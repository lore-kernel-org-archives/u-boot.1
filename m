Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5300C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9562F8785E;
	Sun, 31 Dec 2023 16:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DGFkNW0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C34387859; Sun, 31 Dec 2023 16:26:22 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE7C878A2
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7b7fe0ae57bso487685939f.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036378; x=1704641178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cbrZN1vBHwoxejoX+BLESeQhvB2QXZ2aRb5OPwLgmg=;
 b=DGFkNW0T/wcVTjCqxTvAl7ajPFR4GmFucFVd8a7cHzQ/HJWdLdavbM6JZk6t906/+J
 od95BiNYiGA1SEPCAN0rk6cO5NRZ4SByJAMr5QjwU9UT/+W1cbGLRhP+CLQNDixRLOYq
 4IfhAfR0eoEFJbqxJkM5pyTwgmEKqxanzjhHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036378; x=1704641178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cbrZN1vBHwoxejoX+BLESeQhvB2QXZ2aRb5OPwLgmg=;
 b=RrkCU/E1BiBIRaP2onkAWoPmrhKdSGTJy7y3Qr+JwwJ1Bb8tzmrjmMRjHYaLXWD/wk
 E7RFvM38P8ced6z8HC8/L1wYhqJjp/AUmhf7H4pJzPDX6OQQEJJGd1GIfzqirKocAxoN
 Nr9SpnztbzVjb+sF8SqBb5kCQ3SXckdUnheDr2H/edhAfL++NrbsthCi9aEAznbWWK0a
 +gkGpJKUZ3co9vWrQ0CViVWAOzwHoUG8gUV/VxpEfcWjuNuxwr6AdsPHS6GbNQGwfuIn
 2hnm1FlyTgRS4/j1HQms5D3D6+oqsNlFBXNXD2G9MIGTYtSMJN9pmT9zuwgK5cecKxUf
 sDgQ==
X-Gm-Message-State: AOJu0Yw/ld9Q37GngODS2hgznW98civX5IFZeSevmIntgslM369K7Fs4
 Xi+Fusqe1MbZssvAmjwcyV36Ol5DEOvAVwJgv8QdVKjuHYaA
X-Google-Smtp-Source: AGHT+IG6P1T5vLdLE+2Z1ZshmprV4sqKy4FTN7f3ekVjO0GzeSNpRWJH/1S2UQ2DcaF580t/ntpDhg==
X-Received: by 2002:a6b:908:0:b0:7b9:64ab:41a8 with SMTP id
 t8-20020a6b0908000000b007b964ab41a8mr21196795ioi.10.1704036377790; 
 Sun, 31 Dec 2023 07:26:17 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Igor Prusov <ivprusov@salutedevices.com>
Subject: [PATCH v5 11/12] acpi: Write pointers to tables instead of addresses
Date: Sun, 31 Dec 2023 08:25:54 -0700
Message-Id: <20231231152555.464874-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
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

Sandbox uses an API to map between addresses and pointers. This allows
it to have (emulated) memory at zero and avoid arch-specific addressing
details. It also allows memory-mapped peripherals to work.

As an example, on many machines sandbox maps address 100 to pointer
value 10000000.

However this is not correct for ACPI, if sandbox starts another program
(e.g EFI app) and passes it the tables. That app has no knowledge of
sandbox's address mapping. So to make this work we want to store
10000000 as the value in the table.

Add two new 'nomap' functions which clearly make this exeption to how
sandbox works.

This should allow EFI apps to access ACPI tables with sandbox, e.g. for
testing purposes.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v5:
- Add new patch to write pointers to tables instead of addresses

 arch/sandbox/include/asm/io.h | 16 ++++++++++++++++
 arch/x86/lib/acpi_table.c     |  6 +++---
 cmd/acpi.c                    | 12 ++++++------
 include/mapmem.h              | 18 ++++++++++++++++++
 lib/acpi/acpi.c               | 12 ++++++------
 lib/acpi/acpi_table.c         |  4 ++--
 lib/acpi/base.c               |  4 ++--
 test/dm/acpi.c                | 10 +++++-----
 8 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 3c0a102697e..a23bd64994a 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -231,5 +231,21 @@ static inline void unmap_sysmem(const void *vaddr)
 	unmap_physmem(vaddr, MAP_WRBACK);
 }
 
