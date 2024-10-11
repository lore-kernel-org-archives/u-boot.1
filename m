Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08B3CFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43AE5892FE;
	Fri, 11 Oct 2024 12:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="HU/CGYc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568B489319; Fri, 11 Oct 2024 12:34:43 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6315F892FB
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9953bdc341so175077666b.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642881; x=1729247681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOeZlTEURRuOUzJmfMfrtVLnNbwCgdwqbwXKpCNFyDM=;
 b=HU/CGYc2gUQ9WdXPJXEYlWpxB75K3Q2enTAITskujVB+gMV8s4WGVKnDp+EJz1yhmt
 qmoXXwG/QzY50EzQiucZPWmZfUGBpCCIZ+W6tsD7mXbgcjY8mDbvFCLDiYcDQzSArqBR
 2wRLms6X7U3uiRHCnLgIHZKTykOiEpHjDZGWZRl6fWERXiIZbew438u1ve2TF64GowIj
 HunKViQ6wONrWQjs7qJSmIVsQ+8I9Yffx+CkcBMVbIaSbUnkX66X2koTbB3XFLOy9TiK
 8KW4i8RwR4BwmT44indl4zcJHFcYiHBsJyEA4UZE353kP2cti0O06YFO7DR3ir5jVKL9
 7W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642881; x=1729247681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOeZlTEURRuOUzJmfMfrtVLnNbwCgdwqbwXKpCNFyDM=;
 b=K4Cuxku99njgNLO0RRCl7UxC0tQp0NuYT8v3cvoE5y5Vqgd341Vwz3rXJhtG3Xf7+Q
 kTqB3aCusaMaBgnlOoGeBSTgiZt+NWMNyOCltoYzzQxsOz+rmGUK+aIWxMBeY9/g2qI4
 S9UOxfqikrbYSt/RuQHZVKXqOsSd0qy0TwYB8uvrYwSPnfM3iBtgTSPhofoCQKSFQpkF
 AqNK0Cfd0mzOTBRHRFpVdygMynfRdvTsnI5oIa4F7+3Rk3ZuEyezA7ybdc8H8SQ+cfNK
 T/iXWAF8IOQR0YlotoN7dvlQc6sLb7/p7SX5gyg5KgBncl3SbNXUsW3ZvEGkDxn0lcB0
 V0Uw==
X-Gm-Message-State: AOJu0YzWM97FWJy/jrWmtioMrOvNOlD5NvOP4F9z/tjktifVBM6Ez/3+
 S/W3dfwG54JNDsNTUkCVNbbuLBiGK9l+HTv/87fMJqZIARli8dahCiS2UNOSV8dV3EHBOgdxqSu
 VKGI=
X-Google-Smtp-Source: AGHT+IH4CeuaMGcWnZrlRUXl8DQeSDS0vJD1ADbV0i+yMCdeyOqBR8J83bn2DA9eGBa34krAicJrpA==
X-Received: by 2002:a17:906:f590:b0:a99:4780:1af with SMTP id
 a640c23a62f3a-a99b93c8dc4mr152576066b.31.1728642880746; 
 Fri, 11 Oct 2024 03:34:40 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:40 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 09/37] acpi: acpi_table: Bump revisions
Date: Fri, 11 Oct 2024 12:22:50 +0200
Message-ID: <20241011102419.12523-10-patrick.rudolph@9elements.com>
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

