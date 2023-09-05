Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CF8C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 12:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B050B86907;
	Tue,  5 Sep 2023 14:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A055A8690B; Tue,  5 Sep 2023 14:13:02 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EACFF8656D
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 14:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ben@codethink.co.uk
Received: from [134.238.52.102] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1qdUvQ-002zST-SJ; Tue, 05 Sep 2023 13:12:57 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
 (envelope-from <ben@rainbowdash>) id 1qdUvP-0018E6-2I;
 Tue, 05 Sep 2023 13:12:55 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: u-boot@lists.denx.de
Cc: ganboing@gmail.com, rick@andestech.com,
 Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [[PATCH v2]] riscv: add backtrace support
Date: Tue,  5 Sep 2023 13:12:53 +0100
Message-Id: <20230905121253.269941-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
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

When debugging, it is useful to have a backtrace to find
out what is in the call stack as the previous function (RA)
may not have been the culprit.

Since this adds size to the build, do not add it by default
and avoid putting it in the SPL build if not needed.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v2:
  - back to codethink email as sifive account is now gone
  - add option to build SPL with frame pointer
    (as suggested by Bo Gan <ganboing@gmail.com>
---
 arch/riscv/Kconfig          | 20 ++++++++++++++++++++
 arch/riscv/Makefile         |  4 ++++
 arch/riscv/cpu/start.S      |  1 +
 arch/riscv/lib/interrupts.c | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6771d8d919..a446166631 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -111,6 +111,26 @@ config ARCH_RV64I
 
 endchoice
 
+config FRAMEPOINTER
+	bool "Build with frame pointer for stack unwinding"
+	help
+	  Choose this option to use the frame pointer so the stack can be
+	  unwound if needed. This is useful for tracing where faults came
+	  from as the source may be several functions back
+
+	  If you say Y here, then the code size will be increased due to
+	  having to store the fp.
+
+config SPL_FRAMEPOINTER
+	bool "Build SPL with frame pointer for stack unwinding"
+	help
+	  Choose this option to use the frame pointer so the stack can be
+	  unwound if needed. This is useful for tracing where faults came
+	  from as the source may be several functions back
+
+	  If you say Y here, then the code size will be increased due to
+	  having to store the fp.
+
 choice
 	prompt "Code Model"
 	default CMODEL_MEDLOW
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 4963b5109b..0cb60c7c7e 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -45,6 +45,10 @@ endif
 ARCH_FLAGS = -march=$(RISCV_MARCH) -mabi=$(ABI) \
 	     -mcmodel=$(CMODEL)
 
+ifeq ($(CONFIG_$(SPL_)FRAMEPOINTER),y)
+	ARCH_FLAGS += -fno-omit-frame-pointer
+endif
+
 PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
 CFLAGS_EFI		+= $(ARCH_FLAGS)
 
diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 30cf674370..53de424378 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -419,6 +419,7 @@ call_board_init_r:
  */
 	mv	a0, s3			/* gd_t */
 	mv	a1, s4			/* dest_addr */
+	mv	s0, zero		/* fp == NULL */
 
 /*
  * jump to it ...
diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
index e966afa7e3..db3d7e294b 100644
--- a/arch/riscv/lib/interrupts.c
+++ b/arch/riscv/lib/interrupts.c
@@ -53,6 +53,40 @@ static void show_regs(struct pt_regs *regs)
 #endif
 }
 
+#if defined(CONFIG_FRAMEPOINTER) || defined(CONFIG_SPL_FRAMEPOINTER)
+static void show_backtrace(struct pt_regs *regs)
+{
+	uintptr_t *fp = (uintptr_t *)regs->s0;
+	unsigned count = 0;
+	ulong ra;
+
+	printf("backtrace:\n");
+
+	/* there are a few entry points where the s0 register is
+	 * set to gd, so to avoid changing those, just abort if
+	 * the value is the same */
+	while (fp != NULL && fp != (uintptr_t *)gd) {
+		ra = fp[-1];
+		printf("backtrace %2d: FP: " REG_FMT " RA: " REG_FMT,
+		       count, (ulong)fp, ra);
+
+		if (gd && gd->flags & GD_FLG_RELOC)
+			printf(" - RA: " REG_FMT " reloc adjusted\n",
+			ra - gd->reloc_off);
+		else
+			printf("\n");
+
+		fp = (uintptr_t *)fp[-2];
+		count++;
+	}
+}
+#else
+static void show_backtrace(struct pt_regs *regs)
+{
+	printf("No backtrace support enabled\n");
+}
+#endif
+
 /**
  * instr_len() - get instruction length
  *
@@ -119,6 +153,7 @@ static void _exit_trap(ulong code, ulong epc, ulong tval, struct pt_regs *regs)
 		       epc - gd->reloc_off, regs->ra - gd->reloc_off);
 
 	show_regs(regs);
+	show_backtrace(regs);
 	show_code(epc);
 	show_efi_loaded_images(epc);
 	panic("\n");
-- 
2.40.1

