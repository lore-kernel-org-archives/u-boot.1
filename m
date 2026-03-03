Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803D8E67A8D
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 08:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9D48063E;
	Tue,  3 Mar 2026 09:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0049838BB; Tue,  3 Mar 2026 09:09:03 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B8280050
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 09:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1vxKoO-0006AT-1E; Tue, 03 Mar 2026 09:09:00 +0100
Message-ID: <1c8f8282-7ec9-440e-bfbe-2494f5ea69c8@pengutronix.de>
Date: Tue, 3 Mar 2026 09:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260302220937.3682128-1-trini@konsulko.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20260302220937.3682128-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 3/2/26 23:09, Tom Rini wrote:
> There is a flaw in how U-Boot verifies and generates signatures for FIT
> images. To prevent mix and match style attacks, it is recommended to
> use signed configurations. How this is supposed to work is documented in
> doc/usage/fit/signature.rst.
> 
> Crucially, the `hashed-nodes` property of the `signature` node contains
> which nodes of the FIT device tree were hashed as part of the signature
> and should be verified. However, this property itself is not part of the
> hash and can therefore be modified by an attacker. Furthermore, the
> signature only contains the name of each node and not the path in the
> device tree to the node.
> 
> This patch reworks the code to address this specific oversight.

Do I understand correctly that this is a breaking change
for FIT with signed configurations?

- New U-Boot hashes more than intended for old FIT
- Old U-Boot hashes less than intended for new FIT

Thanks,
Ahmad

> 
> Thanks to Apple Security Engineering and Architecture (SEAR) for
> reporting this issue and then coming up with a fix.
> 
> Reported-by: Apple Security Engineering and Architecture (SEAR)
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I assume one question will be about adding a test case. I have been
> asked to not share the testcase for a few releases yet, so plan to add
> that later in the year.
> ---
>  boot/image-fit-sig.c | 31 +++++++++++++++++++++++--------
>  include/image.h      | 12 ++++++++++++
>  tools/image-host.c   |  9 +++++++--
>  3 files changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> index f23e9d5d0b0f..dce8bbe30e93 100644
> --- a/boot/image-fit-sig.c
> +++ b/boot/image-fit-sig.c
> @@ -44,12 +44,6 @@ struct image_region *fit_region_make_list(const void *fit,
>  	debug("Hash regions:\n");
>  	debug("%10s %10s\n", "Offset", "Size");
>  
> -	/*
> -	 * Use malloc() except in SPL (to save code size). In SPL the caller
> -	 * must allocate the array.
> -	 */
> -	if (!IS_ENABLED(CONFIG_XPL_BUILD) && !region)
> -		region = calloc(sizeof(*region), count);
>  	if (!region)
>  		return NULL;
>  	for (i = 0; i < count; i++) {
> @@ -62,6 +56,23 @@ struct image_region *fit_region_make_list(const void *fit,
>  	return region;
>  }
>  
> +int fit_region_add_hashed_nodes(struct image_region *region, int count,
> +					const char* hashed_nodes, int hashed_nodes_len)
> +{
> +	/* Add the spacer to ensure the hashed strings and hashed-nodes cannot "overlap". */
> +	const char* HASHED_NODES_SPACER = "hashed-nodes";
> +	region[count].data = HASHED_NODES_SPACER;
> +	region[count].size = strlen(HASHED_NODES_SPACER);
> +	count++;
> +
> +	region[count].data = hashed_nodes;
> +	region[count].size = hashed_nodes_len;
> +	count++;
> +
> +	/* Now add the actual hashed-nodes value. */
> +	return count;
> +}
> +
>  static int fit_image_setup_verify(struct image_sign_info *info,
>  				  const void *fit, int noffset,
>  				  const void *key_blob, int required_keynode,
> @@ -376,10 +387,14 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
>  		count++;
>  	}
>  
> -	/* Allocate the region list on the stack */
> -	struct image_region region[count];
> +	/* Allocate the region list on the stack, +2 for the hashed-nodes */
> +	struct image_region region[count+2];
>  
>  	fit_region_make_list(fit, fdt_regions, count, region);
> +
> +	/* Add the hashed-nodes */
> +	count = fit_region_add_hashed_nodes(region, count, prop, prop_len);
> +
>  	if (info.crypto->verify(&info, region, count, fit_value,
>  				fit_value_len)) {
>  		*err_msgp = "Verification failed";
> diff --git a/include/image.h b/include/image.h
> index 34efac6056dd..5b847527b586 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1771,6 +1771,18 @@ struct image_region *fit_region_make_list(const void *fit,
>  		struct fdt_region *fdt_regions, int count,
>  		struct image_region *region);
>  
> +/**
> + * fit_region_add_hashed_nodes() - Add a list of hashed nodes to the regions
> + *
> + * @region:		List of regions to add to
> + * @count:		Number of existing regions (Note: region needs to have space for an additional two regions)
> + * @hashed_nodes:		List of hashed nodes
> + * @hashed_nodes_len:	Length of list
> + * Return: The updated count value (i.e. count+2).
> + */
> +int fit_region_add_hashed_nodes(struct image_region *region, int count,
> +		const char* hashed_nodes, int hashed_nodes_len);
> +
>  static inline int fit_image_check_target_arch(const void *fdt, int node)
>  {
>  #ifndef USE_HOSTCC
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 48d69191c921..1e7c38a9a211 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -1018,13 +1018,15 @@ static int fit_config_get_regions(const void *fit, int conf_noffset,
>  		return -EINVAL;
>  	}
>  
> -	/* Build our list of data blocks */
> -	region = fit_region_make_list(fit, fdt_regions, count, NULL);
> +	/* Allocate the region array, +2 for the hashed-nodes region. */
> +	region = calloc(count+2, sizeof(*region));
>  	if (!region) {
>  		fprintf(stderr, "Out of memory hashing configuration '%s/%s'\n",
>  			conf_name, sig_name);
>  		return -ENOMEM;
>  	}
> +	/* Build our list of data blocks */
> +	fit_region_make_list(fit, fdt_regions, count, region);
>  
>  	/* Create a list of all hashed properties */
>  	debug("Hash nodes:\n");
> @@ -1043,6 +1045,9 @@ static int fit_config_get_regions(const void *fit, int conf_noffset,
>  		strcpy(region_prop + len, node_inc.strings[i]);
>  	strlist_free(&node_inc);
>  
> +	/* Add the hashed-nodes. */
> +	count = fit_region_add_hashed_nodes(region, count, region_prop, len);
> +
>  	*region_countp = count;
>  	*regionp = region;
>  	*region_propp = region_prop;


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
