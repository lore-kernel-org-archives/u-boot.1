Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF904CEBF86
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 00:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE9F8839E4;
	Sun, 16 Nov 2025 01:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KDSrtm21";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NXY2dit2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 554CD839E8; Sun, 16 Nov 2025 01:15:11 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A676839DF
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 01:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d8BGN6cnnz9tJt;
 Sun, 16 Nov 2025 01:15:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=COfNAFz2s440dc/6Iime7Az9kdv/GOo2g1XW+scsj4E=;
 b=KDSrtm21zc92ppIB4g6UeSm/ALSW8VW5BjrGOwhE/LAl0GvGDguuU8OSXZf9MAjq3eWxp5
 d13PPLLOoA4c0XB6BzJi6fnwJTGrM/OxYDGQCqB95GiEm74mOEg2BJF7AYOoaaSVEHqNLD
 wTFGDMT1dwkTn8xT0qZ/M17nh8FuGSUHou++sc415R4xOEcshI83OEyEj6nU5Gw8GmabTM
 sQ6xvFGcRDdd7bOt4K4bV03nfBImF/KTAKg1NDpvnp/wCXSkzO9eecm0mzayfOFJeJzqVm
 NzKyyaIVD9hAeRHYNyju813f7qm3vABGg63ZntTqEwj8pLBSynxi52/VaF0ZgQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NXY2dit2;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=COfNAFz2s440dc/6Iime7Az9kdv/GOo2g1XW+scsj4E=;
 b=NXY2dit2NPSaB3fIgakJaKii5pwrFRrn8U6FzN3xaZGAIpH7vZVra0pLOb1SUYrfd/5jg2
 3d1dKwIn25tb+nW47b+AxIwpwGn2rVeeLS+oQhCupRLPvkKe6Jw2T4ubyFx+F5pxadDWfq
 3rqwP1f2Mw0MA2uAkWrM3Oyw1ZaHelvgpXSn0Mvm5TLOphKn/z0xip7R8ACoOaaLZUdiOD
 AwtJL5CeQds3fZqRzRb6FEGAFU9ddOG2dUg95QhYwysmdZD2MM1BCR91cfv8ICFkfz8Z73
 xZS1NaCsVbNnXCqT8xf43JkiTkVXkTzXTJ2SbnPCdsGgCpxfhlZuJmuYnBubVQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xtensa: Assure end of U-Boot is at 8-byte aligned offset
Date: Sun, 16 Nov 2025 01:14:32 +0100
Message-ID: <20251116001455.674808-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: addbd3eabaf51e5e547
X-MBO-RS-META: m6bs3yow7i6ws51s4mbcdxt6dqc9n8qx
X-Rspamd-Queue-Id: 4d8BGN6cnnz9tJt
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

Make sure the end of U-Boot is at 8-byte aligned offset, not 4-byte
aligned offset. This allows safely appending DT at the end of U-Boot
with the guarantee that the DT will be at 8-byte aligned offset. This
8-byte alignment is now checked by newer libfdt 1.7.2 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/xtensa/cpu/u-boot.lds         | 2 +-
 arch/xtensa/include/asm/ldscript.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/cpu/u-boot.lds b/arch/xtensa/cpu/u-boot.lds
index 72e4b9a706e..6894d4c327b 100644
--- a/arch/xtensa/cpu/u-boot.lds
+++ b/arch/xtensa/cpu/u-boot.lds
@@ -78,7 +78,7 @@ SECTIONS
   SECTION_text(XTENSA_SYS_TEXT_ADDR, FOLLOWING(.DoubleExceptionVector.text))
   SECTION_rodata(ALIGN(16), FOLLOWING(.text))
   SECTION_u_boot_list(ALIGN(16), FOLLOWING(.rodata))
-  SECTION_data(ALIGN(16), FOLLOWING(__u_boot_list))
+  SECTION_data(ALIGN(16), FOLLOWINGDT(__u_boot_list))
 
   __reloc_end = .;
   __init_end = .;
diff --git a/arch/xtensa/include/asm/ldscript.h b/arch/xtensa/include/asm/ldscript.h
index bcf0fd5a744..50d3b390405 100644
--- a/arch/xtensa/include/asm/ldscript.h
+++ b/arch/xtensa/include/asm/ldscript.h
@@ -21,6 +21,9 @@
 #define FORCE_OUTPUT	. = .
 #define FOLLOWING(sec)							\
 	AT(((LOADADDR(sec) + SIZEOF(sec) + ALIGN_LMA-1)) & ~(ALIGN_LMA-1))
+#define ALIGN_LMA_DT	8
+#define FOLLOWINGDT(sec)						\
+	AT(((LOADADDR(sec) + SIZEOF(sec) + ALIGN_LMA_DT-1)) & ~(ALIGN_LMA_DT-1))
 
 /*
  * Specify an output section that will be added to the ROM store table
@@ -110,6 +113,7 @@
 		___u_boot_list_start = ABSOLUTE(.);			\
 		KEEP(*(SORT(__u_boot_list*)));				\
 		___u_boot_list_end = ABSOLUTE(.);			\
+		. = ALIGN(ALIGN_LMA_DT);				\
 	}
 
 #define SECTION_data(_vma_, _lma_)					\
@@ -130,6 +134,7 @@
 		*(.eh_frame)						\
 		*(.dynamic)						\
 		*(.gnu.version_d)					\
+		. = ALIGN(ALIGN_LMA_DT);				\
 		_data_end = ABSOLUTE(.);				\
 	}
 
-- 
2.51.0

