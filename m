Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F34CCFA18
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 13:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A44D083E4C;
	Sat,  8 Nov 2025 14:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JB3+QOaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB8A83E4C; Sat,  8 Nov 2025 14:26:04 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1008783D2E
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 14:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3d1bc63d5f0so1008452fac.0
 for <u-boot@lists.denx.de>; Sat, 08 Nov 2025 05:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762608361; x=1763213161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1RE7Vm+ZDoYP0u5gFKfFHsmpHMA2pF1428i7P0uolA=;
 b=JB3+QOaTJwIhmsR3RDrEklfHtqt1ArTNn+kIqd7dQNjALCwR7Wn0KIX6eQizvu9wOd
 i9AYMKbxyFa+RYE1yWdAp+SI4hP6n0wezQX9PDNH9qrFVhbJRm4h+v8LVtpAyxcF5y8o
 w7g4kJggypAWRQM+un7ljTOMh40mOOUTEAUic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762608361; x=1763213161;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V1RE7Vm+ZDoYP0u5gFKfFHsmpHMA2pF1428i7P0uolA=;
 b=SlN0r5OfYMprcWey4OZmdepJiPAbXjLd0T0L1U7mF0W74zKoUj1WlCSBPl51cPF0aC
 zjvH6Du6uZT3QsgcrKyQDdr237fwYxBPvxmj/MFzvynj2JEu5lu+2TaODP4YBRq8izDw
 W/EHjvLbo1X6RJFMVgDRwc2o4AKU7gWH2Y8klln7sFcfzkWMlB9LdqLMHztUnIeh5io3
 g7SVTbDmbg+iWtvuJ9keO/EZsSPLrdigeHsQHkjBTd9G305MguIiQs2+9ySHeHPzfK5b
 SmG9FPh68pFOw6SAYeb4IO82dKR8V3o/6fTO6NAEMXVyA0RJGW32EqkPMWwepGpTDeiO
 F/SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmkrAiLaP1aidM+v5dgcxQanmsumTmdv2G9jV5jnHNmd69uZL5X4MAX3AGu16avnNJAMyZoOg=@lists.denx.de
X-Gm-Message-State: AOJu0YwyCPFCipMotDXOAoUgnVkJpNTqQDbjmhYGPPIFVGDdbiWiuAgi
 9N8DPFHa00AXO1EPvz4QQrWxhh9du5YbNdNk+ciXWaTU0/fpYYiJDFXh7l3acdVgjuw=
X-Gm-Gg: ASbGncttXzBYGZKbSHFrnFGd5+KFOgyAKU56aaUW9E0kE/0n8yMHtRnV6jfhR7zE1Cc
 f5Fy4HdJJsZeUqNJfEATatsCNvRz4Ly3wj3Id4PtXZF2tFtmdcVxeCZohQT4SpSF9NBU8ICMUjF
 qqakEA3oz6IdCQfXrBCNCrIewcU2e/LDw3nmgJ4YxR8V6HDjedKXHFia71mSSBp7Wn68fQAJmxR
 9B4Yk439FkhDCX2Wc0DR9OqioLX6m6p2OI239t3rabXGeWYWTHLAVov+Rs7v/altxKamiNmKzxF
 iK+OtChVWjadnMbLcdyYEl3cNPLRWgRlHfi9eN7X9pXnupfBYa5VKHdghnjkW1eZjSYekJRDriX
 NtlbLlSiJcxYQ9aZ1N8/qj61yTTF2dJ8FVGqSZpNiQaULpRmvhsdeA3FeVlCXW/8PI4cQjvX5zn
 xYiYRdRzeQrPaajGQeSlvLRlDYovZsdsXl3gl+oOsBEFpgmCfb
