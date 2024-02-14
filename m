Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB66C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 20:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B883871C0;
	Wed, 14 Feb 2024 21:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IGFCT6Qb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9319875E9; Wed, 14 Feb 2024 21:43:17 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550B186F67
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 21:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D82E740933; 
 Wed, 14 Feb 2024 20:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707943393;
 bh=E5fkNN3FDFFcM6W7pDTaiidYdEG8t6SAccml7dDra+g=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=IGFCT6Qb4tlb40mcL/TZctDFkFiSO5Mnvk5rLwyiL/Y7WLbugsK9hLp+Hpqx0A1A/
 bnRzMfrJehRQ0W/pRt44V88MP44QhmgN3tDtBAFciiliV+LDyXsePA2mcvWpUqXjCr
 W85nFVxOpOR/u/S2+2R6g912SGcIW1zyO/MrxcIpiTKgZ6FV1hOTzl9xDr1UJRZxlL
 aAkXHgs5HM6ar3sKYFCNE1vLLmbDJRmFoeraEAi6glvrhoLGaGCmKEtwlrPL7yZfJG
 XkLUkzwodlF7ogWuFR5txSALgqQKiiKHuo/TggluMbUIqzC1lavh1hUpo7H9TKdbCd
 LQs66HVP4eQDQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: set IMAGE_DLLCHARACTERISTICS_NX_COMPAT
Date: Wed, 14 Feb 2024 21:43:21 +0100
Message-ID: <20240214204321.24466-1-heinrich.schuchardt@canonical.com>
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

The IMAGE_DLLCHARACTERISTICS_NX_COMPAT flag marks an EFI binary where
the following conditions are met [1]:

* Executable and writable sections are separated.
* The application does not run self-modifying code.
* The application uses the EFI_MEMORY_ATTRIBUTE_PROTOCOL when loading
  executable code.
* The application does not assume that all memory ranges are usable.
* The stack is not expected to be executable.

The only EFI binaries U-Boot provides that do not fulfill these
requirements are the EFI app and the EFI payload.

Once we have implemented separation of writable and executable memory in
U-Boot we can use the IMAGE_DLLCHARACTERISTICS_NX_COMPAT flag to decide
if we will load an EFI binary.

[1] New UEFI CA memory mitigation requirements for signing
    https://techcommunity.microsoft.com/t5/hardware-dev-center/new-uefi-ca-memory-mitigation-requirements-for-signing/ba-p/3608714

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
The separation of executable and writable sections for armv7 EFI binaries
is provided by

[PATCH 1/1] arm: separate .data and .text sections of EFI binaries
https://lore.kernel.org/u-boot/20240214190625.13764-1-heinrich.schuchardt@canonical.com/T/#u
---
 arch/arm/lib/crt0_aarch64_efi.S | 4 ++++
 arch/arm/lib/crt0_arm_efi.S     | 4 ++++
 arch/riscv/lib/crt0_riscv_efi.S | 4 ++++
 include/asm-generic/pe.h        | 3 +++
 4 files changed, 15 insertions(+)

diff --git a/arch/arm/lib/crt0_aarch64_efi.S b/arch/arm/lib/crt0_aarch64_efi.S
index 3c2cef6ec7..fe6eca576e 100644
--- a/arch/arm/lib/crt0_aarch64_efi.S
+++ b/arch/arm/lib/crt0_aarch64_efi.S
@@ -66,7 +66,11 @@ extra_header_fields:
 	.long	_start - ImageBase		/* SizeOfHeaders */
 	.long	0				/* CheckSum */
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
+#if CONFIG_VENDOR_EFI
 	.short	0				/* DllCharacteristics */
+#else
+	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
+#endif
 	.quad	0				/* SizeOfStackReserve */
 	.quad	0				/* SizeOfStackCommit */
 	.quad	0				/* SizeOfHeapReserve */
diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index ba9fada500..afeff3f3fb 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -65,7 +65,11 @@ extra_header_fields:
 	.long	_start - image_base		/* SizeOfHeaders */
 	.long	0				/* CheckSum */
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION	/* Subsystem */
+#if CONFIG_VENDOR_EFI
 	.short	0				/* DllCharacteristics */
+#else
+	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
+#endif
 	.long	0				/* SizeOfStackReserve */
 	.long	0				/* SizeOfStackCommit */
 	.long	0				/* SizeOfHeapReserve */
diff --git a/arch/riscv/lib/crt0_riscv_efi.S b/arch/riscv/lib/crt0_riscv_efi.S
index 46b0855237..c7a4559eac 100644
--- a/arch/riscv/lib/crt0_riscv_efi.S
+++ b/arch/riscv/lib/crt0_riscv_efi.S
@@ -96,7 +96,11 @@ extra_header_fields:
 	.long	_start - ImageBase		/* SizeOfHeaders */
 	.long	0				/* CheckSum */
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
+#if CONFIG_VENDOR_EFI
 	.short	0				/* DllCharacteristics */
+#else
+	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
+#endif
 #if __riscv_xlen == 32
 	.long	0				/* SizeOfStackReserve */
 	.long	0				/* SizeOfStackCommit */
diff --git a/include/asm-generic/pe.h b/include/asm-generic/pe.h
index b9d674b6da..cd5b6ad62b 100644
--- a/include/asm-generic/pe.h
+++ b/include/asm-generic/pe.h
@@ -51,6 +51,9 @@
 #define IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER	12
 #define IMAGE_SUBSYSTEM_EFI_ROM			13
 
+/* DLL characteristics */
+#define IMAGE_DLLCHARACTERISTICS_NX_COMPAT	0x100
+
 /* Section flags */
 #define IMAGE_SCN_CNT_CODE			0x00000020
 #define IMAGE_SCN_CNT_INITIALIZED_DATA		0x00000040
-- 
2.43.0

