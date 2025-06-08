Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485BDC5B552
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 21:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E19B8144A;
	Sun,  8 Jun 2025 23:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rugrK5Zw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gja6ekMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D26881F0D; Sun,  8 Jun 2025 23:01:53 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89F980FA8
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 23:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bFnYB4sg4z9tW3;
 Sun,  8 Jun 2025 23:01:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749416510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bYsMIj2jhBdFuStz5wnfrdBC7qfYS0n22yj+RPVt/0w=;
 b=rugrK5Zwgz1tgXKNks1k/D4FEmsJ7QJMOnIxWCSHJOmZPccjpVbX5hqUe6eJ0hYDtQQ6LU
 H892jqy/hUBG0CD1arya2Ef+4zVJ97x+cjQULYYE+bzWgB+j4DHkg0IM47e/2ALpIrHWoW
 k97w95VBZ1CLDHOusIdrL7hJoDnJ4u2y3kEaOGJZzbHrFn/WvdKwm1vtBLxPiLxOupdqO0
 NqjfTF7PFHElDsSAM1Vz4/JeFdgEmZfCMu1X69s1DD5nXsvc99Pl5WSqkswRdKNeTk+hki
 9/NVyzowuQ1iw9tYxCJY3M7nIuASEI/NBIKRcaPqLKqA67+NiyEjXcxXibaPqg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749416508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bYsMIj2jhBdFuStz5wnfrdBC7qfYS0n22yj+RPVt/0w=;
 b=gja6ekMR5H6kYy/eKArQJj4Vs7+793/+fUyysAP16ulEG6cqpdxF989v50dnKI+U7bsEaj
 mIFCCzR29KVkgooLE8MDOaZshb6dGxOLsuloWjoahA22QngR64WoGxXF/ZcrXF3jHXBir2
 DOrQm/GrvzZDgKhXeWBNac3LQx+CI5zu5hZv0PLpjIidTNBqq+HgBYwGgDYqLjbvgyagi5
 fIhQOWG1lsVl77yyDlRHm2lvf/IWMhAstcZiB+5KUkZmUKkBBoP4ItlCkoVKb+tEvE2awg
 POWjT8G/jRm1TUsZRcMCtRLWPWlc12km0FvaWXk7S9JgtDql02lcdVCzBQcd+g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: Clean up sysinfo EEPROM DT description
 on R-Car Gen3
Date: Sun,  8 Jun 2025 23:01:04 +0200
Message-ID: <20250608210133.1606437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: e3fgofimd5j9idscr4fg1dmq1uuggitd
X-MBO-RS-ID: 1a94ba8237523207c87
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

Most of the sysinfo EEPROM node eeprom@50 is now part of the core DTs,
remove duplicate DT properties from *-u-boot.dtsi . Adjust the phandle
reference to i2c-eeprom in sysinfo node using <&{i2c_*/eeprom@50}> to
avoid need for DT label. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi |  5 ++---
 arch/arm/dts/r8a77951-ulcb-u-boot.dtsi       |  8 ++------
 arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi |  5 ++---
 arch/arm/dts/r8a77960-ulcb-u-boot.dtsi       |  8 ++------
 arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi |  5 ++---
 arch/arm/dts/r8a77965-ulcb-u-boot.dtsi       |  8 ++------
 arch/arm/dts/r8a77980-condor-u-boot.dtsi     |  7 ++-----
 arch/arm/dts/r8a77990-ebisu-u-boot.dtsi      | 11 ++---------
 arch/arm/dts/r8a77995-draak-u-boot.dtsi      |  7 ++-----
 9 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi b/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi
index 744f4aaaad9..d88e839a890 100644
--- a/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi
@@ -10,7 +10,7 @@
 / {
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
-		i2c-eeprom = <&sysinfo_eeprom>;
+		i2c-eeprom = <&{i2c_dvfs/eeprom@50}>;
 		bootph-all;
 	};
 };
