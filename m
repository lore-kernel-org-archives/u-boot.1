Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D8C1073CA6
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E3A84106;
	Wed,  8 Apr 2026 14:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ewGHNYb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A80583693; Wed,  8 Apr 2026 10:52:25 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F85D80433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 10:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso46383635e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775638341; x=1776243141; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/gm93EP7Cv9hweVQV0IKFkipUq0u4r4/szx404YP+o0=;
 b=ewGHNYb4tKrdaiNbK+WRUPbSIWXebgh/uwuUSx5SJG+10efGZaGKPMcO74479lcoWE
 W0IoTVPVdxgkxfAoL0uPEkbM9yGAqp/DifUXHo/ofxMNwdK0m0LXV8509Wey/K7z0G9h
 iIb9X9DKIEDj1PnCrlB3tvmcZGgQqjFGxeRKh+3hPCCLuDOI7PP4R5F6wfynVtNGaoN3
 iaozYBBiL4S+HBEeBp/3X9YMOshLoTSlIf2VrtCc0uW3Qbf909+eftXyeqqXt1jFgVUE
 1KQWyBjVaMu6T0GPvi+pZTvtqYvlMr/VM82vCmQ9W8viDXF782R7+VhtYgScKIzkvuT2
 TsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775638341; x=1776243141;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/gm93EP7Cv9hweVQV0IKFkipUq0u4r4/szx404YP+o0=;
 b=mfMn24QDZbMwiT7l6rqZreou9WhX8XCteW13cmNf529yV4UQDWn3QZ0aZ4Md0WCBjh
 ZiDx570pY9vOUH0shXa+hgnHfdZbyHDUxa87PjzEWPCDKyAJJrxiDfKotCEYJ2L3RDHx
 ChX+RoEggl6Cj3wk8U/Gh7oXBYFF6rERxMW009cdDd+61HUzpL3QqaIFCVEUyx88O+1B
 robISIxA4PDTj7aJL3oSFKAdj0JsCBhi1+wYVNX/SMQkD4DAHrKfvQ5YXWXMAtEKZ+lG
 Zj52H5pLKpvv/CZrmVWklX8yrUTVieNbz4DXUtrvumL4mWGKQzEHzE4Bh47ohVJaUw1A
 9G6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCVtT1/tXUpqIPgnPA3lmXyn3P5ivmlPb/DdLopQca5/WdUm+XEGszHCsF3ZfsKo20YCrBWcc=@lists.denx.de
X-Gm-Message-State: AOJu0YxaH360KfVbn97CW62HxBASixbUYKsMfyL/5GHq8ysafbMilRpM
 fmxDLu5wNwKaogsJreFcDTZtKWzwZRH70sTOhkzqbaGAgweJe0bnvivmMsIAJlVq0l4=
X-Gm-Gg: AeBDievhqk0Dn/qVlz40xhZwiNN5JJUhaGuWzmgE0OmWl+fxWbxXnDWAeNZuhCMvqhG
 BaaE4YzwQTlhgXxxroX+MNh33Q9RLD63TMoaaBYq7IuOon5kiOSIMGs8trmcyEenktM06Qqf1Mk
 j0+0pB7s2761l6I/WGHUBULcCJxFx1PwNtilbwAoaGaI0iMS5rP8or/OoOpeP7ui5bR5lbC/jM2
 4bItBwzvEA3LgJW9utRUNABTR5Id3Qw+nIwvQD0aeGuMT8ivMSusOcA67HDvRM4yTxz9vQsHLal
 EPZboqGMuTJpJHO2HLJmbQE5TvOV7Sea7VsiUBxigctCMPFSvGdd6OvGKUKEJd0fbu/ragAxR4k
 8wZLsAre8SvHEVzxIABWniu5AIndnY4EKrYjrBpz6jH1NS5ViLnbR4Yp+AuGsTkd34XOL2UdfFZ
 9dW9jQ4NP4Ibf+yH7zEs3MjryQkbIR4dtywn12kIUqc6TyMvZSujp6jc52wgsEZsiL6w==
X-Received: by 2002:a05:600c:c8d:b0:486:ffa3:594 with SMTP id
 5b1f17b1804b1-488997a6883mr272185555e9.23.1775638340910; 
 Wed, 08 Apr 2026 01:52:20 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488b6ff70bcsm332135715e9.14.2026.04.08.01.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:52:20 -0700 (PDT)
Message-ID: <725d22b0-e48f-4444-9c8c-b38004fff2fc@linaro.org>
Date: Wed, 8 Apr 2026 10:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mach-snapdragon: support building SPL
To: michael.srba@seznam.cz, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-4-9e6c2ac66587@seznam.cz>
From: Casey Connolly <casey.connolly@linaro.org>
Content-Language: en-US
In-Reply-To: <20260404-qcom_spl-v1-4-9e6c2ac66587@seznam.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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

Hi Michael,

On 04/04/2026 01:18, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> Initially sdm845 support is added, and only usb boot
> is supported for the next stage.
> 

[snip]

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..0f980a954e4 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -33,6 +33,8 @@
>  #include <sort.h>
>  #include <time.h>
>  
> +#include <spl.h>

I think it would be preferable to split out the SPL specific parts,
particularly since a lot of the functions here won't be called in SPL,
and even if they are the context is quite different. Like if
board_fdt_blob_setup() is called in SPL I would still suggest having a
separate version of it since the logic surely would be different.

Could you put any common code you do need in SPL into common.c and add a
new spl.c with the spl-specific parts?

> +
>  #include "qcom-priv.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -223,6 +225,7 @@ int board_fdt_blob_setup(void **fdtp)
>  		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%#llx)\n",
>  		      (phys_addr_t)external_fdt);
>  
> +#if !defined(CONFIG_SPL_BUILD)
>  	/* Prefer memory information from internal DT if it's present */
>  	if (internal_valid)
>  		ret = qcom_parse_memory(internal_fdt);
> @@ -239,6 +242,7 @@ int board_fdt_blob_setup(void **fdtp)
>  
>  	if (ret < 0)
>  		panic("No valid memory ranges found!\n");
> +#endif
>  
>  	/* If we have an external FDT, it can only have come from the Android bootloader. */
>  	if (external_valid)
> @@ -258,7 +262,9 @@ int board_fdt_blob_setup(void **fdtp)
>  		ret = 0;
>  	}
>  
> +#if CONFIG_IS_ENABLED(SYSRESET_PSCI) && !defined(CONFIG_SPL_BUILD)
>  	qcom_psci_fixup(*fdtp);
> +#endif
>  
>  	return ret;
>  }
> @@ -313,7 +319,9 @@ void __weak qcom_board_init(void)
>  
>  int board_init(void)
>  {
> +#if CONFIG_IS_ENABLED(SYSRESET_PSCI) && !defined(CONFIG_SPL_BUILD)
>  	show_psci_version();
> +#endif
>  	qcom_board_init();
>  	return 0;
>  }
> @@ -749,3 +757,21 @@ void enable_caches(void)
>  	}
>  	dcache_enable();
>  }
> +
> +/* for SPL */
> +
> +__weak void reset_cpu(void)
> +{
> +	/* TODO */

Could you puts() something here to indicate that the board will hang?

Thanks,

-- 
// Casey (she/her)

