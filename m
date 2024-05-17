Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26312C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2446788231;
	Fri, 17 May 2024 18:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="BdDcwsDn";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IAa0AnI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCC7188495; Fri, 17 May 2024 18:33:03 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215A5883AE
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id F1903138151F;
 Fri, 17 May 2024 12:32:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 17 May 2024 12:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715963578;
 x=1716049978; bh=UTtplPzUqAAnXA3gIcMX+WjturFYm70ZmvfOxDiOo4o=; b=
 BdDcwsDnl/bxzIY5NsOq4y1heUiYPSddIxzYMjsMEE8KLoKxsHQ9KYKr8+gpmy1t
 5x8zPGMdFjcwVaALRYMYCSeOcjG4IE+4xrMA4yMd3KtJE65k0PSHeDynusSNXPt9
 7FrqjaTm1rZesIaI0c2tayX69Asfa8t1BZmzzMy+SyIiKTrQEqNjLCQeeBsV2rj7
 51WbhlbvyPR2t1yZR3Xnj4HHT69kUsHukI/kxdJYbgD/3kKK0CZCQ5wTuF3Xs1lN
 BtWUAAZ9wzoYiUaYAWk3L6rYe1vlVOvfTuJQk2SAdwpFpd+Lp8+PhP0pJXc0ReZ0
 H/ZcSWyFC0dK+IFousJRWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715963578; x=
 1716049978; bh=UTtplPzUqAAnXA3gIcMX+WjturFYm70ZmvfOxDiOo4o=; b=I
 Aa0AnI6Ht40ctMbTe3vntiuJIh0gXnv+pQaBrO5odQ6ao8fQgjbMrjdHZZF5zYke
 lDk2DV2jrkhpZhP7sMtOX7tCFHQ7uB+FKASJI3X8vAtSoEuV8Los69zcHmYD5ggp
 LT+yD4TJlGYYrLMxtiSrNPQD1oaibFko+jJ2LoiJQxYStSsk7ejtnjSqPg0UP/e9
 8CSrb/8fxWtEV4jSA/ZI9s+BfrUCmr4yLdPuxCFyIz/d+/BUlppABRY9Ta9LAwYT
 f9d6xXQFA6B1H2zO1fKBjpdpnqCSai8FabK8KyPvvABXysdyGF0Alwn9jt00EYpq
 dTsuviniDEOKjuP5kT/vQ==
X-ME-Sender: <xms:uoZHZo52VuMWnanwMcVwrhsCH_8QTcoc5dcwcWPpbHsinB659OFk4w>
 <xme:uoZHZp4qMjFbxxiEaYcBgdxdkH3N-cC--3X-Ns1pfWRQ8k0KATedIFjWllF82lMe0
 xox2OaUoz7VKUcWucE>
X-ME-Received: <xmr:uoZHZndxrkms5YaiCbeCtVFgaO-owZA2ghKMcNzDH7LDnV5_KZFzBJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnheptedugfejffegudejtdfghefhudeiueekudffgffhleeuffeh
 gfehhfeggfeliefgnecuffhomhgrihhnpehsvghtjhhmphefvddrshgspdhsvghtjhhmph
 eigedrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:uoZHZtKlzikdzrhDQCU_od91g9lXQaNe3P_cic0u1OwzicwoBi4jhA>
 <xmx:uoZHZsIK06sSOiS7S-DFT85kqaEi6OY46g-K5mDaLC6Ktg9bjoJWNA>
 <xmx:uoZHZux8RGyIrZOyHDcoZA7Yto6V3sUNUWfhq1dXTfn7DfAQfXHj3w>
 <xmx:uoZHZgLKkuVZxrRkup4VNZ-Z9hCQ9ow-KbtvM4nz09Qtz3yeu_20jQ>
 <xmx:uoZHZk-bpgkm62-I87XirDup3SMF1NRoU0P8x_pE3MjN0VhkgBECYPWZ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 12:32:57 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 17:32:52 +0100
Subject: [PATCH 1/7] MIPS: Implement setjmp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mips-efi-v1-1-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4368;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=c5fmE1JivIUnmAvFBgx4FAotkjI3drufCzQ3puwpF5k=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3th33XodeOa+xM7BiidV9SbHmvOrVjf+qxLzv/Bapy
 GxzYXreUcrCIMbBICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABMx9WNkOBHUu1rhy/UDa7nC
 JrK+niHy+kg0c8j5iV81goR0Izg7oxn+Fy+ZGTX57dv2tOJ971Zubj5XqjNtVrjCmbd+XaEVO+p
 3cwIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Implement setjmp with o32/n64 ABI's standard stack frame.
Note that those two ABIs slightly disagreed on placement of
registers so they are being implemented in two different
files.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/setjmp.h | 36 +++++++++++++++++++++++++++
 arch/mips/lib/Makefile         |  2 ++
 arch/mips/lib/setjmp32.S       | 51 ++++++++++++++++++++++++++++++++++++++
 arch/mips/lib/setjmp64.S       | 56 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)

