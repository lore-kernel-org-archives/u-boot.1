Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37419D2502F
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 08:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D805F83AEE;
	Sun, 11 Jan 2026 09:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dTOk+wOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0590583C91; Sun, 11 Jan 2026 09:24:00 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 173D183A9F
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 09:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64d0d41404cso8817031a12.0
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 00:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768119832; x=1768724632;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1DWtB0NMZERFgO7txKyF3IFmC6378Zhy2ofmBH5qUjA=;
 b=dTOk+wOPKw8OzD9ce7gjo6CGK68elXFGEj/pQVHB0SBSA3FcN3DyDKlxfjtJ7vtBSH
 qD7XnX77FgU0xwasPOrAe9iTGLjOHRSNUBv1paRVS3Wu8Ww+svNRxZ4h9zt7hIw+WFk/
 TyxHkdcdGoeUpLX0LjvyL4SegejAOGSmdBuDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768119832; x=1768724632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DWtB0NMZERFgO7txKyF3IFmC6378Zhy2ofmBH5qUjA=;
 b=YdCGANpOv+Lsebo+QCwQahrE0oCH/R/t9PkTUvMpMhD46QGteqAb3pEXnDzlZc/VGb
 /q9HBLJ4iEyukWixAWVBVjjB6UzoRqCGS2X7L/TVT41ObUj4ReVyjpYk1ZixNZ5Y4Ddp
 9hecYv4M93aAH8VUb0KHGBiajeaWx73Q12XtASyeb6jj3TTYc1UeZiTpYlknIxISwWkv
 YQA1Hj0VuP+vw/fSLFkbZQVThEgb5tUV4I9R/gmk9rea0NIEypbDsP7U986bTvuobChl
 y0fh6sI6Ns/G3U6417W4ivfJRZuhICo7sMQua5R/i9PDFd0YfSUQM+2t+9KuvKcmdfqp
 yS2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUncYpJ7ET6LZUQBU8Te0BP9mjGL+x+oY7wzSi6Roohf1fb4NNQUe1ze4Th86PkfspJT7l8U24=@lists.denx.de
X-Gm-Message-State: AOJu0Yytd2hbHyeuh30yOW0Q26ZC18w7jHYjJMwoj6ntPebrjCMMlhrP
 ODmki1lGVM+FhcrhohUyyyVNNJSmWc3LzGi/v0EmTo/LTDwgsdB4/yUXwleh48lqibk/QEgZDnW
 M3nIbyZg=
X-Gm-Gg: AY/fxX55bwOheBWWtVVCUCtakOgU9F7xisfYcR/IgT6hu2DGOj7WMj5oFxo/87rRpxX
 tirU30pjDiN5auNvpenRwzEBqmpjhf5H/WTM2C/xXza/gSGNEYk6sQBT7GRYt8ZTDLOfgNFWmuF
 POSXiVRuk7Gqq0ODJ6xngu6tfOndl8iHZfILqN6pYr/wZFjl8GUizzydbD6Ko2i6g85un/TcAOd
 2XnHsm+n5w29H5efFDTAiUQLp5Y3sZqVI8/4W20O6UHBEyTgLFO/czXReMC3oQg+j1Y3c08Q1nE
 XScOwGogcsMjeJu/o6s+Intqx49txHACb+NkxKcC7ZEzE0UY9DdOE0VpvhWJn5OXVAUwVAEoTXw
 2RK2jjdJMLniU7I5oQt05ZwLCdSLyVSGqTa4mkR+lnHOLGyYbzTi8JtOvOLefxGu2lTctBgrv24
 1hCgsZ4uRbR/645zHiv8igt7BA4MjgnyzihGZsBEPV6taD+pNfTQx35ZZPcG87oYlKcdFyln3B5
 TcSDi1TsvmJdIKhsnN36JWChNyy/8rZtzZ3nnBhh5rm6+2XGxI9NMUHuA==
X-Google-Smtp-Source: AGHT+IEOOIJymnZ/6cAAYGhb0UFr8lBOvI3Pr5gg6ibkmw6RDVHt+MIgvv1yTiQYbvR/X14tbkzahw==
X-Received: by 2002:a05:6402:2345:b0:649:6ac4:79af with SMTP id
 4fb4d7f45d1cf-65097dc62abmr13783815a12.6.1768119832434; 
 Sun, 11 Jan 2026 00:23:52 -0800 (PST)
Received: from panicking.homenet.telecomitalia.it
 (host-87-5-117-220.retail.telecomitalia.it. [87.5.117.220])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b9d44bfsm14608346a12.8.2026.01.11.00.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 00:23:50 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 0/2] power: regulator: pfuze100: Fix voltage calculation
 and support high-range
Date: Sun, 11 Jan 2026 09:23:45 +0100
Message-ID: <20260111082347.1302003-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series addresses two significant issues in the pfuze100 regulator driver
regarding voltage calculation accuracy.

The first patch fixes the handling of the "high range" bit. PFUZE chips support
two voltage ranges (controlled by a register bit) with different step sizes
and base voltages. Previously, the driver assumed the low range, leading to
incorrect voltage settings on boards configured for the high range.

The second patch corrects the interpretation of min_uV. The driver was
incorrectly using the device tree's regulator-min-microvolt constraint as the
mathematical base (zero-index) for voltage calculations. This caused offset
errors whenever the DTS constraint differed from the hardware's absolute minimum.
The patch introduces physical minimums in the driver descriptors to ensure
calculations are based on the datasheet specifications, treating the DTS value
strictly as a safety constraint.

Together, these changes align the U-Boot driver logic with the Linux kernel
implementation and ensure correct voltage output.

Michael Trimarchi (2):
  power: regulator: pfuze100: support high voltage range bit
  power: regulator: pfuze100: Decouple hardware base voltage from DTS
    constraints

 drivers/power/regulator/pfuze100.c | 138 ++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 50 deletions(-)

-- 
2.51.0

