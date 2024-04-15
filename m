Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13A4C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC2888118;
	Mon, 15 Apr 2024 14:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oqLsIPUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D6278811D; Mon, 15 Apr 2024 08:42:59 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917C288189
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3454fbdd88aso2643508f8f.3
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713163377; x=1713768177; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0k1SZW1mcxCUr4yIGa/VaGkFBHOOrJomq/fe550c1w=;
 b=oqLsIPUQ6kC4265PpjX13ojvJkLIHPprEnBwVYVGotTjkApMPDeZIIkELXv6qj4lRV
 dmIIbXfweN6fjF0drTZ56CcMmmgtKPuVjrmBQuJWXLubKOx2lifKjsOqlqqEgriuBt63
 qXZv++tQjYFL1skJzG7R46gUrhnNvhEUlGoigY7OBKE/+3/QVZbBXWqpiZz1b5NsipCt
 q1ZLiFkAfyQ5H6BJ/YnVtPX8+SVz5Prje6VG8HR9Nr6iFKuVzCCv+Gp9e0RGAbD44ZYv
 xeOYLFutE/hKnV2465he5iq1+lz+AOh44LzeVW+yD/IfGU/hbmadPiI1MgWdQWeN2WAe
 PT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713163377; x=1713768177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m0k1SZW1mcxCUr4yIGa/VaGkFBHOOrJomq/fe550c1w=;
 b=k7z9r0E9r91k4W80dyUHxHIkiIa87cWR4gGCOakjUDZXwbOoVMFNmQMvtNljLH4UjK
 3NXz0kWTt5MA5BjlNNhkfl8EiFo8UEGqCD7EmCgZMSNASnVGlv0XQvaL/i9lnXB4tyd/
 pNrxNuTpVAhFmikSmdd50psLDuRnU7bMvRpeOrW/77m1RClCJcok+1UZ5zyZ1z6DLKeg
 t3v5dtJPta3MUEwFM/oTzPAstgQMvlt+9x59TNRwUQAFzDhLnf+HW7cBpi/lYOKQETu6
 fdJHaHubtO2d26ov+0JdafFjZzU894vvew8RS5l3SwHUtvnKLED6FMK1CHfmzLY455fg
 bz6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp9ay2EoOYv4TAQeFhysa3VGtaR7jquF89NV2/4DHjz1abfSrp1YBkfWjJO1zganP2GWus5+thPxKrcYaKE8v9nQPVqA==
X-Gm-Message-State: AOJu0Yxqkg3UhWBhbZxOFXjITlNy2x2NhpVr4nPX+78SoYqXBU5KCFKj
 LpbmhrgewjfayTtQcqw9rxoXr4pKK6PeR/dFttUKn9uYwNOOEUU+SS5tGmAS/PU=
X-Google-Smtp-Source: AGHT+IG89fuRBeb8QHX2Bf4bnRU1XH1+fARzIh/srw10H/R6nLJH8FuiVPHeqyE/DxtRszBTgZ2mKQ==
X-Received: by 2002:a5d:5490:0:b0:346:b452:1740 with SMTP id
 h16-20020a5d5490000000b00346b4521740mr6528077wrv.3.1713163377010; 
 Sun, 14 Apr 2024 23:42:57 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
 by smtp.gmail.com with ESMTPSA id
 s19-20020adfe013000000b00346bb778e8bsm11014376wrh.5.2024.04.14.23.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 23:42:56 -0700 (PDT)
Message-ID: <f9a4bee3-3903-49ca-aec0-33d5d8d95895@linaro.org>
Date: Mon, 15 Apr 2024 07:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mtd: ubi: Do not zero out EC and VID on ECC-ed NOR
 flashes
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
 <87a8c4db9598aa2deb52c41895191b17070ca156.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87a8c4db9598aa2deb52c41895191b17070ca156.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 15 Apr 2024 14:14:08 +0200
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

Hi, Takahiro,


On 4/15/24 05:33, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> For NOR flashes EC and VID are zeroed out before an erase is issued to
> make sure UBI does not mistakenly treat the PEB as used and associate it
> with an LEB.
> 
> But on some flashes, like the Infineon Semper NOR flash family,
> multi-pass page programming is not allowed on the default ECC scheme.
> This means zeroing out these magic numbers will result in the flash
> throwing a page programming error.
> 
> Do not zero out EC and VID for such flashes. A writesize > 1 is an
> indication of an ECC-ed flash.
>
I'm not familiar with the u-boot requirements, but I think a good
practice would be to specify if/when a commit follows the upstream linux
implementation. It helps reviewers, gives a peace of mind to the
maintainer(s), and gives credit to the author. If something breaks all
parties can be involved.

This patch replicates the following upstream linux commit:
f669e74be820 ("ubi: Do not zero out EC and VID on ECC-ed NOR flashes")

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Cheers,
ta
