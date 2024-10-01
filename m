Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F1DCEACD5
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 15:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E6888CFB;
	Tue,  1 Oct 2024 17:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L5+N8Ttg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F0588CC3; Tue,  1 Oct 2024 17:38:53 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2C789229
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 17:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so50400235e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727797127; x=1728401927;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJT8LeUg+UMFYuonmVoVgM1eGd64e6PyskomK9ZfcmA=;
 b=L5+N8TtgZX22PjZaS9TS7l1/d9pkMhix0+WOxCOjfhdPmfQLOS476wiB13Tw1LAhKP
 icF+EA+ap9jqZ55PC4lpkIqS1ZVUDGR2cqa1fTS+MNzCEtj5oO8kW9WmbwctfC0ZnPEx
 3mp6rTcRsQLYNwcva5ugf2JTMkbdMqY0fvAtbA52UEy7F9ljFDd6XGyLx36ssj/1BLPU
 L0omrCuDCAh7VW6EmKqdCOu5XTPHRYkDwiDtyTYUoroLdjGe5iFSUjalT5V1bDvbCQQI
 lOWL3zlShpVxVkyQTEjNmUR59DFepU+4f3Q2Loy6BYDDd1wWPnPsy1FE1rmBp+vWXPD6
 WfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727797127; x=1728401927;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJT8LeUg+UMFYuonmVoVgM1eGd64e6PyskomK9ZfcmA=;
 b=lERIxEiLF+i2NBdBUrPHtUMGctShOs8kokVSPRDmXhiBoKiX4NReLDCTx78x583hY0
 08TNeA5JsE87lUcdMIKnC4K7IWrDgyFuDk2ay7yu/UUSSCRKYQr7yM/MHcuBxmY0utuE
 UTuwvQYmUiOouWf5ncpn842P5YF4Ad71UUwnCUKByIMVsXaaaeBTdi1lPbvILPRZuEiP
 mI17nBiUjcvN3f9qR2TAGLhUF/rRXWfOkSTHvGSPixZy7d2jWOh+te7YRtl2sh7aVG4b
 OOpPEDBaIHw/+LnbRbc9igRbEeuHrR+gmgKB4CM1bMkAcuo3dUPV8J63xQ8mH0B3ZTJt
 bd0Q==
X-Gm-Message-State: AOJu0Ywk2l6b+CZg+VzvV6WwOdmLpS96DcxLwx+8uCEoTwVvFZ9/rwpO
 x8Az/QbA+vKDNCuwxoCIxeVNqqsGT3XVyFiuz1wXnPQkZrBZ2KiVY4KbG2WrbMA=
X-Google-Smtp-Source: AGHT+IG0ecQdM279WS26IKPEEkKuL7h/b79fLABexbswTWorpzoe11ipwpR5GhpoNlcfwa1cGTo0bw==
X-Received: by 2002:a05:6000:1b83:b0:37c:c4bc:181c with SMTP id
 ffacd0b85a97d-37cfb8b52f1mr935f8f.11.1727797126667; 
 Tue, 01 Oct 2024 08:38:46 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e922csm12006162f8f.65.2024.10.01.08.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 08:38:46 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20240908230654.286062-1-marek.vasut+renesas@mailbox.org>
References: <20240908230654.286062-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] usb: gadget: usbhs: Add Renesas USBHS device driver
Message-Id: <172779712511.85568.2897665223760729938.b4-ty@baylibre.com>
Date: Tue, 01 Oct 2024 17:38:45 +0200
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

On Mon, 09 Sep 2024 01:06:24 +0200, Marek Vasut wrote:
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
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/50bb758c1e3424d9e1925588c9269b24418c2e04

--
Mattijs
