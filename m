Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7829BC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 13:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A556C87E15;
	Tue, 13 Aug 2024 15:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ve/8T60/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7887788842; Tue, 13 Aug 2024 15:54:53 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD1287C38
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 15:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7b5aacae4f0so898844a12.2
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723557289; x=1724162089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e7QKvCZbfZPrmLmgcGzdrHxD6NZ97GASSTHxKh44q2E=;
 b=Ve/8T60/F8vX9mzbZujrwfQoW0I40bs5f6oaGpEZ6FkHfaO1ZJevNJlj+i5Il62T3L
 xuFMXTR1XPGXxZRpe8T17ONMl+sslnjy9BF/ZHsWjaH98vfIBTeF6KVW4LGztHwosV9c
 OkIU/yd0evWI3nI1Gff9Liwo+kImdqGFnjuPcQp85hbkQCc251/rqEjMTdrL+jQGJqfX
 DKRXiFlxROp95RWUP8RXdZO0ZaEuXU9RRXNJTh1s0M3fJaVrQrUgMR6B0NVB5gJ8mmMN
 jP8F6So1Sq72eV7hDG2795A6ba8y6DSDEmD0YaSz1+c+6JHkeIy19sLyIiRdBh7/Vc5z
 eInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723557289; x=1724162089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7QKvCZbfZPrmLmgcGzdrHxD6NZ97GASSTHxKh44q2E=;
 b=gN90JCIEFJs47Y9JW6YZ2kOBfEQELRXp2ULPD4C+cvjZVTQzISKltpgnLWiRfiI0O9
 3VtEeznrTzwf4p8JGVb+lFVLkJnzDsY27Y40b4eZ+vJIjrJBJQ0ZIh+Qr6SQR3ekvXb0
 dVKXer0bzAWVtCmAVb69xcrymMQAqQ5f24uz+DhbqRPH4ky1FKAJvObWEPeVF4V5UloL
 5KrMvy/DLZuqOJeInr2mp5IXpHmN9ARJ8qJ3oPRBwfxo/qz/Lec8GNRKxuxONrDR0oEm
 38ReYZJmowBNjYlQSGCgQCnjQgDkYrEnct7rr+XtmbiEQNVJitkkAlSK3zlP37cMMq3Q
 i1Ig==
X-Gm-Message-State: AOJu0YxqbQ8X975ZmzXZsj/Q71YUvPd0rRKq6cpW6s/7PjTO/f/1OwRM
 jVlLJCE6CkwvV4XtEVcsEV/hwdLEgL60OfDMWLPV+oa8JnKC62WJsPVQ2Q==
X-Google-Smtp-Source: AGHT+IGLc+CgwfsZCDATbENSCVlXLFKFy9YRm6qN03leBdZGZMY0S04X4DQxr43BQh5XPdrscotA8w==
X-Received: by 2002:a05:6a21:3288:b0:1c4:bb9f:c564 with SMTP id
 adf61e73a8af0-1c8dda1f21bmr1679650637.0.1723557289323; 
 Tue, 13 Aug 2024 06:54:49 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:e58e:430a:bc55:8500])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1fcf0f5f6sm7361672a91.30.2024.08.13.06.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 06:54:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240813
Date: Tue, 13 Aug 2024 10:54:45 -0300
Message-Id: <20240813135445.396224-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 06dceeba3d4515ccfbe37b8989ee047a7628aee3:

  Merge tag 'u-boot-rockchip-20240812' of https://source.denx.de/u-boot/custodians/u-boot-rockchip (2024-08-12 07:58:24 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240813

for you to fetch changes up to 72801d9971d09734f17056fd4836604d4ffd275f:

  tqma6: Do not print the board name twice (2024-08-13 09:31:35 -0300)

u-boot-imx-master-20240813
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22014

- Convert tqma6q_mba6 to watchdog DM to fix reset.
- Convert tqma6q_mba6 to PMIC and I2C DM.
- Convert tqma6q_mba6 to OF_UPSTREAM.
- Do not print the board name twice on tqma6.
- Enable CMD_ERASEENV for imx8mm/mp Phytec boards.
- Add imx8ulp binman support.
- Fix imx8 build when CONFIG_IMX_BOOTAUX is set.
----------------------------------------------------------------
Fabio Estevam (4):
      tqma6q_mba6: Convert to watchdog driver model
      imx6-tqma6: Convert to OF_UPSTREAM
      tqma6: Convert to PMIC and I2C driver model
      tqma6: Do not print the board name twice

