Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AB6D5D688
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A44891E1;
	Thu,  7 Nov 2024 22:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Llqe/p6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE1688EFB; Thu,  7 Nov 2024 22:32:17 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 548EE88B55
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a6e960fb5dso4884675ab.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015133; x=1731619933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tn/0/A7n+HuijX8hUWUXLO1lNv0YNth+jJU4Rj7zQyA=;
 b=Llqe/p6ybiFR3Yec0dsozgPjxOkLUW54tsNIZg/ULJmvBAoo5GhPvpqqJmDenvdP3P
 uw8FhfQtR4rTg/F7tJH0ngLcj+IrDFNnj7gwnNwJRno0hHvgYcoOIufbYdk/pKoukDQ+
 XCrCITbsBfFZMHugce1+N39jRb5FIRDmt3VLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015133; x=1731619933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tn/0/A7n+HuijX8hUWUXLO1lNv0YNth+jJU4Rj7zQyA=;
 b=MOEy/MJE9AuET9jWzwOJFH0O1FYsEjnQfRhJwQ2TeqZu2Yvwh9FH86llJ82UhftrEq
 xLhEspsKU5oJxvJnFiVSXuiHmMdQIuBvm0YK6dZORZFBBlLg7YB9PwjcDIBw7RVGQ3N1
 HSTKzlhHF3OTeLlhKeRqVlavx4ib8iifTuJpiToKCfFzHuBV+0faNkG/suIEA6WkclDL
 doBWRc8JgPEBLaFHeYherif+fHe1pUbcnPvhBF3AQ0O7AHkjjLoFAVvvf0uGHzqyK0iE
 BP8mDHOF9yL8sJz8sF2cMInLQT9YAehykSI6FyMkT9flCjNpo94nR76ic0sDPyxDdCql
 2UOw==
X-Gm-Message-State: AOJu0Yy8q0VQTYImuIFznUo1kEDiCTfwUHyxrRPEaNes526YYKsHmLFY
 HIC3iX+xvhUNOvijL53Q+FI+60FgbMnkrwwx6w5wGEJ4F5jsF22nEvO82khMURPmIORTuxPj+BI
 =
X-Google-Smtp-Source: AGHT+IEuvGsfkjxNEu8RAlAoM9PX+MXbOOf1UCIb+0wPVerXpNus9AQeR24SAVV29Z34rCk9GldPVg==
X-Received: by 2002:a92:c244:0:b0:3a6:ab32:7417 with SMTP id
 e9e14a558f8ab-3a6f1994673mr7982835ab.1.1731015133488; 
 Thu, 07 Nov 2024 13:32:13 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v10 05/10] efi_loader: Allow reporting the host defaults
Date: Thu,  7 Nov 2024 14:31:45 -0700
Message-Id: <20241107213150.1711962-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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

Add an 'efidebug filename' command to report the default filename and
PXE architecture.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v9)

Changes in v9:
- Split out into its own patch

Changes in v8:
- Add new patch to report host default-filename in native mode

 cmd/efidebug.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index e040fe75fa1..02f1e080e88 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -511,6 +511,27 @@ static int do_efi_show_images(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+/**
+ * do_efi_show_defaults() - show UEFI default filename and PXE architecture
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
+ *
+ * Implement efidebug "defaults" sub-command.
+ * Shows the default EFI filename and PXE architecture
+ */
+static int do_efi_show_defaults(struct cmd_tbl *cmdtp, int flag,
+				int argc, char *const argv[])
+{
+	printf("Default boot path: EFI\\BOOT\\%s\n", efi_get_basename());
+	printf("PXE arch: 0x%02x\n", efi_get_pxe_arch());
+
+	return CMD_RET_SUCCESS;
+}
+
 static const char * const efi_mem_type_string[] = {
 	[EFI_RESERVED_MEMORY_TYPE] = "RESERVED",
 	[EFI_LOADER_CODE] = "LOADER CODE",
@@ -1561,6 +1582,8 @@ static struct cmd_tbl cmd_efidebug_sub[] = {
 			 "", ""),
 	U_BOOT_CMD_MKENT(dh, CONFIG_SYS_MAXARGS, 1, do_efi_show_handles,
 			 "", ""),
+	U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_defaults,
+			 "", ""),
 	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
 			 "", ""),
 	U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memmap,
@@ -1653,6 +1676,8 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show UEFI drivers\n"
 	"efidebug dh\n"
 	"  - show UEFI handles\n"
+	"efidebug defaults\n"
+	"  - show default EFI filename and PXE architecture\n"
 	"efidebug images\n"
 	"  - show loaded images\n"
 	"efidebug memmap\n"
-- 
2.34.1

