Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93A6C021B3
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 14:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 082B980540;
	Sun, 23 Feb 2025 15:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="iRKdzd9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1559080F88; Sun, 23 Feb 2025 07:20:19 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467B580207
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 07:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1740291608; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aRWiOUABXgWlsPpQQMde5rPNPdBpbhQjzswpI8zKWvrhyMj+1mUvwTni/gs5MLMS+30Qw9Y8wsN/3MbrDtTIzUiHPN7QvCrQleUez+WERZHLMe1O0V7p14WsxG+89/yNOom9oqOyft7iXrAMOXOrGJyPn18dwQMBLQw2ZRcsi8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1740291608;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/PQN4zNOahSi8nJmwpu85gH8Vrl/2jKbp+p0xnNGcg0=; 
 b=NpW1x6x9J0oJ6VJv6xr6p9IG1ioVPe4Aip8wfQA1L+KBjxKrTGv+I7Kim8ChvWxzdaGRhqTurIQzznSdQVng6Nt7aY9OpQ2hxDdOSaJcSBwlKf0Ue4d/mDDlfWbHV6g2rCGgbsb/B/o3OZ4Ka9407rGxv8hHHUnzI39h01TPibQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740291608; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=/PQN4zNOahSi8nJmwpu85gH8Vrl/2jKbp+p0xnNGcg0=;
 b=iRKdzd9q7Aq23+282jf5+0msqzUkhcQnvbBlJywnR3JmF2bH9B+H2yy1EWlImb5O
 QWYYbruSPW+nz8sm4iVHLjiMPYW7wg0kzg9osWt+L9HIFh51tUPjy8ep1XBEb6VdLiO
 CBLQ9qs91NSqtynEC9JRtMfKi8dU/E57/eYlvdEM=
Received: by mx.zohomail.com with SMTPS id 1740291607319736.800669197495;
 Sat, 22 Feb 2025 22:20:07 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sun, 23 Feb 2025 14:19:26 +0800
Subject: [PATCH] riscv: dts: spacemit: Update UART compatible for k1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-k1-uart-v1-1-2950d22e9f4d@pigmoral.tech>
X-B4-Tracking: v=1; b=H4sIAO69umcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNj3WxD3dLEohLdNAtj4xSzFFNLc4s0JaDqgqLUtMwKsEnRsbW1AA/
 YioBZAAAA
X-Change-ID: 20250223-k1-uart-f833d6d5978f
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Huan Zhou <me@per1cycle.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740291583; l=3660;
 i=junhui.liu@pigmoral.tech; s=20250223; h=from:subject:message-id;
 bh=H1tkLwL2ZQ+M0BdSn4rqkRGzMUW0NbuJ2Q0U7ousaSY=;
 b=vC/IaPq1Kz43WzujNRUZQzPxt87YOSPMRkhaBmclj3NYn9Ib9Ig3XcRUstCa/HIZzO9rI25ok
 Bhre3KpSiORB50HNw0Wo2ZlgzDrMLuJHQ6g12RNZOsZpB3arPTrr2En
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=ZRZkOjG47iI+To+oAo2R4KIpMwtz8r0TffJ5/nO2tcg=
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 23 Feb 2025 15:28:24 +0100
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

Update UART compatible in k1 dts to "intel,xscale-uart", introduced in
commit 2d84e1519c5b ("serial: ns16550: Add Intel XScale support")
recently, aligning dts with the upstream kernel.

Tested-by: Huan Zhou <me@per1cycle.org>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/dts/k1.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
index 514be453dbaf6713cdf4ad5a5d653488297ebb83..fa1cb507351e4dc80b39d439d739865bf9b1f170 100644
--- a/arch/riscv/dts/k1.dtsi
+++ b/arch/riscv/dts/k1.dtsi
@@ -327,7 +327,7 @@
 		ranges;
 
 		uart0: serial@d4017000 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017000 0x0 0x100>;
 			interrupts = <42>;
 			clock-frequency = <14857000>;
@@ -337,7 +337,7 @@
 		};
 
 		uart2: serial@d4017100 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017100 0x0 0x100>;
 			interrupts = <44>;
 			clock-frequency = <14857000>;
@@ -347,7 +347,7 @@
 		};
 
 		uart3: serial@d4017200 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017200 0x0 0x100>;
 			interrupts = <45>;
 			clock-frequency = <14857000>;
@@ -357,7 +357,7 @@
 		};
 
 		uart4: serial@d4017300 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017300 0x0 0x100>;
 			interrupts = <46>;
 			clock-frequency = <14857000>;
@@ -367,7 +367,7 @@
 		};
 
 		uart5: serial@d4017400 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017400 0x0 0x100>;
 			interrupts = <47>;
 			clock-frequency = <14857000>;
@@ -377,7 +377,7 @@
 		};
 
 		uart6: serial@d4017500 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017500 0x0 0x100>;
 			interrupts = <48>;
 			clock-frequency = <14857000>;
@@ -387,7 +387,7 @@
 		};
 
 		uart7: serial@d4017600 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017600 0x0 0x100>;
 			interrupts = <49>;
 			clock-frequency = <14857000>;
@@ -397,7 +397,7 @@
 		};
 
 		uart8: serial@d4017700 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017700 0x0 0x100>;
 			interrupts = <50>;
 			clock-frequency = <14857000>;
@@ -407,7 +407,7 @@
 		};
 
 		uart9: serial@d4017800 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017800 0x0 0x100>;
 			interrupts = <51>;
 			clock-frequency = <14857000>;
@@ -447,7 +447,7 @@
 		};
 
 		sec_uart1: serial@f0612000 {
-			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xf0612000 0x0 0x100>;
 			interrupts = <43>;
 			clock-frequency = <14857000>;
@@ -456,4 +456,4 @@
 			status = "reserved"; /* for TEE usage */
 		};
 	};
-};
\ No newline at end of file
+};

---
base-commit: 5061eab96acd60d28149e080f3a37fbe7220ca54
change-id: 20250223-k1-uart-f833d6d5978f

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>

