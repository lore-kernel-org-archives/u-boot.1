Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A5DCF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9229189017;
	Wed,  2 Oct 2024 11:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="G/0n+GzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6389389017; Wed,  2 Oct 2024 11:52:02 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 621F988F1F
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37cc9aeb01dso3723900f8f.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862720; x=1728467520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Si7uUwYHpiR/hLbMe1Wt9xjJW6ZrFIeipOz15MJIyg=;
 b=G/0n+GzE9vpIfXPoK4GCZZOxUSWjpZSoUgYiiw4BFhkgppKpyX+hHYqavlBNGJlBEZ
 dorx21g9b93C9lqgtdFOQxuWbo7DHjeFsepQhS2o45CHUp7ztcWE0ryhoz0DexDK77rY
 1ERCPvOLKK9WcU6rPtnQXkuOjILuR9YyfRdW3R19G/Fhf+WecIJAGnXtJV07zdJeAK1T
 8U7a3ARjRzexP/nLfrOUzTbHhMJWMt1rdIOe9YrT/2/QZrisGcchlXhZlYUtAg2IS1Vh
 nGio/fcCqJoob1jgffo+ALLgo0nP3x1aMy/g30pvey5EOCvrDrtu4i3hq2HieUl4MPaC
 XyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862720; x=1728467520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Si7uUwYHpiR/hLbMe1Wt9xjJW6ZrFIeipOz15MJIyg=;
 b=cs6TP+tJrOuWcDaOtEQII/dNHXGWRGckZN1zRVgpoD74JnBS1St0tcYYc1iJM9Ag03
 4iUxjpBpVYA2g7D/lpbHBgAT4Q7QEz5/6+MsDS7Ckmhvbtj95AaeB/7dVGXzQwfGV2uO
 E7m9hUxbUCrGqMH3cBLGJU4JFiSsyUnfLd9pgztIRt1ItEQVPaFRS1VYx85ea1ly63ce
 8KlNJd6JZYdMaPqwE7zsFmGKZT6Prhm9mobXwqsGFOqOKTbHXdfcs/TnhgXT2BDbQ7v8
 fZ5HFEZk8ntpmBLWw3vMG9IZ9xiYhWPMfI9uHHahY7zPUuETZUC80BBLeEXutx6ZzemB
 lRJQ==
X-Gm-Message-State: AOJu0Yx2cNkzvymuONFo3ElmWUqQmqTTdb872/s8JIeQT5W9A62MiBH1
 cRyr7JzP0XJJ/ZlMVc3l2Ilb+EFFFU0sdmKMNW5WL51Smtsvk44i7bhLNtNU3VEmDGxMeFDm1pP
 6
X-Google-Smtp-Source: AGHT+IGp0F4+mD5zvnkPBtCME3EnRUlAy3I+Ck4YavZGJRpeSuuOxEx0k6QeuTFYn9vy3AR/3E3WaA==
X-Received: by 2002:a5d:4561:0:b0:37c:ccb1:e92c with SMTP id
 ffacd0b85a97d-37cfb8b2556mr1507514f8f.13.1727862719728; 
 Wed, 02 Oct 2024 02:51:59 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:51:59 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 13/37] acpi_table: Support platforms with unusable RSDT
Date: Wed,  2 Oct 2024 11:47:04 +0200
Message-ID: <20241002094832.24933-14-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

Since ACPI 2.0 the RSDT is deprecated and the XSDT should be preferred.
Until now the RSDT and XSDT entries were keept in sync as all platforms
that installed ACPI tables placed them below 4GiB and thus the address
would fit into the 32bit RSDT.

On platforms that do not have usable DRAM below 4GiB, like QEMU sbsa,
the RSDT cannot be used. Allow both RSDT and XSDT to be null and only
fill those tables that are present in acpi_add_table().

TEST: Fixes a crash on QEMU sbsa and allows to boot on QEMU sbsa.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v4:
- Updated commit message and better explain why this change is needed

