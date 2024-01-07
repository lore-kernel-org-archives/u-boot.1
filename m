Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B700CC47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 12:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1919D876E4;
	Sun,  7 Jan 2024 13:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H7LaS2mR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0BA87463; Sun,  7 Jan 2024 12:27:47 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BFB87A0D
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 12:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6dbb7d80df8so806918a34.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 03:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704626864; x=1705231664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=olePy2yX8zHrx2BzFMR0pIdMtPLcXfnrTuUUBTAchmk=;
 b=H7LaS2mR4C9wSYAYJ7W2XIfv8jMSGo6BJaDHZHh3bMOFjzE5eeJ9sv1Hm5N2XABcZR
 Gg0+upJrM0ND7z3qoLopqsuvRyOnsLvm+y19QErqyBrfQjsic+p0ieB970nCJukZIZQL
 /NLQjtssURm6wKflMJFqIupUUf5wr+tS3WZhl6RQQdggQKREIUqgrItjBEqwlGPO0bIx
 SYkESBTATwNfZ1d7TEhvj/dnESTSY80QuBlzdQ3nyhTGjymTcu3kZzQUVfgcO599mLbX
 FAF0KR68AkxOLJ2daM46rh72v+wUs3Q9RPtcYFaEPwTaEn1eUBV8DgaL4xCyJ3IhCMwJ
 lZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704626864; x=1705231664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=olePy2yX8zHrx2BzFMR0pIdMtPLcXfnrTuUUBTAchmk=;
 b=IBdihJ2Uu/pz8t8sQmwkqjXaSAi/1vQt/V2Mf7WNozzWLhN8ot6Khp7TGMR/dc7SBe
 esnjvvaQMc8i50WJWYhpbHAlH8OILM1io4fFPUHWSTmTUaL2sUhgi+wojlOIAJdbkAJj
 bN7cRGe9mgvv3h9DGoWbMGcAa/KFaOCpONGNtMemF7ia76IULyxC3wgojPb8C/pr73hQ
 qCHaRaSJtoCri8o7ZtL8h2jW1a3MHWm/aS4VhK7fX2ExRvijYlIuSeipwgVplrW7KWC/
 LcdpLu+1QryuEF6TyIVH7iJzJEh4FxHT5RDEidS8wN5uZJJsWlpbGohEzKKznOXOoBKg
 ghyg==
X-Gm-Message-State: AOJu0YwO0tZQHwNKZejasKWozV5Qlyuu8jxoFn1/DXjJMbQ2zkNCdtyI
 v3p6By/4fCOn9J52TptCUexvq+TJbfKkyhnTSgM=
X-Google-Smtp-Source: AGHT+IEPzfVWCh+Z8RLZp585eE4J9OerxEKfT6IJUFkMkZuunw3JvTeARov48j6Ipoj1zQKyQhdPvA==
X-Received: by 2002:a05:6358:9195:b0:175:6ffc:2cc0 with SMTP id
 j21-20020a056358919500b001756ffc2cc0mr1457837rwa.8.1704626863471; 
 Sun, 07 Jan 2024 03:27:43 -0800 (PST)
Received: from localhost.localdomain ([120.204.188.187])
 by smtp.gmail.com with ESMTPSA id
 sf15-20020a17090b51cf00b0028d435cc2cbsm1279253pjb.15.2024.01.07.03.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 03:27:42 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Fabio Estevam <festevam@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Wei Fu <wefu@redhat.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 0/4] riscv: sophgo: milkv_duo: add support for Milk-V Duo board
Date: Sun,  7 Jan 2024 19:27:06 +0800
Message-ID: <20240107112713.61966-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jan 2024 13:25:04 +0100
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


Kongyang Liu (4):
  riscv: sophgo: milkv_duo: initial support added
  riscv: dts: sophgo: Add basic device tree for Milk-V Duo board
  configs: milkv_duo_defconfig: Add initial config
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
 include/configs/milkv_duo.h          |  16 ++++
 13 files changed, 313 insertions(+)
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

