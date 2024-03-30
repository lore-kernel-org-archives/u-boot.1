Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1842ECD1288
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 802F0882A3;
	Sat, 30 Mar 2024 20:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l6GZ7bzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2406B882A4; Sat, 30 Mar 2024 20:40:39 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7FF9882A1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1def81ee762so6012185ad.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711827635; x=1712432435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7UiSr8X+xGRH+2exIB+lKCnAUqKvxWk2I/zpRIX8uJ4=;
 b=l6GZ7bzLxbsKax9I58YnfvB65scfZO64+xoaUzGaLWJvHdfYlfXuf8PRsm1K3djimJ
 vpB9slC9BkuCeBzJBCigu6A5sJfkaexRCD7E1yHo0JKlG1n0oQESrQxDB4yvGkd0Enjd
 /weyboOz9p6Dhy9PBS8cRB/qufcV5zbXbhb4tHoFgE9nsDARDV+sFxfrfzCYKuSWz/bq
 +s3ix1yjmB+jC1dFojPFIJHJzUBWoA2BzkMdTa111VHfhfbYCkP7pHOZQShDqCPVY4UN
 2VlYATcfRZjanV/uw0MJpcQjb4ztkOJPm+a9NpFJI9cBr96EJkSrGAP95RDtrPFALBFT
 24cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711827635; x=1712432435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UiSr8X+xGRH+2exIB+lKCnAUqKvxWk2I/zpRIX8uJ4=;
 b=ZhHSUXdPzs5J+6JIn+ZUnNeVI7xhkRWyOe+8KrvdhwJXtEo8lgC2kc7hXq5w0/Q57F
 eKhaeIrHUW1Ht2VZTSRdvlLuptrStZJPl5/Ey6DVyL5fw3PvHoall+teMfHyxsO3yoR0
 vNkCia9Yx5t4NzafqQi7NXbLSjdwaLCSNfZg306nrbbeHlGPV5jWn+8ChrQB9/ffK4n3
 f5LnKxASYz1NlKzK6un/Cc6nv8BvMjJ58PIzOR3Fdfmb7Iz6AzH500S2F30iE4tI1E7c
 ck63YRaFWOOM+Q1JvX1XT4gswW5gXc37eZ8xYuJ0Htfd6db/XEZU4SvXEyD3TE1uNC03
 7qCw==
X-Gm-Message-State: AOJu0Yx9LB9fZJLJJncTyN8rDjsb+vatAzcBIZy0v+ybzX3jX8/AxsmD
 okIZgoj5QRz0+sSu5wLGxmnMxmAqdkw/tcGIebxBOWXqw9wm2xmcSHHBVIX0
X-Google-Smtp-Source: AGHT+IFQ69TbBoPM07f1b1Q2ZGb2zN+6wktxmXjS+xZhJe7mp/TtzUcZiVXg8UAtgbuC0GVGjcduzA==
X-Received: by 2002:a17:902:d897:b0:1e0:c91b:b950 with SMTP id
 b23-20020a170902d89700b001e0c91bb950mr6445162plz.5.1711827635114; 
 Sat, 30 Mar 2024 12:40:35 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3bdf:3f7c:9329:bd24])
 by smtp.gmail.com with ESMTPSA id
 21-20020a170902c11500b001e0adef698asm5590212pli.230.2024.03.30.12.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Mar 2024 12:40:34 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240330
Date: Sat, 30 Mar 2024 16:40:31 -0300
Message-Id: <20240330194031.2790982-1-festevam@gmail.com>
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

Please pull this material for next from u-boot-imx, thanks.

