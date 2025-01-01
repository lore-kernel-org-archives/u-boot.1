Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5717FE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 19:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D6F80317;
	Wed,  1 Jan 2025 20:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qffO7I7s";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R0q3btNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091FC80379; Wed,  1 Jan 2025 20:19:49 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C33800D7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 20:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YNfmL3Vlnz9vCd;
 Wed,  1 Jan 2025 20:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735759186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=B1PIoHpLKPD3LiF1V/gFf/L+wFuqf7eEkHjMTOuqmvE=;
 b=qffO7I7s4wMAUx+dNr20b/ulRac/hnTWuo51yZkc51DIv7LO1ZqQNjfWZ4iA8Jd4e88Ymh
 t+3LNpcK4AKq4DR8LIcwqxrsGGqFazGhMiQHvr4SiLnN1GpKJnLn2qsdIVlUFAswBz0lVm
 kkz2FcZw6DPh61Cwb/4qXtIUHQvV4J99hiq9Mz5grmbezhHIfityUmzeCuqa75/Sb12BOF
 BfrTWzRt8fJVeSWVJLsuIhmeei9CFMFSpqjcRgr4f5AcwPXqfZ/VE70nAv90QzIq+Ni2B7
 iV2eIAgrd29ZcmAMdxh21iEPgH79yKEyDe0ShPYwH+eNOV5Ww25d/qj8dI7wuQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735759184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=B1PIoHpLKPD3LiF1V/gFf/L+wFuqf7eEkHjMTOuqmvE=;
 b=R0q3btNpbJzYr4jN2zmV9RfcxGXdUaYJ4srYTsKTu57i3ibGT8DrI5rrjP551IGlmovBOG
 s4zw4l99PKaHeeVO4MFiGwPxIWm0slb8r1Ax/EfP1uuVWuGDR0NiNpfgFW90wi6uk5j0SV
 FVHzQnR9mPNIHnDGoA+c+tvZ5NVkDiBKW4K1RkUgtKE/W0sVw4ThbITn7y1nZVR1mRJTOb
 SwY9Ggd0UubNTxWOR0JaNCPp6EO2q4i8owfWxrLNDrvutQ5NYzqFnCAzC7WdeCa2fLPEZ/
 30hs0aJru10u4JZhsL5NU54iWAbydoOSC92LxUKM/6PwqrK2Ty6yd7DNNK1Dtg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/3] arm64: Convert core type check macros into inline
 functions
Date: Wed,  1 Jan 2025 20:19:04 +0100
Message-ID: <20250101191920.25317-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cd98b879d1390de2f54
X-MBO-RS-META: 1heeosqkj4g4a5b1cw5q79o1k9dngdcu
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

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
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
V2: - Rebase on u-boot/next
    - Add RB from Paul and Peter
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

