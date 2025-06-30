Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D572AC83000
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 05:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A188E81E13;
	Mon, 30 Jun 2025 07:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fApLNqiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8804D81FEE; Mon, 30 Jun 2025 07:18:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA9880B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751260716; x=1751865516; i=xypron.glpk@gmx.de;
 bh=U6vzh3zuveLfmB5587fStE+seblJwjXWV/++gyjy6yE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fApLNqiHbOlEqWGx4KyAJrH5qfLKmTMe7LajgUYOGtVnsSNL+RApETpb4UG1lA2O
 GXI1uonK9L3iX0UiSeeysSwXpQ4vAeVZ3neCmCuO3ShnE3zPpdDdzMQSY2ixAaJlO
 auN+FepN7aG3Ck1QjX3swVcmnlPLLnH1/qRjg6r84FpVTMZxqvwAjD6wpszxDBqMC
 3bOB55Ua5vGiTcqdx8zkR7f2dH235JszXY+sEohH/JGgeYyCdyqPfKp0Ue4+3Koy7
 Byapwa4Gq+7/cVvBsSx9by3TR8VKcgXyQX7ztRBSWHcssKC7zBayR89o6/pX5NLi4
 vnjr3wPcb7YckcQWfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.105.73]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MStCe-1u8YAn0iJa-00RW21; Mon, 30
 Jun 2025 07:18:35 +0200
Date: Mon, 30 Jun 2025 07:18:33 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_ARM=3A_bootm=3A_Add_support_f?=
 =?US-ASCII?Q?or_starting_Linux_through_OpTee-OS_on_ARMv7a?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250630000832.952206-1-marek.vasut@mailbox.org>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
Message-ID: <97DFDFA0-80F7-462B-B2A9-BDBAD42A191A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hh/FlZiWm67IhaWmq8QBdYTsK/SXqwea+rsJTC+6bL28AF4OR2t
 PAPBfOHJPTbqOKzMHuv6Sm4fxLblrNiTztLF4YFdYXTSEv7P4zCNydb9SCvNYoW3flWg9oC
 0hfVBbzk8cDjS9gZXUza58OLjbGM/tLTdWi335aF6Wrz1ywDpmie3Qx53HSEz6AaGM+vaYX
 +vpV06+egFq42gpfoz4oA==
UI-OutboundReport: notjunk:1;M01:P0:+fIz4aSfqZE=;zzAmwo3ECYUp9Zn5oPjL4Uy3oVb
 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
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

Am 30=2E Juni 2025 02:08:05 MESZ schrieb Marek Vasut <marek=2Evasut@mailbox=
=2Eorg>:
>Add support for jumping to Linux kernel through OpTee-OS on ARMv7a=2E
>This is only supported if U-Boot runs in PL1 secure=2E This change adds
>two components, one is fitImage OpTee-OS loadable handler, which makes
>a note of OpTee-OS being loaded and stores the load address for later
>jump to it=2E The second part is the actual jump to Linux through OpTee-O=
S=2E
>The jump through OpTee-OS requires set up of multiple CPU registers, r1
>and r2 are passed through, r0 and r3 have to be set to 0, lr is set to
>Linux kernel entry point=2E This setup is done by new assembler function
>boot_jump_linux_via_optee()=2E
>
>The boot_jump_linux_via_optee() also includes STM32MP13xx late TZC
>configuration write, this cannot be moved easily, hence the ifdef=2E

Hello Marek,

Could you, please, add a documentation change to the series=2E This would =
allow reviewers to test your proposal=2E

Furthermore, please, provide tests on QEMU=2E

Best regards

Heinrich


