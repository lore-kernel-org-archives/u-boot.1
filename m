Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EADF606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G0SgNmjI;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=cE9pGWaj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE62281148;
	Wed, 18 Nov 2026 01:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CaSJFDPRVV8n; Wed, 18 Nov 2026 01:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1655081134
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965183;
	b=EggwSu/if9SSbN81rUFaH8duM6L9Doybi69sgdxrNjfstk/qfSBymXWoDBAVCDYVn/mB
	 9eLMht8CSNgVGmL8t357Ya5x3yN8n1xHOnxeI7t/x9n+PZ24lRIC7zQQyPTiZk64IfwqZ
	 LNueoXCr8BWhA+u4wF9GHEoH8vlGrjQfxMcohG/WFMueVM9lTMUN+pNY2PCV6UXeUihEx
	 73ihe5z8aD7bL1QXVX43W6H1Zeb7A/lmyB6daEGdPAGQ0X/Gl3rEHgq9wAKfRpKJLVHR5
	 kVAwgcca7GN9kEhX71wIccX6h9xLLnFDvJuyv39BNzG6PoJP7ymRA+Ez3QKQc7IRiwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965183;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ruxY6WCqLJ0Z9YyL1PM3J43sYIjPFX4aDLKuYAPA29c=;
	b=bZ9fNPdMbHOn8I6SiYRQZGnnm9TcJOh4MRodbHnTY9rYnTY6HddjISabflQFoaUyfMRr
	 cnaHRlHkPiP86KR3TQfahB7AJEvJrxYnKj5ojAsTvEb84WOCTgileUsvTTt6c8b3Ty06G
	 sXqkSMXT3dCbZdORSX3/7/yeP4GNLlkwW9I0ohEwW9wgYpco7FZY2Kg9pqIvzdTPl1Mn+
	 iOD243q+N0BYcj8gkjRz0uZIly8GXkYItjz1YpK+BlChCmeRL3xFsElosYG5q0f3oDAGh
	 lvCn8+pSo/aMg90bf96nHn+LTue68zMBZ301x7X8/ZFlXxxBm5RYCVSot1qtmQxmnjQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965183;
	bh=ruxY6WCqLJ0Z9YyL1PM3J43sYIjPFX4aDLKuYAPA29c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G0SgNmjIwdrcDMr9FN57ugDAPR4B4PamQqTsZennFXn6NLJH9hqo7SxX1Wted9SJb
	 ZVj0s+yqGD61OoflWl8tEz7LEecLMp3tgPZFOmCfb9AlZ1B3mZufN5KSbgS+/eBXiX
	 2S2WuXJwpKMUALu4RY8LQCQ4ixhKigks8tNTt3ZxDwOBet9uq1lIYHUDQJvQ6QiEny
	 bcGpZcRedtGuQR4i7VWKAOYSpfJS20scmicSy47Y94AgU2GKFfxE35jQFRQmPLWpR2
	 MIXLGLfsdSoSSgugz+opvrL2KtF8HI5M83vvGhGgveiHawTYav6IYP4lHNMss2jAI1
	 cA2XbLNwylL9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1655081134;
	Wed, 18 Nov 2026 01:26:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DDA382FB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB167605DE
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNORAlIaGCbk for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 23:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 02108605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=774fa3f08=romain.caritey@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=cE9pGWaj
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02108605DA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794959830; x=1826495830;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jzTXwTBjDt3dtqU3i/dVgO3sxS5kKsiVjLrmG5BBZBU=;
 b=cE9pGWajqwa6uAIsuk7uafqiY0Z/xSHXPNBkhyl+EE7rRlnpb9vSfPKE
 GcDuPtiy7y11ejNz2UuXULeRZE/V/x3VoQ0VW8w6uLOto+mgx8bt2THXw
 gkc2XmQAQQuqbLUTqeZ0Xoy82fPaq0px80H3tDbemYnTH5CyVoI4+UuWE
 z9Iw7tb18q/XtyUtfHjUSJKh8X0DQTLVL9QtFEjTbdOBT6+JM0vryEfrW
 P+PWl6Dw6TZ/yQmwg9F62X2NaNgmg5MGEdGD5jcJwCLDBBfws7d0YUTv5
 9xLFB709iT47ODH2UiTXI1x3xtlWpEdqCQfZa/0bsQEySRxXTjGc92FAe Q==;
X-CSE-ConnectionGUID: WIXGLGGvQKaztswwFIyVsg==
X-CSE-MsgGUID: ACK0D78eSq+sdh24Wb2eBA==
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="298078455"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 17 Nov 2026 16:56:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 17 Nov 2026 16:56:03 -0700
Received: from bby-cbu-c71245.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 17 Nov 2026 16:56:02 -0700
From: Romain Caritey <romain.caritey@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Leo Liang <leo.liang@sifive.com>, "Tim
 Ouyang" <tim609@andestech.com>
CC: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 <charles.perry@microchip.com>, <mamemaria.mbaye@microchip.com>, "Romain
 Caritey" <romain.caritey@microchip.com>
Subject: [PATCH 3/4] riscv: start.S: move .rela.dyn processing to a subroutine
Date: Tue, 17 Nov 2026 15:54:12 -0800
Message-ID: <20261117235433.3601945-4-romain.caritey@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117235433.3601945-1-romain.caritey@microchip.com>
References: <20261117235433.3601945-1-romain.caritey@microchip.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 18 Nov 2026 01:25:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot proper is linked with -static -pie, so the linker only emits
R_RISCV_RELATIVE dynamic relocations, which checkriscvreloc now
enforces. The symbol-based branch of the fixup loop, handling
R_RISCV_32/R_RISCV_64 through .dynsym, is therefore dead code. It is
also incorrect for undefined weak symbols, which would be turned into
the relocation offset instead of staying NULL.