X-Google-Smtp-Source: AGHT+IHAg0XEXX1mQuByPlAJh1kE5NqX5y2sVhVcLzSe35JR6z8eu0tMvfuuzLSXWUv1zBNYut3r2A==
X-Received: by 2002:a05:6870:82a9:b0:3d2:c24:30fc with SMTP id
 586e51a60fabf-3e7c2912e0cmr1484812fac.48.1762608360782; 
 Sat, 08 Nov 2025 05:26:00 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41f13a512sm3581636fac.12.2025.11.08.05.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 05:26:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH 00/19] arm: airoha: add support for en7523 based boards
Message-Id: <176260835950.3710933.1024986526033880057.b4-ty@konsulko.com>
Date: Sat, 08 Nov 2025 07:25:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 01 Nov 2025 03:44:44 +0300, Mikhail Kshevetskiy wrote:

> This patch series adds basic support for the boards based on Airoha
> EN7523/EN7529/EN7562 SoCs. Due to ATF restrictions these boards are
> able to run 32-bit OS only.
> 
> This patch series adds support for the following hardware:
>  * console UART
>  * ethernet controller/switch
>  * spinand flash (in non-dma mode)
> 
> [...]

Applied to u-boot/master, thanks!

[01/19] airoha/an7581: add CONFIG_TARGET_AN7581=y to the defconfig
        commit: ec0cd37f67bffa3e9729605ecedbb5aa093a5e30
[02/19] arm/airoha: add support for airoha en7523 SoC family
        commit: 97aa00e0211d1d0b387e69e4a568ec2ceec7815f
[03/19] arm: airoha: introduce AN7581 helpers to get SCU and CHIP_SCU regmaps
        commit: 9aa3e440c6e64b9af6a8e679d08686b9e816eecf
[04/19] arm: airoha: introduce EN7523 helpers to get SCU and CHIP_SCU regmaps
        commit: 8e21740b68d06f71b4f9fb13b908a8828c5c7e2d
[05/19] clk: airoha: use CHIP_SCU regmap helper
        commit: f8cef0b7435b65b0a33b541c28081b357a76d4c3
[06/19] clk: airoha: add support for airoha en7523 SoC family
        commit: ee82f804dd52c62cef0d6e4101a9fd897064409d
[07/19] configs: airoha: en7523: enable clk support
        commit: 7a656020d8eb9e51d56f778d81722531e38f295a
[08/19] reset: airoha: convert to regmap API
        commit: ea9b7975378a1ab216a28d2851335a3db5c2d445
[09/19] reset: airoha: unify code using SCU regmap helper
        commit: f1cae1f63d9a483853fb28e9b74607d27a7ed2cc
[10/19] dt-bindings: reset: Add reset support for Airoha EN7523
        commit: 168af8e4f4de77053fa7abc60c8e24aeeff858ec
[11/19] reset: airoha: add support for airoha en7523 SoC family
        commit: 1b333e40630f42173270b964ed69be494c2df53a
[12/19] dts: airoha: en7523: add reset controller support
        commit: 4dd7df70b8415b98d4bfcf23adb018ac39e3dcd0
[13/19] configs: airoha: en7523: enable reset controller support
        commit: 4d6da602e3ee7907dc33cadc225f6ab06117f845
[14/19] net: airoha: unify code using SCU regmap helper
        commit: 801a84b1a46ac70f49772a2c7069a33cd30cf720
[15/19] net: airoha: add support for airoha en7523 SoC family
        commit: 251e27fcc209f840b4f33615f89e4859ddb44242
[16/19] dts: airoha: en7523: add ethernet controller support
        commit: 760063efb04dc997e70dd7fd825c7aab0b1d982e
[17/19] configs: airoha: en7523: enable ethernet controller support
        commit: 2ccd4b4efb44134a6ebda9c90aaf64e9573f0b66
[18/19] dts: airoha: en7523: add spinand flash support
        commit: 4fabdc415c4a4a2a79d88c1d73e69d3d463ef631
[19/19] configs: airoha: en7523: enable spinand flashes support
        commit: 475dec28805bf0c84ce83ec06d452b4ee8b5f9a9
-- 
Tom


