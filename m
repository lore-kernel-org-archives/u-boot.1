Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E0AC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0EC98772E;
	Sat, 16 Dec 2023 19:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="THj5Mh7t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I9Ndng2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 697D787738; Sat, 16 Dec 2023 19:08:55 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5305C8772A
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SsvGr68z6z9spP;
 Sat, 16 Dec 2023 19:08:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702750132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7U52xFCUxtrtP63DIbJUH/x9iBB4i4Ia4mHADY0HF7s=;
 b=THj5Mh7tCZOLHVbDUMEqpBXQQQSz5r4EMmIbwfGWSRN6ixTPhFV0YHDNKqjSyD7/VfyJvh
 RHG0vX8fv17u3N3VG6QfBXZp5zhezCEO7S5PJxCyXu/Sj1PPO6KgKfsBxwsGat54yuyDs4
 fYeNcd5Gb+GTcfqF4lNgg1s/i1zGqhMOWd64mrUg+CpmzgSxRm7V9hFdmhLXQUmab/wNb+
 d7kciolms+QZ33nOB5yTZVuSyXTMIChcpK7720byiXRrph4noR5OoD1QAV3vdZDirmpATC
 YqAcoyfEn6M/qY6qS1egQOjREn8ekcQhTO6jXGGSgyuKcZnDe3IOH4uVsbx9mQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702750131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7U52xFCUxtrtP63DIbJUH/x9iBB4i4Ia4mHADY0HF7s=;
 b=I9Ndng2sx2Q+4ZTU2gE3VcTIHogfVhxY1yzVjipsskPv+bvDGXXVlDcBgirgYhe61+wpsz
 ghjlbH4wsaGYrJO797BCEDgf60I4les3QUW4QC2OZ9OkHtOZbapTlFwbVRYcR8/RqVuCfC
 AEONLiEgAseEiFxiq2nsW0ROnVE0p+Fa9Sb+OJYazf/ZlpKdMeHkOn6+I+nbzQLA+7zxQj
 6crnexShc2dS06pwgKlIqE37YHWhNeGnAoLKcjeQer1WQUuwcFlLv/VQXvxup9/kwZ6bfv
 kXMJK9O5Hmob3hjNYs1mUWERE0B9pb0gpM79GQ3QHXJPPsTEJ9O6SdBhEboEuw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: Add OVERLAY command to BSS section
Date: Sat, 16 Dec 2023 19:08:22 +0100
Message-ID: <20231216180842.173422-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: znpbw9e5gipxrk43wr1mdbgu45k9i3gc
X-MBO-RS-ID: 40c121a93468155cbd8
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
  10 .bss_start    00000000  00000000000f21d8  00000000000f21d8  001021d8  2**0
                   CONTENTS
  11 .bss          000068f8  00000000000f2200  00000000000f2200  00102200  2**6
                   CONTENTS
  12 .bss_end      00000000  00000000000f21d8  00000000000f21d8  00108af8  2**0
                   CONTENTS

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/cpu/armv8/u-boot.lds | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index fb6a30c922f..25838b9892c 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -151,16 +151,16 @@ SECTIONS
 
 	. = ALIGN(8);
 
-	.bss_start : {
+	.bss_start (OVERLAY) : {
 		KEEP(*(.__bss_start));
 	}
 
-	.bss : {
+	.bss (OVERLAY) : {
 		*(.bss*)
 		 . = ALIGN(8);
 	}
 
-	.bss_end : {
+	.bss_end (OVERLAY) : {
 		KEEP(*(.__bss_end));
 	}
 
-- 
2.43.0

