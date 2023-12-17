Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0098DC41535
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 00:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381DF87B52;
	Sun, 17 Dec 2023 01:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XY0j+Bjf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hu7fJ6Yq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09A28797F; Sun, 17 Dec 2023 01:34:00 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C520D87775
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 01:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4St3qB27ynz9sWC;
 Sun, 17 Dec 2023 01:33:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702773238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J6Yb54dI+NCcZOvjbk6QC/oAnHb36NFGhSvXv2GQvMM=;
 b=XY0j+BjfLPJz2HF0x/G+lg9MfvkHUEUD+U/dfxgxA1sFh7LmhkSwrUDHDeJfmOoGv9puiL
 F6U9DLyhRGmUfJ6BRBFLBvI5R9aAx8kTVMMnsoLnoOJp/aevU+xlOdR1i0sCuFDKhBf1hn
 yZ4B6C0ySWU9pJtcIvbJFb38uh9GIg3HwN91NkbeEcZ2scJSGx93yDlE8dTiIPdOW1pFqy
 ym7V9vQdebYPR7tM4QJ12eWBZ8IQNTi87qU1k/1N/X68AazACiE5N0vwaunSkRDsmPXz+E
 laJh+bPwJ9MeH5ZFdbRjLhlXpKG0T6X7rqZlH8pgxBoBE9+nzJY2OWV4RDjG4w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702773236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J6Yb54dI+NCcZOvjbk6QC/oAnHb36NFGhSvXv2GQvMM=;
 b=hu7fJ6YqoLuG/5eMivU8CyFp2ayLwOtqPEI97yP+Z/dkJfCtBAF0Im4Zl2WOaAZ/2yE7Qr
 hMU8tdaCIbLL7FMv0pu2ULRJc8kaer8j1JNmDkcM2w3srBSqh/iFTBR4scrmMs1rW4pk+f
 1BSw16Vg9EQCSQEzWrCDyTq6cR5KLfHcoG5fZ0UsCBh51NRA5lVSjq1tv6uJ7d40cZhS4k
 qaMESQetH4dZ8AkKtomnZxW/BSxJiYCzu+8u7xrGIC1BQj2088XNy4uiiIpiF2eZ3BJz1U
 3KJutWmEvGvhxyQma2WG6HfUx7ZxFDOTLqfDWcAqakzV4Mn1qyNryrnfM/KK/g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] arm: Add OVERLAY command to BSS section on ARM64
Date: Sun, 17 Dec 2023 01:33:39 +0100
Message-ID: <20231217003347.194657-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dc8d787f1d36b24b261
X-MBO-RS-META: roduz9xo356hypq98xiqeezuhbzoz8pd
X-Rspamd-Queue-Id: 4St3qB27ynz9sWC
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

Avoid allocating and loading the BSS section.

$ aarch64-linux-gnu-objdump -Sh u-boot

Before:
  10 .bss_start    00000000  00000000000f21d8  00000000000f21d8  001021d8  2**0
                   CONTENTS, ALLOC, LOAD, DATA
  11 .bss          000068f8  00000000000f2200  00000000000f2200  001021d8  2**6
                   ALLOC
  12 .bss_end      00000000  00000000000f8af8  00000000000f8af8  00108af8  2**0
                   CONTENTS, ALLOC, LOAD, DATA

After:
  10 .bss_start    00000000  00000000000bf990  00000000000bf990  001021e0  2**0
                   CONTENTS
  11 .bss          000068e8  00000000000bf990  00000000000bf990  001021e0  2**4
                   CONTENTS
  12 .bss_end      00000000  00000000000c6278  00000000000c6278  00108ac8  2**0
                   CONTENTS

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Replicate arch/arm/cpu/u-boot.lds BSS part verbatim
---
 arch/arm/cpu/armv8/u-boot.lds | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index fb6a30c922f..ebdc079552d 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -151,16 +151,18 @@ SECTIONS
 
 	. = ALIGN(8);
 
-	.bss_start : {
+	.bss_start __rel_dyn_start (OVERLAY) : {
 		KEEP(*(.__bss_start));
+		__bss_base = .;
 	}
 
-	.bss : {
+	.bss __bss_base (OVERLAY) : {
 		*(.bss*)
 		 . = ALIGN(8);
+		 __bss_limit = .;
 	}
 
-	.bss_end : {
+	.bss_end __bss_limit (OVERLAY) : {
 		KEEP(*(.__bss_end));
 	}
 
-- 
2.43.0

