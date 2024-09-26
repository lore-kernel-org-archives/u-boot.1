Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6BDCCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6263E88D7E;
	Thu, 26 Sep 2024 10:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="fHxze1jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C4488D9B; Thu, 26 Sep 2024 10:02:51 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0508588D7C
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c46680a71bso728789a12.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337762; x=1727942562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSfsp/HiUCVg6UGFOAK/rR4BZYDQl5P3t9VlfjKpkDg=;
 b=fHxze1jzq+nDJy5Iqxiv2xp6DnB7DzTDggRoqVnOTL0dKzyX+0tq69F4YwhMi/EV+X
 R8LdFikFB+HhjVnnEJv4BOwrCj0dQyZkRhhrLbgdMbZJ41DkS9vVibkOqoytaTjNm4ZB
 cRoIysFNTIGsHyegf1tt5bfHWuuFJ7j1T2MEoXUFXW3fM9QbpJrOavsIk4NnrFyJHwMP
 ijYTcVoDUOPiTy3W74kNVGPK66bckb1jE1H2zJPCBa+gF3P/pWyM7vEiISiBZvJbIRIp
 Iuqs4GLKQPUmL5cLcu7moNb+R8wRAuCFVQsKyqZdiFp6/2b8MgVsdt91wfXo3rWrlWhm
 UZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337762; x=1727942562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSfsp/HiUCVg6UGFOAK/rR4BZYDQl5P3t9VlfjKpkDg=;
 b=G0ZnvKKhEu3XBtd4yPdxopMbkwnVHh6FZLmS+te1kZsvceLpGoHwMTarQtJZ7pBs/b
 g1WGGPvJmKNyWwKbOVJzFf6rtQYYAO/bjP3HmsgCUHTuAQs4KGaaSvcVuTQ3DRjLsi2y
 8NtIJVr6/Dvhoqyv0cqqbyMHm0Rkz1mP7BriQ+qcAcLNIhcFolmazrFg6xZAPSsyHmcN
 OIzy2c+loOc5REm17Jj2SdixXfuzFrVYtBwl1k6GMkxYcreBUBVVAPPxvfnknDWuCpm9
 AnuTjt4vMzaFmsBPkLZdRUlwUbAAKWV7o54GVxKcX6EjaOB3bAUpgdTAawwQrVHG9ZNB
 QZlQ==
X-Gm-Message-State: AOJu0YwE8x5sByjB+xhUcijyDHI7aOlVwQrHgL/8dNAO5iq1vo9F2st5
 6cjl8htCFHEGJnHZx3lx55yGii6KQL6lj4P9I8XTu6CdPsYuk5dpgCyp61GCCCWS7Mn29Sod88f
 y
X-Google-Smtp-Source: AGHT+IEe/3lgj6E44acjg3vKAYMS9nIn3KiADzJhn/g2LnwqtmWGXKb8qwvnEgoheOdkLFYFP7TxIg==
X-Received: by 2002:a05:6402:354a:b0:5bf:c8:78a with SMTP id
 4fb4d7f45d1cf-5c720623130mr4496519a12.17.1727337762363; 
 Thu, 26 Sep 2024 01:02:42 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:42 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 13/36] acpi_table: Support platforms with unusable RSDT
Date: Thu, 26 Sep 2024 09:59:01 +0200
Message-ID: <20240926080021.148031-14-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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
2.46.0

