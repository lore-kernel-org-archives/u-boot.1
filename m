Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1D6C54FCC
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C3D83D3D;
	Fri, 20 Feb 2026 10:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XbUfIwco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4869F83E13; Fri, 20 Feb 2026 10:02:59 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263FE83D3D
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EA12760054;
 Fri, 20 Feb 2026 09:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00A8C116C6;
 Fri, 20 Feb 2026 09:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771578175;
 bh=id/j9HCr/NRebYD1wgo00AvGd8ieKn9HYGnNIBqxYFM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XbUfIwcouuljAaZrB7JKyXgSWo8+VSym9f5v07fguyBbKzQ8DGKVqxUiZFb5KmeyR
 iafFG2GrUWbmQpMswYQVP0zLAGzDJynBOt+YRws4imHcsTc9ZR63Q5jOIG+siaj4yw
 LmAbqNOXK9/J4KQN66vg2kI38CUD5bg4TgmAcAvRJpySNdSAy1GoBxP5+PcmGEo05l
 +dBxqklim7mPt6uhuSHntbn+3S9sNUuWgUNxA9+XNh3VPXoJEgoC7Iw4ZDvydsiOR3
 UnkjB5Wp6me0N92UcXiY5YcmJP/0z7WCSbB/HGdUJtQ0yY8z4NFjcmh/CIugnBbhiJ
 i1F50IBX5zs4w==
Date: Fri, 20 Feb 2026 14:32:46 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 trini@konsulko.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 neil.armstrong@linaro.org, tien.fong.chee@altera.com,
 miquel.raynal@bootlin.com, msp@baylibre.com,
 alif.zakuan.yuslaimi@altera.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 varadarajan.narayanan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH v8 3/4] mach-snapdragon: Remove RPMH power domain DT
 fixup code
Message-ID: <aZgjNiXk3DxwAzTX@sumit-xelite>
References: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
 <20260213111009.1254360-4-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213111009.1254360-4-aswin.murugan@oss.qualcomm.com>
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

On Fri, Feb 13, 2026 at 04:40:08PM +0530, Aswin Murugan wrote:
> Remove the device tree fixup code that was stripping power-domains
> properties from device tree nodes. This fixup was a temporary
> workaround needed when RPMH power domain driver support was not
> available in U-Boot.
> 
> Now that RPMH power domain driver support has been added, the power
> domain properties can be preserved in the device tree, allowing proper
> power domain management. If a suitable power domain driver is not found
> for the power-controller node, it will be handled with a warning in
> dev_power_domain_ctrl().
> 
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v8:
> - Changed commit message
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> v7:
> - No changes to this patch in v7
> 
> v6:
> - No changes to this patch in v6
> 
> v5:
> - No changes to this patch in v5
> 
> v4:
> - Reverted the inclusion of qcom-rpmpd.h header in pervious versions.
> 
> v3:
> - Removed OF_LIVE_SA8775P config, since there is no SA8775P specific fixups are done
> 
> v2:
> - Removed the power domain fixups, since the power domains are handled in qcom-rpmhpd driver
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 31 -----------------------------
>  1 file changed, 31 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 5b6076ea8e5..286541c8edc 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -134,36 +134,6 @@ static void fixup_usb_nodes(struct device_node *root)
>  	}
>  }
>  
> -/* Remove all references to the rpmhpd device */
> -static void fixup_power_domains(struct device_node *root)
> -{
> -	struct device_node *pd = NULL, *np = NULL;
> -	struct property *prop;
> -	const __be32 *val;
> -
> -	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
> -	for_each_of_allnodes_from(root, pd) {
> -		if (pd->name && !strcmp("power-controller", pd->name))
> -			break;
> -	}
> -
> -	/* Sanity check that this is indeed a power domain controller */
> -	if (!of_find_property(pd, "#power-domain-cells", NULL)) {
> -		log_err("Found power-controller but it doesn't have #power-domain-cells\n");
> -		return;
> -	}
> -
> -	/* Remove all references to the power domain controller */
> -	for_each_of_allnodes_from(root, np) {
> -		if (!(prop = of_find_property(np, "power-domains", NULL)))
> -			continue;
> -
> -		val = prop->value;
> -		if (val[0] == cpu_to_fdt32(pd->phandle))
> -			of_remove_property(np, prop);
> -	}
> -}
> -
>  #define time_call(func, ...) \
>  	do { \
>  		u64 start = timer_get_us(); \
> @@ -176,7 +146,6 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>  	struct device_node *root = event->data.of_live_built.root;
>  
>  	time_call(fixup_usb_nodes, root);
> -	time_call(fixup_power_domains, root);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
