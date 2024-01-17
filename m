Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16569C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 15:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C86D8798F;
	Wed, 17 Jan 2024 16:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YvpcdVPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7EC87B5F; Wed, 17 Jan 2024 16:59:13 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 890C28790F
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HFx84Z057241;
 Wed, 17 Jan 2024 09:59:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705507148;
 bh=6kYxPbe1Sfq1hGC2j0CVDtwY4W4HSqFY9uyw2kut3Jo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YvpcdVPPrX+uKklgFBGFAed+eibhgoSZlC+cF9Y8rD+7mcMttUNnDRq4iDeLeThpJ
 xePqu+HrkepiztMEizE8OIXbvz7sENEcLwDqwxZVvLukvwAtqewVaGpaZPX2zxeICG
 vPGSL9leFT38aFyOtCGPjQohy5YCWLMsrplQiEK8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HFx8Fp009914
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Jan 2024 09:59:08 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 09:59:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 09:59:07 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HFx77p090745;
 Wed, 17 Jan 2024 09:59:07 -0600
Message-ID: <1915a58b-b0f1-4cf9-9ceb-7ca5f4cee5c1@ti.com>
Date: Wed, 17 Jan 2024 09:59:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Kconfig: Add support for FIT image signature enforcing
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240111-b4-upstream-fit-signature-enforce-v1-1-2b91be31866e@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240111-b4-upstream-fit-signature-enforce-v1-1-2b91be31866e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 1/11/24 4:34 AM, Manorit Chawdhry wrote:
> FIT_SIGNATURE doesn't enforce the U-boot setup to be correct for booting
> the FIT images, the DTB might not have all the proper nodes and it just
> boots up without any warning. This makes it difficult to get the correct
> setup working.
> 
> Adds an enforcement flag that doesn't allow the setup to have problems
> and enforces the environment to only pick the signature node from DTB
> and don't rely on anything else.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> A very crude implementation of [0], not exactly sure if the Kconfig
> should just protect the getting key part of if we can make it more
> generic and handle this as some lockdown where we can disable boot for
> any other method and just allow FIT Images to bootup.
> 

Disabling other boot modes could be a different Kconfig, then we would
have a generic "lockdown/secure" Kconfig that goes and selects the
various smaller Kconfigs (like this one) that together would prevent
bypassing security checks.

> [0]: https://lore.kernel.org/u-boot/CAPnjgZ3B9hWTNAMr2QjSN8P1AsOme4XfSAYUKSg=tRRiJ9drTg@mail.gmail.com/
> ---
>   boot/Kconfig         | 11 +++++++++++
>   boot/image-fit-sig.c | 31 +++++++++++++++++++++----------
>   2 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fbc49c5bca47..ed85fd3dc3c5 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -78,6 +78,17 @@ config FIT_SIGNATURE
>   	  format support in this case, enable it using
>   	  CONFIG_LEGACY_IMAGE_FORMAT.
>   
> +config FIT_SIGNATURE_ENFORCE
> +	bool "Enforce the signature in FIT Images"
> +	default y if TI_SECURE_DEVICE
> +	depends on FIT_SIGNATURE
> +	help
> +	  Enabling FIT_SIGNATURE by default doesn't enforce the U-boot DTB to be
> +	  having keys and allows booting the images without having proper setup.

s/be having/have

Andrew

> +	  This option enforces the FIT signature mechanism to contain the keys in
> +	  the DTB and enforce the nodes to be authenticated without relying on
> +	  the "required" node in the DTB.
> +
>   config FIT_SIGNATURE_MAX_SIZE
>   	hex "Max size of signed FIT structures"
>   	depends on FIT_SIGNATURE
> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> index 12369896fe3f..8a324733e7e4 100644
> --- a/boot/image-fit-sig.c
> +++ b/boot/image-fit-sig.c
> @@ -490,15 +490,24 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
>   	/* Work out what we need to verify */
>   	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
>   	if (key_node < 0) {
> -		debug("%s: No signature node found: %s\n", __func__,
> -		      fdt_strerror(key_node));
> -		return 0;
> +		if (IS_ENABLED(CONFIG_FIT_SIGNATURE_ENFORCE)) {
> +			printf("%s: No signature node found: %s\n", __func__,
> +			       fdt_strerror(key_node));
> +			return -EPERM;
> +		} else {
> +			debug("%s: No signature node found: %s\n", __func__,
> +			      fdt_strerror(key_node));
> +			return 0;
> +		}
>   	}
>   
>   	/* Get required-mode policy property from DTB */
> -	reqd_mode = fdt_getprop(key_blob, key_node, "required-mode", NULL);
> -	if (reqd_mode && !strcmp(reqd_mode, "any"))
> -		reqd_policy_all = false;
> +	if (!IS_ENABLED(CONFIG_FIT_SIGNATURE_ENFORCE)) {
> +		reqd_mode =
> +			fdt_getprop(key_blob, key_node, "required-mode", NULL);
> +		if (reqd_mode && !strcmp(reqd_mode, "any"))
> +			reqd_policy_all = false;
> +	}
>   
>   	debug("%s: required-mode policy set to '%s'\n", __func__,
>   	      reqd_policy_all ? "all" : "any");
> @@ -514,10 +523,12 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
>   		const char *required;
>   		int ret;
>   
> -		required = fdt_getprop(key_blob, noffset, FIT_KEY_REQUIRED,
> -				       NULL);
> -		if (!required || strcmp(required, "conf"))
> -			continue;
> +		if (!IS_ENABLED(CONFIG_FIT_SIGNATURE_ENFORCE)) {
> +			required = fdt_getprop(key_blob, noffset,
> +					       FIT_KEY_REQUIRED, NULL);
> +			if (!required || strcmp(required, "conf"))
> +				continue;
> +		}
>   
>   		reqd_sigs++;
>   
> 
> ---
> base-commit: a803f87202aa48974bdff4d8100464a8288931e4
> change-id: 20231107-b4-upstream-fit-signature-enforce-185a0db88b7f
> 
> Best regards,
