Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E541BE7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16D648056A;
	Sat, 21 Dec 2024 22:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QwZghCgF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UAdGXatu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3D680586; Sat, 21 Dec 2024 22:35:14 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A52803A9
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YFyHf40Jzz9st5;
 Sat, 21 Dec 2024 22:35:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DzuxHe4OH1uV5YLgWD2chjHtpY+Smrz/uIMBhmUd3wo=;
 b=QwZghCgFdy+FO2fDZBM3LkeZ4jePzgRQrvqZyD6EchsjBW5DpcUeH9nhjV/MxxH5SN3Pu0
 l3s3Cv378QqAyAbFPhUmvBTJLaSRrhG5SG3yYqcCIXNjHA4Rsz76jvoWmLwrREVD31PI58
 HXnsu2zhuJPi/NEN/ZOopJGzO0zVYMu7Q/IfosUWZZbGxEwBkFr+YiylG5wDtyUqAihPWV
 zonGX1uU/7kSpd52ZTwwQo3G4jPAsgUIaqEk3q9auOsAWWlFkhmD7yTLr1iTrm3jjCOdH0
 BN+e3jN18ANaemcgrHwPmbVYsqplTH7kYLyEzdskNXrRAD/EqUwR6Fs2UGmYvg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734816908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DzuxHe4OH1uV5YLgWD2chjHtpY+Smrz/uIMBhmUd3wo=;
 b=UAdGXatuIDxiCQn8r5hxtkMH1YDv6NLLcYXuY1R8uZ+tNiA9zR6lNEAdu9ql943HchqZnh
 WL2dspcDMV6JcYreuTkszTbu3vAE0/69ftLKQr4cowATVFEMSLjteF/cfbRnbovIVUttsa
 +wA4hmoogkb4R7GofWhniMk1Nh0Bqz3dnkpvpNsfpiO9k7p7gN7wZiUksWA4XdDH5y26JJ
 b+LuP8BgLIqffwwx7Sbp8uwb1T7LtaIgqdrktm5ITfF40BaAAz41MQQRkb4cDc0v6RQrkN
 cf4OvoG/dEl5/I9fsOl6sJJVMTuzTs70B2fhB3mPaBfQeWbQIJVg2i3aO83r5A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/16] pinctrl: renesas: Add Kconfig symbol for conditional
 build of full PFC tables
Date: Sat, 21 Dec 2024 22:34:00 +0100
Message-ID: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sfni5gceyajzat7fo7wt9bxhhwoogf63
X-MBO-RS-ID: 619ababc6069160ec87
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

By default the pin multiplexing tables used by U-Boot are reduced
to keep the size of the bootloader low. This option allows build of
full pin multiplexing tables the same way they are included in the
Linux kernel. This includes pin multiplexing options for Audio, CAN,
CANFD, DU, INTC, INTC-EX, MSIOF, PWM, SSI, for which there is no
U-Boot driver. This option is disabled by default.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/renesas/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 57e88604aa2..49845b6d8d4 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -11,6 +11,18 @@ config PINCTRL_PFC
 	  both the GPIO definitions and pin control functions for each
 	  available multiplex function.
 
+config PINCTRL_PFC_FULL
+	bool "Renesas pin control drivers (full size)"
+	depends on PINCTRL_PFC
+	default n
+	help
+	  By default the pin multiplexing tables used by U-Boot are reduced
+	  to keep the size of the bootloader low. Enable this option to use
+	  full pin multiplexing tables the same way they are included in the
+	  Linux kernel. This includes pin multiplexing options for Audio, CAN,
+	  CANFD, DU, INTC, INTC-EX, MSIOF, PWM, SSI, for which there is no
+	  U-Boot driver.
+
 config PINCTRL_PFC_R8A7790
 	bool "Renesas RCar Gen2 R8A7790 pin control driver"
 	depends on PINCTRL_PFC
-- 
2.45.2

