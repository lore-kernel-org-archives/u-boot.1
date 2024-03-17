Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A8CC54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFB487E0A;
	Mon, 18 Mar 2024 00:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hbSbnB2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C956287EE3; Mon, 18 Mar 2024 00:50:23 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD3C087B35
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29d51cdde7eso1261659a91.0
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710719419; x=1711324219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i09fpjpmHmihxJlOXwAbdJPMOUxiJPgXAdoIDi3RmKE=;
 b=hbSbnB2Ixux3bvm+oapbc/cbxMIQbR0XAmD1RroNtCCMws+55GdCB0xWXUxLvqoIQe
 n9UCC8XwsF1U7F6tWGD3gbuqM4+6armxDtoYwYOQfOu9Bt3L/GEc6eP/kbCXZn6k/zNJ
 3/LtfGgmOrtKjqOHfGCQzvQi5I8FpNUNdSgCub9ozbYGoBCDzTQwhWAW26as7YZ/wABh
 h+XejJfc6QJkbXvAJ1+ce8/Elh8qttaNJlxxA9azX5SOT2vv+jET2eSjMP/NF/TYhQ8Z
 rzVEqTzxHDWnu90I0mEkKHO5Six3RDiuqlU1+agMdX4PaOjZ9+rHVziMLrF1sXDSGLMQ
 vung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710719419; x=1711324219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i09fpjpmHmihxJlOXwAbdJPMOUxiJPgXAdoIDi3RmKE=;
 b=BbHzvjLrH/iLqMjKpqcc+P+Fsk9SKDGATeZWx01k2bNj+WogIoFWShj+NUk2Jo9tx5
 2pQB/jzjWkaUcLb2TqNNlgNIAATqa7NvL3jBjQc8M9/qpnDtVeu67o1nT2xASQEBDW70
 yjkc+uiJQGTo5k8By4EbrvJTSgsyh9FC/+aGv7EvVZflX2eK4qpfkQZzfo8Vd+wSmdcg
 j+0llbmTf11lKhlqBDU4usk5ugdpO/sEs9pdcfMzqBk9X08R+0+y/XL37Dpn1P9UPwDl
 yAOcT7v8J3Ir8RewcIXfh+6Tb2W7xwBRt8hPYQRN96pc+fIzCM49yPzAX+nCzOsrYor2
 BfHw==
X-Gm-Message-State: AOJu0Yza3+aPL8n2IBxLsGbZIGAmqEdtjEiDBDh9perf2OrRBPzCiExO
 aeJYsPVaqlhryNosDll1ba1t+HpT0dSQpVrRQ/FWlDz99+s3GUgBLEBBIWIc
X-Google-Smtp-Source: AGHT+IG1IddJFHHKvHFgjcZosLWtXWcehdqOOUMaHEmC2Jgjz77R9gGJhtv6P6+kahVeADVpPKvMxw==
X-Received: by 2002:a17:903:186:b0:1dd:6f1a:2106 with SMTP id
 z6-20020a170903018600b001dd6f1a2106mr13890622plg.0.1710719419109; 
 Sun, 17 Mar 2024 16:50:19 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1857:6918:c59e:afde])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a170902c40400b001defa98b03fsm4573127plk.101.2024.03.17.16.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 16:50:18 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240317
Date: Sun, 17 Mar 2024 20:50:15 -0300
Message-Id: <20240317235015.333272-1-festevam@gmail.com>
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

Please pull this material for next from u-boot-imx, thank

The following changes since commit 099c94b7613bb10d97936447f5136f3a36694325:

  Merge tag 'u-boot-rockchip-20240315' of https://source.denx.de/u-boot/custodians/u-boot-rockchip into next (2024-03-15 09:15:31 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240317

for you to fetch changes up to 86b79cf131b64eadae023a127921893d30503093:

  imx8m*_venice: move venice to OF_UPSTREAM (2024-03-17 18:39:54 -0300)

u-boot-imx-next-20240317
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19975

- Select polling-rate from cpu-thermal devicetree node on imx_tmu.
- Re-organize the U-Boot environment and add RAUC logic for phycore_imx8mp.
- Enable watchdog on colibri-imx7.
- Move imx8mm-venice to use OF_UPSTREAM.
----------------------------------------------------------------
Benjamin Hahn (1):
      drivers: imx_tmu: Select polling-rate from cpu-thermal devicetree node

Leonard Anderweit (5):
      phycore_imx8mp: Move environment from include/config to board
      phycore_imx8mp: Move default bootcmd to board env
      configs: phycore-imx8mp_defconfig: Use redundant environment
      include: env: Add phytec RAUC boot logic
      board: phytec: phycore_imx8mp: Add RAUC boot logic to environment

