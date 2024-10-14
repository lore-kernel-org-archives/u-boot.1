Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BB7D1625B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436BD890D1;
	Mon, 14 Oct 2024 15:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="NvKtd5Qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA85890EC; Mon, 14 Oct 2024 15:12:23 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25E6C89063
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43124d1ca5dso20280895e9.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911540; x=1729516340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOeZlTEURRuOUzJmfMfrtVLnNbwCgdwqbwXKpCNFyDM=;
 b=NvKtd5Qo+/oMR2Kleikqabu12X1mFcXFUiF+OA1FTBbEWy2S1p3+zxWLEkvgMTHD7R
 BJNo6wKxW0UX/h1vocloBGDp7aLp6an9bb9vHVASGpMk4wvWAsiseZup0MxXiOnyunDv
 jWs7rDEitIHCaqb0GXw0UTcMJ02ENWHpt5D6Sz4Bkl4Q/B+heu11TrVwKClPCyZ1rzsi
 S55dYUkcoioNFWpgjSuy1kE/Be61vnKdiPHjW6qSlMZFW782V4X8TvHeC37P774HjUmK
 nhaXEi3EKcJGipgPx7l8Bn1iDXChHo/PY0VvNtBFIIfISmy1GmV5LyrQlA/rc2gMwADc
 f4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911540; x=1729516340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOeZlTEURRuOUzJmfMfrtVLnNbwCgdwqbwXKpCNFyDM=;
 b=skwvu1nheXE/fW7ghPm5v6Z7AP50XfpKwl8mNtILQh/mnykdsowgR9iJ75+kDG/zT/
 TESvbag0LPZC8RZOGZD+9nvy2mKuI+dmH9nbFNSGIDjCxktrd0RfxNY6jTqpMAZ1V/cf
 Oy8v5WQgCkuGlkCajJfza+Xt5pBXhMd5KL+ZUxMDaPXUtghSsc+a8E3YBctzoeg0AUiC
 vEqSgdVRjGkVbetJ+747Bltcna0PboH+VtYqn5BhDfCZ2os9g/sh9OOysQOBihMucC3/
 Dgvt95VVN7rGPcFnKPkMECODBeGLYrEUa1gRVAf0A8cwAtEmOIRS7vuocs6gTJD43sQP
 NbyA==
X-Gm-Message-State: AOJu0YzWc+PqtVu2+Tg8jJcpzpEbMvaHB31AolmhF1Tw5uNihbz23Jrc
 0AOBsfoRJVh8E/fdEPMYg87wz/DkTYk7Bue/8hf7aBG45kmwheAOl61UYnPx8SjZRJ5MCpI5vYA
 R
X-Google-Smtp-Source: AGHT+IFJEeiOmIXImzvy+XW3DVsXGOHbUg5iamQVcw8Jwn7MFmwAvvYRVdZqjd5pK4n6FGtCsrIXzQ==
X-Received: by 2002:a5d:654b:0:b0:37d:4647:155a with SMTP id
 ffacd0b85a97d-37d54e0a606mr8121676f8f.0.1728911540416; 
 Mon, 14 Oct 2024 06:12:20 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:20 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 09/37] acpi: acpi_table: Bump revisions
Date: Mon, 14 Oct 2024 15:10:25 +0200
Message-ID: <20241014131152.267405-10-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

The FADT structure found in U-Boot represents FADT revision 6 and the
GICC and GICD structures defined in U-Boot are based on ACPI revision
6.3.

Bump the table revision to fix FWTS failures seen on aarch64.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/cpu/tangier/acpi.c | 2 --
 include/acpi/acpi_table.h   | 3 ++-
 lib/acpi/acpi_table.c       | 7 ++++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index 3d11787861..8ea764f7cc 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -28,8 +28,6 @@ void acpi_fill_fadt(struct acpi_fadt *fadt)
 		ACPI_FADT_POWER_BUTTON | ACPI_FADT_SLEEP_BUTTON |
 		ACPI_FADT_SEALED_CASE | ACPI_FADT_HEADLESS |
 		ACPI_FADT_HW_REDUCED_ACPI;
-	fadt->header.revision = 6;
-	fadt->minor_revision = 2;
 }
 
 void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 7d994a985f..48f8ce248f 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -290,7 +290,8 @@ struct __packed acpi_fadt {
 #define ACPI_MADT_REV_ACPI_3_0		2
 #define ACPI_MADT_REV_ACPI_4_0		3
 #define ACPI_MADT_REV_ACPI_5_0		3
-#define ACPI_MADT_REV_ACPI_6_0		5
+#define ACPI_MADT_REV_ACPI_6_2		4
+#define ACPI_MADT_REV_ACPI_6_3		5
 
 #define ACPI_MCFG_REV_ACPI_3_0		1
 
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 5b9b4d2f29..959cac9e2e 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -63,9 +63,9 @@ int acpi_get_table_revision(enum acpi_tables table)
 {
 	switch (table) {
 	case ACPITAB_FADT:
-		return ACPI_FADT_REV_ACPI_3_0;
+		return ACPI_FADT_REV_ACPI_6_0;
 	case ACPITAB_MADT:
-		return ACPI_MADT_REV_ACPI_3_0;
+		return ACPI_MADT_REV_ACPI_6_2;
 	case ACPITAB_MCFG:
 		return ACPI_MCFG_REV_ACPI_3_0;
 	case ACPITAB_TCPA:
@@ -219,6 +219,7 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
 	memcpy(header->creator_id, ASLC_ID, 4);
 	header->creator_revision = 1;
+	fadt->minor_revision = 2;
 
 	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
 	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
@@ -254,7 +255,7 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	/* Fill out header fields */
 	acpi_fill_header(header, "APIC");
 	header->length = sizeof(struct acpi_madt);
-	header->revision = ACPI_MADT_REV_ACPI_3_0;
+	header->revision = acpi_get_table_revision(ACPITAB_MADT);
 
 	acpi_inc(ctx, sizeof(struct acpi_madt));
 	/* TODO: Get rid of acpi_fill_madt and use driver model */
-- 
2.46.2

