Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C36C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 11:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD968832D;
	Tue, 18 Jun 2024 13:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mu3/o2uC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD5588315; Tue, 18 Jun 2024 13:50:18 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54BD8824C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 13:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so807234066b.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718711416; x=1719316216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O2vlhq2/WAUnuu8IFc6lf1D8bi2+kiVvbYVHVdCRCqU=;
 b=mu3/o2uCz+rZ2RHTiBiRs3NERH29IJSVSaT+d/wR2uGl812YWH/Mqe/WOzb4GvOq9R
 142C3ZJaFTPnF9yF5w+4zk4wFjL6VSOkeiEp+uCqbc9QGGtBwc0PvdnWSfqojdBilkPk
 Z/LQeok85lwI9haTYHnzu5YX6gG9UFTpL8lGTZ/m0CNzY3b7yx2z4ElJsK6AFGvpDxhv
 QShcnmUZkchfeKSAsSznIZ11QBlyUikgY5WNns9CPPhVrIv7laI9X9FGFxgCjVmr9fpw
 ymQX+znAvXBxXtAp9ILOC5O/s2ASAvtozSpN0puA9yY1tWlknwM3L5SbXEpB8jk4YLt4
 245A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718711416; x=1719316216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O2vlhq2/WAUnuu8IFc6lf1D8bi2+kiVvbYVHVdCRCqU=;
 b=Lfb4vxDnmgxY5Ak9fQdMpOq7SYp39u3nGYhKq0LKX7bm6kA++f0dEqtVuY3JUjD4xA
 ZAT0bJsZ4ERk26eWuuOpp9x2cAEJ1m+9/co/A1tRWSogG8LNyQWh6qb8PK94c4UwX2Jq
 Pkm3vU9R7utDilmPibLbTvuztPbFDEZmQUYRO3CI1pnRv0ZMtUL2r1KdO6q1BWStmRUF
 5aGz6ZXBRzIgUG86EgWGblpQyn1tuiqcSeCaMJvBjpoyR+OMI7BodonUZDDagBTmvBEN
 DQ+sX6WQMmUmjkf/kUgc+zuORD8yX30kzgS/1t+/bpzVmfhyAEnO6WxguLgkvKrvVHZL
 XX2A==
X-Gm-Message-State: AOJu0Yze5BwrI/bZIdSvR8+fs7keZnc9foRVNvTd4d/PckbdI+WHVoO2
 7CwYvUR4xMhcbOylw4/C5l1yJLvkOKXyrWBn1zfePUjvTLWxmyu/
X-Google-Smtp-Source: AGHT+IFUL2LemkbbCtgLDClG73OHnk3P02wI3D6Xv8/UE8WDs3ojlbQeA8Geu7PRt8FMVNXxOmAIYw==
X-Received: by 2002:a17:906:6a02:b0:a6e:771a:2a8c with SMTP id
 a640c23a62f3a-a6f60d2c459mr968817766b.21.1718711415891; 
 Tue, 18 Jun 2024 04:50:15 -0700 (PDT)
Received: from xeon.. ([188.163.112.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f6121c727sm524648766b.67.2024.06.18.04.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 04:50:15 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/4] Initial support for new Tegra 2/3 devices
Date: Tue, 18 Jun 2024 14:49:46 +0300
Message-ID: <20240618114952.40993-1-clamor95@gmail.com>
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
All setups are tested on real hardware and pass buildman and CI.

---
Changes from v1:
- removed <linux/sizes.h> inclusion
---

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
 include/configs/ideapad-yoga-11.h             |   77 +
 include/configs/qc750.h                       |   65 +
 include/configs/surface-rt.h                  |   39 +
 include/configs/transformer-t20.h             |   21 +
 47 files changed, 5268 insertions(+), 1 deletion(-)
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

