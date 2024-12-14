Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E831FE7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 22:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D8E80087;
	Sat, 14 Dec 2024 23:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UQjOZl3s";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Mz1lT2qY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1386380083; Sat, 14 Dec 2024 23:44:05 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACDDE8006C
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y9h8L39Ldz9slc;
 Sat, 14 Dec 2024 23:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vtbiBsg9yLeU9qzCAg2NzZSmXOav9Oi16XicVJK8Pek=;
 b=UQjOZl3silS+OPUq4iK4glhQMWh79ZVzFAY+O/EFE28CHWnBWkzlCznvY53YG2i82J0pLT
 C+DRrL/kIed2eRXYU8MLfiEwcwWaq/JLkAZsmTYD+6y7PHV+iY7Zjo01Kik+Z8QFqMgu/b
 WbP0MwRSX/76XwK9YoHN1+6oXlCMDht4nmLLFrgJnza6365eKvAwG6V2ky5jqDejxgAPmr
 /SOMvKD8M9pV7MTxtWls2rbtDbtyEAfNH/PDUijeN77ou0VqZfosIC1H2Gz1iUQCLuueCk
 YJq3IwW4q523CuBKYMlhFsoc89h1Yua+6URrzR4m8LUdkWfxdGTq1MCw6E2i8g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vtbiBsg9yLeU9qzCAg2NzZSmXOav9Oi16XicVJK8Pek=;
 b=Mz1lT2qYGWSp1FNtO5YNjE/lIC7JUsdEpT3YXJFSCevQN68ynvqmoYWShfGJ0gZ1gtTSGL
 j4f5bNHiO6FZ6lWNEWFbSyBrp3yJm7K8dDr3DWxu9D4zxhlWj6Ukpb4IwCnDnWZLVRTVxC
 9qQljb2xfKQhoGgOJ5AM5MkpwJx7HCXZwpbHE48Oo8bbhzZBkW0vnbI49L5t/RlxQRxPK5
 FcW/q4bD794fi7QzRCpZcmgoRkh0sJ4kQcKb0f9XuesMASsNR1QKIcK9dK6lQMj0xznqLi
 bY2X6rJ/bfB8cPeV3g3DkjlehpYA6emS6zcLZhpvDJZwDLg05zFFvGGYSYJs/A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] arm64: Convert core type check macros into inline
 functions
Date: Sat, 14 Dec 2024 23:42:46 +0100
Message-ID: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mod1nkmr6enc8e6rkmzt1tuk8gtcsigh
X-MBO-RS-ID: 433b679a28ff0c5d7a7
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

Turn the core type check macros into inline functions to perform
better type checking on them. The inline functions get optimized
out in case they are not used. Indent the MIDR_PARTNUM_CORTEX_An
macros in preparation for addition of future three-digit cores
and use MIDR_PARTNUM_SHIFT in MIDR_PARTNUM_MASK to be consistent.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/armv8/cpu.h | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/armv8/cpu.h b/arch/arm/include/asm/armv8/cpu.h
index 40d54dc85ab..aa1470bb72d 100644
--- a/arch/arm/include/asm/armv8/cpu.h
+++ b/arch/arm/include/asm/armv8/cpu.h
@@ -3,11 +3,11 @@
  * Copyright 2018 NXP
  */
 
-#define MIDR_PARTNUM_CORTEX_A35	0xD04
-#define MIDR_PARTNUM_CORTEX_A53	0xD03
-#define MIDR_PARTNUM_CORTEX_A72	0xD08
-#define MIDR_PARTNUM_SHIFT	0x4
-#define MIDR_PARTNUM_MASK	(0xFFF << 0x4)
+#define MIDR_PARTNUM_CORTEX_A35		0xD04
+#define MIDR_PARTNUM_CORTEX_A53		0xD03
+#define MIDR_PARTNUM_CORTEX_A72		0xD08
+#define MIDR_PARTNUM_SHIFT		0x4
+#define MIDR_PARTNUM_MASK		(0xFFF << MIDR_PARTNUM_SHIFT)
 
 static inline unsigned int read_midr(void)
 {
@@ -18,9 +18,15 @@ static inline unsigned int read_midr(void)
 	return val;
 }
 
-#define is_cortex_a35() (((read_midr() & MIDR_PARTNUM_MASK) >> \
-			 MIDR_PARTNUM_SHIFT) == MIDR_PARTNUM_CORTEX_A35)
-#define is_cortex_a53() (((read_midr() & MIDR_PARTNUM_MASK) >> \
-			 MIDR_PARTNUM_SHIFT) == MIDR_PARTNUM_CORTEX_A53)
-#define is_cortex_a72() (((read_midr() & MIDR_PARTNUM_MASK) >>\
-			 MIDR_PARTNUM_SHIFT) == MIDR_PARTNUM_CORTEX_A72)
+#define is_cortex_a(__n)					\
+	static inline int is_cortex_a##__n(void)		\
+	{							\
+		unsigned int midr = read_midr();		\
+		midr &= MIDR_PARTNUM_MASK;			\
+		midr >>= MIDR_PARTNUM_SHIFT;			\
+		return midr == MIDR_PARTNUM_CORTEX_A##__n;	\
+	}
+
+is_cortex_a(35)
+is_cortex_a(53)
+is_cortex_a(72)
-- 
2.45.2

