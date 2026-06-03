Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC231CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 09:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F86848F5;
	Wed,  3 Jun 2026 11:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="2w73CeGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D0A848EE; Wed,  3 Jun 2026 11:55:20 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3648384898
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 11:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EA2FD1A37B7;
 Wed,  3 Jun 2026 09:55:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B6CCB5FFA8;
 Wed,  3 Jun 2026 09:55:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7CA3810888CD4; 
 Wed,  3 Jun 2026 11:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780480516; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=qhCd/nr17cK+1S8y+7I0gb6egFrn5TStLpac59ZP3y0=;
 b=2w73CeGrCbf0+TsKu+iziqizSWg7/hULIVriVtkr4At4qft5Xw3xBRkZFhxfN62dN0YAIn
 oRxOZA87dwKia0gNN+3kLDFVJ4SbH6khaDv7b3bvf5zTCy1CPw6yZ+zmKHpNxt8A0pej9H
 pTeitMU1/zdpUhvr3MEiW9GG4vnWaVLFEr7kD1rZNfW5u78NBPzsY+6h57vO2Nm1fDoWf4
 2Wkbsx9lx2ODH6pI5TQFKi/o3TO88QLA2BaEMVcXxFwbQDUamFrhinfmc9S5lleXyuINu1
 0WVBpnCmtr8/NWCrcN6E0H1rYNN8Sg/F/zJkwp+NGYu6s1JcMgy5vVP0/Is3Yw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v2 08/16] ram: k3-ddrss: Add j722s DDR resume sequence
Date: Wed,  3 Jun 2026 11:54:41 +0200
Message-ID: <20260603095449.2089514-9-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603095449.2089514-1-richard.genoud@bootlin.com>
References: <20260603095449.2089514-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

As the j722s and am62p resume sequence differs on the way they are
detecting that the board is resuming, we should have a specific
compatible for each one of them.

For that purpose, introduce ti,j722s-ddrss compatible.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/dts/k3-j722s-r5-evm.dts |  4 ++++
 drivers/ram/k3-ddrss/k3-ddrss.c  | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index e1ef5d181ed7..cc4a5910673b 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -11,6 +11,10 @@
 #include "k3-am62a-ddr.dtsi"
 #include "k3-j722s-r5.dtsi"
 
+&memorycontroller {
+	compatible = "ti,j722s-ddrss", "ti,am62a-ddrss";
+};
+
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
 	status = "okay";
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 7b2d2e0814b8..7b23123ab00d 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -1283,6 +1283,11 @@ static int k3_ddrss_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
+__weak bool j7xx_board_is_resuming(void)
+{
+	return false;
+}
+
 static struct ram_ops k3_ddrss_ops = {
 	.get_info = k3_ddrss_get_info,
 };
@@ -1301,11 +1306,18 @@ static const struct k3_ddrss_data j721s2_data = {
 	.flags = MULTI_DDR_SUBSYSTEM,
 };
 
+static const struct k3_ddrss_data j722s_data = {
+	.flags = SINGLE_DDR_SUBSYSTEM,
+	.is_lpm_resume = j7xx_board_is_resuming,
+	.ddrss_deassert_retention = am62xx_ddrss_deassert_retention,
+};
+
 static const struct udevice_id k3_ddrss_ids[] = {
 	{.compatible = "ti,am62a-ddrss", .data = (ulong)&am62xx_data, },
 	{.compatible = "ti,am64-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721e-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721s2-ddrss", .data = (ulong)&j721s2_data, },
+	{.compatible = "ti,j722s-ddrss", .data = (ulong)&j722s_data, },
 	{}
 };
 
-- 
2.47.3

