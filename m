Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07384CF5389
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3920E89335;
	Wed, 23 Oct 2024 15:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="euzyGMCh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEE5A89268; Wed, 23 Oct 2024 15:29:00 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67AEC8930E
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d4821e6b4so4661591f8f.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690133; x=1730294933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgUH/j7Y4ssXH4OFnj8ziNsgQJMqug2+57e7KEKxB7E=;
 b=euzyGMChgGduOHEhZgLFh8B03IFIUJzvYWEvaAUoknHjhVrCMmGRss6zrSAYy/K3JY
 1xUCdaNfKhJ+HciEh6It8nmT0maaKrwU6+a+OUU9CZTHMbDevKwmgDBsRKoHo9DlSI+w
 QKAhDyuevLOwqdLqoV3L13ysq5gHfiHMaSIQ/NOqtXZimiI3Q7fwtKYW+MG81TKa/aN6
 8SQRidPpu843B80WSKG+C1cE908O99RSf4TShRPwNjniT7AVrc6FsrfOUnfY7l1S4bOT
 NhPP97zs1iHFmYJDIAsauC5FpNjxbIM725bluI+0uidYUDU6eY+hy9WZlKCKWimitK4a
 vhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690133; x=1730294933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgUH/j7Y4ssXH4OFnj8ziNsgQJMqug2+57e7KEKxB7E=;
 b=BxctbVOCIcZ8p6bKSyHi0Xwurs4UDBNf0seKmXr0Anojsf8ahTqkmLp+3DpO/T1rly
 FEa5troruW+0NrC4Gpg9w86GlOXA7yit3iGlbOEeY2HYr5M7/qa7ppt70OdbC4pQwGDJ
 2egBhgg66mvb4Onk9JM2TBYRWdv5aGhkmNDWhzhAXZcBY3XWM+1KSlidhvNBcp5ZtEr1
 zMPwZnEsl+Lydqdl0BaBkxsHZZ0ojR07AIE52SXfasAo8MbyhkSvihZ7vPBjpM0UIBPS
 Vprb+YtBZl6QPpxo2byAqCioeelg7Nb34hK/lKX3GuyKjD04ospU/3SfoyxiqfGVZGp/
 z9HQ==
X-Gm-Message-State: AOJu0YxQL+ppuiEX56c8yL6wFi6afnsYXOtl+7FD91HbtsAZTE832xBt
 dZvMkXiV/6uU7mO9g41+IzKgv/EQ7KiKhWU9IjaRckzzrLB7j0ZvfJnlZwF+CX4o/4OlRXLqiHr
 L
X-Google-Smtp-Source: AGHT+IFP5ZOnL/8THnjm2tayu8t9n5mYdJIPUI4JMFj1xhN+3FZk7+FTEZnJ10InNBDU49lcZlRIYA==
X-Received: by 2002:adf:f645:0:b0:37d:4fab:c198 with SMTP id
 ffacd0b85a97d-37efcf1b13bmr1670960f8f.26.1729690132836; 
 Wed, 23 Oct 2024 06:28:52 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:28:52 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 13/37] acpi_table: Support platforms with unusable RSDT
Date: Wed, 23 Oct 2024 15:19:56 +0200
Message-ID: <20241023132116.970117-14-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

