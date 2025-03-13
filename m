Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA151C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17DE680F9C;
	Thu, 13 Mar 2025 20:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BykLRLQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DCE80756; Thu, 13 Mar 2025 20:54:36 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B7E80756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2241053582dso35443305ad.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741895672; x=1742500472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UTP4571JTowDFjSTKBKk3KkNk+2D/Z2gslKp51l8QKU=;
 b=BykLRLQYQpKD+uWIxcLIYs8ZXShIGtjpsqeHVZoGV08awxYC0OuevTidfnNtcD7J5L
 TUeIwI+V3PxSV7V6EibeelT48KBgCX1++AwFCKXaqQ7L57ND2ZlBtZbjYrzIG79yPBVT
 m1lurfdqc1ljROENyM3CAEXjad61GhIfEaxHObCpmQvYJObzKV+Q9Ban8evTtoJ248Yn
 knZlh0uhBB1Z8Ckbu3sq4VSTfXV/3Ur0YkZHPc76u+OmIN1GMHK5rMvLLby7XxtQDq7j
 xttOMF5ThiecCxmIrPknPEQKk3aN1Ov+3N++kY4slFRzylCtTTd+lJTgLuMgOUihBp0x
 tzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741895672; x=1742500472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTP4571JTowDFjSTKBKk3KkNk+2D/Z2gslKp51l8QKU=;
 b=VXMvdQQMgpnfpGrykAnjH3RUIC0p9LKQtXf+DcqPUAvSX5s8gXgzeEm5uF/9wYvlXH
 dmbBQ+xypKCQp0kgfKs5VZe+pcIr7pMN/028BxbIE/yVGNpSH14GivA17FbuhsbSruMe
 69dC5PGSodpblKvbirnm9MnCkuDJT3PjkzFlmuObD3pfUV063oplRE789q+1vdLptOa0
 FeLLPlgmY6aLZcS7RvElYls8YFnpL2zx4oRUprC5ERLB1TC0L8TBHKDEv2YDh0kAMgv/
 Mu/FqZur7QpEZzhfgQP7aDEUtysAoYMzirpXbNc0zyupDQemMvj7mISq6XIRpHYuxYQ1
 j2wA==
X-Gm-Message-State: AOJu0YwdO/anZQZZ/SGSY7uUKGb0OxvN2Kvr/3mLQsPviG/1d8M7oe1G
 dXXF3EIFUtOgO0TiVFv+yVJp9O0WKvN/3YR6rijPNM9k06LUQxi1
X-Gm-Gg: ASbGncsg0lfuqJSJmV2EypnK38UpTUbr6uyFIxlxbg6M59jgKZOrojetN/nu6Gma2Hf
 lDdikc5FI5F4MGNqTji3qwgXwrMbnvDM9s5G1YE9sopPdncdDluj9f2o/nX7KQB9BlKaVkFmKO2
 S6ZfL4KTTOaaoxSfKDcwfMdR7DWR3IkHC5gZKUcJ9fEG4rtOVVdwJY60AVe0E8Bym07SUlByw6E
 J3aGkFRC7g+zPLSq7wFudLf4P2MOIocMnhEHHYrD+vldHDXIEbvAM5Z3PRqJDKHPjdOobiG9a8o
 WY3FR+sjENSVpX1yf+u58YIWdblLdkK4/Qbz7lgA7fG3BbkQwgUpn7FBp4lQCHAEnrggig==
X-Google-Smtp-Source: AGHT+IGlrOSOSopQBYdlzbxnYsP7PGsCimlGTpP5KZozFn3gWcg2HwXVb9W3MdIfC3ibh4xUFxeNAw==
X-Received: by 2002:a17:903:2446:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-225dd82588emr11360485ad.11.1741895671884; 
 Thu, 13 Mar 2025 12:54:31 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:abab:f7ee:5b0a:8554])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f64sm17383495ad.127.2025.03.13.12.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 12:54:31 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250313
Date: Thu, 13 Mar 2025 16:54:27 -0300
Message-Id: <20250313195427.1554312-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit eeefcacb851f7f0bccabc3089a725f5ce86f5c70:

  Merge tag 'u-boot-stm32-20250312' of https://source.denx.de/u-boot/custodians/u-boot-stm into next (2025-03-12 21:36:52 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250313

for you to fetch changes up to 21a4ac55c0d4eba836a45345d011093ffdc85b5c:

  mailbox: add i.MX Messaging Unit (MU) driver (2025-03-13 15:15:50 -0300)

u-boot-imx-next-20250313
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25142

- Support Toradex i.MX6 Apalis/Colibri v1.2 SoM.
- Guard tee.bin inclusion on imx9,
- Remove unneeded regulator entry on DH i.MX6 DHCOM DRC02 devicetree.
- Add i.MX mailbox driver
- Convert ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE to Kconfig.
- Cope with existing optee node on imx8m.
----------------------------------------------------------------
Ernest Van Hoecke (2):
      board: toradex: apalis/colibri imx6: Detect new v1.2 SoM variant
      toradex: apalis/colibri imx6: Select correct DTB for SoM v1.2+

Fabio Estevam (1):
      imx9: container.cfg: Guard tee.bin inclusion

Marek Vasut (1):
      ARM: dts: imx: Drop bogus regulator extras on DH i.MX6 DHCOM DRC02

Peng Fan (1):
      mailbox: add i.MX Messaging Unit (MU) driver

Tom Rini (1):
      mmc: fsl_esdhc: Migrate ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE to Kconfig

Vincent Stehlé (1):
      imx8m: soc: cope with existing optee node

 MAINTAINERS                               |   1 +
 arch/arm/dts/imx6qdl-dhcom-u-boot.dtsi    |   5 -
 arch/arm/mach-imx/imx8m/soc.c             |   3 +-
 arch/arm/mach-imx/imx9/container.cfg      |   2 +
 arch/powerpc/include/asm/config_mpc85xx.h |   3 -
 board/toradex/apalis_imx6/apalis_imx6.c   |  31 +++
 board/toradex/colibri_imx6/colibri_imx6.c |  31 +++
 configs/apalis_imx6_defconfig             |   2 +-
 configs/colibri_imx6_defconfig            |   2 +-
 drivers/mailbox/Kconfig                   |   7 +
 drivers/mailbox/Makefile                  |   1 +
 drivers/mailbox/imx-mailbox.c             | 443 ++++++++++++++++++++++++++++++
 drivers/mmc/Kconfig                       |   6 +
 drivers/mmc/fsl_esdhc_imx.c               |   8 +-
 include/configs/imxrt1020-evk.h           |   2 -
 include/configs/imxrt1050-evk.h           |   2 -
 include/configs/imxrt1170-evk.h           |   2 -
 17 files changed, 527 insertions(+), 24 deletions(-)
 create mode 100644 drivers/mailbox/imx-mailbox.c
