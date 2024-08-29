Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926A3C87FCE
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 18:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E5588D02;
	Thu, 29 Aug 2024 20:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KJ+zshaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6A488C4F; Thu, 29 Aug 2024 16:58:20 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E71B88C35
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-82a151a65b8so34281339f.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943495; x=1725548295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oBOnwFnvgByj4zAFBrF9u3buDAhEQdeEj4ZJ42wYBaA=;
 b=KJ+zshaa3WX8txMlqns0WQaxtDaIKqL63yuSx5rkTMfOnAA72c4teBBk100iwx9RTr
 48FiMSgs70R9vwWF0UmS0EcgS84w0knAHelIzTsNGGjmz6f91QlzK1lgtsDU29NbUtQj
 fD8a/kT1D0/uTe5FQ2xgy/6SBwNMVpF/MazVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943495; x=1725548295;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oBOnwFnvgByj4zAFBrF9u3buDAhEQdeEj4ZJ42wYBaA=;
 b=b/zO4tNe/ePHR9SwOiulkJYFI1SZMG/t2QUNcCxQjrLY7kn5XrQkiiJDHWnmESDYkm
 +byITOVB7lQH3fuG8EW4aqHDf18bAyAlL528IhQ1wKKJy2DL2DR0XcaXDHXCOVvG6GHB
 JZ0GVNHmlo0NQzPYdmvRZI2Zd5O7/XM0wIfWW2GX78fbB6bBi4Uow4ZixM0vQtckaRkW
 K7Dh92VfsDGAJnqGKpU/dU339YzBI7xZMHlysv6fHoFwVyyeHQmFrD8PbQtnY0SIvBS2
 uNP3yRDotzxyUOkKLPqRip/gpBdWHWqeaZwtLNNVIQrHjFfiyd0VFuMU4H0hNQzet+5N
 91tw==
X-Gm-Message-State: AOJu0YxPJVI0RX2/SrLaA2Na3RQvsbExg12TFhZiiKWrlwZXXqvJYKLk
 C961tQ2PJfQYsNiWNOw6hdd9tGhJ8QowXBaKgezz6SVBkvA/60W/nNgq2yWqaRXIk5z/SpxnWVg
 =
X-Google-Smtp-Source: AGHT+IEV8m6Riij73qxESq6lCcxniy0DPuy7kyQWbqjtWxTm/duZCsZxGmx8lGyzSpiVDnrCAnNrvg==
X-Received: by 2002:a05:6e02:1cad:b0:398:16d1:6127 with SMTP id
 e9e14a558f8ab-39f37867c14mr37900275ab.21.1724943494733; 
 Thu, 29 Aug 2024 07:58:14 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Eddie James <eajames@linux.ibm.com>, Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 00/19] vbe: Series part E
Date: Thu, 29 Aug 2024 08:57:43 -0600
Message-Id: <20240829145802.1827952-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Aug 2024 20:23:46 +0200
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


Simon Glass (19):
  image: Add a prototype for fit_image_get_phase()
  serial: ns16550: Allow clocks to be missing
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
 boot/Makefile                 |  4 +-
 boot/bootdev-uclass.c         | 10 ++++-
 boot/image-fit.c              | 29 ++++++++------
 common/hash.c                 |  8 ++++
 common/malloc_simple.c        |  3 +-
 common/spl/Kconfig.vpl        | 17 +++++++++
 common/spl/spl.c              | 15 +++++---
 common/spl/spl_atf.c          | 36 +++++++++---------
 common/spl/spl_fit.c          | 12 +++++-
 common/spl/spl_legacy.c       |  8 ++--
 configs/sandbox_vpl_defconfig |  3 +-
 drivers/serial/ns16550.c      |  2 +-
 include/image.h               | 16 +++++++-
 include/spl.h                 | 28 +++++++-------
 include/u-boot/crc.h          |  3 ++
 lib/Kconfig                   | 53 ++++++++++++++++++++++++++
 lib/Makefile                  |  8 ++--
 lib/crc8.c                    |  6 +++
 19 files changed, 263 insertions(+), 69 deletions(-)

-- 
2.34.1

