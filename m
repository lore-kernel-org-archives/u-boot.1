Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372CFC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 06:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F5488AE0;
	Wed,  7 Aug 2024 08:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iXf8GLZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962D488B0B; Wed,  7 Aug 2024 08:49:00 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7468088AD4
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 08:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so9251735e9.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723013332; x=1723618132;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvvVA/2vwjH//HvGoVqHIOxulCo5vXG+GzCVNuhoyZI=;
 b=iXf8GLZaXS0a4XFzIvMZTbSt41ty64qhF7lQ7W36Am3c/4NGMoku/KQIBj7U8Tl9B7
 eVOPNFna8A89Rxrh+zdw0lIu7AlDIRedgLM+4ypXqVlpOaliFsu1kbY+0ipdRwZBEC6B
 7p/Bm1UtIuYRTGn9E/1nYGYKYdHxbgbLCFmsLaWLHBxWCTI3yljQfcdyAX44crPspC3d
 kJ5QbIOc8domZ4W9k7bT5AFU0GmF95nlb892Jo7opfJrZzOd3ifp5cNZjOizqJVhj/TL
 7AfFxCuCzr+3WksNQVlGrwtdHC1nWPanzaGGM8Qnm+vBI0JKK0k7MsXpAk0f027iZIBj
 rSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723013332; x=1723618132;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvvVA/2vwjH//HvGoVqHIOxulCo5vXG+GzCVNuhoyZI=;
 b=MF1kSxF0GjDhaCiB7FfJaFbx39TzO22PrLYwATPjMkc4QUttJKoEhiFghSpDoxyqzl
 l/6Pm9XFrz/qL+96NXRYgbfWK5ofrI9wo1d+5IXtLy6gFybfR4tGGe0UTtSv3HbdXAkc
 7tvLthqXwgfABNoz6+vLqWyFXjnEZo2lVoIjtHPwve+RY0EO5YbtGmL0HzjOp1b8rOwj
 eEzw+Z0qB/xIN+5vmPFFFkoXSKTz9eord2CT98bRjXY7H44Zd+MqiEqYN1dUdOfWmmJH
 ErtYigrt0Z3YGmeQfapibYZlnYHSFzcjsnUc5iKWbg5dimdGUtGSlipIhuu+/Au9XLPX
 k6zg==
X-Gm-Message-State: AOJu0YwiRsrcgCkMUBWbpYpRCvuC/b91ZN9Noi7WmcMCk/6Qz22LTXQv
 4XajiSILkZmuCnT5Fzz4Ru4BaWyiMoAYc4B9dPv7u05ZGXgQVi3gOAFDboGTDxk=
X-Google-Smtp-Source: AGHT+IEM6rB+5CaQ3dKEHFFiufY5STL+eai4K6GHUFXsiqS/shJzePPgbeHCDKUfyaj4OisoZHee4w==
X-Received: by 2002:a05:600c:1e24:b0:426:8884:2c54 with SMTP id
 5b1f17b1804b1-428e6b9312bmr97243155e9.35.1723013331200; 
 Tue, 06 Aug 2024 23:48:51 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290598f18asm13014925e9.27.2024.08.06.23.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 23:48:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20240620005608.211147-1-marek.vasut+renesas@mailbox.org>
References: <20240620005608.211147-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] usb: gadget: usbhs: Add Renesas USBHS device driver
Message-Id: <172301332974.246690.13564435454732613935.b4-ty@baylibre.com>
Date: Wed, 07 Aug 2024 08:48:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Thu, 20 Jun 2024 02:55:15 +0200, Marek Vasut wrote:
> Add UDC driver for Renesas USBHS controller found in R-Car Gen3 SoCs.
> This is mostly ported from the Linux kernel, with additional porting
> glue. The code has been synchronized with 1b4861e32e46 ("Linux 6.9.3")
> and cleaned up and ported to DM since the original implementation by
> Vitaliy.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] usb: gadget: usbhs: Add Renesas USBHS device driver
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b61ed3c87f977bde4ed47ce1161cebf7fb814765

--
Mattijs
