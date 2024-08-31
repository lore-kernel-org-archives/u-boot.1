Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26370CD13D9
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 20:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A983688D82;
	Sat, 31 Aug 2024 22:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Drgj3MsN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X+EsiGM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB80888D87; Sat, 31 Aug 2024 22:34:07 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E145488D64
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 22:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wx6Ds3SXbz9t0F;
 Sat, 31 Aug 2024 22:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=H6S0SOFUqMgv7CPHL34POcXsK8nisutgAJhF3qayN3Q=;
 b=Drgj3MsNA06Rmk6MQye17CqrtGQAMPoKUYVAkcGBlYx58BKSS6jkNvQrGvlIAXmuxoMLbd
 OJliusPZF5gwysYu7wGlVjqXa31l12NNyhhnolJvHfHaiDvh2ZTnMNGVGKH6x7tC+yWMD/
 WhQOLapyWBX75aeJDV1mUGpXQ5CYozFpbRhFOx4TPIGM/iQ4DADNSJhtu+hDnGp8cVMFDM
 TmBhnn14+kYQOg4opQ/vYSKIvqxZjZSp9yxI7DIYmcY2a3uhYhjYNjKwv+3r7gnvRU/etV
 4/yfDN1UOZ25b0z01BBIZzPDTediJSaRnqxJ5LlwWkAZAlcRfdLKhkdDEWxnTA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=H6S0SOFUqMgv7CPHL34POcXsK8nisutgAJhF3qayN3Q=;
 b=X+EsiGM3YJUQxEQzJj+fPVyzSMGOUrUSEZoXIeJ9cgdedARE+XEyLvBx34LxU4fPFzE5jc
 1pUkbp6SZkLoYTPue7Njz2bjHY3w83Zmejn2/8noGJvl2pfv+iZxPlLvoRvT6KKLYbX+AV
 mSGe09DQmEoHS61CXF0MqFjZBOb4a0oWgEroDukFnm5QXZ7su6KnNp1bpC8/7DxZIybGBT
 MOlBH80HPUuJxTVuO2MicKRWmAs5tSylZM57UrAIqc3HPW4B0mjP6i2VlzETpRYX7AceDP
 YAWYCUWXN6wpxBPGVjW1yQz0wTEskt5n4waaLahl+Q0xmrImJ3MJNoM7lyI4Fw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Cong Dang <cong.dang.xn@renesas.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: renesas: Minimize R8A779G0 V4H RPC SPI DT node
Date: Sat, 31 Aug 2024 22:33:37 +0200
Message-ID: <20240831203352.547864-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8xu1f8xd4dy45ohzok1ybyeyboki6bob
X-MBO-RS-ID: 9d0c25d731888a11fde
X-Rspamd-Queue-Id: 4Wx6Ds3SXbz9t0F
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

The RPC SPI DT node is now part of mainline Linux DT, remove the
duplicate content from U-Boot DT extras. The SPI flash DT node name
has been changed from "spi-flash@0" to "flash@0", reflect this change
in this patch. Retain "bank-width" and "num-cs" DT properties which
are used by U-Boot. Retain "spi-rx-bus-width" and "spi-tx-bus-width"
DT properties to indicate the bus should always be operated in 1-1-1
mode as the U-Boot RPC SPI driver does not support higher bus width
modes yet.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Cong Dang <cong.dang.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g0-u-boot.dtsi            |  1 -
 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi | 22 +-------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/dts/r8a779g0-u-boot.dtsi b/arch/arm/dts/r8a779g0-u-boot.dtsi
index cc8becac996..f60eba531e4 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -8,7 +8,6 @@
 #include "r8a779x-u-boot.dtsi"
 
 &rpc {
-	reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x04000000>;
 	bank-width = <2>;
 	num-cs = <1>;
 };
diff --git a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
index a102639010d..c3704d789e8 100644
--- a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
@@ -13,29 +13,9 @@
 	};
 };
 
-&pfc {
-	qspi0_pins: qspi0 {
-		groups = "qspi0_ctrl", "qspi0_data4";
-		function = "qspi0";
-	};
-};
-
 &rpc {
-	pinctrl-0 = <&qspi0_pins>;
-	pinctrl-names = "default";
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	spi-max-frequency = <40000000>;
-	status = "disabled";
-
-	spi-flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "s25fs512s", "jedec,spi-nor";
-		reg = <0>;
+	flash@0 {
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
-		spi-max-frequency = <40000000>;
 	};
 };
-- 
2.45.2