@@ -18,9 +18,8 @@
 &i2c_dvfs {
 	bootph-all;
 
-	sysinfo_eeprom: eeprom@50 {
+	eeprom@50 {
 		bootph-all;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi b/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi
index 305c4861520..8269d967af9 100644
--- a/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi
@@ -19,7 +19,7 @@
 
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
-		i2c-eeprom = <&sysinfo_eeprom>;
+		i2c-eeprom = <&{i2c_dvfs/eeprom@50}>;
 		bootph-all;
 	};
 };
@@ -27,12 +27,8 @@
 &i2c_dvfs {
 	bootph-all;
 
-	sysinfo_eeprom: eeprom@50 {
-		compatible = "rohm,br24t01", "atmel,24c01";
-		reg = <0x50>;
-		pagesize = <8>;
+	eeprom@50 {
 		bootph-all;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi b/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
index 84a28bf885c..0a1602cdd23 100644
--- a/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
@@ -10,7 +10,7 @@
 / {
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
-		i2c-eeprom = <&sysinfo_eeprom>;
+		i2c-eeprom = <&{i2c_dvfs/eeprom@50}>;
 		bootph-all;
 	};
 };
@@ -18,9 +18,8 @@
 &i2c_dvfs {
 	bootph-all;
 
-	sysinfo_eeprom: eeprom@50 {
+	eeprom@50 {
 		bootph-all;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi b/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
index 6372f953956..d2a0406be17 100644
--- a/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
@@ -19,7 +19,7 @@
 
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
-		i2c-eeprom = <&sysinfo_eeprom>;
+		i2c-eeprom = <&{i2c_dvfs/eeprom@50}>;
 		bootph-all;
 	};
 };
@@ -27,12 +27,8 @@
 &i2c_dvfs {
 	bootph-all;
 
-	sysinfo_eeprom: eeprom@50 {
-		compatible = "rohm,br24t01", "atmel,24c01";
-		reg = <0x50>;
-		pagesize = <8>;
+	eeprom@50 {
 		bootph-all;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi b/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
index d9a28fe9bab..518466aca35 100644
--- a/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
@@ -10,7 +10,7 @@
 / {
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
-		i2c-eeprom = <&sysinfo_eeprom>;
+		i2c-eeprom = <&{i2c_dvfs/eeprom@50}>;
 		bootph-all;
 	};
 };
@@ -18,9 +18,8 @@
 &i2c_dvfs {
 	bootph-all;
 
-	sysinfo_eeprom: eeprom@50 {
+	eeprom@50 {
 		bootph-all;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi b/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
index aa5de3d0465..3905bf4e4f7 100644
--- a/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
@@ -19,7 +19,7 @@
 
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
-		i2c-eeprom = <&sysinfo_eeprom>;
+		i2c-eeprom = <&{i2c_dvfs/eeprom@50}>;
 		bootph-all;
 	};
 };
@@ -27,12 +27,8 @@
 &i2c_dvfs {
 	bootph-all;
 
-	sysinfo_eeprom: eeprom@50 {
-		compatible = "rohm,br24t01", "atmel,24c01";
-		reg = <0x50>;
-		pagesize = <8>;
+	eeprom@50 {
 		bootph-all;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/dts/r8a77980-condor-u-boot.dtsi b/arch/arm/dts/r8a77980-condor-u-boot.dtsi
index 34a735ae5b2..382bfe8cacd 100644
--- a/arch/arm/dts/r8a77980-condor-u-boot.dtsi
+++ b/arch/arm/dts/r8a77980-condor-u-boot.dtsi
@@ -14,7 +14,7 @@
 
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
-		i2c-eeprom = <&sysinfo_eeprom>;
+		i2c-eeprom = <&{i2c0/eeprom@50}>;
 		bootph-all;
 	};
 };
@@ -22,10 +22,7 @@
 &i2c0 {
 	bootph-all;
 
-	sysinfo_eeprom: eeprom@50 {
-		compatible = "rohm,br24t01", "atmel,24c01";
-		reg = <0x50>;
-		pagesize = <8>;
+	eeprom@50 {
 		bootph-all;
 	};
 };
diff --git a/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi b/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
index b6b7b8f3609..a52c5de4ddf 100644
--- a/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
+++ b/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
@@ -10,23 +10,16 @@
 / {
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
-		i2c-eeprom = <&sysinfo_eeprom>;
+		i2c-eeprom = <&{i2c_dvfs/eeprom@50}>;
 		bootph-all;
 	};
 };
 
 &i2c_dvfs {
-	compatible = "renesas,iic-r8a77990",
-		     "renesas,rcar-gen3-iic",
-		     "renesas,rmobile-iic";
 	bootph-all;
 
-	sysinfo_eeprom: eeprom@50 {
-		compatible = "rohm,br24t01", "atmel,24c01";
-		reg = <0x50>;
-		pagesize = <8>;
+	eeprom@50 {
 		bootph-all;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/dts/r8a77995-draak-u-boot.dtsi b/arch/arm/dts/r8a77995-draak-u-boot.dtsi
index 1922c40a438..19d19542efd 100644
--- a/arch/arm/dts/r8a77995-draak-u-boot.dtsi
+++ b/arch/arm/dts/r8a77995-draak-u-boot.dtsi
@@ -10,7 +10,7 @@
 / {
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
-		i2c-eeprom = <&sysinfo_eeprom>;
+		i2c-eeprom = <&{i2c0/eeprom@50}>;
 		bootph-all;
 	};
 };
@@ -18,10 +18,7 @@
 &i2c0 {
 	bootph-all;
 
-	sysinfo_eeprom: eeprom@50 {
-		compatible = "rohm,br24t01", "atmel,24c01";
-		reg = <0x50>;
-		pagesize = <8>;
+	eeprom@50 {
 		bootph-all;
 	};
 };
-- 
2.47.2

