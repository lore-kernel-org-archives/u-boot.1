Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64E7CF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26C888E5F;
	Mon, 30 Sep 2024 04:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aa2zl3l5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6A888F1B; Mon, 30 Sep 2024 03:51:01 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961C288EE3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3a1a412638fso16592035ab.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661040; x=1728265840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3kz1Av5SD+KgJRx52CVVzqzPHwJKjzZrhTyeE4nrmvQ=;
 b=aa2zl3l5WR3B0vcH4RRGfZXLL7cgc37m4vNDntaUZIkVWtxEtTURYFe6kGlDTPXejv
 Qs3BSE+6oMzR3NoBN/PoQNFvkB9TpjsNvY7tvXDgD7BZx1dfRAm6Qpk9TUsLVI6WzHhN
 UsKRFh0NKMxRa0KebLrOa8/nj+/CI969kwI2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661040; x=1728265840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kz1Av5SD+KgJRx52CVVzqzPHwJKjzZrhTyeE4nrmvQ=;
 b=lsT/OkfcMYsvGgFxSS5+vkC7D3ZUqgFcwG2/ZjZlxJWFXIZyTcCrALD0l0NtO2BO1y
 xm9HwRqNuYmhmv0EIgTCYBvK703w5hmBSkGQEDEzimA2jNOp8mbDpTzh7OwA67Bp6wAd
 PSf6i8u1uWuDT64Pd3aoLjDRQvYu6HAsePAT6NMFu00AIK9M1bfC//qCWSiJM+YHyLOH
 Ecse5l+FeErEJ9/ARGxmkbXqF9IMbV7tMgy3uchojjILh+CWAertjrd/TbBc8igH+631
 PtYvVBYFIucLk6eFsAXG5MH6O5LX4T7IVQ5eOUkbQFmpmxqyXrK0crw5myVT+8lPvfH1
 T5kQ==
X-Gm-Message-State: AOJu0Yz4RbTV7leg6Z9ZE8jKtNNnyepO8VDKyrgTnItCm0nRtmsPtIl+
 EbxNA/Onw7It5wX0ZEuw1LI+O5f+OgNcMHVUc81s9ZPwN/H78QPoZZct3mD9LyfzQ+s3pbGLi3A
 JKrNL
X-Google-Smtp-Source: AGHT+IH9gL0e/eloRW+PyRq/Ub8/QCUBVgORUxE63A3fNRs5CanURdW5dQ28s7nmHNZyxpZDcyb9uQ==
X-Received: by 2002:a92:c54f:0:b0:3a0:9952:5fcb with SMTP id
 e9e14a558f8ab-3a3451af2d8mr89117005ab.17.1727661038259; 
 Sun, 29 Sep 2024 18:50:38 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adam Ford <aford173@gmail.com>,
 =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>,
 Dhruva Gole <d-gole@ti.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Harald Seiler <hws@denx.de>,
 Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan 'Kitty' Wang <HuanWang@gehealthcare.com>,
 Ilko Iliev <iliev@ronetix.com>, Jason Liu <jason.hui.liu@nxp.com>,
 =?UTF-8?q?Javier=20Mart=C3=ADnez=20Canillas?= <javier@dowhile0.org>,
 Jesse Taube <Mr.Bossman075@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Matteo Lisi <matteo.lisi@engicam.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Hu <richard.hu@technexion.com>, Stefan Roese <sr@denx.de>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH v3 24/33] board: Use CONFIG_XPL_BUILD instead of
 CONFIG_SPL_BUILD
Date: Sun, 29 Sep 2024 19:49:47 -0600
Message-Id: <20240930014956.1434060-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Sep 2024 04:11:30 +0200
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

Use the new symbol to refer to any 'SPL' build, including TPL and VPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Split into several patches

 board/BuR/brppt1/Makefile                          |  2 +-
 board/BuR/brppt1/board.c                           |  4 ++--
 board/BuR/brppt2/board.c                           |  6 +++---
 board/BuR/brppt2/config.mk                         |  2 +-
 board/BuR/brsmarc1/Makefile                        |  2 +-
 board/BuR/brsmarc1/board.c                         |  8 ++++----
 board/BuR/brxre1/Makefile                          |  2 +-
 board/BuR/brxre1/board.c                           |  4 ++--
 board/BuR/common/common.c                          |  4 ++--
 board/CZ.NIC/turris_1x/Makefile                    |  2 +-
 board/CZ.NIC/turris_1x/tlb.c                       |  2 +-
 board/CZ.NIC/turris_omnia/Makefile                 |  2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c           |  2 +-
 board/Synology/ds414/Makefile                      |  2 +-
 board/advantech/imx8mp_rsb3720a1/Makefile          |  4 ++--
 board/advantech/imx8qm_dmsse20_a1/Makefile         |  2 +-
 board/advantech/imx8qm_rom7720_a1/Makefile         |  2 +-
 board/alliedtelesis/x530/Makefile                  |  2 +-
 board/asus/grouper/Makefile                        |  2 +-
 board/asus/transformer-t30/Makefile                |  2 +-
 board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c    |  2 +-
 board/atmel/at91sam9n12ek/at91sam9n12ek.c          |  2 +-
 board/atmel/at91sam9x5ek/at91sam9x5ek.c            |  2 +-
 board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c    |  2 +-
 .../atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c  |  2 +-
 board/atmel/sama5d2_icp/sama5d2_icp.c              |  2 +-
 board/atmel/sama5d2_xplained/sama5d2_xplained.c    |  2 +-
 board/atmel/sama5d3_xplained/sama5d3_xplained.c    |  2 +-
 board/atmel/sama5d3xek/sama5d3xek.c                |  2 +-
 board/atmel/sama5d4_xplained/sama5d4_xplained.c    |  2 +-
 board/atmel/sama5d4ek/sama5d4ek.c                  |  2 +-
 board/avionic-design/tec-ng/Makefile               |  2 +-
 board/beacon/imx8mm/Makefile                       |  2 +-
 board/beacon/imx8mn/Makefile                       |  2 +-
 board/beacon/imx8mp/Makefile                       |  2 +-
 board/bitmain/antminer_s9/Makefile                 |  2 +-
 board/bosch/acc/acc.c                              |  2 +-
 board/bosch/shc/board.c                            |  4 ++--
 board/bsh/imx6ulz_smm_m2/Makefile                  |  2 +-
 board/bsh/imx8mn_smm_s2/Makefile                   |  2 +-
 board/bticino/mamoj/Makefile                       |  2 +-
 board/cloos/imx8mm_phg/Makefile                    |  2 +-
 board/compulab/cl-som-imx7/Makefile                |  2 +-
 board/compulab/cl-som-imx7/common.h                |  4 ++--
 board/compulab/cl-som-imx7/mux.c                   |  4 ++--
 board/compulab/cm_fx6/Makefile                     |  2 +-
 board/compulab/cm_t43/Makefile                     |  2 +-
 board/compulab/imx8mm-cl-iot-gate/Makefile         |  2 +-
 board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c     |  2 +-
 board/comvetia/lxr2/lxr2.c                         |  2 +-
 board/conclusive/kstr-sama5d27/kstr-sama5d27.c     |  2 +-
 board/congatec/cgtqmx8/Makefile                    |  2 +-
 board/congatec/common/Makefile                     |  2 +-
 board/data_modul/common/common.c                   |  2 +-
 board/data_modul/imx8mm_edm_sbc/Makefile           |  2 +-
 board/data_modul/imx8mp_edm_sbc/Makefile           |  2 +-
 board/davinci/da8xxevm/omapl138_lcdk.c             |  2 +-
 board/dhelectronics/dh_imx6/Makefile               |  2 +-
 board/dhelectronics/dh_imx8mp/Makefile             |  2 +-
 board/dhelectronics/dh_stm32mp1/board.c            |  6 +++---
 board/ea/mx7ulp_com/mx7ulp_com.c                   |  2 +-
 board/eets/pdu001/board.c                          |  2 +-
 board/embest/mx6boards/mx6boards.c                 |  2 +-
 board/engicam/common/Makefile                      |  2 +-
 board/engicam/imx8mm/Makefile                      |  2 +-
 board/engicam/imx8mp/Makefile                      |  2 +-
 board/engicam/stm32mp1/Makefile                    |  2 +-
 board/firefly/firefly-rk3288/firefly-rk3288.c      |  2 +-
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c        |  2 +-
 board/freescale/common/Makefile                    |  6 +++---
 board/freescale/common/cmd_esbc_validate.c         |  2 +-
 board/freescale/common/fsl_chain_of_trust.c        |  8 ++++----
 board/freescale/common/fsl_validate.c              |  4 ++--
 board/freescale/common/qixis.c                     |  2 +-
 board/freescale/imx8mm_evk/Makefile                |  2 +-
 board/freescale/imx8mn_evk/Makefile                |  2 +-
 board/freescale/imx8mp_evk/Makefile                |  2 +-
 board/freescale/imx8mq_evk/Makefile                |  2 +-
 board/freescale/imx8qm_mek/Makefile                |  2 +-
 board/freescale/imx8qxp_mek/Makefile               |  2 +-
 board/freescale/imx8ulp_evk/Makefile               |  2 +-
 board/freescale/imx93_evk/Makefile                 |  2 +-
 board/freescale/imxrt1020-evk/imxrt1020-evk.c      |  2 +-
 board/freescale/imxrt1050-evk/imxrt1050-evk.c      |  2 +-
 board/freescale/imxrt1170-evk/imxrt1170-evk.c      |  2 +-
 board/freescale/ls1012afrdm/ls1012afrdm.c          |  2 +-
 board/freescale/ls1012aqds/ls1012aqds.c            |  2 +-
 board/freescale/ls1012ardb/ls1012ardb.c            |  2 +-
 board/freescale/ls1021aiot/ls1021aiot.c            |  4 ++--
 board/freescale/ls1021aqds/ddr.c                   |  4 ++--
 board/freescale/ls1021aqds/ls1021aqds.c            |  2 +-
 board/freescale/ls1021atsn/ls1021atsn.c            | 10 +++++-----
 board/freescale/ls1021atwr/ls1021atwr.c            | 10 +++++-----
 board/freescale/ls1028a/ls1028a.c                  |  2 +-
 board/freescale/ls1043aqds/Makefile                |  2 +-
 board/freescale/ls1043aqds/ddr.c                   |  2 +-
 board/freescale/ls1043aqds/ls1043aqds.c            |  2 +-
 board/freescale/ls1043ardb/Makefile                |  2 +-
 board/freescale/ls1043ardb/ddr.c                   |  4 ++--
 board/freescale/ls1043ardb/ls1043ardb.c            |  2 +-
 board/freescale/ls1046aqds/Makefile                |  2 +-
 board/freescale/ls1046aqds/ddr.c                   |  2 +-
 board/freescale/ls1046aqds/ls1046aqds.c            |  2 +-
 board/freescale/ls1046ardb/Makefile                |  2 +-
 board/freescale/ls1046ardb/ddr.c                   |  2 +-
 board/freescale/ls1046ardb/ls1046ardb.c            |  2 +-
 board/freescale/ls1088a/Makefile                   |  2 +-
 board/freescale/ls1088a/ddr.c                      |  6 +++---
 board/freescale/ls1088a/ls1088a.c                  |  8 ++++----
 board/freescale/ls2080aqds/ddr.c                   |  2 +-
 board/freescale/ls2080aqds/ls2080aqds.c            |  4 ++--
 board/freescale/ls2080ardb/ddr.c                   |  2 +-
 board/freescale/ls2080ardb/eth_ls2080rdb.c         |  2 +-
 board/freescale/lx2160a/lx2160a.c                  |  2 +-
 board/freescale/mx23evk/Makefile                   |  2 +-
 board/freescale/mx28evk/Makefile                   |  2 +-
 board/freescale/mx6memcal/Makefile                 |  2 +-
 board/freescale/mx6sabreauto/mx6sabreauto.c        |  2 +-
 board/freescale/mx6sabresd/mx6sabresd.c            |  2 +-
 board/freescale/mx6slevk/mx6slevk.c                |  4 ++--
 board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c  |  4 ++--
 board/freescale/p1010rdb/Makefile                  |  4 ++--
 board/freescale/p1010rdb/p1010rdb.c                |  2 +-
 board/freescale/p1010rdb/tlb.c                     |  2 +-
 board/freescale/p1_p2_rdb_pc/Makefile              |  4 ++--
 board/freescale/p1_p2_rdb_pc/tlb.c                 |  2 +-
 board/freescale/t102xrdb/Makefile                  |  2 +-
 board/freescale/t102xrdb/ddr.c                     |  4 ++--
 board/freescale/t102xrdb/tlb.c                     |  4 ++--
 board/freescale/t104xrdb/Makefile                  |  2 +-
 board/freescale/t104xrdb/ddr.c                     |  4 ++--
 board/freescale/t104xrdb/tlb.c                     |  6 +++---
 board/freescale/t208xqds/Makefile                  |  2 +-
 board/freescale/t208xqds/ddr.c                     |  2 +-
 board/freescale/t208xqds/tlb.c                     |  4 ++--
 board/freescale/t208xrdb/Makefile                  |  2 +-
 board/freescale/t208xrdb/ddr.c                     |  2 +-
 board/freescale/t208xrdb/tlb.c                     |  4 ++--
 board/freescale/t4rdb/Makefile                     |  2 +-
 board/freescale/t4rdb/cpld.c                       |  2 +-
 board/freescale/t4rdb/ddr.c                        |  2 +-
 board/freescale/t4rdb/tlb.c                        |  4 ++--
 board/gardena/smart-gateway-at91sam/Makefile       |  2 +-
 board/gardena/smart-gateway-mt7688/board.c         |  2 +-
 board/gateworks/gw_ventana/Makefile                |  2 +-
 board/gateworks/gw_ventana/eeprom.c                |  2 +-
 board/gateworks/venice/Makefile                    |  2 +-
 board/gdsys/a38x/Makefile                          |  2 +-
 board/gdsys/a38x/controlcenterdc.c                 | 12 ++++++------
 board/ge/b1x5v2/b1x5v2.c                           |  4 ++--
 board/ge/b1x5v2/spl.c                              |  2 +-
 board/google/chromebook_coral/coral.c              |  2 +-
 board/google/gru/gru.c                             |  4 ++--
 board/google/imx8mq_phanbell/Makefile              |  2 +-
 board/google/veyron/veyron.c                       |  2 +-
 board/grinn/chiliboard/board.c                     |  2 +-
 board/grinn/liteboard/board.c                      |  2 +-
 board/htc/endeavoru/Makefile                       |  2 +-
 board/imgtec/ci20/ci20.c                           |  4 ++--
 board/isee/igep003x/Makefile                       |  2 +-
 board/isee/igep003x/board.c                        |  2 +-
 board/isee/igep00x0/Makefile                       |  2 +-
 board/k+p/kp_imx6q_tpc/Makefile                    |  2 +-
 board/kontron/pitx_imx8m/Makefile                  |  2 +-
 board/kontron/sl-mx6ul/Makefile                    |  2 +-
 board/kontron/sl-mx8mm/Makefile                    |  2 +-
 board/kontron/sl28/Makefile                        |  4 ++--
 board/kontron/sl28/ddr.c                           |  2 +-
 board/kosagi/novena/Makefile                       |  2 +-
 board/lenovo/ideapad-yoga-11/Makefile              |  2 +-
 board/lg/sniper/sniper.c                           |  2 +-
 board/lg/x3-t30/Makefile                           |  2 +-
 board/liebherr/display5/Makefile                   |  2 +-
 board/liebherr/mccmon6/Makefile                    |  2 +-
 board/liebherr/xea/Makefile                        |  2 +-
 board/liebherr/xea/xea.c                           |  6 +++---
 board/logicpd/am3517evm/am3517evm.c                |  2 +-
 board/logicpd/imx6/imx6logic.c                     |  2 +-
 board/logicpd/omap3som/omap3logic.c                |  2 +-
 board/menlo/m53menlo/m53menlo.c                    |  2 +-
 board/menlo/mx8menlo/Makefile                      |  4 ++--
 board/microsoft/surface-rt/Makefile                |  2 +-
 board/mntre/imx8mq_reform2/Makefile                |  2 +-
 board/msc/sm2s_imx8mp/Makefile                     |  2 +-
 board/myir/mys_6ulx/Makefile                       |  2 +-
 board/nvidia/beaver/Makefile                       |  2 +-
 board/nvidia/cardhu/Makefile                       |  2 +-
 board/olimex/mx23_olinuxino/Makefile               |  2 +-
 board/opalkelly/zynq/Makefile                      |  2 +-
 board/phytec/common/Makefile                       |  2 +-
 board/phytec/pcl063/Makefile                       |  2 +-
 board/phytec/pcm058/pcm058.c                       |  2 +-
 board/phytec/phycore_am335x_r2/Makefile            |  2 +-
 board/phytec/phycore_am335x_r2/board.c             |  2 +-
 board/phytec/phycore_am62x/phycore-am62x.c         |  2 +-
 board/phytec/phycore_imx8mm/Makefile               |  2 +-
 board/phytec/phycore_imx8mp/Makefile               |  2 +-
 board/phytec/phycore_imx93/Makefile                |  2 +-
 board/polyhex/imx8mp_debix_model_a/Makefile        |  2 +-
 board/purism/librem5/Makefile                      |  2 +-
 board/purism/librem5/librem5.h                     |  4 ++--
 board/radxa/rockpi4-rk3399/rockpi4-rk3399.c        |  4 ++--
 board/renesas/alt/Makefile                         |  2 +-
 board/renesas/condor/Makefile                      |  2 +-
 board/renesas/draak/Makefile                       |  2 +-
 board/renesas/eagle/Makefile                       |  2 +-
 board/renesas/ebisu/Makefile                       |  2 +-
 board/renesas/falcon/Makefile                      |  2 +-
 board/renesas/gose/Makefile                        |  2 +-
 board/renesas/koelsch/Makefile                     |  2 +-
 board/renesas/lager/Makefile                       |  2 +-
 board/renesas/porter/Makefile                      |  2 +-
 board/renesas/salvator-x/Makefile                  |  2 +-
 board/renesas/silk/Makefile                        |  2 +-
 board/renesas/stout/Makefile                       |  2 +-
 board/renesas/ulcb/Makefile                        |  2 +-
 board/renesas/v3hsk/Makefile                       |  2 +-
 board/renesas/v3msk/Makefile                       |  2 +-
 board/ronetix/imx7-cm/Makefile                     |  2 +-
 board/ronetix/imx8mq-cm/Makefile                   |  2 +-
 board/samsung/common/Makefile                      |  2 +-
 board/samsung/origen/Makefile                      |  2 +-
 board/samsung/smdkv310/Makefile                    |  2 +-
 board/seeed/npi_imx6ull/Makefile                   |  2 +-
 board/sielaff/imx6dl-sielaff/Makefile              |  2 +-
 board/siemens/capricorn/Makefile                   |  2 +-
 board/siemens/capricorn/board.c                    |  8 ++++----
 board/siemens/common/board_am335x.c                | 12 ++++++------
 board/siemens/common/board_am335x.h                |  4 ++--
 board/siemens/common/factoryset.c                  |  4 ++--
 board/siemens/corvus/board.c                       |  2 +-
 board/siemens/draco/Makefile                       |  4 ++--
 board/siemens/draco/board.c                        | 14 +++++++-------
 board/siemens/pxm2/Makefile                        |  4 ++--
 board/siemens/pxm2/board.c                         | 14 +++++++-------
 board/siemens/rut/Makefile                         |  4 ++--
 board/siemens/rut/board.c                          |  8 ++++----
 board/siemens/smartweb/smartweb.c                  |  2 +-
 board/siemens/taurus/taurus.c                      |  4 ++--
 board/sifive/unleashed/Makefile                    |  2 +-
 board/sifive/unmatched/Makefile                    |  2 +-
 board/silinux/ek874/Makefile                       |  2 +-
 board/softing/vining_2000/vining_2000.c            |  2 +-
 board/softing/vining_fpga/socfpga.c                |  2 +-
 board/solidrun/mx6cuboxi/mx6cuboxi.c               |  2 +-
 board/st/common/cmd_stboard.c                      |  2 +-
 board/st/stm32f746-disco/stm32f746-disco.c         |  4 ++--
 board/st/stm32mp1/Makefile                         |  2 +-
 board/starfive/visionfive2/Makefile                |  2 +-
 board/sunxi/board.c                                |  6 +++---
 board/tcl/sl50/board.c                             | 14 +++++++-------
 board/technexion/pico-imx6/spl.c                   |  2 +-
 board/technexion/pico-imx6ul/spl.c                 |  2 +-
 board/technexion/pico-imx7d/spl.c                  |  2 +-
 board/technexion/pico-imx8mq/Makefile              |  2 +-
 board/theadorable/theadorable.c                    |  6 +++---
 board/theobroma-systems/jaguar_rk3588/Makefile     |  2 +-
 board/theobroma-systems/puma_rk3399/Makefile       |  2 +-
 board/theobroma-systems/ringneck_px30/Makefile     |  2 +-
 board/theobroma-systems/tiger_rk3588/Makefile      |  2 +-
 board/ti/am335x/board.c                            | 12 ++++++------
 board/ti/am57xx/board.c                            | 10 +++++-----
 board/ti/am62x/evm.c                               |  2 +-
 board/ti/am64x/evm.c                               |  2 +-
 board/ti/common/board_detect.c                     |  6 +++---
 board/ti/dra7xx/evm.c                              |  6 +++---
 board/ti/j721e/evm.c                               |  6 +++---
 board/ti/j721s2/evm.c                              |  4 ++--
 board/ti/ks2_evm/board.c                           |  2 +-
 board/ti/ks2_evm/board_k2e.c                       |  2 +-
 board/ti/ks2_evm/board_k2g.c                       |  4 ++--
 board/ti/ks2_evm/board_k2hk.c                      |  2 +-
 board/ti/ks2_evm/board_k2l.c                       |  2 +-
 board/ti/omap3evm/evm.c                            |  4 ++--
 board/timll/devkit8000/devkit8000.c                |  2 +-
 board/topic/zynq/Makefile                          |  2 +-
 board/toradex/apalis_imx6/apalis_imx6.c            | 12 ++++++------
 board/toradex/apalis_imx6/do_fuse.c                |  4 ++--
 board/toradex/apalis_imx6/pf0100.c                 |  4 ++--
 board/toradex/apalis_t30/Makefile                  |  2 +-
 board/toradex/colibri_imx6/colibri_imx6.c          | 12 ++++++------
 board/toradex/colibri_imx6/do_fuse.c               |  4 ++--
 board/toradex/colibri_imx6/pf0100.c                |  4 ++--
 board/toradex/colibri_t30/Makefile                 |  2 +-
 board/toradex/common/Makefile                      |  2 +-
 board/toradex/verdin-imx8mm/Makefile               |  2 +-
 board/toradex/verdin-imx8mp/Makefile               |  2 +-
 board/udoo/neo/neo.c                               |  2 +-
 board/udoo/udoo_spl.c                              |  2 +-
 board/variscite/common/imx9_eeprom.c               |  2 +-
 board/variscite/dart_6ul/Makefile                  |  2 +-
 board/variscite/imx8mn_var_som/Makefile            |  2 +-
 board/variscite/imx8mn_var_som/imx8mn_var_som.c    |  4 ++--
 board/variscite/imx93_var_som/Makefile             |  2 +-
 board/vscom/baltos/board.c                         | 14 +++++++-------
 board/wandboard/Makefile                           |  2 +-
 board/wexler/qc750/Makefile                        |  2 +-
 board/work-microwave/work_92105/Makefile           |  2 +-
 board/xilinx/common/Makefile                       |  2 +-
 board/xilinx/common/board.c                        |  6 +++---
 .../xilinx/microblaze-generic/microblaze-generic.c |  2 +-
 board/xilinx/zynq/Makefile                         |  6 +++---
 board/xilinx/zynq/board.c                          |  4 ++--
 board/xilinx/zynqmp/Makefile                       |  6 +++---
 board/xilinx/zynqmp/zynqmp.c                       |  6 +++---
 305 files changed, 456 insertions(+), 456 deletions(-)

