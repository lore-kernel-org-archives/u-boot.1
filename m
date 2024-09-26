Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4A7CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 717FC88D97;
	Thu, 26 Sep 2024 10:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="H+ZaaOvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C7788D97; Thu, 26 Sep 2024 10:09:54 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7FC88C4A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb2191107so5579015e9.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727338188; x=1727942988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVS/TQvaGEbeIBlKGP3PnXHKxQyaGbllvziHc8nYQ/M=;
 b=H+ZaaOvEYcT2dNHqrHGCsWcPftiwtXF+XWIVbmxJTU9CDWSC+mDEqEHmHhwzVvBQdJ
 BBu3rPNvkCRcrNgomkVkw1gQXH6tXUquiBkAmB6EQ6y0WiYsOaUfY/D77y7eveyIgN/h
 wHD5ioZ99NtZbcIUybpu6gph29M7g2ZS73fY4I7g980uRkLb0jYEfnnfRNCNMqiO0NYy
 S5ESVzS0P1tpIaKpKXc8Nh6tzmOaPGh0GvL9L8UO2iuNVsWnoW3KYc+lqGGFbNeTQVUo
 1QTh9UBJH1AKyut7QlOFk6z5tvIpFj0n9dNgvto92Js535/92c3fQwUzM1nj1RnWCakp
 8n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727338188; x=1727942988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVS/TQvaGEbeIBlKGP3PnXHKxQyaGbllvziHc8nYQ/M=;
 b=Y3XuCaEVIrwcGaEZCC1ZmkXsfBVKkHg+mxOUxFASWrYrdENY7B5xaSVtdoCUBSwjgF
 8VIMupCJU5QyILovalaUQagLA3GkItl7AkXpUMu3S6bUYZPDyrNjUApNvogne8YYrQcc
 IEZgftlXk3SNzTpCuYRthM5WW6WTa0xr8tcmL08r4MA7EtNofU+k6Bbi7LX5VwrWQKmz
 2AnSLAlaEcoZOcpAWZPhqD7Q9CEjH+pKg5P5nMXMAxylpFQFBY+T+i88StkKjarwmw7t
 TdhZLV/6cDD2wtSN02gqHpksZtr8GPWmJDy/ABiL99M9TbcMqQ3K4ldUwHrKEXsnHKFn
 TEcA==
X-Gm-Message-State: AOJu0YxXLAGwbzu/l+9390cxYkkrbBxOu2PueLWZ6CBGTf8pWAllNUpD
 WOp5c11l27gUcB8EFsXn4dmpRsdoeaDpuT5SvhGQ92sC62JPxjN9MacvA/cDDPQ5w2HoQ//GlkR
 q
X-Google-Smtp-Source: AGHT+IEtWfK0Pa1cxaonOEw+SYb17dL/FLx4ccCK9Wa3ofBm9TdFFWz+AuCmbeXfIX3iG1UOvKtZbg==
X-Received: by 2002:a05:6402:4416:b0:5c5:c5c0:74ec with SMTP id
 4fb4d7f45d1cf-5c7206449d6mr4533032a12.24.1727337749017; 
 Thu, 26 Sep 2024 01:02:29 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:27 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 09/36] acpi: acpi_table: Bump revisions
Date: Thu, 26 Sep 2024 09:58:57 +0200
Message-ID: <20240926080021.148031-10-patrick.rudolph@9elements.com>
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
2.46.0

