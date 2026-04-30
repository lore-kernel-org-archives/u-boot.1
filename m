Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6CECCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25D78468E;
	Thu, 30 Apr 2026 10:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JBxVeAkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66252846E9; Thu, 30 Apr 2026 10:45:22 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDD18466B
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8DE1BC5CD62;
 Thu, 30 Apr 2026 08:46:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 16B6560495;
 Thu, 30 Apr 2026 08:45:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C0B8F1072B7B6; 
 Thu, 30 Apr 2026 10:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777538719; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=lj4VIh/Yag1EdNtO913bv/E0tZgKxdFAuP1govJqXx4=;
 b=JBxVeAkJgXCGf7oaiEnUBw9YBagrJt6sZ8To/cUcm6pMR9g6dFNegT3Q+bP5ER3GxSa0+U
 Iw+V11sJafCqEGVFHKR8vWBsV/1rYQ3SU7QeIAlfzijb8t05WCwtWPiSBbYPlrdcONw5kb
 fngg03h5scSI+HT+I55p/M0ZefV4ZxVxmJgIQb46P7xW7Myd74/fYgQBCvGchUxKMl7b1X
 ju9tywY7RBcQwzIZcVvUAFtuv+Zxr2dSzYzbm7ZvQIc6L9EuItzCoBhmduCcLl3DtRSUEq
 JSzTbFPnwBw7P8ayF9E3KJB4leJNokhmbrVx4MDOSxSCGOffSMP6Jm85xrPjyw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH 20/20] arm: dts: k3-j7200: Extend firewall for ATF region to
 TIFS
Date: Thu, 30 Apr 2026 10:44:13 +0200
Message-ID: <20260430084414.1354490-21-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430084414.1354490-1-richard.genoud@bootlin.com>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
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

From: Prasanth Babu Mantena <p-mantena@ti.com>

Extend the access to SRAM region of ATF to TIFS as well. This is
needed for TIFS for encryption and decryption of ATF as a part of
low power mode sequence. TIFS encrypts the ATF while entering into
low power mode and decrypts it back while resuming back.
So, giving permissions for TIFS to access this region.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/dts/k3-binman.dtsi       | 18 ++++++++++++++++--
 arch/arm/dts/k3-j7200-binman.dtsi |  4 ++--
 arch/arm/dts/k3-security.h        |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 0fd93f9536a2..4ffd8ec9e1c1 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -479,7 +479,21 @@
 		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
 		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
 	};
-	firewall_armv8_optee_fg: template-8 {
+	firewall_armv8_atf_tifs_fg: template-8 {
+		control = <(FWCTRL_EN | FWCTRL_LOCK |
+					FWCTRL_CACHE)>;
+		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD)>,
+					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>;
+		start_address = <0x0 0x70000000>;
+		end_address = <0x0 0x7001ffff>;
+	};
+	firewall_armv8_optee_fg: template-9 {
 		control = <(FWCTRL_EN | FWCTRL_LOCK |
 					FWCTRL_CACHE)>;
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
@@ -489,7 +503,7 @@
 		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
 	};
 
-	ti_falcon_template: template-9 {
+	ti_falcon_template: template-10 {
 		filename = "tifalcon.bin";
 		pad-byte = <0xff>;
 
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index c2b86339d593..68ce4aa0ff12 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -259,7 +259,7 @@
 
 						firewall-4760-1 {
 							/* nb_slv0__mem0 Foreground Firewall */
-							insert-template = <&firewall_armv8_atf_fg>;
+							insert-template = <&firewall_armv8_atf_tifs_fg>;
 							id = <4760>;
 							region = <1>;
 						};
@@ -272,7 +272,7 @@
 
 						firewall-4761-1 {
 							/* nb_slv1__mem0 Foreground Firewall */
-							insert-template = <&firewall_armv8_atf_fg>;
+							insert-template = <&firewall_armv8_atf_tifs_fg>;
 							id = <4761>;
 							region = <1>;
 						};
diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
index 33609caa8fb5..3e066bca6ad7 100644
--- a/arch/arm/dts/k3-security.h
+++ b/arch/arm/dts/k3-security.h
@@ -7,6 +7,7 @@
 #define DTS_ARM64_TI_K3_FIREWALL_H
 
 #define FWPRIVID_ALL    0xc3
+#define FWPRIVID_TIFS   0xca
 #define FWPRIVID_ARMV8  1
 #define FWPRIVID_SHIFT  16
 