Drop it, as done on ARM where only R_ARM_RELATIVE/R_AARCH64_RELATIVE
are handled, and move the remaining loop to an apply_relocation
subroutine taking the offset to apply in a3. This allows the same code
to be reused to relocate U-Boot before board_init_f().

The relocation table is now read from the running image instead of
the copy, which holds the same data, and the offset is computed from
CONFIG_TEXT_BASE, which is equal to the run-time address of _start for
all current users. No functional change.

Signed-off-by: Romain Caritey <romain.caritey@microchip.com>
---
 arch/riscv/cpu/start.S | 77 +++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 46 deletions(-)

diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 72032b77ef9..7cf6384b647 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -20,16 +20,10 @@
 #define LREG			lw
 #define SREG			sw
 #define REGBYTES		4
-#define RELOC_TYPE		R_RISCV_32
-#define SYM_INDEX		0x8
-#define SYM_SIZE		0x10
 #else
 #define LREG			ld
 #define SREG			sd
 #define REGBYTES		8
-#define RELOC_TYPE		R_RISCV_64
-#define SYM_INDEX		0x20
-#define SYM_SIZE		0x18
 #endif
 
 .section .data
@@ -315,46 +309,9 @@ copy_loop:
  * Update dynamic relocations after board_init_f
  */
 fix_rela_dyn:
-	lla	t1, __rel_dyn_start
-	lla	t2, __rel_dyn_end
-	beq	t1, t2, clear_bss
-	add	t1, t1, t6		/* t1 <- rela_dyn_start in RAM */
-	add	t2, t2, t6		/* t2 <- rela_dyn_end in RAM */
-
-6:
-	LREG	t5, REGBYTES(t1)	/* t5 <-- relocation info:type */
-	li	t3, R_RISCV_RELATIVE	/* reloc type R_RISCV_RELATIVE */
-	bne	t5, t3, 8f		/* skip non-RISCV_RELOC entries */
-	LREG	t3, 0(t1)
-	LREG	t5, (REGBYTES * 2)(t1)	/* t5 <-- addend */
-	add	t5, t5, t6		/* t5 <-- location to fix up in RAM */
-	add	t3, t3, t6		/* t3 <-- location to fix up in RAM */
-	SREG	t5, 0(t3)
-	j	10f
-
-8:
-	lla	t4, __dyn_sym_start
-	add	t4, t4, t6
-
-9:
-	srli	t0, t5, SYM_INDEX	/* t0 <--- sym table index */
-	andi	t5, t5, 0xFF		/* t5 <--- relocation type */
-	li	t3, RELOC_TYPE
-	bne	t5, t3, 10f		/* skip non-addned entries */
-
-	LREG	t3, 0(t1)
-	li	t5, SYM_SIZE
-	mul	t0, t0, t5
-	add	s5, t4, t0
-	LREG	t0, (REGBYTES * 2)(t1)	/* t0 <-- addend */
-	LREG	t5, REGBYTES(s5)
-	add	t5, t5, t0
-	add	t5, t5, t6		/* t5 <-- location to fix up in RAM */
-	add	t3, t3, t6		/* t3 <-- location to fix up in RAM */
-	SREG	t5, 0(t3)
-10:
-	addi	t1, t1, (REGBYTES * 3)
-	blt	t1, t2, 6b
+	li	a3, CONFIG_TEXT_BASE	/* a3 <- linked address of _start */
+	sub	a3, s4, a3		/* a3 <- link-vs-destination offset */
+	jal	apply_relocation
 
 /*
  * trap update
@@ -420,6 +377,34 @@ call_board_init_r:
  * jump to it ...
  */
 	jr	t4			/* jump to board_init_r() */
+
+/*
+ * Apply the .rela.dyn relocations of the running image. a3 is added
+ * to the link-time location and value of each entry. As on ARM, only
+ * R_RISCV_RELATIVE relocations are handled, other entries are skipped;
+ * checkriscvreloc fails the build if any other type is generated.
+ *
+ * a3 = the offset to add (how far the code moved from its link address)
+ */
+apply_relocation:
+	lla	a0, __rel_dyn_start	/* a0 <- first relocation entry */
+	lla	a1, __rel_dyn_end	/* a1 <- one past the last entry */
+	beq	a0, a1, 3f
+
+1:
+	LREG	t5, REGBYTES(a0)	/* t5 <-- relocation info:type */
+	li	t3, R_RISCV_RELATIVE	/* reloc type R_RISCV_RELATIVE */
+	bne	t5, t3, 2f		/* skip non-RISCV_RELOC entries */
+	LREG	t3, 0(a0)
+	LREG	t5, (REGBYTES * 2)(a0)	/* t5 <-- addend */
+	add	t5, t5, a3		/* t5 <-- relocated value */
+	add	t3, t3, a3		/* t3 <-- location to fix up */
+	SREG	t5, 0(t3)
+2:
+	addi	a0, a0, (REGBYTES * 3)
+	blt	a0, a1, 1b
+3:
+	ret
 #endif /* !defined(CONFIG_XPL_BUILD) */
 
 #if CONFIG_IS_ENABLED(SMP)
-- 
2.47.3

