Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE74606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=egvd4tFy;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=bDE/gNZp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4859B408BA;
	Wed, 18 Nov 2026 01:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vO2TQoqtCu29; Wed, 18 Nov 2026 01:26:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7DB6409B2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965185;
	b=YvOXZLsUUfQo125ZUpca55BI1RoY1cdvpUR6UOdfQ3+mGCQMepIAj59G4QHcC02NsdzI
	 3gD2UYPz+Xi9uvOU4G9294wuf3KMCxJYj6FhYwTS2jxyruTHUUpVZ1NxsjPH0p/xzaw02
	 XnI8yEQTojxiJRN1COw72SKWkGf80LSb8fX5icX56MqZM/uMryk+GontBwqlBEnaF/kTK
	 HpT3z06QM/gsy59liHeqRO9xnQPMM4/WwPGIfU5zlmw2ZIXMA3XzW0mn+Ys8SE5MKNw+4
	 cpUTSUslXIjiC5Dr0KHTUwgWt6TYJwEb42+6btw/QTusHWmQQwM1Whr+An85zO4qrOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ePgaQn4AwtuIALQdvVeYiKDIhqBSsIg+XEQ+Qwum/co=;
	b=q0buJnrnyZIpeHvMvL4SE5THVMxlU/g2q9ljJN6UqUC1PVlf1k2p2QdajkWrXL0xeBJI
	 xwtyDY1qGs7w/KhdbYSLXe7mNH4ekvNwnmcbtRaAnQTmLD+m8rk+Pc/ykGtiX5Fn/Pt33
	 MhJl3xq+qxG3qpCDgcokmUSSSu7/jum3aERDOIEK2v9xhZyv8SUw0fXzYFtJ1+goo/+kO
	 dW3zN83H6W+MpI+WQsDwgOzQn3p69uRr0eebxsk4OD/H9U3Jj5H4muWlb51IM+0ok77uL
	 F0Hq7TOyq7hM21+s46pj7z4rMDblGLfBCnOOfnr2/9sMrzRH9f0dBgQamgqrrJJ/usg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965185;
	bh=ePgaQn4AwtuIALQdvVeYiKDIhqBSsIg+XEQ+Qwum/co=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=egvd4tFyKSyxRFo4n4Y07EbgSYm1etVkz7q5PznZiqOgie1jijN/zddC6wVeJcWPm
	 DzNqjKlT2rG3/7aYcdXXBMh5pfA+uZNxJ8dQFdLHmBEV8i2+6wlXlPuqNZ3jQr1hhf
	 DSfv+7uLBWbOLClyFMeL3n0WkguPNNOnOCTnJSS9eOWbINp/Q/5CZT3ppSeW/v7k2s
	 QpL7TKxQK7AmbInqbT7prP4KA1OeR+AGuj2quscmvMIZJcKQ6JFiJodejYiGeXXOZ1
	 l1v6rJ/99AYKiXb0brFqebuCCb/k0450seIgwdw3nMVOLMJyb/55vEVke3pDI8Y+a0
	 r72DsqMOH/ahg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7DB6409B2;
	Wed, 18 Nov 2026 01:26:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24F4449B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16C11605DE
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7OYZY7jALmK for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 23:57:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03117605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=774fa3f08=romain.caritey@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=bDE/gNZp
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03117605DA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794959831; x=1826495831;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y0N3k1EUMjOQnv4fDCBjzP3ipv1LarSvrR1V7KFNrtc=;
 b=bDE/gNZpPnR1yg1/egUErZRXJOjEnPmHUb9UDYhMMB4M0o96bDulBQpV
 mQQk3BDD0tyUmgrCxl53k31oyVZhu7Ea0C+4WXwIMybD7zh9LaC0ET6qr
 q2xdYhV8uPoEOSKPCH5AvRaoDBZlAJ/MLuWwmkMpMXUzYp0WP9BpK75Hm
 YKzb+7lfq1dKNhhYew8uz5dtwhsCi5Ft0+Hr0UXk7Vv1mgc0CBecpGvBW
 WJ8+j2Fz/njyx8PAAWNraEtwNadp1SRmbBDOFIPm0+yaRIklRLqe8Z5gF
 k0wvrSzkoSKwh9IwMcDze6jrokQUfi3dLNbN6kofNooVl9ialsLE88bet w==;
