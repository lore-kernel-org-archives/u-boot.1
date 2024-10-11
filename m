Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1FECFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4F9892F5;
	Fri, 11 Oct 2024 12:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="K6A/44Sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF8C89304; Fri, 11 Oct 2024 12:34:41 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ACAB892BF
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a995ec65c35so177047166b.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642879; x=1729247679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIm3RfmL1mykx4uPeLEp7kXvVjFAxT7doFgCV3VZEN8=;
 b=K6A/44SdbDN+f74fRb8J08sP8LzZpGalIiwmz7xLcloZUGLVICRnkAC6o0Xr8EXbeS
 M2VhTuHAE1IgALTP1hVNXCAX+3t8uPc673LU07VNWBylUQHV7WAoOa8xxucM/REiOeN2
 zNfGfpI3wVGK5UMIe2xylBjp5EwiJ3tWowJHvILHw0sj+gCPL7iTu5VPrvimrZDnWiRr
 TNqvnodelFRU4ynA0OnXwb7Y2kD536FY4vAdgK+TcB1NZZjZSs5ZNfs/EMpvyLYWcnlM
 YZTCosJ//9bWcdGcJfzw0AkQczgW22Fz9pVXWi0lfNHgmEeSCQq7NnEqaeZUJc71X+rP
 YV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642879; x=1729247679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIm3RfmL1mykx4uPeLEp7kXvVjFAxT7doFgCV3VZEN8=;
 b=Tot5m8Wx4Yjf4Ff2z/jS1fKCnJFjU/1GrE1Qt6GJdk3XMP/CTAAKr5mYMhVurHx9Ok
 itFqiMNa9nCH4/EAJLQGsk+6tMFDA4JXq5q4A5BUwoggZ25eo/NatuGMg9p72INNVBSr
 gDVnhkPtcXGq1EG1sdHLi5wHhhT17wS2OgwQckhpdp88XKEZunak1RvRhXug2BE5DQqh
 snyGNFxme43RJHoL37wgbFUKJb1zsZAYsVGzJgzKhMC4ExzuuqdW0ArcUcbwSTwt9SM5
 RIyt2uhS1QB4qfvJ4e5fLswywDy7vyM/0GYT1hxUDfMSk7NPOGjEc0iXimtE9HHsBHmx
 pMBw==
X-Gm-Message-State: AOJu0YxFqXKX9y+NUwslOXYgs6XsDIYIe39NwX8p9DYXM7DM6I+qGSyT
 XdU8BpFV+54TvSosHCnQmC1QP27ame54MuZxD4IUjEL5/Lq5AZnvgMmUxJPytaTbucCSHvxM2YF
 eJWo=
X-Google-Smtp-Source: AGHT+IFs3AGGwGswK+4lArDAxGwTUNZ1F5Ho15oAlH/ZI2YJJfrsg3Wm29Lg3iLFX4i/G8uJIfboOA==
X-Received: by 2002:a17:907:6d24:b0:a99:637c:c2e0 with SMTP id
 a640c23a62f3a-a99b89fb7b9mr181485366b.31.1728642878902; 
 Fri, 11 Oct 2024 03:34:38 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:38 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 08/37] acpi: Add fill_madt to acpi_ops
Date: Fri, 11 Oct 2024 12:22:49 +0200
Message-ID: <20241011102419.12523-9-patrick.rudolph@9elements.com>
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

Add a new method to acpi_ops to let drivers fill out ACPI MADT.
The code is unused for now until drivers implement the new ops.

TEST: Booted on QEMU sbsa using driver model generated MADT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
Changelog v4:
- Drop __weak attribute and make driver model mandatory on Arm
Changelog v7:
- Rebase on -next

---
 arch/arm/lib/acpi_table.c | 13 ++++++++++++
 drivers/core/acpi.c       | 16 +++++++++++++++
 include/dm/acpi.h         | 26 +++++++++++++++++++++++
 lib/acpi/acpi_table.c     |  2 +-
 test/dm/acpi.c            | 43 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
index 286ed7ceca..e0add04926 100644
--- a/arch/arm/lib/acpi_table.c
+++ b/arch/arm/lib/acpi_table.c
@@ -11,6 +11,8 @@
 #include <acpi/acpigen.h>
 #include <acpi/acpi_device.h>
 #include <acpi/acpi_table.h>
+#include <dm/acpi.h>
+#include <dm/uclass.h>
 
 void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
 			  uint perf_gsiv, ulong phys_base, ulong gicv,
@@ -112,3 +114,14 @@ int acpi_pptt_add_cache(struct acpi_ctx *ctx, const u32 flags,
 
 	return offset;
 }
+
+void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
+{
+	uclass_probe_all(UCLASS_CPU);
+	uclass_probe_all(UCLASS_IRQ);
+
+	/* All SoCs must use the driver model */
+	acpi_fill_madt_subtbl(ctx);
+
+	return ctx->current;
+}
diff --git a/drivers/core/acpi.c b/drivers/core/acpi.c
index 9f78422892..4763963914 100644
--- a/drivers/core/acpi.c
+++ b/drivers/core/acpi.c
@@ -48,6 +48,7 @@ enum method_t {
 	METHOD_FILL_SSDT,
 	METHOD_INJECT_DSDT,
 	METHOD_SETUP_NHLT,
+	METHOD_FILL_MADT,
 };
 
 /* Prototype for all methods */
