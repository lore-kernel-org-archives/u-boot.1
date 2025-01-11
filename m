Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83782E7719D
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E048070D;
	Sat, 11 Jan 2025 01:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GUhMw1Ug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F1480785; Sat, 11 Jan 2025 01:01:48 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6988070D
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844d7f81dd1so87993339f.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553704; x=1737158504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HWfSBlvLy3gAWIoCNj61AabhKzHBwJHKFe/SDfZvaU=;
 b=GUhMw1UgdcBfWktTeAuFjSHcyi3esS61ceXwGOEhHfOVmKFosJCWBaaCYLaK67XS6D
 8uYs6YtLBqQt1xZblwRyaxEdYI+I/QSdS2Yk4jKqXMsvm99EdPw65qTTpdWwQ6FfC/yY
 QjQFVDBQyUU/l8Pzv7bPgVDdJ/0pJ+G9Ndxpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553704; x=1737158504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HWfSBlvLy3gAWIoCNj61AabhKzHBwJHKFe/SDfZvaU=;
 b=GNJmk8Go2L5hatKjQoNP22B9pTx0i5zrbF+chdykf1KrMg+4Dwwy6jZzAZwxeQNwgP
 7lXgtgLgtx2J2OHzcIZgutEWfkLGBsTy3gHC+s5ROZKJ8IGjnWJ5BkAHh5NADjBy6Onw
 EtYnPbIEonPTFqfJEdwkRohJ05RM9XJH3lJGHF6eSmMKi+WdNZmKJRmnzXi77I2Mjy5W
 0Ef/zU8rKgAdDDIqem6+VRMQ9d+wTdpoKID/v6I63e7C1pF7AEqtIGQJfzLtJOOQ5KlA
 5MjJxp+6GMVzFULzvdIWlbJaWBw6J0WPaq0whCGYinz7WcFlpjClncpjlNAopCLFnx5z
 Rvkg==
X-Gm-Message-State: AOJu0YwY61ZNiSKR9PsepM6sOTXA/q/uFbNGTnOZzkMeb+uMNsHe7QpE
 TDHvWeFhYr78aRCRkEfug2I+CnPt6e+rEaFomTbwd3xaQ0Tv74bCZdtTBsoEgDCDZYbcEbI7eho
 =
X-Gm-Gg: ASbGncupIzuoYlQaJlbU/zZYpdlLWlf7nS5XLTI1+tY16o+wfk5bjif2gOW66vCQ3Zd
 JrVyhaStSnysYbsGDc0ComR4FYBdhrLOTUpHdyRfmyMx6fRC3E8Kf4hTN+TdQbcYhYtXeeXbcYA
 XhYhsbdtvbCIgyzdsVSoLUjFROZfn9wuaUJFyWAmwSaCD28QWRllpr7vEYq4aSggK/nXOSh9tnB
 gd25VsF9DYoJp0jnCICJ1xUDyRYTrCU8HdMrdOMrEvy9pHRfldlH5idToVZS2ZcBD3lh2qvhKsQ
 fFZV/R5rnvMeduaUOg==
X-Google-Smtp-Source: AGHT+IEJRkL5Jznzv3QaKOsUAY1RciEyp4QS7bWU27V9+W2ZXt9CV+Wgc/KPFGwd+KZ8QX0lWdxgcw==
X-Received: by 2002:a05:6e02:308b:b0:3a7:9736:501e with SMTP id
 e9e14a558f8ab-3ce3a9d0941mr88119505ab.14.1736553704017; 
 Fri, 10 Jan 2025 16:01:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 24/30] x86: Move tables to use SZ macros
Date: Fri, 10 Jan 2025 17:00:23 -0700
Message-Id: <20250111000029.245022-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

Update the tables to use linux/sizes rather than open-coped values.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v2)

Changes in v2:
- Add new patch to move x86 tables to use SZ macros

 arch/x86/lib/tables.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 5fc7dc75377..9e4f21ae5ad 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -16,6 +16,7 @@
 #include <asm/tables.h>
 #include <asm/coreboot_tables.h>
 #include <linux/log2.h>
+#include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -59,10 +60,10 @@ static struct table_info table_list[] = {
 	 * that the calculation of gd->table_end works properly
 	 */
 #ifdef CONFIG_GENERATE_ACPI_TABLE
-	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, 0x10000, 0x1000},
+	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, SZ_64K, SZ_4K},
 #endif
 #ifdef CONFIG_GENERATE_SMBIOS_TABLE
-	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, 0x1000, 0x100},
+	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, SZ_4K, SZ_256},
 #endif
 };
 
-- 
2.34.1