Gary Bisson (5):
      tools: imx8image: fix soc variable for ULP
      tools: imx8image: add upower image support
      spl: binman: Disable u_boot_any symbols for i.MX 8ULP boards
      mach-imx: Add i.MX 8ULP binman support
      imx8ulp_evk: enable binman support

Max Krummenacher (1):
      imx: imx8: fix build when CONFIG_IMX_BOOTAUX is set

 arch/arm/dts/Makefile                   |   4 -
 arch/arm/dts/imx6dl-mba6b-u-boot.dtsi   |   3 +
 arch/arm/dts/imx6dl-mba6b.dts           |  21 ----
 arch/arm/dts/imx6dl-tqma6a.dtsi         |  16 ---
 arch/arm/dts/imx6dl-tqma6b.dtsi         |  16 ---
 arch/arm/dts/imx6q-mba6b-u-boot.dtsi    |   3 +
 arch/arm/dts/imx6q-mba6b.dts            |  20 ---
 arch/arm/dts/imx6q-tqma6a.dtsi          |  16 ---
 arch/arm/dts/imx6q-tqma6b.dtsi          |  15 ---
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi   |  15 +++
 arch/arm/dts/imx6qdl-tqma6.dtsi         | 215 --------------------------------
 arch/arm/dts/imx6qdl-tqma6a.dtsi        |  53 --------
 arch/arm/dts/imx6qdl-tqma6b.dtsi        |  33 -----
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi    |   2 +
 arch/arm/dts/imx8ulp-u-boot.dtsi        |  63 ++++++++++
 arch/arm/mach-imx/Makefile              |   4 +-
 arch/arm/mach-imx/imx8/cpu.c            |   4 +-
 arch/arm/mach-imx/imx8ulp/Kconfig       |   1 +
 arch/arm/mach-imx/imx8ulp/container.cfg |   7 ++
 arch/arm/mach-imx/imx8ulp/imximage.cfg  |   9 ++
 board/tq/tqma6/Kconfig                  |   1 +
 board/tq/tqma6/tqma6.c                  |  66 ++--------
 common/spl/Kconfig                      |   2 +-
 common/spl/Kconfig.tpl                  |   2 +-
 common/spl/Kconfig.vpl                  |   2 +-
 configs/imx8ulp_evk_defconfig           |   3 +-
 configs/tqma6dl_mba6_mmc_defconfig      |   6 +-
 configs/tqma6dl_mba6_spi_defconfig      |   5 +-
 configs/tqma6q_mba6_mmc_defconfig       |   5 +-
 configs/tqma6q_mba6_spi_defconfig       |   7 +-
 configs/tqma6s_mba6_mmc_defconfig       |   5 +-
 configs/tqma6s_mba6_spi_defconfig       |   5 +-
 doc/board/nxp/imx8ulp_evk.rst           |  79 ++++++++++++
 doc/board/nxp/index.rst                 |   1 +
 include/configs/tqma6.h                 |   8 --
 include/imx8image.h                     |   1 +
 tools/imx8image.c                       |   7 +-
 37 files changed, 236 insertions(+), 489 deletions(-)
 create mode 100644 arch/arm/dts/imx6dl-mba6b-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx6dl-mba6b.dts
 delete mode 100644 arch/arm/dts/imx6dl-tqma6a.dtsi
 delete mode 100644 arch/arm/dts/imx6dl-tqma6b.dtsi
 create mode 100644 arch/arm/dts/imx6q-mba6b-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx6q-mba6b.dts
 delete mode 100644 arch/arm/dts/imx6q-tqma6a.dtsi
 delete mode 100644 arch/arm/dts/imx6q-tqma6b.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-tqma6.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-tqma6a.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-tqma6b.dtsi
 create mode 100644 arch/arm/dts/imx8ulp-u-boot.dtsi
 create mode 100644 arch/arm/mach-imx/imx8ulp/container.cfg
 create mode 100644 arch/arm/mach-imx/imx8ulp/imximage.cfg
 create mode 100644 doc/board/nxp/imx8ulp_evk.rst
