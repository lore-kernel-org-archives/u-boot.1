Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFFC606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oEhNOCpC;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=OzRnzLSX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17B62408E0;
	Wed, 18 Nov 2026 01:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aE5Uz76aF6i9; Wed, 18 Nov 2026 01:26:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2DF5040873
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965180;
	b=Skduf9sc7W4fAIClkCErlvD9pRX3QNjXlEWje7Tlbn88W6SYpyKc/RxI45492zeHunS5
	 Qi7uczkCm8SZlBcRF2peBRMSuubOk3kOXEeAoPJFbzCljbnxXVWeLDKBtuaFs7+JQb79j
	 OIRFP3fZM781Dxhgau5ZZnattGKQQbPMXW18IrR8CmCm4YcfBiQKfupxxTdfVNVKbfFj9
	 5/+kd7uiY3nuORUo9Ypm3gC9wUX/iBPXV9KWap7JJ7OqXAL0wR0EYI4ShmNhhCCMhIJ+0
	 i2JIRt1Te/aWF/CyPPmeiBtqWjuHgUSZ+hpC5CGTcOGhpJHUIKP8Nki/2JXPsNC+DxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965180;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KTBeZrVYtZkmJD7QS7riY1LvXXshUp8WPp62oczCzyU=;
	b=Sz75WOrASEDHUbYrDYl7pzax/y2QnltoTDIFHh5T0V176qnWBtGKLMdhXwHgpad3BQPd
	 6fnCMfM6LHUVa/HhY/4et69VmsK//P+AM4CGJkt17B0I4chjv74/RhakSXwC+iDSFpCBE
	 dI4IkUzGUXOoiNNqUTw/Kdo28Vb83AhpA/UTrx1K8lsc+Px34VmIZ6DkeI658hQVT/LFZ
	 egSNwHI2IbwQ/Eh59ePCaHhVBTYIJvcrdsk1tmhx1Mdlh5TSBSba4ltIj4K/6y+S4tGmL
	 iHOPWF2a38hCBGLQ1NeqJG4l2EBXSLjEi93T4F6OijR4E8haJgw6nvCHKP2nFiCoS8g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965180;
	bh=KTBeZrVYtZkmJD7QS7riY1LvXXshUp8WPp62oczCzyU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oEhNOCpCqB2/TC4ZDDf7PKIOJNz2vjPGsNuBXmeX8wuZ9Liq7B9I2cIISjhzL6Q09
	 BGi2DqZsDJpEhR0iSIq+9LvRi7Eg2ylHJ6R5MaK1NiD+tk6dSQk1XSnh0to2mySjkV
	 CO0sciAc57/9yx9iZZgrz1qkE2VAr/GtsF5rmsiLMhd8Mf5QPqkJmvPWnM0N2nuDdE
	 3BKf4YeNAwySHFDbGh/EJYn1+92tWj7RCsNLcTJHcn6oVZzDW+ItPFG4PlhtlFU8hh
	 4/ko8Ha4v+B9xbLaA6lirvTIPZwfwI1VQTP0wAsjcKTbsmCE9adnNsNjMqsOwPJzWT
	 Rmpf7XrBHXOYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DF5040873;
	Wed, 18 Nov 2026 01:26:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24F7B1E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ADD3605DE
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mbh5UNPxEXM9 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 23:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 15F25605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 17 Nov 2026 23:56:59 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=OzRnzLSX
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=774fa3f08=romain.caritey@microchip.com; receiver=<UNKNOWN> 
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15F25605DA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794959819; x=1826495819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AmS73qa0S1VnxzIZ438moSMj23AGmWMQKAQwB9x0hTM=;
 b=OzRnzLSXtzV4INKg5p/kM/19RdCf4QwO9aj6wN+jREInX0DnYQPFuTPa
 d9XZOVE6AeMTXm9t3pGOkgNdjY22vP18wdTfLcOAvVpPFijXeqhJsdG3T
 E+CTgtobCuPdSA+99Dy8cACkhEQeK5v76ILu+UEKWnNLEo8/OD6ZIjlhs
 P+9Z+YTEVnUnqHg4njxv6U8/h/aJmFQOjTJm25N64n4RJdQL6ckQROh+j
 A9OoNoAsGa0xf1mO06hGub09Q2ZsZyyuYNKSnt/cEXjHsO/qOf/RwzKl1
 7BTjf5TADjLTT0B1h1JIo9joiDxj+mdIFae9tKpv4RJPxOIGgrQXfXsfN A==;
