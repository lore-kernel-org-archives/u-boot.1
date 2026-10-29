Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1D606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UWwndPnT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=VFE0PuIu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F7C34075D;
	Thu, 29 Oct 2026 05:11:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLu9CL9ptwJq; Thu, 29 Oct 2026 05:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A61C0403C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250697;
	b=giFslphQhK7Ig2iEraYvKnjtBNEiaSwS/JL9A8/9gPKTmwXdv6n2RvWMwJMcM9isDfQR
	 NNsOXrxf974PJFDG/8q8SsD7agGZVGJyZ99P3xW0pq8wPfVSDcQlObse6Kfhvb+F9AzYN
	 a6uPwAdK5UYuZ3Phb0k9/065WFUh/X63D/ruZx9b2HU8ihG61C8JEfaE2FpaZxZDFkwDm
	 wqOiLGXunHqKYz7KltTz1egUMvL4qelSY7852z+UFbVVltP8cg5nXxNVjxfRuoWXOIc+N
	 wtKBymUiBmWlLx8FNNX4tNCkpHVj/U7YIYY3Z47CVngY9ysakB2RkmNXsxJTXGWg1eA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lfzlNW/kJqnRHW1LIsqbZ6sl1gtNMNq3J8OxrYcWdBM=;
	b=dDaMWsnl/hWA+zZArEMw1i2sVK4NpIa9DlGTB3ymeCY1XD/mfuBsF52s7BRiK4Mi1lsd
	 9+8DjLPkqSZF9MEFMfW2NICya83t8KAREfP/fDCjALL4h8WvqAZjFJ0cUHqK9737Uy6xx
	 ST67yoZKzvFYoOPl7LvlVpXaC/aREGqyv49+KhMUJdFb5WtV1UnJEYkVMXlgYkZMUxp8J
	 KUYfpa8z/R/wcizryo/H2/qlnYiUVO/lAZZf7ddA+Yt/FVBCxHb2Dv7Ez6/+Ya8Ss7VbK
	 8GRtb1GMA8B87Q9ITgBaFzFVReHfjaffVk9HVshid8HHoXYIEOnCb05IyT5RH4PkdhA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250697;
	bh=lfzlNW/kJqnRHW1LIsqbZ6sl1gtNMNq3J8OxrYcWdBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UWwndPnTvgdH2uN0t4YJMITYvEYEuK7NXTVv/bulqGum6t2vxiIwywIjw7MciXsLi
	 GTk2tLoUWwAsOtTvZC1j1IHeSe1pYKwE7nNZ+b4p7XQA7afjrZr8Se1nCvc0oONus4
	 EUqKVjRQ4N6Ch/cEAEh78CHV4fmdtgB8RIw298oJS3CZWkgKh1MaWbckmGvjRc3B/3
	 D7tm2czFrJKZRxLmHnTli+SyGqbCEd03ySJIcHcURTiCfaDbPyhe5BvdiAopQR13qm
	 I+kYT+WOpGxt4FBXNBlfeoAtbbcKlW+nde6oUGejhn/E8a6pTmkfV9eFxtNCs8Kt1Q
	 iZEw4nLE7PjIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A61C0403C4;
	Thu, 29 Oct 2026 05:11:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E760B1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D992980F90
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4EXfUTobhoZk for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:11:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F05780F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250694;
 b=KuM89Sg39yHzrLbnd8SKaDwmZdaSNuNA6eDa5IjBzH8Dah2mGPiZ53+li67qZyVIJyq7
 ++R7EDh5Nth+OdqsEi3QLLeE3fvF/7rbsX5c9f6J+WDDvadS368M24zrvU4e0Wttp+yed
 7mM5UerIrQv9Pd2Ia7D5SxAd43hlv4mdVVJZIBQk/M1C74d2Qo1I/ytHCKtzoW4XeqGw0
 Dz5b7gN1cmgmLXfZfi6fT6Dpb89RDnfJ+gpSuP6mPto0Bugzd2ErTi7rmOfyfjNtNWeMa
 FIrHVuntn0jbaHC4SEGPaH5pm7tjqkLmz/jqPEnrCWZpPHYwtkJ2MPvzpU28Q1gadog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250694;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=lfzlNW/kJqnRHW1LIsqbZ6sl1gtNMNq3J8OxrYcWdBM=;
 b=OD3u1iwTu7Pi1uskvVO72kk8fo2ZhTLuoe3mHb6TGyyHER0euwhix3sEzHLvuh9YMcpC
 kmY1kwot+XhFsJ9NKgV9LSeb+2yl+hb8Frtiu5mZoLmSVNgBkdGEgEnSPV9hU9Mrq6/QR
 PQjWsivNYbTFdEwdEkZCz/hy7m3B4DodIXSfC4NXErwVTzTaQt8jvmhy8hRhv/HUBaAuc
 1gJ5InU7eynwat58OEQZrZNcMeRsXTkd07x0wyCYBdfgMYEQ3k3PNPahjfolq00tYEaWT
 Q/YckT+yraIuoiycwJn7v1PDcBXHjK+vO8wJwoRG46P+9IP3C7W8Le+dcglkhWhLt7w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=VFE0PuIu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=VFE0PuIu
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F05780F71
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250687; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O+2hgaFFSPHUTFQyvANeB6h6381LfdSVSc9dO5DiPIbiPt2hksnnYpGBu1nujSsP4dVyDHLd04KI1RV8cXq+1DtgY6a/+Uc/DPum4AusIvO5XaBrFn+A3WzKBCDvd5pY1kqZaaEqbVqM5apGxvyYRwNJxA/flVZelINWTHPoTZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250687;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lfzlNW/kJqnRHW1LIsqbZ6sl1gtNMNq3J8OxrYcWdBM=; 
 b=EdeyDfjlDPP/h3ekoTWeFbTGJoJBrarpLtlJlQF4NkVXUg1ceigrGUmL04UGzdv/NWN7EmQ8SmRTfNmQF21OpAsB0u6Bsbv4rW/++++Nw6IefBY5RPOemTMdBVM75zCClPQQyNcnDAlnqFxID2OVzhkCS6RijTWAFADwrnsbZ7o=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=VFE0PuIu7Mmsdt1FsAQw94bWVppnHh3khsO0gtYLA5X+vqFhcBk4Rfw3rbItk7oPTeDhKn01BNMyFcsk1mfrgFkbP3jOW7v2rg3SIXeggZazBWKGTatFtkREvJLtLJZejXpnsFVvu57G8ohwg0NWkOJUXwe2AG1U3q4I+6L88go=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=lfzlNW/kJqnRHW1LIsqbZ6sl1gtNMNq3J8OxrYcWdBM=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250685790794.7684578375248;
 Wed, 28 Oct 2026 22:11:25 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 16/20] efi: LoongArch: Define LoongArch bits everywhere