@@ -282,6 +283,8 @@ acpi_method acpi_get_method(struct udevice *dev, enum method_t method)
 		switch (method) {
 		case METHOD_WRITE_TABLES:
 			return aops->write_tables;
+		case METHOD_FILL_MADT:
+			return aops->fill_madt;
 		case METHOD_FILL_SSDT:
 			return aops->fill_ssdt;
 		case METHOD_INJECT_DSDT:
@@ -328,6 +331,19 @@ int acpi_recurse_method(struct acpi_ctx *ctx, struct udevice *parent,
 	return 0;
 }
 
+int acpi_fill_madt_subtbl(struct acpi_ctx *ctx)
+{
+	int ret;
+
+	log_debug("Writing MADT table\n");
+	ret = acpi_recurse_method(ctx, dm_root(), METHOD_FILL_MADT, TYPE_NONE);
+	log_debug("Writing MADT finished, err=%d\n", ret);
+	if (ret)
+		return log_msg_ret("build", ret);
+
+	return ret;
+}
+
 int acpi_fill_ssdt(struct acpi_ctx *ctx)
 {
 	void *start = ctx->current;
diff --git a/include/dm/acpi.h b/include/dm/acpi.h
index 3adfe21767..d6bc0c099a 100644
--- a/include/dm/acpi.h
+++ b/include/dm/acpi.h
@@ -146,6 +146,22 @@ struct acpi_ops {
 	 */
 	int (*write_tables)(const struct udevice *dev, struct acpi_ctx *ctx);
 
+	/**
+	 * fill_madt() - Generate MADT sub-tables for a device
+	 *
+	 * This is called to create the MADT table. The method should write out
+	 * whatever sub-table is needed by this device. It will end up in the
+	 * MADT table.
+	 *
+	 * Note that this is called 'fill' because the entire contents of the
+	 * MADT is build by calling this method on all devices.
+	 *
+	 * @dev: Device to write
+	 * @ctx: ACPI context to use
+	 * @return 0 if OK, -ve on error
+	 */
+	int (*fill_madt)(const struct udevice *dev, struct acpi_ctx *ctx);
+
 	/**
 	 * fill_ssdt() - Generate SSDT code for a device
 	 *
@@ -231,6 +247,16 @@ int acpi_copy_name(char *out_name, const char *name);
  */
 int acpi_write_dev_tables(struct acpi_ctx *ctx);
 
+/**
+ * acpi_fill_madt_subtbl() - Generate ACPI tables for MADT
+ *
+ * This is called to create the MADT sub-tables for all devices.
+ *
+ * @ctx: ACPI context to use
+ * Return: 0 if OK, -ve on error
+ */
+int acpi_fill_madt_subtbl(struct acpi_ctx *ctx);
+
 /**
  * acpi_fill_ssdt() - Generate ACPI tables for SSDT
  *
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 639d78125f..5b9b4d2f29 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -257,11 +257,11 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	header->revision = ACPI_MADT_REV_ACPI_3_0;
 
 	acpi_inc(ctx, sizeof(struct acpi_madt));
+	/* TODO: Get rid of acpi_fill_madt and use driver model */
 	current = acpi_fill_madt(madt, ctx);
 
 	/* (Re)calculate length and checksum */
 	header->length = (uintptr_t)current - (uintptr_t)madt;
-
 	header->checksum = table_compute_checksum((void *)madt, header->length);
 	acpi_add_table(ctx, madt);
 	ctx->current = (void *)madt + madt->header.length;
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 7ccd7f8d20..39a26bbb49 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -95,6 +95,21 @@ static int testacpi_get_name(const struct udevice *dev, char *out_name)
 		return acpi_copy_name(out_name, ACPI_TEST_DEV_NAME);
 }
 
+static int testacpi_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	u64 *data = ctx->current;
+
+	/* Only fill madt once */
+	if (device_get_uclass_id(dev->parent) != UCLASS_TEST_ACPI)
+		return 0;
+
+	*data = 0xdeadbeef;
+
+	acpi_inc(ctx, sizeof(u64));
+
+	return 0;
+}
+
 static int testacpi_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
 {
 	const char *data;
@@ -124,6 +139,7 @@ static int testacpi_inject_dsdt(const struct udevice *dev, struct acpi_ctx *ctx)
 struct acpi_ops testacpi_ops = {
 	.get_name	= testacpi_get_name,
 	.write_tables	= testacpi_write_tables,
+	.fill_madt	= testacpi_fill_madt,
 	.fill_ssdt	= testacpi_fill_ssdt,
 	.inject_dsdt	= testacpi_inject_dsdt,
 };
@@ -527,6 +543,33 @@ static int dm_test_acpi_fill_ssdt(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_acpi_fill_ssdt, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test acpi_fill_madt() */
+static int dm_test_acpi_fill_madt(struct unit_test_state *uts)
+{
+	struct acpi_ctx ctx;
+	u64 *buf;
+
+	buf = malloc(BUF_SIZE);
+	ut_assertnonnull(buf);
+
+	acpi_reset_items();
+	ctx.current = buf;
+	buf[1] = 'z';	/* sentinel */
+	ut_assertok(acpi_fill_madt_subtbl(&ctx));
+
+	/*
+	 * These values come from acpi-test2's acpi-ssdt-test-data property.
+	 * This device comes first because of u-boot,acpi-ssdt-order
+	 */
+	ut_asserteq(0xdeadbeef, buf[0]);
+
+	ut_asserteq('z', buf[1]);
+
+	return 0;
+}
+
+DM_TEST(dm_test_acpi_fill_madt, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* Test acpi_inject_dsdt() */
 static int dm_test_acpi_inject_dsdt(struct unit_test_state *uts)
 {
-- 
2.46.2

