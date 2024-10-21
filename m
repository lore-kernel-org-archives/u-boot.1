Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2B3D0E6C9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C9E89309;
	Mon, 21 Oct 2024 10:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m/0b89EK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C303A89309; Mon, 21 Oct 2024 10:19:40 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15978897F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb5fa911aaso60308171fa.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729498778; x=1730103578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t6dXu+Zz7E+F8GHblQVdbuOlx/Zz6sShAkVRbwOIr0g=;
 b=m/0b89EKNtHTtqGLw2yr0IQJEcmeWEQRW5vjYOacBvnBg5m2XWejhTRetVAln/Ys1j
 0j+0zhpuhQVXyxBhCYyksdrMOgUWbEkkN3aOa6t4cNf+m2cHvrJKs+XxTh1dsx7BToFB
 P41zuhZSo09/XlCeeOeVe+lqiVRVR20Yx2uFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498778; x=1730103578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6dXu+Zz7E+F8GHblQVdbuOlx/Zz6sShAkVRbwOIr0g=;
 b=XP5bdhmaaB2g4jaVpaHUwhX5ui4a1WQUrVulnFjP+Q4nk/anrcpIzJTgBv0mO8y4z3
 U7LhW4NA472HBPDIC3pDmmOmaE6xToq5R4aOb9iWa8T4PVKYZKj4AzwCsN6alPT7v92z
 h5Vecumpb0arOqLkPbPIhG18qI5AXPuYMtkUF+TOWLF1mnkj7NJw54382Mo5dMwWslaB
 /PB21cI5huR5XeiSas7hvDikkazySQlZUrGJcDSZBDW9cxe/7sl4il/VoGe2pExg9YXd
 QvtCyar/2H2rBap6CNY4jkGByiUVdaP1zLOlooybFaav0YGuZbnzt1lkNcW92m70q3Ck
 TM1w==
X-Gm-Message-State: AOJu0YwealrbPT2OWOpYoV3rbON7bDZYB8oeGXK6v2OJ2fW6ejLfX5Ls
 T/oOJoPJNKkOpNpNTK9cNtxGn+Iqwu4V+/ZFfEC9ArTdlwYUq1YyflkAxOqENtqqDwggEAvoOxC
 yukmw
X-Google-Smtp-Source: AGHT+IEXYEeA+1yGaNlygeJvy+uEk9scdyXmCgcKEztQeMTy/EHpPii18Sbs7j61BmI1m8gUMtaG0w==
X-Received: by 2002:a2e:bea2:0:b0:2fa:c5d9:105b with SMTP id
 38308e7fff4ca-2fb82e90ce0mr71609991fa.2.1729498777780; 
 Mon, 21 Oct 2024 01:19:37 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm176057766b.73.2024.10.21.01.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:19:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Artur Rojek <artur@conclusive.pl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v4 0/8] Allow showing the memory map
Date: Mon, 21 Oct 2024 10:19:24 +0200
Message-ID: <20241021081934.289473-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

This little series adds a new 'memmap' command, intended to show the
layout of memory within U-Boot and how much memory is available for
loading images.

Changes in v4:
- Drop am65x patch as it is not needed
- Add patch to export the lmb data structure
- Add new patch to show the lmb records

Changes in v3:
- Add a new Kconfig for the extra functionality

Changes in v2:
- Split into its own patch
- Modify the existing 'meminfo' command instead

Simon Glass (8):
  common: Fix up malloc() comment in reserve_noncached()
  common: Tidy up how malloc() is inited
  global_data: Add some more accessors
  bootstage: Allow counting memory without strings
  cmd: Move meminfo command into its own file
  cmd: Update the meminfo command to show the memory map
  lmb: Export the lmb data structure
  meminfo: Show the lmb records

 cmd/Kconfig                       |  12 +++
 cmd/Makefile                      |   1 +
 cmd/mem.c                         |  19 -----
 cmd/meminfo.c                     |  99 +++++++++++++++++++++++
 common/board_f.c                  |   8 +-
 common/board_r.c                  |   3 +-
 common/bootstage.c                |  16 ++--
 common/dlmalloc.c                 |   8 +-
 common/spl/spl.c                  |   4 +-
 doc/usage/cmd/meminfo.rst         | 128 ++++++++++++++++++++++++++++++
 doc/usage/index.rst               |   1 +
 include/asm-generic/global_data.h |  30 +++++++
 include/bootstage.h               |   5 +-
 include/malloc.h                  |   8 ++
 lib/lmb.c                         |   2 +-
 test/cmd/Makefile                 |   3 +-
 test/cmd/meminfo.c                |  42 ++++++++++
 17 files changed, 347 insertions(+), 42 deletions(-)
 create mode 100644 cmd/meminfo.c
 create mode 100644 doc/usage/cmd/meminfo.rst
 create mode 100644 test/cmd/meminfo.c

-- 
2.43.0

