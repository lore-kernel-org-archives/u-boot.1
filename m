Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C19C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 13:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0858070C;
	Thu, 22 May 2025 15:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UqEeimJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991F183091; Thu, 22 May 2025 15:03:27 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2315D8006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-52617ceae0dso2401807e0c.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747919004; x=1748523804; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xne02xbRKke5iYsPWuAIgDEfYpDFJTGvIEuiMxg44eo=;
 b=UqEeimJxLe+BFztgcRqSIR+ZgCw25p7wk7UAvirBwF/Lr9+NhHPwN+kAkHJcZCO1fD
 fMrLTgC2e2GRe04PTQI3HRjmSQNBsrpVu8WneAfxNhBFPvp1JVkfc+yivQHKVIILj5tH
 Dy7uJzI7AqC7Dtqoy1ef+3ziiU2Z1Hh2nkLbQjDfnav4SnFeOYFLwAkFVF0QNSpuV9cs
 FH9CZlrCCO2CmTjcxiT+mLMVSdqitNeOXXfvjJxFQHsXAUQComOPCdopnpZC1rRRYFHk
 Os9LmZOqK7GgFsF+ZYUeMESo+FM4yPRYrAFCYPuR0fHoCtp2ER6DKYFBoZ2hBbS3Sdr+
 fNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919004; x=1748523804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xne02xbRKke5iYsPWuAIgDEfYpDFJTGvIEuiMxg44eo=;
 b=Y5QztnZWMo2VO+feMW268QxeQR2ZDC7iIquRD00wAdtljCHTFF/0jvZr4t13qgTSQS
 DqRFhwWTycvjW1UEvnEMKEflpDU3ZRA9fIG0AJ0yhRtViDl8qH6/3fZKCYboKdYv3gyB
 MdBijiqSvZof7SqvROUyZ/R8Inl5VvmaNJQ9n9RZycrh0W/d4rfFkh8wyrtB4XYiRbdr
 HAswg71OiCAmv5NcwMWB9YF953Znzykw/DsxHC6qEIqeKFeQivo0AE6acZtea6zudgXP
 KmZDl+zGxR29i7nOiNOagLlvuPmfVgf4gXL8FMQk+xmOIxk4jJ2ti8ld7r5Xh/cnt5op
 K4AA==
X-Gm-Message-State: AOJu0Yw0GnF4Ocya2zNA06oC692BXH+tfnzRWxUgN1Im0XrehoZyQx6o
 RO6+YsKYSA720twjKAgWFuw+YyhTrh6pmrwVCPgyIVCuy/moSUhe7BcXnwhMfQ==
X-Gm-Gg: ASbGncveh4HF2n9YQ1loC8NU43db2zQF334JGc+9qXrD1A6n1ekNlVcLNTlthZSOVi9
 0XG/b6UVTwptk8afZu/Jqd4qVJgjDziBw5ueKoPltP+8M3qb+XaYgk+VIMJyZFrFBhQ58vfApBA
 RY575SW0P/QvMvdozWthRejhw6Js+O8fSsPpMG2lTPc5rRCkfdYa5J/77kRdkbohAlbiIuxeYft
 0RIJbFuo95aq42b1IFss4lJz9+IJlezB5jYTpNP9TlejyJpbNPg+M6Coc99nONF/9pFfeG4HChJ
 dMUKxdw8cmh967yNgXsLDA/4qwh0LivIHMsG2mfiJhzWbH9xzfGfQhI7KKgZtGDX
X-Google-Smtp-Source: AGHT+IErwf6JGeOkkrrDHYyq7eo4CZrwwOptNShrFqfl0FxdL8a2loYGn+LqAn9cSlxYHfSOyF1ovA==
X-Received: by 2002:a05:6122:3309:b0:524:2fe2:46ba with SMTP id
 71dfb90a1353d-52dbcecf382mr21748861e0c.11.1747919003527; 
 Thu, 22 May 2025 06:03:23 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:453:e0f3:e991:2d38])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dba910d55sm11720632e0c.5.2025.05.22.06.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 06:03:22 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250522
Date: Thu, 22 May 2025 10:03:19 -0300
Message-Id: <20250522130319.1863383-1-festevam@gmail.com>
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

