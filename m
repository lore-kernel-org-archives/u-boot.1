Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AAFD3A696
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8CCA89191;
	Tue, 29 Oct 2024 20:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DKMckKNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC6F891AA; Tue, 29 Oct 2024 20:22:41 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCF789174
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9634c9160so6664125a12.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229759; x=1730834559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnM7MM7p6MWwzPuPCcQyIMM+5swduzRBP8G273R0g1Y=;
 b=DKMckKNa23lowr6/Chu5QVwmknORUW5Y3EjHth7OoujKi/iq6pqCuB/reXvEdBNhje
 B9D37UUiK1woBE5vxgjl3xIMq/VBDn/jhBdqNkt2QnIxCiEihFsT/E8hl2PRM6KjmHyX
 H1gTeAMNuxj46yxe+tULuVjn/rVJFgLSUpydA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229759; x=1730834559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnM7MM7p6MWwzPuPCcQyIMM+5swduzRBP8G273R0g1Y=;
 b=fu3uuDhtQ5fFfKebXmSspIVb8MB2TVymsyh1BSb923UPl5ovuXnm3nU+cFtGLid+Bs
 BgUsV9ugcxZO2ldpi/w4OYD7x0YvUe0aoMOJtbESU+lHYnnQk2f/mMLtTszrCWeHeRHM
 F41TZ9cj0lFE4RFIvt7I95aLZhiIAR/FM22TXDeoc0E9tB273taLPXG8lfQlZp7uznAA
 swqqgVjp4SI/iB+OD+aFo2hkvsOnO++cTkLfIg6tBS9UBWE3PaIWv9h6JP5IeiCuGmfb
 WRSb/zlM5VZd87oNntLb3ia9uu5ghW9kW35Jo3dx+VQc/gGXvONRwB0K8FyAJeqwhW87
 3y4Q==
X-Gm-Message-State: AOJu0YysekvJbH8QujvdpZM3Sx9exb/E90YiTkIe/nRZYGQIc+w3kch9
 ZR4pbs2jE6X/+CkKxYjsZVodJb7xsIJO5K2Ey6IJidR3zHod/laov82UIxYuPc1IE/s9WNnG/FV
 zUDpD
X-Google-Smtp-Source: AGHT+IGE9IG7t4ETBNqEfvgzuQpCgCsytIiR4no/XM/Z9axpsXa4Anu3TNRQw2kqY0HWJDSmDpPajA==
X-Received: by 2002:a05:6402:849:b0:5ca:e5d:f187 with SMTP id
 4fb4d7f45d1cf-5cbbf8b4f45mr11283320a12.17.1730229758228; 
 Tue, 29 Oct 2024 12:22:38 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v9 06/11] efi_loader: Allow reporting the host defaults
Date: Tue, 29 Oct 2024 20:22:14 +0100
Message-ID: <20241029192222.362445-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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

Changes in v9:
- Split out into its own patch

Changes in v8:
- Add new patch to report host default-filename in native mode

 cmd/efidebug.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index bba984b2b75..ff6d118876d 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -536,6 +536,27 @@ static int do_efi_show_log(struct cmd_tbl *cmdtp, int flag,
 		return CMD_RET_FAILURE;
 	}
 
+	return 0;
+}
+
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
 	return CMD_RET_SUCCESS;
 }
 
@@ -1589,6 +1610,8 @@ static struct cmd_tbl cmd_efidebug_sub[] = {
 			 "", ""),
 	U_BOOT_CMD_MKENT(dh, CONFIG_SYS_MAXARGS, 1, do_efi_show_handles,
 			 "", ""),
+	U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_defaults,
+			 "", ""),
 	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
 			 "", ""),
 	U_BOOT_CMD_MKENT(log, CONFIG_SYS_MAXARGS, 1, do_efi_show_log, "", ""),
@@ -1688,6 +1711,8 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show UEFI drivers\n"
 	"efidebug dh\n"
 	"  - show UEFI handles\n"
+	"efidebug defaults\n"
+	"  - show default EFI filename and PXE architecture\n"
 	"efidebug images\n"
 	"  - show loaded images\n"
 	"efidebug log\n"
-- 
2.43.0

