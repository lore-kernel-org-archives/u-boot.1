Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A38C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCB881F44;
	Sun, 23 Mar 2025 13:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N3y/FYhd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA0981F6B; Sun, 23 Mar 2025 13:23:02 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9AA81E13
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so22815025e9.1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742732580; x=1743337380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyB7aI8jg7npvoARedijEVN3XKQW+Kn2juSZr/TPcms=;
 b=N3y/FYhdO0jweLRMlx3mkqc1SjpLsgAdA2hy9nUCp1CHTGwzjKgSeT27CDq8M0eXS9
 hJngnl1M9lY42lN21pzg+25jZxerFAmmzne8fyFdAVVjAodpjnvXdhinYnSDqXhUzEZ0
 vlldsgCMTX/oltnzfNAhujYRhbhJBIOQ7rgJWsM/1nYoQvO1I1cWbibePYNQAfRrBGNA
 4hXpnkNJz/Dr70bcU0FFLNQDMySKcRBx2jvLsD0/AAqhB/pz5PJf3Hyf019ry+L079Ne
 ftIwTtwP3l+raQghn+3hs2co9KdtT1hJRbyahAJcfgbumJcu9TnrC8jtWnxboElyns3s
 oZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742732580; x=1743337380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AyB7aI8jg7npvoARedijEVN3XKQW+Kn2juSZr/TPcms=;
 b=RIdvLLRjWKcjSp/M912uYoTqvdF8H3diXW30Q4IQdkhd7wtusdfqdOQZfHa2JDKPB8
 hNF8G9okomU658mMyyGY1MUQijcSsoLKT2OlZYYKzPVLdjg4UHtzVk8GtxR6lqz2B/r5
 pKUCk6z92TRJytshZX5GFF+mEaquDOUm3pdHFw3fgJBTYJ10RHScPRLxY6ZUoHsa0YLz
 Pz2xmOuMfaWUC9ZWH27bDWsQ/3+yH4S2a6+Vh4TCZ4EEa9lYLiyAdrz3ajh0PPKiSflK
 1dydRN/FMqt6YGla/HRXAW8q6Z9n3q1PzPF9byKBwgRMipv4BwkRGWrCjRk4rvZvsL4O
 0GuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuuRo1DIESIgXWdoY3L7mCpCIrU03G8rqGcoVWpxdunK6xI8Xy8zLFbv7UliqMjc/a/aBqN4k=@lists.denx.de
X-Gm-Message-State: AOJu0YyQstaJqbTEUaZfMVq/niwhQfYPebgsC6HH6kLNPhcbTUHPoi9L
 +6/B3BlzUzb2UpUbEhkX9QOZNYjNZTUZPWaUw8UUbvC5tczpEWJ/
X-Gm-Gg: ASbGnctENFwjptCvv1mwDPAMVY+h2Y9RpAAu712QOw2PtniyZQd8j+QH80Vko8M1Flv
 dP52qXCcRKRsEKY/52TF/BM8HwOo30e8C979hC0dUcNxyXRYzGjw+/Bi3m5ahAf918H4l72jym4
 /2+hdKdmAGgTJJEKKFy5nP5MUdCd4dcNZYmHsb9iPermL7BUrmcbzHBPBtya8Cg62zikx1lbMVj
 W0Knd8ACjJzKdWisW5sCTqpARsER6Y3VeTlpflwkS5INfFQ33hLnVzesSo4eUJMdt2D8DOntUEc
 fdvWxLFVDC6mik4/LDhuMS4pJj+69RVGTRisTXqfBashTrGWH3CAGTh/lMgQT+xLpj+BcUC8KR4
 cN9WbGDRVL3JjaCvRG5v5
X-Google-Smtp-Source: AGHT+IEEgs4EmyttTAIIb2dfbTBM6Ehc3DEXjELIzMzApLxtN+pUUFtf+o3D2xiRB9bwn5jaHx5gLQ==
X-Received: by 2002:a05:600c:4686:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-43d509ee23dmr90116815e9.7.1742732580211; 
 Sun, 23 Mar 2025 05:23:00 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd185c5sm84411325e9.15.2025.03.23.05.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:22:59 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 23/34] spl: reorder SPL_MAX_SIZE defaults for sunxi
Date: Sun, 23 Mar 2025 13:22:58 +0100
Message-ID: <2300711.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20250323113544.7933-24-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-24-andre.przywara@arm.com>
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

Dne nedelja, 23. marec 2025 ob 12:35:33 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Reorder the Kconfig defaults for the maximum SPL size, to make the
> Allwinner specific values more readable and extensible: many older SoCs
> need to be limited to 32KB, so make this the last ARCH_SUNXI entry, used
> as a fallback unless explicitly overridden before.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  common/spl/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 94e118f8465..29d30f5040d 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -80,11 +80,10 @@ config SPL_MAX_SIZE
>  	default 0x1b000 if AM33XX && !TI_SECURE_DEVICE
>  	default 0xec00 if OMAP34XX
>  	default 0x10000 if ARCH_MX6 && !MX6_OCRAM_256KB
> -	default 0x7fa0 if SUNXI_SRAM_ADDRESS =3D 0x10000
> -	default 0x7fa0 if SUNXI_SRAM_ADDRESS =3D 0x20000 && !MACH_SUN50I_H616
>  	default 0xbfa0 if MACH_SUN50I_H616
>  	default 0x7000 if RCAR_GEN3
>  	default 0x5fa0 if SUNXI_SRAM_ADDRESS =3D 0x0
> +	default 0x7fa0 if ARCH_SUNXI
>  	default 0x10000 if ASPEED_AST2600
>  	default 0x27000 if IMX8MM && SPL_TEXT_BASE =3D 0x7E1000
>  	default 0x30000 if ARCH_SC5XX && (SC59X_64 || SC59X)
>=20




