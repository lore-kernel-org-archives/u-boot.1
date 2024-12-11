Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBECE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 423A28021C;
	Wed, 11 Dec 2024 08:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aUbqAFOX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ngFJqJjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 593CA801FD; Wed, 11 Dec 2024 08:32:34 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A548801FD
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Y7S3z5szHz9sxX;
 Wed, 11 Dec 2024 08:32:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WCdN1OmIvZM5pPDUqm1rD0OdHcFcEuihV173MtLOJVA=;
 b=aUbqAFOXtZkNlf5uf5FYEEINCp4arAFk00Zlkv4DMMKjcwdCoOirtwGaUSrPIt++Ya58/S
 XdvNKrG1ILXWcm0wiHLHrbZNsMTnbXNj0XTJnHqadYjHiHGgwegZ/dbLY+9hCJ5b56+db0
 yBfBkQe1njdErGz36/E+NVSRME1aByn9hlPLiPeik0PDclO+n38oxqlhw2GP8PGhKbCgP+
 VHZBH/EtHPa6DXtCGGuDfARw0Qeafbct9Z/sa+Rvyl7rYZAexenU6kEImewYgen6AlvBH+
 N+fnV0gLxjMoEtHoEy2iF/r6kc5EYij/YO1kwE7Yl2hPZ4of/TMKliJT/A1jkA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WCdN1OmIvZM5pPDUqm1rD0OdHcFcEuihV173MtLOJVA=;
 b=ngFJqJjglg8+rpKqpULLHbc7tCpCpBtT843VZjDR5BSeQjusa2/tRrSw8i274lItBWdk/E
 BKXArMf66dZ55mUef4Kaymj6U8kQRbyHt3Jb0iTDl3o4uEECfVIDoer6Zyg4FOiRd3VDCz
 kP4rrzQgMXuef3i8Mi/wAF6LsUera5BOGvyl8akm1fiU2tkXVTOOB84nGI/VuL0pGdL1NP
 ZoQVKtDaqSsoaLiCfHdQQCO/DcMpOgXvN9s/EK/sVZp0TLEvwIklvJbqo+2RE8Hc7GHLUX
 RF+GauEFDQVsE0IeFRJdoMf6gFDppA4TGe/gHTWg0LT1pdoypjIzkvJ81Jb2Rw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/13] ARM: dts: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:25 +0100
Message-ID: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ado3izhf1x79pikab169i3qmt58sq9n8
X-MBO-RS-ID: 77e3332df8207f3503a
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

The correct spelling is R-Car, including the dash, update the usage.
Comment change only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 arch/arm/dts/r8a7790-u-boot.dtsi  | 2 +-
 arch/arm/dts/r8a7791-u-boot.dtsi  | 2 +-
 arch/arm/dts/r8a7792-u-boot.dtsi  | 2 +-
 arch/arm/dts/r8a7793-u-boot.dtsi  | 2 +-
 arch/arm/dts/r8a7794-u-boot.dtsi  | 2 +-
 arch/arm/dts/r8a77951-u-boot.dtsi | 2 +-
 arch/arm/dts/r8a77960-u-boot.dtsi | 2 +-
 arch/arm/dts/r8a77965-u-boot.dtsi | 2 +-
 arch/arm/dts/r8a77970-u-boot.dtsi | 2 +-
 arch/arm/dts/r8a77980-u-boot.dtsi | 2 +-
 arch/arm/dts/r8a77990-u-boot.dtsi | 2 +-
 arch/arm/dts/r8a77995-u-boot.dtsi | 2 +-
 arch/arm/dts/r8a779x-u-boot.dtsi  | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/dts/r8a7790-u-boot.dtsi b/arch/arm/dts/r8a7790-u-boot.dtsi
index 45e2fa6f9f0..2a7d76bd7b1 100644
--- a/arch/arm/dts/r8a7790-u-boot.dtsi
+++ b/arch/arm/dts/r8a7790-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A7790 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A7790 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a7791-u-boot.dtsi b/arch/arm/dts/r8a7791-u-boot.dtsi
index 7143ffc1658..bb0e2fd106c 100644
--- a/arch/arm/dts/r8a7791-u-boot.dtsi
+++ b/arch/arm/dts/r8a7791-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A7791 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A7791 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a7792-u-boot.dtsi b/arch/arm/dts/r8a7792-u-boot.dtsi
index 214cfde1f89..ebbdcb7efd5 100644
--- a/arch/arm/dts/r8a7792-u-boot.dtsi
+++ b/arch/arm/dts/r8a7792-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A7792 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A7792 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a7793-u-boot.dtsi b/arch/arm/dts/r8a7793-u-boot.dtsi
index fb947462c54..08f2248e1f3 100644
--- a/arch/arm/dts/r8a7793-u-boot.dtsi
+++ b/arch/arm/dts/r8a7793-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A7793 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A7793 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a7794-u-boot.dtsi b/arch/arm/dts/r8a7794-u-boot.dtsi
index 53b54c88917..303afaeb4ce 100644
--- a/arch/arm/dts/r8a7794-u-boot.dtsi
+++ b/arch/arm/dts/r8a7794-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A7794 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A7794 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a77951-u-boot.dtsi b/arch/arm/dts/r8a77951-u-boot.dtsi
index 4cbec591479..c16c5116592 100644
--- a/arch/arm/dts/r8a77951-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A7795 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A7795 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a77960-u-boot.dtsi b/arch/arm/dts/r8a77960-u-boot.dtsi
index 15a91474324..2245be2aa76 100644
--- a/arch/arm/dts/r8a77960-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A7796 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A7796 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a77965-u-boot.dtsi b/arch/arm/dts/r8a77965-u-boot.dtsi
index 54107d1ae35..f39acc237d3 100644
--- a/arch/arm/dts/r8a77965-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A77965 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A77965 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a77970-u-boot.dtsi b/arch/arm/dts/r8a77970-u-boot.dtsi
index d252c2e8e6c..7900c641ba1 100644
--- a/arch/arm/dts/r8a77970-u-boot.dtsi
+++ b/arch/arm/dts/r8a77970-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A77970 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A77970 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a77980-u-boot.dtsi b/arch/arm/dts/r8a77980-u-boot.dtsi
index 9f7bf499bc0..aa7e058c585 100644
--- a/arch/arm/dts/r8a77980-u-boot.dtsi
+++ b/arch/arm/dts/r8a77980-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A77980 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A77980 SoC
  *
  * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a77990-u-boot.dtsi b/arch/arm/dts/r8a77990-u-boot.dtsi
index 50bbbe18647..b701f68db81 100644
--- a/arch/arm/dts/r8a77990-u-boot.dtsi
+++ b/arch/arm/dts/r8a77990-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A77990 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A77990 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a77995-u-boot.dtsi b/arch/arm/dts/r8a77995-u-boot.dtsi
index 347b59ac42c..f4bafb6d088 100644
--- a/arch/arm/dts/r8a77995-u-boot.dtsi
+++ b/arch/arm/dts/r8a77995-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar R8A77995 SoC
+ * Device Tree Source extras for U-Boot on R-Car R8A77995 SoC
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/arch/arm/dts/r8a779x-u-boot.dtsi b/arch/arm/dts/r8a779x-u-boot.dtsi
index 001ac59adb9..d1441f1f9df 100644
--- a/arch/arm/dts/r8a779x-u-boot.dtsi
+++ b/arch/arm/dts/r8a779x-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source extras for U-Boot on RCar Gen3
+ * Device Tree Source extras for U-Boot on R-Car Gen3
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
-- 
2.45.2

