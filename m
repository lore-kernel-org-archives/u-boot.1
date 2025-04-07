Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A3CC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2373482F65;
	Mon,  7 Apr 2025 20:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Co+Jl5Rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205F682E40; Mon,  7 Apr 2025 14:45:22 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9574482CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id CDE26A486CC;
 Mon,  7 Apr 2025 12:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37479C4CEDD;
 Mon,  7 Apr 2025 12:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744029918;
 bh=EJ6cjbc3KfgbhUApk4VNSpZn+GtC6o+yo6Y34JlJVyc=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=Co+Jl5Rx+pxX7jO8uz4SYC2EKHQydfCX9G+ghxDliZJnRH2NO2GopCK6rrGz2eztD
 SCdG3DOEiFqX77mpBb8GadiBAke9f+EENVvogFUajJ5Q651d+mvIqxsificXkN4ux2
 P0hWpLjs0v4tcdo9IpIAa2tWDQBX0/jOYDxrGYZGcWRRb6P0+v7wCte9bDHpE83D5S
 v1nOK3Qi4vCrXMtnwuSoqaiWg86y3hShSC1+suDZCeB9ke/6osOYIv18MwXPEYxrN1
 vSc8uqVcLyFgYR3Cz/977thyh3G/HzbRzNJyV6YRqsHrFxr3I1MJIVGFF3NGgSecpm
 8Z1KkaZzxLB0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 20688C36010;
 Mon,  7 Apr 2025 12:45:18 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Mon, 07 Apr 2025 20:44:58 +0800
Subject: [PATCH RFC] bootm: ARM64 EL1 direct jump to kernel start
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-el1-boot-v1-1-f7c52499d9c5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMnI82cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNz3dQcQ92k/PwSXXNLI0sjs6REMwNLAyWg8oKi1LTMCrBR0bG1tQB
 eZCmVWgAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744029916; l=4102;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=GD1dScz1+CT+QozQ4RhYfOQiS9MdEXEF1nvNZ1X8uoU=;
 b=dKmKQr4FszUwY7svjFdvHov40lPlTPq6WV1qwHCdZnK0q5c8SQmFVQHGl1dYx3kJPqYWs0Sm4
 l8G2Y/Q7yOCBH5BUeIKl0S4F/xJWix7lKVETGXShNOvLb+gF9YBRp6a
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 07 Apr 2025 20:14:46 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

It was EL3->EL2 or EL2->EL1 when boot. But in many case such chain
loading from bootloader is already run in EL1.

There is no practically way to raise EL1 to EL2. Thus theonly way
to start kernel is direct jump. This apporach is similar to KEXEC
purgatory idea but do not need to make an extra bulk of binary blob.
This applied when current_el() is 1 only.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
U-Boot usually run in EL3 or EL2 mode so assumed kernel will start
at EL2, or switch from EL2 to enter EL1. Test shows in QCOM SM7125
phone environment chainloading U-Boot is already in EL1 so doing 
EL2 transition EL1 gone wrong.

This patch enable the EL1 chain loading kernel by direct jump to 
image->ep address. This calling convention apply to bootm only.

In short, borrow the logic from kexec-tool purgatory idea and issue
a direct jump when current_el() is EL1.
---
 arch/arm/cpu/armv8/Makefile |  2 +-
 arch/arm/cpu/armv8/entry.S  | 42 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/lib/bootm.c        | 18 ++++++++++++++++--
 3 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index b4126c61df1..d5b0ffe8c87 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -5,7 +5,7 @@
 
 extra-y	:= start.o
 
-obj-y	+= cpu.o
+obj-y	+= cpu.o entry.o
 ifndef CONFIG_$(PHASE_)TIMER
 obj-$(CONFIG_SYS_ARCH_TIMER) += generic_timer.o
 endif
diff --git a/arch/arm/cpu/armv8/entry.S b/arch/arm/cpu/armv8/entry.S
new file mode 100644
index 00000000000..19a7da2438e
--- /dev/null
+++ b/arch/arm/cpu/armv8/entry.S
@@ -0,0 +1,42 @@
+/*
+ * ARM64 purgatory.
+ */
+#include <asm-offsets.h>
+#include <config.h>
+#include <linux/linkage.h>
+#include <asm/macro.h>
+
+.macro  size, sym:req
+        .size \sym, . - \sym
+.endm
+
+.pushsection .text.purgatory_start, "ax"
+ENTRY(purgatory_start)
+purgatory_start:
+
+//	adr	x19, .Lstack
+//	mov	sp, x19
+
+//	bl	purgatory
+
+	/* Start new image. */
+	ldr	x17, kernel_entry
+	ldr	x0, dtb_addr
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+	br	x17
+ENDPROC(purgatory_start)
+.popsection
+.align 3
+
+.globl kernel_entry
+kernel_entry:
+        .quad   0
+size kernel_entry
+
+.globl dtb_addr
+dtb_addr:
+        .quad   0
+size dtb_addr
+.end
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 974cbfe8400..5a15725317c 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -269,6 +269,10 @@ __weak void update_os_arch_secondary_cores(uint8_t os_arch)
 {
 }
 
+extern void (*kernel_entry)(void *fdt_addr, void *res0, void *res1,
+                            void *res2);
+extern void* dtb_addr;
+
 #ifdef CONFIG_ARMV8_SWITCH_TO_EL1
 static void switch_to_el1(void)
 {
@@ -290,13 +294,13 @@ static void switch_to_el1(void)
 static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
 #ifdef CONFIG_ARM64
-	void (*kernel_entry)(void *fdt_addr, void *res0, void *res1,
-			void *res2);
 	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
 
 	kernel_entry = (void (*)(void *fdt_addr, void *res0, void *res1,
 				void *res2))images->ep;
 
+	dtb_addr = images->ft_addr;
+
 	debug("## Transferring control to Linux (at address %lx)...\n",
 		(ulong) kernel_entry);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
@@ -311,6 +315,16 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 
 		update_os_arch_secondary_cores(images->os.arch);
 
+		/* right now switch_to_el1() is hanging the devlice
+		 * when it is already in EL1 so cant do anything about it.
+		 */
+		if (current_el() == 1) {
+			void purgatory_start(void);
+			purgatory_start();
+			panic("nothing to do...\n");
+			return;
+		}
+
 #ifdef CONFIG_ARMV8_SWITCH_TO_EL1
 		armv8_switch_to_el2((u64)images->ft_addr, 0, 0, 0,
 				    (u64)switch_to_el1, ES_TO_AARCH64);

---
base-commit: 848f7ffc64aa7c4cc2229095812625c12343c8c1
change-id: 20250407-el1-boot-792926ba6090

Best regards,
-- 
George Chan <gchan9527@gmail.com>


