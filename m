Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3760C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F088823C;
	Fri, 17 May 2024 18:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="XGIIIqEh";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="B65TBClY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2235884A6; Fri, 17 May 2024 18:33:07 +0200 (CEST)
Received: from fhigh6-smtp.messagingengine.com
 (fhigh6-smtp.messagingengine.com [103.168.172.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94298823C
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 2E24911400F6;
 Fri, 17 May 2024 12:33:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 17 May 2024 12:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715963585;
 x=1716049985; bh=wDMZ5fL1zK7hQ0sYEoPzOwANfLzLJ/dU8A77uRPNvHc=; b=
 XGIIIqEhFx0DKP/2kmY3qNMDsnXvEk49w0puuu0bn4AwbfoB/PXKw4CiSa9hyr5p
 ZJqRfzdGyB1btsXxSjdgA+qEu/wWkWUlxfS9X770ZsBY5Q6r590ZDDksatGHo6/N
 mVpkppeR8RohZPMe5hDM+P9TSq388pALdsn3CIzDyp44lrZLO27ntgBB4ZZM0hRH
 oavnFljK5Xj8Kmetf6tpgwtbxvRMHLPFBi/VL+Jw9fNUiUSHHBPXtnYlFGHoph6c
 FkN73iM99MwSG8BaiFaLqCwFh/leQ33GX7SGBm3z2UeMdsC7d7hFyAlQfnan8YrI
 Krdu9qIX7j90LSguUDTWKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715963585; x=
 1716049985; bh=wDMZ5fL1zK7hQ0sYEoPzOwANfLzLJ/dU8A77uRPNvHc=; b=B
 65TBClY2Y6ZAZWTv4O4chge27tddF+LPGdCCZiKe8aNuP3Wt2Ed9nRsvMp9XD/ef
 dD2vJW2h9Lla5Z04dOB+lEvlQkOlKpm3ZFSKiALnAmjPRgefDRxUsvtq2msB50TP
 HXboO8ZI54Xs4fs6sR7EwGRAt7xa6s/0IN2FkXtsc1sTn1iIy5ZsiQfn4Cvw5H1P
 dgTDGzsRK2zp/mGYjsC2DEszeaGH0+z42R2NnIh6ufJ4McH//nC2wi4CtP9helzh
 RMvyiI4zbNVoK0bCIfyoHBSGA6IexGvf3Kyc4p/5VaoZYM+BPGNTeBEKHxww1w+w
 rh1v/8TnvGGSC+0hwRc8A==
X-ME-Sender: <xms:wIZHZpvtdIakGwNJI3z_KD32DuAPstkDrKQI77pqfn846YTavFQRsw>
 <xme:wIZHZieJHAqbV2j_VbFxJmrGTnSrZ-6nJBs452Yw3JMo-N-6LQLv6Up-ksO6MkuyT
 Oyi4XVF5Pl-ZUS1dyo>
X-ME-Received: <xmr:wIZHZszHsyoODa6IOJCmKo_H5a7aUhSpbe82GtQd5x_dQ2gY3RewvmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wIZHZgPGABHSgCNP7TfjzIWVQxlJ9Ly0fPXMys7_GW5Ny0fGz98Rcw>
 <xmx:wIZHZp_FQlDiCf1nCstm9scdGoLwen8DueHeqqpZmq7bzSuYA9nDMQ>
 <xmx:wIZHZgWbdbsw-Q1I7FpjNzpfVquZ8kuHJi_3QYYI_N_BkUHC092bGg>
 <xmx:wIZHZqcQkyuwDo72SK1h76f5CB9olU645JxJxqGFpcekPZMChUzAcw>
 <xmx:wYZHZpzvNIO9R7bGAXqhsQwPPWTS65Rd62RNkWIffMGJlhzJBTBgyzQN>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 12:33:03 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 17:32:57 +0100
Subject: [PATCH 6/7] MIPS: Define MIPS EFI related bits everywhere
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mips-efi-v1-6-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5330;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=gRrh0wPcAMiji1u8BqtMGh2DSmEwbGOa/emhtKeESCk=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3th1t/2XnNWrfOR4tfFJzVtM8ifATt3IWJzk635jIt
 P128AyxjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjINBVGhmVJDsfm3JG0tJ/j
 dWnCRbPHr+Smf+3JlUh9bXDx2zUL2ROMDCfTZGdwbUq1ery/S17s99dI1+lr+/w/V7Om3NT7fsq
 kggEA
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

Various file names, instruction defines, magic numbers
related to MIPS's EFI implementation.

PE magic numbers are from winnt.h, DHCP numbers are
from IANA page, boot file names are from other
implementations.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 include/asm-generic/pe.h                          |  5 +++++
 include/config_distro_bootcmd.h                   |  6 ++++++
 include/efi_default_filename.h                    |  8 ++++++++
 include/elf.h                                     |  8 ++++++++
 lib/efi_loader/efi_image_loader.c                 | 17 +++++++++++++++++
 lib/efi_selftest/efi_selftest_miniapp_exception.c |  2 ++
 6 files changed, 46 insertions(+)

diff --git a/include/asm-generic/pe.h b/include/asm-generic/pe.h
index cd5b6ad62bf0..42c4cbedbc95 100644
--- a/include/asm-generic/pe.h
+++ b/include/asm-generic/pe.h
@@ -31,6 +31,11 @@
 
 /* Machine types */
 #define IMAGE_FILE_MACHINE_I386			0x014c
+#define IMAGE_FILE_MACHINE_R3000_BE		0x0160
+#define IMAGE_FILE_MACHINE_R3000		0x0162
+#define IMAGE_FILE_MACHINE_R4000_BE		0x0164
+#define IMAGE_FILE_MACHINE_R4000		0x0166
+#define IMAGE_FILE_MACHINE_R10000		0x0168
 #define IMAGE_FILE_MACHINE_ARM			0x01c0
 #define IMAGE_FILE_MACHINE_THUMB		0x01c2
 #define IMAGE_FILE_MACHINE_ARMNT		0x01c4
diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 2a136b96a6d9..9e03d10acec5 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -366,6 +366,12 @@
 #elif defined(CONFIG_ARCH_RV64I) || ((defined(__riscv) && __riscv_xlen == 64))
 #define BOOTENV_EFI_PXE_ARCH "0x1b"
 #define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00027:UNDI:003000"
+#elif defined(CONFIG_CPU_MIPS32) || ((defined(__mips) && __mips == 32))
+#define BOOTENV_EFI_PXE_ARCH "0x21"
+#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00033:UNDI:003000"
+#elif defined(CONFIG_CPU_MIPS64) || ((defined(__mips) && __mips == 64))
+#define BOOTENV_EFI_PXE_ARCH "0x22"
+#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00034:UNDI:003000"
 #elif defined(CONFIG_SANDBOX)
 # error "sandbox EFI support is only supported on ARM and x86"
 #else
diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
index 77932984b557..eb94a54514bc 100644
--- a/include/efi_default_filename.h
+++ b/include/efi_default_filename.h
@@ -47,6 +47,14 @@
 #define BOOTEFI_NAME "BOOTRISCV32.EFI"
 #elif defined(CONFIG_ARCH_RV64I)
 #define BOOTEFI_NAME "BOOTRISCV64.EFI"
+#elif defined(CONFIG_CPU_MIPS32) && defined(CONFIG_SYS_BIG_ENDIAN)
+#define BOOTEFI_NAME "BOOTMIPS.EFI"
+#elif defined(CONFIG_CPU_MIPS32) && defined(CONFIG_SYS_LITTLE_ENDIAN)
+#define BOOTEFI_NAME "BOOTMIPSEL.EFI"
+#elif defined(CONFIG_CPU_MIPS64) && defined(CONFIG_SYS_BIG_ENDIAN)
+#define BOOTEFI_NAME "BOOTMIPS64.EFI"
+#elif defined(CONFIG_CPU_MIPS64) && defined(CONFIG_SYS_LITTLE_ENDIAN)
+#define BOOTEFI_NAME "BOOTMIPS64EL.EFI"
 #else
 #error Unsupported UEFI architecture
 #endif
diff --git a/include/elf.h b/include/elf.h
index a4ba74d8abeb..95de6ffbce31 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -545,6 +545,9 @@ typedef struct {
 #define DT_LOPROC	0x70000000	/* reserved range for processor */
 #define DT_HIPROC	0x7fffffff	/* specific dynamic array tags */
 
+/* MIPS */
+#define DT_MIPS_LOCAL_GOTNO	0x7000000a	/* Number of local got entries */
+
 /* Dynamic Tag Flags - d_un.d_val */
 #define DF_ORIGIN	0x01		/* Object may use DF_ORIGIN */
 #define DF_SYMBOLIC	0x02		/* Symbol resolutions starts here */
@@ -699,6 +702,11 @@ unsigned long elf_hash(const unsigned char *name);
 #define R_RISCV_64		2
 #define R_RISCV_RELATIVE	3
 
+/* MIPS Relocations */
+#define R_MIPS_NONE		0
+#define R_MIPS_REL32		3
+#define R_MIPS_64		18
+
 #ifndef __ASSEMBLY__
 int valid_elf_image(unsigned long addr);
 unsigned long load_elf64_image_phdr(unsigned long addr);
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index cedc4d822fe7..8df469851851 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -51,6 +51,23 @@ static int machines[] = {
 	IMAGE_FILE_MACHINE_RISCV64,
 #endif
 
+#if defined(__mips__) && (__mips == 32) && defined(__BIG_ENDIAN)
+	IMAGE_FILE_MACHINE_R3000_BE,
+#endif
+
+#if defined(__mips__) && (__mips == 32) && defined(__LITTLE_ENDIAN)
+	IMAGE_FILE_MACHINE_R3000,
+#endif
+
+#if defined(__mips__) && (__mips == 64) && defined(__BIG_ENDIAN)
+	IMAGE_FILE_MACHINE_R4000_BE,
+#endif
+
+#if defined(__mips__) && (__mips == 64) && defined(__LITTLE_ENDIAN)
+	IMAGE_FILE_MACHINE_R4000,
+	IMAGE_FILE_MACHINE_R10000,
+#endif
+
 	0 };
 
 /**
diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi_selftest/efi_selftest_miniapp_exception.c
index f668cdac4ab2..f3b4ee926f8f 100644
--- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
+++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c
@@ -33,6 +33,8 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 	asm volatile (".word 0xe7f7defb\n");
 #elif defined(CONFIG_RISCV)
 	asm volatile (".word 0xffffffff\n");
+#elif defined(CONFIG_MIPS)
+	asm volatile ("break 0xf\n");
 #elif defined(CONFIG_X86)
 	asm volatile (".word 0xffff\n");
 #elif defined(CONFIG_SANDBOX)

-- 
2.34.1

