Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F0C0218C
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386C780243;
	Thu, 23 Jan 2025 15:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="SNc1rKz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A615806DC; Thu, 23 Jan 2025 15:51:48 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4568880214
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3118deafe3=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NC1Cpr020449;
 Thu, 23 Jan 2025 15:51:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=sqCn0wj39hRsEubDYeIbRZ
 h57SvGaHWcXdqRJpF9SyI=; b=SNc1rKz3P7Y08ivxnREfxgqyw+B5u/xAKhZNh1
 7C0nJRVWC1UV29Lam42QsfKn6LRBfpVJnc+xPw+AO+Ny3STDibpCuDrBiuyaE0nG
 CR/x/dNGfdVJIb/iSsWWxXGXLw92DkWL2VX6X4gcM5bizKbG5KgToGevaTREs23b
 WpdEj0+N8ZtjIxX8kxBGF7/ZlMQzs6UoWwfdY17yEiyY6p1a1I+ozupnrqceErys
 nZvS1dtfx9Qjr2Xo3fxi9xdNp/OKUQVq/j+85umQVEbjV85JIw9vboR3lllqeNRA
 PIprrB8RWlu8+b0WgDF2jGPplMKZGzOuOTVRFQNPv07KOOsw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44bapu31y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 15:51:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D16E040044;
 Thu, 23 Jan 2025 15:49:39 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8EB8A2B9C09;
 Thu, 23 Jan 2025 15:47:21 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 23 Jan
 2025 15:47:21 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Fabio Estevam <festevam@gmail.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mathieu Othacehe <othacehe@gnu.org>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 0/9] Restore USB and add UMS support for STiH407-B2260
Date: Thu, 23 Jan 2025 15:47:09 +0100
Message-ID: <20250123144718.1139824-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
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


This series is :
 _ restoring USB on STiH410-B2260 which hasn't been
   tested since a while.
 _ migrating STi DWC3 glue from proprietary driver to
   dwc3-generic driver.
 _ adding UMS support for STiH410-B2260.


Changes in v4:
  - Update Kconfig description

Changes in v3:
  - Update comment by adding "Remove useless include files"
  - Replace debug() by dev_err()
  - check return value of syscon_regmap_lookup_by_phandle()

Changes in v2:
  - remove useless include files
  - add dwc3-sti.c DWC3 wrapper as done for dwc3-am62.c

Patrice Chotard (9):
  ARM: dts: sti: Add fixed clock for ehci and ohci nodes in
    stih410-b2260.dtsi
  configs: stih410-b2260: Enable DM_REGULATOR flag
  usb: dwc3-generic: Reorder include
  usb: dwc3-generic: Add STih407 support
  configs: stih410-b2260: Enable USB_DWC3_GENERIC and USB_DWC3_STI flags
  usb: dwc3: Remove dwc3 glue driver support for STi
  configs: stih410-b2260: Enable DM_USB_GADGET flag
  board: stih410-b2260: Remove board_usb_init/cleanup()
  configs: stih410-b2260: Enable CMD_USB_MASS_STORAGE flag

 MAINTAINERS                            |   3 +-
 arch/arm/dts/stih410-b2260-u-boot.dtsi |  10 +
 board/st/stih410-b2260/board.c         |  30 ---
 configs/stih410-b2260_defconfig        |   5 +
 drivers/usb/dwc3/Kconfig               |   8 +
 drivers/usb/dwc3/Makefile              |   1 +
 drivers/usb/dwc3/dwc3-generic-sti.c    | 132 +++++++++++++
 drivers/usb/dwc3/dwc3-generic.c        |  20 +-
 drivers/usb/host/Kconfig               |   9 -
 drivers/usb/host/Makefile              |   1 -
 drivers/usb/host/dwc3-sti-glue.c       | 253 -------------------------
 include/dwc3-sti-glue.h                |  41 ----
 12 files changed, 161 insertions(+), 352 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-generic-sti.c
 delete mode 100644 drivers/usb/host/dwc3-sti-glue.c
 delete mode 100644 include/dwc3-sti-glue.h

-- 
2.25.1

