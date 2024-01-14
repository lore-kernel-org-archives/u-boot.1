Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9DBC47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 18:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A545E87988;
	Sun, 14 Jan 2024 19:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k4FzEwzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F003A8796B; Sun, 14 Jan 2024 19:08:04 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD33D8773F
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 19:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso5352529b3a.1
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 10:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705255680; x=1705860480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S6zQKDG6XA5G1bB8RCytY983T5/07DGTGQkM1FKIh90=;
 b=k4FzEwzjG6lu3/K2WlgdKgNhMOdlc5XbueaWz1jzSFXCqmpP6k9RmnpdcArTKDbELZ
 l18dRUfVCDgFCZKK/ciirTh8q/0rcBO3tRj3IeQ0Te+03Cgd1dIktrktZZK0oE6EV2gm
 W7oC1eksvJmw+2nW5j4jSsGec8Fl+UPXGOID0hukTxTBhV/I9nEsA/tZjHFIAWW5lMVj
 qKqYhEKOBUti77hdv/T3O3vTRMzvCeayGZQsvlFnqTRooIJTdlkSlQTB+0+V7N79PXVp
 sKMXcxUDoqNVJfoy/ASl/mipj1kZeHMIVX3LhWDIjcmmW9763GaZPs3FQi8irHWf+Nmj
 GnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705255680; x=1705860480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S6zQKDG6XA5G1bB8RCytY983T5/07DGTGQkM1FKIh90=;
 b=diWcovKCy/QjCgxeVM/DKqdgmXJxMHbzr4+pft649wtfFI+VymilnsIdLXHLeVLxee
 EGtSKJlv50BiGew/woYgCcaj9R5X0pE1jyN78yzwTJwBBFQ/EUgApxWAPl5WF0PbnvV0
 dh3DdE5ZvJeEnrXbN7cmbgNeNpGWes234b6x/WK0qOXllWgVaqSmchaSGM+3Y6o8CYcP
 qt9KFStBY4bdCwZt8LX/7fGWZGaM0+82cuq1rtAgDUnpgokWmOFYsmeVbIHeoKL0sv4y
 h+HWmBpAkXnCszi0zkfCIOclkXL08aXpxb1LRBLtoCVMYoY+uWx3qL19zrSTUlAKJc9P
 wd5g==
X-Gm-Message-State: AOJu0YyUa6FyGWwXFJwOLPNIhTqDUT8jckAoVNXflvg+gWxciBN+PJV3
 fnYUtRUbZrw/+9qfXtbD4Cx4GpKXDQzEEXef7dI=
X-Google-Smtp-Source: AGHT+IFaILL3Lvc80PDMSsov3Is2d/EQovZYMPvRKAM7lHLC3tfv+qaVAJ2dJRTemX9nwKERnyU74Q==
X-Received: by 2002:a05:6a20:bd1a:b0:19a:80b4:5acd with SMTP id
 fy26-20020a056a20bd1a00b0019a80b45acdmr4590344pzb.53.1705255680232; 
 Sun, 14 Jan 2024 10:08:00 -0800 (PST)
Received: from localhost.localdomain ([120.204.188.187])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a056a00088d00b006d998f5b890sm6253657pfj.192.2024.01.14.10.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 10:07:59 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng@tinylab.org>, Chris Morgan <macromorgan@hotmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Wei Fu <wefu@redhat.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 0/3] riscv: sophgo: milkv_duo: add support for Milk-V Duo
 board
Date: Mon, 15 Jan 2024 02:07:36 +0800
Message-ID: <20240114180741.2114-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Jan 2024 19:08:45 +0100
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

Changes in v2:
- Fold the defconfig patch to first patch
- Remove unnecessary environment settings of consoledev and baudrate in
config

Kongyang Liu (3):
  riscv: sophgo: milkv_duo: initial support added
  riscv: dts: sophgo: Add basic device tree for Milk-V Duo board
  doc: sophgo: milkv_duo: document Milk-V Duo board

 arch/riscv/Kconfig                   |   4 +
 arch/riscv/dts/Makefile              |   1 +
 arch/riscv/dts/cv1800b-milkv-duo.dts |  38 +++++++++
 arch/riscv/dts/cv1800b.dtsi          | 123 +++++++++++++++++++++++++++
 board/sophgo/milkv_duo/Kconfig       |  28 ++++++
 board/sophgo/milkv_duo/MAINTAINERS   |   6 ++
 board/sophgo/milkv_duo/Makefile      |   5 ++
 board/sophgo/milkv_duo/board.c       |   9 ++
 configs/milkv_duo_defconfig          |  24 ++++++
 doc/board/index.rst                  |   1 +
 doc/board/sophgo/index.rst           |   8 ++
 doc/board/sophgo/milkv_duo.rst       |  50 +++++++++++
 include/configs/milkv_duo.h          |  12 +++
 13 files changed, 309 insertions(+)
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

