Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A2DC46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 201E68773E;
	Fri, 22 Dec 2023 06:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jGbro6jN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0099487650; Fri, 22 Dec 2023 06:46:36 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C0487788
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d3d0faf262so12532605ad.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703223990; x=1703828790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BWecYUpkzCMYtYwL+8RYXnL7j/+Draf3Dw2PJsI4wE0=;
 b=jGbro6jNa396dT76mltoQfYruilqA+43Pc8l1RHLFveAh5PzUI9FM/S6iUsGLdQMri
 SPuflfu01x9My87lPWq5gRleCI6BnOIXUMxqZYCTHJ9Y2O1gd9wxFI4TSALvR6vzNDNv
 3jRcb5GR7t5om9uySccOT9lnAKoDfvg7aIQ5CvBaoNqz98+M2QntXmQXdf2XHGgdLfTu
 RPrjrj5j2AjxTWRBzDQkdpPRE5aT8dgDhkAKIlzGhcLigkbmqlzqNWQrlxiIhol+x9mA
 5Y//dp6NzBiV2tbpoTMORPzQ1HsyP2mIB1w/HW5YpHSuG9xMcd21GUWsb2J+R0RXGfuk
 Y6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703223990; x=1703828790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BWecYUpkzCMYtYwL+8RYXnL7j/+Draf3Dw2PJsI4wE0=;
 b=D+Pp1xg5wZGgaVTd8VQzDQYTHxppyqON16iSNuvJL4O4gY5IDCi5lKY90bmABO7BPR
 2T6DRGSbGHHYQcduw/3jj2XewBbfnfaJA4SqSFlaJOuLT7+x1VTSkbuxPJ3wsFzjWblF
 D3Ri4I2FUyaPE+qA7ate+QslypiyBuk7Bpj7Mfl85VWt/DpH5k8keiX7xtDzYkdmUT1U
 u+z/ETxlhwSFBSpjjDdGW8bWi+/XU+0Ny/+CQzqYmnlAA+0SxFSfsI/x0YoHtohjVQHF
 99Q3YIuMouf7lnaRNBe9/A9ehHLPnJUasmLORSChB+tF04R8PIL+7eAlRtv6WDe5alOB
 x3dg==
X-Gm-Message-State: AOJu0YyyA22AIV6qYILjJ3CPgzetDevNFxjdiYIcXnjERh9gbDYq2kyH
 c/GhIdXjEPxE06pf51vNCbLfht5Spsw=
X-Google-Smtp-Source: AGHT+IFDujHrwAfXPDJ0M6qQ6OP7TmuNe0xpFQxy4TBYOj3gnUZUonjh3XUauDLmolLm+lKq0H/4ag==
X-Received: by 2002:a17:902:f689:b0:1d0:7965:f530 with SMTP id
 l9-20020a170902f68900b001d07965f530mr940587plg.88.1703223990590; 
 Thu, 21 Dec 2023 21:46:30 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:46:30 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 0/9] mtd: spi-nor: Add support for Infineon S28HS02GT
Date: Fri, 22 Dec 2023 14:45:57 +0900
Message-Id: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Infineon S28HS02GT is 1.8V, 2Gb (256MB) NOR Flash memory with Octal
interface. It is a dual-die package parts and has same features with
existing S28 series.

The goal of this series of patches is to add S28HS02GT support. Before
adding device ID to the table, some reworks are done to simplify the
support structure for all other S25Hx-T and S28Hx-T families.

Tested newly added S28HS02GT and other S25Hx-T and S28Hx-T devices on
Zynq-7000 platform with Infineon SPI controller.

Only summary datasheet is available on web.
https://www.infineon.com/dgdl/Infineon-S28HS02GT_S28HS04GT_S28HL02GT_S28HL04GT_2Gb_4Gb_SEMPER_Flash_Octal_interface_1.8V_3.0V-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7e7124d1017f0631e33714d9

Please send an email to me for full version of the datasheet.

Changes in v2:
  - Rebased


Takahiro Kuwano (9):
  mtd: spi-nor-core: Clean up macros for Infineon(Cypress) S25 and S28
  mtd: spi-nor-core: Consolidate non-uniform erase helpers for S25 and
    S28
  mtd: spi-nor-core: Rework spansion_read_any_reg() to support Octal DTR
    mode
  mtd: spi-nor-core: Use CLPEF(0x82) as alternative to CLSR(0x30) for
    S25 and S28
  mtd: spi-nor-core: Rework s25_mdp_ready() to support Octal DTR mode
  mtd: spi-nor-core: Consolidate setup() hook for Infineon(Cypress) S25
    and S28
  mtd: spi-nor-core: Consolidate post_bfpt_fixup() for Infineon(Cypress)
    S25 and S28
  mtd: spi-nor-core: Rework spi_nor_cypress_octal_dtr_enable()
  mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt ID

 drivers/mtd/spi/spi-nor-core.c | 224 +++++++++++++--------------------
 drivers/mtd/spi/spi-nor-ids.c  |   1 +
 include/linux/mtd/spi-nor.h    |  14 +--
 3 files changed, 91 insertions(+), 148 deletions(-)

-- 
2.34.1

