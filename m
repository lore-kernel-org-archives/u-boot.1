Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28DBC3ABC6
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5382182A0A;
	Thu,  8 May 2025 23:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="EoiMEJOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24454829E4; Thu,  8 May 2025 23:24:35 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2692182AB1
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739472; x=1746998672;
 bh=WdINZlVrxLCODgGmEft/B1R0ndZZXcBDrpc2vVcuhjU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=EoiMEJOGb7PYkIrXVXNutgLXFUEp/6hFN/YzB+uQyH19HiPAivxAop585+Dk21pLm
 6QqgxzRmuhyqQbVkD4vbj2okLI33c0CuXlI79yg+YLV5C1foM5pr8DqP8xuvYcc+sT
 /gGL3hlndXXD1KJMk43bkBs3WVjlzHoMrtqMeZ3D2bH9YxvCGPUAht65kO5QpS8oTR
 vI68vOwOt7qnr8x3qRJaA8xAfCltBxvFmqnB2Y0iSJREwzPzWnl9IDVsZnbIRMrZS6
 wRMNJ2THyC+NT0cAYSbjbV6Y8dv8sUBtdelNR/TBihf+QYMT+ZaLSyReyigcZJvyBz
 TG2ti7C1oi29g==
Date: Thu, 08 May 2025 21:24:27 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 08/10] arm: dts: add STM32H747 discovery board
Message-ID: <20250508212058.640483-9-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 7e7e1d0be26bff170a4ce09b151b00b8ab251b1d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add initial support for the STM32H747 discovery baord. Copied
from the STM32H743 discovery board.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/dts/stm32h747i-disco-u-boot.dtsi | 101 ++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi

diff --git a/arch/arm/dts/stm32h747i-disco-u-boot.dtsi b/arch/arm/dts/stm32=
h747i-disco-u-boot.dtsi
new file mode 100644
index 00000000000..02e28c63f28
--- /dev/null
+++ b/arch/arm/dts/stm32h747i-disco-u-boot.dtsi
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <stm32h7-u-boot.dtsi>
+
+&fmc {
+
+=09/*
+=09 * Memory configuration from sdram datasheet IS42S32800G-6BLI
+=09 * first bank is bank@0
+=09 * second bank is bank@1
+=09 */
+=09bank1: bank@1 {
+=09=09st,sdram-control =3D /bits/ 8 <NO_COL_9
+=09=09=09=09=09     NO_ROW_12
+=09=09=09=09=09     MWIDTH_32
+=09=09=09=09=09     BANKS_4
+=09=09=09=09=09     CAS_2
+=09=09=09=09=09     SDCLK_3
+=09=09=09=09=09     RD_BURST_EN
+=09=09=09=09=09     RD_PIPE_DL_0>;
+=09=09st,sdram-timing =3D /bits/ 8 <TMRD_1
+=09=09=09=09=09    TXSR_1
+=09=09=09=09=09    TRAS_1
+=09=09=09=09=09    TRC_6
+=09=09=09=09=09    TRP_2
+=09=09=09=09=09    TWR_1
+=09=09=09=09=09    TRCD_1>;
+=09=09st,sdram-refcount =3D <1539>;
+=09};
+};
+
+&pinctrl {
+=09fmc_pins: fmc@0 {
+=09=09pins {
+=09=09=09pinmux =3D <STM32_PINMUX('D', 0, AF12)>,
+=09=09=09=09 <STM32_PINMUX('D', 1, AF12)>,
+=09=09=09=09 <STM32_PINMUX('D', 8, AF12)>,
+=09=09=09=09 <STM32_PINMUX('D', 9, AF12)>,
+=09=09=09=09 <STM32_PINMUX('D',10, AF12)>,
+=09=09=09=09 <STM32_PINMUX('D',14, AF12)>,
+=09=09=09=09 <STM32_PINMUX('D',15, AF12)>,
+
+=09=09=09=09 <STM32_PINMUX('E', 0, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E', 1, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E', 7, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E', 8, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E', 9, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E',10, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E',11, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E',12, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E',13, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E',14, AF12)>,
+=09=09=09=09 <STM32_PINMUX('E',15, AF12)>,
+
+=09=09=09=09 <STM32_PINMUX('F', 0, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F', 1, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F', 2, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F', 3, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F', 4, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F', 5, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F',11, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F',12, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F',13, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F',14, AF12)>,
+=09=09=09=09 <STM32_PINMUX('F',15, AF12)>,
+
+=09=09=09=09 <STM32_PINMUX('G', 0, AF12)>,
+=09=09=09=09 <STM32_PINMUX('G', 1, AF12)>,
+=09=09=09=09 <STM32_PINMUX('G', 2, AF12)>,
+=09=09=09=09 <STM32_PINMUX('G', 4, AF12)>,
+=09=09=09=09 <STM32_PINMUX('G', 5, AF12)>,
+=09=09=09=09 <STM32_PINMUX('G', 8, AF12)>,
+=09=09=09=09 <STM32_PINMUX('G',15, AF12)>,
+
+=09=09=09=09 <STM32_PINMUX('H', 5, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H', 6, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H', 7, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H', 8, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H', 9, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H',10, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H',11, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H',12, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H',13, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H',14, AF12)>,
+=09=09=09=09 <STM32_PINMUX('H',15, AF12)>,
+
+=09=09=09=09 <STM32_PINMUX('I', 0, AF12)>,
+=09=09=09=09 <STM32_PINMUX('I', 1, AF12)>,
+=09=09=09=09 <STM32_PINMUX('I', 2, AF12)>,
+=09=09=09=09 <STM32_PINMUX('I', 3, AF12)>,
+=09=09=09=09 <STM32_PINMUX('I', 4, AF12)>,
+=09=09=09=09 <STM32_PINMUX('I', 5, AF12)>,
+=09=09=09=09 <STM32_PINMUX('I', 6, AF12)>,
+=09=09=09=09 <STM32_PINMUX('I', 7, AF12)>,
+=09=09=09=09 <STM32_PINMUX('I', 9, AF12)>,
+=09=09=09=09 <STM32_PINMUX('I',10, AF12)>;
+
+=09=09=09slew-rate =3D <3>;
+=09=09};
+=09};
+};
--=20
2.39.5


