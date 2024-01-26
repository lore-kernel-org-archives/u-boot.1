Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F32C47258
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 00:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C7F87763;
	Fri, 26 Jan 2024 01:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="edNyC0wh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08948784D; Fri, 26 Jan 2024 01:56:12 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6562F876EF
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 01:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6dbce74f917so83608b3a.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706230566; x=1706835366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7rc6nAC15lSczOpcfc+F+1qKvA728f3WAydJx3GihMQ=;
 b=edNyC0whlOWYg9X9NB7UTrtOH2IT5c916wGpfnwl6KgjSfIgjDRNlj6ArwFCDMLQ/V
 jc22l51DRATJgn0Y666ztn8KPIDbm+g+LQ2vz2HitM17Hj1Y6hq0t4Sb5gUgU9j2HCQo
 WXJka6NUI0Hyj+VLWBid8/P4k1QmG/fa4RTwxNEV50p7P0Y82Xv9IrTYcUNmvoh7hpKV
 dCvmVHGhF2DTPKtBbbWlJXBzZV68T4QwrMAlYYjjVOqvZwHXJURlT7Yiqn5SUXvdlHja
 fPi1aDpvKZ9fhXqJTWkoBY5iUOwwMleAx5N5XiRaAAZ7iBswLZWx66XJyIwxHEze3fsK
 c4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706230566; x=1706835366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7rc6nAC15lSczOpcfc+F+1qKvA728f3WAydJx3GihMQ=;
 b=q7UNiXfirSrQtGh6uiJ1fEjnZfgY9iY7/Aqam71RRtDjLd1pBN4DtXFdyfXe+/oIR2
 hGMGSQ1lGQIdx35YwlnkZ5TNUz9XeB+j9JbSV06Nll5SFIroZe6ctaQ2mK41+6zTv3+R
 Bj5ClCXUuwFH1d8FWdD0eQr+68rn7FxRVKDvLzbAmWMZ336T5u51mLgaHaTQKF+aYffB
 qCTDnt1vHPWOKg/uPgXVRDJm7Uqd9eBLgCRgXdE9O3+J6zEKWvPL/fLQZDNUr+/gtXn9
 ZtUZnCQJYTPguEcMz9u3rHzTjsxHhZh0y+bjg3aODTS2eLP/ASwktt91keEkXBajTPga
 kSlw==
X-Gm-Message-State: AOJu0YxX25xcVLSVy7QsGp7jWteGoySUdq0qncp3lnZrpzKTMqrtZyFQ
 nZVq80rt9O86HnuYD9NB/YTvYit6CrJlMcoRyT/hteijS5Ro86dCb6kNTf+/WvGtGDdDOCxVxPs
 l
X-Google-Smtp-Source: AGHT+IEx7j5FrKmnCxKZLSIxxpP7wt/4hA/PTkuomr1GoCsGwLgbywkGvY7tDDnvc5P6YJnaFbcHJQ==
X-Received: by 2002:a05:6a20:2da6:b0:19a:4922:c0d3 with SMTP id
 bf38-20020a056a202da600b0019a4922c0d3mr428875pzb.55.1706230565746; 
 Thu, 25 Jan 2024 16:56:05 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 i10-20020a17090320ca00b001d74c170f2dsm96390plb.90.2024.01.25.16.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 16:56:05 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2] efi_loader: migrate SMBIOS 3.0 entry point structure for
 measurement
Date: Fri, 26 Jan 2024 09:53:42 +0900
Message-Id: <20240126005342.1221684-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Current U-Boot only supports the SMBIOS 3.0 entry point structure.
TCG2 measurement code should migrate to SMBIOS 3.0 entry
point structure.

efi_selftest tcg2 test also needs to be updated, and expected
PCR[1] result is changed since guid for SMBIOS EFI system table
uses different guid SMBIOS3_TABLE_GUID instead of SMBIOS_TABLE_GUID.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
Changes in v2:
- add SMBIOS 3.0 anchor string check

 include/efi_loader.h                 |  1 +
 include/smbios.h                     |  4 +-
 lib/efi_loader/efi_tcg2.c            | 19 ++++--
 lib/efi_selftest/efi_selftest_tcg2.c | 97 +++++++++++++---------------
 lib/smbios-parser.c                  |  9 ++-
 5 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index d5fca2fa5e..5c5af4f7fd 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -340,6 +340,7 @@ extern const efi_guid_t efi_guid_firmware_management_protocol;
 extern const efi_guid_t efi_esrt_guid;
 /* GUID of the SMBIOS table */
 extern const efi_guid_t smbios_guid;
