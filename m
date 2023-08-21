Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279C0EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 07:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8626A8702E;
	Mon, 21 Aug 2023 09:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F2987048; Mon, 21 Aug 2023 09:29:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 51ADA8695F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 09:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81A8B2F4;
 Mon, 21 Aug 2023 00:30:15 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8298C3F740;
 Mon, 21 Aug 2023 00:29:32 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 3/6] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
Date: Mon, 21 Aug 2023 12:59:06 +0530
Message-Id: <20230821072909.2387400-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821072909.2387400-1-sughosh.ganu@linaro.org>
References: <20230821072909.2387400-1-sughosh.ganu@linaro.org>
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

The EFI capsule authentication logic in u-boot expects the public key
in the form of an EFI Signature List(ESL) to be provided as part of
the platform's dtb. Currently, the embedding of the ESL file into the
dtb needs to be done manually.

Add a target for generating a dtsi file which contains the signature
node with the ESL file included as a property under the signature
node. Include the dtsi file in the dtb. This brings the embedding of
the ESL in the dtb into the U-Boot build flow.

The path to the ESL file is specified through the
CONFIG_EFI_CAPSULE_ESL_FILE symbol.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes since V2: None

 lib/efi_loader/Kconfig             |  8 ++++++++
 lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
 scripts/Makefile.lib               | 15 +++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 lib/efi_loader/capsule_esl.dtsi.in

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 9989e3f384..d20aaab6db 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -272,6 +272,14 @@ config EFI_CAPSULE_MAX
 	  Select the max capsule index value used for capsule report
 	  variables. This value is used to create CapsuleMax variable.
 
+config EFI_CAPSULE_ESL_FILE
+	string "Path to the EFI Signature List File"
+	depends on EFI_CAPSULE_AUTHENTICATE
+	help
+	  Provides the path to the EFI Signature List file which will
+	  be embedded in the platform's device tree and used for
+	  capsule authentication at the time of capsule update.
+
 config EFI_DEVICE_PATH_TO_TEXT
 	bool "Device path to text protocol"
 	default y
diff --git a/lib/efi_loader/capsule_esl.dtsi.in b/lib/efi_loader/capsule_esl.dtsi.in
new file mode 100644
index 0000000000..61a9f2b25e
--- /dev/null
+++ b/lib/efi_loader/capsule_esl.dtsi.in
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+/**
+ * Devicetree file with the public key EFI Signature List(ESL)
+ * node. This file is used to generate the dtsi file to be
+ * included into the DTB.
+*/
+/ {
+	signature {
+		capsule-key = /incbin/("ESL_BIN_FILE");
+	};
+};
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8c5e25c31c..3cec46bb15 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -334,6 +334,21 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 		; \
 	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
+quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
+cmd_capsule_esl_gen = \
+	$(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_input_file) > $@)
+
+$(obj)/.capsule_esl.dtsi:
+	$(call cmd_capsule_esl_gen)
+
+capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
+capsule_esl_dtsi = .capsule_esl.dtsi
+capsule_esl_path=$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_ESL_FILE)))
+
+ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
+dtsi_include_list += $(capsule_esl_dtsi)
+endif
+
 dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
 
 $(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
-- 
2.34.1

