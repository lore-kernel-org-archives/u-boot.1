Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017AACFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0869D8931F;
	Fri, 11 Oct 2024 12:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="QMVsMSkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D209289320; Fri, 11 Oct 2024 12:34:50 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C91C48930E
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99422929c5so217872966b.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642888; x=1729247688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Si7uUwYHpiR/hLbMe1Wt9xjJW6ZrFIeipOz15MJIyg=;
 b=QMVsMSkCIQ/G3bjE3U8WYng+98CMtdiK1u1PkwXRmkPM+PnMV8M1byNkAOzDwBhGnY
 /mWV7InpP6GyqCtLUoioxYXkx6gAGYk7OyNn+obTz19aI2bRwI63hqnXHxpvGO61ShEP
 ZunW02iLr0MqSoniJs7xeLw2J+6lPSie35fUlpahYb6U/OQNvrJmw+jicXD8ZG+ubOxH
 BWuniyrVsynnFk9jRELBbO60Aj0fkbWiRWaXmYozFKoirVIIbmOkSDFuKugfNto5UiEO
 d9e9fyYYj6ZwAT5S4BM43dKE6fYcyKrl6hgVl+qSdAg+cqNk5Rjc/9GZuF11osrrXHsI
 /t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642888; x=1729247688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Si7uUwYHpiR/hLbMe1Wt9xjJW6ZrFIeipOz15MJIyg=;
 b=egojv9L+vRexQNFHpB9WdtyemIiDwGZVy7G/h5w+t0iW1xP71Wg+n5XAfKHuQ716UH
 nNXdIdrTSaRnmpOPngLik0Too1+HDgckMrA3ieMNDJEHkY9BwJvDHGdKQoOU+8KjGalX
 M33lth8CFuIe2dng6IbO4pu873LAIrB3POf5xFmEoS25TywCC8xV5NW+OsxdIHNwybBs
 wTkBh/cBF17dZKFe4t1eX6B1+w1dkKmy5FVGEKcyxj89Ss2pegOccEDM+bTq5Gz7Qhp+
 97t+33VKXDQ783AL/S5sBv/4HhpTo7YqU7qSoYy5a/30m9g6/fPbcCaM8wW9oFKOrOc5
 MEBQ==
X-Gm-Message-State: AOJu0YzrWtjFNi9j3MLohzWOglHQH/nDD93OnTni3Ye9witLO1zVwJlx
 uu+Q8rY6qNKCSQjHjxdnGcuLevgJ16jiDmNrd040jwGLoVDzwbyjZcMv0LM+hpk6PPhsaYwf8GF
 Anxo=
X-Google-Smtp-Source: AGHT+IHN5h+EIrSHEsCuKoHi2nFoKBgSXVFWEjiiz4nf1i8setGajUUh/nxM32wtC7XsLq38BKUXRQ==
X-Received: by 2002:a17:907:3f07:b0:a80:f840:9004 with SMTP id
 a640c23a62f3a-a99b936997cmr159041166b.12.1728642888081; 
 Fri, 11 Oct 2024 03:34:48 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:47 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 13/37] acpi_table: Support platforms with unusable RSDT
Date: Fri, 11 Oct 2024 12:22:54 +0200
Message-ID: <20241011102419.12523-14-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

