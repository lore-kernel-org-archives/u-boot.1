Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A5606A887
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pf1cJXJg;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=dVZFHgnZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43E3160EC1;
	Fri, 13 Nov 2026 02:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yYmysBpLGFV5; Fri, 13 Nov 2026 02:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A79860E8A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537225;
	b=bYuch6uMa9UYGYZLCgbdyfli0ne9gsqKtAggRV91mtUDy1aynWvjKkf/nF2ywPuGPfWf
	 khwcZ2XID8RAsP+eLGwFA8u3PdXicr8fM5m79mgH8RVGHwFhrW0Ka7Cx7CE/Qt/VCxaRg
	 jdd7/4/aMjxIpoj+pGQgsTMwwZhrJbGUs8auhjUNfCr0v0IeTBSlpY7S0oTY2Lx7d6JLI
	 DVuY6ba1BhdJuGLDyUc4JMUyVZhiqnc2Kfm6OVmmxPHiJCTQhFq9XpV+I/WmUDHAMdOQ5
	 UFpi6lFIhgj+DmyGx25gV/8D8sJlLNzVAsNgLYRu4/lneS0LvY+KF7GjilQ6mX7NwqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537225;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=unrczy5PQEYE5BxHtwdDQuDUdjXeDqpqqC5mgLsiAtg=;
	b=Vk7rqxl4/n+MWnq1v+4GLcOBitPtKx/r1UgzHwhYp2f6XbyC2s60hOaG/3qhObpucu6f
	 DMM6qmMxGnpMy6SRZmXW6B/nkOTBZRlMzOygqxbrsCNCdwuRsHuaqChyKqxZb3eeLSU0o
	 IqJHjE6qpifO6Q+w7QCQBIogn8akj37Vfrk/LZfp25Lv1MC6+yBgZTJW/IWzw0gmvPjn8
	 oxTg8r9m0LibX7+G/H2j+SR/XnBPfcQhHsX9Z/s2AM54B8AddxjtmgXipaK/fxOvWvKlQ
	 J4FDd9EuMTqGIgCC4x70PhMVuUV9D76oIGVDe6JFq9tIjBAS0/F7wgVUkscYhL3tbsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=dVZFHgnZ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537225;
	bh=unrczy5PQEYE5BxHtwdDQuDUdjXeDqpqqC5mgLsiAtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pf1cJXJgcaRd1UaW8wvNFQ7fxBAWiapj/LcSqfg68dL7TkVQ8sB9nX+yqlE8mmzwf
	 WnU30ksmeIQU10lATcOVv6Y9PCawUjgKacsf990Rvlagk09IUD4nqMUd2qF2eXPugj
	 73SKOniBdDa0aA/3lmx9PHqH6xhu2NTpg2FovFvw6C02fP9b/m4tUM+xetk7RAJKdL
	 1i2xxvNoUBB4Fr0FUGQtpL5J9uRaWiYBNCHXm4zXtiYabp3R1T+UJ2ykVxeXnR0mad
	 zgG4rBbtdxsB75f3/RwQ1R0uFD8UpJ44Ve6rP+6xKWvFjvDd2NGPt8Ga72j5NbrhTm
	 eV7BpwAHbKxhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A79860E8A;
	Fri, 13 Nov 2026 02:33:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ECA3E2E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE56960E8A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 749mXis-_z3N for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A1A8E60EC0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=dVZFHgnZ
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1A8E60EC0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:42 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 894334C8BC;
 Fri, 13 Nov 2026 13:33:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unrczy5PQEYE5BxHtwdDQuDUdjXeDqpqqC5mgLsiAtg=;
 b=dVZFHgnZPHzyXMMRd5BQBSAJK45dpkaYdLYYug0tc9WlBgW2/eLPy/UueY9gZbAUEWypSi
 cDpR4e148sEWk3mRaBb1KHUslj8rj17JM38MDVfo/AJy5de2xaWc1YIBEn2I2feprCeH/i
 qh7htqQxdDskcSAJu1FDJG6KWMF/qxziqEmZX0o3xoRmuh38iDWZvvvIu7sBovo4ifFB4X
 n+ZoCXFbOJWxoHokVD7Wtte0rT2pBkh4EhvZ24/8rfMB08LqbZsACdSuh7E0zLY21a+dWE
 dKE5xP5rKzo44Go4j1jG2bmb02xKPhoddg/ehkgqnPxIHGGt3zCr0+Z7gUBHuA==
X-GPT-Reason: legitimate; This is a technical, developer-oriented
 software patch (Linux kernel/U-Boot style) sent from a known personal
 domain (alastair@d-silva.org) to a matching mailbox (alastair@d-silva.org),
 which perfectly aligns with the personal/professional context
 of the user. The content is highly specific, technical, and contains
 no marketing, phishing, or scareware signals; furthermore, the From
 domain matches the sender's identity and the lack of external
 URLs or urgency tactics confirms a non-malicious, functional communication.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 12/26] arm64: spl: Support disposable .init.rodata section
 after _image_binary_end