+/**
+ * nomap_sysmem() - pass through an address unchanged
+ *
+ * This is used to indicate an address which should NOT be mapped, e.g. in
+ * SMBIOS tables. Using this function instead of a case shows that the sandbox
+ * conversion has been done
+ */
+static inline void *nomap_sysmem(phys_addr_t paddr, unsigned long len)
+{
+	return (void *)(uintptr_t)paddr;
+}
+
+static inline phys_addr_t nomap_to_sysmem(const void *ptr)
+{
+	return (phys_addr_t)(uintptr_t)ptr;
+}
 
 #endif
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index c5b33dc65de..b366e44e337 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -197,7 +197,7 @@ int acpi_write_tcpa(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 	tcpa->platform_class = 0;
 	tcpa->laml = size;
-	tcpa->lasa = map_to_sysmem(log);
+	tcpa->lasa = nomap_to_sysmem(log);
 
 	/* (Re)calculate length and checksum */
 	current = (u32)tcpa + sizeof(struct acpi_tcpa);
@@ -268,7 +268,7 @@ static int acpi_write_tpm2(struct acpi_ctx *ctx,
 
 	/* Fill the log area size and start address fields. */
 	tpm2->laml = tpm2_log_len;
-	tpm2->lasa = map_to_sysmem(lasa);
+	tpm2->lasa = nomap_to_sysmem(lasa);
 
 	/* Calculate checksum. */
 	header->checksum = table_compute_checksum(tpm2, header->length);
@@ -430,7 +430,7 @@ int acpi_write_gnvs(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 			u32 *gnvs = (u32 *)((u32)ctx->dsdt + i);
 
 			if (*gnvs == ACPI_GNVS_ADDR) {
-				*gnvs = map_to_sysmem(ctx->current);
+				*gnvs = nomap_to_sysmem(ctx->current);
 				log_debug("Fix up global NVS in DSDT to %#08x\n",
 					  *gnvs);
 				break;
diff --git a/cmd/acpi.c b/cmd/acpi.c
index 0c144092420..79e9335b5db 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -45,7 +45,7 @@ static int dump_table_name(const char *sig)
 	if (!hdr)
 		return -ENOENT;
 	printf("%.*s @ %16lx\n", ACPI_NAME_LEN, hdr->signature,
-	       (ulong)map_to_sysmem(hdr));
+	       (ulong)nomap_to_sysmem(hdr));
 	print_buffer(0, hdr, 1, hdr->length, 0);
 
 	return 0;
@@ -54,9 +54,9 @@ static int dump_table_name(const char *sig)
 static void list_fadt(struct acpi_fadt *fadt)
 {
 	if (fadt->dsdt)
-		dump_hdr(map_sysmem(fadt->dsdt, 0));
+		dump_hdr(nomap_sysmem(fadt->dsdt, 0));
 	if (fadt->firmware_ctrl)
-		dump_hdr(map_sysmem(fadt->firmware_ctrl, 0));
+		dump_hdr(nomap_sysmem(fadt->firmware_ctrl, 0));
 }
 
 static void list_rsdt(struct acpi_rsdp *rsdp)
@@ -66,11 +66,11 @@ static void list_rsdt(struct acpi_rsdp *rsdp)
 	struct acpi_xsdt *xsdt;
 
 	if (rsdp->rsdt_address) {
-		rsdt = map_sysmem(rsdp->rsdt_address, 0);
+		rsdt = nomap_sysmem(rsdp->rsdt_address, 0);
 		dump_hdr(&rsdt->header);
 	}
 	if (rsdp->xsdt_address) {
-		xsdt = map_sysmem(rsdp->xsdt_address, 0);
+		xsdt = nomap_sysmem(rsdp->xsdt_address, 0);
 		dump_hdr(&xsdt->header);
 		len = xsdt->header.length - sizeof(xsdt->header);
 		count = len / sizeof(u64);
@@ -91,7 +91,7 @@ static void list_rsdt(struct acpi_rsdp *rsdp)
 			entry = rsdt->entry[i];
 		if (!entry)
 			break;
-		hdr = map_sysmem(entry, 0);
+		hdr = nomap_sysmem(entry, 0);
 		dump_hdr(hdr);
 		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
 			list_fadt((struct acpi_fadt *)hdr);
diff --git a/include/mapmem.h b/include/mapmem.h
index bb68b4c11af..f496c96d16c 100644
--- a/include/mapmem.h
+++ b/include/mapmem.h
@@ -28,6 +28,24 @@ static inline phys_addr_t map_to_sysmem(const void *ptr)
 {
 	return (phys_addr_t)(uintptr_t)ptr;
 }
+
+/**
+ * nomap_sysmem() - pass through an address unchanged
+ *
+ * This is used to indicate an address which should NOT be mapped, e.g. in
+ * SMBIOS tables. Using this function instead of a case shows that the sandbox
+ * conversion has been done
+ */
+static inline void *nomap_sysmem(phys_addr_t paddr, unsigned long len)
+{
+	return (void *)(uintptr_t)paddr;
+}
+
+static inline phys_addr_t nomap_to_sysmem(const void *ptr)
+{
+	return (phys_addr_t)(uintptr_t)ptr;
+}
+
 # endif
 
 #endif /* __MAPMEM_H */
diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
index 939a638bb5b..bcafd771750 100644
--- a/lib/acpi/acpi.c
+++ b/lib/acpi/acpi.c
@@ -22,13 +22,13 @@ struct acpi_table_header *acpi_find_table(const char *sig)
 	if (!rsdp)
 		return NULL;
 	if (rsdp->xsdt_address) {
-		xsdt = map_sysmem(rsdp->xsdt_address, 0);
+		xsdt = nomap_sysmem(rsdp->xsdt_address, 0);
 		len = xsdt->header.length - sizeof(xsdt->header);
 		count = len / sizeof(u64);
 	} else {
 		if (!rsdp->rsdt_address)
 			return NULL;
-		rsdt = map_sysmem(rsdp->rsdt_address, 0);
+		rsdt = nomap_sysmem(rsdp->rsdt_address, 0);
 		len = rsdt->header.length - sizeof(rsdt->header);
 		count = len / sizeof(u32);
 	}
@@ -36,19 +36,19 @@ struct acpi_table_header *acpi_find_table(const char *sig)
 		struct acpi_table_header *hdr;
 
 		if (rsdp->xsdt_address)
-			hdr = map_sysmem(xsdt->entry[i], 0);
+			hdr = nomap_sysmem(xsdt->entry[i], 0);
 		else
-			hdr = map_sysmem(rsdt->entry[i], 0);
+			hdr = nomap_sysmem(rsdt->entry[i], 0);
 		if (!memcmp(hdr->signature, sig, ACPI_NAME_LEN))
 			return hdr;
 		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN)) {
 			struct acpi_fadt *fadt = (struct acpi_fadt *)hdr;
 
 			if (!memcmp(sig, "DSDT", ACPI_NAME_LEN) && fadt->dsdt)
-				return map_sysmem(fadt->dsdt, 0);
+				return nomap_sysmem(fadt->dsdt, 0);
 			if (!memcmp(sig, "FACS", ACPI_NAME_LEN) &&
 			    fadt->firmware_ctrl)
-				return map_sysmem(fadt->firmware_ctrl, 0);
+				return nomap_sysmem(fadt->firmware_ctrl, 0);
 		}
 	}
 
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index e74522e9972..39dd53ec402 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -167,7 +167,7 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
 	}
 
 	/* Add table to the RSDT */
