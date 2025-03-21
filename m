Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE631C36002
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 23:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A67819B1;
	Sat, 22 Mar 2025 00:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Nk0pyenY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6346F81A0C; Sat, 22 Mar 2025 00:21:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 523398197D
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 00:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D03013F72E
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 23:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742599296;
 bh=RklT/2SOwCLGW/x4Z+mv4hIOkSv1lsio9dNL09SFr6g=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Nk0pyenYYOvnNhSPbTCnnjKqC+zfiafVDZ1yAv0m5B3WvXwsUy+11Q2sLYkVVg8jA
 PE5YHpGK2pmDzY9bVLIqT8JPGkretOUNzGs54TBc1J3eCq4AeAhmcxMMkpqE2lBH68
 K9Mlhn6t4G2P7ebDx+0GPMDUDm53qCcXo1/O5Qa+zj6ZSQwz0jMhJjRLWMF+sYWr7s
 rBvnJLuW5jv7ekMlBw5O7Ai5QXf0/Ro88M3RslDQcrpKasVlBwnUl1HIReh3Mu7esP
 DzaItIk6Ht0BqqBYMLlq0Ld2lc4Z8slIEhYQ9RqoVyyXRqDi9kZOtrCzUCj7qPqSbG
 aV9YdZiysPnKA==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac2db121f95so201629266b.1
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 16:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742599296; x=1743204096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RklT/2SOwCLGW/x4Z+mv4hIOkSv1lsio9dNL09SFr6g=;
 b=mxNZcISkssZhcAYpws0Yyx8z/JUaffL7QGpJQHEkbCavmHrJoTgwPlQ71av1nyo0mk
 CCtbO2Z+XlckOAFqy67evTzIN2fiougX0+l5RS8HcTeR6z2hPJQHAkSwbpxm5L58Fuwl
 hhvE37Dpfg1ZNqvyX5345yQQ64ThFVf6JF2im8jLtyQSkJ6jAjDs5oM1dt787+C6MVU2
 7YH8Qy6TqZ02jubF/jVY6mjqXI/RQ+VOG/ruwF943aHc4Vq46OYhaRKPS+gYaIduFCqV
 qmk/Bd3anibLL2dc5VHyOS8O/G6PshyApEZinb25ZdgEBETb+1DapSIRdms6x89/V5wo
 YkGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG5ZYxFbe6nGb7qKVpYHKYF0Y2NuKJxRTCZdrBA3SNmQuuAk6Py6iFmXKpJg8kiwTDAkpqaGg=@lists.denx.de
X-Gm-Message-State: AOJu0YzOcAnQP7mUkC0tSRLUaewOZXDq6ntAg4OW6HmVCePCX5VWhUTU
 vf+bYSYjNeW36jHYfxW1w420YP80fKEsIMvGqJgkAzA7Z7Imu8VLXoyRD70l+x+exNOJM2rvJKH
 r3VuUX/WqO2G7mQgbb+ksHMJPNrv3hLkJ97Xcf8E9KmwrOhoRM1uWAVZ/AyLqw1hHhVk=
X-Gm-Gg: ASbGncvUR1gyTjxMVx48FUlbCfbIdq5jnSephZ4O+oB5YtEVqPPBtI2KV/ph5Mv/dtn
 0du4v2b557iyCMtG6U6cNFP0yQu9Ea3BmATYV5YV4qETJef6v6BUbrVX+AHi/98B6fMR15eS7Ik
 MXuXFi8VPyC2dFTdU/HkwkTe2qw/mjmSGXyw+4WaF8Z/h1jJZFOr7kkC9lDUrIiV7gARwBm05CJ
 gmLjTYDiTtzU9hAwnfC1kTitP/KqYRo9uerElkHSHkAsIKDTL2OEluCXV6aIGVxOh228S07MBs2
 TvbnZg8V4G0+jvduBcelSqyhdz9F8NNBXhSiPY4YvBxj7M/a7sfOi47Zw9NY4EBFPqfj3fyEl0K
 p8lVM+X74RbtvlieSQQ==
X-Received: by 2002:a17:907:7208:b0:ac2:c06:ad9d with SMTP id
 a640c23a62f3a-ac3f2139774mr459710966b.14.1742599296105; 
 Fri, 21 Mar 2025 16:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKAogK0wjB9yJiBshyqxZA6w/m+Q8dWTc9kS3RSDzr0RuN39DV4tJZYFQ7tKQFqFeop/tYhA==
X-Received: by 2002:a17:907:7208:b0:ac2:c06:ad9d with SMTP id
 a640c23a62f3a-ac3f2139774mr459709166b.14.1742599295618; 
 Fri, 21 Mar 2025 16:21:35 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd3aa21sm231673866b.158.2025.03.21.16.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 16:21:35 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/5] acpi: simplify updating header checksum
Date: Sat, 22 Mar 2025 00:21:17 +0100
Message-ID: <20250321232121.251800-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
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

Use acpi_update_checksum() for updating ACPI table header checksum.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/acpi/acpi_table.c | 18 +++++++-----------
 lib/acpi/base.c       |  6 ++----
 lib/acpi/csrt.c       |  2 +-
 lib/acpi/mcfg.c       |  2 +-
 lib/acpi/ssdt.c       |  2 +-
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index c0ed24984af..b5495d48a46 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -195,9 +195,7 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
 					(sizeof(u32) * (i + 1));
 
 		/* Re-calculate checksum */