Date: Fri, 13 Nov 2026 13:32:22 +1100
Message-ID: <20261113023236.569054-13-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some SoCs with tight SRAM budgets (such as Allwinner A733, where TF-A
BL31 loads into SRAM A2 at 0x00058000) carry large one-time DRAM
initialization tables and PHY firmware in SPL that are never referenced
after DRAM bringup completes.

Add CONFIG_SPL_DISPOSABLE_INIT_RODATA and CONFIG_SPL_ACTIVE_MAX_SIZE so
ARM64 SPL builds with separate BSS and no SPL DT append can emit
.init.rodata immediately after _image_binary_end, copy it into
u-boot-spl-nodtb.bin via SPL_OBJCFLAGS, and enforce a linker ASSERT on
the active SPL ceiling before the reclaimable region begins.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/config.mk                |  4 ++++
 arch/arm/cpu/armv8/u-boot-spl.lds | 20 ++++++++++++++++++++
 arch/arm/cpu/armv8/u-boot.lds     |  1 +
 common/spl/Kconfig                | 18 ++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index bce9a31e966..9f76e70bd21 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -165,6 +165,10 @@ endif
 # 2) unit tests include device tree blobs
 OBJCOPYFLAGS += -j .dtb.init.rodata
 
+ifeq ($(CONFIG_SPL_DISPOSABLE_INIT_RODATA),y)
+SPL_OBJCFLAGS += -j .init.rodata
+endif
+
 ifdef CONFIG_EFI_LOADER
 OBJCOPYFLAGS += -j .efi_runtime -j .efi_runtime_rel
 endif
diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index 39020a1fddd..3feeb73ff04 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -33,6 +33,9 @@ SECTIONS
 	.rodata : {
 		. = ALIGN(8);
 		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
+#if !CONFIG_IS_ENABLED(DISPOSABLE_INIT_RODATA)
+		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.init.rodata*)))
+#endif
 	} >.sram
 
 	.data : {
@@ -67,6 +70,18 @@ SECTIONS
 	_end = .;
 	_image_binary_end = .;
 
+#if CONFIG_IS_ENABLED(DISPOSABLE_INIT_RODATA)
+	/*
+	 * Disposable early-init read-only tables (e.g. DRAM PHY firmware/tables)
+	 * placed after _image_binary_end so subsequent firmware loads (such as
+	 * TF-A BL31) can reclaim this SRAM region once early bringup completes.
+	 */
+	.init.rodata : {
+		. = ALIGN(8);
+		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.init.rodata*)))
+	} >.sram
+#endif
+
 #ifdef CONFIG_SPL_SEPARATE_BSS
 	.bss : {
 		__bss_start = .;
@@ -102,3 +117,8 @@ ASSERT(_image_binary_end % 8 == 0, \
 
 ASSERT(ADDR(.bss) % 8 == 0, \
        ".bss must be 8-byte aligned");
+
+#if CONFIG_IS_ENABLED(DISPOSABLE_INIT_RODATA) && CONFIG_SPL_ACTIVE_MAX_SIZE > 0
+ASSERT(_image_binary_end - __image_copy_start <= CONFIG_SPL_ACTIVE_MAX_SIZE, \
+       "SPL active binary exceeds CONFIG_SPL_ACTIVE_MAX_SIZE");
+#endif
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 231ab28b50c..55ad4c5feea 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -120,6 +120,7 @@ SECTIONS
 #endif
 		__start_rodata = .;
 		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
+		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.init.rodata*)))
 	}
 
 	__u_boot_list ALIGN(8) : {
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4930ecb0861..170578ef895 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -86,6 +86,24 @@ config SPL_MAX_SIZE
 	  sections), BSS excluded.  When defined, the linker checks that the
 	  actual size does not exceed it.
 
+config SPL_DISPOSABLE_INIT_RODATA
+	bool
+	depends on ARM64 && SPL_SEPARATE_BSS && !SPL_OF_CONTROL
+	help
+	  Place .init.rodata* sections after _image_binary_end in the SPL
+	  SRAM image so one-time initialization tables (such as DRAM PHY
+	  firmware) can be reclaimed by subsequent firmware stages (e.g.
+	  TF-A BL31) once early hardware bringup completes.
+
+config SPL_ACTIVE_MAX_SIZE
+	hex
+	depends on SPL_DISPOSABLE_INIT_RODATA
+	default 0x0
+	help
+	  When non-zero, maximum size in bytes of the active SPL image
+	  (_image_binary_end - __image_copy_start) before the disposable
+	  .init.rodata region begins.
+
 config SPL_PAD_TO
 	hex "Offset to which the SPL should be padded before appending the SPL payload"
 	default 0x7f8000 if ARCH_ROCKCHIP
-- 
2.53.0

