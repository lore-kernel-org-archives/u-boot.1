Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384A4C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 16:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A10A0806D8;
	Thu, 27 Mar 2025 17:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SQ+dDQN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4787E8070C; Thu, 27 Mar 2025 17:28:25 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F79D805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 17:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso13191425e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743092902; x=1743697702; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ea4k6Ydw38CIvo1ItjzoMFp5RYHiwRDRIb55Ltz4Z8A=;
 b=SQ+dDQN1cgtKDNK7KE28zaMXMFDAusfoB+WEXPcYkt+AA7uEbxoj6mh9Nd7IFP8UNp
 tkfVaFhr4r+8QTBmgcmnFdYt8kaENDwazOLl/7T9GI5JJ+onYGY1HsdXo+t9t7TocDeC
 s+Il2fmlbABuQ433JDLOGm2qekR+L135zAV3H8/+qJckOlP9S/ipAUvAO+JnGhYuJftU
 qZCeMx0zatb8AfaDuycPiuVZoprDMtj8YjR/uHC8j39lwyG2wHD39sD17uHwX+YjmOAw
 EzxtMbPkDy/+axPp+QQ+REjRcKnG2HIpUKdA2UMG4cVZ2Mihi/ahtB9ZWm5UDpnKpXWA
 iaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743092902; x=1743697702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ea4k6Ydw38CIvo1ItjzoMFp5RYHiwRDRIb55Ltz4Z8A=;
 b=F4BJ1bS1sheBsAOydgeEgjRGSeihPU37kuixiNIRCMw/zD+xEYdrFbrq9LDOJfPTjI
 maWuX5HkfWbUm+1HwML+kKEXkUZZlq3eoCWFrU9QNLdRls6DWDdjC911qqucmOO67/7x
 7lkwEBpFsRHq/UQaLBkMSkypFzAoplmJMtY0bs7n4XJayYDtIuDnWGBWLk6rwCsDkjL9
 xQLMw5YBXg7zUW3ECgQKfKlvVbp/Mt2AoRZaujD4ng9njpVA9loLa00BC1i+2LUC/OfD
 Fnr2z1OStxwuWsoGWepnRl/thOfTOFT7haC5JCXJii4+9msqamrWZImUMPm4OTG/z8qK
 PsSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0EpUPbisXBBMi83fvVPoBdijxAXc6DFB2MsOi7wWCrp2YPMb0+4YZc19HYMGn/FSKtrhGBxg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6s7L1Jbimq/NcyIIVHCZxBmRUzf1itvfXhTqkDrLqZ+8iltzg
 DtlcOaIDam4rkl2Ju4cpks0/tmx9azdTM4x33J+BhSdbYF6Hq/FF1osMG5lqOwk=
X-Gm-Gg: ASbGncsVsHO5Z9auVtLoMaRTpcJVK4Xwxz0fphB1bCdy/6aw5zIsjgVQ1+zaNfEnZGc
 +boq0XTnFHW58TV0a81lkHPr3fz0d/zVlFQRwczEnmFy6H1UryIpW63naCneU7LXxuw8tn385kL
 WkdB7Fy4miGPri/E80AZLVRoKspxvU78IaR81weFzhPBLhfmLV/diJyvdH8bRBR3ntbcahjZjGK
 bC1rBaGDTR0TUSStMxmtIoLwm4zqFFK8ewGUc2ncuZ+Fv2I4AU8JLNJcTD1MYsZKtG7Ewiw49Fg
 15zvTKkWXKi0FtfVtttybBkBHoGpK166Gjqw1GOUwoJJlh+gB9V6niT7bENIvIb0VDw0j5krS1Y
 =
X-Google-Smtp-Source: AGHT+IEaaBHPVUI/wQ+6FiBIrO0cM/dtEJxrQgiQT6xv87TGP15pA1r65Q0Hl6u7wTrCxn7sfQYkYw==
X-Received: by 2002:a05:600c:4fd4:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-43d8d5b0106mr14254315e9.2.1743092902416; 
 Thu, 27 Mar 2025 09:28:22 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e83477sm44033915e9.16.2025.03.27.09.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:28:21 -0700 (PDT)
Message-ID: <63f9cecc-4889-4fbf-b0ca-9db28c356a6c@linaro.org>
Date: Thu, 27 Mar 2025 17:28:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/29] efi: arm: Don't do the EL2 switch when running
 under EFI
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Janne Grunau <j@jannau.net>,
 Tom Rini <trini@konsulko.com>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-15-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2/15/25 04:22, Simon Glass wrote:
> The previous bootloader has likely done this already, so avoid trying to
> do it again. This fixes a crash in QEMU when booting from EDK2
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

ll_boot_init is a pretty unintuitive name tbh. skip_lowlevel_init() 
might be clearer?

off-topic, but how is EBS called?

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
> (no changes since v1)
> 
>   arch/arm/lib/bootm.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> index 974cbfe8400..688c2f3f29b 100644
> --- a/arch/arm/lib/bootm.c
> +++ b/arch/arm/lib/bootm.c
> @@ -16,6 +16,7 @@
>   #include <command.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> +#include <init.h>
>   #include <log.h>
>   #include <asm/global_data.h>
>   #include <dm/root.h>
> @@ -186,8 +187,10 @@ __weak void setup_board_tags(struct tag **in_params) {}
>   #ifdef CONFIG_ARM64
>   static void do_nonsec_virt_switch(void)
>   {
> -	smp_kick_all_cpus();
> -	dcache_disable();	/* flush cache before swtiching to EL2 */
> +	if (ll_boot_init()) {
> +		smp_kick_all_cpus();
> +		dcache_disable();	/* flush cache before swtiching to EL2 */
> +	}
>   }
>   #endif
>   

-- 
Caleb (they/them)

