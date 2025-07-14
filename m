Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC236C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 21:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7BAE82F6F;
	Mon, 14 Jul 2025 23:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=novatechautomation.com header.i=@novatechautomation.com header.b="TmwQckTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB4B582E52; Mon, 14 Jul 2025 23:03:04 +0200 (CEST)
Received: from gw1.cammew.com (gw1.cammew.com [64.182.209.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBEE882CEA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 23:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
Received: from eric-Desktop.novatech-llc.local (unknown [38.62.160.128])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gw1.cammew.com (Postfix) with ESMTPSA id 88081119CBD;
 Mon, 14 Jul 2025 17:02:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 gw1.cammew.com 88081119CBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=novatechautomation.com; s=relay; t=1752526978;
 bh=NwtAfoqYLNAtb1flNGu2Dg856RQmnAx1LyPRxYCbJ5g=;
 h=From:To:Cc:Subject:Date:From;
 b=TmwQckTuT1MpYTIxSPbY2kyBhWMxW+Dygm6UNMnxVfBvVdwfC7ZKEdBXISrIFnUMy
 k7+erdkuzssGVjrfFuZDwKbr/AkWwVQzldRQsj1xk4wuAb6aSFaFzjsxUBc+quB+d6
 ltIWJ+G7eAB2shTDTg1/yDFXz87Qzke+FEacznNE=
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Subject: [PATCH 1/2] Fix x86 baytrail boot flow.
Date: Mon, 14 Jul 2025 16:02:48 -0500
Message-ID: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
X-Mailer: git-send-email 2.43.0
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

It was found that on modern versions of GCC the transition from low level
assembly into the C function 'fsp_find_header' was no longer valid. A detailed
step by step analysis with GDB showed that various registers were not being
initialized properly which would result in the hardware to fail to setup the
Cache As Ram (CAR) portion. This failure cascades down into later stages of
initialization because there is no valid stack, or memory for later functions.

The function 'fsp_find_header' has been rewritten in assembly, which should
no longer be dependant on a specific version of GCC in order to be usable on
actual hardware.

Testing was done using GCC 11.4.0 on Ubuntu 22.04.
Hardware used for verification: Intel E3845 SoC

Patch 1 of 2

Upstream-Status: Pending

Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
---
 arch/x86/cpu/start.S            |   3 +-
 arch/x86/cpu/start16.S          |   4 +
 arch/x86/lib/fsp1/fsp_car.S     |   4 +-
 arch/x86/lib/fsp1/fsp_support.c | 132 ++++++++++++++++++--------------
 common/board_f.c                |   1 +
 include/init.h                  |   9 +++
 6 files changed, 92 insertions(+), 61 deletions(-)

diff --git a/arch/x86/cpu/start.S b/arch/x86/cpu/start.S
index 0ef27cc5a00..3b4d1151d7f 100644
--- a/arch/x86/cpu/start.S
+++ b/arch/x86/cpu/start.S
@@ -77,7 +77,8 @@ _start:
 #endif
 
 	/* Load the segment registers to match the GDT loaded in start16.S */
-	movl	$(X86_GDT_ENTRY_32BIT_DS * X86_GDT_ENTRY_SIZE), %eax
+	movl	$(X86_GDT_ENTRY_32BIT_DS * X86_GDT_ENTRY_SIZE), %eax  /* Move values into EAX: 3 * 8 = 0x18 */
+
 	movw	%ax, %fs
 	movw	%ax, %ds
 	movw	%ax, %gs
diff --git a/arch/x86/cpu/start16.S b/arch/x86/cpu/start16.S
index 865a49731e5..518ff842948 100644
--- a/arch/x86/cpu/start16.S
+++ b/arch/x86/cpu/start16.S
@@ -20,11 +20,15 @@ start16:
 	/* Save BIST */
 	movl	%eax, %ecx
 
+	/* Set COLD_BOOT Flag */
+	movl   $0x10000, %ebx
+
 	xorl	%eax, %eax
 	movl	%eax, %cr3	/* Invalidate TLB */
 
 	/* Turn off cache (this might require a 486-class CPU) */
 	movl	%cr0, %eax
+	/* Set Cache Disable, and NonWrite-through $(0x60000000), %eax */
 	orl	$(X86_CR0_NW | X86_CR0_CD), %eax
 	movl	%eax, %cr0
 	wbinvd
diff --git a/arch/x86/lib/fsp1/fsp_car.S b/arch/x86/lib/fsp1/fsp_car.S
index a64a6534357..2f32636cef0 100644
--- a/arch/x86/lib/fsp1/fsp_car.S
+++ b/arch/x86/lib/fsp1/fsp_car.S
@@ -20,7 +20,7 @@ car_init:
 
 car_init_start:
 	post_code(POST_CAR_START)
-	lea	fsp_find_header_romstack, %esp
+	lea     fsp_find_header_romstack, %esp
 	jmp	fsp_find_header
 
 fsp_find_header_ret:
@@ -91,6 +91,8 @@ die:
 	 * contain the function return address as well as the parameters.
 	 */
 	.balign	4
+/* Does this need to be global? */
+.global fsp_find_header_romstack
 fsp_find_header_romstack:
 	.long	fsp_find_header_ret
 
diff --git a/arch/x86/lib/fsp1/fsp_support.c b/arch/x86/lib/fsp1/fsp_support.c
index d84c632f140..c043a63d906 100644
--- a/arch/x86/lib/fsp1/fsp_support.c
+++ b/arch/x86/lib/fsp1/fsp_support.c
@@ -9,66 +9,80 @@
 #include <asm/fsp1/fsp_support.h>
 #include <asm/post.h>
 
-struct fsp_header *__attribute__((optimize("O0"))) fsp_find_header(void)
-{
-	/*
-	 * This function may be called before the a stack is established,
-	 * so special care must be taken. First, it cannot declare any local
-	 * variable using stack. Only register variable can be used here.
-	 * Secondly, some compiler version will add prolog or epilog code
-	 * for the C function. If so the function call may not work before
-	 * stack is ready.
-	 *
-	 * GCC 4.8.1 has been verified to be working for the following codes.
-	 */
-	volatile register u8 *fsp asm("eax");
-
-	/* Initalize the FSP base */
-	fsp = (u8 *)CONFIG_FSP_ADDR;
-
-	/* Check the FV signature, _FVH */
-	if (((struct fv_header *)fsp)->sign == EFI_FVH_SIGNATURE) {
-		/* Go to the end of the FV header and align the address */
-		fsp += ((struct fv_header *)fsp)->ext_hdr_off;
-		fsp += ((struct fv_ext_header *)fsp)->ext_hdr_size;
-		fsp  = (u8 *)(((u32)fsp + 7) & 0xFFFFFFF8);
-	} else {
-		fsp  = 0;
-	}
+#define _STR(x) #x
+#define STR(x) _STR(x)
 
-	/* Check the FFS GUID */
-	if (fsp &&
-	    ((struct ffs_file_header *)fsp)->name.b[0] == FSP_GUID_BYTE0 &&
-	    ((struct ffs_file_header *)fsp)->name.b[1] == FSP_GUID_BYTE1 &&
-	    ((struct ffs_file_header *)fsp)->name.b[2] == FSP_GUID_BYTE2 &&
-	    ((struct ffs_file_header *)fsp)->name.b[3] == FSP_GUID_BYTE3 &&
-	    ((struct ffs_file_header *)fsp)->name.b[4] == FSP_GUID_BYTE4 &&
-	    ((struct ffs_file_header *)fsp)->name.b[5] == FSP_GUID_BYTE5 &&
-	    ((struct ffs_file_header *)fsp)->name.b[6] == FSP_GUID_BYTE6 &&
-	    ((struct ffs_file_header *)fsp)->name.b[7] == FSP_GUID_BYTE7 &&
-	    ((struct ffs_file_header *)fsp)->name.b[8] == FSP_GUID_BYTE8 &&
-	    ((struct ffs_file_header *)fsp)->name.b[9] == FSP_GUID_BYTE9 &&
-	    ((struct ffs_file_header *)fsp)->name.b[10] == FSP_GUID_BYTE10 &&
-	    ((struct ffs_file_header *)fsp)->name.b[11] == FSP_GUID_BYTE11 &&
-	    ((struct ffs_file_header *)fsp)->name.b[12] == FSP_GUID_BYTE12 &&
-	    ((struct ffs_file_header *)fsp)->name.b[13] == FSP_GUID_BYTE13 &&
-	    ((struct ffs_file_header *)fsp)->name.b[14] == FSP_GUID_BYTE14 &&
-	    ((struct ffs_file_header *)fsp)->name.b[15] == FSP_GUID_BYTE15) {
-		/* Add the FFS header size to find the raw section header */
-		fsp += sizeof(struct ffs_file_header);
-	} else {
-		fsp = 0;
-	}
-
-	if (fsp &&
-	    ((struct raw_section *)fsp)->type == EFI_SECTION_RAW) {
-		/* Add the raw section header size to find the FSP header */
-		fsp += sizeof(struct raw_section);
-	} else {
-		fsp = 0;
-	}
-
-	return (struct fsp_header *)fsp;
+__attribute__((naked))  // avoid prolog/epilog and stack usage
+struct fsp_header *fsp_find_header(void)
+{
+    asm volatile (
+	// Make sure function knows where to return to later..
+	"push %%ebp\n\t"
+	"mov %%esp, %%ebp\n\t"
+
+	"mov $" STR(CONFIG_FSP_ADDR) ", %%eax\n\t"         // eax = CONFIG_FSP_ADDR
+
+	// Check for FVH signature at CONFIG_FSP_ADDR + 0x28
+	"movl 0x28(%%eax), %%edx\n\t"
+	"cmp $" STR(EFI_FVH_SIGNATURE) ", %%edx\n\t"
+	"jne .fail_fvh\n\t"
+
+	// Found the header, verify it!
+	"mov %%eax, %%edx\n\t"
+	"mov 0x34(%%eax), %%eax\n\t"
+	"movzwl %%ax, %%eax\n\t"	// Zero extend ax from 16-bit to 32-bit
+	"add %%edx, %%eax\n\t"
+	"mov %%eax, %%edx\n\t"
+	"mov 0x10(%%eax), %%eax\n\t"
+	"add %%edx, %%eax\n\t"
+	"add $0x7, %%eax\n\t" 		// 8-byte alignment
+	"and $0xfffffff8, %%eax\n\t"
+
+	// From here code should jump to first GUID byte to check
+	"mov (%%eax), %%edx\n\t"
+	"cmp $0x912740be, %%edx\n\t"	// These are bytes 0-3 of FSP_GUID in LE
+	"jne .fail_fvh\n\t"
+
+	"mov 0x4(%%eax), %%edx\n\t"
+	"cmp $0x47342284 , %%edx\n\t"	// These are bytes 4-7 of FSP_GUID in LE
+	"jne .fail_fvh\n\t"
+
+	"mov 0x8(%%eax), %%edx\n\t"
+	"cmp $0xb08471b9, %%edx\n\t"	// These are bytes 8-11 of FSP_GUID in LE
+	"jne .fail_fvh\n\t"
+
+	"mov 0xc(%%eax), %%edx\n\t"
+	"cmp $0x0c3f3527, %%edx\n\t"	// These are bytes 12-15 of FSP_GUID in LE
+	"jne .fail_fvh\n\t"
+
+	// Add 0x18 bytes to offset header in eax register
+	"add $0x18,%%eax\n\t"
+
+	//Make sure eax is greater than 0x18, should be!
+	"cmp $0x18, %%eax\n\t"
+	"jbe .fail_fvh\n\t"
+
+	"mov 0x3(%%eax), %%edx\n\t"
+	// Make sure pointer is at actual " FSP" start
+	"cmp $0x50534619, %%edx\n\t"
+	"jne .fail_fvh\n\t"
+
+	// That test passed, so advance pointer 4 bytes..
+	"add $0x4, %%eax\n\t"
+
+	// Base pointer should be set before entering here so..
+	"pop %%ebp\n\t"
+	"ret\n"
+
+	".fail_fvh:\n\t"
+	"mov $0xF1, %%al\n\t"
+	"out %%al, $0x80\n\t"
+	"xor %%eax, %%eax\n\t"                  // return 0 on failure
+	"ret\n"
+	:
+	:
+	: "eax", "ecx"
+    );
 }
 
 void fsp_continue(u32 status, void *hob_list)
diff --git a/common/board_f.c b/common/board_f.c
index 442b8349d08..3a9ae741d97 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -860,6 +860,7 @@ __weak int clear_bss(void)
 }
 
 static const init_fnc_t init_sequence_f[] = {
+	arch_fsp_init,          // FSP on platforms like baytrail MUST be done before memory ops
 	setup_mon_len,
 #ifdef CONFIG_OF_CONTROL
 	fdtdec_setup,
diff --git a/include/init.h b/include/init.h
index 9a1951d10a0..21d9cea30f6 100644
--- a/include/init.h
+++ b/include/init.h
@@ -68,6 +68,15 @@ int mach_cpu_init(void);
  */
 int arch_fsp_init_r(void);
 
+/**
+ * arch_fsp_init() - perform firmware support package init
+ *
+ * Where U-Boot relies on binary blobs to handle part of the system init, this
+ * function can be used to set up the blobs. This is used on some Intel
+ * platforms.
+ */
+int arch_fsp_init(void);
+
 int dram_init(void);
 
 /**
-- 
2.43.0