>
>Signed-off-by: Marek Vasut <marek=2Evasut@mailbox=2Eorg>
>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: Janne Grunau <j@jannau=2Enet>
>Cc: Mattijs Korpershoek <mkorpershoek@kernel=2Eorg>
>Cc: Patrick Rudolph <patrick=2Erudolph@9elements=2Ecom>
>Cc: Sam Edwards <cfsworks@gmail=2Ecom>
>Cc: Simon Glass <sjg@chromium=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>Cc: u-boot@lists=2Edenx=2Ede
>---
>V2: - Add ifdeffery around armv7_init_nonsec(), boot_jump_linux_via_optee=
(),
>      secure_ram_addr() due to external dependencies which may not be rea=
chable
>    - Add ifdeffery around arch_tee_image_process() to avoid breaking OMA=
P2
>      IH_TYPE_TEE loading
>---
> arch/arm/include/asm/armv7=2Eh |  2 ++
> arch/arm/lib/Makefile        |  3 ++
> arch/arm/lib/bootm-optee=2ES   | 30 +++++++++++++++++++
> arch/arm/lib/bootm=2Ec         | 56 ++++++++++++++++++++++++++++++------
> 4 files changed, 82 insertions(+), 9 deletions(-)
> create mode 100644 arch/arm/lib/bootm-optee=2ES
>
>diff --git a/arch/arm/include/asm/armv7=2Eh b/arch/arm/include/asm/armv7=
=2Eh
>index c002998ac0b=2E=2Ebfffbbd5d9a 100644
>--- a/arch/arm/include/asm/armv7=2Eh
>+++ b/arch/arm/include/asm/armv7=2Eh
>@@ -142,6 +142,8 @@ bool armv7_boot_nonsec(void);
> unsigned int _nonsec_init(void);
> void _do_nonsec_entry(void *target_pc, unsigned long r0,
> 		      unsigned long r1, unsigned long r2);
>+void boot_jump_linux_via_optee(void *target_pc, unsigned long r1,
>+			       unsigned long r2, unsigned long tee_entry);
> void _smp_pen(void);
>=20
> extern char __secure_start[];
>diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
>index ade42d0ca43=2E=2E92149d7058c 100644
>--- a/arch/arm/lib/Makefile
>+++ b/arch/arm/lib/Makefile
>@@ -41,6 +41,9 @@ obj-$(CONFIG_CMD_BOOTZ) +=3D zimage=2Eo
> endif
> obj-$(CONFIG_OF_LIBFDT) +=3D bootm-fdt=2Eo
> endif
>+ifndef CONFIG_ARM64
>+obj-$(CONFIG_BOOTM_OPTEE) +=3D bootm-optee=2Eo
>+endif
> ifdef CONFIG_ARM64
> obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMSET) +=3D memset-arm64=2Eo
> obj-$(CONFIG_$(PHASE_)USE_ARCH_MEMCPY) +=3D memcpy-arm64=2Eo
>diff --git a/arch/arm/lib/bootm-optee=2ES b/arch/arm/lib/bootm-optee=2ES
>new file mode 100644
>index 00000000000=2E=2E9d1a77b563d
>--- /dev/null
>+++ b/arch/arm/lib/bootm-optee=2ES
>@@ -0,0 +1,30 @@
>+/* SPDX-License-Identifier: GPL-2=2E0+ */
>+/*
>+ *  Copyright (C) 2025 Marek Vasut
>+ */
>+#include <config=2Eh>
>+#include <linux/linkage=2Eh>
>+
>+ENTRY(boot_jump_linux_via_optee)
>+	mov	r4, r3
>+	mov	lr, r0
>+	mov	r3, #0
>+	mov	r0, #0
>+
>+	/*
>+	 * Special TZC handling on this platform, the last
>+	 * 'str' has to be immediately before 'bx' and can
>+	 * not be interleaved with any return from function
>+	 * call, if it is then the system hangs=2E
>+	 */
>+#if defined(CONFIG_STM32MP13X) && !defined(CONFIG_TFABOOT)
>+	ldr	r6, =3DSTM32_TZC_BASE + 0x114 + (0x20 * 2)
>+	mov	r7, #0x0
>+	str	r7, [r6]
>+	ldr	r6, =3DSTM32_TZC_BASE + 0x110 + (0x20 * 1)
>+	mov	r7, #0x1
>+	str	r7, [r6]
>+#endif
>+
>+	bx	r4
>+ENDPROC(boot_jump_linux_via_optee)
>diff --git a/arch/arm/lib/bootm=2Ec b/arch/arm/lib/bootm=2Ec
>index 7eb764e1f4e=2E=2E82a2c9f2499 100644
>--- a/arch/arm/lib/bootm=2Ec
>+++ b/arch/arm/lib/bootm=2Ec
>@@ -258,6 +258,11 @@ bool armv7_boot_nonsec(void)
>=20
> 	return nonsec;
> }
>+#else
>+bool armv7_boot_nonsec(void)
>+{
>+	return false;
>+}
> #endif
>=20
> #ifdef CONFIG_ARM64
>@@ -283,9 +288,9 @@ static void switch_to_el1(void)
> #endif
>=20
> /* Subcommand: GO */
>+#ifdef CONFIG_ARM64
> static void boot_jump_linux(struct bootm_headers *images, int flag)
> {
>-#ifdef CONFIG_ARM64
> 	void (*kernel_entry)(void *fdt_addr, void *res0, void *res1,
> 			void *res2);
> 	int fake =3D (flag & BOOTM_STATE_OS_FAKE_GO);
>@@ -323,7 +328,13 @@ static void boot_jump_linux(struct bootm_headers *im=
ages, int flag)
> 					    ES_TO_AARCH64);
> #endif
> 	}
>+}
> #else
>+static __maybe_unused bool boot_jump_via_optee;
>+static __maybe_unused unsigned long boot_jump_via_optee_addr;
>+
>+static void boot_jump_linux(struct bootm_headers *images, int flag)
>+{
> 	unsigned long machid =3D gd->bd->bi_arch_number;
> 	char *s;
> 	void (*kernel_entry)(int zero, int arch, uint params);
>@@ -335,6 +346,13 @@ static void boot_jump_linux(struct bootm_headers *im=
ages, int flag)
> 	ulong addr =3D (ulong)kernel_entry | 1;
> 	kernel_entry =3D (void *)addr;
> #endif
>+
>+	if (IS_ENABLED(CONFIG_ARMV7_NONSEC) && armv7_boot_nonsec() &&
>+	    boot_jump_via_optee) {
>+		printf("Cannot start OpTee-OS from NS\n");
>+		return;
>+	}
>+
> 	s =3D env_get("machid");
> 	if (s) {
> 		if (strict_strtoul(s, 16, &machid) < 0) {
>@@ -354,19 +372,39 @@ static void boot_jump_linux(struct bootm_headers *i=
mages, int flag)
> 	else
> 		r2 =3D gd->bd->bi_boot_params;
>=20
>-	if (!fake) {
>+	if (fake)
>+		return;
>+
> #ifdef CONFIG_ARMV7_NONSEC
>-		if (armv7_boot_nonsec()) {
>-			armv7_init_nonsec();
>-			secure_ram_addr(_do_nonsec_entry)(kernel_entry,
>-							  0, machid, r2);
>-		} else
>+	if (armv7_boot_nonsec())
>+		armv7_init_nonsec();
> #endif
>-			kernel_entry(0, machid, r2);
>-	}
>+
>+#ifdef CONFIG_BOOTM_OPTEE
>+	if (boot_jump_via_optee)
>+		boot_jump_linux_via_optee(kernel_entry, machid, r2, boot_jump_via_opte=
e_addr);
>+#endif
>+
>+#ifdef CONFIG_ARMV7_NONSEC
>+	if (armv7_boot_nonsec()) {
>+		secure_ram_addr(_do_nonsec_entry)(kernel_entry, 0, machid, r2);
>+	} else
> #endif
>+	{
>+		kernel_entry(0, machid, r2);
>+	}
> }
>=20
>+#ifndef CONFIG_TI_SECURE_DEVICE
>+static void arch_tee_image_process(ulong image, size_t size)
>+{
>+	boot_jump_via_optee =3D true;
>+	boot_jump_via_optee_addr =3D image;
>+}
>+U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TEE, arch_tee_image_process);
>+#endif
>+#endif
>+
> /* Main Entry point for arm bootm implementation
>  *
>  * Modeled after the powerpc implementation