diff --git a/board/BuR/brppt1/Makefile b/board/BuR/brppt1/Makefile
index 3dec0e6522a..417afacad15 100644
--- a/board/BuR/brppt1/Makefile
+++ b/board/BuR/brppt1/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 2013 Hannes Schmelzer <oe5hpm@oevsv.at>
 # Bernecker & Rainer Industrieelektronik GmbH - http://www.br-automation.com
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-y	:= mux.o
 endif
 obj-y	+= ../common/common.o
diff --git a/board/BuR/brppt1/board.c b/board/BuR/brppt1/board.c
index 80e0ca805b5..8b7def06cc4 100644
--- a/board/BuR/brppt1/board.c
+++ b/board/BuR/brppt1/board.c
@@ -38,7 +38,7 @@ DECLARE_GLOBAL_DATA_PTR;
 /* -- defines for GPIO -- */
 #define	REPSWITCH	(0+20)	/* GPIO0_20 */
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 /* TODO: check ram-timing ! */
 static const struct ddr_data ddr3_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
@@ -142,7 +142,7 @@ void sdram_init(void)
 		   &ddr3_cmd_ctrl_data,
 		   &ddr3_emif_reg_data, 0);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* Basic board specific setup.  Pinmux has been handled already. */
 int board_init(void)
diff --git a/board/BuR/brppt2/board.c b/board/BuR/brppt2/board.c
index 105fac8912d..c0a163251b4 100644
--- a/board/BuR/brppt2/board.c
+++ b/board/BuR/brppt2/board.c
@@ -16,7 +16,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/iomux.h>
 #include <asm/arch/mx6-pins.h>
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 # include <asm/arch/mx6-ddr.h>
 #endif
 #include <asm/arch/clock.h>
@@ -82,7 +82,7 @@
 
 #define MUXDESC(pad, ctrl)	IOMUX_PADS(pad | MUX_PAD_CTRL(ctrl))
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 static iomux_v3_cfg_t const eth_pads[] = {
 	/*
 	 * Gigabit Ethernet
@@ -542,4 +542,4 @@ void board_init_f(ulong dummy)
 void reset_cpu(void)
 {
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/BuR/brppt2/config.mk b/board/BuR/brppt2/config.mk
index 0d1638a97ac..f2362d16dc4 100644
--- a/board/BuR/brppt2/config.mk
+++ b/board/BuR/brppt2/config.mk
@@ -23,7 +23,7 @@ cmd_prodzip =					\
 	zip -9 -r $@ misc/* >/dev/null $<
 
 ifeq ($(hw-platform-y),brppt2)
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 INPUTS-y += $(hw-platform-y)_prog.bin
 INPUTS-y += $(hw-platform-y)_prod.zip
 endif
diff --git a/board/BuR/brsmarc1/Makefile b/board/BuR/brsmarc1/Makefile
index 1c3f64dea4d..42b647af58d 100644
--- a/board/BuR/brsmarc1/Makefile
+++ b/board/BuR/brsmarc1/Makefile
@@ -4,7 +4,7 @@
 # B&R Industrial Automation GmbH - http://www.br-automation.com/
 #
 
-obj-$(CONFIG_SPL_BUILD) += mux.o
+obj-$(CONFIG_XPL_BUILD) += mux.o
 obj-y	+= ../common/br_resetc.o
 obj-y	+= ../common/common.o
 obj-y	+= board.o
diff --git a/board/BuR/brsmarc1/board.c b/board/BuR/brsmarc1/board.c
index bfb6adf6d5c..c05eec6b35e 100644
--- a/board/BuR/brsmarc1/board.c
+++ b/board/BuR/brsmarc1/board.c
@@ -32,7 +32,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static const struct ddr_data ddr3_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
 	.datawdsratio0 = MT41K256M16HA125E_WR_DQS,
@@ -124,8 +124,8 @@ void sdram_init(void)
 		   &ddr3_cmd_ctrl_data,
 		   &ddr3_emif_reg_data, 0);
 }
-#endif /* CONFIG_SPL_BUILD */
-#if !defined(CONFIG_SPL_BUILD)
+#endif /* CONFIG_XPL_BUILD */
+#if !defined(CONFIG_XPL_BUILD)
 
 /* decision if backlight is switched on or not on powerup */
 int board_backlightstate(void)
@@ -166,4 +166,4 @@ int board_late_init(void)
 }
 
 #endif /* CONFIG_BOARD_LATE_INIT */
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/BuR/brxre1/Makefile b/board/BuR/brxre1/Makefile
index 1d224e9e719..c4b1a67be3e 100644
--- a/board/BuR/brxre1/Makefile
+++ b/board/BuR/brxre1/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 2014 Hannes Schmelzer <oe5hpm@oevsv.at> -
 # Bernecker & Rainer Industrielektronik GmbH - http://www.br-automation.com/
 
-obj-$(CONFIG_SPL_BUILD) += mux.o
+obj-$(CONFIG_XPL_BUILD) += mux.o
 obj-y	+= ../common/br_resetc.o
 obj-y	+= ../common/common.o
 obj-y	+= board.o
diff --git a/board/BuR/brxre1/board.c b/board/BuR/brxre1/board.c
index 510d2af3147..c25af42e70a 100644
--- a/board/BuR/brxre1/board.c
+++ b/board/BuR/brxre1/board.c
@@ -39,7 +39,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static const struct ddr_data ddr3_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
 	.datawdsratio0 = MT41K256M16HA125E_WR_DQS,
@@ -134,7 +134,7 @@ void sdram_init(void)
 		   &ddr3_cmd_ctrl_data,
 		   &ddr3_emif_reg_data, 0);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 /*
  * Basic board specific setup.  Pinmux has been handled already.
  */
diff --git a/board/BuR/common/common.c b/board/BuR/common/common.c
index 8aff821cfe8..7fb61736710 100644
--- a/board/BuR/common/common.c
+++ b/board/BuR/common/common.c
@@ -83,7 +83,7 @@ int overwrite_console(void)
 	return 1;
 }
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_AM33XX)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_AM33XX)
 #include <asm/arch/hardware.h>
 #include <asm/arch/omap.h>
 #include <asm/arch/clock.h>
@@ -175,4 +175,4 @@ void set_mux_conf_regs(void)
 	enable_board_pin_mux();
 }
 
-#endif /* CONFIG_SPL_BUILD && CONFIG_AM33XX */
+#endif /* CONFIG_XPL_BUILD && CONFIG_AM33XX */
diff --git a/board/CZ.NIC/turris_1x/Makefile b/board/CZ.NIC/turris_1x/Makefile
index a24aee9161b..1bf370122d9 100644
--- a/board/CZ.NIC/turris_1x/Makefile
+++ b/board/CZ.NIC/turris_1x/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # (C) 2022 Pali Rohár <pali@kernel.org>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= ../../freescale/p1_p2_rdb_pc/spl.o
 endif
 
diff --git a/board/CZ.NIC/turris_1x/tlb.c b/board/CZ.NIC/turris_1x/tlb.c
index f35a5558385..5e5892ee1e5 100644
--- a/board/CZ.NIC/turris_1x/tlb.c
+++ b/board/CZ.NIC/turris_1x/tlb.c
@@ -111,7 +111,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      0, 9, BOOKE_PAGESZ_256K, 1),
 #endif
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	/* **M** - SDRAM 2G */
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE,
 		      CFG_SYS_DDR_SDRAM_BASE,
diff --git a/board/CZ.NIC/turris_omnia/Makefile b/board/CZ.NIC/turris_omnia/Makefile
index d1ef5cb8600..acaa3b8ef31 100644
--- a/board/CZ.NIC/turris_omnia/Makefile
+++ b/board/CZ.NIC/turris_omnia/Makefile
@@ -4,4 +4,4 @@
 
 obj-y	:= turris_omnia.o ../turris_atsha_otp.o ../turris_common.o
 obj-$(CONFIG_CMD_EEPROM_LAYOUT)	+= eeprom.o
-obj-$(CONFIG_SPL_BUILD)		+= old_ddr3_training.o
+obj-$(CONFIG_XPL_BUILD)		+= old_ddr3_training.o
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index eb88ee7f1ed..b7588fa4eec 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -494,7 +494,7 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
 	if (!eeprom)
 		return false;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
 	else
 		ret = i2c_eeprom_read(eeprom, 0, (void *)oep, sizeof(*oep));
diff --git a/board/Synology/ds414/Makefile b/board/Synology/ds414/Makefile
index b1d018effaa..1a10e9d8d54 100644
--- a/board/Synology/ds414/Makefile
+++ b/board/Synology/ds414/Makefile
@@ -3,6 +3,6 @@
 # Copyright (C) 2015 Phil Sutter <phil@nwl.cc>
 
 obj-y	+= ds414.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y	+= cmd_syno.o
 endif
diff --git a/board/advantech/imx8mp_rsb3720a1/Makefile b/board/advantech/imx8mp_rsb3720a1/Makefile
index eb6b18b04a2..39fb0d4fb62 100644
--- a/board/advantech/imx8mp_rsb3720a1/Makefile
+++ b/board/advantech/imx8mp_rsb3720a1/Makefile
@@ -8,7 +8,7 @@
 ifdef CONFIG_TARGET_IMX8MP_RSB3720A1_6G
 obj-y += imx8mp_rsb3720a1.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_rsb3720a1_6G.o
 endif
@@ -17,7 +17,7 @@ endif
 ifdef CONFIG_TARGET_IMX8MP_RSB3720A1_4G
 obj-y += imx8mp_rsb3720a1.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_rsb3720a1_4G.o
 endif
diff --git a/board/advantech/imx8qm_dmsse20_a1/Makefile b/board/advantech/imx8qm_dmsse20_a1/Makefile
index 262ffcd6834..c82fcc85636 100644
--- a/board/advantech/imx8qm_dmsse20_a1/Makefile
+++ b/board/advantech/imx8qm_dmsse20_a1/Makefile
@@ -5,4 +5,4 @@
 #
 
 obj-y += imx8qm_dmsse20_a1.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/advantech/imx8qm_rom7720_a1/Makefile b/board/advantech/imx8qm_rom7720_a1/Makefile
index 51c5de251c4..d8792c6c687 100644
--- a/board/advantech/imx8qm_rom7720_a1/Makefile
+++ b/board/advantech/imx8qm_rom7720_a1/Makefile
@@ -6,6 +6,6 @@
 
 obj-y += imx8qm_rom7720_a1.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 endif
diff --git a/board/alliedtelesis/x530/Makefile b/board/alliedtelesis/x530/Makefile
index 97de1d463fe..467c55d7e66 100644
--- a/board/alliedtelesis/x530/Makefile
+++ b/board/alliedtelesis/x530/Makefile
@@ -4,6 +4,6 @@
 #
 
 obj-y	:= $(BOARD).o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y	+= ../common/gpio_hog.o
 endif
diff --git a/board/asus/grouper/Makefile b/board/asus/grouper/Makefile
index d041cf80870..05c6ffb405b 100644
--- a/board/asus/grouper/Makefile
+++ b/board/asus/grouper/Makefile
@@ -6,7 +6,7 @@
 #  (C) Copyright 2021
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_DM_PMIC_MAX77663) += grouper-spl-max.o
 obj-$(CONFIG_DM_PMIC_TPS65910) += grouper-spl-ti.o
 endif
diff --git a/board/asus/transformer-t30/Makefile b/board/asus/transformer-t30/Makefile
index c083f2289ba..ad700786b70 100644
--- a/board/asus/transformer-t30/Makefile
+++ b/board/asus/transformer-t30/Makefile
@@ -6,6 +6,6 @@
 #  (C) Copyright 2021
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-obj-$(CONFIG_SPL_BUILD) += transformer-t30-spl.o
+obj-$(CONFIG_XPL_BUILD) += transformer-t30-spl.o
 
 obj-y += transformer-t30.o
diff --git a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
index af486e977e5..d94904366ed 100644
--- a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
+++ b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
@@ -70,7 +70,7 @@ void at91sam9m10g45ek_nand_hw_init(void)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 
diff --git a/board/atmel/at91sam9n12ek/at91sam9n12ek.c b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
index 6f9abcbb127..2cddc2175ac 100644
--- a/board/atmel/at91sam9n12ek/at91sam9n12ek.c
+++ b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
@@ -119,7 +119,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 
diff --git a/board/atmel/at91sam9x5ek/at91sam9x5ek.c b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
index f52b9a97731..3f41fb1c983 100644
--- a/board/atmel/at91sam9x5ek/at91sam9x5ek.c
+++ b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
@@ -134,7 +134,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 
diff --git a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
index cb3cd7ac9ae..bf54fc33df4 100644
--- a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
+++ b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
@@ -105,7 +105,7 @@ int misc_init_r(void)
 #endif
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 }
diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index 15cbd0daa6f..04de1257eca 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -90,7 +90,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 static void board_leds_init(void)
 {
diff --git a/board/atmel/sama5d2_icp/sama5d2_icp.c b/board/atmel/sama5d2_icp/sama5d2_icp.c
index 6f0d578abf7..113bd2feb62 100644
--- a/board/atmel/sama5d2_icp/sama5d2_icp.c
+++ b/board/atmel/sama5d2_icp/sama5d2_icp.c
@@ -79,7 +79,7 @@ int misc_init_r(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 /* must set PB25 low to enable the CAN transceivers */
 static void board_can_stdby_dis(void)
diff --git a/board/atmel/sama5d2_xplained/sama5d2_xplained.c b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
index d104736fa7c..eca5b2bf107 100644
--- a/board/atmel/sama5d2_xplained/sama5d2_xplained.c
+++ b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
@@ -105,7 +105,7 @@ int misc_init_r(void)
 #endif
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 }
diff --git a/board/atmel/sama5d3_xplained/sama5d3_xplained.c b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
index f98322fb540..7a813c19ff2 100644
--- a/board/atmel/sama5d3_xplained/sama5d3_xplained.c
+++ b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
@@ -117,7 +117,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 #ifdef CONFIG_SD_BOOT
diff --git a/board/atmel/sama5d3xek/sama5d3xek.c b/board/atmel/sama5d3xek/sama5d3xek.c
index 28079a81517..555a8c0970b 100644
--- a/board/atmel/sama5d3xek/sama5d3xek.c
+++ b/board/atmel/sama5d3xek/sama5d3xek.c
@@ -194,7 +194,7 @@ int board_late_init(void)
 #endif
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 #if CONFIG_NAND_BOOT
diff --git a/board/atmel/sama5d4_xplained/sama5d4_xplained.c b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
index f9112fc5321..e296b0466aa 100644
--- a/board/atmel/sama5d4_xplained/sama5d4_xplained.c
+++ b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
@@ -141,7 +141,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 #if CONFIG_NAND_BOOT
diff --git a/board/atmel/sama5d4ek/sama5d4ek.c b/board/atmel/sama5d4ek/sama5d4ek.c
index 0bdc6adbdc8..e820605d3b9 100644
--- a/board/atmel/sama5d4ek/sama5d4ek.c
+++ b/board/atmel/sama5d4ek/sama5d4ek.c
@@ -127,7 +127,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 #if CONFIG_NAND_BOOT
diff --git a/board/avionic-design/tec-ng/Makefile b/board/avionic-design/tec-ng/Makefile
index d6890e5797f..ec1710e137e 100644
--- a/board/avionic-design/tec-ng/Makefile
+++ b/board/avionic-design/tec-ng/Makefile
@@ -3,6 +3,6 @@
 # (C) Copyright 2013
 # Avionic Design GmbH <www.avionic-design.de>
 
-obj-$(CONFIG_SPL_BUILD) += tec-ng-spl.o
+obj-$(CONFIG_XPL_BUILD) += tec-ng-spl.o
 
 obj-y	+= ../common/tamonten-ng.o
diff --git a/board/beacon/imx8mm/Makefile b/board/beacon/imx8mm/Makefile
index 7d3bd3112cb..b33dc8b05b9 100644
--- a/board/beacon/imx8mm/Makefile
+++ b/board/beacon/imx8mm/Makefile
@@ -7,7 +7,7 @@
 obj-y += imx8mm_beacon.o
 obj-y += ../../freescale/common/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-y += lpddr4_timing.o
 endif
diff --git a/board/beacon/imx8mn/Makefile b/board/beacon/imx8mn/Makefile
index d620ccb7723..48b7b0952cc 100644
--- a/board/beacon/imx8mn/Makefile
+++ b/board/beacon/imx8mn/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mn_beacon.o
 obj-y += ../../freescale/common/
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 ifdef CONFIG_IMX8MN_BEACON_2GB_LPDDR
 obj-y += lpddr4_2g_timing.o
diff --git a/board/beacon/imx8mp/Makefile b/board/beacon/imx8mp/Makefile
index 264720f6d49..7b994d2c8a1 100644
--- a/board/beacon/imx8mp/Makefile
+++ b/board/beacon/imx8mp/Makefile
@@ -7,7 +7,7 @@
 obj-y += imx8mp_beacon.o
 obj-y += ../../freescale/common/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/bitmain/antminer_s9/Makefile b/board/bitmain/antminer_s9/Makefile
index 1af01d6d808..57580f3730b 100644
--- a/board/bitmain/antminer_s9/Makefile
+++ b/board/bitmain/antminer_s9/Makefile
@@ -6,4 +6,4 @@ obj-y	+= ../../xilinx/common/board.o
 # Remove quotes
 hw-platform-y :=$(shell echo $(CONFIG_DEFAULT_DEVICE_TREE))
 
-obj-$(CONFIG_SPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
+obj-$(CONFIG_XPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
diff --git a/board/bosch/acc/acc.c b/board/bosch/acc/acc.c
index a1a00e7ffc4..4c7c9d38a44 100644
--- a/board/bosch/acc/acc.c
+++ b/board/bosch/acc/acc.c
@@ -269,7 +269,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 #include <asm/arch/crm_regs.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/iomux.h>
diff --git a/board/bosch/shc/board.c b/board/bosch/shc/board.c
index 1f9dc2d8df1..02f51ca2ca8 100644
--- a/board/bosch/shc/board.c
+++ b/board/bosch/shc/board.c
@@ -259,7 +259,7 @@ static void check_button_status(void)
 	}
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
@@ -473,7 +473,7 @@ int board_late_init(void)
 #endif
 
 #if defined(CONFIG_USB_ETHER) && \
-	(!defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_USB_ETHER))
+	(!defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_USB_ETHER))
 int board_eth_init(struct bd_info *bis)
 {
 	return usb_eth_initialize(bis);
diff --git a/board/bsh/imx6ulz_smm_m2/Makefile b/board/bsh/imx6ulz_smm_m2/Makefile
index b761bbb2f90..59870419bdd 100644
--- a/board/bsh/imx6ulz_smm_m2/Makefile
+++ b/board/bsh/imx6ulz_smm_m2/Makefile
@@ -2,5 +2,5 @@
 # (C) Copyright 2021 Amarula Solutions B.V.
 
 obj-y  := imx6ulz_smm_m2.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
 
diff --git a/board/bsh/imx8mn_smm_s2/Makefile b/board/bsh/imx8mn_smm_s2/Makefile
index 19d37a723ea..3050194ff89 100644
--- a/board/bsh/imx8mn_smm_s2/Makefile
+++ b/board/bsh/imx8mn_smm_s2/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mn_smm_s2.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_BSH_SMM_S2_DDR3L_256) += ddr3l_timing_256m.o
 obj-$(CONFIG_BSH_SMM_S2_DDR3L_512) += ddr3l_timing_512m.o
diff --git a/board/bticino/mamoj/Makefile b/board/bticino/mamoj/Makefile
index f1ddda48918..b83e667e828 100644
--- a/board/bticino/mamoj/Makefile
+++ b/board/bticino/mamoj/Makefile
@@ -5,4 +5,4 @@
 #
 
 obj-y := mamoj.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/cloos/imx8mm_phg/Makefile b/board/cloos/imx8mm_phg/Makefile
index 2b36931fcf7..c3e54bfc2e0 100644
--- a/board/cloos/imx8mm_phg/Makefile
+++ b/board/cloos/imx8mm_phg/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mm_phg.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/compulab/cl-som-imx7/Makefile b/board/compulab/cl-som-imx7/Makefile
index 8f0e068b7e9..35cf2c13562 100644
--- a/board/compulab/cl-som-imx7/Makefile
+++ b/board/compulab/cl-som-imx7/Makefile
@@ -10,7 +10,7 @@
 
 obj-y := mux.o common.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y  += spl.o
 else
 obj-y  += cl-som-imx7.o
diff --git a/board/compulab/cl-som-imx7/common.h b/board/compulab/cl-som-imx7/common.h
index bc19867f876..5b29763b340 100644
--- a/board/compulab/cl-som-imx7/common.h
+++ b/board/compulab/cl-som-imx7/common.h
@@ -18,7 +18,7 @@ PADS_SET_PROT(uart1_pads);
 PADS_SET_PROT(espi1_pads);
 #endif /* CONFIG_SPI */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #ifdef CONFIG_FSL_ESDHC_IMX
 PADS_SET_PROT(usdhc3_emmc_pads);
 #endif /* CONFIG_FSL_ESDHC_IMX */
@@ -28,4 +28,4 @@ PADS_SET_PROT(fec1_pads);
 #endif /* CONFIG_FEC_MXC */
 PADS_SET_PROT(usb_otg1_pads);
 PADS_SET_PROT(wdog_pads);
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/compulab/cl-som-imx7/mux.c b/board/compulab/cl-som-imx7/mux.c
index 25123ee145a..da8848b9f57 100644
--- a/board/compulab/cl-som-imx7/mux.c
+++ b/board/compulab/cl-som-imx7/mux.c
@@ -67,7 +67,7 @@ PADS_SET(espi1_pads)
 
 #endif /* CONFIG_SPI */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #ifdef CONFIG_FSL_ESDHC_IMX
 