+extern const efi_guid_t smbios3_guid;
 /*GUID of console */
 extern const efi_guid_t efi_guid_text_input_protocol;
 extern const efi_guid_t efi_guid_text_output_protocol;
diff --git a/include/smbios.h b/include/smbios.h
index b507b9d9d7..e45303d0d3 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -326,10 +326,10 @@ int smbios_update_version_full(void *smbios_tab, const char *version);
  * This function clear the device dependent parameters such as
  * serial number for the measurement.
  *
- * @entry: pointer to a struct smbios_entry
+ * @entry: pointer to a struct smbios3_entry
  * @header: pointer to a struct smbios_header
  */
-void smbios_prepare_measurement(const struct smbios_entry *entry,
+void smbios_prepare_measurement(const struct smbios3_entry *entry,
 				struct smbios_header *header);
 
 #endif /* _SMBIOS_H_ */
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 8db35d0b3c..85562c50a1 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1075,12 +1075,17 @@ error:
  */
 static efi_status_t
 tcg2_measure_smbios(struct udevice *dev,
-		    const struct smbios_entry *entry)
+		    const struct smbios3_entry *entry)
 {
 	efi_status_t ret;
 	struct smbios_header *smbios_copy;
 	struct smbios_handoff_table_pointers2 *event = NULL;
 	u32 event_size;
+	const char smbios3_anchor[] = "_SM3_";
+
+	/* We only support SMBIOS 3.0 Entry Point structure */
+	if (memcmp(entry->anchor, smbios3_anchor, sizeof(smbios3_anchor) - 1))
+		return EFI_UNSUPPORTED;
 
 	/*
 	 * TCG PC Client PFP Spec says
@@ -1093,7 +1098,7 @@ tcg2_measure_smbios(struct udevice *dev,
 	 */
 	event_size = sizeof(struct smbios_handoff_table_pointers2) +
 		     FIELD_SIZEOF(struct efi_configuration_table, guid) +
-		     entry->struct_table_length;
+		     entry->max_struct_size;
 	event = calloc(1, event_size);
 	if (!event) {
 		ret = EFI_OUT_OF_RESOURCES;
@@ -1104,11 +1109,11 @@ tcg2_measure_smbios(struct udevice *dev,
 	memcpy(event->table_description, SMBIOS_HANDOFF_TABLE_DESC,
 	       sizeof(SMBIOS_HANDOFF_TABLE_DESC));
 	put_unaligned_le64(1, &event->number_of_tables);
-	guidcpy(&event->table_entry[0].guid, &smbios_guid);
+	guidcpy(&event->table_entry[0].guid, &smbios3_guid);
 	smbios_copy = (struct smbios_header *)((uintptr_t)&event->table_entry[0].table);
 	memcpy(&event->table_entry[0].table,
 	       (void *)((uintptr_t)entry->struct_table_address),
-	       entry->struct_table_length);
+	       entry->max_struct_size);
 
 	smbios_prepare_measurement(entry, smbios_copy);
 
@@ -1133,7 +1138,7 @@ static void *find_smbios_table(void)
 	u32 i;
 
 	for (i = 0; i < systab.nr_tables; i++) {
-		if (!guidcmp(&smbios_guid, &systab.tables[i].guid))
+		if (!guidcmp(&smbios3_guid, &systab.tables[i].guid))
 			return systab.tables[i].table;
 	}
 
@@ -1360,7 +1365,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
 	u32 pcr_index;
 	struct udevice *dev;
 	u32 event = 0;
-	struct smbios_entry *entry;
+	struct smbios3_entry *entry;
 
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
@@ -1382,7 +1387,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	entry = (struct smbios_entry *)find_smbios_table();
+	entry = (struct smbios3_entry *)find_smbios_table();
 	if (entry) {
 		ret = tcg2_measure_smbios(dev, entry);
 		if (ret != EFI_SUCCESS)
diff --git a/lib/efi_selftest/efi_selftest_tcg2.c b/lib/efi_selftest/efi_selftest_tcg2.c
index 67a886efaa..fb8b997653 100644
--- a/lib/efi_selftest/efi_selftest_tcg2.c
+++ b/lib/efi_selftest/efi_selftest_tcg2.c
@@ -126,41 +126,40 @@ static u8 boot_order[] = {0x02, 0x10, 0x00, 0x10, 0x01, 0x10};
 
 static void *orig_smbios_table;
 static u64 dmi_addr = U32_MAX;
-#define SMBIOS_ENTRY_HEADER_SIZE 0x20
+#define SMBIOS3_ENTRY_HEADER_SIZE 0x18
 /* smbios table for the measurement test */
-static u8 smbios_table_test[] = {
-0x5f, 0x53, 0x4d, 0x5f, 0x2c, 0x1f, 0x03, 0x00, 0x54, 0x00, 0x00, 0x00,
-0x00, 0x00, 0x00, 0x00, 0x5f, 0x44, 0x4d, 0x49, 0x5f, 0xe4, 0x5c, 0x01,
-0x20, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00,
-0x01, 0x02, 0x00, 0x00, 0x03, 0x00, 0x80, 0x08, 0x01, 0x00, 0x00, 0x00,
-0x00, 0x00, 0x00, 0x0c, 0x15, 0x0a, 0xff, 0xff, 0x55, 0x2d, 0x42, 0x6f,
-0x6f, 0x74, 0x00, 0x32, 0x30, 0x32, 0x31, 0x2e, 0x31, 0x30, 0x2d, 0x72,
-0x63, 0x34, 0x2d, 0x30, 0x30, 0x30, 0x30, 0x35, 0x2d, 0x67, 0x37, 0x32,
-0x37, 0x63, 0x33, 0x66, 0x33, 0x32, 0x35, 0x39, 0x2d, 0x64, 0x69, 0x72,
-0x74, 0x79, 0x00, 0x31, 0x30, 0x2f, 0x30, 0x31, 0x2f, 0x32, 0x30, 0x32,
-0x31, 0x00, 0x00, 0x01, 0x1b, 0x01, 0x00, 0x01, 0x02, 0x00, 0x03, 0x31,
-0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00,
-0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
-0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x20, 0x50, 0x72,
-0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,
-0x37, 0x38, 0x00, 0x00, 0x02, 0x0e, 0x02, 0x00, 0x01, 0x02, 0x00, 0x04,
-0x03, 0x01, 0x01, 0x01, 0x00, 0x0a, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
-0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x20, 0x50, 0x72,
-0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
-0x33, 0x33, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00,
-0x00, 0x03, 0x15, 0x03, 0x00, 0x01, 0x03, 0x00, 0x02, 0x03, 0x03, 0x03,
-0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x6e,
-0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,
-0x37, 0x38, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x00,
-0x00, 0x04, 0x30, 0x04, 0x00, 0x00, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00,
-0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00,
-0x00, 0x01, 0x06, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x02, 0x03, 0x04,
-0x04, 0x04, 0x08, 0x00, 0x00, 0x02, 0x00, 0x08, 0x00, 0x08, 0x00, 0x01,
-0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x31, 0x32, 0x33,
-0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
-0x33, 0x33, 0x00, 0x35, 0x35, 0x35, 0x35, 0x35, 0x35, 0x35, 0x35, 0x00,
-0x00, 0x20, 0x0b, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-0x00, 0x00, 0x7f, 0x04, 0x06, 0x00, 0x00, 0x00
+static u8 smbios3_table_test[] = {
+0x5f, 0x53, 0x4d, 0x33, 0x5f, 0x00, 0x18, 0x03, 0x07, 0x00, 0x01, 0x00,
+0x5c, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+0x00, 0x18, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x03, 0x00, 0x80, 0x08,
+0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x15, 0x0a, 0xff, 0xff,
+0x55, 0x2d, 0x42, 0x6f, 0x6f, 0x74, 0x00, 0x32, 0x30, 0x32, 0x31, 0x2e,
+0x31, 0x30, 0x2d, 0x72, 0x63, 0x34, 0x2d, 0x30, 0x30, 0x30, 0x30, 0x35,
+0x2d, 0x67, 0x37, 0x32, 0x37, 0x63, 0x33, 0x66, 0x33, 0x32, 0x35, 0x39,
+0x2d, 0x64, 0x69, 0x72, 0x74, 0x79, 0x00, 0x31, 0x30, 0x2f, 0x30, 0x31,
+0x2f, 0x32, 0x30, 0x32, 0x31, 0x00, 0x00, 0x01, 0x1b, 0x01, 0x00, 0x01,
+0x02, 0x00, 0x03, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00,
+0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x55, 0x6e,
+0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
+0x6e, 0x20, 0x50, 0x72, 0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x31, 0x32,
+0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x00, 0x02, 0x0e, 0x02, 0x00,
+0x01, 0x02, 0x00, 0x04, 0x03, 0x01, 0x01, 0x01, 0x00, 0x0a, 0x55, 0x6e,
+0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
+0x6e, 0x20, 0x50, 0x72, 0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x33, 0x33,
+0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35,
+0x36, 0x37, 0x38, 0x00, 0x00, 0x03, 0x15, 0x03, 0x00, 0x01, 0x03, 0x00,
+0x02, 0x03, 0x03, 0x03, 0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+0x00, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x31, 0x32,
+0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33,
+0x33, 0x33, 0x33, 0x00, 0x00, 0x04, 0x30, 0x04, 0x00, 0x00, 0x03, 0x02,
+0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0c, 0x00,
+0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x06, 0xff, 0xff, 0xff, 0xff, 0xff,
+0xff, 0x02, 0x03, 0x04, 0x04, 0x04, 0x08, 0x00, 0x00, 0x02, 0x00, 0x08,
+0x00, 0x08, 0x00, 0x01, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e,
+0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x33, 0x33,
+0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x00, 0x35, 0x35, 0x35, 0x35, 0x35,
+0x35, 0x35, 0x35, 0x00, 0x00, 0x20, 0x0b, 0x05, 0x00, 0x00, 0x00, 0x00,
+0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7f, 0x04, 0x06, 0x00, 0x00, 0x00
 };
 
 #define IDX_ARRAY_SZ 3 /* support 24 PCRs */
@@ -179,10 +178,10 @@ static u8 expected_pcrs[EFI_TCG2_MAX_PCR_INDEX + 1][TPM2_SHA256_DIGEST_SIZE] = {
 	 0x7b, 0xb9, 0xfe, 0xa1, 0xcd, 0x64, 0x49, 0xdd,
 	 0xed, 0xe2, 0x65, 0x82, 0xc5, 0x3e, 0xf4, 0xc4},
 
-	{0xf5, 0x79, 0xf3, 0x20, 0x62, 0x6e, 0x8b, 0x58,
-	 0x62, 0xa3, 0x4e, 0x2f, 0xb7, 0x10, 0xac, 0x34,
-	 0x4e, 0x68, 0x94, 0x37, 0x87, 0x29, 0xc4, 0xbe,
-	 0xa3, 0xc4, 0xd9, 0x14, 0x2b, 0x66, 0x79, 0x9b},
+	{0x75, 0xb5, 0x91, 0x54, 0x12, 0xa8, 0xa4, 0x25,
+	 0x73, 0x79, 0xa7, 0x47, 0xd9, 0x32, 0x54, 0x78,
+	 0x9a, 0x80, 0x3f, 0xa8, 0x34, 0xfe, 0xd2, 0xae,
+	 0x76, 0xd3, 0x16, 0x4a, 0xb2, 0x03, 0xac, 0xe6},
 
 	{0x3d, 0x45, 0x8c, 0xfe, 0x55, 0xcc, 0x03, 0xea,
 	 0x1f, 0x44, 0x3f, 0x15, 0x62, 0xbe, 0xec, 0x8d,
@@ -543,7 +542,7 @@ static void *find_smbios_table(const struct efi_system_table *systable)
 	u32 i;
 
 	for (i = 0; i < systable->nr_tables; i++) {
-		if (!guidcmp(&smbios_guid, &systable->tables[i].guid))
+		if (!guidcmp(&smbios3_guid, &systable->tables[i].guid))
 			return systable->tables[i].table;
 	}
 
@@ -558,14 +557,12 @@ static void *find_smbios_table(const struct efi_system_table *systable)
  */
 static efi_status_t setup_smbios_table(const struct efi_system_table *systable)
 {
-	struct smbios_entry *se;
+	struct smbios3_entry *se;
 	efi_status_t ret;
 	/* Map within the low 32 bits, to allow for 32bit SMBIOS tables */
 	void *dmi;
-	char *istart;
-	int isize;
 
-	if (sizeof(smbios_table_test) > EFI_PAGE_SIZE)
+	if (sizeof(smbios3_table_test) > EFI_PAGE_SIZE)
 		return EFI_OUT_OF_RESOURCES;
 
 	orig_smbios_table = find_smbios_table(systable);
@@ -586,19 +583,15 @@ static efi_status_t setup_smbios_table(const struct efi_system_table *systable)
 
 	dmi = (void *)(uintptr_t)dmi_addr;
 	se = dmi;
-	boottime->copy_mem(se, smbios_table_test, sizeof(smbios_table_test));
+	boottime->copy_mem(se, smbios3_table_test, sizeof(smbios3_table_test));
 
 	/* update smbios table start address */
-	se->struct_table_address = (uintptr_t)((u8 *)dmi + SMBIOS_ENTRY_HEADER_SIZE);
+	se->struct_table_address = (uintptr_t)((u8 *)dmi + SMBIOS3_ENTRY_HEADER_SIZE);
 
-	/* calculate checksums */
-	istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
-	isize = sizeof(struct smbios_entry) - SMBIOS_INTERMEDIATE_OFFSET;
-	se->intermediate_checksum = table_compute_checksum(istart, isize);
-	se->checksum = table_compute_checksum(se, sizeof(struct smbios_entry));
+	se->checksum = table_compute_checksum(se, sizeof(struct smbios3_entry));
 
 	/* Install SMBIOS information as configuration table */
-	ret = boottime->install_configuration_table(&smbios_guid, dmi);
+	ret = boottime->install_configuration_table(&smbios3_guid, dmi);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("Cannot install SMBIOS table\n");
 		boottime->free_pages(dmi_addr, 1);
@@ -992,7 +985,7 @@ static int efi_st_tcg2_teardown(void)
 	 * If orig_smbios_table is NULL, calling install_configuration_table()
 	 * removes dummy SMBIOS table form systab.
 	 */
-	r = boottime->install_configuration_table(&smbios_guid, orig_smbios_table);
+	r = boottime->install_configuration_table(&smbios3_guid, orig_smbios_table);
 	if (r != EFI_SUCCESS) {
 		efi_st_error("Failed to restore SMBOIS table\n");
 		return EFI_ST_FAILURE;
diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index ac9a367a87..f48d743657 100644
--- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -223,21 +223,24 @@ static void clear_smbios_table(struct smbios_header *header,
 	}
 }
 
-void smbios_prepare_measurement(const struct smbios_entry *entry,
+void smbios_prepare_measurement(const struct smbios3_entry *entry,
 				struct smbios_header *smbios_copy)
 {
 	u32 i, j;
+	void *table_end;
 	struct smbios_header *header;
 
+	table_end = (void *)((u8 *)smbios_copy + entry->max_struct_size);
+
 	for (i = 0; i < ARRAY_SIZE(smbios_filter_tables); i++) {
 		header = smbios_copy;
-		for (j = 0; j < entry->struct_count; j++) {
+		for (j = 0; (void *)header < table_end; j++) {
 			if (header->type == smbios_filter_tables[i].type)
 				break;
 
 			header = get_next_header(header);
 		}
-		if (j >= entry->struct_count)
+		if ((void *)header >= table_end)
 			continue;
 
 		clear_smbios_table(header,
-- 
2.34.1

