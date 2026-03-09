Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4C2F41810
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 16:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B6B83F6D;
	Mon,  9 Mar 2026 17:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7321383F59; Mon,  9 Mar 2026 17:36:57 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A6B1383F6E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBDD51570;
 Mon,  9 Mar 2026 09:36:47 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.13])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BAF43F7BD;
 Mon,  9 Mar 2026 09:36:53 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 3/4] cmd: efidebug: add ecpt command
Date: Mon,  9 Mar 2026 17:36:37 +0100
Message-ID: <20260309163638.2340548-3-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305161349.2317130-1-vincent.stehle@arm.com>
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add an "efidebug ecpt" command, to print the conformance profiles in the
ECPT:

  => efidebug ecpt
  cce33c35-74ac-4087-bce7-8b29b02eeb27  EFI EBBR 2.1 Conformance Profile

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Change log level to error and adapt the printed message (suggested by
  Heinrich)
- Also in that case, return an error code

 cmd/efidebug.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 109496d9e95..7b733119c82 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -533,6 +533,47 @@ static int do_efi_show_defaults(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+#if CONFIG_IS_ENABLED(EFI_ECPT)
+/**
+ * do_efi_show_ecpt() - show UEFI conformance profiles in ECPT
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ * Return:	CMD_RET_SUCCESS on success,
+ *		CMD_RET_USAGE or CMD_RET_FAILURE on failure
+ *
+ * Implement efidebug "ecpt" sub-command.
+ * Show all the UEFI Conformance Profiles listed in the EFI Conformance Profiles
+ * Table (ECPT).
+ */
+static int do_efi_show_ecpt(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	const struct efi_conformance_profiles_table *ecpt;
+	u16 n;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	ecpt = efi_get_configuration_table(&efi_ecpt_guid);
+	if (!ecpt) {
+		log_err("ECPT table missing\n");
+		return CMD_RET_FAILURE;
+	}
+
+	for (n = 0; n < ecpt->number_of_profiles; n++) {
+		const efi_guid_t *guid = &ecpt->conformance_profiles[n];
+
+		printf("%pUl  %s\n", guid->b,
+		       uuid_guid_get_str(guid->b) ?: "(unknown)");
+	}
+
+	return CMD_RET_SUCCESS;
+}
+#endif /* CONFIG_IS_ENABLED(EFI_ECPT) */
+
 static const char * const efi_mem_type_string[] = {
 	[EFI_RESERVED_MEMORY_TYPE] = "RESERVED",
 	[EFI_LOADER_CODE] = "LOADER CODE",
@@ -1586,6 +1627,10 @@ static struct cmd_tbl cmd_efidebug_sub[] = {
 			 "", ""),
 	U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_defaults,
 			 "", ""),
+#if CONFIG_IS_ENABLED(EFI_ECPT)
+	U_BOOT_CMD_MKENT(ecpt, CONFIG_SYS_MAXARGS, 1, do_efi_show_ecpt,
+			 "", ""),
+#endif
 	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
 			 "", ""),
 	U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memmap,
@@ -1680,6 +1725,10 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show UEFI handles\n"
 	"efidebug defaults\n"
 	"  - show default EFI filename and PXE architecture\n"
+#if CONFIG_IS_ENABLED(EFI_ECPT)
+	"efidebug ecpt\n"
+	"  - show conformance profiles in the ECPT\n"
+#endif
 	"efidebug images\n"
 	"  - show loaded images\n"
 	"efidebug memmap\n"
-- 
2.53.0

