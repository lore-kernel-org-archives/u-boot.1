Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31EAC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD4A88915;
	Fri, 23 Aug 2024 21:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cJU7iSSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7931488A3D; Fri, 23 Aug 2024 21:41:00 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF49588914
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7cda0453766so824067a12.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724442056; x=1725046856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DvSSMnRFL3Xzx1qTIcYk7nPJqRwsd0WifzTAetQD8+Q=;
 b=cJU7iSSNJPRZqEci00u0O4Hv/Q3/DVBosx6VhyZhIlrGPqlcsknDV9k8pmc/MuOviY
 ZEBgmXESWt6oyVL8wOnEjDMjN4lP4cYi6kSP8zJqNJYb3l2uhuJGyXhAsIzq8/Vtj5GH
 aNMmEYoLkL4djo++rxAAbFHdyOqrMaGMgGDH9NQQ+WFsNwHfL+aPr7lH4DjZygKrcfya
 XCiO9UH8iyNNXNAqFN1M19J4WWtOtobnf9NGcW1fKJH95LZ2qbSsZNkjMX1ia+I+ndTR
 JkLX5FlpaQx6G7jwB2bsR4MsL+Z0XtW6Ly8JeiXsR2Ss40pb3ZNGFMPu8Ska2pxaJ4XW
 F6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724442056; x=1725046856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DvSSMnRFL3Xzx1qTIcYk7nPJqRwsd0WifzTAetQD8+Q=;
 b=LMkgCk2dhbpRAebXlF3AkK/Dwsf/G40KjbBwEirBZlGKEzKVgks07wF3USkGNV0v8p
 tA/HNYDodCiUkG7z3UL3A4vv8QTi/+AsvwGXkpOrYxaY5LDpGqaPmoCz/vcI7fi+Eoxp
 Kje5YNez8842DlqxPRsz2mL0Ij0BB+mEegCJZIDlkU9uZzSNHabkH0M2mnjwB+hi3mvS
 sipuijQkByOTaxKU30SsjotE2AtkNu0iPfH9MS6lJfqagExBFyCe8vRzH0lwdeu5Szyt
 Jhq4N/XG4aBhdTguiauxOxKTvvkQYfiVwovvre6K3vSFeGRP+Ly8mIRaGvcZFzeiaVkK
 7hWg==
X-Gm-Message-State: AOJu0YxhErwwHouVQ8FaTcvADHPN+Hj9VXmkLoslZ2a/bHH7jdBBuf/y
 IBkcFVFaAZSuG3Ixx7PWFmowPiUtbebRrsiu4zQYtVWa6LwrgSwV
X-Google-Smtp-Source: AGHT+IHTSuR5fHOsDTnSFZLSf15N8B7TATWprVYdm7ypjYTkzLjIjrPOYLJof7mXlQPSGBgwhdfMHw==
X-Received: by 2002:a05:6a20:2d0c:b0:1c1:31d0:c7a7 with SMTP id
 adf61e73a8af0-1cc89d4ca7bmr4647696637.16.1724442056349; 
 Fri, 23 Aug 2024 12:40:56 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:7a3d:a1bd:2192:9908])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613b1f0d5sm4539258a91.55.2024.08.23.12.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 12:40:55 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL v2] Please pull u-boot-imx-next-20240823
Date: Fri, 23 Aug 2024 16:40:52 -0300
Message-Id: <20240823194052.3978150-1-festevam@gmail.com>
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

Please pull from u-boot-imx/next, thanks.

The following changes since commit e93d343cc7d2886b1148d885aa137d46bbce0570:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-samsung into next (2024-08-22 08:15:04 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240823

for you to fetch changes up to dda8444832ce32e0bdb9a05e2e90a7dc9f8663ca:

  ARM: imx: Enable cat and xxd commands on Data Modul i.MX8M Mini/Plus eDM SBC (2024-08-23 14:53:53 -0300)

u-boot-imx-next-20240823
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22098

- Add BOOTAUX support for apalis and colibri imx8 boards.
- Cleanup tqma6 board by removing unneeded board code.
- Add support for booting from ecspi3 via bmode command on imx6.
- Add a script to ease updating flash.bin on imx8mm phytec board.
- Enable cat and xxd commands on Data Modul i.MX8M Mini/Plus eDM SBC
and use USB SDPS as fallback option.
- Fix critical temperature on imx9.
- Add Cortex M and bootaux support for phycore-imx8mp.
----------------------------------------------------------------
Andrejs Cainikovs (4):
      board: apalis-imx8: add reset code
      apalis-imx8: enable i.MX specific BOOTAUX
      colibri-imx8x: enable i.MX specific BOOTAUX
      colibri-imx8x: enable i.MX specific SNVS configuration

Fabio Estevam (5):
      tqma6: Remove non-DM board code
      tqma6_mba6: Remove unused defines
      tqma6_mba6: Remove UART board code
      gw_ventana: Remove unneeded comments
      mx6: Expand bmode to support ecspi3 boot

Lukasz Majewski (1):
      config: Add 'update_bootimg' command to update flash.bin on Phytec's imx8mm

Marek Vasut (2):
      ARM: imx: Use USB SDPS as fallback option on Data Modul i.MX8M Plus eDM SBC
      ARM: imx: Enable cat and xxd commands on Data Modul i.MX8M Mini/Plus eDM SBC

Primoz Fiser (1):
      imx: imx9: Set correct critical temperature

Yashwanth Varakala (2):
      board: phytec: phycore_imx8mp: Add mcore support
      configs: phycore-imx8mp_defconfig: Enabled bootaux command

 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi          |  16 ++++
 arch/arm/mach-imx/imx9/soc.c                   |   2 +-
 arch/arm/mach-imx/mx6/soc.c                    |   4 +
 board/data_modul/imx8mp_edm_sbc/spl.c          |   5 +-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env |   5 +-
 board/toradex/apalis-imx8/apalis-imx8.c        |   8 ++
 board/tq/tqma6/tqma6.c                         | 126 -------------------------
 board/tq/tqma6/tqma6_mba6.c                    |  35 -------
 configs/apalis-imx8_defconfig                  |   1 +
 configs/colibri-imx8x_defconfig                |   2 +
 configs/imx8mm_data_modul_edm_sbc_defconfig    |   2 +
 configs/imx8mp_data_modul_edm_sbc_defconfig    |   2 +
 configs/phycore-imx8mp_defconfig               |   1 +
 include/configs/gw_ventana.h                   |  31 +-----
 include/configs/phycore_imx8mm.h               |   8 ++
 15 files changed, 53 insertions(+), 195 deletions(-)
