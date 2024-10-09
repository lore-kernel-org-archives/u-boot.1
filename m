Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB6BCF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E001F88FE1;
	Wed,  9 Oct 2024 03:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P7LP5tOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC3F88FE1; Wed,  9 Oct 2024 03:50:30 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FDF88F4B
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a2761f1227so21776465ab.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438627; x=1729043427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0xg3SvAjxl9c72FE84Z8FFdcNYwxEbk/XBy0TOFSjsg=;
 b=P7LP5tOrDo5X5RBudZHvpatI9NBwnfoCGSS8hEGHofhBV8iaB8eF9rLct3moAvh2ug
 V/lamk5QC9tpeE/vgs/fEPoHm0zA2eDyyd9aLjvVNEzhPJC001t3DHeZxLbBOEEm1Vce
 Orhh4sWQHapEAdFjAYUaBw9vizL3IScc5Wbu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438627; x=1729043427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0xg3SvAjxl9c72FE84Z8FFdcNYwxEbk/XBy0TOFSjsg=;
 b=qhIap29EduTiPw023UZdCoT44IKrGGPUvBIFADCUd/hVWw49IyBKuia/yojJbSEVus
 RgAPsFiohU6OIJJPvJcp21R8Wor89Ycjn2/PWupP2om9m+E1r2I2kky3icp4XN35r60l
 8pec+6BlNEA6cPxenCCzdbjbX87B/Lt1yB12SDQ/nTvA2S0H1UGa+7o9g3jgEkwxJXwY
 SI5ERBXPb4Lv+0tvmhliVmbHa/OA9hSOMzQvkglZC9gz3VNHmYsg9Z8EmGOBrPkjDOsY
 wpDRg7MWz8KbSLpEMJtyjy4bv1jVerrFkczAl2BCaM5i54kSHuaztL2sjgoDXinr/WE9
 xcMw==
X-Gm-Message-State: AOJu0YxBXYefXMwI5rtavWKW4jfeI9aORTpHbe70bu76dTQh8NKBLokf
 gz6uGa7AJVE1Y5OThdT2dhviEKRxthBLf3o5+BMpEQ58anX7WNS6xPnmyOgV8glZ6ddTNGo+YHX
 9PA==
X-Google-Smtp-Source: AGHT+IFumcq9tMc183erPaYLwG4eFeD4I7aKYFS717yHMJvV9dG/YOw2u0VEmr9jNInu6VNuLpyuRQ==
X-Received: by 2002:a05:6e02:1561:b0:3a3:4175:79d2 with SMTP id
 e9e14a558f8ab-3a397cf240bmr9313065ab.14.1728438627215; 
 Tue, 08 Oct 2024 18:50:27 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a868967sm20677585ab.67.2024.10.08.18.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 18:50:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Andrew Davis <afd@ti.com>,
 Artur Rojek <artur@conclusive.pl>, Devarsh Thakkar <devarsht@ti.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Jonas Karlman <jonas@kwiboo.se>,
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
Subject: [PATCH 0/6] Allow showing the memory map
Date: Tue,  8 Oct 2024 19:50:12 -0600
Message-ID: <20241009015020.25817-1-sjg@chromium.org>
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


Simon Glass (6):
  common: Fix up malloc() comment in reserve_noncached()
  common: Tidy up how malloc() is inited
  am65x: Use map_to_sysmem() to convert from pointer
  global_data: Add some more accessors
  bootstage: Allow counting memory without strings
  cmd: Add a command to show the memory map

 arch/arm/mach-k3/am65x/am654_init.c |  11 +--
 cmd/Kconfig                         |  10 +++
 cmd/Makefile                        |   1 +
 cmd/memmap.c                        |  66 +++++++++++++++
 common/board_f.c                    |   8 +-
 common/board_r.c                    |   3 +-
 common/bootstage.c                  |  16 ++--
 common/dlmalloc.c                   |   8 +-
 common/spl/spl.c                    |   4 +-
 doc/usage/cmd/memmap.rst            | 123 ++++++++++++++++++++++++++++
 doc/usage/index.rst                 |   1 +
 include/asm-generic/global_data.h   |  30 +++++++
 include/bootstage.h                 |   5 +-
 include/malloc.h                    |   8 ++
 test/cmd/Makefile                   |   3 +-
 test/cmd/memmap.c                   |  35 ++++++++
 16 files changed, 305 insertions(+), 27 deletions(-)
 create mode 100644 cmd/memmap.c
 create mode 100644 doc/usage/cmd/memmap.rst
 create mode 100644 test/cmd/memmap.c

-- 
2.43.0

