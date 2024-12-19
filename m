Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4E5E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 19:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C68A80317;
	Thu, 19 Dec 2024 20:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hZOIlEE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F25058022B; Thu, 19 Dec 2024 19:29:17 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9868021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a815ed5acfso3667975ab.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632953; x=1735237753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Io4/O3EA2wrAzVTobpQxkDRpy4UeGVoi2lu32+v6VL8=;
 b=hZOIlEE2XRBIFg3diMHf2+9eUQo8HKtYg5LNMegw+UOh5OUP/uC4URBFrEfP1duIlJ
 JJf0Ragz/gfu6TFglSunR5dj93IDXaGl44Th8lFDbCZEo7s0+fZbBGBCn2spLtkr30Yp
 O6dsNzFjCgKGfzIYxhZmj9K2/0lbIAvOD85gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632953; x=1735237753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Io4/O3EA2wrAzVTobpQxkDRpy4UeGVoi2lu32+v6VL8=;
 b=OD1A3s72sksgHPEoOxOJhedTjOqOmWs5mPKvO1snOrtPhYwpX8G67QeQ8kExdZ7TlF
 Xf9WWuMg9Lusa14pXGvKzmj7fDRamSzZn7Li4bFVu344G8mQUQH3b0g24zFdQo6+wMT9
 Xqn3QHWjP3bFkcnnIB6q9GnRNMvohiJo9WUUqazRmMnZi7S8C3o8y1ctUl6VjO0bWxWR
 MBgi4p7KiP8e+HpunKszdhlW0RPkMDedg4d1wXTaybZHoxIgTsMW5b57nyO3cgxCjKPC
 6SOhMDxiDVkwk0Ng7yoPUb3BZ8RAk5sYEqrmy/Y8IglhacA/Rq7age9+mnLA4AEQxk/U
 DC9w==
X-Gm-Message-State: AOJu0Yyd/5cQK/y/3l0Yb1kWGYLaObzLW9NKUXlM7E/k6L8TdOSi+mmO
 GZFmBfsh30triSTSNTrZ422ueI6+d2qUs/iYTN++wCm6SIbp2J3mkLnfwCe+E50tAO/SeLdR/xY
 =
X-Gm-Gg: ASbGnctUe4CRlYNatj+poA7XtSZHRATAXNuHAMDAkptlHJnohuHn8/5pdS2VnMy2wD0
 nKJ+NrxJQWzciCyXIdyB6iP7ye5x05HX+Rb8JepNrtfbMPnSAP6cnIFQ0w26bAA4qVc8VdhB4ab
 al/D66gNA7KzTlhhn5Fm4kC8a1vj0bNz7R+WPAJs9CVIA7PwdYJBJTPaKi/e3OsBe9MqRxYoxFC
 PU3B+134/85OzGkC9Ng9CxrwIvIygZ+BaOMJYhWDVp2FTvG6e/YAcXmeElcKW9LOkbEdeTDPp/a
 8ZpoiI9ln2o74wfwVA==
X-Google-Smtp-Source: AGHT+IGRHV9jmI5Rae08DV4x62Jv519YG1036YgVwgHZPakxnSFQ38VJ+Q7wRlmpiqmMMDEsstx6LQ==
X-Received: by 2002:a05:6e02:148d:b0:3bc:be0f:edcd with SMTP id
 e9e14a558f8ab-3c2d2d4f4a6mr842655ab.11.1734632953467; 
 Thu, 19 Dec 2024 10:29:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alex Shumsky <alexthreed@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Dragan Simic <dsimic@manjaro.org>,
 Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Joshua Watt <jpewhacker@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 00/19] vbe: Series part E
Date: Thu, 19 Dec 2024 11:28:48 -0700
Message-Id: <20241219182907.2609704-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Dec 2024 20:41:56 +0100
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


This includes various patches towards implementing the VBE abrec
bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
fatures are available in VPL.

Changes in v4:
- Add an option to avoid code bloat with rcar3_salvator-x for example

Changes in v3:
- Add new patch to avoid size growth in spl_mmc_find_device() debug
- Use strlcpy() instead of strncpy()
- Rebase to master

Changes in v2:
- Add field names into the message
- Fix 'depends on SPL' to depend on TPL
- Depend on TPL/VPL as well
- Drop patch 'serial: ns16550: Allow clocks to be missing'

Simon Glass (19):
  spl: mmc: Avoid size growth in spl_mmc_find_device() debug
  image: Add a prototype for fit_image_get_phase()
  boot: Allow FIT to fall back from best-match option
  bootstd: Avoid sprintf() in SPL when creating bootdevs
  boot: Respect the load_op in fit_image_load()
  malloc: Show amount of used space when memory runs out
  malloc: Provide a simple malloc for VPL
  Support setting a maximum size for the VPL image
  spl: Report a loader failure
  spl: Allow serial to be disabled in any XPL phase
  spl: Support a relocated stack in any XPL phase
  spl: Drop use of uintptr_t
  spl: Drop a duplicate variable in boot_from_devices()
  spl: Add some more debugging to load_simple_fit()
  spl: lib: Allow for decompression in any SPL build
  boot: Allow use of FIT in TPL and VPL
  lib: Allow crc8 in TPL and VPL
  boot: Imply CRC8 with VBE
  hash: Plumb crc8 into the hash functions

 boot/Kconfig                  | 71 ++++++++++++++++++++++++++++++++++-
 boot/bootdev-uclass.c         | 10 ++++-
 boot/image-fit.c              | 29 ++++++++------
 common/Kconfig                |  8 ++++
 common/hash.c                 |  8 ++++
 common/malloc_simple.c        |  3 +-
 common/spl/Kconfig.vpl        | 17 +++++++++
 common/spl/spl.c              | 15 +++++---
 common/spl/spl_atf.c          | 36 +++++++++---------
 common/spl/spl_fit.c          | 12 +++++-
 common/spl/spl_legacy.c       |  8 ++--
 common/spl/spl_mmc.c          |  6 ++-
 configs/sandbox_vpl_defconfig |  2 +
 include/image.h               | 16 +++++++-
 include/spl.h                 | 28 +++++++-------
 include/u-boot/crc.h          |  3 ++
 lib/Kconfig                   | 53 ++++++++++++++++++++++++++
 lib/Makefile                  | 12 +++---
 lib/crc8.c                    |  6 +++
 19 files changed, 275 insertions(+), 68 deletions(-)

-- 
2.34.1

