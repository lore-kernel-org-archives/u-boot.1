Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B78C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 22:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D65877B6;
	Mon, 11 Dec 2023 23:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NJ3jWBwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6265877B6; Mon, 11 Dec 2023 23:06:52 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB73877B3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 23:06:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50bfa7f7093so6435689e87.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 14:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702332410; x=1702937210;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jgjor0CBTHy7XzOQ/Y6y7ZxJzmr44UtwtBmoDoQEgaY=;
 b=NJ3jWBwezt1QX0tvQTmx6Qx3CeuBWYEKpoMespGuZOqNHVZKRWx2w6EUnzdR6ZMJQz
 X2rvuTf5ffxZC+x2Bobye8AGdJoCyJDBi904dp/zoEzat5Gr9NEGTBHlxBJHuMSRHvsv
 V1R/Ds2JqRlaoQxPo9bcIbDWMGi+H5wo3gBlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702332410; x=1702937210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jgjor0CBTHy7XzOQ/Y6y7ZxJzmr44UtwtBmoDoQEgaY=;
 b=gmmRprDy9ftcVFlL2CU/IWdkFMA3+AobiENQbTAkDXzj6BpxmHjao7EhwgHvw3vBEs
 /bBb5IK5qHzTp76Q0hHOQhajM1YtiXcdSljjSqPf2tpzfztQQE7bGKoZ8Jln1eOLBbuJ
 sBo/Wf+O1QaLOydEiPKqI+H++My5s8cOCcx0idhtJhXYgs8XZYAAHTmMEv441lshCTM3
 gXrhqirUMkN+TUUglWO5+x7B/I6SgKq5VvyLztzY+labdx/F3sSqCXjsqh4mBdsLDjFa
 bkpWVmGuZKVUNBQSTWWzrRkMy6T9xIhN/dkbhBhxdEOlIicNRwOCpJhcUobIUlHSr1yg
 /CgA==
X-Gm-Message-State: AOJu0YyTCmQKKhskCVpfTs8EhuMdCWQs8kggcNewPjvHAgRlWOJZGr0X
 0+Ri+KIAvoIZwtirLm0rXRw7Gn1hZBnfyJ09+9hqUg==
X-Google-Smtp-Source: AGHT+IFaJh857hb/MLPxS3Jfsr6yHydSWHKdHJsxa1+MiT2ACUW0FP5UBgePlTSW4toPjZCI4H3L+A==
X-Received: by 2002:a05:6512:92a:b0:50b:e9ec:4e2c with SMTP id
 f10-20020a056512092a00b0050be9ec4e2cmr1933885lft.104.1702332409906; 
 Mon, 11 Dec 2023 14:06:49 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-82-54-95-129.retail.telecomitalia.it. [82.54.95.129])
 by smtp.gmail.com with ESMTPSA id
 se13-20020a170907a38d00b00a1f78048f08sm4568276ejc.146.2023.12.11.14.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 14:06:49 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 0/6] Support display on stm32f469-disco board
Date: Mon, 11 Dec 2023 23:05:50 +0100
Message-ID: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The series adds support for the Orise Tech OTM8009A display on the
stm32f469-disco board. Substantial differences in the drivers for clock
management, LTDC and DSI compared to Linux, made it necessary to modify
the device tree. These changes were made in stm32f469-disco-uboot.dtsi to
avoid altering the Linux device tree. It is therefore desirable, as soon
as possible, to add these drivers the functionalities so that they do not
require device tree properties that deviate from those present in the Linux
version.

Changes in v3:
- Add Patrice Chotard's Reviewed-by tag.
- Remove RFC tag
- Split "[4/5] ARM: dts: stm32: support display on stm32f469-disco board"
  patch in 2 parts:
  - DTS ([4/6] ARM: dts: stm32: support MIPI DSI on stm32f469-disco board)
  - config and LTDC driver update ([5/6] board: stm32f469-disco: add support to display)

Changes in v2:
- Add Patrice Chotard's Reviewed-by tag to patches 1, 2 and 3 of the series.
- Fix frame buffer allocation for stm32f469 discovery board.

Dario Binacchi (6):
  ARM: dts: stm32f469-disco: sync with Linux 6.5
  ARM: dts: stm32: make the LTDC clock usable by the clock driver
  ARM: dts: stm32: make the DSI clock usable by the clock driver
  ARM: dts: stm32: support MIPI DSI on stm32f469-disco board
  board: stm32f469-disco: add support to display
  board: stm32f469-disco: add splash screen with stmicroelectronics logo

 arch/arm/dts/stm32f469-disco-u-boot.dtsi |  13 ++++++++++
 arch/arm/dts/stm32f469-disco.dts         |   4 +--
 configs/stm32f469-discovery_defconfig    |  16 ++++++++++++
 drivers/video/stm32/stm32_ltdc.c         |  31 +++++++++++++++++++++++
 include/configs/stm32f469-discovery.h    |   2 ++
 tools/logos/stm32f469-discovery.bmp      | Bin 0 -> 18532 bytes
 6 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 tools/logos/stm32f469-discovery.bmp

-- 
2.43.0

