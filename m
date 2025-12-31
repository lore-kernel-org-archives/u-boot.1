Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDD7EE645A
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C553E841B9;
	Wed, 31 Dec 2025 20:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VKwpEAh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1DD84179; Wed, 31 Dec 2025 20:31:04 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 302D7841BC
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so2491364966b.2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767209461; x=1767814261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nNN3ugMXFKLlPtQpiabvdNcV0dM7PfwcCCmI7eZegKo=;
 b=VKwpEAh6Bk1i29SD5DCJ7ye4ayeSqrW1Z43wUl5Fs95CSJv68yzFWzHrqhkFkLAqTc
 dP26zlk6Y5yAkddCBeDPhUqFeBYiwCo01ccB+ZBvQIerPoKmnc+N5Pz88o2i2/tjShiz
 2I7wsVPfdJhEzw03F88jcOem2py+1xCMZs1Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767209461; x=1767814261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNN3ugMXFKLlPtQpiabvdNcV0dM7PfwcCCmI7eZegKo=;
 b=XC7C46Kv+eluJH3MRtFzC4pnmJeWrkfs5aXAARmpCbQ+1DXyXFpOlfWYnK/CiSQAEp
 3UJNamD31HaM2vglyr5GzRwtzLmWXl4g5JNAqItULZ+PXVIWYdQR46iW91+k8jHEwiL5
 SYHs2lAqtptFknVLxT0j7h3XefbSCpSBLFs/ozoaIT9l3LVwXKpiPInzfk3m5o2gocEC
 UmgjonUd1TA53Bl339k89YaJmwsGKlaIOMEUV63IFan8DIX8G7ipgSypFaA7IxFJQt2E
 /RiXegGdUn+LiUNy8bDd2Gp5Cqguxp7A2jAXB+PG2+Ny/x88iyD8aB6Zxf1EfzigqEsc
 HHYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWslYW4jx9b40muDpyD8auzhOuKhmNOBQ+ExN1/vGns0Ybi2/UfeaLkKPeZcUvNmtfnaLIXbE0=@lists.denx.de
X-Gm-Message-State: AOJu0YwZnplJsFCTBwdjL+uHfAh23IXHC0Fm+WK070myDCBBn32QJIBW
 C4bj0AvgL8bHNqWzjvSB4+jKWeYmDsV6obMd8q8Whh/HUSYsDikLe2c6w89La+PUZzpst6iZzTZ
 dUssxl6InGkA3YPQb5nbqVRyKw17VjuKSlyHoU7tU
X-Gm-Gg: AY/fxX5RTRCFWI+ySoBkk9b+zWjIN3E1b+zw769H6qEXSemwD5mnBtTKsXIn4INVgUt
 tOGvBoAVJ5D/VcfJS4aA/2PZl00Y+dtXNKctTx6TcggXGZeNJcMnqEDcs3O4nMv0RCdHJWGcfQB
 D5O8w19AGDXOGyBAYASsLLnujyNesstrWbaC9Rc2Uu+sqNy7Y+6UiyeyMi+C1AwTNvotcN/P+He
 ruXG4+Vv1iL4RZZK6kiD6iyfSvy//8E4H/JBaGVOrAx9+GMvYKCShdLo+p96wTkY+NLIQ==
X-Google-Smtp-Source: AGHT+IGaI/O6yALq0QkPNdmOj1MjLHyiLkAtoo48jAAK3+CDeBG4kNtpItmgkYdOZPzRinmY4iFHitMh2N6l8jDHGkU=
X-Received: by 2002:a17:907:7753:b0:b83:1326:7d46 with SMTP id
 a640c23a62f3a-b831326eb32mr1644422666b.30.1767209460639; Wed, 31 Dec 2025
 11:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20251231141550.64310-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251231141550.64310-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Dec 2025 12:30:44 -0700
X-Gm-Features: AQt7F2qhAl47vNYUsywicBkyzJ4OdZclTsV4gnbInaBOcPKkTnpLPx1XWKS5gHM
Message-ID: <CAFLszTiWCR=GbYvZg3p3d5PEd2YC3azCyHGRP808wdJ72Hh6gQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: command `font` should depend on CONSOLE_TRUETYPE
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Wed, 31 Dec 2025 at 07:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The font command is not usable without CONSOLE_TRUETYPE.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index b71ac554c0b..b5b03eb5363 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2649,8 +2649,8 @@ config CMD_VIDCONSOLE
>
>  config CMD_SELECT_FONT
>         bool "select font size"
> -       depends on VIDEO
> -       default y if CONSOLE_TRUETYPE
> +       depends on CONSOLE_TRUETYPE
> +       default y
>         help
>           Enabling this will provide 'font' command.
>           Allows font selection at runtime.
> --
> 2.51.0
>

It should be possible to change between bitmap fonts if you enable
multiple ones.

Regards,
Simon
