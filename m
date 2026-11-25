Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B546606A329
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zG8bsT+w;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E0J705AM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FFF84061D;
	Wed, 25 Nov 2026 07:41:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UE_ZqiyP9x5b; Wed, 25 Nov 2026 07:41:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2EA6B40609
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795592492;
	b=oB8Fi/+1Droxz/9wD5GAAtpcDV2OSdPClPpx/MjkKrqTmMlx3ss74nhOXuSLr5hcYtBT
	 NxzUuvHgUanwbQpZlnORdP7e2z11Qq7qtrL4KOJ+bYiX/TMvZzhgC3dSrf7H9j+IWXZ3f
	 qEjfUlokH//J2XwWz32OWuiY0T2MZKhZOXsLl7fgigPkIrbebBZl/h9y4rwk7opm2AwoM
	 JA+pfnXKCFZRA/0KvvVNYcE4w4Kw/eO5O10K+Zv47qabaa6l0ybVMFQ98E/SqzZClXlP3
	 u7RDPWCyTNnpy3Q47D9X4eP1Dx1jOh3SRy+nhhOLpHHIx9+8ZvPSvy9/veDQjiyp6zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795592492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XZ0dczyBMZodesqv5ktDGd38P8NmYbmWyySqlnSW/0c=;
	b=PF0nbBtG9MxZ+TanKvlFXpKckX3SwOFTGUDwpjn89q44TStT7TTPazEfPvz2RBRZwdUR
	 Zf4V23NbyE0A3njQIjnFHIgzM4sFn4ozL1tMXpIKGa8Uwk1JZ1lR9GlwoST54hVyVcKqH
	 Aqsix28OazbeZ2r7IXZkxQQlg4jiZEZOosN1BRSQagc0vJsiwJZgLR8zWazdv117PxjpT
	 tMspOtGqqnZ+rhiHAs6zAkcg4qzzjGuyeFvjFazX1HOrtFzSjuAQzIKVyyC6/30qtgNKY
	 ITNsgbkk5dfc3xo9wE5QMU7EI2vIe6+pBd/3w8zULz+eZ+5PWPpLW54od8W3P9pVTMA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795592492;
	bh=XZ0dczyBMZodesqv5ktDGd38P8NmYbmWyySqlnSW/0c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zG8bsT+wCP5tsIFOoWs1K4EbNz/gBjBYTCoDtvkkAGNnXKUiJJWDkU8xsulrgz907
	 Snz0/sIQHx5RTpeWrB0MRpwbuDzYFRMBDnsGLAWetp9vOsjUCtw6wv3XDOBJeLIXGy
	 jTcKgdQE+cqPb7jUnkdzImRNWjep6A9gGrQcMkVRkyHhS5x2Kl9pUmOpMq7S0fZoFt
	 cqUQz4RPtO2b2GmUgCtxMXoobKhiBNe9WP34EwTrKUZ7OzpG8HsRwr+gcXcmytNgbg
	 zosFDed3MFyK7bsImuh3+N/kfDjlFEmOxqK/LZ2h+HXGaCbeexiSoETW2iQf2FCYpd
	 aZ+B/Zfc6oF5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EA6B40609;
	Wed, 25 Nov 2026 07:41:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5942910B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F1AB80CB0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T1c7ciEh05yc for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 07:41:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB31480C9A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=E0J705AM
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB31480C9A
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:41:28 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so3715878f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 23:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795592487; x=1796197287;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XZ0dczyBMZodesqv5ktDGd38P8NmYbmWyySqlnSW/0c=;
 b=E0J705AMRKfPJ97WbVfcyxPJllsSEArr4Yib5IBJhAA353UvOyljCDFRH9w8DfHDcv
 SLp0YqWU6xzld6KyUt2imLHOme/91MVIARRJiNnL8Xh1DCihFxcODFnrnGV1Tuwi7MPZ
 gwytH2W2XsNsqDuQaDh/giRNGvTQxF7PK2896r1Alm1vNYXTD5VTGjcZI0dtb++ydR2N
 xhVOdp52o3P6+VESf/3Jud3eIAJ9XOyWEHVUib3PGgVOztREJA25IN9olZWiUR7EZYLR
 58Fexta/qvrr+Rvm8VKV+CsAZOl0lHGWBCb3fHsqbT13E32W5XPw8FRebgZbKIPHBsZw
 lNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795592487; x=1796197287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XZ0dczyBMZodesqv5ktDGd38P8NmYbmWyySqlnSW/0c=;
 b=OFN6yr717YjeIIh4u8Xu0Ma9wRfqvK/0LJiRzRwRPoGx/27Y5G6YisU+ggcZAo9UcV
 /6S4sevuKPAuULFDOFJ9bQEQosvQCsuLdJ1O4Kwdk7qOw8XLde5u2Epq9XhnEFBYzMJ4
 +3H3VqVbmXKBZSdnlwQmnCSbqZJcNrXTebeOVMtuvnFd2gMAULwz/gsKnevu9BoPUzWk
 nVyQXkGPT/T1BSXrUWIiMSiRX+ntASOKn9WjIvnVxkRwv2alLKBtAPQErS+rgVZIQFXR
 1MstRZkDW6t384D9I0qFxHQYIwYaXIqZCRqQDIAoeBaveTLxNEVg3UxraSLkVwyyWn83
 qcNg==
