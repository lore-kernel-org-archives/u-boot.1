Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A606C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 21:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC3C88378;
	Mon, 27 May 2024 23:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D18ksH69";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F9FC87D1A; Mon, 27 May 2024 19:02:35 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F336187E95
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b59f8daso22933635ad.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716829351; x=1717434151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B1UkOGVUB/j5ZaiE03JzefRbnIkrH36feC+aiIE7/P4=;
 b=D18ksH69cZlmts1i4JXfFnbQCkGGYlDs4+q5WNA25hB2BrgbC5eU/XxHcDfpeFGDp4
 xSOxAHSW5WLLgsbaqn6eTAt/UfJY5P6tpdepJ+iK1kh8Nzk5M3Hsy20C9oLT+Rw64Bqc
 iUwFdod+y7NLPC1LuRVtoU2f6NscS6aMDcbHSCLguXYJes6YIWs+LhBjTEYI5FV5LxSm
 Q3NMdync9nbsigPFgMNEsZx8gvcVKZAM8+qcTNk5DLLLwh6hIrLlkvb/wOS2twrYiGhf
 M3EBggEF6zsatPR3PgcLdGMkA8EZDrnRqsu4C6IwHgOvF+0zlTAaN+jVIhyPafAVHVxf
 z+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829351; x=1717434151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B1UkOGVUB/j5ZaiE03JzefRbnIkrH36feC+aiIE7/P4=;
 b=E9i/Nf5GNc21UF3L/tykxp0oUSvsWg4VUQmNdoU4F8AiMM1M5OQXd7nH0PqD+0VdQx
 ikCB2Lt/zYRh/E05lX5t86EUxVOWXSX2RkVJHeWclDX3RtSCFYTmL2zzR7XCs3W4G2B7
 Z297/sPC4Ikwtc4ptXIJppexLc2JBefL9l98kKu5KT4uQFLpuQ1FOSbRL7IXQ1HRt/ZG
 jeMfTMHIa1WAdpoWEgjXvAhaUx3EzBVWYQY4ptVByUa2ecZg/xDmas564Wq6C56OSqSw
 V162XkAJQKv2YFk+XGnkBZrZfo4h62lM0jaSYRcdc1hMZXX4ptn2OK9vyAjfoI67DY8u
 g77A==
X-Gm-Message-State: AOJu0YzVitHIkMeGpCMW1cSK93jARQnuco1rl1iuJEty3qrP+0HfR6PX
 XP1/Yal9YVesHZhlvchC+kft7uHT16hTVsUPZFcrqWltd/cFNEOtfKeyoOo8o8g=
X-Google-Smtp-Source: AGHT+IGyxhVGOR9GcJZ3+4OEIbbcnZIIMQ1LehqpbzepoTPKjkV/XO7GA6djrDOyy4EaxUpFxEjaPA==
X-Received: by 2002:a17:902:f687:b0:1f3:5346:35f4 with SMTP id
 d9443c01a7336-1f44873dd4dmr102924665ad.35.1716829351110; 
 Mon, 27 May 2024 10:02:31 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c757845sm63462095ad.5.2024.05.27.10.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:02:30 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>
Subject: [PATCH v3 0/7] add ArmSoM Sige7 Rk3588 board
Date: Tue, 28 May 2024 01:02:07 +0800
Message-Id: <20240527170214.283988-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 May 2024 23:34:36 +0200
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

Devicetree of ArmSoM Sige7 is merged to kernel v6.10-rc1 with USBDP and
GPU nodes. So I use update-dts-subtree.sh to pick related commits of
rk3588s.dtsi, and then pick the commit of ArmSoM Sige7's devicetree.
I also did run command:
./dts/update-dts-subtree.sh pull v6.10-rc1-dts
based on my work but there is a merge conflict of file:
dts/upstream/Bindings/Makefile
I think this should not be related to my work.

Changes in v3:
- Use update-dts-subtree.sh to pick upstream dts

Changes in v2:
- Fix alphabetical order of MAINTAINERS
- Use arch/arm/dts/rk3588-armsom-sige7* in board MAINTAINERS
- Remove spi flash related config
- Move kernel dts to dts/upstream/src/arm64/rockchip/

Boris Brezillon (1):
  arm64: dts: rockchip: Add rk3588 GPU node

Diederik de Haas (1):
  arm64: dts: rockchip: Fix ordering of nodes on rk3588s

Jianfeng Liu (2):
  arm64: dts: rockchip: Add ArmSom Sige7 board
  board: rockchip: add ArmSoM Sige7 Rk3588 board

Sebastian Reichel (3):
  arm64: dts: rockchip: fix usb2phy nodename for rk3588
  arm64: dts: rockchip: add USBDP phys on rk3588
  arm64: dts: rockchip: add USB3 DRD controllers on rk3588

 MAINTAINERS                                   |   1 +
 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi  |  28 +
 arch/arm/mach-rockchip/rk3588/Kconfig         |  26 +
 board/armsom/sige7-rk3588/Kconfig             |  12 +
 board/armsom/sige7-rk3588/MAINTAINERS         |   7 +
 configs/sige7-rk3588_defconfig                |  93 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../arm64/rockchip/rk3588-armsom-sige7.dts    | 721 ++++++++++++++++++
 dts/upstream/src/arm64/rockchip/rk3588.dtsi   |  72 ++
 dts/upstream/src/arm64/rockchip/rk3588s.dtsi  | 337 +++++---
 include/configs/sige7-rk3588.h                |  15 +
 11 files changed, 1215 insertions(+), 98 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
 create mode 100644 board/armsom/sige7-rk3588/Kconfig
 create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
 create mode 100644 configs/sige7-rk3588_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
 create mode 100644 include/configs/sige7-rk3588.h

-- 
2.34.1

