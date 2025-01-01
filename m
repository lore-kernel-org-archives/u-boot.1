Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119E5E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A508058A;
	Wed,  1 Jan 2025 23:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l5tulmX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0459480654; Wed,  1 Jan 2025 23:22:58 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBFD980379
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso11974873a91.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770172; x=1736374972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saCjsS2iKPo11X0NcFJcJeUXIT/ZhCwPkCDsrwRa5Fo=;
 b=l5tulmX1z9Q/5+Mtz/wIrpMK0kUQtoWUsE8qJ9jedv8i8NVfgmLW0B/gqWlGm5EL25
 bhzkN6PSHIog1/0C1xKQiOLGPB/qQFrsVWA7ZeA8lEgHb8KRTHhbg7NpdsO9AI611MyG
 JymAGsgYeoYEmOmyVaomeGkdcsL1kTvtEv04c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770172; x=1736374972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saCjsS2iKPo11X0NcFJcJeUXIT/ZhCwPkCDsrwRa5Fo=;
 b=KB4gFpnFgLn59CYhTN3rSyZYl4Bhq5VYDzYptlrMCDA51UHJnZk4ZBDgW5oSdOdEQA
 Emh7YwaIUC+LPxFNIGw7cC+6fKH1D3YGvvNvrSopSeZIlySJUoLi1zeyvesSrjpyXutq
 JmF+t+cqOgg+1fV69IvzClWNajOOYdDyq74c4nz2oNTrQH5P7CAIZh4ETE9Po4hFwH8f
 Drao8hvLR5hivCwCyYnOGXroUE1aw44SmAX7DPnFtAXnkNssfAe4hKqo2UJVe6p4Z1im
 HqT2sXMOKd8YeT3dooM2cM3BgdbZHqqqOPuX4xKIC/BHaWCFchBWwAb0HW7xdaag0Rd2
 Twyw==
X-Gm-Message-State: AOJu0YwsbqFgKpsMIuCxvq354plJnr94OoNsdR1TPUN34F/PjbhfCoCN
 XWwDUP8zzobo6zrjKuIllNCDTzq4R7aizkGCyK2mw4MjcoF6IW+1rNxzCkYGLoGKzmomRi31sCw
 =
X-Gm-Gg: ASbGnctN4vBpZgL6yKRQpHtx2ySNt3XutammeJcPRZSn5sq74WOgkyPOJXxljg1lpId
 N+LpPHNyHjBvWBVeZYIoYkWWRkKL9Sly47L3hp9tAG4KEVt4p0CG45xnnPoOoBrgZGNXpoILBh3
 e/+OQa2HE4/1+eIB/ZYneVcGc3NfGsUuJsvvTz5DgAuLR2ONojCSOM+zNavbuJPq4ZPHuTxvkg6
 ETcAOhXNkB+OVSHgBvxEFXu90w/S70SMnHAzf/UCSMtJuAk653dL4k=
X-Google-Smtp-Source: AGHT+IEozTpd9OZnIVFajC1uCASJUdruy0FWvczqGYjrYYfuWmMm/CB7NefPNhN+Eln9IS7odBfIPQ==
X-Received: by 2002:a05:6a00:2449:b0:728:e906:e45a with SMTP id
 d2e1a72fcca58-72abdecdbfdmr64734535b3a.24.1735770171825; 
 Wed, 01 Jan 2025 14:22:51 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 54/67] upl: Use a reg property to specify the FIT address and
 size
Date: Thu,  2 Jan 2025 11:09:40 +1300
Message-ID: <20250101221003.1944600-55-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

The spec has changed to use a unit address and reg property for this
value. Update the implementation to match. It is now possible to obtain
the size of the FIT as well as its address.

