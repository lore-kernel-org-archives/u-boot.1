Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58853E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47DE8894C6;
	Sun,  8 Dec 2024 23:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="woC5ABGh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bUGDD8U5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74432893AE; Sun,  8 Dec 2024 23:06:24 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5469C893B4
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Y5zbf0fmMz9sdQ;
 Sun,  8 Dec 2024 23:06:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IE7+XAQvRJ2/qy37GjzY87Qy2NkHBG0n5gRBoz/ugto=;
 b=woC5ABGh27RvrOJB7vC/QvQc935EXi12GfgyuxZKXp4N6Ziz/UGI7q2iidqleJJgGca6eA
 mqtArH6mVu3iDmVH3azqgA6zyJZK4keOqbd/Xt5pMhW1H09fI+z92JrZjeDTL0CS1+SXGB
 ohtvnft5OKVV/BYSPKzpR/q902JwGRx9X3Vnwx3r9Heau6J46x/x/euqKh6jIWpBOWBXa3
 2yTJ23vDrriCKC3+zAYdHn7HAfJpRcFhXlj8dGdIZIA7OSBlsBA6Vlh8j0z1+7uJV8PxpA
 //98o8/ZWqmliMQUhq2w7WUn8hqh9NtUQkjilTDfH3/Di9TTF66xU1LE8e1z5g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IE7+XAQvRJ2/qy37GjzY87Qy2NkHBG0n5gRBoz/ugto=;
 b=bUGDD8U5+ilmaPhDlX4FiFsv/bXE539Qe3cHKOSpO11zJ5t6Jmf4CBkrGyeZ375L4I0iu7
 3pRdNEnoRXgVF+2HVPuSp1nygDKMt+jXtW9iUNKMpgwrvHMkmR4NnfxNTUI5q3t9Druxdd
 2XKwhO1mAFu9HLZxsm4MmjvztYhk1WWCE8QxgHpeJiAcmGZm+jx67hbI+SIqY1n3a8HkqR
 Eyksi6G1+3l4ySrAiMWw/Z8o5TBmgISu5e2OJ5/nl7mXB3JPCS8EjNApGbXcjaGV5WlhEk
 RZEmgcS6lEvPVf4yZSAWz5bGpLbrORcQ32IcFcQI/hGhWbHC+2ryCu/TGQ/Ivw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/13] ARM: dts: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:03:54 +0100
Message-ID: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o8zaszxrxbs3dtketj8krstc7m18krkq
X-MBO-RS-ID: 895e32792ba140c0cfa
X-Rspamd-Queue-Id: 4Y5zbf0fmMz9sdQ
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

