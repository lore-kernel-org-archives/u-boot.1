Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEFEC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632A48708B;
	Sun, 12 Nov 2023 16:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AKzme9nl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46B2B8706F; Sun, 12 Nov 2023 16:58:27 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F1C86F1F
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7a683bd610dso133763339f.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699804701; x=1700409501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HlpBafy/9jRd4UxPVJe+gtaxrb2RZHo4Ywsvg68Seo=;
 b=AKzme9nlRuRKtdIHyvd2cwr2mfKA0XzpHwkfN/0YXOAD04YKbmfiuYBrm5g9gTaA0j
 ZZQu0KY36bKAhHjk6IocgxYTy4/aq86De8ahDytOiOpCT2olA/ImfCqMMSKKJLstWysO
 8cmfuurtODKELW0AGn2AlTXLmGb9mImSCt1C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699804701; x=1700409501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HlpBafy/9jRd4UxPVJe+gtaxrb2RZHo4Ywsvg68Seo=;
 b=B+TMMqzNHI2kAH98fVHAlZVmJYWKPDa426pG9hvoGI63voCoqILjR1XghhzOqZda3R
 5ppi2ptToNRMkP0Yeu2cgfUh1WYxZhP19a0My1OerLjoNRQYPo36a9OzcZOJ3qTrpqHU
 oV3779Z9HNdko1J755ivMKxzQwYESiel5FdvWdTiRuEjhg7QIZ0zrNJ4/CLEoDm2eg+R
 PziJZfGTCj2ARfrLVzjZh51AFOLbIjDsm9CBNHcDDRJAi6FlvaoUzVIb7eXMhULivvV4
 /f48FCzvhqJR0YXogQERpVt7XzfvQzOG7VMVoPBdiTrKVddfrNmcUXZHXLTRwbhBgtAI
 s/1A==
X-Gm-Message-State: AOJu0YzdXVeEkI6H/Ws9d5qCnNk3ZbHA+e24TuBNBEjaSouVUvf3AVDv
 0hp5eS2iHFaey8HwRKw1dIFG11legIMYQ/kfMjOy2Q==
X-Google-Smtp-Source: AGHT+IFoF/7srISP3KoxqlE5WAtqzOHPRny46VPutvnvnDlEXFKVrt39mShN1AU/TL6ghmouOiXkZw==
X-Received: by 2002:a6b:5f17:0:b0:7a6:b272:fd78 with SMTP id
 t23-20020a6b5f17000000b007a6b272fd78mr5697186iob.10.1699804701517; 
 Sun, 12 Nov 2023 07:58:21 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a056638348b00b0042b37dda71asm1065843jal.136.2023.11.12.07.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:58:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/4] efi: Collect the ACPI tables in the app
Date: Sun, 12 Nov 2023 08:58:03 -0700
Message-ID: <20231112155808.135585-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112155808.135585-1-sjg@chromium.org>
References: <20231112155808.135585-1-sjg@chromium.org>
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

Locate these so that they can be displayed using the 'acpi' command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi/efi_app.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index 2209410f35b5..c5eb816655ea 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -12,18 +12,21 @@
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <dm.h>
+#include <efi.h>
+#include <efi_api.h>
 #include <errno.h>
 #include <init.h>
 #include <malloc.h>
+#include <sysreset.h>
+#include <uuid.h>
 #include <asm/global_data.h>
 #include <linux/err.h>
 #include <linux/types.h>
-#include <efi.h>
-#include <efi_api.h>
-#include <sysreset.h>
+#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/root.h>
+#include <mapmem.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -320,6 +323,19 @@ int dm_scan_other(bool pre_reloc_only)
 	return 0;
 }
 
+static void scan_tables(struct efi_system_table *sys_table)
+{
+	efi_guid_t acpi = EFI_ACPI_TABLE_GUID;
+	uint i;
+
+	for (i = 0; i < sys_table->nr_tables; i++) {
+		struct efi_configuration_table *tab = &sys_table->tables[i];
+
+		if (!memcmp(&tab->guid, &acpi, sizeof(efi_guid_t)))
+			gd_set_acpi_start(map_to_sysmem(tab->table));
+	}
+}
+
 /**
  * efi_main() - Start an EFI image
  *
@@ -354,6 +370,8 @@ efi_status_t EFIAPI efi_main(efi_handle_t image,
 		return ret;
 	}
 
+	scan_tables(priv->sys_table);
+
 	/*
 	 * We could store the EFI memory map here, but it changes all the time,
 	 * so this is only useful for debugging.
-- 
2.42.0.869.gea05f2083d-goog

