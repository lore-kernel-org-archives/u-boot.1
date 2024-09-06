Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C7CE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2995A88D67;
	Fri,  6 Sep 2024 09:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="E8rX1oC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E9B88D5C; Fri,  6 Sep 2024 09:22:47 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1F8788D16
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a86a37208b2so241579766b.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607363; x=1726212163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWwAtuvGUTwXnbi30IVwTUxIM9btjMVWQAt6bX+T5+o=;
 b=E8rX1oC5FH8kS3HF/Ic466ZmL5CpHh7fqFNiB98bYx//pGwDdzC7bz/u6980t66Y1C
 iQs4+dP4CR0DRkML461H11MNyuV9q3MEoTCMV2VKb1ct5N/l8aiiFZsBSPtqLzWrn5iO
 Q85RRNJypn+Bh+YmUlKLHPH7f5a5lJ7I6Ks7Z1QfYldLxvGYf3L/Leo2myuwRC22RU/G
 8Z4sRlaEqDSx2exfgoPmr1vEunz0m3OfovS79LuZ2vef5Kb86v5YsdqiQ+/BfyzDdmfR
 REHlTysxKhY/Iw53dUGnG9UWcu7v2M8gSZ+1E3MGa42EkkZIIj2U/8F5/2eNiGixxGuQ
 5uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607363; x=1726212163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWwAtuvGUTwXnbi30IVwTUxIM9btjMVWQAt6bX+T5+o=;
 b=HYHgiX7cG+WEhmmNOtlpJPBn/uWo3adliEfxCV426MyMpJCcNFFA1S19BCithCKwB/
 8u+z/mZLHEXHZ5aa0gPuZNMxohbY2ctXiiJLcejuTT9D5hSSTmGt8kSjNcAgCh4bXbxI
 +jhVnet3R42zJy1z5qVnwAfWgLPP5QDKb+scV+S75zjfmLwTIQK/vXvjm1drLJjSeZ8H
 yv1cP/L6pXheYnBKnioCjlSyG6ZChfusTiuF3u2xDrlEPs0rp3yGv6pf5GMNo3zXZYqL
 UCh66dpv5Ek7B97IrKyISNinIHyU9tOdr7a982tnlnLl0woB5TC5gYBsPRnZfi/d4gvb
 sS3g==
X-Gm-Message-State: AOJu0Yx7z6LCdVYvJKMzlFChZsHSwBr7LtGmmp+wmoZoy4CVWlMsAeMw
 EhocB54lrhJoXfaU4M0mrIW3BdEGolrP2Er/Rtoh3W/Z6rdfD1C+zkz0SqFccggFkuzXGMQJRAz
 y
X-Google-Smtp-Source: AGHT+IHx2JrvJ2z0xyUbNdnosPMXpNhPXr08ObONeR+24i1iFg8rLNr7gpF9XX2EkGSRarxILX1ECg==
X-Received: by 2002:a17:907:948f:b0:a72:750d:ab08 with SMTP id
 a640c23a62f3a-a897f77eef9mr1997891066b.14.1725607363319; 
 Fri, 06 Sep 2024 00:22:43 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:43 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 08/28] acpi: Add fill_madt to acpi_ops
Date: Fri,  6 Sep 2024 09:22:10 +0200
Message-ID: <20240906072231.2531491-9-patrick.rudolph@9elements.com>
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

Add a new method to acpi_ops to let drivers fill out ACPI MADT.
The code is unused for now until drivers implement the new ops.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/core/acpi.c   | 16 ++++++++++++++++
 include/dm/acpi.h     | 26 ++++++++++++++++++++++++++
 lib/acpi/acpi_table.c | 12 +++++++++++-
 test/dm/acpi.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)

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
index 823af43045..2173701e6d 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -249,6 +249,7 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	struct acpi_table_header *header;
 	struct acpi_madt *madt;
 	void *current;
+	u32 old_length;
 
 	madt = ctx->current;
 
@@ -261,14 +262,23 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	header->revision = ACPI_MADT_REV_ACPI_3_0;
 
 	current = (void *)madt + sizeof(struct acpi_madt);
+	/* TODO: Get rid of acpi_fill_madt */
 	current = acpi_fill_madt(madt, current);
 
+	/* Calculate length */
+	header->length = (uintptr_t)current - (uintptr_t)madt;
+	old_length = header->length;
+	acpi_inc(ctx, madt->header.length);
+
+	acpi_fill_madt_subtbl(ctx);
+	current = ctx->current;
+
 	/* (Re)calculate length and checksum */
 	header->length = (uintptr_t)current - (uintptr_t)madt;
 
 	header->checksum = table_compute_checksum((void *)madt, header->length);
 	acpi_add_table(ctx, madt);
-	acpi_inc(ctx, madt->header.length);
+	acpi_inc(ctx, madt->header.length - old_length);
 
 	return 0;
 }
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 7da381f1a5..cc032a4618 100644
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
@@ -532,6 +548,32 @@ static int dm_test_acpi_fill_ssdt(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_acpi_fill_ssdt, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
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
+DM_TEST(dm_test_acpi_fill_madt, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+
 /* Test acpi_inject_dsdt() */
 static int dm_test_acpi_inject_dsdt(struct unit_test_state *uts)
 {
-- 
2.45.2

