Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF15E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E60801E8;
	Tue,  7 Jan 2025 10:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PNLrPWUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBFB8036B; Tue,  7 Jan 2025 10:16:50 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1B4801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso105131725e9.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 01:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736241405; x=1736846205;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FEyciuyJHOkaoWJ+3n84qeB/XreykiZzsc/wN6ObrNY=;
 b=PNLrPWUy8XXN/wC9cJvoej6JdAqW/TpFHxdcl1FKpA3g2UjeV5vDjR2ChyQ53A/pul
 o+giMITvxJjyk2M7R5lnSrKmvUamFiZIZEL8CrUfXRaE/nhqUK3a60RcY4yj3ge4jZRN
 GC3O3chFgTX6rdaypUPj8VeKPRaDNmP1544K/39oK+L1GPFCc7Ah/odobF8Kf1n4pmB7
 aueUCD5oB2QJQcJy8NZtgQKwVnuK+mMp5+2P5HpVwaVXa1uNrGvxF9kSzCnMTEhYMx0a
 OIARPnuzJPwaAdIA/IYtBt5tszP/dsREg/+Q63+wAhZrlQHWB5oVeM4yJW8pJEaBr4lh
 BDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736241405; x=1736846205;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEyciuyJHOkaoWJ+3n84qeB/XreykiZzsc/wN6ObrNY=;
 b=wfw31tbGflSYvGKGUOO8/5Bbkji/MTINWrviocJhOGH1MxCAC/56mj0gfuW6smtbWg
 4Z+sNbIfUpWpnAd2ENiGbY5s87vI44LgF3XVdMzie1Eb/nlbXB6hrFClPk1pYUV/SzmK
 GZJkyPtcSRr0yj0XHVLC3onkBgkIkTJJuOxYyuKLEPlN/Xrlimd7itCUMd9+wX0ggybn
 WcJD5NA6wHn4EYRPN6w9yjIz/6azA0hTjT4IptnbbD4Krpjhxc9vsxpMq7QqBG33cBL7
 I9XfTchqagqtAxMZJLb+uTAgKF57GJZWk953T6Moy/cQx0UrQ4/r72EeQh4aB9rP8WCf
 H1aA==
X-Gm-Message-State: AOJu0Yz+IYG//EY/9Yr4goFEU7hB6caYLS1WMG3YDqWqKKY/IcQB+wPp
 DsWVPUNtI6yccaC3r+m7y4evOAySKeGKJ+T5q0Bpt1VfyLp4uQ+xOccczpLYTEc=
X-Gm-Gg: ASbGncs4wavFMFq7XeAapjrQxyIB9Whk08TS2Y/14TGXHGEb/0vIuT6p1uT1PV/mXZ+
 ve5jfeqAV3DbXtsFw7oXavSZhttyvL2zJwwXSuu6MVWP3teGDTUYjDteoULNpP/U/5hzFxiB7Yu
 gB97LzgYVKgqHmkSmxkoLHrZqM0awJKc47dUIrD9Fw2NJl2mzDmsVK+LyX+fe2+4mPcm+YQXAHq
 ef10SG44aN/Mx/b+S+OMWiWfSrneyQmfAbHV5yiMyxHBPw8+SlsJiIZJo06BAXb7A==
X-Google-Smtp-Source: AGHT+IHEv53YMrTJhgNrJ+iQH/uwL5q73u77mUdL+2p7Cf9eOcGi0G2uUumNT66s9adPjLj0GCIU4w==
X-Received: by 2002:a05:600c:1c1a:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-43668548500mr473343755e9.2.1736241404926; 
 Tue, 07 Jan 2025 01:16:44 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8472d5sm50591090f8f.47.2025.01.07.01.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:16:44 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com,
 junhui.liu@pigmoral.tech
Subject: Re: [PATCH v3 3/8] USB: dwc2: Fix HBstLen setting for external DMA
 mode
In-Reply-To: <20250104-dwc2-dev-v3-3-d4b2bc1996e4@pigmoral.tech>
References: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
 <20250104-dwc2-dev-v3-3-d4b2bc1996e4@pigmoral.tech>
Date: Tue, 07 Jan 2025 10:16:43 +0100
Message-ID: <87sepvc7b8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Junhui,

Thank you for the patch.

On sam., janv. 04, 2025 at 11:37, Junhui Liu <junhui.liu@pigmoral.tech> wro=
te:

> From: Kongyang Liu <seashell11234455@gmail.com>
>
> The loop used to calculate HBstLen for extern DMA mode does not produce
> the correct result according to the datasheet [1]. Replacing that loop
> with a direct calculation using LOG2 to correctly assign the burst length
> in the GAHBCFG register for external DMA mode.
>
> [1] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf#page=3D24
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> ---
> Additionally, the boards I have only use internal DMA mode, and it=E2=80=
=99s
> unclear which chips employ external DMA. The testing was performed by
> comparing against the datasheet, and the results are shown in [2].
>
> [2] https://gist.github.com/Judehahh/34530da390b58728102778406e602cb1
> ---
>  drivers/usb/host/dwc2.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> index 609de18faa3abc5f4ecb0c23cf3590966bad7992..954650d856a4f2e95d74e1b57=
16c0ebe83fa9ba8 100644
> --- a/drivers/usb/host/dwc2.c
> +++ b/drivers/usb/host/dwc2.c
> @@ -448,11 +448,8 @@ static void dwc_otg_core_init(struct udevice *dev)
>  	case DWC2_HWCFG2_ARCHITECTURE_SLAVE_ONLY:
>  		break;
>  	case DWC2_HWCFG2_ARCHITECTURE_EXT_DMA:
> -		while (brst_sz > 1) {
> -			ahbcfg |=3D ahbcfg + (1 << DWC2_GAHBCFG_HBURSTLEN_OFFSET);
> -			ahbcfg &=3D DWC2_GAHBCFG_HBURSTLEN_MASK;
> -			brst_sz >>=3D 1;
> -		}
> +		ahbcfg |=3D (LOG2(brst_sz >> 1) << DWC2_GAHBCFG_HBURSTLEN_OFFSET) &
> +			  DWC2_GAHBCFG_HBURSTLEN_MASK;
>=20=20
>  #ifdef DWC2_DMA_ENABLE
>  		ahbcfg |=3D DWC2_GAHBCFG_DMAENABLE;
>
> --=20
> 2.47.1
