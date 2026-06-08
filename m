Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD131CD8CA4
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 19:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D98684843;
	Mon,  8 Jun 2026 21:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TZwMy/z5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F36F84825; Mon,  8 Jun 2026 21:04:53 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B9784843
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 21:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-486118ecd5dso2866381b6e.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780945490; x=1781550290; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CCJDny7y6YkH0vQUfS6QL/HngmzsiMpqHzUBb6s4xUw=;
 b=TZwMy/z5Sk3qM2zpA1hqct7V7+VEyYOL/iNMRuxGy3fuAQ6p3Ay8VPlyt4NGf1DiAn
 WMUCsaACDwHXyiANJL2YYbbWBJS4pC1ftc4p4PQMxXqGG0bTaeKYVfxYPJQysV9a2mUj
 2VrFFQTz3++tfTaEKmH04R/jCW9rMbOUspeoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945490; x=1781550290;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCJDny7y6YkH0vQUfS6QL/HngmzsiMpqHzUBb6s4xUw=;
 b=BF77jdYUQwWlj4ju6sL3fCBKXBpv9wHLzHciNV3lvpwShtwyypCBs64EMCp2eoQ7nJ
 n5dUiHWcVsjR8QnkXa7EMiIEzSLkCagZ/RDn+K57Hx9kKB939IA/xbv1wXqC48TwbEjs
 Csd6bWGYfZ6HkK/P/xOYq3x3VvzL34My0kUkCPTHxLlZVURWm1hPT0PaYVpFLjXUKACy
 3O0Rz0s5rpNAsnLf9AhW/2kH6cTpCYva+/napryFrHIurmH1H53396m0wxA8Kz38gFMZ
 ZI6LC2pIShruO5aFXiYeCn19zNQ9eAbIqazDigSDJEdCj/IJP1gznLpodGyEiBeCLYZw
 /sFw==
X-Gm-Message-State: AOJu0Yw+jtc19803Jnaci6pjynWS0rzXPsUfMqOZqC3/24NEWaZBGV/S
 fUq2NfFHWdNaZlR0adBnRkzkyBbMXiYtAycYQGM62xRBS0PB+DHhd8Zsu9WrDfqWEew=
X-Gm-Gg: Acq92OEyLnwGU1D5ai3uIkKtjDd+/POcgtwJtSnmEMCDAMW3vA39g/ajv6cWQDZkIwN
 P9C3EA5/2ZSck38Hmi5s6daDoF1czmfdVpgNbQrfZpxP+Ldss0ejHe40LY3i5Ne5AhB1tFvoC+x
 BO2XWuXG/LQVDhJK+ZuJBdGl4SUMrYbOCOL8t8WtWSAzr+2r44+BS1Hg3PPgH4WvpORr+A+Ergk
 SUcf+D+vQc1eDJax8934wbo4WJ8OimJhdx4iMLntxvUt4RzEwJas5qNk8R8rZFJLLJmGgcGfoId
 YjquwdbEJvWvi2wCeLh2MRAw+QqCo52tqyArTNdGax5ZqGrVNymGSJxzPCgLfJT5OfULQm0cHyx
 48vGYEYHfZPosVulBAFPiMr+f7m+vK+bSOCDE368DFeOdORRsUSE40IbQ1SnZzbR8kY9q0sNJQj
 ydJXLAoSEpUIDctXUe4Fho603XWZpgq1ty1VzyckUVWdDZ5KEQEqPlfTGc+YoHWblGvsKzgjFZZ
 w3YUmIBsbu37rBSMPPtjbsUBA3sDBtKsF/3HeGinWKjthDO9MBKlqUURy16uw==
X-Received: by 2002:a05:6808:1991:b0:479:d57b:838a with SMTP id
 5614622812f47-4868defdb13mr9766048b6e.35.1780945489567; 
 Mon, 08 Jun 2026 12:04:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b91f944sm14337792b6e.9.2026.06.08.12.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:04:48 -0700 (PDT)
Date: Mon, 8 Jun 2026 13:04:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>
Subject: Re: [PATCH v3 3/5] ufs: extending ufs cmd line
Message-ID: <20260608190446.GO382693@bill-the-cat>
References: <20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com>
 <20260608-ufs_tool2-v3-3-a9f181e86229@mobileye.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jbam18nqzAYASQkL"
Content-Disposition: inline
In-Reply-To: <20260608-ufs_tool2-v3-3-a9f181e86229@mobileye.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Jbam18nqzAYASQkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 01:33:27PM +0300, Raz Ben Yehuda wrote:

> The UFS tool provides utilities for querying, displaying, and modifying
> UFS device configuration and descriptor information.

This still reads like you're adding a new command, which you aren't
anymore. Please reword all of this to make sense again given that it's
now part of the existing ufs command.

[snip]
> diff --git a/cmd/ufs.c b/cmd/ufs.c
> index 790dab50f18..203a58d6026 100644
> --- a/cmd/ufs.c
> +++ b/cmd/ufs.c
> @@ -3,12 +3,1191 @@
>   * ufs.c - UFS specific U-Boot commands
>   *
>   * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
> - *
> + * Copyright (C) 2026 Mobileye Incorporated - https://www.mobileye.com
>   */
> +#include <asm/io.h>
> +#include <dm/devres.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <linux/bitops.h>
> +#include <linux/byteorder/little_endian.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <malloc.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +#include <dm/uclass.h>
> +#include <dm/device.h>
>  #include <command.h>
> +
>  #include <ufs.h>
> -#include <vsprintf.h>
> -#include <linux/string.h>

Please audit this new big list of includes to make sure you're only
adding what's required.