-	rsdt->entry[i] = map_to_sysmem(table);
+	rsdt->entry[i] = nomap_to_sysmem(table);
 
 	/* Fix RSDT length or the kernel will assume invalid entries */
 	rsdt->header.length = sizeof(struct acpi_table_header) +
@@ -185,7 +185,7 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
 	xsdt = ctx->xsdt;
 
 	/* Add table to the XSDT */
-	xsdt->entry[i] = map_to_sysmem(table);
+	xsdt->entry[i] = nomap_to_sysmem(table);
 
 	/* Fix XSDT length */
 	xsdt->header.length = sizeof(struct acpi_table_header) +
diff --git a/lib/acpi/base.c b/lib/acpi/base.c
index 07b53e0c561..8b6af2bc43a 100644
--- a/lib/acpi/base.c
+++ b/lib/acpi/base.c
@@ -24,10 +24,10 @@ void acpi_write_rsdp(struct acpi_rsdp *rsdp, struct acpi_rsdt *rsdt,
 	memcpy(rsdp->oem_id, OEM_ID, 6);
 
 	if (rsdt)
-		rsdp->rsdt_address = map_to_sysmem(rsdt);
+		rsdp->rsdt_address = nomap_to_sysmem(rsdt);
 
 	if (xsdt)
-		rsdp->xsdt_address = map_to_sysmem(xsdt);
+		rsdp->xsdt_address = nomap_to_sysmem(xsdt);
 
 	rsdp->length = sizeof(struct acpi_rsdp);
 	rsdp->revision = ACPI_RSDP_REV_ACPI_2_0;
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 1211e2f0e7f..c53ebcdb1c1 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -291,8 +291,8 @@ static int dm_test_acpi_write_tables(struct unit_test_state *uts)
 
 	/* Check that the pointers were added correctly */
 	for (i = 0; i < 3; i++) {
-		ut_asserteq(map_to_sysmem(dmar + i), ctx.rsdt->entry[i]);
-		ut_asserteq(map_to_sysmem(dmar + i), ctx.xsdt->entry[i]);
+		ut_asserteq(nomap_to_sysmem(dmar + i), ctx.rsdt->entry[i]);
+		ut_asserteq(nomap_to_sysmem(dmar + i), ctx.xsdt->entry[i]);
 	}
 	ut_asserteq(0, ctx.rsdt->entry[3]);
 	ut_asserteq(0, ctx.xsdt->entry[3]);
@@ -371,8 +371,8 @@ static int dm_test_acpi_ctx_and_base_tables(struct unit_test_state *uts)
 	end = PTR_ALIGN((void *)xsdt + sizeof(*xsdt), 64);
 	ut_asserteq_ptr(end, ctx.current);
 
-	ut_asserteq(map_to_sysmem(rsdt), rsdp->rsdt_address);
-	ut_asserteq(map_to_sysmem(xsdt), rsdp->xsdt_address);
+	ut_asserteq(nomap_to_sysmem(rsdt), rsdp->rsdt_address);
+	ut_asserteq(nomap_to_sysmem(xsdt), rsdp->xsdt_address);
 
 	return 0;
 }
@@ -445,7 +445,7 @@ static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
 	/* Now a real table */
 	console_record_reset();
 	run_command("acpi dump dmar", 0);
-	addr = ALIGN(map_to_sysmem(ctx.xsdt) + sizeof(struct acpi_xsdt), 64);
+	addr = ALIGN(nomap_to_sysmem(ctx.xsdt) + sizeof(struct acpi_xsdt), 64);
 	ut_assert_nextline("DMAR @ %16lx", addr);
 	ut_assert_nextlines_are_dump(0x30);
 	ut_assert_console_end();
-- 
2.34.1

