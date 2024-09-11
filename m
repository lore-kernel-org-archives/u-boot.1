Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27955EE0212
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F4E891A4;
	Wed, 11 Sep 2024 08:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="dH42gHWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9019889195; Wed, 11 Sep 2024 08:25:43 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967508919C
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso38398665e9.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035941; x=1726640741; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaZV4uFb0YRPsno335gyTB57s3Bs6ZczqYJHLdTsUMs=;
 b=dH42gHWjQz5+Go6gFR3MJ0mhp6mJLh+Spkyl8xn5vzUW10GOMjdHniy85sSCGHA2+Z
 eJ6uhiCufhXnVSxZfttFnO6m/wEUa5t15TlNCQYqJRinfWd15Nv/I4gZVZlaHDPhH1bS
 C6wqBNEai5cKFMKRWE9coeaf0SIA6BoEiVswzTt7rC5cpMko/UlT0YY1PIxKl6EvyilA
 wkHnGkEEWUvzyHoVFEXId0oPRYsZZVn89SH0y3GE8Tkd7VF3dIyfTAeQKMs2n96FZi9Z
 Ack5rmWVv0uBoNm+gEvu46fX/A436ViDm8h3vQOct7nEpyT1847qlaTivM5DoD7220zC
 T/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035941; x=1726640741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaZV4uFb0YRPsno335gyTB57s3Bs6ZczqYJHLdTsUMs=;
 b=cudKdm7NSVC0phl1GiWLBBWdbKBldXs1vcHsXIqkdJXXoTnfHh7CSJ0SUN5c8ZbI0y
 ftaxZdD1IaEaYWOwA43CkrTnZ49iPRn+6BOwbWjgdhROBs9EBSBLlSHqLfuAoSIVMP96
 LFboStNQxDasSy1AjZnE/R56hfsY+YhqJvLrzB7MnLx8TByc4aO8ed+5An1SVov0YsLN
 dc5KD6MHvqyHKYwFg2jf/fy5xwCGCqanZcmPTJjs5sstoGDKdkImeGg6zXmwZCbJ8aEX
 mFA8osmQARk2CKdA2iztnNX7XByW1L7Zca4OmjLyYiJgJFK24MV5lf2nb2mFh2Q6ipQh
 9NnA==
X-Gm-Message-State: AOJu0YzRIGviOMkhQlcmrG8sOZbuZhT07R139Io5vJYA+jFmjvEQI3di
 RQkwkxR3GbLReeY01y5MvUSBQHHGC2TyVfWPliXbLGkPerox8I9BeYz4w7sNwY3daSXfSYPVazt
 O
X-Google-Smtp-Source: AGHT+IFMVbiqZS0gDpTVZtVT1a5pZ3xuYxoSvP4zDTo+B1RlWAVsZrosbC5ucX3N8dUi293IoCYA9g==
X-Received: by 2002:adf:f2c9:0:b0:374:c3cd:73de with SMTP id
 ffacd0b85a97d-378922b9b93mr12430479f8f.35.1726035940883; 
 Tue, 10 Sep 2024 23:25:40 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:40 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 13/30] acpi: acpi_table: Support ACPI 2.0 platforms
Date: Wed, 11 Sep 2024 08:24:03 +0200
Message-ID: <20240911062511.494855-14-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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

On platforms that do not have usable DRAM below 4GiB, like QEMU sbsa,
the RSDT cannot be used. Allow both RSDT and XSDT to be null and only
fill those tables that are present in acpi_add_table().

Fixes a crash on QEMU sbsa.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/acpi/acpi_table.c | 95 ++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 38 deletions(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 4f5cfe522c..8aab41212a 100644
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

