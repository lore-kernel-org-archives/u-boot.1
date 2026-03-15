Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E110F30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C4084114;
	Mon, 16 Mar 2026 00:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T5KS8VMx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HKC3xw75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0578E841C2; Mon, 16 Mar 2026 00:50:58 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7D08408D
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fYw332FgTz9sxL;
 Mon, 16 Mar 2026 00:50:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/3vEMjsYEhVTZdJTKjBoF6f46TV8NzVt5C4493PHXus=;
 b=T5KS8VMxaicCKz3gmORdGF9vRLFsm0zxNqDP9Xcn9doxauAexJzN6LIdkxYKf5YDbcqi6b
 juxX/wxk43Cg3X14TL6WxQBLdZPP5AxZgW8x7P7tinSR9vHmITqoDBwuMNNy1pJ8NRwJDq
 ZVnlEE6mcYtoiFKd3mgwvGK/Zxvfa8ZnVeWzt2R7qLHn3Z1INRA04C4vO6iPS6Qf2lmMKp
 rFIUhqZaYvKVZIaRtjwreE2uyav+Oi2ZNNjNVNHAQ+DaCqS9T8ISm7PkVG9HRq9obU6uWO
 opOAEWmnZvUJhE4rfu3dhs1kDR87tdhXo9yiG78EdaW0xoefMBK1aIrLtkyshw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/3vEMjsYEhVTZdJTKjBoF6f46TV8NzVt5C4493PHXus=;
 b=HKC3xw75LB2tK8QmueQ8Yzm+4iXOiw+jlPToCmD7v2h1Y4jEFCtyWXuYIPVu5/Fd6zyS51
 km1Gff8JR8bfw45Dow3VDSGy5yX3Cx36OrFowTGOwNgFVWoVffXyqkHcj2ZQ2UDn6W9W2h
 1q4Zz9LPrEz+5qAJUB114Kp8lLubyJ+qUsA9ghOFP9h92CjzUwZqDWim7rnwGuY3qBEjMZ
 6CWWUa7YKn718UVjQ/ZPrzEo2heLPsKQxr5q3DnmeMWlM3IviRiTQmHrhgkHVQWcINsMLn
 d32k4utc6ibI03+fZdCWc7Ezm1I3ZmFtdJ8uL0yegg+DmmfconTJEOB5iIX6Yg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: Introduce current_pl() on ARM32 and compatibility
 current_el()
Date: Mon, 16 Mar 2026 00:50:33 +0100
Message-ID: <20260315235046.304489-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xk98q6ew7w5udcb3adt3q94ocdx81rfp
X-MBO-RS-ID: f8e0f59b7933c08f05d
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

The ARM32 has PLx Privilege Levels instead of Exception Levels present
on ARM64. Introduce current_pl() function which reports the current PL
on ARM32.

Introduce current_el() for ARM32 as well and current_pl() for ARM64
which each call the other matching function. This is mainly mean to
allow code like this to compile and retain compile time code coverage:

if (IS_ENABLED(CONFIG_ARM64) && current_el() != 3) { ... }
if (!IS_ENABLED(CONFIG_ARM64) && current_pl() != 0) { ... }

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/system.h | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 4c1b81483c9..9e3ad57073d 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -171,6 +171,12 @@ static inline unsigned int current_el(void)
 	return 3 & (el >> 2);
 }
 
+static inline unsigned int current_pl(void)
+{
+	/* Aarch32 compatibility */
+	return current_el();
+};
+
 static inline unsigned long get_sctlr(void)
 {
 	unsigned int el;
@@ -466,6 +472,39 @@ static inline int is_hyp(void)
 #endif
 }
 
+static inline int is_usr(void)
+{
+	return (get_cpsr() & 0x1f) == 0x10;
+}
+
+static inline unsigned int current_pl(void)
+{
+	/*
+	 * ARM DDI 0406C.d ID040418 , page 140 chapter A3.6.1 "Processor
+	 * privilege levels, execution privilege, and access privilege",
+	 * clarifies the PLx levels as follows (abbreviated):
+	 * The characteristics of the privilege levels are:
+	 * - PL0 - The privilege level of application software, that
+	 *         executes in User mode.
+	 * - PL1 - Software execution in all modes other than User mode
+	 *         and Hyp mode is at PL1.
+	 * - PL2 - Software executing in Hyp mode executes at PL2.
+	 */
+	if (is_hyp())	/* HYP */
+		return 2;
+
+	if (is_usr())	/* USR */
+		return 0;
+
+	return 1;	/* The rest */
+}
+
+static inline unsigned int current_el(void)
+{
+	/* Aarch64 compatibility */
+	return current_pl();
+};
+
 static inline unsigned int get_cr(void)
 {
 	unsigned int val;
-- 
2.51.0

