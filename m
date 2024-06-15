Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BF9C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 09:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E8387D1A;
	Sat, 15 Jun 2024 11:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IABIqcPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF1587D2F; Sat, 15 Jun 2024 11:20:26 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1BE87ABC
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 11:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so437269066b.2
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718443223; x=1719048023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5mg3jXSd9EnaIcWux3JAc87iOUYuQ64vJpe86IumEI=;
 b=IABIqcPsOTiYm8B8rfN6mqHCFgYeEIXRTG3HdQDR20rT304LIKp09zt2fxn4/XAq2G
 fPJJ57jFJkBdrKzXNtMV3Y9NbyoI9B/ZM+Ji0UgNzF0aSSAFuylV/qrjzzbrJYZqHCAJ
 UFQBJEWnqWoJmKRIER0NSSeUL2r4M+RTaxdQbD/IDTOC3q8IGHzjcldzm0R5uQ2dSj5n
 4U8t1z6cwHpmvsU2MPBGryNQou0s4YEUos1bo+2DtvqY+3q7kciSQnAfkh+EhUozmqjM
 fsqXKOfT4f/p3BCSoDRgmRg9yqaIPs3uS+ZFlq01K8EwxwZbHGO3SHbyKhvyIxLMtGUA
 SlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718443223; x=1719048023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5mg3jXSd9EnaIcWux3JAc87iOUYuQ64vJpe86IumEI=;
 b=afKH7TDB3w26HupDtLIhBuCJ5c5FwF427Y6l8Hilwgp2yBgqc2cfq6Z8j0TD5W0eMm
 pbJXZtrfmmFg9V3dbKxdEJsncNJ0pfYWX6IwR7OsAPnGr6rV+Sj39PqW/7h5SmKy7Iev
 YliOG5nyCaqnOxKHnTUdK0awhTUGWLj8Rpopws6Zt/hEN3FY9U5UeaQSiWWYbMnQOvJo
 iiqEuqzR9LlNCutABKfnIVkjCoRM0PFHKM1nrWFpbd12yWegSLu1a4SXu81aVlN0wWq6
 QYicEpnb3RWpOaq9W+K2roBafB9l8PAx8WOrZpDcIO6sgoL6SzOJvJZZenNDN4425mmh
 2/vA==
X-Gm-Message-State: AOJu0YyTYp3hGgl6N17iyjcS2Z9r8VfoqWf6GH+H9jHh/e6HatPAwJVc
 wQQ54yezBXLpfc6i0Wh9L1SuVVC2eF2GJIBAsoKnX+psJi/tMe/t
X-Google-Smtp-Source: AGHT+IGvoBY2Zk/x/yKsXhid83MMq1H8DeFSsSttXz1FzPYPQMB2trB6SklMggz31okbyLuIjPrEKg==
X-Received: by 2002:a17:907:3f03:b0:a6f:5fe2:56e9 with SMTP id
 a640c23a62f3a-a6f60d2b9a7mr413371566b.17.1718443223341; 
 Sat, 15 Jun 2024 02:20:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f63f7e9d8sm172367066b.182.2024.06.15.02.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 02:20:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Initial support for new Tegra 2/3 devices
Date: Sat, 15 Jun 2024 12:19:42 +0300
Message-ID: <20240615091950.239610-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Patchset includes initial support bringup for 4 new Tegra 2 and
Tegra 3 devices which include Asus Transformers with Tegra 2,
Microfost Surface RT, Lenovo Ideapad Yoga 11 and Wexler Tab 7t.
All setups are tested on real hardware and pass buildman.

Jonas Schwöbel (2):
  board: microsoft: surface-rt: add Microsoft Surface RT support
  board: lenovo: ideapad-yoga-11: Lenovo Ideapad Yoga 11