Date: Thu, 29 Oct 2026 05:07:33 +0000
Message-ID: <20261029050738.1107663-17-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Add PE machine type, removable boot image name, vendor class identifier,
client architecture identifier, relative ELF relocation, and undefined
instruction for LoongArch. They are all coming from UEFI specification,
PE-COFF specification, or IANA websites.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v3

Changed from v2
- Describe what has been added in commit message
- Drop extra paretheses in elif condition in config_distro_bootcmd.h
- Define IMAGE_REL_BASED_LOONGARCH32_MARK_LA as well in include/pe.h

Changed from v1
- Reword commit message, replacing "PE spec" with "PE-COFF specification"
- Replace obsolete __loongarch64 macro with __loongarch__ and
  __loongarch_grlen
- Use a true undefined instruction in efi_selftest_miniapp_exception.c
- Define HOST_BOOTEFI_NAME and HOST_PXE_ARCH
- Introduce definition for IMAGE_REL_BASEd_LOONGARCH64_MARK_LA
---
 include/asm-generic/pe.h                          | 2 ++
 include/config_distro_bootcmd.h                   | 5 +++++
 include/pe.h                                      | 2 ++
 lib/efi_loader/efi_helper.c                       | 4 ++++
 lib/efi_loader/efi_image_loader.c                 | 7 +++++++
 lib/efi_loader/efi_runtime.c                      | 4 ++++
 lib/efi_selftest/efi_selftest_miniapp_exception.c | 3 +++
 7 files changed, 27 insertions(+)

diff --git a/include/asm-generic/pe.h b/include/asm-generic/pe.h
index cd5b6ad62bf0..fb93f2621715 100644
--- a/include/asm-generic/pe.h
+++ b/include/asm-generic/pe.h
@@ -38,6 +38,8 @@
 #define IMAGE_FILE_MACHINE_ARM64		0xaa64
 #define IMAGE_FILE_MACHINE_RISCV32		0x5032
 #define IMAGE_FILE_MACHINE_RISCV64		0x5064
+#define IMAGE_FILE_MACHINE_LOONGARCH32	0x6232
+#define IMAGE_FILE_MACHINE_LOONGARCH64	0x6264
 
 /* Header magic constants */
 #define IMAGE_NT_OPTIONAL_HDR32_MAGIC		0x010b
diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 8d6f80a0ce5c..0eb6bd742b9f 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -118,6 +118,8 @@
 #define BOOTEFI_NAME "bootriscv32.efi"
 #elif defined(CONFIG_ARCH_RV64I)
 #define BOOTEFI_NAME "bootriscv64.efi"
+#elif defined(CONFIG_ARCH_LA64)
+#define BOOTEFI_NAME "bootloongarch64.efi"
 #endif
 #endif
 
@@ -371,6 +373,9 @@
 #elif defined(CONFIG_ARCH_RV64I) || ((defined(__riscv) && __riscv_xlen == 64))
 #define BOOTENV_EFI_PXE_ARCH "0x1b"
 #define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00027:UNDI:003000"
+#elif defined(CONFIG_ARCH_LA64) || (defined(__loongarch__) && __loongarch_grlen == 64)
+#define BOOTENV_EFI_PXE_ARCH "0x27"
+#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00039:UNDI:003000"
 #elif defined(CONFIG_SANDBOX)
 # error "sandbox EFI support is only supported on ARM and x86"
 #else
diff --git a/include/pe.h b/include/pe.h
index 086f2b860e99..eac9eb25ce47 100644
--- a/include/pe.h
+++ b/include/pe.h
@@ -194,6 +194,8 @@ typedef struct _IMAGE_RELOCATION
 #define IMAGE_REL_BASED_THUMB_MOV32             7 /* yes, 7 too */
 #define IMAGE_REL_BASED_RISCV_LOW12I		7 /* yes, 7 too */
 #define IMAGE_REL_BASED_RISCV_LOW12S		8
+#define IMAGE_REL_BASED_LOONGARCH32_MARK_LA	8 /* yes, 8 too */
+#define IMAGE_REL_BASED_LOONGARCH64_MARK_LA	8 /* yes, 8 too */
 #define IMAGE_REL_BASED_MIPS_JMPADDR16          9
 #define IMAGE_REL_BASED_IA64_IMM64              9 /* yes, 9 too */
 #define IMAGE_REL_BASED_DIR64                   10
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 44b806aadc4f..bc48e265b901 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -62,6 +62,8 @@
 #define BOOTEFI_NAME "BOOTRISCV32.EFI"
 #elif defined(CONFIG_ARCH_RV64I)
 #define BOOTEFI_NAME "BOOTRISCV64.EFI"
+#elif defined(CONFIG_ARCH_LA64)
+#define BOOTEFI_NAME "BOOTLOONGARCH64.EFI"
 #else
 #error Unsupported UEFI architecture
 #endif
@@ -94,6 +96,8 @@ int efi_get_pxe_arch(void)
 		return 0x19;
 	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
 		return 0x1b;
+	else if (IS_ENABLED(CONFIG_ARCH_LA64))
+		return 0x27;
 
 	return -EINVAL;
 }
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index f9a2d2df405d..bed5f1817266 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -51,6 +51,13 @@ static int machines[] = {
 #if defined(__riscv) && (__riscv_xlen == 64)
 	IMAGE_FILE_MACHINE_RISCV64,
 #endif
+
+#if defined(__loongarch__) && __loongarch_grlen == 64
+	IMAGE_FILE_MACHINE_LOONGARCH64,
+#endif
+#if defined(__loongarch__) && __loongarch_grlen == 32
+	IMAGE_FILE_MACHINE_LOONGARCH32,
+#endif
 	0 };
 
 /**
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 73d4097464c0..de50d72d634a 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -78,6 +78,10 @@ struct dyn_sym {
 #else
 #error unknown riscv target
 #endif
+#elif defined(__loongarch__)
+#define R_RELATIVE	R_LARCH_RELATIVE
+#define R_MASK		0xffffffffULL
+#define IS_RELA		1
 #else
 #error Need to add relocation awareness
 #endif
diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi_selftest/efi_selftest_miniapp_exception.c
index f668cdac4ab2..648206c17098 100644
--- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
+++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c
@@ -35,6 +35,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 	asm volatile (".word 0xffffffff\n");
 #elif defined(CONFIG_X86)
 	asm volatile (".word 0xffff\n");
+#elif defined(CONFIG_LOONGARCH)
+	/* ud 31 */
+	asm volatile (".word 0x386007ff\n");
 #elif defined(CONFIG_SANDBOX)
 #if (HOST_ARCH == HOST_ARCH_ARM || HOST_ARCH == HOST_ARCH_AARCH64)
 	asm volatile (".word 0xe7f7defb\n");
-- 
2.56.0