X-CSE-ConnectionGUID: 18/cBhFiRBekg/vNTsXrHA==
X-CSE-MsgGUID: UlIfJhUJQCWJsJxKQOOvKw==
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="233724516"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 17 Nov 2026 16:55:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 17 Nov 2026 16:55:54 -0700
Received: from bby-cbu-c71245.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 17 Nov 2026 16:55:54 -0700
From: Romain Caritey <romain.caritey@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Leo Liang <leo.liang@sifive.com>, "Tim
 Ouyang" <tim609@andestech.com>
CC: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 <charles.perry@microchip.com>, <mamemaria.mbaye@microchip.com>, "Romain
 Caritey" <romain.caritey@microchip.com>
Subject: [PATCH 1/4] riscv: start.S: use lla instead of la
Date: Tue, 17 Nov 2026 15:54:10 -0800
Message-ID: <20261117235433.3601945-2-romain.caritey@microchip.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With -fpic, which is always used for RISC-V, the la pseudo-instruction
is expanded into a load from the GOT. The GOT entries hold link-time
addresses until the .rela.dyn relocations have been applied, so la only
returns the right address when U-Boot runs at CONFIG_TEXT_BASE.

The symbols referenced in start.S are all local to U-Boot, and the
code needs their run-time address. Use lla, which always generates a
PC-relative auipc/addi pair and does not access memory.

No functional change when U-Boot runs at CONFIG_TEXT_BASE, which is
currently the only supported case. This is a prerequisite for running
U-Boot at an address different from the one it was linked at.

Signed-off-by: Romain Caritey <romain.caritey@microchip.com>
---
 arch/riscv/cpu/start.S | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 7bafdfd390a..72032b77ef9 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -61,7 +61,7 @@ _start:
 	 * Set the trap handler. This must happen after initializing gp because
 	 * the handler may use it.
 	 */
-	la	t0, trap_entry
+	lla	t0, trap_entry
 	csrw	MODE_PREFIX(tvec), t0
 
 	/*
@@ -149,7 +149,7 @@ call_harts_early_init:
 	 * Pick hart to initialize global data and run U-Boot. The other harts
 	 * wait for initialization to complete.
 	 */
-	la	t0, hart_lottery
+	lla	t0, hart_lottery
 	li	t1, 1
 	amoswap.w s2, t1, 0(t0)
 	bnez	s2, wait_for_gd_init
@@ -176,7 +176,7 @@ call_harts_early_init:
 
 #if !CONFIG_IS_ENABLED(XIP)
 #ifdef CONFIG_AVAILABLE_HARTS
-	la	t0, available_harts_lock
+	lla	t0, available_harts_lock
 	amoswap.w.rl zero, zero, 0(t0)
 #endif
 
@@ -188,7 +188,7 @@ wait_for_gd_init:
 	 */
 	mv	gp, s0
 #ifdef CONFIG_AVAILABLE_HARTS
-	la	t0, available_harts_lock
+	lla	t0, available_harts_lock
 	li	t1, 1
 1:	amoswap.w.aq t1, t1, 0(t0)
 	bnez	t1, 1b
@@ -215,13 +215,13 @@ wait_for_gd_init:
 #endif
 
 	mv	a0, zero		/* a0 <-- boot_flags = 0 */
-	la	t5, board_init_f
+	lla	t5, board_init_f
 	jalr	t5			/* jump to board_init_f() */
 
 #ifdef CONFIG_XPL_BUILD
 spl_clear_bss:
-	la	t0, __bss_start
-	la	t1, __bss_end
+	lla	t0, __bss_start
+	lla	t1, __bss_end
 	beq	t0, t1, spl_stack_gd_setup
 
 spl_clear_bss_loop:
