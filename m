Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F21CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFB686B37;
	Sun, 17 Sep 2023 16:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iW37CcQi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B80p19o5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92E7886AA7; Sun, 17 Sep 2023 16:13:58 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C436786308
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVKJ4735z9snG
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92jD03qXJr2/nokrPKvsOnC5XkZcAtT9TcfkD8xhu4Y=;
 b=iW37CcQiCT1nm6JoymoBTaCB13OBPCzjBtKWPEb1F6E+0aJYD9ypnfy4UsyMhBX3lSpw9S
 zrK2Ukv884YLy87irSIxNRaIqkZjX8rKmDFRRTpjnjfq3T78hU+7WD9Ebu76s3Gvf04pB2
 yq68tkIRmaga+eudjWTisSk0uBf+ngA8zKKIrsRDL0oNBa/YxC8pt5uM3SdDrMxC3fN1S5
 t6w8GG6Rmc02X+KK4fb4jZtJ9DhXO51tvryXymlhiXu7f8UcsXf+7JKyOyK2e8aNp+9zvF
 yNnjEf8mCMgU9BZ3HEvQA86Tkm3ZXBuoxPkoSzW4Dbtlm3P291/PDl7mo+YdAg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92jD03qXJr2/nokrPKvsOnC5XkZcAtT9TcfkD8xhu4Y=;
 b=B80p19o5kIx0bY1a7GURi14ESly0xx4mXn7U/3aQk/rDR/S5iIAgF1SkAcNIA0ftwBNfcZ
 D82K7YGxRMPx3uFlgj4SRgwH9aFASdPfK3Zv//9pH0FYNhZApmlVslGWfDmZJf13oVRCW9
 SVds7v7vPLk/4E0FOamde9kYtlOShOahVTk0Z3M3fr8SldMkpb7m7j1K5DpHj7QllfZePB
 tDYenS/41Km3zp7iHDvsWsp1jBMBdz9wLgTPIeACuzgJijf0CZ+y6Jl9dMt8ALuFUrdSOt
 0zuQVNRxLNPB71Gvcsf3lHiwAkBzQDF/KIKB1HzY1gAOe0EbahjSXAO304TusQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/19] ARM: dts: renesas: Synchronize R-Car R8A77970 V3M DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:07 +0200
Message-Id: <20230917141319.379939-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 02ba488e0dd626b25e5
X-MBO-RS-META: dbf9mgbkzc7niib5ekjyabs6o3gg55zh
X-Rspamd-Queue-Id: 4RpVKJ4735z9snG
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

Synchronize R-Car R8A77970 V3M DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a77970-eagle.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/r8a77970-eagle.dts b/arch/arm/dts/r8a77970-eagle.dts
index 004a5eacd46..405404c0843 100644
--- a/arch/arm/dts/r8a77970-eagle.dts
+++ b/arch/arm/dts/r8a77970-eagle.dts
@@ -287,6 +287,9 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	avb_pins: avb0 {
 		groups = "avb0_mdio", "avb0_rgmii", "avb0_txcrefclk";
 		function = "avb0";
@@ -316,6 +319,11 @@
 		groups = "scif0_data";
 		function = "scif0";
 	};
+
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk_b";
+		function = "scif_clk";
+	};
 };
 
 &rpc {
@@ -391,3 +399,7 @@
 
 	status = "okay";
 };
+
+&scif_clk {
+	clock-frequency = <14745600>;
+};
-- 
2.40.1