-		rsdt->header.checksum = 0;
-		rsdt->header.checksum = table_compute_checksum((u8 *)rsdt,
-							       rsdt->header.length);
+		acpi_update_checksum(&rsdt->header);
 	}
 
 	if (ctx->xsdt) {
@@ -228,9 +226,7 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
 					(sizeof(u64) * (i + 1));
 
 		/* Re-calculate checksum */
-		xsdt->header.checksum = 0;
-		xsdt->header.checksum = table_compute_checksum((u8 *)xsdt,
-							       xsdt->header.length);
+		acpi_update_checksum(&xsdt->header);
 	}
 
 	return 0;
@@ -268,7 +264,7 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 	acpi_fill_fadt(fadt);
 
-	header->checksum = table_compute_checksum(fadt, header->length);
+	acpi_update_checksum(header);
 
 	return acpi_add_fadt(ctx, fadt);
 }
@@ -303,7 +299,7 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	if (IS_ENABLED(CONFIG_ACPI_PARKING_PROTOCOL))
 		acpi_write_park(madt);
 
-	header->checksum = table_compute_checksum((void *)madt, header->length);
+	acpi_update_checksum(header);
 	acpi_add_table(ctx, madt);
 	ctx->current = (void *)madt + madt->header.length;
 
@@ -374,7 +370,7 @@ void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 	/* Update structure lengths and checksum */
 	device->length = current - (uintptr_t)device;
 	header->length = current - (uintptr_t)dbg2;
-	header->checksum = table_compute_checksum(dbg2, header->length);
+	acpi_update_checksum(header);
 }
 
 int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
@@ -549,7 +545,7 @@ static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry
 		spcr->baud_rate = 0;
 
 	/* Fix checksum */
-	header->checksum = table_compute_checksum((void *)spcr, header->length);
+	acpi_update_checksum(header);
 
 	acpi_add_table(ctx, spcr);
 	acpi_inc(ctx, spcr->header.length);
@@ -759,7 +755,7 @@ static int acpi_write_iort(struct acpi_ctx *ctx, const struct acpi_writer *entry
 
 	/* (Re)calculate length and checksum */
 	iort->header.length = ctx->current - (void *)iort;
-	iort->header.checksum = table_compute_checksum((void *)iort, iort->header.length);
+	acpi_update_checksum(&iort->header);
 	log_debug("IORT at %p, length %x\n", iort, iort->header.length);
 
 	/* Drop the table if it is empty */
diff --git a/lib/acpi/base.c b/lib/acpi/base.c
index 8b6af2bc43a..5c755b14c16 100644
--- a/lib/acpi/base.c
+++ b/lib/acpi/base.c
@@ -50,8 +50,7 @@ static void acpi_write_rsdt(struct acpi_rsdt *rsdt)
 	/* Entries are filled in later, we come with an empty set */
 
 	/* Fix checksum */
-	header->checksum = table_compute_checksum(rsdt,
-						  sizeof(struct acpi_rsdt));
+	acpi_update_checksum(header);
 }
 
 static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
@@ -66,8 +65,7 @@ static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
 	/* Entries are filled in later, we come with an empty set */
 
 	/* Fix checksum */
-	header->checksum = table_compute_checksum(xsdt,
-						  sizeof(struct acpi_xsdt));
+	acpi_update_checksum(header);
 }
 
 static int acpi_write_base(struct acpi_ctx *ctx,
diff --git a/lib/acpi/csrt.c b/lib/acpi/csrt.c
index 00927e53406..b863c644c07 100644
--- a/lib/acpi/csrt.c
+++ b/lib/acpi/csrt.c
@@ -40,7 +40,7 @@ int acpi_write_csrt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 	/* (Re)calculate length and checksum */
 	header->length = (ulong)ctx->current - (ulong)csrt;
-	header->checksum = table_compute_checksum(csrt, header->length);
+	acpi_update_checksum(header);
 
 	acpi_add_table(ctx, csrt);
 
diff --git a/lib/acpi/mcfg.c b/lib/acpi/mcfg.c
index 8b8a5bfafae..e21fe7ce123 100644
--- a/lib/acpi/mcfg.c
+++ b/lib/acpi/mcfg.c
@@ -57,7 +57,7 @@ int acpi_write_mcfg(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 	/* (Re)calculate length and checksum */
 	header->length = (ulong)ctx->current - (ulong)mcfg;
-	header->checksum = table_compute_checksum(mcfg, header->length);
+	acpi_update_checksum(header);
 
 	acpi_add_table(ctx, mcfg);
 
diff --git a/lib/acpi/ssdt.c b/lib/acpi/ssdt.c
index df1d739d117..41e2d3c2f6c 100644
--- a/lib/acpi/ssdt.c
+++ b/lib/acpi/ssdt.c
@@ -35,7 +35,7 @@ int acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 	/* (Re)calculate length and checksum */
 	ssdt->length = ctx->current - (void *)ssdt;
-	ssdt->checksum = table_compute_checksum((void *)ssdt, ssdt->length);
+	acpi_update_checksum(ssdt);
 	log_debug("SSDT at %p, length %x\n", ssdt, ssdt->length);
 
 	/* Drop the table if it is empty */
-- 
2.48.1