@@ -138,4 +138,4 @@ static iomux_v3_cfg_t const wdog_pads[] = {
 
 PADS_SET(wdog_pads)
 
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/compulab/cm_fx6/Makefile b/board/compulab/cm_fx6/Makefile
index e648db26a1d..e9f86cb8410 100644
--- a/board/compulab/cm_fx6/Makefile
+++ b/board/compulab/cm_fx6/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2014 CompuLab, Ltd. <www.compulab.co.il>
 #
 # Authors: Nikita Kiryanov <nikita@compulab.co.il>
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y = common.o spl.o
 else
 obj-y = common.o cm_fx6.o
diff --git a/board/compulab/cm_t43/Makefile b/board/compulab/cm_t43/Makefile
index 6fa231a045e..221d1b432fd 100644
--- a/board/compulab/cm_t43/Makefile
+++ b/board/compulab/cm_t43/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2015 Compulab, Ltd.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o mux.o
 else
 obj-y	+= cm_t43.o mux.o
diff --git a/board/compulab/imx8mm-cl-iot-gate/Makefile b/board/compulab/imx8mm-cl-iot-gate/Makefile
index 3800b21a6fd..7c2d6e508b3 100644
--- a/board/compulab/imx8mm-cl-iot-gate/Makefile
+++ b/board/compulab/imx8mm-cl-iot-gate/Makefile
@@ -7,7 +7,7 @@
 
 obj-y += imx8mm-cl-iot-gate.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o eeprom_spl.o
 obj-y += ddr/
 endif
diff --git a/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c b/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c
index 1256848f9a9..a22e6ef1d96 100644
--- a/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c
+++ b/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c
@@ -10,7 +10,7 @@
 #include <asm/setup.h>
 #include <linux/delay.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #define CFG_SYS_I2C_EEPROM_ADDR_P1	0x51
 
diff --git a/board/comvetia/lxr2/lxr2.c b/board/comvetia/lxr2/lxr2.c
index 173263522bd..dc7fc202049 100644
--- a/board/comvetia/lxr2/lxr2.c
+++ b/board/comvetia/lxr2/lxr2.c
@@ -138,7 +138,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 
 #define MX6_PHYFLEX_ERR006282	IMX_GPIO_NR(2, 11)
diff --git a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
index 37750137ad9..15dba146eb8 100644
--- a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
+++ b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
@@ -141,7 +141,7 @@ int dram_init(void)
 }
 
 /* SPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 }
diff --git a/board/congatec/cgtqmx8/Makefile b/board/congatec/cgtqmx8/Makefile
index 4b59dbb6bc7..2a02cec4f15 100644
--- a/board/congatec/cgtqmx8/Makefile
+++ b/board/congatec/cgtqmx8/Makefile
@@ -6,6 +6,6 @@
 
 obj-y += cgtqmx8.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 endif
diff --git a/board/congatec/common/Makefile b/board/congatec/common/Makefile
index 2db0fc1ae5c..f8170d9c653 100644
--- a/board/congatec/common/Makefile
+++ b/board/congatec/common/Makefile
@@ -7,7 +7,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
diff --git a/board/data_modul/common/common.c b/board/data_modul/common/common.c
index b4d74a8fd8b..b5f83908771 100644
--- a/board/data_modul/common/common.c
+++ b/board/data_modul/common/common.c
@@ -72,7 +72,7 @@ int board_phys_sdram_size(phys_size_t *size)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static void data_modul_imx_edm_sbc_early_init_f(const iomux_v3_cfg_t wdog_pad)
 {
 	struct wdog_regs *wdog = (struct wdog_regs *)WDOG1_BASE_ADDR;
diff --git a/board/data_modul/imx8mm_edm_sbc/Makefile b/board/data_modul/imx8mm_edm_sbc/Makefile
index 6d72e930fca..3d8fedf74d4 100644
--- a/board/data_modul/imx8mm_edm_sbc/Makefile
+++ b/board/data_modul/imx8mm_edm_sbc/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing_2G_32.o lpddr4_timing_4G_32.o
 else
 obj-y += imx8mm_data_modul_edm_sbc.o
diff --git a/board/data_modul/imx8mp_edm_sbc/Makefile b/board/data_modul/imx8mp_edm_sbc/Makefile
index 28c1d62f2bb..7e1fe855799 100644
--- a/board/data_modul/imx8mp_edm_sbc/Makefile
+++ b/board/data_modul/imx8mp_edm_sbc/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing_4G_32.o
 else
 obj-y += imx8mp_data_modul_edm_sbc.o
diff --git a/board/davinci/da8xxevm/omapl138_lcdk.c b/board/davinci/da8xxevm/omapl138_lcdk.c
index 03c34455c50..dc42a4a7b53 100644
--- a/board/davinci/da8xxevm/omapl138_lcdk.c
+++ b/board/davinci/da8xxevm/omapl138_lcdk.c
@@ -311,7 +311,7 @@ int board_mmc_init(struct bd_info *bis)
 #endif
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static const struct ns16550_plat serial_pdata = {
 	.base = DAVINCI_UART2_BASE,
 	.reg_shift = 2,
diff --git a/board/dhelectronics/dh_imx6/Makefile b/board/dhelectronics/dh_imx6/Makefile
index 70ca30d3971..7102a47450e 100644
--- a/board/dhelectronics/dh_imx6/Makefile
+++ b/board/dhelectronics/dh_imx6/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2017 Marek Vasut <marex@denx.de>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= dh_imx6_spl.o
 else
 obj-y	:= dh_imx6.o
diff --git a/board/dhelectronics/dh_imx8mp/Makefile b/board/dhelectronics/dh_imx8mp/Makefile
index e5a29fdd122..7bc8dc21e64 100644
--- a/board/dhelectronics/dh_imx8mp/Makefile
+++ b/board/dhelectronics/dh_imx8mp/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing_2G_32.o lpddr4_timing_4G_32.o
 else
 obj-y += imx8mp_dhcom_pdk2.o
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index 4f4f537fee5..073f32d1380 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -260,13 +260,13 @@ int board_stm32mp1_ddr_config_name_match(struct udevice *dev,
 
 void board_vddcore_init(u32 voltage_mv)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		opp_voltage_mv = voltage_mv;
 }
 
 int board_early_init_f(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		stpmic1_init(opp_voltage_mv);
 	board_get_coding_straps();
 
@@ -767,7 +767,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 	dh_stm32_ks8851_fixup(spl_image_fdt_addr(spl_image));
diff --git a/board/ea/mx7ulp_com/mx7ulp_com.c b/board/ea/mx7ulp_com/mx7ulp_com.c
index 8f78937e097..d3a65fd820b 100644
--- a/board/ea/mx7ulp_com/mx7ulp_com.c
+++ b/board/ea/mx7ulp_com/mx7ulp_com.c
@@ -52,7 +52,7 @@ int board_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 
 #ifdef CONFIG_SPL_LOAD_FIT
diff --git a/board/eets/pdu001/board.c b/board/eets/pdu001/board.c
index 00f9a5ef341..16af687d9cc 100644
--- a/board/eets/pdu001/board.c
+++ b/board/eets/pdu001/board.c
@@ -65,7 +65,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define CFG_SYS_RTC_SCRATCH0 0x60
 #define BOOT_DEVICE_SAVE_REGISTER (RTC_BASE + CFG_SYS_RTC_SCRATCH0)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static void save_boot_device(void)
 {
 	*((u32 *)(BOOT_DEVICE_SAVE_REGISTER)) = spl_boot_device();
diff --git a/board/embest/mx6boards/mx6boards.c b/board/embest/mx6boards/mx6boards.c
index cf3368c253b..5ed41d01d9b 100644
--- a/board/embest/mx6boards/mx6boards.c
+++ b/board/embest/mx6boards/mx6boards.c
@@ -394,7 +394,7 @@ int checkboard(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 
 void board_init_f(ulong dummy)
diff --git a/board/engicam/common/Makefile b/board/engicam/common/Makefile
index 15f0eaa1ec4..dc8be383c23 100644
--- a/board/engicam/common/Makefile
+++ b/board/engicam/common/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2016 Amarula Solutions B.V.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX6_ENGICAM_COMMON) += spl.o
 else
 obj-$(CONFIG_IMX6_ENGICAM_COMMON) += board.o
diff --git a/board/engicam/imx8mm/Makefile b/board/engicam/imx8mm/Makefile
index 3392d61920a..d6ad299f830 100644
--- a/board/engicam/imx8mm/Makefile
+++ b/board/engicam/imx8mm/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += icore_mx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-y += lpddr4_timing.o
 endif
diff --git a/board/engicam/imx8mp/Makefile b/board/engicam/imx8mp/Makefile
index c3ec09d6e38..f21a31b8078 100644
--- a/board/engicam/imx8mp/Makefile
+++ b/board/engicam/imx8mp/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += icore_mx8mp.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/engicam/stm32mp1/Makefile b/board/engicam/stm32mp1/Makefile
index 155d33f9eec..9ac78e4d1aa 100644
--- a/board/engicam/stm32mp1/Makefile
+++ b/board/engicam/stm32mp1/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2018, STMicroelectronics - All Rights Reserved
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += stm32mp1.o
diff --git a/board/firefly/firefly-rk3288/firefly-rk3288.c b/board/firefly/firefly-rk3288/firefly-rk3288.c
index 8e67ab4b132..c65ce5890e5 100644
--- a/board/firefly/firefly-rk3288/firefly-rk3288.c
+++ b/board/firefly/firefly-rk3288/firefly-rk3288.c
@@ -9,7 +9,7 @@
 #include <asm/global_data.h>
 #include <dm/ofnode.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static int setup_led(void)
 {
 #ifdef CONFIG_SPL_LED
diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index a149e4fe822..6937a27176f 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -13,7 +13,7 @@
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #define PMUGRF_BASE	0xff320000
 #define GPIO0_BASE	0xff720000
diff --git a/board/freescale/common/Makefile b/board/freescale/common/Makefile
index b4faf6f9e0a..c491dc8b241 100644
--- a/board/freescale/common/Makefile
+++ b/board/freescale/common/Makefile
@@ -5,7 +5,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
@@ -29,14 +29,14 @@ endif
 obj-$(CONFIG_FSL_CADMUS)	+= cadmus.o
 obj-$(CONFIG_FSL_VIA)		+= cds_via.o
 obj-$(CONFIG_FMAN_ENET)	+= fman.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_FSL_NGPIXIS)	+= ngpixis.o
 endif
 obj-$(I2C_COMMON)		+= i2c_common.o
 obj-$(CONFIG_FSL_USE_PCA9547_MUX)		+= i2c_mux.o
 obj-$(CONFIG_$(SPL_)VID)	+= vid.o
 obj-$(CONFIG_FSL_QIXIS)	+= qixis.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_ID_EEPROM)	+= sys_eeprom.o
 endif
 ifndef CONFIG_RAMBOOT_PBL
diff --git a/board/freescale/common/cmd_esbc_validate.c b/board/freescale/common/cmd_esbc_validate.c
index 3344653ba2d..7629d7091e9 100644
--- a/board/freescale/common/cmd_esbc_validate.c
+++ b/board/freescale/common/cmd_esbc_validate.c
@@ -23,7 +23,7 @@ loop:
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int do_esbc_validate(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
 {
diff --git a/board/freescale/common/fsl_chain_of_trust.c b/board/freescale/common/fsl_chain_of_trust.c
index 27a33924c84..194a0907e72 100644
--- a/board/freescale/common/fsl_chain_of_trust.c
+++ b/board/freescale/common/fsl_chain_of_trust.c
@@ -15,7 +15,7 @@
 #include <dm/root.h>
 #include <asm/fsl_secure_boot.h>
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_FRAMEWORK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_FRAMEWORK)
 #include <spl.h>
 #endif
 
@@ -67,7 +67,7 @@ int fsl_check_boot_mode_secure(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int fsl_setenv_chain_of_trust(void)
 {
 	/* Check Boot Mode
@@ -92,7 +92,7 @@ int fsl_setenv_chain_of_trust(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_validate_uboot(uint32_t hdr_addr, uintptr_t img_addr)
 {
 	int res;
@@ -157,4 +157,4 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 	image_entry();
 }
 #endif /* ifdef CONFIG_SPL_FRAMEWORK */
