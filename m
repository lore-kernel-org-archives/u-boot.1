Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04655D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6319A893E4;
	Fri, 11 Oct 2024 23:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RE6HM9+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B9E8939B; Fri, 11 Oct 2024 23:40:39 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DFC8939B
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a3a7d5a156so9337265ab.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728682835; x=1729287635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TxBb80cSKDgl1xaduxfmBvIvnrDlHCXS+nbwPN14dWs=;
 b=RE6HM9+UkDW0fAGp7oP8jcYx4TXjAMXvSMJMP7xi/n/Vaa5wGQeDCA4YHYv2NE/5P4
 nDV77lk5ce0qz9ruSfUcButehpjx8LQ0aMsMDolzgDu3Q45dbOsP+vWGBFPobL2P8her
 4jXCSJvc/8olmc4L3h2NHV7aBRCG/J1AyMRIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728682835; x=1729287635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TxBb80cSKDgl1xaduxfmBvIvnrDlHCXS+nbwPN14dWs=;
 b=v0Tq4QcK9VHr2Pec1UulnVFxUOBQQeWfpn3Thsk99U4xp/G+geg/yk+cAQrxVYscwE
 qlQ864Ur8lZpYilNNim2RPdDPlFI9zS2a5hwOP4mhHBVwT7zT7vah9evkDw4UE+huUTZ
 Jaxl/kphAQY08bWdLHWw/gE2FldBBwmui3qwGfAll0821+IF+a8/aM69Y87kgwOLbaDV
 aPzNTy9p7aU9QK9lAX4VAc6+zqa+EHJ+A90zw91b64FfaywXmtAT3R7wAinnhVUyD7qX
 67biGD3Zg6drskhjdOucAWITd8YIu90qL1kSIO3NxXdHlB6T1kbeLc9kH9ioZO2QCcBC
 FX+Q==
X-Gm-Message-State: AOJu0Yx8j1Jp9CttVhDFTYQLTugRPHaB3KcJkUmYdlA6ETu0hayO2M4F
 w7Rg46cdXBwttmk87bhfscvlOFmaGRh2BT6oRLS8K8MwUrJ5XvSaBV9JyvQDGX6ld/MNi5Ry71T
 CXw==
X-Google-Smtp-Source: AGHT+IEdQTBPk9KztTmudt4PpBWuwGNu2ddmYyS168FRDOnHv5UdLAlXUfeH08eVfbCJJzKSY9zPBg==
X-Received: by 2002:a05:6e02:3cc2:b0:3a3:a307:6851 with SMTP id
 e9e14a558f8ab-3a3bce0858dmr6384025ab.22.1728682835322; 
 Fri, 11 Oct 2024 14:40:35 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a3afdae0f1sm8830475ab.11.2024.10.11.14.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:40:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/7] Allow showing the memory map
Date: Fri, 11 Oct 2024 15:40:24 -0600
Message-Id: <20241011214032.760072-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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
 cmd/Kconfig                         |   1 +
 cmd/Makefile                        |   1 +
 cmd/mem.c                           |  19 -----
 cmd/meminfo.c                       |  72 ++++++++++++++++
 common/board_f.c                    |   8 +-
 common/board_r.c                    |   3 +-
 common/bootstage.c                  |  16 ++--
 common/dlmalloc.c                   |   8 +-
 common/spl/spl.c                    |   4 +-
 doc/usage/cmd/meminfo.rst           | 126 ++++++++++++++++++++++++++++
 doc/usage/index.rst                 |   1 +
 include/asm-generic/global_data.h   |  30 +++++++
 include/bootstage.h                 |   5 +-
 include/malloc.h                    |   8 ++
 test/cmd/Makefile                   |   3 +-
 test/cmd/meminfo.c                  |  38 +++++++++
 17 files changed, 308 insertions(+), 46 deletions(-)
 create mode 100644 cmd/meminfo.c
 create mode 100644 doc/usage/cmd/meminfo.rst
 create mode 100644 test/cmd/meminfo.c

-- 
2.34.1

