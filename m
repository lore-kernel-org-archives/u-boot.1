Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7684C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 219E381F30;
	Sun, 23 Mar 2025 13:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kt3HFZYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D9D81E13; Sun, 23 Mar 2025 13:21:49 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51C6F81F44
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so2064735f8f.1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742732507; x=1743337307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD9fiySrjSJymCyfiJ81CRwTFuIUBgVU3mKrzaw5TP0=;
 b=kt3HFZYVLaDSDy+lZ7XNy+LoaampcbsojZQ01emBImKbx2+/uz+6uR8TZRAccX24na
 Y+n1o9ts8820/bI3UAGg22UeciSn/BvWFFYUC8CKOUhjtUzHzL5d18WZeQeF+H2X2ZLh
 g/o91lpHe5XD3QSgOagiurMryULWlvgZlv9JpGPndqOwxlghPnBqIIDipBXDI60DQqJq
 MO4WX7S1g/SC6Dr0gQRcfBnxBRJyyDPj5WqYWtDGVygwGwslalhI2mtv4GhX7HFAmfK4
 +/6yJQH/W8LOcH4RAhHgUCshubdSTihsoHhdWjpTNMgZSmo1HbIhGz3XJ6cW2z38+EIr
 lnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742732507; x=1743337307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CD9fiySrjSJymCyfiJ81CRwTFuIUBgVU3mKrzaw5TP0=;
 b=MU8qhU4JrksY2wJHGM9cQPsq9nYzCnxBHbUKcu3FfoYBQyBywll6hsYmOzci5zaahl
 hJ3MEjpeSFvVhTOmAS0R0itGpjZLXzL2y1VZyaeJ0VRnf8LbT/FHasYUxSqsnBF8s9sv
 Q2pW9iQgDfM65hn+tIwSCzRWga9eqR++ElGFErPufu1BpHb14rcZJsL2eWHW5J7OlSld
 Na6PbH7Jo966bEd/7Er/XYmFUgbM4svLjZEhpbMRpBJF7FMuGyebaK98Wih7C4Q4p/1d
 qQVW7O4AZmxHNRNb6qW5Yz8NRHAXcOs6AMxf8cphnl3UEh6Okpl8zV36wA0uWTykVlCd
 BcCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUodg9daBMcGpUSn6c1cnPDwdarSj+lfsLwU9vmCC2NdQpeHWjrzY6wmNVW6xEl5K8XC85ThhQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf6eRjYIfKPjQZSfiGulehXAgfXPcZtSXJUziAnuS2/S9Hpi+M
 iRJX3zYJCBtFRJ/8g/UshK4cE3lEg3GK/NFfzkSmoNE0GCE1mxGE+hU+yw==
X-Gm-Gg: ASbGncsPnZFMfQAKtEHcL3/Yey1zYCD1BGQG/Y/o2rX0ozZBE/Dg6Njo5nfKEbq/27T
 3KvaDbESTNTCoQ5wccuFDDxmVH+OflWZTJMcfZarYvm+hpTuTH0faghfrQB8iLkgTHDurI1wr0r
 CVCrf207sYYAvE8pljE0EfIhS87jX1CzkDvRohiJQLU57S24jjLJuYCS8dRpYyHWsVyyMWdoB+I
 QRR8blyXX8M65vsvgEXrgOtYNMTA2B2u+eivyCY6VStAmPPBwJIVCd+kAkPU6RrrdgTawv72Qgd
 nXPj4oXbIvaRabRC6piAluSMFIEQv8VSN0XgqBdFEmOSVSioF0Qs8fgP7S5gJAOHXhnC13Lg7Lr
 e7Cs5j5MbkiAAeS95jQ1D
X-Google-Smtp-Source: AGHT+IEnFssmByWF6LQ07zj3s5eQ1YB6d+qCuh54xlEPBKkvmQX4FCl8xYyU1T7s4HPRY2SITZYy9w==
X-Received: by 2002:a05:6000:1788:b0:38f:4d40:358 with SMTP id
 ffacd0b85a97d-3997f900d5fmr9220163f8f.9.1742732506589; 
 Sun, 23 Mar 2025 05:21:46 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9eff6esm7576566f8f.100.2025.03.23.05.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:21:46 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 22/34] sunxi: Kconfig: consolidate SYS_CLK_FREQ selection
Date: Sun, 23 Mar 2025 13:21:45 +0100
Message-ID: <8502726.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20250323113544.7933-23-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-23-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 23. marec 2025 ob 12:35:32 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Most Allwinner SoCs (used on 107 out of 172 boards) use a default CPU
> frequency of 1008 MHz during the initial setup in the SPL.
>=20
> Make this the fallback default, in case nothing else is selected, to
> simplify the Kconfig stanza and make future additions easier.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/mach-sunxi/Kconfig | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 950b9047470..ab432390d3c 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -716,16 +716,10 @@ endif
> =20
>  config SYS_CLK_FREQ
>  	default 408000000 if MACH_SUNIV
> -	default 1008000000 if MACH_SUN4I
> -	default 1008000000 if MACH_SUN5I
> -	default 1008000000 if MACH_SUN6I
> -	default 912000000 if MACH_SUN7I
>  	default 816000000 if MACH_SUN50I || MACH_SUN50I_H5
> -	default 1008000000 if MACH_SUN8I
> -	default 1008000000 if MACH_SUN9I
>  	default 888000000 if MACH_SUN50I_H6
> -	default 1008000000 if MACH_SUN50I_H616
> -	default 1008000000 if MACH_SUN8I_R528
> +	default 912000000 if MACH_SUN7I
> +	default 1008000000
> =20
>  config SYS_CONFIG_NAME
>  	default "suniv" if MACH_SUNIV
>=20