The following changes since commit a3e09b24ffd4429909604f1b28455b44306edbaa:

  Merge tag 'mmc-2025-05-20' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2025-05-20 08:35:31 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250522

for you to fetch changes up to 159b6f0e119962ce5da645f548cefe9196c8778e:

  caam: Fix CAAM error on startup (2025-05-22 09:01:51 -0300)

u-boot-imx-master-20250522
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/26275

- Fix boot regression on imx8mn_bsh_smm_s2/s2pro.
- Fix reset on imx6ulz_smm_m2.
- Adjust DDR initialization on imx6ulz_smm_m2.
- Fix CAAM startup error.
----------------------------------------------------------------
Dario Binacchi (6):
      arm: imx: imx8m: soc: replace ifdef by IS_ENABLED()
      spl: Kconfig: support U-Boot load from raw NAND
      imx: spl_imx_romapi: support raw NAND sector
      configs: imx8mn_bsh_smm_s2: load U-Boot from raw NAND
      board: bsh: imx8mn_bsh_smm_s2/s2pro: enlarge CONFIG_SPL_SYS_MALLOC_F_LEN
      board: bsh: imx8mn_bsh_smm_s2/s2pro: let clock system enable UART clock

Michael Bode (2):
      board: bsh: imx6ulz_smm_m2: Add support for 512 MiB DRAM
      board: bsh: imx6ulz_smm_m2: Add delay between DRAM read access

Michael Trimarchi (6):
      arm: imx: imx8m: soc: fix the macro name
      arm: dts: imx6ulz-bsh-smm-m2-u-boot: Drop soc node
      configs: imx6ulz_smm_m2: Add board watchdog reset configuration
      arm: dts: imx6ulz-bsh-smm-m2: Fix reset using wdt-reboot driver
      board: freescale: imx8mn_evk: let clock system enable UART clock
      board: bsh: imx6ulz_smm_m2: Match SPL DDR settings to DCD table

Olaf Baehring (1):
      caam: Fix CAAM error on startup

Primoz Fiser (1):
      ARM: dts: imx93-phycore: Migrate to OF_UPSTREAM

Simon Holesch (1):
      board: bsh: imx6ulz_smm_m2: Add support for 256 MiB DRAM

 arch/arm/dts/Makefile                        |   3 +-
 arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi  |   8 +-
 arch/arm/dts/imx93-phyboard-segin.dts        | 117 -------------------
 arch/arm/dts/imx93-phycore-som.dtsi          | 126 --------------------
 arch/arm/mach-imx/imx8m/soc.c                |  42 +++----
 arch/arm/mach-imx/imx9/Kconfig               |   1 +
 arch/arm/mach-imx/spl_imx_romapi.c           |   8 +-
 board/bsh/imx6ulz_smm_m2/Makefile            |   3 +-
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c | 169 +++++++++++++++++++++++++++
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c | 168 ++++++++++++++++++++++++++
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c | 168 ++++++++++++++++++++++++++
 board/bsh/imx6ulz_smm_m2/spl.c               | 111 +++++++-----------
 board/bsh/imx6ulz_smm_m2/spl_mtypes.h        |  27 +++++
 board/bsh/imx8mn_smm_s2/spl.c                |   2 -
 board/freescale/imx8mn_evk/spl.c             |   2 -
 board/phytec/phycore_imx93/MAINTAINERS       |   2 -
 common/spl/Kconfig                           |  15 +++
 configs/imx6ulz_smm_m2_defconfig             |   3 +
 configs/imx8mn_bsh_smm_s2_defconfig          |   3 +-
 configs/imx8mn_bsh_smm_s2pro_defconfig       |   1 -
 configs/imx93-phycore_defconfig              |   2 +-
 drivers/crypto/fsl/jr.c                      |  25 ++--
 drivers/crypto/fsl/jr.h                      |   4 -
 include/configs/imx6ulz_smm_m2.h             |   6 +-
 24 files changed, 647 insertions(+), 369 deletions(-)
 delete mode 100644 arch/arm/dts/imx93-phyboard-segin.dts
 delete mode 100644 arch/arm/dts/imx93-phycore-som.dtsi
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c
 create mode 100644 board/bsh/imx6ulz_smm_m2/spl_mtypes.h