Parth Pancholi (1):
      configs: colibri-imx7: enable watchdog

Tim Harvey (1):
      imx8m*_venice: move venice to OF_UPSTREAM

 arch/arm/dts/Makefile                          |   17 -
 arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi |    4 +
 arch/arm/dts/imx8mm-venice-gw700x.dtsi         |  525 -----------
 arch/arm/dts/imx8mm-venice-gw71xx-0x.dts       |   19 -
 arch/arm/dts/imx8mm-venice-gw71xx.dtsi         |  239 -----
 arch/arm/dts/imx8mm-venice-gw72xx-0x.dts       |   19 -
 arch/arm/dts/imx8mm-venice-gw72xx.dtsi         |  400 ---------
 arch/arm/dts/imx8mm-venice-gw73xx-0x.dts       |   19 -
 arch/arm/dts/imx8mm-venice-gw73xx.dtsi         |  452 ----------
 arch/arm/dts/imx8mm-venice-gw7901.dts          | 1137 ------------------------
 arch/arm/dts/imx8mm-venice-gw7902.dts          | 1052 ----------------------
 arch/arm/dts/imx8mm-venice-gw7903.dts          |  869 ------------------
 arch/arm/dts/imx8mm-venice-gw7904.dts          |  928 -------------------
 arch/arm/dts/imx8mm-venice-gw7905-0x.dts       |   28 -
 arch/arm/dts/imx8mm-venice-gw7905.dtsi         |  303 -------
 arch/arm/dts/imx8mm-venice.dts                 |  169 ----
 arch/arm/dts/imx8mn-venice-gw7902.dts          |  980 --------------------
 arch/arm/dts/imx8mn-venice.dts                 |  169 ----
 arch/arm/dts/imx8mp-venice-gw702x.dtsi         |  587 ------------
 arch/arm/dts/imx8mp-venice-gw71xx-2x.dts       |   19 -
 arch/arm/dts/imx8mp-venice-gw71xx.dtsi         |  236 -----
 arch/arm/dts/imx8mp-venice-gw72xx-2x.dts       |   19 -
 arch/arm/dts/imx8mp-venice-gw72xx.dtsi         |  378 --------
 arch/arm/dts/imx8mp-venice-gw73xx-2x.dts       |   19 -
 arch/arm/dts/imx8mp-venice-gw73xx.dtsi         |  421 ---------
 arch/arm/dts/imx8mp-venice-gw74xx.dts          | 1125 -----------------------
 arch/arm/dts/imx8mp-venice-gw7905-2x.dts       |   28 -
 arch/arm/dts/imx8mp-venice-gw7905.dtsi         |  309 -------
 arch/arm/dts/imx8mp-venice.dts                 |  183 ----
 arch/arm/mach-imx/imx8m/Kconfig                |    3 +
 board/gateworks/venice/venice.c                |    7 +-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env |   62 ++
 configs/colibri_imx7_defconfig                 |    2 +
 configs/colibri_imx7_emmc_defconfig            |    2 +
 configs/imx8mm_venice_defconfig                |    4 +-
 configs/imx8mn_venice_defconfig                |    4 +-
 configs/imx8mp_venice_defconfig                |    4 +-
 configs/phycore-imx8mp_defconfig               |    4 +-
 drivers/thermal/imx_tmu.c                      |    6 +-
 include/configs/phycore_imx8mp.h               |   43 -
 include/env/phytec/rauc.env                    |   52 ++
 41 files changed, 141 insertions(+), 10705 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw700x.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw71xx-0x.dts
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw71xx.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw72xx-0x.dts
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw72xx.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw73xx-0x.dts
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw73xx.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw7901.dts
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw7902.dts
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw7903.dts
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw7904.dts
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw7905-0x.dts
 delete mode 100644 arch/arm/dts/imx8mm-venice-gw7905.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-venice.dts
 delete mode 100644 arch/arm/dts/imx8mn-venice-gw7902.dts
 delete mode 100644 arch/arm/dts/imx8mn-venice.dts
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw702x.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw71xx-2x.dts
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw71xx.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw72xx-2x.dts
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw72xx.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw73xx-2x.dts
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw73xx.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw74xx.dts
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw7905-2x.dts
 delete mode 100644 arch/arm/dts/imx8mp-venice-gw7905.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-venice.dts
 create mode 100644 board/phytec/phycore_imx8mp/phycore_imx8mp.env
 create mode 100644 include/env/phytec/rauc.env
