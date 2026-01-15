Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F90D4662B
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13AD082BF2;
	Thu, 15 Jan 2026 23:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gkErAbvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1101883A2D; Thu, 15 Jan 2026 23:28:48 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09EA83923
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cfd0f2ef93so643463a34.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516124; x=1769120924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCbTRh6x2sg64HysMU25Tc3XViWMz/fs9tlw77iGPXU=;
 b=gkErAbvNW1qGlIR4EmnZLWJ3AtTrKsQl1r8MmrhEEHUbBBVQ+YN/+HYh/cOiep/6qi
 SexJ6S1Iye+UC2MhI/c/hO6oDKSeih2EtJz0uETX7uwDe0dy3d0RUsUOJdwnTTdL94dK
 3oyNLz/uniS7vC8YdsalrJh0Xrp0XcxeIBmJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516124; x=1769120924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NCbTRh6x2sg64HysMU25Tc3XViWMz/fs9tlw77iGPXU=;
 b=N1R0MIbto4TfdAwoErsaTmQj7N4halO6KmA2We9Arexc3r/34ceykVt6cMbgncqbqX
 OAXZz6kGhxU2ki9BKOQJWuFK25GYi3iTV09cX5zmhIgcezaImCRGD8aBJTSbJOYJ1WRS
 actn0gSU5IX50aFxHgUntqih3PFThqay2v5mQQ/zLDARELHFCVcYKFS1XeAghW6r4vWQ
 Mz9eEbSEFIBYlLMqkJ5pj7ETY5dIAqC2O5PusJ7t+fq3C8kh+TbQQ2cfuA7WbcKtLbSV
 IZAevsvjyg+B/iBjT+/fbcR/TU+Ui5YgX9B1iZDqpa2F7aSsJ1a9dsgtcb8vF/3MwY1y
 swjA==
X-Gm-Message-State: AOJu0YyaOiqT3pObDjaClDDCRm5sUxU/DYrQcxFN7n+7m2HMXdNvgTaK
 z1T/iUFgtAMS1PnBYjMU5kPiSmcwyyGjg+lOfb0YCw2jR2mx47vWrhcYAVyyFjgmHn+5DAbFq/Y
 xMjsDKZs=
X-Gm-Gg: AY/fxX4gkT26ZmlmhOliaEEiCVEGYZ1NUthmEDY6rU7RFT7ieIRRGy2L51jvde4E3wk
 iEH+JcwxyIxM0JDQjHksiTAivcOzW4wJXi28FjzwAuHp7rmrmXL3A/PtHs6mhV8HuiidpNKkSXB
 Ryr4yJX/rcSF4tluc8fz/Okdh/L1NZjhhIs5LmdXVh59IGtjiPf04Jzvk5uBmxkaK1WNiDT2+GB
 vteDDcz6zFqJTVm5NrSf00mB/kB9dRVZ469rDk6070TlukpSbQrTmBGoj5wl1XP5/VYa0j5z6FM
 zBmpITCwpB1lbJEhLeZSQNGxO4TM/lOpvGgjWLQnR5XslYmUpmOHLikonWKIpRVp+D23ZpD1KgM
 +46xOh2cDX+Vo12RpgOV47mZ7t9/6N9/ye8rMAts6opwbcUrVcIzDGJAg18KHHGO/0iMcGZMZTx
 uLP/cKLhc4YK9DZmz1ZFr5AGyUI8Sfy0Uuoh3sAy889rrqupfwLeqWPHpOpgdlW6LBnnT1hP9aw
 E+11vWzlvQz3McdZ/m8uRaMwlg+w3LhT4k8YYsNR6qNa0E6r0pz
X-Received: by 2002:a05:6830:7304:b0:7c7:1c87:4f95 with SMTP id
 46e09a7af769-7cfded3d675mr518874a34.4.1768516124628; 
 Thu, 15 Jan 2026 14:28:44 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 10/10] x86: Update linker scripts to ensure appended device
 tree is aligned
Date: Thu, 15 Jan 2026 16:19:40 -0600
Message-ID: <20260115222828.3931345-11-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
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

With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
that we must have ALIGN(x) statements inside of a section to ensure that
padding is included and not simply that the linker address counter is
incremented. To that end, this patch:
- Rewrite the '.rel.dyn' (u-boot.lds) to follow modern practices, and
  include the 8-byte alignment at the end of the section.
- Expands the '.dynamic' section (u-boot-64.lds) to be more readable
  when adding a second statement to the section.
- Aligns the final section before _end (for U-Boot) or _image_binary_end
  or __bss_end (for xPL phases) by 8-bytes by adding '. = ALIGN(8);' to
  the final section before the symbol or changing an existing ALIGN(4)
  statement.
- Ensure that we do have alignment by adding an ASSERT so that when not
  aligned we fail to link (and explain why).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/x86/cpu/u-boot-64.lds  |  6 ++++--
 arch/x86/cpu/u-boot-spl.lds | 10 +++++++++-
 arch/x86/cpu/u-boot.lds     | 11 ++++++-----
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86/cpu/u-boot-64.lds b/arch/x86/cpu/u-boot-64.lds
index 00a6d8691211..0c353c5d7401 100644
--- a/arch/x86/cpu/u-boot-64.lds
+++ b/arch/x86/cpu/u-boot-64.lds
@@ -86,9 +86,11 @@ SECTIONS
 	__rel_dyn_end = .;
 	. = ALIGN(4);
 
-	.dynamic : { *(.dynamic) }
+	.dynamic : {
+		*(.dynamic)
+		. = ALIGN(8);
+	}
 
-	. = ALIGN(4);
 	_end = .;
 
 	.bss __rel_dyn_start (OVERLAY) : {
diff --git a/arch/x86/cpu/u-boot-spl.lds b/arch/x86/cpu/u-boot-spl.lds
index 50b4b1608552..57cdce6d7515 100644
--- a/arch/x86/cpu/u-boot-spl.lds
+++ b/arch/x86/cpu/u-boot-spl.lds
@@ -68,7 +68,7 @@ SECTIONS
 		__bss_start = .;
 		*(.bss*)
 		*(COM*)
-		. = ALIGN(4);
+		. = ALIGN(8);
 		__bss_end = .;
 	}
 	__bss_size = __bss_end - __bss_start;
@@ -97,3 +97,11 @@ SECTIONS
 #endif
 
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
+
+#if !CONFIG_IS_ENABLED(SEPARATE_BSS)
+ASSERT(__bss_end % 8 == 0, \
+       "__bss_end must be 8-byte aligned for device tree");
+#endif
diff --git a/arch/x86/cpu/u-boot.lds b/arch/x86/cpu/u-boot.lds
index c418ff44aa08..ea070acd6a15 100644
--- a/arch/x86/cpu/u-boot.lds
+++ b/arch/x86/cpu/u-boot.lds
@@ -79,13 +79,12 @@ SECTIONS
 	. = ALIGN(4);
 	.dynsym : { *(.dynsym*) }
 
-	. = ALIGN(4);
-	__rel_dyn_start = .;
-	.rel.dyn : {
+	.rel.dyn ALIGN(4) : {
+		__rel_dyn_start = .;
 		*(.rel*)
+		__rel_dyn_end = .;
+		. = ALIGN(8);
 	}
-	__rel_dyn_end = .;
-	. = ALIGN(4);
 	_end = .;
 
 	.bss __rel_dyn_start (OVERLAY) : {
@@ -120,3 +119,5 @@ SECTIONS
 #endif
 
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
-- 
2.43.0