Add #address/size-cells properties as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_read.c      | 12 +++++++++---
 boot/upl_write.c     | 25 +++++++++++++++++++++----
 cmd/upl.c            |  2 +-
 common/spl/spl_upl.c |  4 ++--
 include/upl.h        |  4 ++--
 test/boot/upl.c      | 10 ++++++----
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/boot/upl_read.c b/boot/upl_read.c
index 1b6290ffb1c..8fcc5a77c15 100644
--- a/boot/upl_read.c
+++ b/boot/upl_read.c
@@ -310,6 +310,8 @@ static int decode_upl_params(struct upl *upl, ofnode options)
 static int decode_upl_images(struct upl *upl, ofnode options)
 {
 	ofnode node, images;
+	const char *buf;
+	int size;
 	int ret;
 
 	images = ofnode_find_subnode(options, UPLN_UPL_IMAGES);
@@ -317,9 +319,13 @@ static int decode_upl_images(struct upl *upl, ofnode options)
 		return log_msg_ret("img", -EINVAL);
 	log_debug("decoding '%s'\n", ofnode_get_name(images));
 
-	ret = read_addr(upl, images, UPLP_FIT, &upl->fit);
-	if (!ret)
-		ret = read_uint(images, UPLP_CONF_OFFSET, &upl->conf_offset);
+	buf = ofnode_read_prop(images, UPLP_REG, &size);
+	if (buf) {
+		ret = decode_addr_size(upl, buf, size, &upl->fit);
+		if (ret < 0)
+			return log_msg_ret("uft", ret);
+	}
+	ret = read_uint(images, UPLP_CONF_OFFSET, &upl->conf_offset);
 	if (ret)
 		return log_msg_ret("cnf", ret);
 
diff --git a/boot/upl_write.c b/boot/upl_write.c
index 9702ef91930..32c68308149 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -244,6 +244,9 @@ static int add_upl_params(const struct upl *upl, ofnode options)
 	ofnode node;
 	int ret;
 
+	ret = add_addr_size_cells(options, upl->addr_cells, upl->size_cells);
+	if (ret)
+		return log_msg_ret("upa", ret);
 	ret = ofnode_add_subnode(options, UPLN_UPL_PARAMS, &node);
 	if (ret)
 		return log_msg_ret("img", ret);
@@ -276,21 +279,35 @@ static int add_upl_params(const struct upl *upl, ofnode options)
  */
 static int add_upl_images(const struct upl *upl, ofnode options)
 {
+	char name[40];
 	ofnode node;
 	int ret, i;
 
-	ret = ofnode_add_subnode(options, UPLN_UPL_IMAGES, &node);
+	snprintf(name, sizeof(name), UPLN_UPL_IMAGES "@%llx", upl->fit.base);
+	ret = ofnode_add_subnode(options, name, &node);
 	if (ret)
 		return log_msg_ret("img", ret);
 
-	if (upl->fit)
-		ret = ofnode_write_u32(node, UPLP_FIT, upl->fit);
-	if (!ret && upl->conf_offset)
+	if (upl->fit.base) {
+		char buf[4 * sizeof(u64)];
+
+		ret = encode_addr_size(upl, buf, sizeof(buf), &upl->fit);
+		if (ret < 0)
+			return log_msg_ret("uft", ret);
+		ret = ofnode_write_prop(node, UPLP_REG, buf, ret, true);
+		if (ret)
+			return log_msg_ret("ufw", ret);
+	}
+	if (upl->conf_offset)
 		ret = ofnode_write_u32(node, UPLP_CONF_OFFSET,
 				       upl->conf_offset);
 	if (ret)
 		return log_msg_ret("cnf", ret);
 
+	ret = add_addr_size_cells(node, upl->addr_cells, upl->size_cells);
+	if (ret)
+		return log_msg_ret("upi", ret);
+
 	for (i = 0; i < upl->image.count; i++) {
 		const struct upl_image *img = alist_get(&upl->image, i,
 							struct upl_image);
diff --git a/cmd/upl.c b/cmd/upl.c
index d8d46cdf34f..676e8f1f9e2 100644
--- a/cmd/upl.c
+++ b/cmd/upl.c
@@ -31,7 +31,7 @@ static int do_upl_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (argc > 1 && !strcmp("-v", argv[1])) {
 		int i;
 
-		printf("fit %lx\n", upl->fit);
+		printf("fit %llx size %lx\n", upl->fit.base, upl->fit.size);
 		printf("conf_offset %x\n", upl->conf_offset);
 		for (i = 0; i < upl->image.count; i++) {
 			const struct upl_image *img =
diff --git a/common/spl/spl_upl.c b/common/spl/spl_upl.c
index 2bc0e265661..5777148bbe4 100644
--- a/common/spl/spl_upl.c
+++ b/common/spl/spl_upl.c
@@ -21,14 +21,14 @@ void upl_set_fit_addr(ulong fit)
 {
 	struct upl *upl = &s_upl;
 
-	upl->fit = fit;
+	upl->fit.base = fit;
 }
 
 void upl_set_fit_info(ulong fit, int conf_offset, ulong entry_addr)
 {
 	struct upl *upl = &s_upl;
 
-	upl->fit = fit;
+	upl->fit.base = fit;
 	upl->conf_offset = conf_offset;
 	log_debug("upl: add fit %lx conf %x\n", fit, conf_offset);
 }
diff --git a/include/upl.h b/include/upl.h
index dd43e8e8529..cff3401a932 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -250,7 +250,7 @@ struct upl_graphics {
  * @addr_cells: Number of address cells used in the handoff
  * @size_cells: Number of size cells used in the handoff
  * @bootmode: Boot-mode mask (enum upl_boot_mode)
- * @fit: Address of FIT image that was loaded
+ * @fit: Address and size of FIT image that was loaded
  * @conf_offset: Offset in FIT of the configuration that was selected
  * @addr_width: Adress-bus width of machine, e.g. 46 for 46 bits
  * @acpi_nvs_size: Size of the ACPI non-volatile-storage area in bytes
@@ -266,7 +266,7 @@ struct upl {
 	ulong smbios;
 	ulong acpi;
 	uint bootmode;
-	ulong fit;
+	struct memregion fit;
 	uint conf_offset;
 	uint addr_width;
 	uint acpi_nvs_size;
diff --git a/test/boot/upl.c b/test/boot/upl.c
index e1454ba3469..8e1a016943a 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -46,7 +46,8 @@ int upl_get_test_data(struct unit_test_state *uts, struct upl *upl)
 	upl->smbios = 0x123;
 	upl->acpi = 0x456;
 	upl->bootmode = BIT(UPLBM_DEFAULT) | BIT(UPLBM_S3);
-	upl->fit = 0x789;
+	upl->fit.base = 0x789;
+	upl->fit.size = 0xabc;
 	upl->conf_offset = 0x234;
 	upl->addr_width = 46;
 	upl->acpi_nvs_size = 0x100;
@@ -294,7 +295,8 @@ static int compare_upl(struct unit_test_state *uts, struct upl *base,
 	ut_asserteq(base->smbios, cmp->smbios);
 	ut_asserteq(base->acpi, cmp->acpi);
 	ut_asserteq(base->bootmode, cmp->bootmode);
-	ut_asserteq(base->fit, cmp->fit);
+	ut_asserteq(base->fit.base, cmp->fit.base);
+	ut_asserteq(base->fit.size, cmp->fit.size);
 	ut_asserteq(base->conf_offset, cmp->conf_offset);
 	ut_asserteq(base->addr_width, cmp->addr_width);
 	ut_asserteq(base->acpi_nvs_size, cmp->acpi_nvs_size);
@@ -411,14 +413,14 @@ static int upl_test_info_norun(struct unit_test_state *uts)
 
 	ut_assertok(run_command("upl info -v", 0));
 	ut_assert_nextline("UPL state: active");
-	ut_assert_nextline("fit %lx", upl->fit);
+	ut_assert_nextline("fit %llx (size %lx)", upl->fit.base, upl->fit.size);
 	ut_assert_nextline("conf_offset %x", upl->conf_offset);
 	ut_assert_nextlinen("image 0");
 	ut_assert_nextlinen("image 1");
 	ut_assert_console_end();
 
 	/* check the offsets */
-	fit = map_sysmem(upl->fit, 0);
+	fit = map_sysmem(upl->fit.base, 0);
 	ut_asserteq_str("conf-1", fdt_get_name(fit, upl->conf_offset, NULL));
 
 	ut_asserteq(2, upl->image.count);
-- 
2.43.0