-#endif /* ifdef CONFIG_SPL_BUILD */
+#endif /* ifdef CONFIG_XPL_BUILD */
diff --git a/board/freescale/common/fsl_validate.c b/board/freescale/common/fsl_validate.c
index 657f4533bcd..df0c1a1f406 100644
--- a/board/freescale/common/fsl_validate.c
+++ b/board/freescale/common/fsl_validate.c
@@ -396,7 +396,7 @@ static void fsl_secboot_bootscript_parse_failure(void)
  */
 void fsl_secboot_handle_error(int error)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	const struct fsl_secboot_errcode *e;
 
 	for (e = fsl_secboot_errcodes; e->errcode != ERROR_ESBC_CLIENT_MAX;
@@ -807,7 +807,7 @@ static int calculate_cmp_img_sig(struct fsl_secboot_img_priv *img)
 	prop.num_bits = key_len * 8;
 	prop.exp_len = key_len;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	ret = device_bind_driver(NULL, "fsl_rsa_mod_exp", "fsl_rsa_mod_exp", NULL);
 	if (ret) {
 		printf("Couldn't bind fsl_rsa_mod_exp driver (%d)\n", ret);
diff --git a/board/freescale/common/qixis.c b/board/freescale/common/qixis.c
index 6400ac05245..7815ba2dbce 100644
--- a/board/freescale/common/qixis.c
+++ b/board/freescale/common/qixis.c
@@ -161,7 +161,7 @@ void board_deassert_mem_reset(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static void qixis_reset(void)
 {
 	QIXIS_WRITE(rst_ctl, QIXIS_RST_CTL_RESET);
diff --git a/board/freescale/imx8mm_evk/Makefile b/board/freescale/imx8mm_evk/Makefile
index 1db7b62cafc..9fecd8dd8cb 100644
--- a/board/freescale/imx8mm_evk/Makefile
+++ b/board/freescale/imx8mm_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mm_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/freescale/imx8mn_evk/Makefile b/board/freescale/imx8mn_evk/Makefile
index 42d1179724d..5ef666a36dd 100644
--- a/board/freescale/imx8mn_evk/Makefile
+++ b/board/freescale/imx8mn_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mn_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 ifdef CONFIG_IMX8MN_LOW_DRIVE_MODE
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_ld.o
diff --git a/board/freescale/imx8mp_evk/Makefile b/board/freescale/imx8mp_evk/Makefile
index 106bf9a1edf..3c154d7f7f5 100644
--- a/board/freescale/imx8mp_evk/Makefile
+++ b/board/freescale/imx8mp_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mp_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/freescale/imx8mq_evk/Makefile b/board/freescale/imx8mq_evk/Makefile
index cf046963d25..ca449e6f369 100644
--- a/board/freescale/imx8mq_evk/Makefile
+++ b/board/freescale/imx8mq_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mq_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o lpddr4_timing_b0.o
 endif
diff --git a/board/freescale/imx8qm_mek/Makefile b/board/freescale/imx8qm_mek/Makefile
index bc9a1260bde..53b33a0dfb1 100644
--- a/board/freescale/imx8qm_mek/Makefile
+++ b/board/freescale/imx8qm_mek/Makefile
@@ -5,4 +5,4 @@
 #
 
 obj-y += imx8qm_mek.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/freescale/imx8qxp_mek/Makefile b/board/freescale/imx8qxp_mek/Makefile
index acaadcd84a4..459ec771eea 100644
--- a/board/freescale/imx8qxp_mek/Makefile
+++ b/board/freescale/imx8qxp_mek/Makefile
@@ -5,4 +5,4 @@
 #
 
 obj-y += imx8qxp_mek.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/freescale/imx8ulp_evk/Makefile b/board/freescale/imx8ulp_evk/Makefile
index 1cf148ab910..7819b2675b3 100644
--- a/board/freescale/imx8ulp_evk/Makefile
+++ b/board/freescale/imx8ulp_evk/Makefile
@@ -2,7 +2,7 @@
 
 obj-y   += imx8ulp_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 ifdef CONFIG_IMX8ULP_ND_MODE
 obj-y += lpddr4_timing_264.o
diff --git a/board/freescale/imx93_evk/Makefile b/board/freescale/imx93_evk/Makefile
index ede8d20ff5c..b077acc70a5 100644
--- a/board/freescale/imx93_evk/Makefile
+++ b/board/freescale/imx93_evk/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx93_evk.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing.o lpddr4x_timing_1866mts.o
 endif
diff --git a/board/freescale/imxrt1020-evk/imxrt1020-evk.c b/board/freescale/imxrt1020-evk/imxrt1020-evk.c
index 42a0a67ae93..11dbef84688 100644
--- a/board/freescale/imxrt1020-evk/imxrt1020-evk.c
+++ b/board/freescale/imxrt1020-evk/imxrt1020-evk.c
@@ -37,7 +37,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk.c b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
index 46a644908e9..056489932ac 100644
--- a/board/freescale/imxrt1050-evk/imxrt1050-evk.c
+++ b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
@@ -37,7 +37,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
diff --git a/board/freescale/imxrt1170-evk/imxrt1170-evk.c b/board/freescale/imxrt1170-evk/imxrt1170-evk.c
index e10b8830ec6..047aea8181a 100644
--- a/board/freescale/imxrt1170-evk/imxrt1170-evk.c
+++ b/board/freescale/imxrt1170-evk/imxrt1170-evk.c
@@ -37,7 +37,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
diff --git a/board/freescale/ls1012afrdm/ls1012afrdm.c b/board/freescale/ls1012afrdm/ls1012afrdm.c
index dae2cf097bc..f157e75e385 100644
--- a/board/freescale/ls1012afrdm/ls1012afrdm.c
+++ b/board/freescale/ls1012afrdm/ls1012afrdm.c
@@ -140,7 +140,7 @@ int dram_init(void)
 #endif
 	mmdc_init(&mparam);
 
-#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1012aqds/ls1012aqds.c b/board/freescale/ls1012aqds/ls1012aqds.c
index 7d56eb0117d..b21c4d917d0 100644
--- a/board/freescale/ls1012aqds/ls1012aqds.c
+++ b/board/freescale/ls1012aqds/ls1012aqds.c
@@ -88,7 +88,7 @@ int dram_init(void)
 
 	mmdc_init(&mparam);
 	gd->ram_size = CFG_SYS_SDRAM_SIZE;
-#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1012ardb/ls1012ardb.c b/board/freescale/ls1012ardb/ls1012ardb.c
index 5f0564f1b23..ab69eab8408 100644
--- a/board/freescale/ls1012ardb/ls1012ardb.c
+++ b/board/freescale/ls1012ardb/ls1012ardb.c
@@ -138,7 +138,7 @@ int dram_init(void)
 #endif
 
 	gd->ram_size = CFG_SYS_SDRAM_SIZE;
-#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1021aiot/ls1021aiot.c b/board/freescale/ls1021aiot/ls1021aiot.c
index 2fdac87bc29..4eff0a3fee0 100644
--- a/board/freescale/ls1021aiot/ls1021aiot.c
+++ b/board/freescale/ls1021aiot/ls1021aiot.c
@@ -99,7 +99,7 @@ void ddrmc_init(void)
 
 int dram_init(void)
 {
-#if (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 	ddrmc_init();
 #endif
 
@@ -125,7 +125,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	/* Clear the BSS */
diff --git a/board/freescale/ls1021aqds/ddr.c b/board/freescale/ls1021aqds/ddr.c
index 5b0f23688f0..fd897e832c8 100644
--- a/board/freescale/ls1021aqds/ddr.c
+++ b/board/freescale/ls1021aqds/ddr.c
@@ -172,14 +172,14 @@ int fsl_initdram(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_SPL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_SPL)
 	puts("Initializing DDR....using SPD\n");
 	dram_size = fsl_ddr_sdram();
 #else
 	dram_size =  fsl_ddr_sdram_size();
 #endif
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
diff --git a/board/freescale/ls1021aqds/ls1021aqds.c b/board/freescale/ls1021aqds/ls1021aqds.c
index 930ef6be385..0bdd468d9a7 100644
--- a/board/freescale/ls1021aqds/ls1021aqds.c
+++ b/board/freescale/ls1021aqds/ls1021aqds.c
@@ -181,7 +181,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 #ifdef CONFIG_NAND_BOOT
diff --git a/board/freescale/ls1021atsn/ls1021atsn.c b/board/freescale/ls1021atsn/ls1021atsn.c
index b7e043b2e62..d1acccec110 100644
--- a/board/freescale/ls1021atsn/ls1021atsn.c
+++ b/board/freescale/ls1021atsn/ls1021atsn.c
@@ -27,7 +27,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static void ddrmc_init(void)
 {
-#if (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 	struct ccsr_ddr *ddr = (struct ccsr_ddr *)CFG_SYS_FSL_DDR_ADDR;
 	u32 temp_sdram_cfg, tmp;
 
@@ -105,7 +105,7 @@ static void ddrmc_init(void)
 		out_be32(&ddr->sdram_cfg_2, temp_sdram_cfg);
 	}
 #endif
-#endif /* !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD) */
+#endif /* !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD) */
 }
 
 int dram_init(void)
@@ -116,7 +116,7 @@ int dram_init(void)
 
 	gd->ram_size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE);
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
@@ -156,7 +156,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	void (*second_uboot)(void);
@@ -214,7 +214,7 @@ int board_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 void spl_board_init(void)
 {
 	ls102xa_smmu_stream_id_init();
diff --git a/board/freescale/ls1021atwr/ls1021atwr.c b/board/freescale/ls1021atwr/ls1021atwr.c
index 78006afce86..cc9665c0410 100644
--- a/board/freescale/ls1021atwr/ls1021atwr.c
+++ b/board/freescale/ls1021atwr/ls1021atwr.c
@@ -224,7 +224,7 @@ void ddrmc_init(void)
 
 int dram_init(void)
 {
-#if (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 	ddrmc_init();
 #endif
 
@@ -232,7 +232,7 @@ int dram_init(void)
 
 	gd->ram_size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE);
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
@@ -407,7 +407,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_init_f(ulong dummy)
 {
 	void (*second_uboot)(void);
@@ -527,7 +527,7 @@ int board_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 void spl_board_init(void)
 {
 	if (IS_ENABLED(CONFIG_FSL_CAAM)) {
@@ -607,7 +607,7 @@ u16 flash_read16(void *addr)
 }
 
 #if !defined(CONFIG_QSPI_BOOT) && !defined(CONFIG_SD_BOOT_QSPI) \
-	&& !defined(CONFIG_SPL_BUILD)
+	&& !defined(CONFIG_XPL_BUILD)
 static void convert_flash_bank(char bank)
 {
 	struct cpld_data *cpld_data = (void *)(CFG_SYS_CPLD_BASE);
diff --git a/board/freescale/ls1028a/ls1028a.c b/board/freescale/ls1028a/ls1028a.c
index e01b5a8c2eb..db94d9c1fa8 100644
--- a/board/freescale/ls1028a/ls1028a.c
+++ b/board/freescale/ls1028a/ls1028a.c
@@ -123,7 +123,7 @@ int board_early_init_f(void)
 	u8 uart;
 #endif
 
-#if defined(CONFIG_SYS_I2C_EARLY_INIT) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SYS_I2C_EARLY_INIT) && defined(CONFIG_XPL_BUILD)
 	i2c_early_init_f();
 #endif
 
diff --git a/board/freescale/ls1043aqds/Makefile b/board/freescale/ls1043aqds/Makefile
index 49d8d7d9b96..ff830788fd7 100644
--- a/board/freescale/ls1043aqds/Makefile
+++ b/board/freescale/ls1043aqds/Makefile
@@ -5,7 +5,7 @@
 #
 
 obj-y += ddr.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += eth.o
 endif
 obj-y += ls1043aqds.o
diff --git a/board/freescale/ls1043aqds/ddr.c b/board/freescale/ls1043aqds/ddr.c
index 2a9717df616..137ad7395ad 100644
--- a/board/freescale/ls1043aqds/ddr.c
+++ b/board/freescale/ls1043aqds/ddr.c
@@ -123,7 +123,7 @@ int fsl_initdram(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 
 	return 0;
diff --git a/board/freescale/ls1043aqds/ls1043aqds.c b/board/freescale/ls1043aqds/ls1043aqds.c
index 2ecf5a74a03..f043599fbb8 100644
--- a/board/freescale/ls1043aqds/ls1043aqds.c
+++ b/board/freescale/ls1043aqds/ls1043aqds.c
@@ -288,7 +288,7 @@ int dram_init(void)
 	select_i2c_ch_pca9547(I2C_MUX_CH_DEFAULT, 0);
 	fsl_initdram();
 #if (!defined(CONFIG_SPL) && !defined(CONFIG_TFABOOT)) || \
-	defined(CONFIG_SPL_BUILD)
+	defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1043ardb/Makefile b/board/freescale/ls1043ardb/Makefile
index 5309576c688..95745bf3a9c 100644
--- a/board/freescale/ls1043ardb/Makefile
+++ b/board/freescale/ls1043ardb/Makefile
@@ -4,7 +4,7 @@
 
 obj-y += ddr.o
 obj-y += ls1043ardb.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_NET) += eth.o
 obj-y += cpld.o
 endif
diff --git a/board/freescale/ls1043ardb/ddr.c b/board/freescale/ls1043ardb/ddr.c
index 187925e981a..231b60d1b3d 100644
--- a/board/freescale/ls1043ardb/ddr.c
+++ b/board/freescale/ls1043ardb/ddr.c
@@ -225,14 +225,14 @@ int fsl_initdram(void)
 	phys_size_t dram_size;
 
 #ifdef CONFIG_SYS_DDR_RAW_TIMING
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_SPL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_SPL)
 	puts("Initializing DDR....\n");
 	dram_size = fsl_ddr_sdram();
 #else
 	dram_size =  fsl_ddr_sdram_size();
 #endif
 #else
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_SPL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_SPL)
 	puts("Initialzing DDR using fixed setting\n");
 	dram_size = fixed_sdram();
 #else
diff --git a/board/freescale/ls1043ardb/ls1043ardb.c b/board/freescale/ls1043ardb/ls1043ardb.c
index cf84ff9e638..bba041065b5 100644
--- a/board/freescale/ls1043ardb/ls1043ardb.c
+++ b/board/freescale/ls1043ardb/ls1043ardb.c
@@ -132,7 +132,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 int checkboard(void)
 {
diff --git a/board/freescale/ls1046aqds/Makefile b/board/freescale/ls1046aqds/Makefile
index 6267522cc26..365247d92bc 100644
--- a/board/freescale/ls1046aqds/Makefile
+++ b/board/freescale/ls1046aqds/Makefile
@@ -5,7 +5,7 @@
 #
 
 obj-y += ddr.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += eth.o
 endif
 obj-y += ls1046aqds.o
diff --git a/board/freescale/ls1046aqds/ddr.c b/board/freescale/ls1046aqds/ddr.c
index ac1b6049721..57790335f0a 100644
--- a/board/freescale/ls1046aqds/ddr.c
+++ b/board/freescale/ls1046aqds/ddr.c
@@ -107,7 +107,7 @@ int fsl_initdram(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 
 	return 0;
diff --git a/board/freescale/ls1046aqds/ls1046aqds.c b/board/freescale/ls1046aqds/ls1046aqds.c
index a83b2170651..7df12550868 100644
--- a/board/freescale/ls1046aqds/ls1046aqds.c
+++ b/board/freescale/ls1046aqds/ls1046aqds.c
@@ -284,7 +284,7 @@ int dram_init(void)
 	select_i2c_ch_pca9547(I2C_MUX_CH_DEFAULT, 0);
 	fsl_initdram();
 #if (!defined(CONFIG_SPL) && !defined(CONFIG_TFABOOT)) || \
-	defined(CONFIG_SPL_BUILD)
+	defined(CONFIG_XPL_BUILD)
 	/* This will break-before-make MMU for DDR */
 	update_early_mmu_table();
 #endif
diff --git a/board/freescale/ls1046ardb/Makefile b/board/freescale/ls1046ardb/Makefile
index 1c13ed6b6f0..9e5d24f53c8 100644
--- a/board/freescale/ls1046ardb/Makefile
+++ b/board/freescale/ls1046ardb/Makefile
@@ -4,7 +4,7 @@
 
 obj-y += ddr.o
 obj-y += ls1046ardb.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_NET) += eth.o
 obj-y += cpld.o
 endif
diff --git a/board/freescale/ls1046ardb/ddr.c b/board/freescale/ls1046ardb/ddr.c
index 68353022e7d..4170666c420 100644
--- a/board/freescale/ls1046ardb/ddr.c
+++ b/board/freescale/ls1046ardb/ddr.c
@@ -113,7 +113,7 @@ int fsl_initdram(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 
 	return 0;
diff --git a/board/freescale/ls1046ardb/ls1046ardb.c b/board/freescale/ls1046ardb/ls1046ardb.c
index 0492f0a8c0a..83b280f7646 100644
--- a/board/freescale/ls1046ardb/ls1046ardb.c
+++ b/board/freescale/ls1046ardb/ls1046ardb.c
@@ -44,7 +44,7 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int checkboard(void)
 {
 	static const char *freq[2] = {"100.00MHZ", "156.25MHZ"};
diff --git a/board/freescale/ls1088a/Makefile b/board/freescale/ls1088a/Makefile
index c2b0e7dc0f4..e54d6cad9e1 100644
--- a/board/freescale/ls1088a/Makefile
+++ b/board/freescale/ls1088a/Makefile
@@ -4,7 +4,7 @@
 
 obj-y += ls1088a.o
 obj-y += ddr.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_TARGET_LS1088ARDB) += eth_ls1088ardb.o
 obj-$(CONFIG_TARGET_LS1088AQDS) += eth_ls1088aqds.o
 endif
diff --git a/board/freescale/ls1088a/ddr.c b/board/freescale/ls1088a/ddr.c
index 54b432ad794..cd590af9534 100644
--- a/board/freescale/ls1088a/ddr.c
+++ b/board/freescale/ls1088a/ddr.c
@@ -13,7 +13,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 static void fsl_ddr_setup_0v9_volt(memctl_options_t *popts)
 {
 	int vdd;
@@ -101,7 +101,7 @@ found:
 	popts->addr_hash = 1;
 
 	popts->ddr_cdr1 = DDR_CDR1_DHC_EN | DDR_CDR1_ODT(DDR_CDR_ODT_60ohm);
-#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD))
+#if defined(CONFIG_VID) && (!defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD))
 	fsl_ddr_setup_0v9_volt(popts);
 #endif
 
@@ -124,7 +124,7 @@ int fsl_initdram(void)
 {
 	puts("Initializing DDR....using SPD\n");
 
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 #else
 	gd->ram_size = fsl_ddr_sdram();
diff --git a/board/freescale/ls1088a/ls1088a.c b/board/freescale/ls1088a/ls1088a.c
index 58951f2bb2a..9f4eb4811d9 100644
--- a/board/freescale/ls1088a/ls1088a.c
+++ b/board/freescale/ls1088a/ls1088a.c
@@ -248,7 +248,7 @@ int fixup_ls1088ardb_pb_banner(void *fdt)
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 int checkboard(void)
 {
 #ifdef CONFIG_TFABOOT
@@ -421,7 +421,7 @@ unsigned long get_board_ddr_clk(void)
 }
 #endif
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 void board_retimer_init(void)
 {
 	u8 reg;
@@ -804,7 +804,7 @@ exit:
 	return ret;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 int board_init(void)
 {
 	init_final_memctl_regs();
@@ -995,7 +995,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 #endif
-#endif /* defined(CONFIG_SPL_BUILD) */
+#endif /* defined(CONFIG_XPL_BUILD) */
 
 #ifdef CONFIG_TFABOOT
 #ifdef CONFIG_MTD_NOR_FLASH
diff --git a/board/freescale/ls2080aqds/ddr.c b/board/freescale/ls2080aqds/ddr.c
index d19c061e122..31ed72c949b 100644
--- a/board/freescale/ls2080aqds/ddr.c
+++ b/board/freescale/ls2080aqds/ddr.c
@@ -168,7 +168,7 @@ int fsl_initdram(void)
 #else
 int fsl_initdram(void)
 {
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 #else
 	puts("Initializing DDR....using SPD\n");
diff --git a/board/freescale/ls2080aqds/ls2080aqds.c b/board/freescale/ls2080aqds/ls2080aqds.c
index 4c8d0706688..aba0560181a 100644
--- a/board/freescale/ls2080aqds/ls2080aqds.c
+++ b/board/freescale/ls2080aqds/ls2080aqds.c
@@ -264,7 +264,7 @@ void detail_board_ddr_info(void)
 #endif
 }
 
-#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_XPL_BUILD)
 void fdt_fixup_board_enet(void *fdt)
 {
 	int offset;
@@ -323,7 +323,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	fsl_fdt_fixup_dr_usb(blob, bd);
 
-#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_XPL_BUILD)
 	fdt_fixup_board_enet(blob);
 	fdt_reserve_mc_mem(blob, 0x300);
 #endif
diff --git a/board/freescale/ls2080ardb/ddr.c b/board/freescale/ls2080ardb/ddr.c
index a1a97f9f8c2..e56667c846f 100644
--- a/board/freescale/ls2080ardb/ddr.c
+++ b/board/freescale/ls2080ardb/ddr.c
@@ -173,7 +173,7 @@ int fsl_initdram(void)
 #else
 int fsl_initdram(void)
 {
-#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL) && !defined(CONFIG_XPL_BUILD)
 	gd->ram_size = fsl_ddr_sdram_size();
 #else
 	puts("Initializing DDR....using SPD\n");
diff --git a/board/freescale/ls2080ardb/eth_ls2080rdb.c b/board/freescale/ls2080ardb/eth_ls2080rdb.c
index 7fc4fecf774..7d5beb32417 100644
--- a/board/freescale/ls2080ardb/eth_ls2080rdb.c
+++ b/board/freescale/ls2080ardb/eth_ls2080rdb.c
@@ -12,7 +12,7 @@ DECLARE_GLOBAL_DATA_PTR;
 int board_eth_init(struct bd_info *bis)
 {
 
-#if defined(CONFIG_PHY_AQUANTIA) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_PHY_AQUANTIA) && !defined(CONFIG_XPL_BUILD)
 	/*
 	 * Export functions to be used by AQ firmware
 	 * upload application
diff --git a/board/freescale/lx2160a/lx2160a.c b/board/freescale/lx2160a/lx2160a.c
index 3aa984dab8e..341f82ce724 100644
--- a/board/freescale/lx2160a/lx2160a.c
+++ b/board/freescale/lx2160a/lx2160a.c
@@ -58,7 +58,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int board_early_init_f(void)
 {
-#if defined(CONFIG_SYS_I2C_EARLY_INIT) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SYS_I2C_EARLY_INIT) && defined(CONFIG_XPL_BUILD)
 	i2c_early_init_f();
 #endif
 
diff --git a/board/freescale/mx23evk/Makefile b/board/freescale/mx23evk/Makefile
index 6fe6992a5fc..5cc99ab1836 100644
--- a/board/freescale/mx23evk/Makefile
+++ b/board/freescale/mx23evk/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef	CONFIG_SPL_BUILD
+ifndef	CONFIG_XPL_BUILD
 obj-y	:= mx23evk.o
 else
 obj-y	:= spl_boot.o
diff --git a/board/freescale/mx28evk/Makefile b/board/freescale/mx28evk/Makefile
index 057760433da..1fd2a439f7a 100644
--- a/board/freescale/mx28evk/Makefile
+++ b/board/freescale/mx28evk/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef	CONFIG_SPL_BUILD
+ifndef	CONFIG_XPL_BUILD
 obj-y	:= mx28evk.o
 else
 obj-y	:= iomux.o
diff --git a/board/freescale/mx6memcal/Makefile b/board/freescale/mx6memcal/Makefile
index fc2d3eb9e10..b4088b9f2ec 100644
--- a/board/freescale/mx6memcal/Makefile
+++ b/board/freescale/mx6memcal/Makefile
@@ -4,7 +4,7 @@
 #
 # (C) Copyright 2011 Freescale Semiconductor, Inc.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= spl.o
 else
 obj-y	:= mx6memcal.o
diff --git a/board/freescale/mx6sabreauto/mx6sabreauto.c b/board/freescale/mx6sabreauto/mx6sabreauto.c
index bab62fd4421..8ca57e0b2ac 100644
--- a/board/freescale/mx6sabreauto/mx6sabreauto.c
+++ b/board/freescale/mx6sabreauto/mx6sabreauto.c
@@ -545,7 +545,7 @@ int board_ehci_hcd_init(int port)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <asm/arch/mx6-ddr.h>
 #include <spl.h>
 #include <linux/libfdt.h>
diff --git a/board/freescale/mx6sabresd/mx6sabresd.c b/board/freescale/mx6sabresd/mx6sabresd.c
index bb066a5d36c..dff3a9c33bf 100644
--- a/board/freescale/mx6sabresd/mx6sabresd.c
+++ b/board/freescale/mx6sabresd/mx6sabresd.c
@@ -507,7 +507,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <asm/arch/mx6-ddr.h>
 #include <spl.h>
 #include <linux/libfdt.h>
diff --git a/board/freescale/mx6slevk/mx6slevk.c b/board/freescale/mx6slevk/mx6slevk.c
index d37d8a4136f..fb145fa6aac 100644
--- a/board/freescale/mx6slevk/mx6slevk.c
+++ b/board/freescale/mx6slevk/mx6slevk.c
@@ -61,7 +61,7 @@ static iomux_v3_cfg_t const uart1_pads[] = {
 	MX6_PAD_UART1_RXD__UART1_RXD | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static iomux_v3_cfg_t const usdhc1_pads[] = {
 	/* 8 bit SD */
 	MX6_PAD_SD1_CLK__USDHC1_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
@@ -195,7 +195,7 @@ int checkboard(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
 
diff --git a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
index e5a0197e2fd..c4ab59da78c 100644
--- a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
+++ b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
@@ -123,7 +123,7 @@ static int board_qspi_init(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #define USDHC_PAD_CTRL (PAD_CTL_PKE | PAD_CTL_PUE |		\
 	PAD_CTL_PUS_22K_UP  | PAD_CTL_SPEED_LOW |		\
@@ -346,7 +346,7 @@ void board_preboot_os(void)
 	gpio_set_value(IMX_GPIO_NR(5, 9), 0);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
diff --git a/board/freescale/p1010rdb/Makefile b/board/freescale/p1010rdb/Makefile
index a00806e6aae..df4e8001d38 100644
--- a/board/freescale/p1010rdb/Makefile
+++ b/board/freescale/p1010rdb/Makefile
@@ -4,7 +4,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
@@ -15,7 +15,7 @@ endif
 ifdef MINIMAL
 obj-y	+= spl_minimal.o
 else
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 endif
 obj-y	+= p1010rdb.o
diff --git a/board/freescale/p1010rdb/p1010rdb.c b/board/freescale/p1010rdb/p1010rdb.c
index e386840d9ef..9b4b6f34f46 100644
--- a/board/freescale/p1010rdb/p1010rdb.c
+++ b/board/freescale/p1010rdb/p1010rdb.c
@@ -656,7 +656,7 @@ int misc_init_r(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int pin_mux_cmd(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
 {
diff --git a/board/freescale/p1010rdb/tlb.c b/board/freescale/p1010rdb/tlb.c
index 44acebaa2bb..aa130ccf78b 100644
--- a/board/freescale/p1010rdb/tlb.c
+++ b/board/freescale/p1010rdb/tlb.c
@@ -41,7 +41,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 			MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 			0, 1, BOOKE_PAGESZ_1M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	SET_TLB_ENTRY(1, CFG_SYS_FLASH_BASE, CFG_SYS_FLASH_BASE_PHYS,
 			MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 			0, 2, BOOKE_PAGESZ_16M, 1),
diff --git a/board/freescale/p1_p2_rdb_pc/Makefile b/board/freescale/p1_p2_rdb_pc/Makefile
index cbdb2507e83..8c13813e3b0 100644
--- a/board/freescale/p1_p2_rdb_pc/Makefile
+++ b/board/freescale/p1_p2_rdb_pc/Makefile
@@ -4,7 +4,7 @@
 
 MINIMAL=
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifndef CONFIG_TPL_BUILD
 ifdef CONFIG_SPL_INIT_MINIMAL
 MINIMAL=y
@@ -15,7 +15,7 @@ endif
 ifdef MINIMAL
 obj-y	+= spl_minimal.o
 else
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 endif
 obj-y	+= p1_p2_rdb_pc.o
diff --git a/board/freescale/p1_p2_rdb_pc/tlb.c b/board/freescale/p1_p2_rdb_pc/tlb.c
index ae0b7adbe54..f27821418eb 100644
--- a/board/freescale/p1_p2_rdb_pc/tlb.c
+++ b/board/freescale/p1_p2_rdb_pc/tlb.c
@@ -37,7 +37,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 			MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 			0, 1, BOOKE_PAGESZ_1M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* W**G* - Flash/promjet, localbus */
 	/* This will be changed to *I*G* after relocation to RAM. */
 	SET_TLB_ENTRY(1, CFG_SYS_FLASH_BASE, CFG_SYS_FLASH_BASE_PHYS,
diff --git a/board/freescale/t102xrdb/Makefile b/board/freescale/t102xrdb/Makefile
index e597486c940..b0f27c47191 100644
--- a/board/freescale/t102xrdb/Makefile
+++ b/board/freescale/t102xrdb/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 else
 obj-y   += t102xrdb.o
diff --git a/board/freescale/t102xrdb/ddr.c b/board/freescale/t102xrdb/ddr.c
index f8d504fb3c7..1a8a131cdcc 100644
--- a/board/freescale/t102xrdb/ddr.c
+++ b/board/freescale/t102xrdb/ddr.c
@@ -236,7 +236,7 @@ int dram_init(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 #ifndef CONFIG_SYS_DDR_RAW_TIMING
 	puts("Initializing....using SPD\n");
 #endif
@@ -248,7 +248,7 @@ int dram_init(void)
 	dram_size = setup_ddr_tlbs(dram_size / 0x100000);
 	dram_size *= 0x100000;
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
diff --git a/board/freescale/t102xrdb/tlb.c b/board/freescale/t102xrdb/tlb.c
index 008bd6e72b7..8e99c2c7022 100644
--- a/board/freescale/t102xrdb/tlb.c
+++ b/board/freescale/t102xrdb/tlb.c
@@ -53,7 +53,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCI */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -100,7 +100,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      0, 11, BOOKE_PAGESZ_256K, 1),
 #endif
 
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 12, BOOKE_PAGESZ_1G, 1),
diff --git a/board/freescale/t104xrdb/Makefile b/board/freescale/t104xrdb/Makefile
index a9495019430..9bca1a1fbcc 100644
--- a/board/freescale/t104xrdb/Makefile
+++ b/board/freescale/t104xrdb/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright 2013 Freescale Semiconductor, Inc.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y	+= t104xrdb.o
diff --git a/board/freescale/t104xrdb/ddr.c b/board/freescale/t104xrdb/ddr.c
index bab684860da..6c066480b46 100644
--- a/board/freescale/t104xrdb/ddr.c
+++ b/board/freescale/t104xrdb/ddr.c
@@ -129,7 +129,7 @@ int dram_init(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 	puts("Initializing....using SPD\n");
 	dram_size = fsl_ddr_sdram();
 #else
@@ -138,7 +138,7 @@ int dram_init(void)
 	dram_size = setup_ddr_tlbs(dram_size / 0x100000);
 	dram_size *= 0x100000;
 
-#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DEEP_SLEEP) && !defined(CONFIG_XPL_BUILD)
 	fsl_dp_resume();
 #endif
 
diff --git a/board/freescale/t104xrdb/tlb.c b/board/freescale/t104xrdb/tlb.c
index 24bc83f756b..7b2183da8b0 100644
--- a/board/freescale/t104xrdb/tlb.c
+++ b/board/freescale/t104xrdb/tlb.c
@@ -38,7 +38,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 		      0, 0, BOOKE_PAGESZ_256K, 1),
 
-#elif defined(CONFIG_NXP_ESBC) && defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_NXP_ESBC) && defined(CONFIG_XPL_BUILD)
 	/*
 	 * *I*G - L3SRAM. When L3 is used as 256K SRAM, in case of Secure Boot
 	 * the physical address of the SRAM is at 0xbffc0000,
@@ -66,7 +66,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCI */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -118,7 +118,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      0, 11, BOOKE_PAGESZ_256K, 1),
 #endif
 
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 12, BOOKE_PAGESZ_1G, 1),
diff --git a/board/freescale/t208xqds/Makefile b/board/freescale/t208xqds/Makefile
index de8613058de..eb99d921b4a 100644
--- a/board/freescale/t208xqds/Makefile
+++ b/board/freescale/t208xqds/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-$(CONFIG_TARGET_T2080QDS) += t208xqds.o eth_t208xqds.o
diff --git a/board/freescale/t208xqds/ddr.c b/board/freescale/t208xqds/ddr.c
index 9076fbba10a..77c8ce0c870 100644
--- a/board/freescale/t208xqds/ddr.c
+++ b/board/freescale/t208xqds/ddr.c
@@ -109,7 +109,7 @@ int dram_init(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 	puts("Initializing....using SPD\n");
 	dram_size = fsl_ddr_sdram();
 #else
diff --git a/board/freescale/t208xqds/tlb.c b/board/freescale/t208xqds/tlb.c
index a4cc532acda..08c140afc68 100644
--- a/board/freescale/t208xqds/tlb.c
+++ b/board/freescale/t208xqds/tlb.c
@@ -65,7 +65,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCIe 1, 0x80000000 */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -142,7 +142,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      0, 18, BOOKE_PAGESZ_1M, 1),
 #endif
 
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 19, BOOKE_PAGESZ_2G, 1)
diff --git a/board/freescale/t208xrdb/Makefile b/board/freescale/t208xrdb/Makefile
index 7af3cd0ac4c..e5ef250c8b2 100644
--- a/board/freescale/t208xrdb/Makefile
+++ b/board/freescale/t208xrdb/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 else
 obj-$(CONFIG_TARGET_T2080RDB) += t208xrdb.o eth_t208xrdb.o cpld.o
diff --git a/board/freescale/t208xrdb/ddr.c b/board/freescale/t208xrdb/ddr.c
index fe98f62668a..cc9586eaa14 100644
--- a/board/freescale/t208xrdb/ddr.c
+++ b/board/freescale/t208xrdb/ddr.c
@@ -102,7 +102,7 @@ int dram_init(void)
 {
 	phys_size_t dram_size;
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 	puts("Initializing....using SPD\n");
 	dram_size = fsl_ddr_sdram();
 #else
diff --git a/board/freescale/t208xrdb/tlb.c b/board/freescale/t208xrdb/tlb.c
index a9a03908dfb..a3f283548f3 100644
--- a/board/freescale/t208xrdb/tlb.c
+++ b/board/freescale/t208xrdb/tlb.c
@@ -65,7 +65,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCIe 1, 0x80000000 */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -141,7 +141,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_G,
 		      0, 18, BOOKE_PAGESZ_1M, 1),
 #endif
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 19, BOOKE_PAGESZ_2G, 1)
diff --git a/board/freescale/t4rdb/Makefile b/board/freescale/t4rdb/Makefile
index 3106848639c..8d94faaba1c 100644
--- a/board/freescale/t4rdb/Makefile
+++ b/board/freescale/t4rdb/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= spl.o
 else
 obj-$(CONFIG_TARGET_T4240RDB)	+= t4240rdb.o
diff --git a/board/freescale/t4rdb/cpld.c b/board/freescale/t4rdb/cpld.c
index cd14d5895f5..f076350c1c5 100644
--- a/board/freescale/t4rdb/cpld.c
+++ b/board/freescale/t4rdb/cpld.c
@@ -94,7 +94,7 @@ static void cpld_dump_regs(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int do_cpld(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int rc = 0;
diff --git a/board/freescale/t4rdb/ddr.c b/board/freescale/t4rdb/ddr.c
index bbe31d4a54e..1ce70962264 100644
--- a/board/freescale/t4rdb/ddr.c
+++ b/board/freescale/t4rdb/ddr.c
@@ -111,7 +111,7 @@ int dram_init(void)
 
 	puts("Initializing....using SPD\n");
 
-#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
+#if defined(CONFIG_XPL_BUILD) || !defined(CONFIG_RAMBOOT_PBL)
 	dram_size = fsl_ddr_sdram();
 #else
 	/* DDR has been initialised by first stage boot loader */
diff --git a/board/freescale/t4rdb/tlb.c b/board/freescale/t4rdb/tlb.c
index 1fb9d41d52b..7c58c14f3b6 100644
--- a/board/freescale/t4rdb/tlb.c
+++ b/board/freescale/t4rdb/tlb.c
@@ -51,7 +51,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SR, MAS2_W|MAS2_G,
 		      0, 2, BOOKE_PAGESZ_256M, 1),
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* *I*G* - PCI */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT, CFG_SYS_PCIE1_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
@@ -114,7 +114,7 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SW|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 		      0, 17, BOOKE_PAGESZ_4K, 1),
 #endif
-#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_RAMBOOT_PBL) && !defined(CONFIG_XPL_BUILD)
 	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE, CFG_SYS_DDR_SDRAM_BASE,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
 		      0, 18, BOOKE_PAGESZ_2G, 1)
diff --git a/board/gardena/smart-gateway-at91sam/Makefile b/board/gardena/smart-gateway-at91sam/Makefile
index a2ed79fd06c..ac9e57938b3 100644
--- a/board/gardena/smart-gateway-at91sam/Makefile
+++ b/board/gardena/smart-gateway-at91sam/Makefile
@@ -2,6 +2,6 @@
 
 obj-y += board.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 endif
diff --git a/board/gardena/smart-gateway-mt7688/board.c b/board/gardena/smart-gateway-mt7688/board.c
index eb7fcd630a1..b6c0fe960ea 100644
--- a/board/gardena/smart-gateway-mt7688/board.c
+++ b/board/gardena/smart-gateway-mt7688/board.c
@@ -295,7 +295,7 @@ err_free:
 	return ret;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 U_BOOT_CMD(
 	fd_write,	1,	0,	do_fd_write,
 	"Write test factory-data values to SPI NOR",
diff --git a/board/gateworks/gw_ventana/Makefile b/board/gateworks/gw_ventana/Makefile
index c407f8e6c54..08859a963d0 100644
--- a/board/gateworks/gw_ventana/Makefile
+++ b/board/gateworks/gw_ventana/Makefile
@@ -7,4 +7,4 @@
 #
 
 obj-y  := gw_ventana.o eeprom.o common.o
-obj-$(CONFIG_SPL_BUILD) += gw_ventana_spl.o
+obj-$(CONFIG_XPL_BUILD) += gw_ventana_spl.o
diff --git a/board/gateworks/gw_ventana/eeprom.c b/board/gateworks/gw_ventana/eeprom.c
index b37f1972249..447862dfee1 100644
--- a/board/gateworks/gw_ventana/eeprom.c
+++ b/board/gateworks/gw_ventana/eeprom.c
@@ -327,7 +327,7 @@ struct ventana_eeprom_config econfig[] = {
 	{ /* Sentinel */ }
 };
 
-#if defined(CONFIG_CMD_EECONFIG) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_EECONFIG) && !defined(CONFIG_XPL_BUILD)
 static struct ventana_eeprom_config *get_config(const char *name)
 {
 	struct ventana_eeprom_config *cfg = econfig;
diff --git a/board/gateworks/venice/Makefile b/board/gateworks/venice/Makefile
index faf1348cfa9..ab69e07ba7b 100644
--- a/board/gateworks/venice/Makefile
+++ b/board/gateworks/venice/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += venice.o eeprom.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 ifdef CONFIG_IMX8MM
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_imx8mm.o
diff --git a/board/gdsys/a38x/Makefile b/board/gdsys/a38x/Makefile
index 4b13859fed1..2713633730f 100644
--- a/board/gdsys/a38x/Makefile
+++ b/board/gdsys/a38x/Makefile
@@ -6,6 +6,6 @@
 
 obj-$(CONFIG_TARGET_CONTROLCENTERDC) += controlcenterdc.o hre.o keyprogram.o dt_helpers.o
 
-ifeq ($(CONFIG_SPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 obj-$(CONFIG_TARGET_CONTROLCENTERDC) += hydra.o ihs_phys.o
 endif
diff --git a/board/gdsys/a38x/controlcenterdc.c b/board/gdsys/a38x/controlcenterdc.c
index 4abb3e45128..659dfddecea 100644
--- a/board/gdsys/a38x/controlcenterdc.c
+++ b/board/gdsys/a38x/controlcenterdc.c
@@ -84,7 +84,7 @@ int hws_board_topology_load(struct serdes_map **serdes_map_array, u8 *count)
 
 void spl_board_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	uint k;
 	struct gpio_desc gpio = {};
 
@@ -139,7 +139,7 @@ struct mv_ddr_topology_map *mv_ddr_topology_map_get(void)
 
 int board_early_init_f(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* Configure MPP */
 	writel(0x00111111, MVEBU_MPP_BASE + 0x00);
 	writel(0x40040000, MVEBU_MPP_BASE + 0x04);
@@ -174,7 +174,7 @@ int board_init(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 void init_host_phys(struct mii_dev *bus)
 {
 	uint k;
@@ -241,7 +241,7 @@ int ccdc_eth_init(void)
 
 int board_late_init(void)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	hydra_initialize();
 #endif
 	return 0;
@@ -272,13 +272,13 @@ int board_fix_fdt(void *rw_fdt_blob)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int last_stage_init(void)
 {
 	struct udevice *tpm;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return 0;
 	ccdc_eth_init();
 
diff --git a/board/ge/b1x5v2/b1x5v2.c b/board/ge/b1x5v2/b1x5v2.c
index 031773bc5ef..c1aacd1458b 100644
--- a/board/ge/b1x5v2/b1x5v2.c
+++ b/board/ge/b1x5v2/b1x5v2.c
@@ -35,7 +35,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define B1X5V2_GE_VPD_OFFSET	0x0100000
 #define B1X5V2_GE_VPD_SIZE	1022
@@ -695,4 +695,4 @@ U_BOOT_CMD(
        ""
 );
 
-#endif // CONFIG_SPL_BUILD
+#endif // CONFIG_XPL_BUILD
diff --git a/board/ge/b1x5v2/spl.c b/board/ge/b1x5v2/spl.c
index 460d3be1d83..b6f23345acd 100644
--- a/board/ge/b1x5v2/spl.c
+++ b/board/ge/b1x5v2/spl.c
@@ -20,7 +20,7 @@
 #include <spi_flash.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 
 #include <asm/arch/mx6-ddr.h>
 
diff --git a/board/google/chromebook_coral/coral.c b/board/google/chromebook_coral/coral.c
index 7b2724c01d0..3443dc91885 100644
--- a/board/google/chromebook_coral/coral.c
+++ b/board/google/chromebook_coral/coral.c
@@ -147,7 +147,7 @@ static int coral_get_str(struct udevice *dev, int id, size_t size, char *val)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return -ENOSYS;
 
 	switch (id) {
diff --git a/board/google/gru/gru.c b/board/google/gru/gru.c
index e08cb42c27e..f3a1a19f2b6 100644
--- a/board/google/gru/gru.c
+++ b/board/google/gru/gru.c
@@ -7,7 +7,7 @@
 #include <init.h>
 #include <asm/arch-rockchip/clock.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* provided to defeat compiler optimisation in board_init_f() */
 void gru_dummy_function(int i)
 {
@@ -33,7 +33,7 @@ int board_early_init_f(void)
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int board_early_init_r(void)
 {
 	struct udevice *clk;
diff --git a/board/google/imx8mq_phanbell/Makefile b/board/google/imx8mq_phanbell/Makefile
index d6427cf8e90..ac6418e49a7 100644
--- a/board/google/imx8mq_phanbell/Makefile
+++ b/board/google/imx8mq_phanbell/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += imx8mq_phanbell.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_1g.o
 endif
diff --git a/board/google/veyron/veyron.c b/board/google/veyron/veyron.c
index bd8ce633772..7057b76e290 100644
--- a/board/google/veyron/veyron.c
+++ b/board/google/veyron/veyron.c
@@ -19,7 +19,7 @@
  * There is a U-Boot driver for this but it may need to add support for the
  * 'voltage-table' property.
  */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if !CONFIG_IS_ENABLED(ROCKCHIP_BACK_TO_BROM)
 static int veyron_init(void)
 {
diff --git a/board/grinn/chiliboard/board.c b/board/grinn/chiliboard/board.c
index e0eb8aa9f2b..d5491d5076f 100644
--- a/board/grinn/chiliboard/board.c
+++ b/board/grinn/chiliboard/board.c
@@ -104,7 +104,7 @@ int board_init(void)
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
 {
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	uint8_t mac_addr[6];
 	uint32_t mac_hi, mac_lo;
 
diff --git a/board/grinn/liteboard/board.c b/board/grinn/liteboard/board.c
index 07bb5b7d797..c2a44b4aa2d 100644
--- a/board/grinn/liteboard/board.c
+++ b/board/grinn/liteboard/board.c
@@ -229,7 +229,7 @@ int checkboard(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void board_boot_order(u32 *spl_boot_list)
 {
 	struct src *psrc = (struct src *)SRC_BASE_ADDR;
diff --git a/board/htc/endeavoru/Makefile b/board/htc/endeavoru/Makefile
index 0c6ba4af3b1..57f84d6ea98 100644
--- a/board/htc/endeavoru/Makefile
+++ b/board/htc/endeavoru/Makefile
@@ -6,6 +6,6 @@
 #  (C) Copyright 2021
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-obj-$(CONFIG_SPL_BUILD) += endeavoru-spl.o
+obj-$(CONFIG_XPL_BUILD) += endeavoru-spl.o
 
 obj-y += endeavoru.o
diff --git a/board/imgtec/ci20/ci20.c b/board/imgtec/ci20/ci20.c
index 4e268381d3c..3e9833d684f 100644
--- a/board/imgtec/ci20/ci20.c
+++ b/board/imgtec/ci20/ci20.c
@@ -39,7 +39,7 @@ static void ci20_mux_mmc(void)
 	jz4780_clk_ungate_mmc();
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 static void ci20_mux_eth(void)
 {
@@ -251,7 +251,7 @@ int checkboard(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #if defined(CONFIG_SPL_MMC)
 int board_mmc_init(struct bd_info *bd)
diff --git a/board/isee/igep003x/Makefile b/board/isee/igep003x/Makefile
index c3e39745252..02ec0ccbdb2 100644
--- a/board/isee/igep003x/Makefile
+++ b/board/isee/igep003x/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2013, ISEE 2007 SL - http://www.isee.biz/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= mux.o
 endif
 
diff --git a/board/isee/igep003x/board.c b/board/isee/igep003x/board.c
index 7cd26ce3c34..162467c803a 100644
--- a/board/isee/igep003x/board.c
+++ b/board/isee/igep003x/board.c
@@ -68,7 +68,7 @@ static int get_board_revision(void)
 	return revision;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* PN H5TQ4G63AFR is equivalent to MT41K256M16HA125*/
 static const struct ddr_data ddr3_igep0034_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
diff --git a/board/isee/igep00x0/Makefile b/board/isee/igep00x0/Makefile
index e095bcada29..527748cdadd 100644
--- a/board/isee/igep00x0/Makefile
+++ b/board/isee/igep00x0/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000, 2001, 2002
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= spl.o common.o
 else
 obj-y	:= igep00x0.o common.o
diff --git a/board/k+p/kp_imx6q_tpc/Makefile b/board/k+p/kp_imx6q_tpc/Makefile
index 6551b2bfa2d..6444628c649 100644
--- a/board/k+p/kp_imx6q_tpc/Makefile
+++ b/board/k+p/kp_imx6q_tpc/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2018 Lukasz Majewski <lukma@denx.de>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= kp_imx6q_tpc_spl.o
 else
 obj-y	:= kp_imx6q_tpc.o
diff --git a/board/kontron/pitx_imx8m/Makefile b/board/kontron/pitx_imx8m/Makefile
index 6ebe5d07709..50ca56f4efd 100644
--- a/board/kontron/pitx_imx8m/Makefile
+++ b/board/kontron/pitx_imx8m/Makefile
@@ -2,7 +2,7 @@
 
 obj-y += pitx_imx8m.o pitx_misc.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o pitx_misc.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_2gb.o lpddr4_timing_4gb.o
 endif
diff --git a/board/kontron/sl-mx6ul/Makefile b/board/kontron/sl-mx6ul/Makefile
index 6af5f65450a..dfed1991ee7 100644
--- a/board/kontron/sl-mx6ul/Makefile
+++ b/board/kontron/sl-mx6ul/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # (C) Copyright 2018 Kontron Electronics GmbH
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y := spl.o
 else
 obj-y := sl-mx6ul.o
diff --git a/board/kontron/sl-mx8mm/Makefile b/board/kontron/sl-mx8mm/Makefile
index fceed684ede..b47fafc5733 100644
--- a/board/kontron/sl-mx8mm/Makefile
+++ b/board/kontron/sl-mx8mm/Makefile
@@ -3,7 +3,7 @@
 
 obj-y := sl-mx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/kontron/sl28/Makefile b/board/kontron/sl28/Makefile
index 084c11da376..2cb41251708 100644
--- a/board/kontron/sl28/Makefile
+++ b/board/kontron/sl28/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += sl28.o cmds.o
 endif
 
@@ -8,7 +8,7 @@ obj-y += common.o ddr.o
 
 obj-$(CONFIG_ARMV8_PSCI) += psci.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_SPL_ATF) += spl_atf.o
 endif
diff --git a/board/kontron/sl28/ddr.c b/board/kontron/sl28/ddr.c
index 9b881fdc265..1f1a6aa1b16 100644
--- a/board/kontron/sl28/ddr.c
+++ b/board/kontron/sl28/ddr.c
@@ -98,7 +98,7 @@ int fsl_initdram(void)
 		break;
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL) || IS_ENABLED(CONFIG_SPL_BUILD))
+	if (!IS_ENABLED(CONFIG_SPL) || IS_ENABLED(CONFIG_XPL_BUILD))
 		fsl_ddr_set_memctl_regs(&ddr_cfg_regs, 0, 0);
 
 	gd->ram_size = dram_size;
diff --git a/board/kosagi/novena/Makefile b/board/kosagi/novena/Makefile
index 64d32f5a963..fdcd8b5f422 100644
--- a/board/kosagi/novena/Makefile
+++ b/board/kosagi/novena/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2014 Marek Vasut <marex@denx.de>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= novena_spl.o
 else
 obj-y	:= novena.o
diff --git a/board/lenovo/ideapad-yoga-11/Makefile b/board/lenovo/ideapad-yoga-11/Makefile
index 186f1cb4ee5..fd9736d1bf1 100644
--- a/board/lenovo/ideapad-yoga-11/Makefile
+++ b/board/lenovo/ideapad-yoga-11/Makefile
@@ -3,4 +3,4 @@
 #  (C) Copyright 2022
 #  Open Surface RT
 
-obj-$(CONFIG_SPL_BUILD) += ideapad-yoga-11-spl.o
+obj-$(CONFIG_XPL_BUILD) += ideapad-yoga-11-spl.o
diff --git a/board/lg/sniper/sniper.c b/board/lg/sniper/sniper.c
index 9d0959f294e..d4db32ee69b 100644
--- a/board/lg/sniper/sniper.c
+++ b/board/lg/sniper/sniper.c
@@ -54,7 +54,7 @@ void set_muxconf_regs(void)
 	MUX_SNIPER();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void get_board_mem_timings(struct board_sdrc_timings *timings)
 {
 	timings->mcfg = HYNIX_V_MCFG_200(256 << 20);
diff --git a/board/lg/x3-t30/Makefile b/board/lg/x3-t30/Makefile
index 3eeb132f3c6..fb2527f9ee8 100644
--- a/board/lg/x3-t30/Makefile
+++ b/board/lg/x3-t30/Makefile
@@ -6,6 +6,6 @@
 #  (C) Copyright 2021
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-obj-$(CONFIG_SPL_BUILD) += x3-t30-spl.o
+obj-$(CONFIG_XPL_BUILD) += x3-t30-spl.o
 
 obj-y += x3-t30.o
diff --git a/board/liebherr/display5/Makefile b/board/liebherr/display5/Makefile
index ee503add75d..c62583a9806 100644
--- a/board/liebherr/display5/Makefile
+++ b/board/liebherr/display5/Makefile
@@ -4,7 +4,7 @@
 #
 # SPDX-License-Identifier:    GPL-2.0+
 #
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y = spl.o
 else
 obj-y := display5.o
diff --git a/board/liebherr/mccmon6/Makefile b/board/liebherr/mccmon6/Makefile
index 3c9786c6b7d..d5fdc2011b0 100644
--- a/board/liebherr/mccmon6/Makefile
+++ b/board/liebherr/mccmon6/Makefile
@@ -2,7 +2,7 @@
 #
 # (C) Copyright 2016-2017
 # Lukasz Majewski, DENX Software Engineering, lukma@denx.de
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y  := spl.o
 else
 obj-y  := mccmon6.o
diff --git a/board/liebherr/xea/Makefile b/board/liebherr/xea/Makefile
index abf500857f6..6efa07ca004 100644
--- a/board/liebherr/xea/Makefile
+++ b/board/liebherr/xea/Makefile
@@ -7,6 +7,6 @@
 
 obj-y	:= xea.o
 
-ifdef	CONFIG_SPL_BUILD
+ifdef	CONFIG_XPL_BUILD
 obj-y	+= spl_xea.o
 endif
diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index 9ade3563b25..1d4f165fd13 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -37,7 +37,7 @@
 #include <spi.h>
 #include <spi_flash.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #endif
 
@@ -62,7 +62,7 @@ static void init_clocks(void)
 	mxs_set_sspclk(MXC_SSPCLK3, 96000, 0);
 }
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_FRAMEWORK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_FRAMEWORK)
 void board_init_f(ulong arg)
 {
 	init_clocks();
@@ -355,4 +355,4 @@ U_BOOT_DRIVER(fsl_imx28_clkctrl) = {
 	.id             = UCLASS_CLK,
 	.of_match       = imx28_clk_ids,
 };
-#endif	/* CONFIG_SPL_BUILD */
+#endif	/* CONFIG_XPL_BUILD */
diff --git a/board/logicpd/am3517evm/am3517evm.c b/board/logicpd/am3517evm/am3517evm.c
index e6ca31016b7..e4f619d0942 100644
--- a/board/logicpd/am3517evm/am3517evm.c
+++ b/board/logicpd/am3517evm/am3517evm.c
@@ -39,7 +39,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define CPGMACSS_SW_RST		(1 << 1)
 #define PHY_GPIO		30
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_SPL_OS_BOOT)
 int spl_start_uboot(void)
 {
diff --git a/board/logicpd/imx6/imx6logic.c b/board/logicpd/imx6/imx6logic.c
index 589136fd64a..652994df616 100644
--- a/board/logicpd/imx6/imx6logic.c
+++ b/board/logicpd/imx6/imx6logic.c
@@ -135,7 +135,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <asm/arch/mx6-ddr.h>
 #include <asm/arch/mx6q-ddr.h>
 #include <spl.h>
diff --git a/board/logicpd/omap3som/omap3logic.c b/board/logicpd/omap3som/omap3logic.c
index a9fe61918b6..352b519b451 100644
--- a/board/logicpd/omap3som/omap3logic.c
+++ b/board/logicpd/omap3som/omap3logic.c
@@ -68,7 +68,7 @@ int spl_start_uboot(void)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 /*
  * Routine: get_board_mem_timings
  * Description: If we use SPL then there is no x-loader nor config header
diff --git a/board/menlo/m53menlo/m53menlo.c b/board/menlo/m53menlo/m53menlo.c
index 79351f47273..fc76d5765fa 100644
--- a/board/menlo/m53menlo/m53menlo.c
+++ b/board/menlo/m53menlo/m53menlo.c
@@ -524,7 +524,7 @@ int checkboard(void)
 /*
  * NAND SPL
  */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 	setup_iomux_nand();
diff --git a/board/menlo/mx8menlo/Makefile b/board/menlo/mx8menlo/Makefile
index fd5ec826336..62939395ba1 100644
--- a/board/menlo/mx8menlo/Makefile
+++ b/board/menlo/mx8menlo/Makefile
@@ -9,13 +9,13 @@ obj-y	:= mx8menlo.o
 
 obj-y += ../../toradex/verdin-imx8mm/verdin-imx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += ../../toradex/verdin-imx8mm/spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += ../../toradex/verdin-imx8mm/lpddr4_timing.o
 endif
 
 # Common for all Toradex modules
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 # Necessary to create built-in.o
 obj- := __dummy__.o
 else
diff --git a/board/microsoft/surface-rt/Makefile b/board/microsoft/surface-rt/Makefile
index da4094a7df3..feda1dba3bd 100644
--- a/board/microsoft/surface-rt/Makefile
+++ b/board/microsoft/surface-rt/Makefile
@@ -3,4 +3,4 @@
 #  (C) Copyright 2021
 #  Open Surface RT
 
-obj-$(CONFIG_SPL_BUILD) += surface-rt-spl.o
+obj-$(CONFIG_XPL_BUILD) += surface-rt-spl.o
diff --git a/board/mntre/imx8mq_reform2/Makefile b/board/mntre/imx8mq_reform2/Makefile
index 2efd56bb4ad..2772c8dc717 100644
--- a/board/mntre/imx8mq_reform2/Makefile
+++ b/board/mntre/imx8mq_reform2/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mq_reform2.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/msc/sm2s_imx8mp/Makefile b/board/msc/sm2s_imx8mp/Makefile
index 7908a0ceb04..48dc885b8f6 100644
--- a/board/msc/sm2s_imx8mp/Makefile
+++ b/board/msc/sm2s_imx8mp/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:      GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing.o
 else
 obj-y += sm2s_imx8mp.o
diff --git a/board/myir/mys_6ulx/Makefile b/board/myir/mys_6ulx/Makefile
index 3c63e439aba..9b76595701e 100644
--- a/board/myir/mys_6ulx/Makefile
+++ b/board/myir/mys_6ulx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
 obj-y  := mys_6ulx.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/nvidia/beaver/Makefile b/board/nvidia/beaver/Makefile
index 5e9e70825c7..d56c7151af6 100644
--- a/board/nvidia/beaver/Makefile
+++ b/board/nvidia/beaver/Makefile
@@ -2,6 +2,6 @@
 #
 # Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
 
-obj-$(CONFIG_SPL_BUILD) += beaver-spl.o
+obj-$(CONFIG_XPL_BUILD) += beaver-spl.o
 
 obj-y	= ../cardhu/cardhu.o
diff --git a/board/nvidia/cardhu/Makefile b/board/nvidia/cardhu/Makefile
index 6f480cdfd3b..85d88295c08 100644
--- a/board/nvidia/cardhu/Makefile
+++ b/board/nvidia/cardhu/Makefile
@@ -3,6 +3,6 @@
 #  (C) Copyright 2010-2012
 #  NVIDIA Corporation <www.nvidia.com>
 
-obj-$(CONFIG_SPL_BUILD) += cardhu-spl.o
+obj-$(CONFIG_XPL_BUILD) += cardhu-spl.o
 
 obj-y	+= cardhu.o
diff --git a/board/olimex/mx23_olinuxino/Makefile b/board/olimex/mx23_olinuxino/Makefile
index b2ea8974344..0a6beb10ded 100644
--- a/board/olimex/mx23_olinuxino/Makefile
+++ b/board/olimex/mx23_olinuxino/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef	CONFIG_SPL_BUILD
+ifndef	CONFIG_XPL_BUILD
 obj-y	:= mx23_olinuxino.o
 else
 obj-y	:= spl_boot.o
diff --git a/board/opalkelly/zynq/Makefile b/board/opalkelly/zynq/Makefile
index 19e893e43d7..8a2375a1068 100644
--- a/board/opalkelly/zynq/Makefile
+++ b/board/opalkelly/zynq/Makefile
@@ -4,4 +4,4 @@ obj-y	:= board.o
 
 hw-platform-y :=$(shell echo $(CONFIG_DEFAULT_DEVICE_TREE))
 
-obj-$(CONFIG_SPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
+obj-$(CONFIG_XPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index 04469d0a924..cd78f7686fe 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2023 PHYTEC Messtechnik GmbH
 # Author: Teresa Remmet <t.remmet@phytec.de>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 # necessary to create built-in.o
 obj- := __dummy__.o
 endif
diff --git a/board/phytec/pcl063/Makefile b/board/phytec/pcl063/Makefile
index 53c73c9b082..0f17eb466c5 100644
--- a/board/phytec/pcl063/Makefile
+++ b/board/phytec/pcl063/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-y  := pcl063.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/phytec/pcm058/pcm058.c b/board/phytec/pcm058/pcm058.c
index ecc5b75d8d4..4a95376b359 100644
--- a/board/phytec/pcm058/pcm058.c
+++ b/board/phytec/pcm058/pcm058.c
@@ -108,7 +108,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
 
diff --git a/board/phytec/phycore_am335x_r2/Makefile b/board/phytec/phycore_am335x_r2/Makefile
index 16ac38fd8be..4f865ab9e10 100644
--- a/board/phytec/phycore_am335x_r2/Makefile
+++ b/board/phytec/phycore_am335x_r2/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= mux.o
 endif
 
diff --git a/board/phytec/phycore_am335x_r2/board.c b/board/phytec/phycore_am335x_r2/board.c
index 2022525651d..a2a488a0e30 100644
--- a/board/phytec/phycore_am335x_r2/board.c
+++ b/board/phytec/phycore_am335x_r2/board.c
@@ -26,7 +26,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 static struct ctrl_dev *cdev = (struct ctrl_dev *)CTRL_DEVICE_BASE;
 
diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 9f6bc736cbb..a0e098e010e 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -182,7 +182,7 @@ int do_board_detect(void)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 	u64 start[CONFIG_NR_DRAM_BANKS];
diff --git a/board/phytec/phycore_imx8mm/Makefile b/board/phytec/phycore_imx8mm/Makefile
index 27f6c027b6c..2fb59761fc9 100644
--- a/board/phytec/phycore_imx8mm/Makefile
+++ b/board/phytec/phycore_imx8mm/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += phycore-imx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/phytec/phycore_imx8mp/Makefile b/board/phytec/phycore_imx8mp/Makefile
index c4c434c9475..8cf1f4dcea3 100644
--- a/board/phytec/phycore_imx8mp/Makefile
+++ b/board/phytec/phycore_imx8mp/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += phycore-imx8mp.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/phytec/phycore_imx93/Makefile b/board/phytec/phycore_imx93/Makefile
index ce35326a156..dd5085e160f 100644
--- a/board/phytec/phycore_imx93/Makefile
+++ b/board/phytec/phycore_imx93/Makefile
@@ -9,6 +9,6 @@
 
 obj-y += phycore-imx93.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o lpddr4_timing.o
 endif
diff --git a/board/polyhex/imx8mp_debix_model_a/Makefile b/board/polyhex/imx8mp_debix_model_a/Makefile
index e5cdc850878..3d50c7af4af 100644
--- a/board/polyhex/imx8mp_debix_model_a/Makefile
+++ b/board/polyhex/imx8mp_debix_model_a/Makefile
@@ -7,7 +7,7 @@
 
 obj-y += imx8mp_debix_model_a.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/purism/librem5/Makefile b/board/purism/librem5/Makefile
index 47f25f047b7..4514add3a5b 100644
--- a/board/purism/librem5/Makefile
+++ b/board/purism/librem5/Makefile
@@ -7,7 +7,7 @@
 
 obj-y += librem5.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o lpddr4_timing_b0.o
 endif
diff --git a/board/purism/librem5/librem5.h b/board/purism/librem5/librem5.h
index 0d24edea9b1..69475a5b063 100644
--- a/board/purism/librem5/librem5.h
+++ b/board/purism/librem5/librem5.h
@@ -57,7 +57,7 @@
 /* Could be ASPEN, BIRCH or CHESTNUT. assume CHESTNUT */
 #define BOARD_REV_UNKNOWN	BOARD_REV_CHESTNUT
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static const iomux_v3_cfg_t configure_pads[] = {
 	IMX8MQ_PAD_GPIO1_IO00__GPIO1_IO0 | MUX_PAD_CTRL(PAD_CTL_DSE6),
 	IMX8MQ_PAD_GPIO1_IO03__GPIO1_IO3 | MUX_PAD_CTRL(PAD_CTL_DSE6) | MUX_MODE_SION,
@@ -151,7 +151,7 @@ static inline void init_pinmux(void)
 	gpio_direction_output(AUDIO_EN, 1);
 	gpio_direction_output(DSI_EN, 1);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define USB1_BASE_ADDR         0x38100000
 #define USB2_BASE_ADDR         0x38200000
diff --git a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
index a533128b92f..fd827467b30 100644
--- a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
+++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
@@ -18,7 +18,7 @@ struct efi_capsule_update_info update_info = {
 
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
 static bool board_is_rockpi_4b(void)
 {
@@ -55,4 +55,4 @@ void rockchip_capsule_update_board_setup(void)
 	}
 }
 #endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/renesas/alt/Makefile b/board/renesas/alt/Makefile
index 53418699b27..f9c131fc6cd 100644
--- a/board/renesas/alt/Makefile
+++ b/board/renesas/alt/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= alt_spl.o
 else
 obj-y	:= alt.o qos.o
diff --git a/board/renesas/condor/Makefile b/board/renesas/condor/Makefile
index 19e6038430b..cb965cde35f 100644
--- a/board/renesas/condor/Makefile
+++ b/board/renesas/condor/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/common.o
diff --git a/board/renesas/draak/Makefile b/board/renesas/draak/Makefile
index 1fc90d1dab4..8859cf902ca 100644
--- a/board/renesas/draak/Makefile
+++ b/board/renesas/draak/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= draak.o ../rcar-common/common.o
diff --git a/board/renesas/eagle/Makefile b/board/renesas/eagle/Makefile
index 9fb6a7c0f0a..98164b5ea29 100644
--- a/board/renesas/eagle/Makefile
+++ b/board/renesas/eagle/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/v3-common.o ../rcar-common/common.o
diff --git a/board/renesas/ebisu/Makefile b/board/renesas/ebisu/Makefile
index 956ce8a90fa..283d3a4ae36 100644
--- a/board/renesas/ebisu/Makefile
+++ b/board/renesas/ebisu/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/common.o
diff --git a/board/renesas/falcon/Makefile b/board/renesas/falcon/Makefile
index 3b202c24fb1..2e240d3bad6 100644
--- a/board/renesas/falcon/Makefile
+++ b/board/renesas/falcon/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= falcon.o ../rcar-common/common.o
diff --git a/board/renesas/gose/Makefile b/board/renesas/gose/Makefile
index c6a1dc21cda..2c45bd74014 100644
--- a/board/renesas/gose/Makefile
+++ b/board/renesas/gose/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= gose_spl.o
 else
 obj-y	:= gose.o qos.o
diff --git a/board/renesas/koelsch/Makefile b/board/renesas/koelsch/Makefile
index 77cf067406c..1b0818fa7ec 100644
--- a/board/renesas/koelsch/Makefile
+++ b/board/renesas/koelsch/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= koelsch_spl.o
 else
 obj-y	:= koelsch.o qos.o
diff --git a/board/renesas/lager/Makefile b/board/renesas/lager/Makefile
index 379368fdfce..77e380f9335 100644
--- a/board/renesas/lager/Makefile
+++ b/board/renesas/lager/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= lager_spl.o
 else
 obj-y	:= lager.o qos.o
diff --git a/board/renesas/porter/Makefile b/board/renesas/porter/Makefile
index c237ee5ec77..9f22044bc79 100644
--- a/board/renesas/porter/Makefile
+++ b/board/renesas/porter/Makefile
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= porter_spl.o
 else
 obj-y	:= porter.o qos.o
diff --git a/board/renesas/salvator-x/Makefile b/board/renesas/salvator-x/Makefile
index 95258079e40..0fc69ba9de6 100644
--- a/board/renesas/salvator-x/Makefile
+++ b/board/renesas/salvator-x/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= salvator-x.o ../rcar-common/common.o
diff --git a/board/renesas/silk/Makefile b/board/renesas/silk/Makefile
index b5c3ad8d934..48dd7dbb8be 100644
--- a/board/renesas/silk/Makefile
+++ b/board/renesas/silk/Makefile
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= silk_spl.o
 else
 obj-y	:= silk.o qos.o
diff --git a/board/renesas/stout/Makefile b/board/renesas/stout/Makefile
index b8875bb7b98..e1bca5339b9 100644
--- a/board/renesas/stout/Makefile
+++ b/board/renesas/stout/Makefile
@@ -8,7 +8,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= stout_spl.o
 else
 obj-y	:= stout.o cpld.o qos.o
diff --git a/board/renesas/ulcb/Makefile b/board/renesas/ulcb/Makefile
index f4d24c68a67..ec2f161feae 100644
--- a/board/renesas/ulcb/Makefile
+++ b/board/renesas/ulcb/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ulcb.o cpld.o ../rcar-common/common.o
diff --git a/board/renesas/v3hsk/Makefile b/board/renesas/v3hsk/Makefile
index a9d597edd58..b29114c7239 100644
--- a/board/renesas/v3hsk/Makefile
+++ b/board/renesas/v3hsk/Makefile
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/v3-common.o ../rcar-common/common.o
diff --git a/board/renesas/v3msk/Makefile b/board/renesas/v3msk/Makefile
index ec493e572f1..f8c4bcdcf9f 100644
--- a/board/renesas/v3msk/Makefile
+++ b/board/renesas/v3msk/Makefile
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../rcar-common/gen3-spl.o
 else
 obj-y	:= ../rcar-common/v3-common.o ../rcar-common/common.o
diff --git a/board/ronetix/imx7-cm/Makefile b/board/ronetix/imx7-cm/Makefile
index 7e08f238a0d..1ca6332852f 100644
--- a/board/ronetix/imx7-cm/Makefile
+++ b/board/ronetix/imx7-cm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # (C) Copyright 2017 NXP Semiconductors
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y  += spl.o
 else
 obj-y  += imx7-cm.o
diff --git a/board/ronetix/imx8mq-cm/Makefile b/board/ronetix/imx8mq-cm/Makefile
index 0d9d8e646db..4ca2a96d81e 100644
--- a/board/ronetix/imx8mq-cm/Makefile
+++ b/board/ronetix/imx8mq-cm/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mq_cm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/samsung/common/Makefile b/board/samsung/common/Makefile
index d31b81abf1e..abecef8be11 100644
--- a/board/samsung/common/Makefile
+++ b/board/samsung/common/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_USB_GADGET_DOWNLOAD) += gadget.o
 obj-$(CONFIG_MISC_COMMON) += misc.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_BOARD_COMMON)	+= board.o sromc.o
 ifdef CONFIG_EXYNOS5_DT
 obj-y += exynos5-dt.o
diff --git a/board/samsung/origen/Makefile b/board/samsung/origen/Makefile
index 44691af09f4..940f689a601 100644
--- a/board/samsung/origen/Makefile
+++ b/board/samsung/origen/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2011 Samsung Electronics
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 # necessary to create built-in.o
 obj- := __dummy__.o
 
diff --git a/board/samsung/smdkv310/Makefile b/board/samsung/smdkv310/Makefile
index fccd8ffd2c1..b7f9d5a254c 100644
--- a/board/samsung/smdkv310/Makefile
+++ b/board/samsung/smdkv310/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (C) 2011 Samsung Electronics
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 # necessary to create built-in.o
 obj- := __dummy__.o
 
diff --git a/board/seeed/npi_imx6ull/Makefile b/board/seeed/npi_imx6ull/Makefile
index 93ea413517d..bd8f83148bb 100644
--- a/board/seeed/npi_imx6ull/Makefile
+++ b/board/seeed/npi_imx6ull/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
 obj-y	:= npi_imx6ull.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/sielaff/imx6dl-sielaff/Makefile b/board/sielaff/imx6dl-sielaff/Makefile
index 65cecfe6f6c..9c8bab662e4 100644
--- a/board/sielaff/imx6dl-sielaff/Makefile
+++ b/board/sielaff/imx6dl-sielaff/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # (C) Copyright 2022 Kontron Electronics GmbH
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y := spl.o
 else
 obj-y := imx6dl-sielaff.o
diff --git a/board/siemens/capricorn/Makefile b/board/siemens/capricorn/Makefile
index 4dafac10829..e8a24c448b9 100644
--- a/board/siemens/capricorn/Makefile
+++ b/board/siemens/capricorn/Makefile
@@ -6,7 +6,7 @@
 obj-y += board.o
 obj-y += ../common/eeprom.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += ../common/factoryset.o
diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 53dac8bfe1b..ad474d9baa0 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -235,7 +235,7 @@ void reset_cpu(void)
 {
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /* LED's */
 static int board_led_init(void)
 {
@@ -265,7 +265,7 @@ static int board_led_init(void)
 	mdelay(1);
 	return ret;
 }
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
 
 int checkboard(void)
 {
@@ -335,7 +335,7 @@ void board_late_mmc_env_init(void)
 	run_command(cmd, 0);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int load_parameters_from_factoryset(void)
 {
 	int ret;
@@ -443,4 +443,4 @@ U_BOOT_CMD(
 	"Reset eth phy",
 	"[print]"
 );
-#endif /* ! CONFIG_SPL_BUILD */
+#endif /* ! CONFIG_XPL_BUILD */
diff --git a/board/siemens/common/board_am335x.c b/board/siemens/common/board_am335x.c
index e6537b0675a..daf0bb930ec 100644
--- a/board/siemens/common/board_am335x.c
+++ b/board/siemens/common/board_am335x.c
@@ -22,7 +22,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void set_uart_mux_conf(void)
 {
 	enable_uart0_pin_mux();
@@ -52,9 +52,9 @@ void sdram_init(void)
 
 	return;
 }
-#endif /* #ifdef CONFIG_SPL_BUILD */
+#endif /* #ifdef CONFIG_XPL_BUILD */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * Basic board specific setup.  Pinmux has been handled already.
  */
@@ -78,7 +78,7 @@ int board_init(void)
 
 	return 0;
 }
-#endif /* #ifndef CONFIG_SPL_BUILD */
+#endif /* #ifndef CONFIG_XPL_BUILD */
 
 #define OSC	(V_OSCK/1000000)
 const struct dpll_params dpll_ddr = {
@@ -89,7 +89,7 @@ const struct dpll_params *get_dpll_ddr_params(void)
 	return &dpll_ddr;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define MAX_NR_LEDS	10
 #define MAX_PIN_NUMBER	128
@@ -247,4 +247,4 @@ U_BOOT_CMD(
 	"Set LEDs defined in environment",
 	"<0|1>"
 );
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
diff --git a/board/siemens/common/board_am335x.h b/board/siemens/common/board_am335x.h
index 3a20352d457..4c9d5b04f12 100644
--- a/board/siemens/common/board_am335x.h
+++ b/board/siemens/common/board_am335x.h
@@ -22,7 +22,7 @@ void spl_draco_board_init(void);
 void draco_init_ddr(void);
 int draco_read_eeprom(void);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* Mux for init: uart?, i2c0 to read the main EEPROM */
 void enable_uart0_pin_mux(void);
 void enable_uart1_pin_mux(void);
@@ -34,6 +34,6 @@ void enable_i2c0_pin_mux(void);
 
 /* Main mux function to enable other pinmux required on the board */
 void enable_board_pin_mux(void);
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _BOARD_AM335X_H_ */
diff --git a/board/siemens/common/factoryset.c b/board/siemens/common/factoryset.c
index a250ccfe252..8261b3d37cc 100644
--- a/board/siemens/common/factoryset.c
+++ b/board/siemens/common/factoryset.c
@@ -5,7 +5,7 @@
  * (C) Copyright 2013 Siemens Schweiz AG
  */
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 
 #include <env.h>
 #include <g_dnl.h>
@@ -350,4 +350,4 @@ int g_dnl_get_board_bcd_device_number(int gcnum)
 {
 	return factory_dat.version;
 }
-#endif /* defined(CONFIG_SPL_BUILD) */
+#endif /* defined(CONFIG_XPL_BUILD) */
diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
index cd27fc1cc37..a8714e055d7 100644
--- a/board/siemens/corvus/board.c
+++ b/board/siemens/corvus/board.c
@@ -114,7 +114,7 @@ static void corvus_nand_hw_init(void)
 	at91_set_gpio_input(CFG_SYS_NAND_READY_PIN, 1);
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 
diff --git a/board/siemens/draco/Makefile b/board/siemens/draco/Makefile
index aae536472c5..ac59c5bd985 100644
--- a/board/siemens/draco/Makefile
+++ b/board/siemens/draco/Makefile
@@ -9,13 +9,13 @@
 # u-boot:/board/ti/am335x/Makefile
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
 obj-y += ../common/board_am335x.o
 obj-y += ../common/eeprom.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index fc3eb06ccf2..147f827673b 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -28,7 +28,7 @@
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static struct draco_baseboard_id __section(".data") settings;
 
 #if DDR_PLL_FREQ == 303
@@ -106,7 +106,7 @@ static void print_chip_data(void)
 	printf("hw version: \t'%s'\n", settings.chip.shwver);
 	printf("max freq: \t%d MHz\n", dpll_mpu_opp100.m);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define AM335X_NAND_ECC_MASK 0x0f
 #define AM335X_NAND_ECC_TYPE_16 0x02
@@ -142,7 +142,7 @@ static int draco_read_nand_geometry(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*
  * Read header information from EEPROM into global structure.
  */
@@ -233,7 +233,7 @@ void spl_draco_board_init(void)
 {
 	return;
 }
-#endif /* if def CONFIG_SPL_BUILD */
+#endif /* if def CONFIG_XPL_BUILD */
 
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
@@ -266,8 +266,8 @@ int board_late_init(void)
 }
 #endif
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 static void cpsw_control(int enabled)
 {
 	/* VTP can be added here */
@@ -343,4 +343,4 @@ U_BOOT_CMD(
 	""
 );
 #endif /* #if defined(CONFIG_DRIVER_TI_CPSW) */
-#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) */
+#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) */
diff --git a/board/siemens/pxm2/Makefile b/board/siemens/pxm2/Makefile
index aae536472c5..ac59c5bd985 100644
--- a/board/siemens/pxm2/Makefile
+++ b/board/siemens/pxm2/Makefile
@@ -9,13 +9,13 @@
 # u-boot:/board/ti/am335x/Makefile
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
 obj-y += ../common/board_am335x.o
 obj-y += ../common/eeprom.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index 888c7c09baf..4f9611372cd 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -28,7 +28,7 @@
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void draco_init_ddr(void)
 {
 struct emif_regs pxm2_ddr3_emif_reg_data = {
@@ -154,10 +154,10 @@ int draco_read_eeprom(void)
 
 	return 0;
 }
-#endif /* if def CONFIG_SPL_BUILD */
+#endif /* if def CONFIG_XPL_BUILD */
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 static void cpsw_control(int enabled)
 {
 	/* VTP can be added here */
@@ -198,15 +198,15 @@ static struct cpsw_platform_data cpsw_data = {
 	.host_port_num		= 0,
 	.version		= CPSW_CTRL_VERSION_2,
 };
-#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) */
+#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) */
 
 #if defined(CONFIG_DRIVER_TI_CPSW) || \
 	(defined(CONFIG_USB_ETHER) && defined(CONFIG_USB_MUSB_GADGET))
 int board_eth_init(struct bd_info *bis)
 {
 	int n = 0;
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 	struct ctrl_dev *cdev = (struct ctrl_dev *)CTRL_DEVICE_BASE;
 #ifdef CONFIG_FACTORYSET
 	int rv;
diff --git a/board/siemens/rut/Makefile b/board/siemens/rut/Makefile
index aae536472c5..ac59c5bd985 100644
--- a/board/siemens/rut/Makefile
+++ b/board/siemens/rut/Makefile
@@ -9,13 +9,13 @@
 # u-boot:/board/ti/am335x/Makefile
 # Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= mux.o
 endif
 
 obj-y	+= board.o
 obj-y += ../common/board_am335x.o
 obj-y += ../common/eeprom.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index 8d316918e7a..828ae5c27a0 100644
--- a/board/siemens/rut/board.c
+++ b/board/siemens/rut/board.c
@@ -24,7 +24,7 @@
 #include "../common/eeprom.h"
 #include "../common/factoryset.h"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*
  * Read header information from EEPROM into global structure.
  */
@@ -116,7 +116,7 @@ void spl_draco_board_init(void)
 	REQUEST_AND_PULSE_RESET(MAXTOUCH_RESET_GPIO);
 	REQUEST_AND_PULSE_RESET(DISPLAY_RESET_GPIO);
 }
-#endif /* if def CONFIG_SPL_BUILD */
+#endif /* if def CONFIG_XPL_BUILD */
 
 #if defined(CONFIG_DRIVER_TI_CPSW)
 static void cpsw_control(int enabled)
@@ -168,7 +168,7 @@ int board_eth_init(struct bd_info *bis)
 	int n = 0;
 	int rv;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	factoryset_env_set();
 #endif
 
@@ -183,7 +183,7 @@ int board_eth_init(struct bd_info *bis)
 	return n;
 }
 #endif /* #if defined(CONFIG_DRIVER_TI_CPSW) */
-#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) */
+#endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) */
 
 #if defined(CONFIG_HW_WATCHDOG)
 static bool hw_watchdog_init_done;
diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
index e9e4bc348cb..6fa3ca573ae 100644
--- a/board/siemens/smartweb/smartweb.c
+++ b/board/siemens/smartweb/smartweb.c
@@ -191,7 +191,7 @@ int board_eth_init(struct bd_info *bis)
 #endif /* CONFIG_MACB */
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 #include <spi_flash.h>
diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
index 3764ab48ab3..252b0787124 100644
--- a/board/siemens/taurus/taurus.c
+++ b/board/siemens/taurus/taurus.c
@@ -79,7 +79,7 @@ static void taurus_nand_hw_init(void)
 	at91_set_gpio_output(CFG_SYS_NAND_ENABLE_PIN, 1);
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <spl.h>
 #include <nand.h>
 #include <spi_flash.h>
@@ -331,7 +331,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_BOARD_AXM)
 /*
  * Booting the Fallback Image.
diff --git a/board/sifive/unleashed/Makefile b/board/sifive/unleashed/Makefile
index 98e9111cbcc..d0a156d2cab 100644
--- a/board/sifive/unleashed/Makefile
+++ b/board/sifive/unleashed/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2019 Western Digital Corporation or its affiliates.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += unleashed.o
diff --git a/board/sifive/unmatched/Makefile b/board/sifive/unmatched/Makefile
index 13453300896..ce9deed9cdc 100644
--- a/board/sifive/unmatched/Makefile
+++ b/board/sifive/unmatched/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_ID_EEPROM) += hifive-platform-i2c-eeprom.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += unmatched.o
diff --git a/board/silinux/ek874/Makefile b/board/silinux/ek874/Makefile
index 4c8f0925f1e..6917a2418ca 100644
--- a/board/silinux/ek874/Makefile
+++ b/board/silinux/ek874/Makefile
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	:= ../../renesas/rcar-common/gen3-spl.o
 else
 obj-y	:= ek874.o ../../renesas/rcar-common/common.o
diff --git a/board/softing/vining_2000/vining_2000.c b/board/softing/vining_2000/vining_2000.c
index bd430cfaa7f..769f3e2ff2a 100644
--- a/board/softing/vining_2000/vining_2000.c
+++ b/board/softing/vining_2000/vining_2000.c
@@ -402,7 +402,7 @@ void board_preboot_os(void)
 	setbits_le32(&gpc_regs->cntr, PCIE_PHY_PUP_REQ);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
diff --git a/board/softing/vining_fpga/socfpga.c b/board/softing/vining_fpga/socfpga.c
index 2483fbcf263..ec2c7ea3631 100644
--- a/board/softing/vining_fpga/socfpga.c
+++ b/board/softing/vining_fpga/socfpga.c
@@ -43,7 +43,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int misc_init_r(void)
 {
 	uchar data[128];
diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index 3406ba8616e..e9269ef5353 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -570,7 +570,7 @@ void board_boot_order(u32 *spl_boot_list)
 	spl_boot_list[1] = BOOT_DEVICE_BOARD;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <asm/arch/mx6-ddr.h>
 static const struct mx6dq_iomux_ddr_regs mx6q_ddr_ioregs = {
 	.dram_sdclk_0 =  0x00020030,
diff --git a/board/st/common/cmd_stboard.c b/board/st/common/cmd_stboard.c
index 50da063051b..b9d0abdba7d 100644
--- a/board/st/common/cmd_stboard.c
+++ b/board/st/common/cmd_stboard.c
@@ -29,7 +29,7 @@
  *   Board: MB<Board> Var<VarCPN>.<VarFG> Rev.<Revision>-<BOM>
  */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <command.h>
 #include <console.h>
 #include <misc.h>
diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
index 6d86e4fe7aa..8966a09501e 100644
--- a/board/st/stm32f746-disco/stm32f746-disco.c
+++ b/board/st/stm32f746-disco/stm32f746-disco.c
@@ -27,7 +27,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	int rv;
 	struct udevice *dev;
 	rv = uclass_get_device(UCLASS_RAM, 0, &dev);
@@ -45,7 +45,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
 {
diff --git a/board/st/stm32mp1/Makefile b/board/st/stm32mp1/Makefile
index f2d720b67b3..5e39b7b189f 100644
--- a/board/st/stm32mp1/Makefile
+++ b/board/st/stm32mp1/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2018, STMicroelectronics - All Rights Reserved
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
 obj-y += stm32mp1.o
diff --git a/board/starfive/visionfive2/Makefile b/board/starfive/visionfive2/Makefile
index c7ba4f7ed67..97c25a2fd13 100644
--- a/board/starfive/visionfive2/Makefile
+++ b/board/starfive/visionfive2/Makefile
@@ -4,5 +4,5 @@
 #
 
 obj-y	:= starfive_visionfive2.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
 obj-$(CONFIG_ID_EEPROM) += visionfive2-i2c-eeprom.o
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 961cdcde74d..824c322a0dc 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -281,7 +281,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_NAND_SUNXI) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NAND_SUNXI) && defined(CONFIG_XPL_BUILD)
 static void nand_pinmux_setup(void)
 {
 	unsigned int pin;
@@ -530,7 +530,7 @@ int mmc_get_env_dev(void)
 #endif
 #endif /* CONFIG_MMC */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 static void sunxi_spl_store_dram_size(phys_addr_t dram_size)
 {
@@ -641,7 +641,7 @@ void sunxi_board_init(void)
 	else
 		printf("Failed to set core voltage! Can't set CPU frequency\n");
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #ifdef CONFIG_USB_GADGET
 int g_dnl_board_usb_cable_connected(void)
diff --git a/board/tcl/sl50/board.c b/board/tcl/sl50/board.c
index 6c60c70b7b4..20fa61131cb 100644
--- a/board/tcl/sl50/board.c
+++ b/board/tcl/sl50/board.c
@@ -249,8 +249,8 @@ int board_late_init(void)
 }
 #endif
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 static void cpsw_control(int enabled)
 {
 	/* VTP can be added here */
@@ -303,10 +303,10 @@ static struct cpsw_platform_data cpsw_data = {
  * when we build an SPL that has neither option but full U-Boot will.
  */
 #if ((defined(CONFIG_SPL_ETH) || defined(CONFIG_SPL_USB_ETHER)) \
-		&& defined(CONFIG_SPL_BUILD)) || \
+		&& defined(CONFIG_XPL_BUILD)) || \
 	((defined(CONFIG_DRIVER_TI_CPSW) || \
 	  defined(CONFIG_USB_ETHER) && defined(CONFIG_MUSB_GADGET)) && \
-	 !defined(CONFIG_SPL_BUILD))
+	 !defined(CONFIG_XPL_BUILD))
 int board_eth_init(struct bd_info *bis)
 {
 	int rv, n = 0;
@@ -323,8 +323,8 @@ int board_eth_init(struct bd_info *bis)
 	mac_addr[4] = mac_lo & 0xFF;
 	mac_addr[5] = (mac_lo & 0xFF00) >> 8;
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 	if (!env_get("ethaddr")) {
 		printf("<ethaddr> not set. Validating first E-fuse MAC\n");
 
@@ -373,7 +373,7 @@ int board_eth_init(struct bd_info *bis)
 
 #endif
 #if defined(CONFIG_USB_ETHER) && \
-	(!defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_USB_ETHER))
+	(!defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_USB_ETHER))
 	if (is_valid_ether_addr(mac_addr))
 		eth_env_set_enetaddr("usbnet_devaddr", mac_addr);
 
diff --git a/board/technexion/pico-imx6/spl.c b/board/technexion/pico-imx6/spl.c
index 50f51774264..700abb73289 100644
--- a/board/technexion/pico-imx6/spl.c
+++ b/board/technexion/pico-imx6/spl.c
@@ -24,7 +24,7 @@
 #include <asm/arch/sys_proto.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <asm/arch/mx6-ddr.h>
 
 #define IMX6DQ_DRIVE_STRENGTH		0x30
diff --git a/board/technexion/pico-imx6ul/spl.c b/board/technexion/pico-imx6ul/spl.c
index 67484e62dad..5b91868ba9c 100644
--- a/board/technexion/pico-imx6ul/spl.c
+++ b/board/technexion/pico-imx6ul/spl.c
@@ -18,7 +18,7 @@
 #include <linux/libfdt.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
diff --git a/board/technexion/pico-imx7d/spl.c b/board/technexion/pico-imx7d/spl.c
index 8f219f76c60..cb60d3be420 100644
--- a/board/technexion/pico-imx7d/spl.c
+++ b/board/technexion/pico-imx7d/spl.c
@@ -21,7 +21,7 @@
 #include <fsl_esdhc_imx.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 
 #ifdef CONFIG_SPL_OS_BOOT
 int spl_start_uboot(void)
diff --git a/board/technexion/pico-imx8mq/Makefile b/board/technexion/pico-imx8mq/Makefile
index 7cfe1e02ef9..da3073cdf79 100644
--- a/board/technexion/pico-imx8mq/Makefile
+++ b/board/technexion/pico-imx8mq/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += pico-imx8mq.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing_1gb.o lpddr4_timing_2gb.o lpddr4_timing_3gb.o lpddr4_timing_4gb.o
 endif
diff --git a/board/theadorable/theadorable.c b/board/theadorable/theadorable.c
index d7234532fe6..2f5ad769b9b 100644
--- a/board/theadorable/theadorable.c
+++ b/board/theadorable/theadorable.c
@@ -10,7 +10,7 @@
 #include <init.h>
 #include <net.h>
 #include <pci.h>
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 #include <bootcount.h>
 #endif
 #include <asm/global_data.h>
@@ -252,7 +252,7 @@ int board_eth_init(struct bd_info *bis)
 }
 #endif
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_BOARD_LATE_INIT)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_BOARD_LATE_INIT)
 int board_late_init(void)
 {
 	pci_dev_t bdf;
@@ -343,7 +343,7 @@ int board_late_init(void)
 }
 #endif
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_PCI)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_PCI)
 static int pcie_get_link_speed_width(pci_dev_t bdf, int *speed, int *width)
 {
 	struct udevice *dev;
diff --git a/board/theobroma-systems/jaguar_rk3588/Makefile b/board/theobroma-systems/jaguar_rk3588/Makefile
index 532aab01532..d43bf194b68 100644
--- a/board/theobroma-systems/jaguar_rk3588/Makefile
+++ b/board/theobroma-systems/jaguar_rk3588/Makefile
@@ -5,6 +5,6 @@
 #
 
 obj-y += jaguar_rk3588.o
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-y	+= ../common/common.o
 endif
diff --git a/board/theobroma-systems/puma_rk3399/Makefile b/board/theobroma-systems/puma_rk3399/Makefile
index edd61a35c1e..2256e72cda1 100644
--- a/board/theobroma-systems/puma_rk3399/Makefile
+++ b/board/theobroma-systems/puma_rk3399/Makefile
@@ -5,6 +5,6 @@
 #
 
 obj-y	+= puma-rk3399.o
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-y	+= ../common/common.o
 endif
diff --git a/board/theobroma-systems/ringneck_px30/Makefile b/board/theobroma-systems/ringneck_px30/Makefile
index 45cc65baf9a..4d108f2d011 100644
--- a/board/theobroma-systems/ringneck_px30/Makefile
+++ b/board/theobroma-systems/ringneck_px30/Makefile
@@ -5,6 +5,6 @@
 #
 
 obj-y	+= ringneck-px30.o
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-y	+= ../common/common.o
 endif
diff --git a/board/theobroma-systems/tiger_rk3588/Makefile b/board/theobroma-systems/tiger_rk3588/Makefile
index 5c4c484657a..94b0859eb35 100644
--- a/board/theobroma-systems/tiger_rk3588/Makefile
+++ b/board/theobroma-systems/tiger_rk3588/Makefile
@@ -5,6 +5,6 @@
 #
 
 obj-y += tiger_rk3588.o
-ifneq ($(CONFIG_SPL_BUILD),y)
+ifneq ($(CONFIG_XPL_BUILD),y)
 obj-y	+= ../common/common.o
 endif
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 681002ba1da..720bf2cb3e1 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -569,8 +569,8 @@ void sdram_init(void)
 }
 #endif
 
-#if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_SPL_BUILD) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD)))
+#if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_XPL_BUILD) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD)))
 static void request_and_set_gpio(int gpio, char *name, int val)
 {
 	int ret;
@@ -707,8 +707,8 @@ int board_init(void)
 	gpmc_init();
 #endif
 
-#if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_SPL_BUILD) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD)))
+#if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_XPL_BUILD) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD)))
 	if (board_is_icev2()) {
 		int rv;
 		u32 reg;
@@ -798,7 +798,7 @@ int board_init(void)
 int board_late_init(void)
 {
 	struct udevice *dev;
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	uint8_t mac_addr[6];
 	uint32_t mac_hi, mac_lo;
 #endif
@@ -847,7 +847,7 @@ int board_late_init(void)
 		env_set("boot_fit", "1");
 #endif
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	/* try reading mac address from efuse */
 	mac_lo = readl(&cdev->macid0l);
 	mac_hi = readl(&cdev->macid0h);
diff --git a/board/ti/am57xx/board.c b/board/ti/am57xx/board.c
index cc5e64c9879..fc0d87daae4 100644
--- a/board/ti/am57xx/board.c
+++ b/board/ti/am57xx/board.c
@@ -515,7 +515,7 @@ int get_voltrail_opp(int rail_offset)
 	return opp;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* No env to setup for SPL */
 static inline void setup_board_eeprom_env(void) { }
 
@@ -538,7 +538,7 @@ void do_board_detect(void)
 #endif
 }
 
-#else	/* CONFIG_SPL_BUILD */
+#else	/* CONFIG_XPL_BUILD */
 
 /* Override function to read eeprom information: actual i2c read done by SPL*/
 void do_board_detect(void)
@@ -616,7 +616,7 @@ invalid_eeprom:
 	set_board_info_env(name);
 }
 
-#endif	/* CONFIG_SPL_BUILD */
+#endif	/* CONFIG_XPL_BUILD */
 
 void vcores_init(void)
 {
@@ -783,7 +783,7 @@ int board_late_init(void)
 	if (board_is_bbai())
 		env_set("console", "ttyS0,115200n8");
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	board_ti_set_ethaddr(2);
 #endif
 
@@ -935,7 +935,7 @@ const struct mmc_platform_fixups *platform_fixups_mmc(uint32_t addr)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_OS_BOOT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_OS_BOOT)
 int spl_start_uboot(void)
 {
 	/* break into full u-boot on 'c' */
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 9bdd0223cdb..1166c9b8e09 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -103,7 +103,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 
 void spl_board_init(void)
 {
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 609e5cf6d51..00b8317d6bf 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -105,7 +105,7 @@ int board_fit_config_name_match(const char *name)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #if CONFIG_IS_ENABLED(USB_STORAGE)
 static int fixup_usb_boot(const void *fdt_blob)
 {
diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index ea21d48bbc0..a43cc075b92 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -304,7 +304,7 @@ int __maybe_unused ti_i2c_eeprom_am_get(int bus_addr, int dev_addr)
 	struct ti_common_eeprom *ep;
 
 	ep = TI_EEPROM_DATA;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (ep->header == TI_EEPROM_HEADER_MAGIC)
 		return 0; /* EEPROM has already been read */
 #endif
@@ -350,7 +350,7 @@ int __maybe_unused ti_i2c_eeprom_dra7_get(int bus_addr, int dev_addr)
 	struct ti_common_eeprom *ep;
 
 	ep = TI_EEPROM_DATA;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (ep->header == DRA7_EEPROM_HEADER_MAGIC)
 		return 0; /* EEPROM has already been read */
 #endif
@@ -563,7 +563,7 @@ int __maybe_unused ti_i2c_eeprom_am6_get_base(int bus_addr, int dev_addr)
 	 * Always execute EEPROM read by not allowing to bypass it during the
 	 * first invocation of SPL which happens on the R5 core.
 	 */
-#if !(defined(CONFIG_SPL_BUILD) && defined(CONFIG_CPU_V7R))
+#if !(defined(CONFIG_XPL_BUILD) && defined(CONFIG_CPU_V7R))
 	if (ep->header == TI_EEPROM_HEADER_MAGIC) {
 		debug("%s: EEPROM has already been read\n", __func__);
 		return 0;
diff --git a/board/ti/dra7xx/evm.c b/board/ti/dra7xx/evm.c
index 2b1db2541b0..98d63e14e29 100644
--- a/board/ti/dra7xx/evm.c
+++ b/board/ti/dra7xx/evm.c
@@ -713,7 +713,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void do_board_detect(void)
 {
 	int rc;
@@ -756,7 +756,7 @@ void do_board_detect(void)
 		snprintf(sysinfo.board_string, SYSINFO_BOARD_NAME_MAX_LEN,
 			 "Board: %s REV %s\n", bname, board_ti_get_rev());
 }
-#endif	/* CONFIG_SPL_BUILD */
+#endif	/* CONFIG_XPL_BUILD */
 
 void vcores_init(void)
 {
@@ -972,7 +972,7 @@ const struct mmc_platform_fixups *platform_fixups_mmc(uint32_t addr)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_OS_BOOT)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_OS_BOOT)
 int spl_start_uboot(void)
 {
 	/* break into full u-boot on 'c' */
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index f3452ff0a8f..6221be9dcff 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -164,7 +164,7 @@ static void __maybe_unused detect_enable_hyperflash(void *blob)
 }
 #endif
 
-#if defined(CONFIG_SPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
+#if defined(CONFIG_XPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
 					defined(CONFIG_TARGET_J721E_A72_EVM) || defined(CONFIG_TARGET_J721E_R5_EVM))
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
@@ -340,7 +340,7 @@ static int probe_daughtercards(void)
 		printf("Detected: %s rev %s\n", ep.name, ep.version);
 		daughter_card_detect_flags[i] = true;
 
-		if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 			int j;
 			/*
 			 * Populate any MAC addresses from daughtercard into the U-Boot
@@ -359,7 +359,7 @@ static int probe_daughtercards(void)
 		}
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		char name_overlays[1024] = { 0 };
 
 		for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 5a0281d6b48..2cfeb3bec6c 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -239,7 +239,7 @@ static int probe_daughtercards(void)
 		printf("Detected: %s rev %s\n", ep.name, ep.version);
 		daughter_card_detect_flags[i] = true;
 
-		if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 			int j;
 			/*
 			 * Populate any MAC addresses from daughtercard into the U-Boot
@@ -257,7 +257,7 @@ static int probe_daughtercards(void)
 		}
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		char name_overlays[1024] = { 0 };
 
 		for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
diff --git a/board/ti/ks2_evm/board.c b/board/ti/ks2_evm/board.c
index c6735d37dda..48547719012 100644
--- a/board/ti/ks2_evm/board.c
+++ b/board/ti/ks2_evm/board.c
@@ -75,7 +75,7 @@ int board_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 	spl_init_keystone_plls();
diff --git a/board/ti/ks2_evm/board_k2e.c b/board/ti/ks2_evm/board_k2e.c
index 4385be4221b..3ccf70c5ac7 100644
--- a/board/ti/ks2_evm/board_k2e.c
+++ b/board/ti/ks2_evm/board_k2e.c
@@ -109,7 +109,7 @@ int board_early_init_f(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_init_keystone_plls(void)
 {
 	init_plls();
diff --git a/board/ti/ks2_evm/board_k2g.c b/board/ti/ks2_evm/board_k2g.c
index d07b77d23e2..b1142ed5e96 100644
--- a/board/ti/ks2_evm/board_k2g.c
+++ b/board/ti/ks2_evm/board_k2g.c
@@ -346,7 +346,7 @@ int embedded_dtb_select(void)
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
 {
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_TI_I2C_BOARD_DETECT)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_TI_I2C_BOARD_DETECT)
 	int rc;
 
 	rc = ti_i2c_eeprom_am_get(CONFIG_EEPROM_BUS_ADDRESS,
@@ -382,7 +382,7 @@ int board_early_init_f(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_init_keystone_plls(void)
 {
 	init_plls();
diff --git a/board/ti/ks2_evm/board_k2hk.c b/board/ti/ks2_evm/board_k2hk.c
index 2b5d2d75664..93249fa5f49 100644
--- a/board/ti/ks2_evm/board_k2hk.c
+++ b/board/ti/ks2_evm/board_k2hk.c
@@ -116,7 +116,7 @@ int board_fit_config_name_match(const char *name)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_init_keystone_plls(void)
 {
 	init_plls();
diff --git a/board/ti/ks2_evm/board_k2l.c b/board/ti/ks2_evm/board_k2l.c
index 1971bc94f7d..b813f21b682 100644
--- a/board/ti/ks2_evm/board_k2l.c
+++ b/board/ti/ks2_evm/board_k2l.c
@@ -104,7 +104,7 @@ int board_fit_config_name_match(const char *name)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 void spl_init_keystone_plls(void)
 {
 	init_plls();
diff --git a/board/ti/omap3evm/evm.c b/board/ti/omap3evm/evm.c
index 4eb08add256..8803643b032 100644
--- a/board/ti/omap3evm/evm.c
+++ b/board/ti/omap3evm/evm.c
@@ -117,7 +117,7 @@ int spl_start_uboot(void)
 }
 #endif /* CONFIG_SPL_OS_BOOT */
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 /*
  * Routine: get_board_mem_timings
  * Description: If we use SPL then there is no x-loader nor config header
@@ -150,7 +150,7 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
 	timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_165MHz;
 	timings->mr = MICRON_V_MR_165;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /*
  * Routine: misc_init_r
diff --git a/board/timll/devkit8000/devkit8000.c b/board/timll/devkit8000/devkit8000.c
index ad404f7e9c4..a2a3a9489aa 100644
--- a/board/timll/devkit8000/devkit8000.c
+++ b/board/timll/devkit8000/devkit8000.c
@@ -147,7 +147,7 @@ void board_mmc_power_init(void)
 }
 #endif
 
-#if defined(CONFIG_DRIVER_DM9000) & !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DRIVER_DM9000) & !defined(CONFIG_XPL_BUILD)
 /*
  * Routine: board_eth_init
  * Description: Setting up the Ethernet hardware.
diff --git a/board/topic/zynq/Makefile b/board/topic/zynq/Makefile
index cc100b0f422..23a6dd86441 100644
--- a/board/topic/zynq/Makefile
+++ b/board/topic/zynq/Makefile
@@ -6,4 +6,4 @@ obj-y	+= ../../xilinx/common/board.o
 # Remove quotes
 hw-platform-y :=$(shell echo $(CONFIG_DEFAULT_DEVICE_TREE))
 
-obj-$(CONFIG_SPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
+obj-$(CONFIG_XPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index 4a1cfb89345..ec0f223c4aa 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -96,7 +96,7 @@ iomux_v3_cfg_t const uart1_pads_dte[] = {
 	MX6_PAD_CSI0_DAT11__UART1_TX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
-#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_XPL_BUILD)
 /* Apalis MMC1 */
 iomux_v3_cfg_t const usdhc1_pads[] = {
 	MX6_PAD_SD1_CLK__SD1_CLK   | MUX_PAD_CTRL(USDHC_PAD_CTRL),
@@ -139,7 +139,7 @@ iomux_v3_cfg_t const usdhc3_pads[] = {
 	MX6_PAD_SD3_DAT7__SD3_DATA7 | MUX_PAD_CTRL(USDHC_EMMC_PAD_CTRL),
 	MX6_PAD_SD3_RST__GPIO7_IO08 | MUX_PAD_CTRL(WEAK_PULLUP) | MUX_MODE_SION,
 };
-#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_SPL_BUILD */
+#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_XPL_BUILD */
 
 int mx6_rgmii_rework(struct phy_device *phydev)
 {
@@ -321,7 +321,7 @@ int board_ehci_hcd_init(int port)
 }
 #endif
 
-#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_XPL_BUILD)
 /* use the following sequence: eMMC, MMC1, SD1 */
 struct fsl_esdhc_cfg usdhc_cfg[CFG_SYS_FSL_USDHC_NUM] = {
 	{USDHC3_BASE_ADDR},
@@ -391,7 +391,7 @@ int board_mmc_init(struct bd_info *bis)
 
 	return fsl_esdhc_initialize(bis, &usdhc_cfg[0]);
 }
-#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_SPL_BUILD */
+#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_XPL_BUILD */
 
 int board_phy_config(struct phy_device *phydev)
 {
@@ -748,7 +748,7 @@ void ldo_mode_set(int ldo_bypass)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
 #include "asm/arch/mx6q-ddr.h"
@@ -1042,7 +1042,7 @@ void reset_cpu(void)
 {
 }
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static struct mxc_serial_plat mxc_serial_plat = {
 	.reg = (struct mxc_uart *)UART1_BASE,
diff --git a/board/toradex/apalis_imx6/do_fuse.c b/board/toradex/apalis_imx6/do_fuse.c
index b404b01e032..698b05bc5ad 100644
--- a/board/toradex/apalis_imx6/do_fuse.c
+++ b/board/toradex/apalis_imx6/do_fuse.c
@@ -7,7 +7,7 @@
  * Helpers for i.MX OTP fusing during module production
 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <command.h>
 #include <console.h>
 #include <fuse.h>
@@ -94,4 +94,4 @@ U_BOOT_CMD(
 	"OTP fusing during module update",
 	"updt_fuse [-n] [-y] - boot cfg fast boot mode fusing"
 );
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/toradex/apalis_imx6/pf0100.c b/board/toradex/apalis_imx6/pf0100.c
index 157aaec6fe0..7ea9bbb07ed 100644
--- a/board/toradex/apalis_imx6/pf0100.c
+++ b/board/toradex/apalis_imx6/pf0100.c
@@ -212,7 +212,7 @@ unsigned pmic_init(void)
 	return programmed;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int pf0100_prog(void)
 {
 	int rc;
@@ -280,4 +280,4 @@ U_BOOT_CMD(
 	"Program the OTP fuses on the PMIC PF0100",
 	""
 );
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/toradex/apalis_t30/Makefile b/board/toradex/apalis_t30/Makefile
index eed607043fc..2d079004c4b 100644
--- a/board/toradex/apalis_t30/Makefile
+++ b/board/toradex/apalis_t30/Makefile
@@ -1,6 +1,6 @@
 # Copyright (c) 2014 Marcel Ziswiler
 # SPDX-License-Identifier:      GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD) += apalis_t30-spl.o
+obj-$(CONFIG_XPL_BUILD) += apalis_t30-spl.o
 
 obj-y	+= apalis_t30.o
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index 251970b99cc..64cf99e9cfc 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -86,7 +86,7 @@ iomux_v3_cfg_t const uart1_pads[] = {
 	MX6_PAD_CSI0_DAT11__UART1_TX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
-#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_XPL_BUILD)
 /* Colibri MMC */
 iomux_v3_cfg_t const usdhc1_pads[] = {
 	MX6_PAD_SD1_CLK__SD1_CLK    | MUX_PAD_CTRL(USDHC_PAD_CTRL),
@@ -113,7 +113,7 @@ iomux_v3_cfg_t const usdhc3_pads[] = {
 	MX6_PAD_SD3_DAT7__SD3_DATA7 | MUX_PAD_CTRL(USDHC_EMMC_PAD_CTRL),
 	MX6_PAD_SD3_RST__SD3_RESET  | MUX_PAD_CTRL(USDHC_PAD_CTRL),
 };
-#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_SPL_BUILD */
+#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_XPL_BUILD */
 
 /* mux auxiliary pins to GPIO, so they can be used from the U-Boot cmdline */
 iomux_v3_cfg_t const gpio_pads[] = {
@@ -289,7 +289,7 @@ int board_ehci_hcd_init(int port)
 }
 #endif
 
-#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_FSL_ESDHC_IMX) && defined(CONFIG_XPL_BUILD)
 /* use the following sequence: eMMC, MMC */
 struct fsl_esdhc_cfg usdhc_cfg[CFG_SYS_FSL_USDHC_NUM] = {
 	{USDHC3_BASE_ADDR},
@@ -346,7 +346,7 @@ int board_mmc_init(struct bd_info *bis)
 
 	return fsl_esdhc_initialize(bis, &usdhc_cfg[0]);
 }
-#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_SPL_BUILD */
+#endif /* CONFIG_FSL_ESDHC_IMX & CONFIG_XPL_BUILD */
 
 int board_phy_config(struct phy_device *phydev)
 {
@@ -677,7 +677,7 @@ void ldo_mode_set(int ldo_bypass)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
 #include "asm/arch/mx6dl-ddr.h"
@@ -1101,7 +1101,7 @@ void reset_cpu(void)
 {
 }
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static struct mxc_serial_plat mxc_serial_plat = {
 	.reg = (struct mxc_uart *)UART1_BASE,
diff --git a/board/toradex/colibri_imx6/do_fuse.c b/board/toradex/colibri_imx6/do_fuse.c
index b404b01e032..698b05bc5ad 100644
--- a/board/toradex/colibri_imx6/do_fuse.c
+++ b/board/toradex/colibri_imx6/do_fuse.c
@@ -7,7 +7,7 @@
  * Helpers for i.MX OTP fusing during module production
 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <command.h>
 #include <console.h>
 #include <fuse.h>
@@ -94,4 +94,4 @@ U_BOOT_CMD(
 	"OTP fusing during module update",
 	"updt_fuse [-n] [-y] - boot cfg fast boot mode fusing"
 );
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/toradex/colibri_imx6/pf0100.c b/board/toradex/colibri_imx6/pf0100.c
index 58b7bc3bb9a..b5dffc87b35 100644
--- a/board/toradex/colibri_imx6/pf0100.c
+++ b/board/toradex/colibri_imx6/pf0100.c
@@ -197,7 +197,7 @@ unsigned pmic_init(void)
 	return programmed;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int pf0100_prog(void)
 {
 	int rc;
@@ -265,4 +265,4 @@ U_BOOT_CMD(
 	"Program the OTP fuses on the PMIC PF0100",
 	""
 );
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/toradex/colibri_t30/Makefile b/board/toradex/colibri_t30/Makefile
index 8f333235b17..1cc801c8cfd 100644
--- a/board/toradex/colibri_t30/Makefile
+++ b/board/toradex/colibri_t30/Makefile
@@ -1,6 +1,6 @@
 # Copyright (c) 2013-2014 Stefan Agner
 # SPDX-License-Identifier:      GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD) += colibri_t30-spl.o
+obj-$(CONFIG_XPL_BUILD) += colibri_t30-spl.o
 
 obj-y	+= colibri_t30.o
diff --git a/board/toradex/common/Makefile b/board/toradex/common/Makefile
index 7b19b6e4c87..7e3905445a5 100644
--- a/board/toradex/common/Makefile
+++ b/board/toradex/common/Makefile
@@ -2,7 +2,7 @@
 # Copyright (c) 2016 Toradex, Inc.
 
 # Common for all Toradex modules
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 # Necessary to create built-in.o
 obj- := __dummy__.o
 else
diff --git a/board/toradex/verdin-imx8mm/Makefile b/board/toradex/verdin-imx8mm/Makefile
index b38054254da..eee58aa2f83 100644
--- a/board/toradex/verdin-imx8mm/Makefile
+++ b/board/toradex/verdin-imx8mm/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += verdin-imx8mm.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/toradex/verdin-imx8mp/Makefile b/board/toradex/verdin-imx8mp/Makefile
index 98fa14e4e2a..5edd1778816 100644
--- a/board/toradex/verdin-imx8mp/Makefile
+++ b/board/toradex/verdin-imx8mp/Makefile
@@ -5,7 +5,7 @@
 
 obj-y += verdin-imx8mp.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
 endif
diff --git a/board/udoo/neo/neo.c b/board/udoo/neo/neo.c
index 4cf214bf17c..bc30bdac462 100644
--- a/board/udoo/neo/neo.c
+++ b/board/udoo/neo/neo.c
@@ -209,7 +209,7 @@ int board_late_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 #include <linux/libfdt.h>
 #include <asm/arch/mx6-ddr.h>
diff --git a/board/udoo/udoo_spl.c b/board/udoo/udoo_spl.c
index 6c477530055..b845284d688 100644
--- a/board/udoo/udoo_spl.c
+++ b/board/udoo/udoo_spl.c
@@ -23,7 +23,7 @@
 #include <asm/arch/sys_proto.h>
 #include <spl.h>
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #include <asm/arch/mx6-ddr.h>
 
 /*
diff --git a/board/variscite/common/imx9_eeprom.c b/board/variscite/common/imx9_eeprom.c
index 32551af5b40..bfa30adc256 100644
--- a/board/variscite/common/imx9_eeprom.c
+++ b/board/variscite/common/imx9_eeprom.c
@@ -83,7 +83,7 @@ int var_eeprom_get_dram_size(struct var_eeprom *ep, phys_size_t *size)
 
 void var_eeprom_print_prod_info(struct var_eeprom *ep)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return;
 
 	flush_dcache_all();
diff --git a/board/variscite/dart_6ul/Makefile b/board/variscite/dart_6ul/Makefile
index 48aa361bf2d..39c3f53e736 100644
--- a/board/variscite/dart_6ul/Makefile
+++ b/board/variscite/dart_6ul/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
 obj-y  := dart_6ul.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/variscite/imx8mn_var_som/Makefile b/board/variscite/imx8mn_var_som/Makefile
index a8b6a343ffc..36d9c36dd2d 100644
--- a/board/variscite/imx8mn_var_som/Makefile
+++ b/board/variscite/imx8mn_var_som/Makefile
@@ -6,7 +6,7 @@
 
 obj-y += imx8mn_var_som.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-y += ddr4_timing.o
 endif
diff --git a/board/variscite/imx8mn_var_som/imx8mn_var_som.c b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
index 532d8d60a76..80c84e64241 100644
--- a/board/variscite/imx8mn_var_som/imx8mn_var_som.c
+++ b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
@@ -54,7 +54,7 @@ int board_mmc_get_env_dev(int devno)
 	return devno;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 
 #if defined(CONFIG_DISPLAY_BOARDINFO)
 
@@ -227,4 +227,4 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 }
 #endif /* CONFIG_OF_BOARD_SETUP */
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/board/variscite/imx93_var_som/Makefile b/board/variscite/imx93_var_som/Makefile
index b63883901bd..8b160f189c1 100644
--- a/board/variscite/imx93_var_som/Makefile
+++ b/board/variscite/imx93_var_som/Makefile
@@ -8,7 +8,7 @@
 obj-y += imx93_var_som.o
 obj-$(CONFIG_TARGET_IMX93_VAR_SOM) += ../common/imx9_eeprom.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-$(CONFIG_TARGET_IMX93_VAR_SOM) += lpddr4x_timing.o
 else
diff --git a/board/vscom/baltos/board.c b/board/vscom/baltos/board.c
index f54f183038b..de9f8367d59 100644
--- a/board/vscom/baltos/board.c
+++ b/board/vscom/baltos/board.c
@@ -131,7 +131,7 @@ static int read_eeprom(BSP_VS_HWPARAM *header)
 	return 0;
 }
 
-#if defined(CONFIG_SPL_BUILD) || defined(CONFIG_NOR_BOOT)
+#if defined(CONFIG_XPL_BUILD) || defined(CONFIG_NOR_BOOT)
 
 static const struct ddr_data ddr3_baltos_data = {
 	.datardsratio0 = MT41K256M16HA125E_RD_DQS,
@@ -371,8 +371,8 @@ int board_late_init(void)
 }
 #endif
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 static void cpsw_control(int enabled)
 {
 	/* VTP can be added here */
@@ -415,10 +415,10 @@ static struct cpsw_platform_data cpsw_data = {
 #endif
 
 #if ((defined(CONFIG_SPL_ETH) || defined(CONFIG_SPL_USB_ETHER)) \
-		&& defined(CONFIG_SPL_BUILD)) || \
+		&& defined(CONFIG_XPL_BUILD)) || \
 	((defined(CONFIG_DRIVER_TI_CPSW) || \
 	  defined(CONFIG_USB_ETHER) && defined(CONFIG_USB_MUSB_GADGET)) && \
-	 !defined(CONFIG_SPL_BUILD))
+	 !defined(CONFIG_XPL_BUILD))
 int board_eth_init(struct bd_info *bis)
 {
 	int rv, n = 0;
@@ -442,8 +442,8 @@ int board_eth_init(struct bd_info *bis)
 	mac_addr[4] = mac_lo & 0xFF;
 	mac_addr[5] = (mac_lo & 0xFF00) >> 8;
 
-#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
+#if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD))
 	if (!env_get("ethaddr")) {
 		printf("<ethaddr> not set. Validating first E-fuse MAC\n");
 
diff --git a/board/wandboard/Makefile b/board/wandboard/Makefile
index c3d80536b3a..6e5bcc11630 100644
--- a/board/wandboard/Makefile
+++ b/board/wandboard/Makefile
@@ -3,4 +3,4 @@
 # (C) Copyright 2013 Freescale Semiconductor, Inc.
 
 obj-y  := wandboard.o
-obj-$(CONFIG_SPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/wexler/qc750/Makefile b/board/wexler/qc750/Makefile
index 4daefc4159a..5f9ebafd89c 100644
--- a/board/wexler/qc750/Makefile
+++ b/board/wexler/qc750/Makefile
@@ -6,6 +6,6 @@
 #  (C) Copyright 2023
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
-obj-$(CONFIG_SPL_BUILD) += qc750-spl.o
+obj-$(CONFIG_XPL_BUILD) += qc750-spl.o
 
 obj-y += qc750.o
diff --git a/board/work-microwave/work_92105/Makefile b/board/work-microwave/work_92105/Makefile
index b837e7b0dd8..a96098d0f2a 100644
--- a/board/work-microwave/work_92105/Makefile
+++ b/board/work-microwave/work_92105/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2014  DENX Software Engineering GmbH
 # Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-y	+= work_92105_spl.o
 else
 obj-y	+= work_92105.o
diff --git a/board/xilinx/common/Makefile b/board/xilinx/common/Makefile
index d563290ab90..4b8fdec5830 100644
--- a/board/xilinx/common/Makefile
+++ b/board/xilinx/common/Makefile
@@ -8,6 +8,6 @@ obj-y	+= board.o
 ifndef CONFIG_ARCH_ZYNQ
 obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
 endif
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_FRU) += fru.o fru_ops.o
 endif
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 5e5eb49ddf3..68f401e4b34 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -370,7 +370,7 @@ void *board_fdt_blob_setup(int *err)
 			return fdt_blob;
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) &&
 	    !IS_ENABLED(CONFIG_VERSAL_NO_DDR) &&
 	    !IS_ENABLED(CONFIG_ZYNQMP_NO_DDR)) {
 		fdt_blob = (void *)CONFIG_XILINX_OF_BOARD_DTB_ADDR;
@@ -381,7 +381,7 @@ void *board_fdt_blob_setup(int *err)
 		debug("DTB is not passed via %p\n", fdt_blob);
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		/*
 		 * FDT is at end of BSS unless it is in a different memory
 		 * region
@@ -515,7 +515,7 @@ int __maybe_unused board_fit_config_name_match(const char *name)
 {
 	debug("%s: Check %s, default %s\n", __func__, name, board_name);
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	if (IS_ENABLED(CONFIG_REGEX)) {
 		struct slre slre;
 		int ret;
diff --git a/board/xilinx/microblaze-generic/microblaze-generic.c b/board/xilinx/microblaze-generic/microblaze-generic.c
index 2b035d53589..dc4523824b4 100644
--- a/board/xilinx/microblaze-generic/microblaze-generic.c
+++ b/board/xilinx/microblaze-generic/microblaze-generic.c
@@ -40,7 +40,7 @@ int board_late_init(void)
 	ulong max_size;
 	u32 status = 0;
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SYSRESET_MICROBLAZE)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SYSRESET_MICROBLAZE)
 	int ret;
 
 	ret = device_bind_driver(gd->dm_root, "mb_soft_reset",
diff --git a/board/xilinx/zynq/Makefile b/board/xilinx/zynq/Makefile
index 85661715891..f40fe382f57 100644
--- a/board/xilinx/zynq/Makefile
+++ b/board/xilinx/zynq/Makefile
@@ -26,17 +26,17 @@ endif
 ifeq ($(init-objs),)
 ifneq ($(wildcard $(srctree)/$(src)/ps7_init_gpl.c),)
 init-objs := ps7_init_gpl.o
-$(if $(CONFIG_SPL_BUILD),\
+$(if $(CONFIG_XPL_BUILD),\
 $(warning Put custom ps7_init_gpl.c/h to board/xilinx/zynq/custom_hw_platform/))
 endif
 endif
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_ZYNQ) += cmds.o
 obj-$(CONFIG_CMD_ZYNQ_RSA) += bootimg.o
 endif
 
-obj-$(CONFIG_SPL_BUILD) += $(init-objs)
+obj-$(CONFIG_XPL_BUILD) += $(init-objs)
 
 # Suppress "warning: function declaration isn't a prototype"
 CFLAGS_REMOVE_ps7_init_gpl.o := -Wstrict-prototypes
diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index b9a91110ff7..a852d5b8ed5 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -27,7 +27,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_DEBUG_UART_BOARD_INIT)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_DEBUG_UART_BOARD_INIT)
 void board_debug_uart_init(void)
 {
 	/* Add initialization sequence if UART is not configured */
@@ -36,7 +36,7 @@ void board_debug_uart_init(void)
 
 int board_init(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		printf("Silicon version:\t%d\n", zynq_get_silicon_version());
 
 	if (CONFIG_IS_ENABLED(DM_I2C) && CONFIG_IS_ENABLED(I2C_EEPROM))
diff --git a/board/xilinx/zynqmp/Makefile b/board/xilinx/zynqmp/Makefile
index 9ab50eca400..544346d686e 100644
--- a/board/xilinx/zynqmp/Makefile
+++ b/board/xilinx/zynqmp/Makefile
@@ -26,16 +26,16 @@ endif
 ifeq ($(init-objs),)
 ifneq ($(wildcard $(srctree)/$(src)/psu_init_gpl.c),)
 init-objs := psu_init_gpl.o
-$(if $(CONFIG_SPL_BUILD),\
+$(if $(CONFIG_XPL_BUILD),\
 $(warning Put custom psu_init_gpl.c/h to board/xilinx/zynqmp/custom_hw_platform/))
 endif
 endif
 
 obj-$(CONFIG_$(SPL_)ZYNQMP_PSU_INIT_ENABLED) += $(init-objs)
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifneq ($(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE),"")
-obj-$(CONFIG_SPL_BUILD) += pm_cfg_obj.o
+obj-$(CONFIG_XPL_BUILD) += pm_cfg_obj.o
 $(obj)/pm_cfg_obj.o: $(shell cd $(srctree); readlink -f $(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE)) FORCE
 endif
 endif
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 20a675c010d..8cdd9d86009 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -86,7 +86,7 @@ int __maybe_unused psu_uboot_init(void)
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 # if defined(CONFIG_DEBUG_UART_BOARD_INIT)
 void board_debug_uart_init(void)
 {
@@ -120,7 +120,7 @@ static int multi_boot(void)
 	return multiboot;
 }
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static void restore_jtag(void)
 {
 	if (current_el() != 3)
@@ -155,7 +155,7 @@ int board_init(void)
 	int ret;
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	/* Check *at build time* if the filename is an non-empty string */
 	if (sizeof(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE) > 1)
 		zynqmp_pmufw_load_config_object(zynqmp_pm_cfg_obj,
-- 
2.34.1