X-Forwarded-Encrypted: i=1;
 AL+hErFFeFJgjkaYJA2MyzP0MLnXBUBj6WUON2FR7D7yWVHxsC+fXBVuFVsKUayaKq/tZ/xBd8oOwq0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ZiofZnJK6wATAhjeUwTiYgqctKcFWSS6qjakokAQFVNE6LaZA
 2ysNQstNZiB4pf301vQFNlCfAOBLhf5uKWOq3o+kdOM8XcNVyXQy0iN777NUdYSSXCc=
X-Gm-Gg: AZFdTZe9ArfK9PaoSPVPKnOv9FpqMfj0CFouAytrRuJYPGKzVRgvytOSKQsY9d3w9kS
 q/fbb5HR4SC0q2fVfRRSsdaabJ43lzH0lEkD5rJRBQX2tPqmkwiPyAfO1bVRYaMPB622304BBb6
 cNDsFvSKdurXyC5RUZ4hZx53aGAKx+oDrcEKXmc03zWBUEaY/gJk3uOcGOi0Q0cFWOJ7//aAjvO
 jadcBfH82kGvo3t49iD7NIqix6MDZb3GGu8cE37x32TfJVW9UTK7MYQhcFXcf1W84K2MGSdCHwG
 LL7INQcA2v0r6GuEkzmb9sJFwjzUZI0gZpKGpl+yzBPnlzuLD+RDmlOEYeW9fwyF0vBp351fN8Y
 A0ePzk2uYkttW1CgnVv7EYUMtkpAw1PaUxVdMk+hITS8yL3qEORk9jrshPct0zxUegwZyYwcOGs
 FZ4AfPS5tKlgCOrDCPnZBK+DbIQKTNSMiROiLmdy5eVtisdq4cJchv7DfZmJ+SQx+KUaZ9L7BtL
 d9cLcP/jWWKFV5CmH2LTnS3zYUK++4qJteC/yTUDBlYt/t+19o4YOmFL+hyVfOYWWXpDNugWK/J
 /5fB8EyMHvxelske3rzh4ajvrixXekqAt5CHQSn0DVmBLrEgcPki1bCiXQJJtREQQd23nx4NARv
 DaWpcHL7jxxUG/VLLW9yuxJuiJ18cZLkQawy9oFiW3cyw2UeduQmRYxZ/KN3oS5+CUwzACzunjq
 2WeZYCGnmlrwljkCt37tlN+1aQ7LQq25BlYLGVjee6V1MpvNq5pTSuOKxjJ1x5Gok4l+hxz9jwp
 +XGC5HR/2GBR1Kq14j3sHeOIyI9vgcIsZRh+l4CB5f8HWWnmFuwonza/OLow6MNb5oz9wNIQCli
 Zk+Mec7NbAfFCK0diwPaR5AYzKppIGP+8aOClkMwHcjqRckGJ/rrN5m0y3+cxTw1npgSLQrNlZs
 oX77NVOz0mTaQkMqi/PomcBmqmYO+pY5tIE9ZzoZT0E9nfFfS8xQqRSRSQeVeahHP
X-Received: by 2002:a05:600c:1548:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4bb88800013mr369678375e9.6.1795592486667; 
 Tue, 24 Nov 2026 23:41:26 -0800 (PST)
Received: from hades ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa397asm33296675f8f.48.2026.11.24.23.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 23:41:25 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com,
	richard.henderson@linaro.org
