Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DBBC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 10:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD568036F;
	Fri, 17 Jan 2025 11:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y3HFO1GV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A36C68069D; Fri, 17 Jan 2025 11:29:30 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8308980312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 11:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso367112866b.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737109768; x=1737714568; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u0mYx5vOmcH7G6oJAjwkBd+dXsMFMOFPdv0qjJphjBI=;
 b=y3HFO1GV1vJjcf5rMbAItQcv5qXFfxKTE2hdA1x7lK+4U8TYmUWDcHr2AwMvhZCJ0A
 yoVBFvwfCFA+7f/nPpPQUTRCt3iB6Jn95RmAfDoH/CVSuRRF0PdTOzPdAfJger4IT8Q+
 OfyyXyH4Ly2pxrh21Z1yCVotXILDT+VyNMYwD+Fn2yOwDuQcDMNflW1fv9e3WmAmcMJ7
 WxwO4DpNUBzi9LQlARu3fAbjCIgPKc9rUS+0OQSuEO29kDKdzECoxEporqOMQ9cF+sRw
 gGmtr6t9qgxvgB8P+fT6l9Fj+q0NL6AFznL8iLtPBOni4Ds4g6QgdnIb3PZeJ+IDWX7C
 9yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737109768; x=1737714568;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u0mYx5vOmcH7G6oJAjwkBd+dXsMFMOFPdv0qjJphjBI=;
 b=oHAE0/R0H4eZQaa9MjmEUpHxtrY6F4wD7Y5ha+QPUawuz6QQJMvGFWgJ1AHzYrp28t
 bN5+35jzXn/6ySZGubpNcm/ULZCpmTYAAgbHexHyV9Lv73+fLtjgDRBhCHxNHmxK9Yjr
 GbcuSvHgxtm4Dp5Ac1+QnfK3Gcvr6Rbxl8AzLfNPPL5YNARkgsV8GqticsTP3yHobF5h
 J8S9Qlfdsuh+7ibqzDQBbyaYXbqfud5URHLPG+129PI8R/FqP19EY8iXkHBTW0RIZ1yi
 oQT1gc/+fWiVUzaFpJDaQgQQVgGkRFzJ3f8j7Vy7XBK07XP/W83mpzQQyStFtGp8qHbD
 KQWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA5X0Bl8ags8vE+4oalkqyfkkRzQ027uQy21poy6OPPzLniyyrv6BTBHVrbpunfT70FqK5Q1Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw72FXWHYXw9L26PfTmIuVP/XIIxRbEnd/Kow4CCHB3W/ihPl/F
 ZOjxL5pCCdKSd8b3NDSGEh99c4Ii139GNbOuoJUqo1nvspb7XTIlphtVxLqAunk=
X-Gm-Gg: ASbGncvFoAi8DMORXuEi+ofM32atVCibETx+n05Sc2MQY9WtWZ9wHTpPFoK1KZ2IR9z
 49jeccG9mQVc2iYx6QhqhfppMp06F3j9iT0BmWuN1NXism37C5uxGYgC2thGHZFtmsuHlkBQ99v
 /NNQjXVoYKOHjNAbO8lefsir+FTZo6NghXqiU+iPAZ6NFbkBaw7pgaOtiVS9qycn/mtSVXweknQ
 LzP8vfEYO6CWOEMHhRE9A/ZqT2YSXXcaf2F0xSRVlS/ECkNaMSK6aXOgcvtd2WyqCULL4YINED5
 +ecvbPAymNpomWI=
X-Google-Smtp-Source: AGHT+IHDrsVOrm5HS/A9n6Z6pCDWAuMayvnClZdBECzs79cn11WDLVdVbSXYCyOHyTM3F2bW0ctfkw==
X-Received: by 2002:a17:906:7955:b0:ab2:f816:c5e1 with SMTP id
 a640c23a62f3a-ab38b1b4659mr253652766b.1.1737109767858; 
 Fri, 17 Jan 2025 02:29:27 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm146888866b.39.2025.01.17.02.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 02:29:27 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] mach-snapdragon: fix board_fdt_blob_setup()
Date: Fri, 17 Jan 2025 11:27:28 +0100
Message-ID: <20250117102734.3725009-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.0
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

In fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup())
there was a subtle change to the Snapdragon implementation, removing the
assignment to gd->fdt_blob partway through the function.

This breaks qcom_parse_memory() which was also called during
board_fdt_blob_setup().

Since this was a strange (and seemingly unnecessary choice), take the
chance to move this to the more typical dram_init() phase so that we
don't depend on gd->fdt_blob being correct until after
board_fdt_blob_setup() has finished.

Fixes: fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup())
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 67 +++++++++++++++-----------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index f1319df43147..fbb3d6e588e3 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -45,17 +45,8 @@ static struct {
 	phys_addr_t start;
 	phys_size_t size;
 } prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
 
-int dram_init(void)
-{
-	/*
-	 * gd->ram_base / ram_size have been setup already
-	 * in qcom_parse_memory().
-	 */
-	return 0;
-}
-
 static int ddr_bank_cmp(const void *v1, const void *v2)
 {
 	const struct {
 		phys_addr_t start;
@@ -69,42 +60,22 @@ static int ddr_bank_cmp(const void *v1, const void *v2)
 
 	return (res1->start >> 24) - (res2->start >> 24);
 }
 
-/* This has to be done post-relocation since gd->bd isn't preserved */
-static void qcom_configure_bi_dram(void)
-{
-	int i;
-
-	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
-		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
-	}
-}
-
-int dram_init_banksize(void)
-{
-	qcom_configure_bi_dram();
-
-	return 0;
-}
-
 static void qcom_parse_memory(void)
 {
 	ofnode node;
-	const fdt64_t *memory;
+	const fdt64_t *memory = NULL;
 	int memsize;
 	phys_addr_t ram_end = 0;
 	int i, j, banks;
 
 	node = ofnode_path("/memory");
-	if (!ofnode_valid(node)) {
-		log_err("No memory node found in device tree!\n");
-		return;
-	}
-	memory = ofnode_read_prop(node, "reg", &memsize);
-	if (!memory) {
-		log_err("No memory configuration was provided by the previous bootloader!\n");
+	if (ofnode_valid(node))
+		memory = ofnode_read_prop(node, "reg", &memsize);
+
+	if (!memory || !ofnode_valid(node)) {
+		panic("No memory configuration was provided by the previous bootloader!\n");
 		return;
 	}
 
 	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
@@ -134,8 +105,32 @@ static void qcom_parse_memory(void)
 	debug("ram_base = %#011lx, ram_size = %#011llx, ram_end = %#011llx\n",
 	      gd->ram_base, gd->ram_size, ram_end);
 }
 
+int dram_init(void)
+{
+	qcom_parse_memory();
+	return 0;
+}
+
+/* This has to be done post-relocation since gd->bd isn't preserved */
+static void qcom_configure_bi_dram(void)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
+		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
+	}
+}
+
+int dram_init_banksize(void)
+{
+	qcom_configure_bi_dram();
+
+	return 0;
+}
+
 static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
@@ -173,9 +168,9 @@ int board_fdt_blob_setup(void **fdtp)
 		ret = -EEXIST;
 	} else {
 		debug("Using external FDT\n");
 		/* So we can use it before returning */
-		*fdtp = fdt;
+		gd->fdt_blob = *fdtp = fdt;
 	}
 
 	/*
 	 * Parse the /memory node while we're here,
-- 
2.48.0

