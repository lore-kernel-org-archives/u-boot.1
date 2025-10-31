Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92499CCF9F0
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 01:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAECF83642;
	Fri, 31 Oct 2025 02:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nnSxPj+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51BAF836F0; Fri, 31 Oct 2025 02:47:52 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EE98331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 02:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7a4c202a30aso1945822b3a.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875268; x=1762480068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=in/1O2/G0vrNCzwNHe6B8vtbRZVZ5xY2KFWlIwQ0AKA=;
 b=nnSxPj+uXolaDdPyPNF6PnlwMGeLiQOV8qMaDWZHMi3hOLpDJV2Tutj1QclKt2d5/v
 yc5VqKisV9pUWoN4hqOBJ2ZMA3LnrD9cth2I7BQQRytSSvsMZLBhI8vtpmMDmPWdH2WH
 3v98uxjEWzOw2mC+hpKLfhh3zp1oqbhW/U1DHRlh6uqFEeLqhVEVGPOEse2/EhzqTj52
 4HOggxLfy/OJ6mTofN/V4vQnpcYVY/FwcjCveOb15BgF7KnZG5AxYRl1Gntx/Ou3e7sw
 DEpheuAz++RWfXhO1LKeIAZVRts7mRwX/nGwSm8NcEoR0rqQ/bSkdZbZurCU8VC6saiZ
 atRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875268; x=1762480068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=in/1O2/G0vrNCzwNHe6B8vtbRZVZ5xY2KFWlIwQ0AKA=;
 b=qQ8wagqQtnPFGDXgojCNrOVF1sOBM2aTueMzkROfX8bOx2Ur037vurh27KQY153FrB
 6oO3YzlaUFwK6TkOmKw33D0XK+uYEWqa+7nSduwxoon8GoOV2Q93uW8Ht3R7XUBWdoUO
 B+J5D7EI7HZ5q6QwFGyJdR5S7Gtj7Pt08wV4lzVcet+2z4gkbMOQdubZrJ4+MWGLuv55
 9AF5r6A0KUwnHzV3t/2WmfGS+BSYdvqGyz/2tJBtG1x1asYDQ0GOCYpEnhCRYapmVkt7
 H2kAF+4ymgaUn72IfFa9geK+ibEY5VWehL3t4/3Xs+n24XBLv8LBTwLz6z3ZCp0qkUQQ
 z8Pg==
X-Gm-Message-State: AOJu0YwuecK0jz3GsGpPMl2a/vFWmUKaUNCM7lJjPpEz4oOcLwqjfrKe
 gxtUP+xR5F2Phu9sPKE1AEAzT5U1vsMh+iwRw6Po+NfTyNN4p8uTkEsIghW7FfMh
X-Gm-Gg: ASbGncsTgF4DQL1AVtwWliMFiCbvLoKu5WIAsEHaZmB+7TzJ2cHRGSr/c09CotAUnPe
 zhMBJwtL7wwNvE5r/vklBDPyDlr2EhmMsm8r2sSdJ3PZF4zP6gPYOs1hRc95jzElAJ87aZwOfNz
 s49DoCoSodG8Z6QDuKiL+BkkbhmD0GSxYaYMrcE/KVsHGyR0gNSLDwSVs5MNtShP7n8LsiHMUFJ
 w332E8IE9+E4z3fBUETRyO+JDALvFWty39+4lvZju6guE20FBVfeTWZhr8RkalclckxQ3SCdp5a
 3Qj9RSF9LcfEVjSLC1TpkoUV8gGzwbUv6sEnhu7tlqTIVN3ETaRDt8GY+k9/UHMG8v17MbiNf59
 qncHVzUjI27KbN4mau6NIu5/5ZmtYLr3n8pnBIWzHfiTppJsqWAb08a/TEfDrTJSsvNQSwoo=
