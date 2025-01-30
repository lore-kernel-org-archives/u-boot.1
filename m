Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B9CC0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99704820FE;
	Thu, 30 Jan 2025 17:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="yq6Az5+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFC08212B; Thu, 30 Jan 2025 17:46:17 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BEA282145
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125720023=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UEUtBZ022418;
 Thu, 30 Jan 2025 17:46:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=bc0PgtAkii1k73fjC74wzw
 Mr3saNrv9+H/DMBY1PwBQ=; b=yq6Az5+AWdHrxcHZr0Hrq08apXTtU4oDlGQyrv
 0h2HarlASIv7DQ6mDcvf30IaWEPkKsCSZG8LS/T32qeXJdRJUueEF89pII5fX2vr
 doBO558nM4tY9VBfWDYY7FWtzIegVXGWcPiDXnSohrjHkx85tThM+jDow9Isim6p
 zClxuMHIimquM10XOJtDGLDeq4VhZHtCepH91vUI2aItpUiD5iBo2twD8aQXVsgr
 PQoN+hKo1AzZTc3uHYZDeqIHg6HPOaFF6qAtJY2nlDntfO0tRCVES9nSIYDk6ke9
 4z78udcXbOYRxqoZjUi1VuM2L2EnisoCt8Db2VVRoM8gCm3g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44g6v6j3xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 17:46:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 85EA04002D;
 Thu, 30 Jan 2025 17:44:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 26A4F3E8A3A;
 Thu, 30 Jan 2025 17:35:49 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 17:35:48 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, Mathieu
 Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 0/9] Restore USB and add UMS support for STiH407-B2260
Date: Thu, 30 Jan 2025 17:35:38 +0100
Message-ID: <20250130163547.512990-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
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


Changes in v5:
  - move this patch from 6/9 to 3/9 position to avoid to have
    2 drivers with identical compatible string simultaneously.
  - update commit description accordingly
  - reorder files entry for ARM STI in MAINTAINERS file
  - add #define LOG_CATEGORY UCLASS_NOP
  - use UCLASS_NOP instead of UCLASS_SIMPLE_BUS

Changes in v4:
  - Update Kconfig description

Changes in v3:
  - add RB Mattijs Korpershoek
  - Update comment by adding "Remove useless include files"
  - Replace debug() by dev_err()
  - check return value of syscon_regmap_lookup_by_phandle()
  - add RB Mattijs Korpershoek

Changes in v2:
  - remove useless include files
  - add dwc3-sti.c DWC3 wrapper as done for dwc3-am62.c

Patrice Chotard (9):
  ARM: dts: sti: Add fixed clock for ehci and ohci nodes in
    stih410-b2260.dtsi
  configs: stih410-b2260: Enable DM_REGULATOR flag
  usb: dwc3: Remove dwc3 glue driver support for STi
  usb: dwc3-generic: Reorder include
  usb: dwc3-generic: Add STih407 support
  configs: stih410-b2260: Enable USB_DWC3_GENERIC and USB_DWC3_STI flags
  configs: stih410-b2260: Enable DM_USB_GADGET flag
  board: stih410-b2260: Remove board_usb_init/cleanup()
  configs: stih410-b2260: Enable CMD_USB_MASS_STORAGE flag

 MAINTAINERS                            |   3 +-
 arch/arm/dts/stih410-b2260-u-boot.dtsi |  10 +
 board/st/stih410-b2260/board.c         |  30 ---
 configs/stih410-b2260_defconfig        |   5 +
 drivers/usb/dwc3/Kconfig               |   8 +
 drivers/usb/dwc3/Makefile              |   1 +
 drivers/usb/dwc3/dwc3-generic-sti.c    | 134 +++++++++++++
 drivers/usb/dwc3/dwc3-generic.c        |  20 +-
 drivers/usb/host/Kconfig               |   9 -
 drivers/usb/host/Makefile              |   1 -
 drivers/usb/host/dwc3-sti-glue.c       | 253 -------------------------
 include/dwc3-sti-glue.h                |  41 ----
 12 files changed, 163 insertions(+), 352 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-generic-sti.c
 delete mode 100644 drivers/usb/host/dwc3-sti-glue.c
 delete mode 100644 include/dwc3-sti-glue.h

-- 
2.25.1

