Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D77C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D71B87134;
	Sun, 12 Nov 2023 21:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NZqZ8n9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0FF86903; Sun, 12 Nov 2023 21:55:25 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E80869DA
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a94c550cc8so103968939f.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699822520; x=1700427320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcgHRVtfebO8yXyveNSLZCNqy1mGOaAUhmg39ZJEqho=;
 b=NZqZ8n9F+wKGBm6+HyGzG+AHuIVkDdmlBSUN4394SeItvSbnbG/1bqLvkk6xRMFMJL
 A4Q++kEltM++q6X0G3ZusOkqjxRWmUfC0LdQ5Yx0/rAAy1BJd0lSQ3QfDeak2qbrZNaL
 Y4SX8yQ/P9BBuDbVVlZwbgmxvXnMd5hCSux38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699822520; x=1700427320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcgHRVtfebO8yXyveNSLZCNqy1mGOaAUhmg39ZJEqho=;
 b=VmyegpaKiNByHWRLrqUeThI3fpyePREWZzt+nuGlGLGb8BfVC+WnsjYzmb71Rbonl9
 tfwGcu8qq60oDuD7HNVr9hLxemtyjH5Lyg+sQTYDxBV+TxyeC4LH+5c/RHa+2Cq3o8/h
 DJsTpzKivCflcmBZ5xrlvGsCxz+tozTfHqe/MPLcG1/rCRRVi8NgvywFB2iMzw9WAIfp
 qCKll5rBT9No1N1ePO8qkFZUKGEcV66U2ACNGtIMyvWekaM7S2KwVEn8z69kENveJp6z
 1vt56PHjAS2cdQ76O65bgsBzg3Xae5uXBUW9r03Fd3i9umrRa9A9WzpmySkDaT08UjZd
 4pOQ==
X-Gm-Message-State: AOJu0YyW2bxH7vP9XoaZs/KPh9bUraHNW4Jy/KaFQWwN8AZzW7K350Bo
 C+Crt/Vdvqas8iYbUkAUt5WuF2u78XQZdtXxE0Eu5Q==
X-Google-Smtp-Source: AGHT+IH8gYOuGgyF13naVIWoGrOtyAe5EFKu6zVoLStR+TWQiC9xAPZRm8icd0lLb55l61WPIYw9DA==
X-Received: by 2002:a05:6602:360d:b0:7b0:2664:ba1f with SMTP id
 bc13-20020a056602360d00b007b02664ba1fmr3706325iob.2.1699822520533; 
 Sun, 12 Nov 2023 12:55:20 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a056602210c00b007b01c6a57d5sm1079641iox.15.2023.11.12.12.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:55:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 1/3] efi: Collect the ACPI tables in the app
Date: Sun, 12 Nov 2023 13:55:09 -0700
Message-ID: <20231112205516.183410-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112205516.183410-1-sjg@chromium.org>
References: <20231112205516.183410-1-sjg@chromium.org>
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

(no changes since v1)

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