Svyatoslav Ryhel (2):
  board: asus: transformer: add ASUS Transformer T20 family support
  board: wexler: qc750: add WEXLER Tab 7t support

 arch/arm/dts/Makefile                         |    9 +-
 arch/arm/dts/tegra20-asus-sl101.dts           |    9 +
 arch/arm/dts/tegra20-asus-tf101.dts           |    9 +
 arch/arm/dts/tegra20-asus-tf101g.dts          |    9 +
 arch/arm/dts/tegra20-asus-transformer.dtsi    |  545 +++++++
 .../dts/tegra30-lenovo-ideapad-yoga-11.dts    | 1266 +++++++++++++++++
 arch/arm/dts/tegra30-microsoft-surface-rt.dts | 1083 ++++++++++++++
 arch/arm/dts/tegra30-wexler-qc750.dts         | 1106 ++++++++++++++
 arch/arm/mach-tegra/tegra20/Kconfig           |    5 +
 arch/arm/mach-tegra/tegra30/Kconfig           |   15 +
 board/asus/transformer-t20/Kconfig            |   12 +
 board/asus/transformer-t20/MAINTAINERS        |    8 +
 board/asus/transformer-t20/Makefile           |    9 +
 .../asus/transformer-t20/configs/sl101.config |    1 +
 .../asus/transformer-t20/configs/tf101.config |    1 +
 .../transformer-t20/configs/tf101g.config     |    1 +
 board/asus/transformer-t20/transformer-t20.c  |   57 +
 board/lenovo/ideapad-yoga-11/Kconfig          |   12 +
 board/lenovo/ideapad-yoga-11/MAINTAINERS      |    7 +
 board/lenovo/ideapad-yoga-11/Makefile         |    6 +
 .../ideapad-yoga-11/ideapad-yoga-11-spl.c     |   41 +
 board/microsoft/surface-rt/Kconfig            |   12 +
 board/microsoft/surface-rt/MAINTAINERS        |    7 +
 board/microsoft/surface-rt/Makefile           |    6 +
 board/microsoft/surface-rt/surface-rt-spl.c   |   41 +
 board/wexler/qc750/Kconfig                    |   12 +
 board/wexler/qc750/MAINTAINERS                |    7 +
 board/wexler/qc750/Makefile                   |   11 +
 board/wexler/qc750/qc750-spl.c                |   45 +
 board/wexler/qc750/qc750.c                    |   21 +
 configs/ideapad-yoga-11_defconfig             |   84 ++
 configs/qc750_defconfig                       |   81 ++
 configs/surface-rt_defconfig                  |   80 ++
 configs/transformer_t20_defconfig             |   82 ++
 doc/board/asus/index.rst                      |    1 +
 doc/board/asus/transformer_t20.rst            |  129 ++
 doc/board/index.rst                           |    3 +
 doc/board/lenovo/ideapad-yoga-11.rst          |   41 +
 doc/board/lenovo/index.rst                    |    9 +
 doc/board/microsoft/index.rst                 |    9 +
 doc/board/microsoft/surface-rt.rst            |   41 +
 doc/board/wexler/index.rst                    |    9 +
 doc/board/wexler/qc750.rst                    |  125 ++
 include/configs/ideapad-yoga-11.h             |   79 +
 include/configs/qc750.h                       |   67 +
 include/configs/surface-rt.h                  |   41 +
 include/configs/transformer-t20.h             |   23 +
 47 files changed, 5276 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/tegra20-asus-sl101.dts
 create mode 100644 arch/arm/dts/tegra20-asus-tf101.dts
 create mode 100644 arch/arm/dts/tegra20-asus-tf101g.dts
 create mode 100644 arch/arm/dts/tegra20-asus-transformer.dtsi
 create mode 100644 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
 create mode 100644 arch/arm/dts/tegra30-microsoft-surface-rt.dts
 create mode 100644 arch/arm/dts/tegra30-wexler-qc750.dts
 create mode 100644 board/asus/transformer-t20/Kconfig
 create mode 100644 board/asus/transformer-t20/MAINTAINERS
 create mode 100644 board/asus/transformer-t20/Makefile
 create mode 100644 board/asus/transformer-t20/configs/sl101.config
 create mode 100644 board/asus/transformer-t20/configs/tf101.config
 create mode 100644 board/asus/transformer-t20/configs/tf101g.config
 create mode 100644 board/asus/transformer-t20/transformer-t20.c
 create mode 100644 board/lenovo/ideapad-yoga-11/Kconfig
 create mode 100644 board/lenovo/ideapad-yoga-11/MAINTAINERS
 create mode 100644 board/lenovo/ideapad-yoga-11/Makefile
 create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11-spl.c
 create mode 100644 board/microsoft/surface-rt/Kconfig
 create mode 100644 board/microsoft/surface-rt/MAINTAINERS
 create mode 100644 board/microsoft/surface-rt/Makefile
 create mode 100644 board/microsoft/surface-rt/surface-rt-spl.c
 create mode 100644 board/wexler/qc750/Kconfig
 create mode 100644 board/wexler/qc750/MAINTAINERS
 create mode 100644 board/wexler/qc750/Makefile
 create mode 100644 board/wexler/qc750/qc750-spl.c
 create mode 100644 board/wexler/qc750/qc750.c
 create mode 100644 configs/ideapad-yoga-11_defconfig
 create mode 100644 configs/qc750_defconfig
 create mode 100644 configs/surface-rt_defconfig
 create mode 100644 configs/transformer_t20_defconfig
 create mode 100644 doc/board/asus/transformer_t20.rst
 create mode 100644 doc/board/lenovo/ideapad-yoga-11.rst
 create mode 100644 doc/board/lenovo/index.rst
 create mode 100644 doc/board/microsoft/index.rst
 create mode 100644 doc/board/microsoft/surface-rt.rst
 create mode 100644 doc/board/wexler/index.rst
 create mode 100644 doc/board/wexler/qc750.rst
 create mode 100644 include/configs/ideapad-yoga-11.h
 create mode 100644 include/configs/qc750.h
 create mode 100644 include/configs/surface-rt.h
 create mode 100644 include/configs/transformer-t20.h

-- 
2.43.0

