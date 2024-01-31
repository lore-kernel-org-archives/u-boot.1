Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5822EC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 13:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36DAE87CE9;
	Wed, 31 Jan 2024 14:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bQjYMSzO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DAD887C39; Wed, 31 Jan 2024 14:34:06 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64AF087CE9
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 14:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 29F1461769;
 Wed, 31 Jan 2024 13:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D2DC433B1;
 Wed, 31 Jan 2024 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706708042;
 bh=yeH/71lmv8PvqvHk15MdyBdXQ4aHXKUziEDWcD69Kec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bQjYMSzOpuD1kKqM4TnCco28flwmoRMUWjaabjEkIQVm0Di5li7cGhABnIGBcDyBZ
 AIpZ2ABvDv6m7k7yZxJysswaYCNN6o8yODd47d2c2fs6c00guFlC9/K5ke44bbWbow
 1HDXMeqCKu8TexmQ1aieUOiwahLjLr49lvnI7S3s8M0BgaVfJj1zqGtanpVzeahuz7
 Y0JH4wEu/9pFrs4L0+hBKxYy1YjM4RrH/L/YnpkMQ8OKm+L62wJbkyOLbjsFWYHqFE
 Pk5aWtWafYm7JTUM4gE9muSQAT0c3REH7Wv1DRxOO3RSDXt8qsB4ZEOmG3vOp2OS7O
 fBi/Adp1j3m6Q==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, s-vadapalli@ti.com, srk@ti.com, r-gunasekaran@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 3/3] arm: dts: k3-u-boot: Add missing "bootph-all" property to
 MUX nodes.
Date: Wed, 31 Jan 2024 15:33:48 +0200
Message-Id: <20240131133348.182987-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131133348.182987-1-rogerq@kernel.org>
References: <20240131133348.182987-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

As it is present for USB and USB won't work without the MUX
initialized correctly, add "bootph-all" property to MUX nodes.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am642-sk-u-boot.dtsi                | 4 ++++
 arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi | 8 ++++++++
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi                | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index f3ed376ab7..ea200a1ee1 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -184,6 +184,10 @@
 	bootph-all;
 };
 
+&serdes_ln_ctrl {
+	bootph-all;
+};
+
 &usbss0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index b77f8d92de..9433f3bafa 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -93,6 +93,14 @@
 	bootph-all;
 };
 
+&serdes_ln_ctrl {
+	bootph-all;
+};
+
+&usb_serdes_mux {
+	bootph-all;
+};
+
 &main_usbss0_pins_default {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 370fe5190b..fff447094a 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -89,6 +89,14 @@
 	bootph-all;
 };
 
+&serdes_ln_ctrl {
+	bootph-all;
+};
+
+&usb_serdes_mux {
+	bootph-all;
+};
+
 &main_usbss0_pins_default {
 	bootph-all;
 };
-- 
2.34.1