@@ -248,7 +248,7 @@ spl_stack_gd_setup:
 #if CONFIG_IS_ENABLED(SMP)
 	/* set new stack and global data pointer on secondary harts */
 spl_secondary_hart_stack_gd_setup:
-	la	a0, secondary_hart_relocate
+	lla	a0, secondary_hart_relocate
 	mv	a1, s0
 	mv	a2, s0
 	mv	a3, zero
@@ -257,7 +257,7 @@ spl_secondary_hart_stack_gd_setup:
 	/* hang if relocation of secondary harts has failed */
 	beqz	a0, 1f
 	mv	a1, a0
-	la	a0, secondary_harts_relocation_error
+	lla	a0, secondary_harts_relocation_error
 	jal	printf
 	jal	hang
 #endif
@@ -297,12 +297,12 @@ stack_setup:
 	mv	sp, s2
 #endif
 
-	la	t0, _start
+	lla	t0, _start
 	sub	t6, s4, t0		/* t6 <- relocation offset */
 	beq	t0, s4, clear_bss	/* skip relocation */
 
 	mv	t1, s4			/* t1 <- scratch for copy_loop */
-	la	t2, __bss_start		/* t2 <- source end address */
+	lla	t2, __bss_start		/* t2 <- source end address */
 
 copy_loop:
 	LREG	t5, 0(t0)
@@ -315,8 +315,8 @@ copy_loop:
  * Update dynamic relocations after board_init_f
  */
 fix_rela_dyn:
-	la	t1, __rel_dyn_start
-	la	t2, __rel_dyn_end
+	lla	t1, __rel_dyn_start
+	lla	t2, __rel_dyn_end
 	beq	t1, t2, clear_bss
 	add	t1, t1, t6		/* t1 <- rela_dyn_start in RAM */
 	add	t2, t2, t6		/* t2 <- rela_dyn_end in RAM */
@@ -333,7 +333,7 @@ fix_rela_dyn:
 	j	10f
 
 8:
-	la	t4, __dyn_sym_start
+	lla	t4, __dyn_sym_start
 	add	t4, t4, t6
 
 9:
@@ -359,14 +359,14 @@ fix_rela_dyn:
 /*
  * trap update
 */
-	la	t0, trap_entry
+	lla	t0, trap_entry
 	add	t0, t0, t6
 	csrw	MODE_PREFIX(tvec), t0
 
 clear_bss:
-	la	t0, __bss_start		/* t0 <- rel __bss_start in FLASH */
+	lla	t0, __bss_start		/* t0 <- rel __bss_start in FLASH */
 	add	t0, t0, t6		/* t0 <- rel __bss_start in RAM */
-	la	t1, __bss_end		/* t1 <- rel __bss_end in FLASH */
+	lla	t1, __bss_end		/* t1 <- rel __bss_end in FLASH */
 	add	t1, t1, t6		/* t1 <- rel __bss_end in RAM */
 	beq	t0, t1, relocate_secondary_harts
 
@@ -378,7 +378,7 @@ clbss_l:
 relocate_secondary_harts:
 #if CONFIG_IS_ENABLED(SMP)
 	/* send relocation IPI */
-	la	t0, secondary_hart_relocate
+	lla	t0, secondary_hart_relocate
 	add	a0, t0, t6
 
 	/* store relocation offset */
@@ -392,7 +392,7 @@ relocate_secondary_harts:
 	/* hang if relocation of secondary harts has failed */
 	beqz	a0, 1f
 	mv	a1, a0
-	la	a0, secondary_harts_relocation_error
+	lla	a0, secondary_harts_relocation_error
 	jal	printf
 	jal	hang
 
@@ -407,7 +407,7 @@ relocate_secondary_harts:
 call_board_init_r:
 	jal	invalidate_icache_all
 	jal	flush_dcache_all
-	la	t0, board_init_r        /* offset of board_init_r() */
+	lla	t0, board_init_r        /* offset of board_init_r() */
 	add	t4, t0, t6		/* real address of board_init_r() */
 /*
  * setup parameters for board_init_r
-- 
2.47.3