---
 lib/acpi/acpi_table.c | 95 ++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 38 deletions(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 9d9c8befe8..d6357bdc4d 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -157,51 +157,70 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
 	struct acpi_rsdt *rsdt;
 	struct acpi_xsdt *xsdt;
 
-	/* The RSDT is mandatory while the XSDT is not */
-	rsdt = ctx->rsdt;
-
-	/* This should always be MAX_ACPI_TABLES */
-	entries_num = ARRAY_SIZE(rsdt->entry);
-
-	for (i = 0; i < entries_num; i++) {
-		if (rsdt->entry[i] == 0)
-			break;
-	}
-
-	if (i >= entries_num) {
-		log_err("ACPI: Error: too many tables\n");
-		return -E2BIG;
-	}
+	/* On legacy x86 platforms the RSDT is mandatory while the XSDT is not.
+	 * On other platforms there might be no memory below 4GiB, thus RSDT is NULL.
+	 */
+	if (ctx->rsdt) {
+		rsdt = ctx->rsdt;
 
-	/* Add table to the RSDT */
-	rsdt->entry[i] = nomap_to_sysmem(table);
+		/* This should always be MAX_ACPI_TABLES */
+		entries_num = ARRAY_SIZE(rsdt->entry);
 
-	/* Fix RSDT length or the kernel will assume invalid entries */
-	rsdt->header.length = sizeof(struct acpi_table_header) +
-				(sizeof(u32) * (i + 1));
+		for (i = 0; i < entries_num; i++) {
+			if (rsdt->entry[i] == 0)
+				break;
+		}
 
-	/* Re-calculate checksum */
-	rsdt->header.checksum = 0;
-	rsdt->header.checksum = table_compute_checksum((u8 *)rsdt,
-						       rsdt->header.length);
+		if (i >= entries_num) {
+			log_err("ACPI: Error: too many tables\n");
+			return -E2BIG;
+		}
 
-	/*
-	 * And now the same thing for the XSDT. We use the same index as for
-	 * now we want the XSDT and RSDT to always be in sync in U-Boot
-	 */
-	xsdt = ctx->xsdt;
+		/* Add table to the RSDT */
+		rsdt->entry[i] = nomap_to_sysmem(table);
 
-	/* Add table to the XSDT */
-	xsdt->entry[i] = nomap_to_sysmem(table);
+		/* Fix RSDT length or the kernel will assume invalid entries */
+		rsdt->header.length = sizeof(struct acpi_table_header) +
+					(sizeof(u32) * (i + 1));
 
-	/* Fix XSDT length */
-	xsdt->header.length = sizeof(struct acpi_table_header) +
-				(sizeof(u64) * (i + 1));
+		/* Re-calculate checksum */
+		rsdt->header.checksum = 0;
+		rsdt->header.checksum = table_compute_checksum((u8 *)rsdt,
+							       rsdt->header.length);
+	}
 
-	/* Re-calculate checksum */
-	xsdt->header.checksum = 0;
-	xsdt->header.checksum = table_compute_checksum((u8 *)xsdt,
-						       xsdt->header.length);
+	if (ctx->xsdt) {
+		/*
+		 * And now the same thing for the XSDT. We use the same index as for
+		 * now we want the XSDT and RSDT to always be in sync in U-Boot
+		 */
+		xsdt = ctx->xsdt;
+
+		/* This should always be MAX_ACPI_TABLES */
+		entries_num = ARRAY_SIZE(xsdt->entry);
+
+		for (i = 0; i < entries_num; i++) {
+			if (xsdt->entry[i] == 0)
+				break;
+		}
+
+		if (i >= entries_num) {
+			log_err("ACPI: Error: too many tables\n");
+			return -E2BIG;
+		}
+
+		/* Add table to the XSDT */
+		xsdt->entry[i] = nomap_to_sysmem(table);
+
+		/* Fix XSDT length */
+		xsdt->header.length = sizeof(struct acpi_table_header) +
+					(sizeof(u64) * (i + 1));
+
+		/* Re-calculate checksum */
+		xsdt->header.checksum = 0;
+		xsdt->header.checksum = table_compute_checksum((u8 *)xsdt,
+							       xsdt->header.length);
+	}
 
 	return 0;
 }
-- 
2.46.2

