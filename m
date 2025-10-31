Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A439BCCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3633B8399B;
	Fri, 31 Oct 2025 16:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o10xWY4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D716F839B1; Fri, 31 Oct 2025 16:58:24 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD3C83A07
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A2E9260241;
 Fri, 31 Oct 2025 15:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E865C4CEE7;
 Fri, 31 Oct 2025 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761926301;
 bh=HYw5ynD8QjuVP+FHmu/u24rwL+y8JkLatZpfWFhxtFY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=o10xWY4EdUjJeV73Hw+D4XRMjQWAZAeQnRIbau1OvsuPnLgVwzeDkJtOURiaYQrd6
 WzR9E1TUSWkB3EY96Y/Vzd9oAwsv07VdXcshR5Oq4IT7YfBw/L1qM4QDqCke8I3Mjz
 SMav8jpZ/bnYwqOOOwOrljus2mbheFcNn6waYrCEvGmCabdKjxY4C9yoIEdwOVqREi
 UWXmf2UBcQZQXqemGpExVy5nGOKgF/kDQ5bFl9RztEgb17wa7ACvvTbyqidIor9WoA
 ni/HPSQclgRO5HrJoZvBjvv7ElGxhW/Uf4J0TRRH2v5DAiTYhreWLyRlaZIw45JdSK
 CO8LJXHx+sYnA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
Subject: Re: [PATCH v2 3/5] boot: android: Add bootconfig support
In-Reply-To: <20251017-bootconfig-v2-3-8c7c2f2e5474@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-3-8c7c2f2e5474@baylibre.com>
Date: Fri, 31 Oct 2025 16:58:16 +0100
Message-ID: <87cy635ahz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Guillaume,

Thank you for the patch.

On Fri, Oct 17, 2025 at 15:19, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:

> For android vendor boot image version 4 bootconfig is mandatory.[1]

There seems to be a link "[1]" here but it's not part of the commit
message.
Can you add it please?

>
> In the android_image_get_ramdisk function, after copying both vendor and
> boot ramdisks, we extract all androidboot.* entries from the kernel
> command line. These entries are added to the bootconfig section.
> We then update the sizes of the ramdisk and bootconfig.
> Finally, all androidboot.* entries are removed from the kernel command
> line.
>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
>  boot/image-android.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 93 insertions(+), 8 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 613f2aa4b9e..cf038a4a62f 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -534,17 +534,102 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  			ramdisk_ptr = img_data.ramdisk_addr;
>  		}
>  		*rd_data = ramdisk_ptr;
> -		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
> +
> +		/* Extract androidboot.* parameters from bootargs */
> +		const char *bootargs = env_get("bootargs");
> +		char *androidboot_params = NULL;
> +		char *new_bootargs = NULL;
> +		size_t androidboot_params_len = 0;
> +
> +		if (bootargs && img_data.bootconfig_size) {
> +			size_t len = strlen(bootargs);
> +
> +			androidboot_params = malloc(len + 1);
> +			new_bootargs = malloc(len + 1);
> +			if (!androidboot_params || !new_bootargs) {
> +				free(androidboot_params);
> +				free(new_bootargs);
> +				printf("Error: malloc failed\n");
> +				return -ENOMEM;
> +			}
> +
> +			/* Extract androidboot.* and build new bootargs in one pass */
> +			const char *src = bootargs;
> +			char *bc_dst = androidboot_params;
> +			char *args_dst = new_bootargs;
> +
> +			while (*src) {
> +				/* Skip leading spaces */
> +				while (*src == ' ')
> +					src++;
> +				if (!*src)
> +					break;
> +
> +				/* Check if this param starts with androidboot. */
> +				if (strncmp(src, "androidboot.", 12) == 0) {
> +					/* Copy to bootconfig (add newline if not first) */
> +					if (bc_dst != androidboot_params)
> +						*bc_dst++ = '\n';
> +					while (*src && *src != ' ')
> +						*bc_dst++ = *src++;
> +				} else {
> +					/* Copy to new bootargs (add space if not first) */
> +					if (args_dst != new_bootargs)
> +						*args_dst++ = ' ';
> +					while (*src && *src != ' ')
> +						*args_dst++ = *src++;
> +				}
> +			}
> +
> +			*bc_dst++ = '\n';  /* Final newline for bootconfig */
> +			*bc_dst = '\0';
> +			*args_dst = '\0';
> +			androidboot_params_len = bc_dst - androidboot_params;
> +
> +			/* Update bootargs if we extracted any androidboot params */
> +			if (androidboot_params_len > 1)
> +				env_set("bootargs", new_bootargs);
> +		}
> +
> +		/* Map addresses for memcpy operations */
> +		void *ramdisk_dest = map_sysmem(ramdisk_ptr, img_data.ramdisk_size);
> +		void *vendor_ramdisk_src = map_sysmem(img_data.vendor_ramdisk_ptr,
> +						      img_data.vendor_ramdisk_size);
> +		void *boot_ramdisk_src = map_sysmem(img_data.ramdisk_ptr,
> +						    img_data.boot_ramdisk_size);
> +
> +		memcpy(ramdisk_dest, vendor_ramdisk_src,
>  		       img_data.vendor_ramdisk_size);
> -		ramdisk_ptr += img_data.vendor_ramdisk_size;
> -		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
> -		       img_data.boot_ramdisk_size);
> -		ramdisk_ptr += img_data.boot_ramdisk_size;
> +		memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size,
> +		       boot_ramdisk_src, img_data.boot_ramdisk_size);
> +
>  		if (img_data.bootconfig_size) {
> -			memcpy((void *)
> -			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
> -			       img_data.bootconfig_size);
> +			void *bootconfig_src = map_sysmem(img_data.bootconfig_addr,
> +							  img_data.bootconfig_size);
> +			memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size +
> +			       img_data.boot_ramdisk_size,
> +			       bootconfig_src, img_data.bootconfig_size);
> +			unmap_sysmem(bootconfig_src);
> +
> +			/* Add androidboot.* parameters to bootconfig */
> +			if (androidboot_params && androidboot_params_len > 1) {
> +				ulong bootconfig_ptr = (ulong)ramdisk_dest +
> +						       img_data.vendor_ramdisk_size +
> +						       img_data.boot_ramdisk_size;
> +				img_data.ramdisk_size +=
> +					add_bootconfig_parameters(androidboot_params,
> +								  androidboot_params_len,
> +								  bootconfig_ptr,
> +								  img_data.bootconfig_size);
> +			}
>  		}
> +
> +		free(androidboot_params);
> +		free(new_bootargs);
> +
> +		unmap_sysmem(boot_ramdisk_src);
> +		unmap_sysmem(vendor_ramdisk_src);
> +		unmap_sysmem(ramdisk_dest);

We are here in the "if (img_data.header_version > 2) {" block.
What about boot image v3? Why are we forcing bootconfig upon them?

Also, please move this to a seperate function. It makes
android_image_get_ramdisk() quite long and difficult to read otherwise.

Finally, what happens if a kernel does not have bootconfig enabled ?
I imagine that everything will crash due to this change. Even if
bootconfig is mandatory for boot image v4, I believe we should make this
behaviour optional to avoid breaking existing kernels.

>  	} else {
>  		/* Ramdisk can be used in-place, use current ptr */
>  		if (img_data.ramdisk_addr == 0 ||
>
> -- 
> 2.34.1
