Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B14C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BBA6808A2;
	Thu,  6 Mar 2025 15:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CroGOhzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A4380F4C; Thu,  6 Mar 2025 15:31:44 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E4080756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85b018062a5so59702339f.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741271500; x=1741876300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5OK39mHmmtT429jAJIfOwWwqNymnQ0GbZQ0BalbgCk8=;
 b=CroGOhzGC5vf4tOovH7QF5PbQmfAJmpUAL8bKxxqyjNWMnIpjG8jXA80Qzfy9GQWkZ
 555N7ehstFjeaNA2laDO4QClgzhvv9xovX4PNXCK3h42vnTlxgW7CMuyHO/guaqOpps+
 b2Go58SIKkBV486lO1CIGMSpSA43+SHq+3E28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271500; x=1741876300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5OK39mHmmtT429jAJIfOwWwqNymnQ0GbZQ0BalbgCk8=;
 b=qFyJB/YW668VGFu+sF5lqFFL0D9Lpyxk6hbT8j24fq6MwCD8csBLVj97JNaaz4QA7Q
 CBMvoUa/lfQdTIrlKtU44i1MpznpN5JZvT2nubqRwz9TTUCIpuiKTSfpFhuGhTkr2kS9
 EMRoKbwSZgcpXQiS/ulDb6kGLvjZ3JEK6B8OqI6QUEvHLackJfcKMSP8cttugATUTfHu
 2bPILCz+QCfdVrvE3lMrcQvDvtpiiWcVJ/YB4aEsKXFChbS4EnW/LJnecTyYgVUgrI92
 yuBU16vs0CO1YsASn4T79M6YZvzzrLRYDTH32EljoyImcH1FAJPVgv9EGTim3AHw+z0J
 gZ4g==
X-Gm-Message-State: AOJu0YwGpg03yISirAczLRsZFJX9xVgCHsQjr3P1J2W555Ygm3Jk/MTF
 F7ja0ove7O4HTHfdDFlaNbIMb7wKj596xod59ytfPo5gTIDFzKPSUuhv6u4dIQjVljDRkWpj1A8
 =
X-Gm-Gg: ASbGncvcj340JP9mGxNCPL0bJiE1Q+pbPvKv1OrXh1Nx5LA7O7+oZJbORotL/QEN3y+
 zgOeSX0zgQ5PT/r1LdSUu3wDcX0bTaTzEPgEKB6Rp3NwYllBJQeNY3snAsm8jHIdGRDuXVBMPje
 3ptyQ4dmYF2nWytYjGxWoCUH8vezOue2iBbu7yF/TedIKgfQgOnJsOAWVlYDXUPfcuUUsQauN+o
 H1jMLwV19GjZt7qmv2GVKuCA9c+WM/WOnuiSXULcbTE0PrJfyXm3V7m+XQnf4eCD0JSYs1kgCk6
 q39gq/M+yfIBe9TV8w35P4RLq5R1UFuZ5UKrjDUBIn4jaLWKl5xjcUyeYStEgjUWK4mbtwn88WT
 gwL/rNQ==
X-Google-Smtp-Source: AGHT+IE0rj/A+oJnihMNvZlQVAatdXrgRm/22YC6MXK87wHaLUQ8Nfnw9eqKLqZAs39secTa9yozgQ==
X-Received: by 2002:a05:6602:2770:b0:855:6965:6660 with SMTP id
 ca18e2360f4ac-85affbb307bmr865391139f.13.1741271499985; 
 Thu, 06 Mar 2025 06:31:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11987377sm28850439f.8.2025.03.06.06.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:31:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] efi_loader: Install the ACPI table from the bloblist
Date: Thu,  6 Mar 2025 07:31:24 -0700
Message-ID: <20250306143134.2549815-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

When BLOBLIST_TABLES is used, the ACPI tables are not currently added to
the list of EFI tables. While we don't want to create a new memory
region, we do want to tell EFI about the tables.

Fix this by covering this case. At some point the non-bloblist code can
likely be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 3da59ee9579 ("efi_loader: Avoid mapping the ACPI tables twice")
---

 lib/efi_loader/efi_acpi.c | 44 ++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index ff305a6b13e..b8b3a3670da 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -5,6 +5,9 @@
  *  Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#define LOG_CATEGORY LOGC_ACPI
+
+#include <bloblist.h>
 #include <efi_loader.h>
 #include <log.h>
 #include <mapmem.h>
@@ -32,25 +35,38 @@ efi_status_t efi_acpi_register(void)
 	 * add_u_boot_and_runtime(). At some point that function could create a
 	 * more detailed map.
 	 */
-	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
-		return EFI_SUCCESS;
-
-	/* Mark space used for tables */
-	start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
-	end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
-	ret = efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM_MEMORY);
-	if (ret != EFI_SUCCESS)
-		return ret;
-	if (gd->arch.table_start_high) {
-		start = ALIGN_DOWN(gd->arch.table_start_high, EFI_PAGE_MASK);
-		end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
+	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
+		int size;
+		void *tab = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
+
+		if (!tab)
+			return EFI_NOT_FOUND;
+		addr = map_to_sysmem(tab);
+
+		ret = efi_add_memory_map(addr, size,
+					 EFI_ACPI_RECLAIM_MEMORY);
+		if (ret != EFI_SUCCESS)
+			return ret;
+	} else {
+		/* Mark space used for tables */
+		start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
+		end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
 		ret = efi_add_memory_map(start, end - start,
 					 EFI_ACPI_RECLAIM_MEMORY);
 		if (ret != EFI_SUCCESS)
 			return ret;
-	}
+		if (gd->arch.table_start_high) {
+			start = ALIGN_DOWN(gd->arch.table_start_high,
+					   EFI_PAGE_MASK);
+			end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
+			ret = efi_add_memory_map(start, end - start,
+						 EFI_ACPI_RECLAIM_MEMORY);
+			if (ret != EFI_SUCCESS)
+				return ret;
+		}
 
-	addr = gd_acpi_start();
+		addr = gd_acpi_start();
+	}
 	log_debug("EFI using ACPI tables at %lx\n", addr);
 
 	/* And expose them to our EFI payload */
-- 
2.43.0

