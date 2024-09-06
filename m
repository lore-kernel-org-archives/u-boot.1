Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3173DCE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D4C788D6D;
	Fri,  6 Sep 2024 09:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="BGK45st0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E17188D22; Fri,  6 Sep 2024 09:22:48 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58C088D22
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32971cso1999605a12.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607364; x=1726212164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qm8qEMxkiL4qM4W4+zM1TqzkWChqVLEig9jP5mp8Vpg=;
 b=BGK45st0VAzAynjohmzd+4D6rMCobK3AX9KEezuKJkY48oaTjUPi1LzQ7RxsTeKEDH
 tegEa+VyB2YNhTd8CuOTnJy4TlENap53m/hBWuoyb+zbDaszLZplZ7gBwp+nZ9q3uH9R
 jDz1PlznD/aFLarYzcQrQrnZqDIkMvQLYW+Y4g96RfEEgFR6gXZhFcagRgg706m/z2VH
 3g/FQ5qojoVGV3n3wD5OloeKWGJPzeJhB6RxvDtpHSEReD1RmbUw4Rwxd7azu62TvSqj
 DnqXhscTWswlLWgkox0XbM2ArpN48B+HUt1gGPwG5wWaMC/i2zECKA7Wy5Tr/gMfw7+0
 Jpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607364; x=1726212164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qm8qEMxkiL4qM4W4+zM1TqzkWChqVLEig9jP5mp8Vpg=;
 b=MKDuDjZst8S5WQG34oEQIUHi8AXhgnnUUk2g0HbRHMI66lpfOz8ysLvZWzTW10SPrj
 Z36XebKVCQ01r3583ugIvsZ9mIDHSaPer7z76yDNOhUeCEmI01DaAsdR6pI+ZZR/8PgU
 uGDokN95ECZJqubaM3LanJ7fAdUe+MgvCF34g6iQ0aFZ5lgv7XOjB6MkKZQGVyFa9Kaa
 qKCEpxA8jwNo4wp8tLnh0wzSVFf6e3iBqHDzzLfC35Fyh89ypm8M5aMqkleJHL+Tm9pN
 9w6K1t7rvANKTHF7oUNRk5eTX3t221DuS3uFMjWDzWk2AroL+pbxZT7VeFC8HzR3XS/M
 NyQw==
X-Gm-Message-State: AOJu0YxWS2cg7frcK2Pva5oSzYS1dSugHHsSAdQbwyjowH8zEk09anLz
 FtOXIfroxo6u7dymv2dKYrUY3pSLQDf1OXimBiRvaq1zJvA03Z5ENFlJGk2nPEw/+meAcS7OHiV
 /
X-Google-Smtp-Source: AGHT+IEHgGLpjMWgBu1pg/ZmxeiGjbQQva/CPBOOeaWHbV2TuzpbaIs/bQeDx6MX+CUzu6fwhsM+iA==
X-Received: by 2002:a17:907:96a7:b0:a86:a417:72d2 with SMTP id
 a640c23a62f3a-a8a88667ef1mr115766066b.35.1725607364134; 
 Fri, 06 Sep 2024 00:22:44 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:43 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 09/28] acpi: acpi_table: Bump revisions
Date: Fri,  6 Sep 2024 09:22:11 +0200
Message-ID: <20240906072231.2531491-10-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
index 9e5e6c57aa..7b0bcfd956 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -28,8 +28,6 @@ void acpi_fill_fadt(struct acpi_fadt *fadt)
 		ACPI_FADT_POWER_BUTTON | ACPI_FADT_SLEEP_BUTTON |
 		ACPI_FADT_SEALED_CASE | ACPI_FADT_HEADLESS |
 		ACPI_FADT_HW_REDUCED_ACPI;
-	fadt->header.revision = 6;
-	fadt->minor_revision = 2;
 }
 
 void *acpi_fill_madt(struct acpi_madt *madt, void *current)
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index efa5d7929e..bbe3c99a56 100644
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
index 2173701e6d..fbbf56a5af 100644
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
@@ -223,6 +223,7 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
 	memcpy(header->creator_id, ASLC_ID, 4);
 	header->creator_revision = 1;
+	fadt->minor_revision = 2;
 
 	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
 	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
@@ -259,7 +260,7 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	/* Fill out header fields */
 	acpi_fill_header(header, "APIC");
 	header->length = sizeof(struct acpi_madt);
-	header->revision = ACPI_MADT_REV_ACPI_3_0;
+	header->revision = acpi_get_table_revision(ACPITAB_MADT);
 
 	current = (void *)madt + sizeof(struct acpi_madt);
 	/* TODO: Get rid of acpi_fill_madt */
-- 
2.45.2

