Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299BFD216BF
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B698882BE;
	Tue, 15 Oct 2024 16:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gMjaFbWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F7888387; Tue, 15 Oct 2024 15:33:10 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C19598811C
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-8354851fcabso222445139f.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728999187; x=1729603987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MisQU+4fwHg6xVdYTM+lLkHhwIgxLtj7fCDr1EKI3ls=;
 b=gMjaFbWuNCth0NBSLMyLIEbCsniHt4KDfuauGkYxbAIAMIjWfWjMp3LHouKtMNMkxh
 FqIClwdedk72Lo+RIbBwCwoj2GvJMlGQxJdGJeKI9rd6l0VwxRXMyb3xpZZbbtabOYvZ
 lEdspz/35U9x7upsQ8NIFdGYNvBUr55LLou6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999187; x=1729603987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MisQU+4fwHg6xVdYTM+lLkHhwIgxLtj7fCDr1EKI3ls=;
 b=WX+peRLZH5XFdVxT4o8GlwGLXVCfTzm2m32+B74kMuREuEHkwns3TBoYTkNuf8Rx78
 QYCANPokqMrIILm3GaSUvD3KPuV0YFYxkEWPHf1jmDYPd+1/f2EMuGGs9nLIT9Cb75Uu
 odTQaYGe4BxfXsIlOiQmBvqfpYlkDRx9Fc84yGhKT1LMEkg0np62t64hjDiwAKwkbKeh
 +WSiI1ARNW3fLP6roOqPbFXB0ivGvmCNL5/I78znE8ds1g06JEyogYLN5v+eR83b9BnZ
 8ZPGO3DlBP9FR2IEqR9d3bYo23WVnVHd9J9E428qj2HyfugKb1uUYp6ZTwMt9nZ0/Pl/
 Nv0Q==
X-Gm-Message-State: AOJu0Yzs8znmkHA+nVP9ui+IxL1omRdIrgPc8j/BYJGm5NQheBV0nvMz
 JZ8KQGU3dNptarqy40p4pajLgTlaGq/vQczo54Oj0uURGe3Q52poOexmXVj1moTV096038pwmwP
 0Fg==
X-Google-Smtp-Source: AGHT+IHmiRiVOAVV8Itmo8I7s2gT78j4jwshyJhWtRTSCcZmJXT4mwndQsttY/YyiitXohDkJpdSYA==
X-Received: by 2002:a05:6602:6410:b0:837:2815:825b with SMTP id
 ca18e2360f4ac-8379531ce60mr1221460339f.16.1728999187373; 
 Tue, 15 Oct 2024 06:33:07 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83a8b28bed6sm29794939f.8.2024.10.15.06.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:33:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Andrew Davis <afd@ti.com>,
 Artur Rojek <artur@conclusive.pl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Eddie James <eajames@linux.ibm.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nishanth Menon <nm@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v3 0/7] Allow showing the memory map
Date: Tue, 15 Oct 2024 07:32:57 -0600
Message-Id: <20241015133304.2874735-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Oct 2024 16:58:22 +0200
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

Changes in v3:
- Add a new Kconfig for the extra functionality

Changes in v2:
- Split into its own patch
- Modify the existing 'meminfo' command instead

Simon Glass (7):
  common: Fix up malloc() comment in reserve_noncached()
  common: Tidy up how malloc() is inited
  am65x: Use map_to_sysmem() to convert from pointer
  global_data: Add some more accessors
  bootstage: Allow counting memory without strings
  cmd: Move meminfo command into its own file
  cmd: Update the meminfo command to show the memory map

 arch/arm/mach-k3/am65x/am654_init.c |  11 +--
 cmd/Kconfig                         |  12 +++
 cmd/Makefile                        |   1 +
 cmd/mem.c                           |  19 -----
 cmd/meminfo.c                       |  75 ++++++++++++++++
 common/board_f.c                    |   8 +-
 common/board_r.c                    |   3 +-
 common/bootstage.c                  |  16 ++--
 common/dlmalloc.c                   |   8 +-
 common/spl/spl.c                    |   4 +-
 doc/usage/cmd/meminfo.rst           | 128 ++++++++++++++++++++++++++++
 doc/usage/index.rst                 |   1 +
 include/asm-generic/global_data.h   |  30 +++++++
 include/bootstage.h                 |   5 +-
 include/malloc.h                    |   8 ++
 test/cmd/Makefile                   |   3 +-
 test/cmd/meminfo.c                  |  38 +++++++++
 17 files changed, 324 insertions(+), 46 deletions(-)
 create mode 100644 cmd/meminfo.c
 create mode 100644 doc/usage/cmd/meminfo.rst
 create mode 100644 test/cmd/meminfo.c

-- 
2.34.1

