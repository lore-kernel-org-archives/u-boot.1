Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F29C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF6187B8E;
	Thu, 14 Dec 2023 19:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hxqzmkWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6032087B7A; Thu, 14 Dec 2023 19:17:11 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30FC187B73
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5cd81e76164so82049657b3.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577827; x=1703182627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/0eI15i1UHQJyWb68/UPispkNF2G4oad4GiabD71SvQ=;
 b=hxqzmkWZxtaW9ODnqyV4CKYdsSaFTMbZkiRpsKobghq+wFRjaXoXFYlRGRtFcoMpCJ
 2MRRaIyXHEP61G04CP2ktLuJtZX+88RLTNHOrmcSWgJERsQdTA/GuD0Yzg0PEq0fFcR8
 HuKgZDpJv1XwHeUA7Dx72JM39SdZahBTRiBko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577827; x=1703182627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0eI15i1UHQJyWb68/UPispkNF2G4oad4GiabD71SvQ=;
 b=FwUmlaSub+cBNGAk0F6+IGrA/ZgsdV89IUE1dWUsh9w0qHqnDwb1OjLfwI3W/lDCVe
 8gNMxCmVTHbbJkjqVa6ktyZHLGhmCHRfpfqjYcycmWjcdaB1yg9N3F831QRXcnWxmZmj
 75Mdxbh27skfyHwPQ56Px8Yo5K7NjmIs4tlQ9kTMGeiXP5bGJow2zxLqiILR2KS9zqRW
 NMVKSye+ZUyRHLf8ouv2a3Ndudi5RA5iR8FgbU34FqdGPelTnWjMLwfQTNaDR8n34Cao
 SchjP9qohDNySqqndzw+/Agdb3qH9DK/xQUvv+TCJf6mAWLmkd5wNS6Qf/2EPsyyyxc0
 MXXA==
X-Gm-Message-State: AOJu0Yw1gd4MorD+J8LKvNLU7o38fNrUCbxb4DUOAraoy8/Yk5XWsOz6
 4pRYcmDruMCKrhPYBzoWdn69u9vcRtXdphmtbio=
X-Google-Smtp-Source: AGHT+IGbTH3iztlGG/SCPxgGOWqlIbhipZeYaEEis3QoYuc6FFO+QasfDsSut2QlnRzKbaH0v69sxQ==
X-Received: by 2002:a0d:f682:0:b0:5d7:1940:dd84 with SMTP id
 g124-20020a0df682000000b005d71940dd84mr9705919ywf.90.1702577827608; 
 Thu, 14 Dec 2023 10:17:07 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.06
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v2 10/16] global: Rework architecture global_data.h to include
 <linux/types.h>
Date: Thu, 14 Dec 2023 13:16:52 -0500
Message-Id: <20231214181658.3359902-10-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
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

In most cases, the architecture global data currently makes use of
assorted linux types, but does not include <linux/types.h> to provide
them. Add <linux/types.h> instead of relying on indirect inclusion.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Update include/system-constraints.h and board/cssi/cmpc885/sdram.c
---
 arch/mips/include/asm/global_data.h    | 2 +-
 arch/nios2/include/asm/global_data.h   | 2 ++
 arch/powerpc/include/asm/global_data.h | 1 -
 arch/riscv/include/asm/global_data.h   | 1 +
 arch/x86/include/asm/global_data.h     | 1 +
 board/cssi/cmpc885/sdram.c             | 1 +
 include/system-constants.h             | 2 ++
 7 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/global_data.h b/arch/mips/include/asm/global_data.h
index f0d3b07bf1eb..34b7e0bed945 100644
--- a/arch/mips/include/asm/global_data.h
+++ b/arch/mips/include/asm/global_data.h
@@ -7,8 +7,8 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
+#include <linux/types.h>
 #include <asm/regdef.h>
-#include <asm/types.h>
 
 struct octeon_eeprom_mac_addr {
 	u8 mac_addr_base[6];
diff --git a/arch/nios2/include/asm/global_data.h b/arch/nios2/include/asm/global_data.h
index 1a0e7d25fa3b..b56e8a5078e0 100644
--- a/arch/nios2/include/asm/global_data.h
+++ b/arch/nios2/include/asm/global_data.h
@@ -6,6 +6,8 @@
 #ifndef	__ASM_NIOS2_GLOBALDATA_H_
 #define __ASM_NIOS2_GLOBALDATA_H_
 
+#include <linux/types.h>
+
 /* Architecture-specific global data */
 struct arch_global_data {
 	u32 dcache_line_size;
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 43d71f5caec0..f7860122a00b 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -8,7 +8,6 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
-#include <config.h>
 #include <linux/types.h>
 
 /* Architecture-specific global data */
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index 937fa4d15446..d00247ad9536 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -10,6 +10,7 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
+#include <linux/types.h>
 #include <asm/smp.h>
 #include <asm/u-boot.h>
 #include <compiler.h>
diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index 6f4a7130f1da..1ef7f1f0349e 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -9,6 +9,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
 #include <asm/processor.h>
 #include <asm/mrccache.h>
 
diff --git a/board/cssi/cmpc885/sdram.c b/board/cssi/cmpc885/sdram.c
index 11a50c3a52d6..828784bd368e 100644
--- a/board/cssi/cmpc885/sdram.c
+++ b/board/cssi/cmpc885/sdram.c
@@ -4,6 +4,7 @@
  * Charles Frey <charles.frey@c-s.fr>
  */
 
+#include <config.h>
 #include <linux/sizes.h>
 #include <linux/delay.h>
 #include <init.h>
diff --git a/include/system-constants.h b/include/system-constants.h
index d688629f119b..e09fc418a47c 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -3,6 +3,8 @@
 #ifndef __SYSTEM_CONSTANTS_H__
 #define __SYSTEM_CONSTANTS_H__
 
+#include <config.h>
+
 /*
  * The most common case for our initial stack pointer address is to
  * say that we have defined a static intiial ram address location and
-- 
2.34.1