The following changes since commit 6e2228fb052b68c84688d5baff06e2ebc787a4a5:

  Merge patch series "Clean up arm linker scripts" (2024-03-29 10:39:38 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240330

for you to fetch changes up to f21b3e2cd954634d405fb522198d099879f3f1e7:

  config: xea: Add limits for SPL and u-boot proper sizes (2024-03-30 15:12:22 -0300)

u-boot-imx-next-20240330
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20128

- Allow accessing job-rings from non-TrustZone on colibri-imx7.
- Add support for reading XEA hardware revision.
- Convert imx8mq/8mm/8mn/8mp-evk to OF_UPSTREAM.
- Add TMP support on imx8m*-venice-gw72xx.
- Miscellaneous fixes and improvements.
----------------------------------------------------------------
Emanuele Ghidoli (3):
      crypto/fsl: allow accessing Job Ring from non-TrustZone
      configs: colibri-imx7: set non-secure boot mode as default
      configs: colibri-imx7: allow accessing job-rings from non-TrustZone

Fabio Estevam (3):
      phycore_pcl063: Drop leading zero from USB vendor number
      imx8: Add a default reset_cpu() implementation
      imx8mq_evk: Remove FEC and Ethernet PHY board code

Hiago De Franco (1):
      board: toradex: colibri-imx8x: Remove board_gpio_init

Lukasz Majewski (4):
      arm: spl: xea: Remove I2S pins configuration from early initialization
      arm: spl: Add definition for PHY reset GPIO for XEA HW rev. 2
      arm: xea: Add support for reading SoM (CPU) board HW revision
      config: xea: Add limits for SPL and u-boot proper sizes

Peng Fan (4):
      imx: imx8mq_evk: convert to OF_UPSTREAM
      imx: imx8mm_evk: convert to OF_UPSTREAM
      imx: imx8mn-evk: convert to OF_UPSTREAM
      imx: imx8mp_evk: convert to OF_UPSTREAM

Tim Harvey (2):
      arm: dts: imx8mm-venice-gw7901: add digital I/O direction control GPIO's
      arm: dts: imx8m*-venice-gw72xx: add TPM device

Ye Li (4):
      arm: imx9: Fix MMU map table overlap
      thermal: imx_tmu: Fix TMU error on iMX8MQ
      image-container: Fix incorrect return value
      net: fec_mxc: Avoid enable regulator failure

 arch/arm/dts/Makefile                              |   5 -
 arch/arm/dts/imx8mm-evk.dts                        | 128 ----
 arch/arm/dts/imx8mm-evk.dtsi                       | 615 ------------------
 arch/arm/dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi   |   7 +
 arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi      |  14 +
 arch/arm/dts/imx8mn-ddr4-evk.dts                   | 160 -----
 arch/arm/dts/imx8mn-evk.dts                        | 128 ----
 arch/arm/dts/imx8mp-evk.dts                        | 684 --------------------
 arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi   |   9 +
 arch/arm/dts/imx8mq-evk.dts                        | 712 ---------------------
 arch/arm/mach-imx/image-container.c                |   2 +-
 arch/arm/mach-imx/imx8/cpu.c                       |   4 +
 arch/arm/mach-imx/imx8m/Kconfig                    |   5 +
 arch/arm/mach-imx/imx9/soc.c                       |   2 +-
 .../imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c          |  11 -
 .../imx8qm_rom7720_a1/imx8qm_rom7720_a1.c          |   8 -
 board/congatec/cgtqmx8/cgtqmx8.c                   |   7 -
 board/freescale/imx8mq_evk/imx8mq_evk.c            |  30 -
 board/freescale/imx8qm_mek/imx8qm_mek.c            |   8 -
 board/freescale/imx8qxp_mek/imx8qxp_mek.c          |   8 -
 board/liebherr/xea/spl_xea.c                       |  21 +-
 board/liebherr/xea/xea.c                           |  49 ++
 board/toradex/apalis-imx8/apalis-imx8.c            |   8 -
 board/toradex/colibri-imx8x/colibri-imx8x.c        |  19 -
 configs/colibri_imx7_defconfig                     |   1 +
 configs/colibri_imx7_emmc_defconfig                |   2 +-
 configs/imx28_xea_defconfig                        |   4 +
 configs/imx28_xea_sb_defconfig                     |   1 +
 configs/imx8mm_evk_defconfig                       |   2 +-
 configs/imx8mm_evk_fspi_defconfig                  |   2 +-
 configs/imx8mn_ddr4_evk_defconfig                  |   2 +-
 configs/imx8mn_evk_defconfig                       |   2 +-
 configs/imx8mp_evk_defconfig                       |   2 +-
 configs/imx8mq_evk_defconfig                       |   2 +-
 configs/phycore_pcl063_defconfig                   |   2 +-
 configs/phycore_pcl063_ull_defconfig               |   2 +-
 drivers/crypto/fsl/Kconfig                         |   6 +
 drivers/crypto/fsl/jr.c                            |  19 +
 drivers/crypto/fsl/jr.h                            |   2 +
 drivers/net/fec_mxc.c                              |   2 +-
 drivers/thermal/imx_tmu.c                          |   3 +
 41 files changed, 149 insertions(+), 2551 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mm-evk.dts
 delete mode 100644 arch/arm/dts/imx8mm-evk.dtsi
 delete mode 100644 arch/arm/dts/imx8mn-ddr4-evk.dts
 delete mode 100644 arch/arm/dts/imx8mn-evk.dts
 delete mode 100644 arch/arm/dts/imx8mp-evk.dts
 delete mode 100644 arch/arm/dts/imx8mq-evk.dts
