Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0491BCF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F004F88FF8;
	Wed,  2 Oct 2024 11:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="JY5DQ4Uo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BA688FF8; Wed,  2 Oct 2024 11:51:51 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF2CA88F1F
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so62688195e9.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862708; x=1728467508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOeZlTEURRuOUzJmfMfrtVLnNbwCgdwqbwXKpCNFyDM=;
 b=JY5DQ4Uo8mgDuQ5XljlpfkmKNkR7AuTccZ4QX9bsG2qJiAtfmKE2cfDCVhvuIutA4J
 Tk0S61TWBHfR4JbPFfs3g98Z+FUI+B33WpaDqm5LbaXfFnHQfG4VMGI/bNRkrW49SXUB
 IqLlj3OrOEbo5MsV+Hs2Uw97aWeffePI12KoqY0DoS1kqEK0/QJZguTqdP8YirZgWHys
 vNbmg5gUHlup7g4QKSktXQCSUXj4HbpTVG+5zGMXpvw+Fwp3A+YdC2Ut5Uk2kDiav/B6
 PeO0/aZcLg5NIgroB0uqBYYn1AzVbm/gMTiODSImmoNYlRUoHzM88Gv9mS6mT5LPhIjJ
 tWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862708; x=1728467508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOeZlTEURRuOUzJmfMfrtVLnNbwCgdwqbwXKpCNFyDM=;
 b=TigvxRjPum5ujodbymuM+azmrlsF8Fi6IMtXulz2C2gqAUb9iymaIRkzni5HMRrxcI
 +5+/UqL5cPjdZHO2NBVp1RmD2KQzqHzNklw03ZxcIMPNRPA91LH62xLXnTFmq9UpJ5Dz
 orC1QxxJ+BsaBVHnXeNtHxSLp88eqq1HsaxfFAww6ZQ5A/XIFc+T38uyA+77hjfx5cff
 eji3sNhNgghvwLFcFQzCz5qV1OSjtp+dUoYvdLMy1jzedTRi+N5xDojYkrX3ZN5JPK74
 ZPFopcFSfEtmWR1IWAuAsQ6bcyTj6j2W44l4nhdrvYZ29zMpkKjQv5ao7kIkMmLANcw4
 LhkA==
X-Gm-Message-State: AOJu0Yyox8wv7qdy4E7md9dU4gkIraEIi333AbIMmQVfFo/BCDlvDS07
 tgMoNIcty/D7OdFVDC/cq5TYO21zECZvkoYmXDEJkPY+B1WxcH6Ic/Ta5pORFWpHlbxTl+avIVm
 n
X-Google-Smtp-Source: AGHT+IF4p653F8VYrCeiv+1sNxTvf6VeFOFQ3vWWMwMADEU6A55EGm2pnHkwzn8pvztI0Ig3T7UMpw==
X-Received: by 2002:a05:600c:1f8f:b0:42c:b1ee:4afb with SMTP id
 5b1f17b1804b1-42f777ee373mr18010095e9.26.1727862708343; 
 Wed, 02 Oct 2024 02:51:48 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:51:48 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 09/37] acpi: acpi_table: Bump revisions
Date: Wed,  2 Oct 2024 11:47:00 +0200
Message-ID: <20241002094832.24933-10-patrick.rudolph@9elements.com>
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

