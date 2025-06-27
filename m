Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781CCC7EE3A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 10:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE8E482EC6;
	Fri, 27 Jun 2025 12:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E6Dse9//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BAE182E9A; Fri, 27 Jun 2025 12:00:34 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC7D82E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 12:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55RA0SYC2385089;
 Fri, 27 Jun 2025 05:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751018428;
 bh=ap6km2sK3NGS0KsH+YeBf8cpOGnrKjssi9kXUA0ECmY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=E6Dse9//uKaOAqVyV/YsWd8SDECx3l6p50Z02TruPZAoLYWy1BJ/2TyqOo2fNioX4
 fo8r9Op5RJrDW7oB9EJQRdOalah6+8Ua7/5/x+QvWMttHIUlMKJjWO7U+y4NlqmtTE
 TnVh2U68yRrur1kCZm2fQjdfr6kLATd+V+jwbwrc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55RA0SLi286448
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 27 Jun 2025 05:00:28 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 27
 Jun 2025 05:00:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 27 Jun 2025 05:00:27 -0500
Received: from [10.24.72.128] (psdkl-workstation0.dhcp.ti.com [10.24.72.128])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 55RA0Oqj2884588; Fri, 27 Jun 2025 05:00:25 -0500
Message-ID: <814d8034-e81d-475b-acfc-ad31a50c75d2@ti.com>
Date: Fri, 27 Jun 2025 15:30:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: Fix of_list_dirs with EXT_DTB
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
References: <20250626-b4-upstream-fix-icssg-fit-v1-1-95eff1c853a4@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20250626-b4-upstream-fix-icssg-fit-v1-1-95eff1c853a4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Manorit,


On 26/06/25 16:13, Manorit Chawdhry wrote:
> EXT_DTB overrides the of_list_dirs that is passed to binman during
> builds. This causes binman to not find the normal DTB paths and instead
> it just is able to use the path for EXT_DTB only.
> 
> Add the default of_list_dirs that is used for normal binman builds to
> EXT_DTB usecase as well.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

> ---
>   Makefile | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index e60bbb01a004c7801034a10e7f3fdd04f92f700d..f2a6fbad6d32c3b68292ff19bda4f4fdb686de63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1392,17 +1392,17 @@ ifneq ($(EXT_DTB),)
>   ext_dtb_list := $(basename $(notdir $(EXT_DTB)))
>   default_dt := $(firstword $(ext_dtb_list))
>   of_list := "$(ext_dtb_list)"
> -of_list_dirs := $(dir $(EXT_DTB))
> +of_list_dirs := $(dir $(EXT_DTB)) $(dt_dir)
>   else
>   of_list := $(CONFIG_OF_LIST)
> -ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
> -of_list_dirs := $(dt_dir) arch/$(ARCH)/dts
> -else
>   of_list_dirs := $(dt_dir)
> -endif
>   default_dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(CONFIG_DEFAULT_DEVICE_TREE))
>   endif
>   
> +ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
> +of_list_dirs += arch/$(ARCH)/dts
> +endif
> +
>   binman_dtb := $(shell echo $(CONFIG_BINMAN_DTB))
>   ifeq ($(strip $(binman_dtb)),)
>   ifeq ($(CONFIG_OF_EMBED),y)
> 
> ---
> base-commit: 40e083353a1610276f12fdbe613bf12004452656
> change-id: 20250626-b4-upstream-fix-icssg-fit-b6a42952daea
> 
> Best regards,
