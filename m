Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046ABC25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 15:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A5D188052;
	Sat, 25 May 2024 17:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IG4dQngD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E780E882C4; Sat, 25 May 2024 17:09:58 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD49087F69
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 17:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5785d466c82so1902689a12.3
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716649796; x=1717254596; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v770EqQPwYNn7MpgSLpmNbq4V2esVCXgdbmA/D6Fef0=;
 b=IG4dQngDJag18BqbvzJadDI5aphAooiWJIaaRQfl1jHNVyMJvle8sr8cpvflHaRjx4
 MIy8z1xgOAuHcyFEIeviZAfWvNon4nHOoWsZxN/7aPZvLKFol7LLD4xaSHgEn8Ve75Tr
 g1TZo4Gnur8jBGL3SL84wmJS5LUHncVEKrJL4jXs0EWaFDi5oXT1VIgfjGHlRTtlvwSW
 c0mdz2WRshRZVGlf7uDeKMtaBMdG7Cb5EZIZ2g0yxjC/WHbFChk+zT8vit+OyEpe5yVS
 KsLmDAYqz8MW6lUXwGqDKk3r17IhZoHTtp/Hb8nCRs4Tzhpj8zEy5Ec8oav04vkMkuFZ
 MHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716649796; x=1717254596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v770EqQPwYNn7MpgSLpmNbq4V2esVCXgdbmA/D6Fef0=;
 b=RL8mbIol/v491rI8/UNOOfbWPeVJolOFhG44F9Rl2bAsbROcZOvNOlsclfZ7ODx2f4
 ISq5P+5y0apP8teCkKHEksbakxLtpbNYk3bHCyyYCI7+fpVsB37swobvIKD2DiiKIcHv
 Di8sThbsOZmxX18T8lNaxFsqo/TH8PHPJtgQWKqwxKJ1ShjJTcFBgHoBRewEz1B9arJ/
 LD7aZKTafS7An9I1SnfZUuU00hAnYUIKO7xKwgVxIn3lvx0atSlgwODoyQZ/uiLmvKp1
 eTLIaWFkJdXnjhadlp41oAF0iRoE8ZMe6wnZO7pRApp8JvH75fo6gbXt9+tgwXUczJnU
 h0dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpipPYMU39VIpwDIMRGFOSAGOUlf8JPdlaUKO7ohKoG1aEP9KQ47aAHK9oOqEGUZcLUOrY87bpgDwSiUiYyAScWlIexA==
X-Gm-Message-State: AOJu0YyebDmvg5kgXCjeChFuXpZz+fcT0WNSjA/ulQZUsxhA2ns/S5PI
 MVELX8PI8Bcer43/DtmXZAhyTuiT4amplsLWUtSx0gi9Xz6ASVeISDErIfiS1to=
X-Google-Smtp-Source: AGHT+IGix+ksECZNN3iUZpebYWWs7YKpKbsDyMpHu/4rGM1PpiUwH74+556eYuyCttxjd+wOh//dSw==
X-Received: by 2002:a17:906:640a:b0:a59:b543:c9f9 with SMTP id
 a640c23a62f3a-a6264179c04mr337517966b.7.1716649796198; 
 Sat, 25 May 2024 08:09:56 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b9b7sm261097766b.151.2024.05.25.08.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 08:09:55 -0700 (PDT)
Date: Sat, 25 May 2024 18:09:52 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] Revert "arm: dts: bcm283x: Add minimal smbios information"
Message-ID: <ZlH_QIcVzwqHUbxh@hera>
References: <20240514130724.1474507-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514130724.1474507-1-pbrobinson@gmail.com>
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

On Tue, May 14, 2024 at 02:07:19PM +0100, Peter Robinson wrote:
> This reverts commit 33041972727e84d3f95e26c83322521f61827584.
>
> With the ability to generate this SMBIOS details autmotically the
> small amount of details that this patch provided are generated
> automatically so this is now obsolete so we can just drop it.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  arch/arm/dts/bcm283x-u-boot.dtsi | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/arch/arm/dts/bcm283x-u-boot.dtsi b/arch/arm/dts/bcm283x-u-boot.dtsi
> index 8c17c6f6a52..ec0f93dd850 100644
> --- a/arch/arm/dts/bcm283x-u-boot.dtsi
> +++ b/arch/arm/dts/bcm283x-u-boot.dtsi
> @@ -6,25 +6,6 @@
>   * (C) Copyright 2016 Fabian Vogt <fvogt@suse.com>
>   */
>
> -/ {
> -	smbios {
> -		compatible = "u-boot,sysinfo-smbios";
> -		smbios {
> -			system {
> -				manufacturer = "raspberrypi";
> -				product = "rpi";
> -			};
> -			baseboard {
> -				manufacturer = "raspberrypi";
> -				product = "rpi";
> -			};
> -			chassis {
> -				manufacturer = "raspberrypi";
> -			};
> -		};
> -	};
> -};
> -
>  &uart0 {
>  	skip-init;
>  	bootph-all;
> --
> 2.45.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