diff --git a/arch/mips/include/asm/setjmp.h b/arch/mips/include/asm/setjmp.h
new file mode 100644
index 000000000000..afa2ffb007e6
--- /dev/null
+++ b/arch/mips/include/asm/setjmp.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef _SETJMP_H_
+#define _SETJMP_H_	1
+
+/*
+ * This really should be opaque, but the EFI implementation wrongly
+ * assumes that a 'struct jmp_buf_data' is defined.
+ */
+#if __mips == 64
+struct jmp_buf_data {
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long fp;
+	unsigned long gp;
+	unsigned long s_regs[8];	/* s0 - s7 */
+};
+#else
+struct jmp_buf_data {
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long s_regs[8];	/* s0 - s7 */
+	unsigned long fp;
+	unsigned long gp;
+};
+#endif
+
+typedef struct jmp_buf_data jmp_buf[1];
+
+int setjmp(jmp_buf jmp);
+void longjmp(jmp_buf jmp, int ret);
+
+#endif /* _SETJMP_H_ */
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 1621cc9a1ff9..e36dfd0547b5 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -10,6 +10,8 @@ obj-y	+= reloc.o
 obj-y	+= stack.o
 obj-y	+= traps.o
 
+obj-$(CONFIG_32BIT) += setjmp32.o
+obj-$(CONFIG_64BIT) += setjmp64.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
diff --git a/arch/mips/lib/setjmp32.S b/arch/mips/lib/setjmp32.S
new file mode 100644
index 000000000000..4a2661d29249
--- /dev/null
+++ b/arch/mips/lib/setjmp32.S
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/regdef.h>
+
+.pushsection .text.setjmp, "ax"
+ENTRY(setjmp)
+	sw      ra,  0(a0)
+	sw      sp,  4(a0)
+	sw      s0,  8(a0)
+	sw      s1, 12(a0)
+	sw      s2, 16(a0)
+	sw      s3, 20(a0)
+	sw      s4, 24(a0)
+	sw      s5, 28(a0)
+	sw      s6, 32(a0)
+	sw      s7, 36(a0)
+	sw      fp, 40(a0)
+	sw      gp, 44(a0)
+
+	move	v0, zero
+	jr	ra
+ENDPROC(setjmp)
+.popsection
+
+.pushsection .text.longjmp, "ax"
+ENTRY(longjmp)
+	lw      ra,  0(a0)
+	lw      sp,  4(a0)
+	lw      s0,  8(a0)
+	lw      s1, 12(a0)
+	lw      s2, 16(a0)
+	lw      s3, 20(a0)
+	lw      s4, 24(a0)
+	lw      s5, 28(a0)
+	lw      s6, 32(a0)
+	lw      s7, 36(a0)
+	lw      fp, 40(a0)
+	lw      gp, 44(a0)
+
+	beqz	a1, 1f
+	move	v0, a1
+	jr	ra
+1:
+	li	v0, 1
+	jr	ra
+ENDPROC(longjmp)
+.popsection
diff --git a/arch/mips/lib/setjmp64.S b/arch/mips/lib/setjmp64.S
new file mode 100644
index 000000000000..6f615bb10014
--- /dev/null
+++ b/arch/mips/lib/setjmp64.S
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2006 - 2008, Intel Corporation. All rights reserved.
+ * Copyright (c) 2017 Lemote Co.Ltd
+ * 	Author: Heiher <r@hev.cc>
+ * Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/regdef.h>
+
+.pushsection .text.setjmp, "ax"
+ENTRY(setjmp)
+	sd	ra, 0x00(a0)
+	sd	sp, 0x08(a0)
+	sd	fp, 0x10(a0)
+	sd	gp, 0x18(a0)
+
+	sd	s0, 0x20(a0)
+	sd	s1, 0x28(a0)
+	sd	s2, 0x30(a0)
+	sd	s3, 0x38(a0)
+	sd	s4, 0x40(a0)
+	sd	s5, 0x48(a0)
+	sd	s6, 0x50(a0)
+	sd	s7, 0x58(a0)
+
+	move	v0, zero
+	jr	ra
+ENDPROC(setjmp)
+.popsection
+
+.pushsection .text.longjmp, "ax"
+ENTRY(longjmp)
+	ld	ra, 0x00(a0)
+	ld	sp, 0x08(a0)
+	ld	fp, 0x10(a0)
+	ld	gp, 0x18(a0)
+
+	ld	s0, 0x20(a0)
+	ld	s1, 0x28(a0)
+	ld	s2, 0x30(a0)
+	ld	s3, 0x38(a0)
+	ld	s4, 0x40(a0)
+	ld	s5, 0x48(a0)
+	ld	s6, 0x50(a0)
+	ld	s7, 0x58(a0)
+
+	beqz	a1, 1f
+	move	v0, a1
+	jr	ra
+1:
+	li	v0, 1
+	jr	ra
+ENDPROC(longjmp)
+.popsection

-- 
2.34.1

