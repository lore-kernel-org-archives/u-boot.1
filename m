Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA721CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFFDA83DF7;
	Thu, 13 Nov 2025 12:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Si+vqHr1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C6bbIXr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835BF83E45; Thu, 13 Nov 2025 12:57:11 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA92783D13
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d6dzm1wQ8z9vCd;
 Thu, 13 Nov 2025 12:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763035028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mcx5m/TRZsojG6HPxFI+Sjx7RbzrMt6nvNvXxr0K1tY=;
 b=Si+vqHr1vCusAxcA7QelBSLAbK3HHJUnLZeZiWRr8xn2XzENar5+AOiMAQdizNTQC/f73/
 3Kz10rN+gn8LZFkjLpF/fmoKOOJIgr+gFE5MQFoSBn1Xf/GcFJdnpcZrcgvAnbkY9yuTu3
 g7UxD9iaUoqiOFGDdeuKxwgSFBvAolspLE1rkCLjIYI+Chd8lASpM5Q2B6hpWjws0q3JWz
 IFfzXJ43NVfIWGeGTTBB6OZ4OkHb47zCslKs1KK7eahkbQV7lQ3xvq/AAdnW2viiyintdl
 twcEQ++5m2flCUtmZ6i5wHlN5XUzMtSSVZZ77ZtjiAiXCl6BpyDUmpljnhLy4Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=C6bbIXr3;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763035026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mcx5m/TRZsojG6HPxFI+Sjx7RbzrMt6nvNvXxr0K1tY=;
 b=C6bbIXr3RdMpAX2ShU8ax35CpfVHQb+1hSBjD38yNGkGqHASH6OxTc1Xe2XL1Apt+QOrDp
 KRZmTxWif2FBqBwXuXVAaDdd7y5qYgN4A9Lnj4m8nMJnFODe1HruuXcRX+g3izDQxtIuvD
 OZr5MAaknE9xqSPuP7DyNYWjMG9Kf5IVu9SHq6aRoO8BYuJoRKYB57ZqhySGrRzyP9DuAJ
 DJOGnbXA8h5zPCSOGQ3wdQ6xIM0lAIA7Gu8USNIOnIxW2Sa3Xdj9sGPzvcKXi6K2rWem9J
 AabdZHp8befRCEgHuTPZGP1ok5LhiqVNBVR7Jm0PBY4ThAFbSatL6g4rB14N3A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] sandbox: Fix DT compiler address warnings in sandbox DTs
Date: Thu, 13 Nov 2025 12:56:29 +0100
Message-ID: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 115370e9a83ab6d52ae
X-MBO-RS-META: ybd84p7tobrqnmbx3swycoein7u5bi8z
X-Rspamd-Queue-Id: 4d6dzm1wQ8z9vCd
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

Trivially fix the following warnings in sandbox DTs, which show up with
DTC 1.7.2. Fill in the missing address and adjust emulated I2C address
to fit the 7bit address limit:

"
arch/sandbox/dts/sandbox.dtsi:138.30-140.5: Warning (i2c_bus_reg): /i2c@0/sandbox_pmic: I2C bus unit address format error, expected "40"
arch/sandbox/dts/sandbox.dtsi:146.18-161.5: Warning (i2c_bus_reg): /i2c@0/emul: I2C bus unit address format error, expected "ff"
arch/sandbox/dts/sandbox.dtsi:148.4-17: Warning (i2c_bus_reg): /i2c@0/emul:reg: I2C address must be less than 7-bits, got "0xff". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property
"

"
arch/sandbox/dts/.test.dtb.pre.tmp:912.18-926.5: Warning (i2c_bus_reg): /i2c@0/emul: I2C bus unit address format error, expected "ff"
arch/sandbox/dts/.test.dtb.pre.tmp:913.4-17: Warning (i2c_bus_reg): /i2c@0/emul:reg: I2C address must be less than 7-bits, got "0xff". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property
arch/sandbox/dts/.test.dtb.pre.tmp:928.30-931.5: Warning (i2c_bus_reg): /i2c@0/sandbox_pmic: I2C bus unit address format error, expected "40"
"

Fix up pmic test to match.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/sandbox/dts/sandbox.dtsi | 6 +++---
 arch/sandbox/dts/test.dts     | 6 +++---
 test/dm/pmic.c                | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index 8a115c503dc..02b03894eaf 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -135,7 +135,7 @@
 			sandbox,emul = <&emul0>;
 			bootph-pre-ram;
 		};
-		sandbox_pmic: sandbox_pmic {
+		sandbox_pmic: sandbox_pmic@40 {
 			reg = <0x40>;
 		};
 
@@ -143,9 +143,9 @@
 			reg = <0x41>;
 		};
 
-		i2c_emul: emul {
+		i2c_emul: emul@7f {
 			bootph-pre-ram;
-			reg = <0xff>;
+			reg = <0x7f>;
 			compatible = "sandbox,i2c-emul-parent";
 			emul_eeprom: emul-eeprom {
 				compatible = "sandbox,i2c-eeprom";
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a2c739a2044..86db3939cfd 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -909,8 +909,8 @@
 			sandbox,emul = <&emul1>;
 		};
 
-		i2c_emul: emul {
-			reg = <0xff>;
+		i2c_emul: emul@7f {
+			reg = <0x7f>;
 			compatible = "sandbox,i2c-emul-parent";
 			emul_eeprom: emul-eeprom {
 				compatible = "sandbox,i2c-eeprom";
@@ -925,7 +925,7 @@
 			};
 		};
 
-		sandbox_pmic: sandbox_pmic {
+		sandbox_pmic: sandbox_pmic@40 {
 			reg = <0x40>;
 			sandbox,emul = <&emul_pmic0>;
 		};
diff --git a/test/dm/pmic.c b/test/dm/pmic.c
index 70dd18f5df0..b163b8e315d 100644
--- a/test/dm/pmic.c
+++ b/test/dm/pmic.c
@@ -39,7 +39,7 @@ static inline int power_pmic_get(struct unit_test_state *uts, char *name)
 /* Test PMIC get method */
 static int dm_test_power_pmic_get(struct unit_test_state *uts)
 {
-	power_pmic_get(uts, "sandbox_pmic");
+	power_pmic_get(uts, "sandbox_pmic@40");
 
 	return 0;
 }
@@ -57,7 +57,7 @@ DM_TEST(dm_test_power_pmic_mc34708_get, UTF_SCAN_FDT);
 /* Test PMIC I/O */
 static int dm_test_power_pmic_io(struct unit_test_state *uts)
 {
-	const char *name = "sandbox_pmic";
+	const char *name = "sandbox_pmic@40";
 	uint8_t out_buffer, in_buffer;
 	struct udevice *dev;
 	int reg_count, i;
-- 
2.51.0

