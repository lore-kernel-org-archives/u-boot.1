Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C26C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 09:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23F8088703;
	Tue, 23 Jul 2024 11:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QlayLTIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446CB887B9; Tue, 23 Jul 2024 11:30:44 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16AD388703
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 11:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-368380828d6so2711095f8f.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721727034; x=1722331834;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Prxp+grMWUSFOW5nBtW2K3eokOwKO3TvzIs6vDVscNE=;
 b=QlayLTIEBMg/GNClbo9VMOXZy616ELgG9fPQJ2d51ZkjNJU6rl/JPgThwk9XCJD6E5
 8A/zCWHIhEvucMrTfKPEKFQY6X8pbNwZQCm9I10RkOBP0gFwHJCucMYU2zVjkGMamEIr
 AQKsvUJwQ+ym+COCGLo3OHmITLx6huC73GGh3/3JZGtH9rECjS2NyYja+rR44xq6InJW
 VVaZIKbWFnlJQWptOimKMgfYhWpRRNz33hhPRiMxT+hdX1qDvsYC4cgSa56+aJmyOKKr
 y8haINK8sicdGX+gnAF0zwDj9Sd7MAQh14esou561U+pCoPkJSstRd7+9ijThExbYkge
 /VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721727034; x=1722331834;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Prxp+grMWUSFOW5nBtW2K3eokOwKO3TvzIs6vDVscNE=;
 b=r5Yaqzn4teszurRTezJK5Fpi+jjT8y/Zj8Vrvt4LIF6G9NNi4J1Dy2vK/9PjObAmYy
 t/EMPp4GAY9xz6lRpCAhs6Pze4mlF1z/prdqmMdey41rdgZ3JYqjSmN+2XetFAvmHEQp
 W0KujCTB9Ja1Cd4Cvw40mnC099SRbQnddwXB9FaSWh2S6ybTuLjZlfK1MsriFCJTQc7q
 9eukf2DHvtaKsZjYCz3e3FJGdxKSst7poBzC+P4zSZyV36hWfhMTwTCQAPtYK/ZxHctx
 Xi+v5DP4d/96dIv/MtJpg8Y/dxdtlD1OkNN2AQ5yru7ahToOD65J8QjFj921Yzl+54+B
 YpVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp+xQjVcoHF67mDJ1sf8akMaPeK9j+ojib6lUXEy0wtyD1ogiOeVUMEcticgY5J4TYfWo9ke48Cxuc7J43n7TkzMDjkg==
X-Gm-Message-State: AOJu0YwklOpxzV8FxLAMlewxnsvnjHoyVNLakoqJ8D8F0hosHepKo6iw
 5Lkb9SQz3htRpr3unv5SHFp3OKZ2GYo9h/PIWaoiIv0c2exj65n506a/NEHzZ+g=
X-Google-Smtp-Source: AGHT+IHqAMBO06qKgUthaDR7m1j1qeg+nmaj3ItheQVqn2wZ6pLZNiO/oiQkt64TwWHYVMfZYgVoKQ==
X-Received: by 2002:adf:e34b:0:b0:368:6f19:cbf5 with SMTP id
 ffacd0b85a97d-369dec1e3d7mr1643830f8f.31.1721727034143; 
 Tue, 23 Jul 2024 02:30:34 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ed7b8sm10909914f8f.106.2024.07.23.02.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 02:30:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>, Lukasz
 Majewski <lukma@denx.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: gadget: usbhs: Add Renesas USBHS device driver
In-Reply-To: <20240620005608.211147-1-marek.vasut+renesas@mailbox.org>
References: <20240620005608.211147-1-marek.vasut+renesas@mailbox.org>
Date: Tue, 23 Jul 2024 11:30:32 +0200
Message-ID: <87jzhcpi9z.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

Sorry for the review delay and thank you for the patch.

On jeu., juin 20, 2024 at 02:55, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> From: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
>
> Add UDC driver for Renesas USBHS controller found in R-Car Gen3 SoCs.
> This is mostly ported from the Linux kernel, with additional porting
> glue. The code has been synchronized with 1b4861e32e46 ("Linux 6.9.3")
> and cleaned up and ported to DM since the original implementation by
> Vitaliy.
>
> Signed-off-by: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Note that the driver does have a few checkpatch warnings in it, those
> also partly come from Linux.
> ---
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>

I've reviewed this by comparing this patch to the Linux stable 6.9.3
codebase located in drivers/usb/renesas_usbhs/ and the
phy driver (drivers/usb/renesas_usbhs/)

While I notice some differences, such as:
* no USB host support (no VBUS control support)
* no dma mapping control support
* no support for the older RCar controllers (rcar2)

This looks good overall.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

[...]


> ---
> -- 
> 2.43.0
