Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFC7E6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C86892CE;
	Fri,  1 Nov 2024 16:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aqXm793x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B3E892E6; Fri,  1 Nov 2024 16:26:35 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B70889300
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso324827266b.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730474791; x=1731079591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Otig4MT+7NE5EvZ3Wb6FUNyd4tXoWuPjhCR+dMjmZgI=;
 b=aqXm793xukan1/V990JshnhYTO06v9HYKK/GSkmEd+mSaJ6GyYQdpXchMV4RgWCZI+
 crgUFl1D064nL8KKTR4fuKcSjgOn6+h6Ze58/kKpIvsD1235Nib/PdLDEsljiV/D7aAB
 dlMGiuI19Fshbsw48gFS++4Nqld6iQmn83GHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474791; x=1731079591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Otig4MT+7NE5EvZ3Wb6FUNyd4tXoWuPjhCR+dMjmZgI=;
 b=BM59k7+0JSNgJ8JEP66sqxq+erdQ7Yg5iQDOjH0lH9vR7HGeVpeg5hikps6/le604z
 VBuA3wCenFNAFZEU43TGVX+Exdu5l/pF43OBpAP0H04980bEB6T8RrJJWls8JqaMf0A5
 LZU1nApFYViAFywURMv4HNdpqP1fUe/t87ZxQtVBi6chGryHo8ULJNiJtGMDn8zRvj/4
 6yD7JumUY7QfniXf8gkavB27FFRw4tyrjGzKUkfN8eJe/1bi+5kt/aMGNqm4ub3283wp
 J7x1rqje/10iaTSIVbfMQ40RksK1LlZEtWuBJVTVYgoh+A9CkOzzySoddnYPKS0CiiAI
 RQbQ==
X-Gm-Message-State: AOJu0YxR2DQdJvra+hDO4KV5BErR+MwlSlO2limr1yubSIUQqZjpM/tI
 M9/WR6R3AalEhx/YDn9lb6TqPiXy6EpV0JyCP3HqRJ7g43yCXseqkP2xL2Jwg/+FblT7y4auT1h
 sqDOz
X-Google-Smtp-Source: AGHT+IHrS9pCjGa6W/NmkWbMyO7xDrL9UtpDiZnfjf1xcrfcHQw7g4FNKGY498y4/p0+MRC1qoWsbA==
X-Received: by 2002:a17:907:97cb:b0:a99:92d3:7171 with SMTP id
 a640c23a62f3a-a9de63327dbmr2272541366b.61.1730474791400; 
 Fri, 01 Nov 2024 08:26:31 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5649454csm190269466b.8.2024.11.01.08.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:26:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v9 06/11] efi_loader: Allow reporting the host defaults
Date: Fri,  1 Nov 2024 16:26:04 +0100
Message-ID: <20241101152614.238747-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101152614.238747-1-sjg@chromium.org>
References: <20241101152614.238747-1-sjg@chromium.org>
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