X-CSE-ConnectionGUID: 0vd1MpbgRR+F2QrxSiJ9qw==
X-CSE-MsgGUID: cEyeO193RjGeqma45KQQ1Q==
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="298078476"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 16:56:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 17 Nov 2026 16:56:08 -0700
Received: from bby-cbu-c71245.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 17 Nov 2026 16:56:07 -0700
From: Romain Caritey <romain.caritey@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Leo Liang <leo.liang@sifive.com>, "Tim
 Ouyang" <tim609@andestech.com>
CC: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 <charles.perry@microchip.com>, <mamemaria.mbaye@microchip.com>, "Romain
 Caritey" <romain.caritey@microchip.com>, Michal Simek <michal.simek@amd.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 4/4] riscv: add support for POSITION_INDEPENDENT
Date: Tue, 17 Nov 2026 15:54:13 -0800
Message-ID: <20261117235433.3601945-5-romain.caritey@microchip.com>
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

U-Boot proper on RISC-V has to be loaded at CONFIG_TEXT_BASE. The
previous stage, OpenSBI for instance, does not always load it there,
and the load address can depend on the platform or on the memory
layout.

Add a POSITION_INDEPENDENT option, as on ARM. When enabled:

- start.S applies the .rela.dyn relocations for the run-time address
  using apply_relocation, before any C code runs: compiled code loads
  addresses from the GOT or from initialized data, so even
  board_init_f_alloc_reserve() and harts_early_init(), which may be
  overridden by a CPU or board, must only run after the fixup. The
  first hart to enter _start applies the relocations, the other harts
  wait for it to be done. The fixup is skipped when U-Boot runs at
  CONFIG_TEXT_BASE.

- INIT_SP_RELATIVE, selected by default, sets the early stack pointer
  to __bss_start + SYS_INIT_SP_BSS_OFFSET instead of using a fixed
  address.

- gd->reloc_off is computed from the run-time address of _start, as
  board_init_f() adds it to run-time addresses to jump to the
  relocated board_init_r().

The early stack, malloc area and global data are located above .bss,
so the memory from the load address up to __bss_start +
SYS_INIT_SP_BSS_OFFSET must be usable.

POSITION_INDEPENDENT, INIT_SP_RELATIVE and SYS_INIT_SP_BSS_OFFSET
duplicate the options of the same name in arch/arm/Kconfig, with the
same meaning but different dependencies. They are kept per
architecture for now to keep this change contained to RISC-V; they
could be unified in a shared Kconfig file with per-architecture
dependencies as a follow-up.

Signed-off-by: Romain Caritey <romain.caritey@microchip.com>
---
 arch/riscv/Kconfig     | 35 +++++++++++++++++++++++++++
 arch/riscv/cpu/start.S | 54 ++++++++++++++++++++++++++++++++++++++++--
 common/board_f.c       |  3 +++
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a..1903a19c527 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -501,6 +501,41 @@ config SPL_XIP
 	  rely on lock variables (for example hart_lottery and available_harts_lock),
 	  this affects only SPL, other stages should proceed as non-XIP.
 
+config POSITION_INDEPENDENT
+	bool "Generate position-independent pre-relocation code"
+	depends on !XIP
+	help
+	  U-Boot expects to be linked to a specific hard-coded address, and to
+	  be loaded to and run from that address. This option lifts that
+	  restriction, thus allowing the code to be loaded to and executed from
+	  almost any 4K aligned address. This logic relies on the relocation
+	  information that is embedded in the binary to support U-Boot
+	  relocating itself to the top-of-RAM later during execution.
+
+config INIT_SP_RELATIVE
+	bool "Specify the early stack pointer relative to the .bss section"
+	default y if POSITION_INDEPENDENT
+	help
+	  U-Boot typically uses a hard-coded value for the stack pointer
+	  before relocation. Enable this option to instead calculate the
+	  initial SP at run-time. This is useful to avoid hard-coding addresses
+	  into U-Boot, so that it can be loaded and executed at arbitrary
+	  addresses and thus avoid using arbitrary addresses at runtime.
+
+	  If this option is enabled, the early stack pointer is set to
+	  &_bss_start with a offset value added. The offset is specified by
+	  SYS_INIT_SP_BSS_OFFSET.
+
+config SYS_INIT_SP_BSS_OFFSET
+	hex "Early stack offset from the .bss base address"
+	depends on INIT_SP_RELATIVE
+	default 0x80000
+	help
+	  This option's value is the offset added to &_bss_start in order to
+	  calculate the stack pointer. This offset should be large enough so
+	  that the early malloc region, global data (gd), and early stack usage
+	  do not overlap any appended DTB.
+
 config AVAILABLE_HARTS
 	bool "Send IPI by available harts"
 	depends on !XIP
diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 7cf6384b647..624baf5f195 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -30,6 +30,18 @@
 secondary_harts_relocation_error:
 	.ascii "Relocation of secondary harts has failed, error %d\n"
 
+#if CONFIG_IS_ENABLED(POSITION_INDEPENDENT)
+/*
+ * Used before .bss is cleared, so they must be in .data. Set by the hart
+ * that applies the run-time relocations, see pie_fixup.
+ */
+	.balign	4
+pie_fixup_lottery:
+	.word	0
+pie_fixup_complete:
+	.word	0
+#endif
+
 .section .text
 .globl _start
 _start:
@@ -80,12 +92,50 @@ _start:
 	csrs	MODE_PREFIX(ie), t0
 #endif
 
+#if CONFIG_IS_ENABLED(POSITION_INDEPENDENT)
+	/*
+	 * Position-Independent Executable fix
+	 * Fix .rela.dyn relocations. This allows U-Boot to be loaded to and
+	 * executed at a different address than it was linked at. It must be
+	 * done before any C code runs, as compiled code loads addresses from
+	 * the GOT. The first hart to get here applies the relocations, the
+	 * other harts wait until it is done.
+	 */
+pie_fixup:
+	lla	t0, pie_fixup_lottery
+	li	t1, 1
+	amoswap.w t1, t1, 0(t0)
+	bnez	t1, pie_fixup_wait
+
+	lla	t0, _start		/* t0 <- runtime address of _start */
+	li	t1, CONFIG_TEXT_BASE	/* t1 <- linked address of _start */
+	sub	a3, t0, t1		/* a3 <- offset */
+	beqz	a3, 1f
+	jal	apply_relocation
+1:
+	lla	t0, pie_fixup_complete
+	li	t1, 1
+	amoswap.w.rl zero, t1, 0(t0)	/* publish the fixed up data */
+	j	pie_fixup_done
+
+pie_fixup_wait:
+	lla	t0, pie_fixup_complete
+1:	lw	t1, 0(t0)
+	beqz	t1, 1b
+	fence	r, rw			/* order later loads after the fixup */
+pie_fixup_done:
+#endif
+
 /*
  * Set stackpointer in internal/ex RAM to call board_init_f
  */
 call_board_init_f:
 #if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
 	li	t0, CONFIG_VAL(STACK)
+#elif CONFIG_IS_ENABLED(INIT_SP_RELATIVE)
+	lla	t0, __bss_start
+	li	t1, CONFIG_SYS_INIT_SP_BSS_OFFSET
+	add	t0, t0, t1
 #else
 	li	t0, SYS_INIT_SP_ADDR
 #endif
@@ -291,8 +341,8 @@ stack_setup:
 	mv	sp, s2
 #endif
 
-	lla	t0, _start
-	sub	t6, s4, t0		/* t6 <- relocation offset */
+	lla	t0, _start		/* t0 <- runtime address of _start */
+	sub	t6, s4, t0		/* t6 <- copy offset */
 	beq	t0, s4, clear_bss	/* skip relocation */
 
 	mv	t1, s4			/* t1 <- scratch for copy_loop */
diff --git a/common/board_f.c b/common/board_f.c
index 2f26b4644ca..4f928a9f33d 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -763,6 +763,9 @@ static int setup_reloc(void)
 		gd->reloc_off = gd->relocaddr - (unsigned long)__image_copy_start;
 #elif defined(CONFIG_MICROBLAZE)
 		gd->reloc_off = gd->relocaddr - (u32)_start;
+#elif defined(CONFIG_RISCV) && defined(CONFIG_POSITION_INDEPENDENT)
+		/* U-Boot may not run at CONFIG_TEXT_BASE, use where it runs */
+		gd->reloc_off = gd->relocaddr - (ulong)_start;
 #elif defined(CONFIG_M68K)
 		/*
 		 * On all ColdFire arch cpu, monitor code starts always
-- 
2.47.3