Cc: casey.connolly@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 1/2] arm64: relocate: convert relocate_code to C
Date: Wed, 25 Nov 2026 09:41:19 +0200
Message-ID: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

relocate_code() on arm64 is called from _main with sp and gd already
pointing at the relocated area and lr pointing to the relocated copy of
relocation_return. By that time pie_fixup has already run, if
POSITION_INDEPENDENT is enabled, the image is fixed up and plain C works
fine, like the rest of board_init_f(). So let's convert it to C which is
much easier to read and maintain.

While at it change the behaviour and order of cache maintenance.
Invalidate the I-cache after the D-cache clean instead of before
and add a 'dsb' between 'ic iallu' and the 'isb', which is the
architecturally required sequence.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/lib/relocate_64.S | 96 --------------------------------------
 arch/arm/lib/relocate_64.c | 82 ++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 96 deletions(-)
 delete mode 100644 arch/arm/lib/relocate_64.S
 create mode 100644 arch/arm/lib/relocate_64.c

diff --git a/arch/arm/lib/relocate_64.S b/arch/arm/lib/relocate_64.S
deleted file mode 100644
index 495a5f03ba76..000000000000
--- a/arch/arm/lib/relocate_64.S
+++ /dev/null
@@ -1,96 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * relocate - common relocation function for AArch64 U-Boot
- *
- * (C) Copyright 2013
- * Albert ARIBAUD <albert.u.boot@aribaud.net>
- * David Feng <fenghua@phytium.com.cn>
- */
-
-#include <asm-offsets.h>
-#include <config.h>
-#include <elf.h>
-#include <linux/linkage.h>
-#include <asm/macro.h>
-
-/*
- * void relocate_code(addr_moni)
- *
- * This function relocates the monitor code.
- * x0 holds the destination address.
- */
-ENTRY(relocate_code)
-	stp	x29, x30, [sp, #-32]!	/* create a stack frame */
-	mov	x29, sp
-	str	x0, [sp, #16]
-	/*
-	 * Copy u-boot from flash to RAM
-	 */
-	adrp	x1, __image_copy_start		/* x1 <- address bits [31:12] */
-	add	x1, x1, :lo12:__image_copy_start/* x1 <- address bits [11:00] */
-	subs	x9, x0, x1			/* x9 <- Run to copy offset */
-	b.eq	relocate_done			/* skip relocation */
-	/*
-	 * Don't ldr x1, __image_copy_start here, since if the code is already
-	 * running at an address other than it was linked to, that instruction
-	 * will load the relocated value of __image_copy_start. To
-	 * correctly apply relocations, we need to know the linked value.
-	 *
-	 * Linked &__image_copy_start, which we know was at
-	 * CONFIG_TEXT_BASE, which is stored in _TEXT_BASE, as a non-
-	 * relocated value, since it isn't a symbol reference.
-	 */
-	ldr	x1, _TEXT_BASE		/* x1 <- Linked &__image_copy_start */
-	subs	x9, x0, x1		/* x9 <- Link to copy offset */
-
-	adrp	x1, __image_copy_start		/* x1 <- address bits [31:12] */
-	add	x1, x1, :lo12:__image_copy_start/* x1 <- address bits [11:00] */
-	adrp	x2, __image_copy_end		/* x2 <- address bits [31:12] */
-	add	x2, x2, :lo12:__image_copy_end	/* x2 <- address bits [11:00] */
-copy_loop:
-	ldp	x10, x11, [x1], #16	/* copy from source address [x1] */
-	stp	x10, x11, [x0], #16	/* copy to   target address [x0] */
-	cmp	x1, x2			/* until source end address [x2] */
-	b.lo	copy_loop
-	str	x0, [sp, #24]
-
-	/*
-	 * Fix .rela.dyn relocations
-	 */
-	adrp	x2, __rel_dyn_start		/* x2 <- address bits [31:12] */
-	add	x2, x2, :lo12:__rel_dyn_start	/* x2 <- address bits [11:00] */
-	adrp	x3, __rel_dyn_end		/* x3 <- address bits [31:12] */
-	add	x3, x3, :lo12:__rel_dyn_end	/* x3 <- address bits [11:00] */
-fixloop:
-	ldp	x0, x1, [x2], #16	/* (x0,x1) <- (SRC location, fixup) */
-	ldr	x4, [x2], #8		/* x4 <- addend */
-	and	x1, x1, #0xffffffff
-	cmp	x1, #R_AARCH64_RELATIVE
-	bne	fixnext
-
-	/* relative fix: store addend plus offset at dest location */
-	add	x0, x0, x9
-	add	x4, x4, x9
-	str	x4, [x0]
-fixnext:
-	cmp	x2, x3
-	b.lo	fixloop
-
-relocate_done:
-	switch_el x1, 3f, 2f, 1f
-	bl	hang
-3:	mrs	x0, sctlr_el3
-	b	0f
-2:	mrs	x0, sctlr_el2
-	b	0f
-1:	mrs	x0, sctlr_el1
-0:	tbz	w0, #2, 5f	/* skip flushing cache if disabled */
-	tbz	w0, #12, 4f	/* skip invalidating i-cache if disabled */
-	ic	iallu		/* i-cache invalidate all */
-	isb	sy
-4:	ldp	x0, x1, [sp, #16]
-	bl	__asm_flush_dcache_range
-	bl     __asm_flush_l3_dcache
-5:	ldp	x29, x30, [sp],#32
-	ret
-ENDPROC(relocate_code)
diff --git a/arch/arm/lib/relocate_64.c b/arch/arm/lib/relocate_64.c
new file mode 100644
index 000000000000..6f7a50f2264e
--- /dev/null
+++ b/arch/arm/lib/relocate_64.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * relocate - common relocation function for AArch64
+ *
+ * Adapted from the original asm from:
+ * Albert ARIBAUD <albert.u.boot@aribaud.net>
+ * David Feng <fenghua@phytium.com.cn>
+ *
+ * Copyright (c) 2026, Ilias Apalodimas <ilias.apalodimas@linaro.org>
+ */
+
+#include <elf.h>
+#include <init.h>
+#include <linux/compiler.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/sections.h>
+#include <asm/system.h>
+
+/**
+ * relocate_code() - copy U-Boot to its final location and fix it up
+ *
+ * @dest: destination address, gd->relocaddr
+ *
+ * This is entered from _main in crt0_64.S with sp and gd already
+ * pointing to the relocated area and with lr pointing to the relocated
+ * copy of relocation_return, so returning from here continues execution
+ * in the new image.
+ *
+ * Constraints for this function, since it runs from the old image and
+ * before BSS is usable:
+ * - It must not touch BSS. On arm64 .bss overlays .rela.dyn
+ * - It must not rely on anything that needs relocating in the destination.
+ *   Symbol addresses are generated PC-relative (adrp/add, -fno-pic), so they
+ *   resolve to the runtime location of the currently executing image, which
+ *   is already correct, either because we run at CONFIG_TEXT_BASE or because
+ *   pie_fixup has fixed up the running image in place.
+ * - It must not be instrumented.
+ */
+void notrace relocate_code(ulong dest)
+{
+	u64 src = (u64)__image_copy_start;
+	u64 size = (u64)__image_copy_end - src;
+	const Elf64_Rela *rela = (const Elf64_Rela *)__rel_dyn_start;
+	const Elf64_Rela *rela_end = (const Elf64_Rela *)__rel_dyn_end;
+	u64 sctlr;
+	u64 offset;
+
+	if (src == dest)
+		return;
+	memcpy((void *)dest, (void *)src, size);
+	/*
+	 * r_offset and r_addend are link-time values, so the offset to apply
+	 * is link-to-copy
+	 */
+	offset = dest - CONFIG_TEXT_BASE;
+
+	/*
+	 * We have a makefile check that aborts if reloc entries are not
+	 * R_AARCH64_RELATIVE.
+	 */
+	for (; rela < rela_end; rela++) {
+		if (ELF64_R_TYPE(rela->r_info) != R_AARCH64_RELATIVE)
+			continue;
+		*(u64 *)(rela->r_offset + offset) = rela->r_addend + offset;
+	}
+
+	sctlr = get_sctlr();
+	if (sctlr & CR_C) {
+		__asm_flush_dcache_range(dest, dest + size);
+		__asm_flush_l3_dcache();
+	} else {
+		/* Non-cacheable stores need to complete before we fetch new code */
+		asm volatile("dsb sy" : : : "memory");
+	}
+
+	if (sctlr & CR_I)
+		asm volatile("ic iallu\n\tdsb nsh\n\tisb" : : : "memory");
+
+	/* Always discard anything already fetched/prefetched */
+	asm volatile("isb" : : : "memory");
+}
--
2.53.0

