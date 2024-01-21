Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83715C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 15:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E148772A;
	Sun, 21 Jan 2024 16:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KfngtnSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DBDD87705; Sun, 21 Jan 2024 16:06:52 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B7B8772A
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 16:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6db9e52bbccso1052331b3a.3
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705849607; x=1706454407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9VKU8rp9f4KbLyQhZH/GNAL5wR1UmfInFgJAbXMThgs=;
 b=KfngtnSkMS1LC0Ib0Y0ieclPjKh5tav18s/MSI7UA+pM2umWNwxLVtU5PdWAnn7zMp
 o1QTGrmNZlP8H4kaxmaMqIw3uJ4YIYqC05j+PyGwaEVgwZrdVds/AZxdybJZ3TSAf6Ud
 5OX+tW3APqA3FRpjq2RrxL+1B0yfx2LNWug9RWsKFDZX67opZv4Vr+twtFMeiIzws33S
 Jzi/Dn9o6+wSodkece2AVDRpiwKC8Xs93FbVWFdA5s/YSap8kQjfa4PDFxrsVtoVPRZ+
 P7FU31ycCKefYm6mAa1yjx0m7jYt4vifBmgLtEvNUaG1efEPZJKxrG46JZokVMU8Fp6M
 iaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705849607; x=1706454407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9VKU8rp9f4KbLyQhZH/GNAL5wR1UmfInFgJAbXMThgs=;
 b=QZ0F/b59HhCtLEVa+FC8eXxbTgyp+qcIKalRZu83XLtjE3LsUXn6y9YTk9vrVTBeS3
 9LhGCpeBJg3c7xK7wtA9rCVZF3rT5n6Dt+N77H0A4qkC7zQBOw4p1D9q6hobW1lxRTXE
 PE6wL17D1DbHNIiAjzITjWo1q3PfaYVugID+xP/ZQtzVeOn5euzbXKQBJIuwVbfGo8Xw
 r+SbCJVY3AWmLZgPm8jdx+Fkgl2l1OdQNFiCXFWNMcIHFJv3F4vfQd68Qn47TTdROJKT
 rlx64+d54lhXvj9NB6yiW6oPBcutXUHfzdxlFZ2DjZH14AxSIjJImVzZicoyWLU0sXkW
 oZQg==
X-Gm-Message-State: AOJu0YxyhBsG87stPWaOYRWbRvyOe8IdRMgN4mKCfN5RpCpKrsy1UqAK
 2XXdXNwzRBF1pdJ9CP7VJF8BEgTKUCV3mv7hKqMbsRFyaQMsLI07mV7QBASRdR5eAabo
X-Google-Smtp-Source: AGHT+IHhGzYcedx/KsbvMOdxBIDGdjKUQAT4o1PS8JwEeSdke0M5SlPFmMXQPqE1sMt9Tb1xDWGp2w==
X-Received: by 2002:a17:902:b612:b0:1d7:1cbf:201a with SMTP id
 b18-20020a170902b61200b001d71cbf201amr1124279pls.84.1705849607099; 
 Sun, 21 Jan 2024 07:06:47 -0800 (PST)
Received: from localhost.localdomain ([218.73.27.11])
 by smtp.gmail.com with ESMTPSA id
 ke5-20020a170903340500b001d33e6521b9sm5942139plb.14.2024.01.21.07.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 07:06:46 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Fabio Estevam <festevam@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v3 0/3] riscv: sophgo: milkv_duo: add support for Milk-V Duo
 board
Date: Sun, 21 Jan 2024 23:05:12 +0800
Message-ID: <20240121150630.30588-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jan 2024 16:11:19 +0100
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

The Milk-V Duo board is built upon Sophgo's CV1800B SoC, featuring two
XuanTie C906 CPUs running at 1.0GHz and 700MHz, respectively.

This series introduces fundamental support for the Milk-V Duo board,
encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
operate in serial console mode.

Changes in v3:
- Swap patch 1 and 2 duo to dependency of defconfig and device tree
- Enable EFI loader
- Add brief description of the procedure to run u-boot-dtb.bin

Changes in v2:
- Fold the defconfig patch to first patch
- Remove unnecessary environment settings of consoledev and baudrate in
  config

Kongyang Liu (3):
  riscv: dts: sophgo: add basic device tree for Milk-V Duo board
  riscv: sophgo: milkv_duo: initial support added
  doc: sophgo: milkv_duo: document Milk-V Duo board

 arch/riscv/Kconfig                   |   4 +
 arch/riscv/dts/Makefile              |   1 +
 arch/riscv/dts/cv1800b-milkv-duo.dts |  38 +++++++++
 arch/riscv/dts/cv1800b.dtsi          | 123 +++++++++++++++++++++++++++
 board/sophgo/milkv_duo/Kconfig       |  28 ++++++
 board/sophgo/milkv_duo/MAINTAINERS   |   6 ++
 board/sophgo/milkv_duo/Makefile      |   5 ++
 board/sophgo/milkv_duo/board.c       |   9 ++
 configs/milkv_duo_defconfig          |  23 +++++
 doc/board/index.rst                  |   1 +
 doc/board/sophgo/index.rst           |   8 ++
 doc/board/sophgo/milkv_duo.rst       |  64 ++++++++++++++
 include/configs/milkv_duo.h          |  12 +++
 13 files changed, 322 insertions(+)
 create mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
 create mode 100644 arch/riscv/dts/cv1800b.dtsi
 create mode 100644 board/sophgo/milkv_duo/Kconfig
 create mode 100644 board/sophgo/milkv_duo/MAINTAINERS
 create mode 100644 board/sophgo/milkv_duo/Makefile
 create mode 100644 board/sophgo/milkv_duo/board.c
 create mode 100644 configs/milkv_duo_defconfig
 create mode 100644 doc/board/sophgo/index.rst
 create mode 100644 doc/board/sophgo/milkv_duo.rst
 create mode 100644 include/configs/milkv_duo.h

-- 
2.41.0