[snip]
> +int ufshcd_query_desc_idn_power(struct ufs_hba *hba, int lun,
> +				struct ufs_power_parameters_descriptor
> +				*out_desc)
> +{
> +	unsigned char Space[QUERY_DESC_POWER_DEF_SIZE];

That's not a good variable name, and do we need to allocate this on the
stack like that?

> +#define CMD_HELP \
> +		"query:\n" \
> +		"\tDevice desc (0h)\n" \
> +		"\tGeometry desc(7h)\n" \
> +		"\tPower desc (8h)\n" \
> +		"\tUnit desc(2h)\n" \
> +		"\tConfig desc(1h)\n" \
> +		"****************************\n" \
> +		"\n\tset_lun [LUN] (parm)\n" \
> +		"\t\tlu_enable\n" \
> +		"\t\tboot_lun_id\n" \
> +		"\t\tlu_write_protect\n" \
> +		"\t\tmemory_type\n" \
> +		"\t\tdata_reliability\n" \
> +		"\t\tnum_allocunits\n" \
> +		"\t\tlogical_block_size\n" \
> +		"\t\tprovisioning_type\n" \
> +		"\t\tcontext_capabilities\n" \
> +		"\t\tlu_num_write_booster_buffer_allocunits\n\n" \
> +		"****************************\n" \
> +		"\n\tset_cfg_desc [parm] [value]\n" \
> +		"\t\tlength\n" \
> +		"\t\tdescriptor_idn\n" \
> +		"\t\tconf_desc_continue\n" \
> +		"\t\tboot_enable\n" \
> +		"\t\tdescr_access_en\n" \
> +		"\t\tinitpower_mode\n" \
> +		"\t\thigh_priority_lun\n" \
> +		"\t\tsecure_removal_type\n" \
> +		"\t\tinit_active_icc_level\n" \
> +		"\t\tperiodic_rtc_update\n" \
> +		"\t\treserved_HPB\n" \
> +		"\t\trpmb_region_enable\n" \
> +		"\t\trpmb_region1_size\n" \
> +		"\t\trpmb_region2_size\n" \
> +		"\t\trpmb_region3_size\n" \
> +		"\t\twrite_booster_buffer_preserve_user_space_en\n" \
> +		"\t\twrite_booster_buffer_type\n" \
> +		"\t\tnum_shared_write_booster_buffer_allocunits\n" \
> +		"****************************\n" \
> +		"\n\tgetflag [flag name]\n" \
> +		"\t\tdeviceinit\n" \
> +		"\t\tpermanent_wpe\n" \
> +		"\t\tpwr_on_wpe\n" \
> +		"\t\tbkops_en\n" \
> +		"\t\tlife_span_mode\n" \
> +		"\t\tpurge_enable\n" \
> +		"\t\tfphy_resource_removal\n" \
> +		"\t\tbusy_rtc\n" \
> +		"\t\tpermanently_disable_fw_update\n" \
> +		"\t\twrite_booster_en\n" \
> +		"\t\twb_buf_flush_en\n" \
> +		"\t\twb_buf_flush_h8\n" \
> +		"****************************\n" \
> +		"\texamples :\n" \
> +		"\n\nto write lun please\n" \
> +		"\tufs query 0 1\n" \
> +		"\tfix the luns, disable lu_enable\n" \
> +		"\tuse ufs set_lun [LUN] num_allocunits=3Dxxx to set size\n" \
> +		"\tufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000\=
n" \
> +		"\tufs set_cfg_desc write_booster_buffer_type 1\n" \
> +		"\tufs commit\n"
> +
> +void ufs_tool_help(void)
> +{
> +	puts(CMD_HELP);
> +}

Please integrate this, properly, to the existing command. It seems like
you just copy/pasted the previous ufs_tool.c file in to cmd/ufs.c
instead.

[snip]
> diff --git a/include/ufs.h b/include/ufs.h
> index f6e27d90e43..89fde263fcf 100644
> --- a/include/ufs.h
> +++ b/include/ufs.h
[snip]
> +int ufshcd_query_desc_idn_geometry(struct ufs_hba *hba,
> +				   struct ufs_geometry_descriptor *decs);
> +int ufshcd_query_desc_idn_config(struct ufs_hba *hba, struct ufs_config_=
descriptor *cfg);
> +int ufshcd_query_desc_idn_device(struct ufs_hba *hba, struct ufs_device_=
descriptor *desc);
> +int ufshcd_query_desc_idn_unit(struct ufs_hba *hba, int lun,
> +			       struct unit_descriptor *desc);
> +void ufshcd_print_idn_geometry_desc(struct ufs_geometry_descriptor *desc=
);
> +void ufshcd_print_device_descriptor(struct ufs_device_descriptor *desc);
> +void ufshcd_print_unit_descriptor(struct unit_descriptor *desc);
> +int ufshcd_query_desc_idn_power(struct ufs_hba *hba, int lun,
> +				struct ufs_power_parameters_descriptor *desc);
> +void print_ufs_power_parameters(struct ufs_power_parameters_descriptor *=
desc);
> +int ufshcd_query_user_flag(struct ufs_hba *hba, const char *flag_name);

These all need appropriate kernel-doc comments.

--=20
Tom

--Jbam18nqzAYASQkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaicSTgAKCRAr4qD1Cr/k
CgOwAP0bJCZQe7YKFgj0APHEVkkc7EgfsvouY64GGYNtVM1gTAD8DoYAnaVJ0zHZ
zaPbkPcJZ1vb2rehmFxEIUcRrOWiEAo=
=6Q30
-----END PGP SIGNATURE-----

--Jbam18nqzAYASQkL--
