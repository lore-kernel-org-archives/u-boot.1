Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F25CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6FB286B3F;
	Sun, 17 Sep 2023 16:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MY2tVoON";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g0lQ01s6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ACC486B25; Sun, 17 Sep 2023 16:13:59 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CDD586B09
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVKJ73mKz9sWf
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbnidjx+SJBQO+cvs4AFVofUjOA+Ox3txQYKY9Meh1Y=;
 b=MY2tVoONqJ1WaOpVFT6irBNVlVJyNJgcQvSoCwAFT47u5GXIYIsJKcT6GM0LKwCoSkxrdD
 JN6mgxQsP6+Op2hpUvCNDzqkE31xon+HHHzlXlyyjc+Orrkyzdel3UYBQluVdfAr/V5cpl
 CFyzFvIq5v1nb6g5/qLLyiruXvKKVxJkoSgOB5pmA8ncMVKMUbYM2xa/xzAiHd0fAQvp3E
 AmabbwHI1v3ToBUHemLW94l1ovozhkiQ5kgj9ra9nW6E3+bC53Ox/1G8R2sw8/0zo+jfu+
 QbX7Q1olpaF+QzXQCFMEewEoWOAOLSGxftpctXj3mIr2Kc8ZWbYAo+EZzm3KAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbnidjx+SJBQO+cvs4AFVofUjOA+Ox3txQYKY9Meh1Y=;
 b=g0lQ01s6WcpkzMIIcM94bMCV1OH1o8HbV7a7cMQ2Mrf8JNt8rZff5o9dVFfMPRWvkdCJpJ
 hvGf6N7qALahSDh7ZA1n/DgAQwTv8lhBl1x0njuSiAWRPaiwd6C4XcmmbFwoaRNssCsrXo
 25KlPF4XakqwoaRFD6e8Jef53iUfx2BWcvQma++d0KMbT9WAtKuM6A1xDDgAvTlr5f9cM8
 dH2Nit7y0c3smuggdg8xFV8vgaPP0JkxsfPBp2myRp3CilNq53JtGfSsekLR2BVAw0ar4L
 2FGZfd+NBPx4tZf1CzLFfMd8szFsklv9Z9ZSvG38tf0tUclJHd7NUFkJVr/xzg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/19] ARM: dts: renesas: Synchronize R-Car R8A77980 V3H DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:08 +0200
Message-Id: <20230917141319.379939-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 17a9869579be8488a17
X-MBO-RS-META: 1wtnektgqsnahch86ea8oyu7ea8owmnd
X-Rspamd-Queue-Id: 4RpVKJ73mKz9sWf
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

Synchronize R-Car R8A77980 V3H DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/condor-common.dtsi  | 1 +
 arch/arm/dts/r8a77980-condor.dts | 8 ++++++++
 arch/arm/dts/r8a77980-v3hsk.dts  | 1 +
 arch/arm/dts/r8a77980.dtsi       | 5 ++++-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/condor-common.dtsi b/arch/arm/dts/condor-common.dtsi
index dfbe35bf46e..7c34d14dcd7 100644
--- a/arch/arm/dts/condor-common.dtsi
+++ b/arch/arm/dts/condor-common.dtsi
@@ -21,6 +21,7 @@
 
 	chosen {
 		stdout-path = "serial0:115200n8";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=on";
 	};
 
 	d1_8v: regulator-2 {
diff --git a/arch/arm/dts/r8a77980-condor.dts b/arch/arm/dts/r8a77980-condor.dts
index 1d326552e2f..68d1f1d53b3 100644
--- a/arch/arm/dts/r8a77980-condor.dts
+++ b/arch/arm/dts/r8a77980-condor.dts
@@ -14,3 +14,11 @@
 	model = "Renesas Condor board based on r8a77980";
 	compatible = "renesas,condor", "renesas,r8a77980";
 };
+
+&i2c0 {
+	eeprom@50 {
+		compatible = "rohm,br24t01", "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
diff --git a/arch/arm/dts/r8a77980-v3hsk.dts b/arch/arm/dts/r8a77980-v3hsk.dts
index d168b0e7747..77d22df25ff 100644
--- a/arch/arm/dts/r8a77980-v3hsk.dts
+++ b/arch/arm/dts/r8a77980-v3hsk.dts
@@ -122,6 +122,7 @@
 	phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id0022.1622",
 			     "ethernet-phy-ieee802.3-c22";
+		rxc-skew-ps = <1500>;
 		reg = <0>;
 		interrupt-parent = <&gpio4>;
 		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm/dts/r8a77980.dtsi b/arch/arm/dts/r8a77980.dtsi
index c4ac28a0f71..5ed2daaca1f 100644
--- a/arch/arm/dts/r8a77980.dtsi
+++ b/arch/arm/dts/r8a77980.dtsi
@@ -1386,7 +1386,8 @@
 				 <0x02000000 0 0xfe200000 0 0xfe200000 0 0x0200000>,
 				 <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>,
 				 <0x42000000 0 0x38000000 0 0x38000000 0 0x8000000>;
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			/* Map all possible DDR/IOMMU as inbound ranges */
+			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
@@ -1399,6 +1400,8 @@
 			resets = <&cpg 319>;
 			phys = <&pcie_phy>;
 			phy-names = "pcie";
+			iommu-map = <0 &ipmmu_vi0 5 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
-- 
2.40.1

