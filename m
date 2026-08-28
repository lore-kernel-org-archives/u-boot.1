Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2A3C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09B514089B;
	Fri, 28 Aug 2026 13:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcEy_DzAUA-u; Fri, 28 Aug 2026 13:58:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925517;
	bh=EI/PAE888h567xHS1o/Klt4SMaw+Xvm6wgebOcEZ9ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AW1T3w0ENg+9hqxCoWdIV8U3O+MQN5EkjnU3yI2d7GyfKMt2NxFR68FhaMZXwlq0t
	 LO2ZQCQf9B6x0/Nl/i/LVvb6bL+SF9HvwGPRw3N+ChrT63HUzomnKCKzTgJABvVdtJ
	 2dL4clP+5J/GUy4acJFgCqdd2dEUOUU1mngfhCJFQ0ONlIemGP1kOI2xiZfdIMXlyL
	 zH1Ta0Rqj3y6hqMTj+Be7TMybwuihtRNVvLpJK04d5n/ldQ8HIWEZYsA555UJrXP4v
	 /Nuvnt6LIeSMsgpZWHfFt9C13yM6BSeaBZdiAFtG0xcTXf7ezpGVirTJKm+k8hxIfi
	 w891++AB2Q7Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46A1040861;
	Fri, 28 Aug 2026 13:58:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDF9C78B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B190B80F82
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SY1VCj09tsIv for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=sU1eZVOB
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C7EA80F7C
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 86C691A18A3;
 Fri, 28 Aug 2026 13:58:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5A1CD60537;
 Fri, 28 Aug 2026 13:58:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 58FAB11C781B3; 
 Fri, 28 Aug 2026 15:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925509; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=EI/PAE888h567xHS1o/Klt4SMaw+Xvm6wgebOcEZ9ns=;
 b=sU1eZVOBC4RtEWhIuF0gH3c6neAqeT5iJRhL+SbJpmxJFBrCydfZn/WEb1tFJCTzA6v5W3
 y1watEtbqFlF1KwDQ0YLBmQrctCXavZTfFWDAICIIU1HqBPbsNUnnT0Bi7i9mQPgTsOgx2
 wvPNSS3ei4BDHYerOKISVNltykIa/QyIKo7ZhWRgulGBLyOxsxinFAsuKpVzgIBeHFMZLw
 OYdlmJ3c19zDv1TNVG0KJRdwu/KVs/CfwmLAS57H18LajCfqOYpVuwy4U0/D17oyL80TPB
 0tzMAuzLimcaETVZ+0j7aMyRgo5PERiGFnbHEjh5Lqtlfnp/T3dlqlTNcic/Lw==
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
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 13/21] ram: k3-ddrss: Add j722s DDR resume sequence
Date: Fri, 28 Aug 2026 15:57:22 +0200
Message-ID: <20260828135730.1565643-14-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

As the j722s and am62p resume sequence differs on the way they are
detecting that the board is resuming, we should have a specific
compatible for each one of them.

For that purpose, introduce ti,j722s-ddrss compatible.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/dts/k3-j722s-r5-evm.dts | 4 ++++
 drivers/ram/k3-ddrss/k3-ddrss.c  | 8 ++++++++
 2 files changed, 12 insertions(+)

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
index d8ec8356b286..3af360f191df 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -19,6 +19,7 @@
 #include <power-domain.h>
 #include <wait_bit.h>
 #include <power/regulator.h>
+#include <mach/hardware.h>
 #include <mach/k3-ddr.h>
 
 #include "k3-ddrss-lpm.h"
@@ -1300,11 +1301,18 @@ static const struct k3_ddrss_data j721s2_data = {
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
 
