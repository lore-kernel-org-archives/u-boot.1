Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C936F43832
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA74E83B99;
	Wed, 15 Apr 2026 17:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LylJ+HJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3185583C2B; Wed, 15 Apr 2026 17:02:34 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 741A983936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso4937857fac.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776265350; x=1776870150;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/53wSaihosguF9AAfotOTHKNy4GtHUoS70Dx5HEDlWU=;
 b=LylJ+HJ9oZL1K77hdgukpbi4XVbB3Z1DL9j/Q65qf594X+wA0AnuNmlHz490ZiIysv
 u1CwHuUgaQosGMG9IznFA8zIQRg+vh1m0L8oXjIBfkEGHy91uNTEw3rkCPUH/zyYlkY0
 3EIMbxPrNmrj65yZ5Y1G5HI3TEKce3KNZieazkaG2ROmHPCM0JagVCVc7TKeUmsaQPZt
 4CkFnfv1MJZMwxofIWPqsaHfDFs2jDSaSH84gMDXLiXm2bGz22j092c6hWB8LQlQcS3P
 9MOWlY+KX/lsMDYPhqF2HrFrNDDcmHcnJUK+Y+jqQjgBrV/bMYHbi38TYdjXKdF6erun
 5Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776265350; x=1776870150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/53wSaihosguF9AAfotOTHKNy4GtHUoS70Dx5HEDlWU=;
 b=PQJEs//zXAqVLS3ViVpPh/ysiq8s9Z4keprlPiNwoMcXs7iGnNLITE4jPPf/liXiLu
 L5xld7UcFJIjyQ8fmLUqyUoJdv2RMVE10nJt7fZb2qSyK8HTUDEuPGJV/q70dveznHGc
 usQsf7cOXOwl80aDUh5JrQ99A1Law6rty4PD5nYTe2jztd2yhj6b61m/w4EwktO4TjAX
 0Xg1eMxUfa6kLa6mKAnvIHgs6zl7xTfDPXyMPbXDOaNvsXT7B8R10W6TtmSgc7zhKkuw
 ctTYtXZQ3oB0DzwHPr7Hemt6+LSaVlkDfNYn3ft9/S7H73hWlGhqjQD8EmltN/R5neM6
 yZXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90TXrIKryKtKCpbmH50KPj/oZ+v5jQtDqkLfu0lDsT1G3ayDMVSNz6y3UbLliu6uGWlOqsN4M=@lists.denx.de
X-Gm-Message-State: AOJu0YxNOEzmX7sOFmMLn4ILuOBE+IbGYglctVy3O4APu+BPKFkr2vDQ
 qojOuD8n40dm1Gssb7ig/70NNMPRJGQF5SEWCFyNag++YLo70dk99OK+4+gDcA7xKrMzbQkmMtO
 InXZE
X-Gm-Gg: AeBDietFgrWpBhl9WmOGEk8RhJQvVxS+JC6AyNptUBArSa6GIBDYNN+C9UArRx+b7jc
 VTP9iv1B7Y4BTHp9Ck4TS7UVVKGOUyjxjaOF7i2f8rTfJG4k4RmGPaUDCUQRhbsTtDZfZ4YyOuE
 8yTJL/0wvynORS5DaX+8onOr0f8lQlMEpn1CldiiCHtw+TH9fy+rNQovrgCbI6Lu7oha6hUSIBv
 hBLAbT59yL8G4SDnBr1Pa/5p8lOaPVy3vqDwPJtUevuUCORfoqh/GCFkbw045avaThHKyWlFWzv
 +xTDXoo2KN5WsBuOkT4Oau3fLrnv8ID23sYPwYKArcTwo3gwBZmzdOJfDkIadR+fFZJ5HY+Iz/3
 JRfZs2HyTWXyh8pA2jGdwem4cjW/38OjQe+uCmvZk5PKsA+6+27EIh1/sBW3XljGkF09Cp/ah0t
 rqTOmlH0MxGxeyIZ3nOjp90PkaqopuRBP8r+f3qHfGt65zmzybf28iiHEhL21MDwReAPfF8NbNb
 wdEtw628kwL
X-Received: by 2002:a05:6870:7d89:b0:40a:4467:d5 with SMTP id
 586e51a60fabf-423e0eacef0mr13036043fac.14.1776265349946; 
 Wed, 15 Apr 2026 08:02:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5ab6:1e6d:2337:887c?
 ([2600:8803:e7e4:500:5ab6:1e6d:2337:887c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4264469bafbsm1660312fac.0.2026.04.15.08.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 08:02:29 -0700 (PDT)
Message-ID: <d23fec41-0eeb-489f-8c1e-5bb4b974139b@baylibre.com>
Date: Wed, 15 Apr 2026 10:02:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mediatek: enable fw loader support
To: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>
References: <20260410015311.4066075-1-weijie.gao@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260410015311.4066075-1-weijie.gao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/9/26 8:53 PM, Weijie Gao wrote:
> Enable SUPPORTS_FW_LOADER to allow the mediatek platform to use ethernet PHY
> drivers with fw loading.
> 
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 03416c55265..aee8e74dace 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -868,6 +868,7 @@ config ARCH_MEDIATEK
>  	select SPL_LIBGENERIC_SUPPORT if SPL
>  	select SPL_OF_CONTROL if SPL
>  	select SUPPORT_SPL
> +	select SUPPORTS_FW_LOADER

I don't think this is how this config option is meant to be used.

Based on [1], it sounds like we just need to make sure CMDLINE and
ENV_SUPPORT are enabled in any config that also enables PHY_MEDIATEK_2P5GE.

I don't see any defconfig that enables PHY_MEDIATEK_2P5GE though, so
I'm not sure there is anything to do here. Unless it makes sense to
enable this in one of the existing defconfigs or add a new defconfig?

[1]: https://lore.kernel.org/u-boot/20260310162610.1163833-1-trini@konsulko.com/

>  	help
>  	  Support for the MediaTek SoCs family developed by MediaTek Inc.
>  	  Please refer to doc/README.mediatek for more information.