X-Google-Smtp-Source: AGHT+IFY/26yYQdhEYSC53QFP75QWgZAAc4jbL49nzBuKFDi1fAQqc4urJxIYkTRstMnwXbIBn8g0w==
X-Received: by 2002:a17:902:cecc:b0:290:5601:9d56 with SMTP id
 d9443c01a7336-2951a477313mr27085925ad.46.1761875267991; 
 Thu, 30 Oct 2025 18:47:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61::1000])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295268cb73dsm3615255ad.44.2025.10.30.18.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 18:47:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20251030
Date: Thu, 30 Oct 2025 22:47:42 -0300
Message-Id: <20251031014742.516268-1-festevam@gmail.com>
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit e34d01d23e45e007368685ffa6dfd674b6dd7b17:

  Merge tag 'u-boot-ufs-20251029' of https://source.denx.de/u-boot/custodians/u-boot-ufs (2025-10-29 07:41:43 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20251030

for you to fetch changes up to 087277fc76baa0bdd6275ab365891d9058612e1e:

  imx8mp_evk: Fix typo on maintainer's name (2025-10-30 12:40:47 -0300)

u-boot-imx-master-20251030
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/28092

- Fix a i.MX6ULL regression related to the REFTOP_VBGADJ setting.
- Shrink SPL size for the Liebherr BTT board. 
- Add suppot for Toradex SMARC iMX95.
- Fix Aquila imx95 0098 Product ID.
----------------------------------------------------------------
Emanuele Ghidoli (1):
      arm: imx8: select ARCH_MISC_INIT if FSL_CAAM is enabled

Fabio Estevam (1):
      imx8mp_evk: Fix typo on maintainer's name

Francesco Dolcini (1):
      board: toradex: fix aquila imx95 0098 pid4

João Paulo Gonçalves (1):
      board: toradex: add Toradex SMARC iMX95

Primoz Fiser (1):
      thermal: imx_tmu: Always set thermal trips from fuses

Rasmus Villemoes (1):
      liebherr: btt: shrink spl_board_init

Ye Li (1):
      imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and fix comments

 arch/arm/Kconfig                                 |    1 +
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi |  110 +++
 arch/arm/dts/imx95-toradex-smarc-dev.dts         |  277 ++++++
 arch/arm/dts/imx95-toradex-smarc.dtsi            | 1153 ++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                   |    5 +
 arch/arm/mach-imx/mx6/soc.c                      |   20 +-
 board/freescale/imx8mp_evk/MAINTAINERS           |    2 +-
 board/liebherr/btt/btt.c                         |   60 +-
 board/toradex/common/tdx-cfg-block.c             |    2 +-
 board/toradex/common/tdx-cfg-block.h             |    2 +-
 board/toradex/smarc-imx95/Kconfig                |   36 +
 board/toradex/smarc-imx95/MAINTAINERS            |   11 +
 board/toradex/smarc-imx95/Makefile               |    8 +
 board/toradex/smarc-imx95/smarc-imx95.c          |   31 +
 board/toradex/smarc-imx95/smarc-imx95.env        |   20 +
 board/toradex/smarc-imx95/spl.c                  |  119 +++
 configs/toradex-smarc-imx95_defconfig            |  172 ++++
 doc/board/toradex/index.rst                      |    1 +
 doc/board/toradex/smarc-imx95.rst                |  172 ++++
 drivers/thermal/imx_tmu.c                        |   33 +-
 include/configs/toradex-smarc-imx95.h            |   24 +
 21 files changed, 2184 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-toradex-smarc-dev.dts
 create mode 100644 arch/arm/dts/imx95-toradex-smarc.dtsi
 create mode 100644 board/toradex/smarc-imx95/Kconfig
 create mode 100644 board/toradex/smarc-imx95/MAINTAINERS
 create mode 100644 board/toradex/smarc-imx95/Makefile
 create mode 100644 board/toradex/smarc-imx95/smarc-imx95.c
 create mode 100644 board/toradex/smarc-imx95/smarc-imx95.env
 create mode 100644 board/toradex/smarc-imx95/spl.c
 create mode 100644 configs/toradex-smarc-imx95_defconfig
 create mode 100644 doc/board/toradex/smarc-imx95.rst
 create mode 100644 include/configs/toradex-smarc-imx95.h
