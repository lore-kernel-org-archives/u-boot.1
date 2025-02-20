Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E509DC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42858810F1;
	Thu, 20 Feb 2025 22:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b7p9pHIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC76A806FE; Thu, 20 Feb 2025 21:59:17 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A7C98006D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22113560c57so27363695ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085154; x=1740689954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NDqh/6cYBGwz8c7Cxhlb/r1jq5VWQv6aSCBwzzUfDM=;
 b=b7p9pHIfZtgoC/HEHdCtGHYFd8/cvuxuAP66Rp4KAqyiJunrr5Ul2eIc22yi5nOOA2
 H9MP+JfiiQzcVoQ+2uEtp6iy0Pkxtayduh2sRdW+J419gqLGRfVb9OrBQd69dgsuzxQo
 oXwMyspidT2Vjb7v4YyDwBK7TNDGmPFoICuwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085154; x=1740689954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NDqh/6cYBGwz8c7Cxhlb/r1jq5VWQv6aSCBwzzUfDM=;
 b=GDZgYvofNOr8mero2qfovmr/wXBEa+sJag73dt7a4ujc9J2tvINArt+9K0wL5zv3ai
 bYNkCcTING4whcOTau+8ua1jJRsQPD+t9EEqkSfuIXlaXiTZSfoigNYt4nYJhIISHQOb
 D5o07yfkGu6TBqFpYkA63ZViE4mSh+LPmFZiiKNX8KLoW+m8EqsJqwPiOytIBcw94zuf
 MxnRm5bCElqSyGFa42n/Fc1kI/6oc7KTg9jcC837GO6D/7ESmMEEYJHauuBJ+aVwwzoo
 qLCziDda/E3l6k6BAzi9dm4p9M9FlsSKzGcNxwk7LVCQOsTTGEdP63zpfPcHgE3FTxya
 /kww==
X-Gm-Message-State: AOJu0YwifUic2p/uDZVBlC6A5zV05lXJCcy78GOC3CJ/aG7fPozMI3L/
 1LLdKFXvkrzZmLMR2EUVODro6ZFFBlkrT92Rm2TuG/6CaUyYc7FTquFcTkhA3jNWMvcy+HUHHmU
 =
X-Gm-Gg: ASbGncsNmDAIqNV7eO9MOtzugiJa+t/w6qIKYRmPiGPhdoi9j+wON8mnPsAhiQlU8iC
 opn8V3SI6y1dMJ0CZqjgU2FuDdA/AsiaaknsfeBnY9W8OYBKzXNsbtlM2VV0ou07xL2ReBSpEjH
 1GyHiZadSAW4ftZNAdnY+0k3gaySVJSLNtFwS/NBo5GdMpRlONzFHSrje1GyxWZdio9RQYB4w1g
 WTXuO2Ykrkw4Jccp+rH6Edqbzk/nWnxBcJ1RaQn7Dw9OvQ2NjIZkPwR94vT8fGvj5P5J8qK+pri
 83thwf8lIGxLiMeh3rQ+51090WmuiOgfJRXJEXj0bObpbFs+J8PPIKw=
X-Google-Smtp-Source: AGHT+IGxfCdoo2ExW5NKWWopQ87pyimu+8NqTcjiIgqbP3Zkfe7bYfRFnRbKdTvlueo1/CQHfUMoRA==
X-Received: by 2002:a17:902:e54e:b0:220:f1db:d96b with SMTP id
 d9443c01a7336-221a1148be7mr2818055ad.41.1740085153729; 
 Thu, 20 Feb 2025 12:59:13 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-220ea7a9348sm110337405ad.211.2025.02.20.12.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:13 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 08/12] coreboot: Parse sku_id/fw_config from coreboot tables
Date: Thu, 20 Feb 2025 12:58:50 -0800
Message-ID: <20250220205900.3127680-9-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

The SKU ID is part of the coreboot tables. Historically, it was under
the coreboot tag for sku_id specifically, but modern coreboot versions
have put all the ID values together in one entry CB_TAG_BOARD_CONFIG
along with fw_config. Parse that tag to populate the sku_id and
fw_config fields.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/cbsysinfo.c           |  2 ++
 include/cb_sysinfo.h      |  4 ++++
 include/coreboot_tables.h | 11 +++++++++++
 lib/coreboot/cb_sysinfo.c | 15 +++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/cmd/cbsysinfo.c b/cmd/cbsysinfo.c
index ed7b50f6d0fc..d6ab71a3db8d 100644
--- a/cmd/cbsysinfo.c
+++ b/cmd/cbsysinfo.c
@@ -418,6 +418,8 @@ static void show_table(struct sysinfo_t *info, bool verbose)
 	print_ptr("MRC cache", info->mrc_cache);
 	print_ptr("ACPI GNVS", info->acpi_gnvs);
 	print_hex("Board ID", info->board_id);
+	print_hex("SKU ID", info->sku_id);
+	print_addr64("FWCONFIG", info->fw_config);
 	print_hex("RAM code", info->ram_code);
 	print_ptr("WiFi calib", info->wifi_calibration);
 	print_addr64("Ramoops buff", info->ramoops_buffer);
diff --git a/include/cb_sysinfo.h b/include/cb_sysinfo.h
index 69b02db4f281..6561f99fe26d 100644
--- a/include/cb_sysinfo.h
+++ b/include/cb_sysinfo.h
@@ -114,6 +114,8 @@
  * acpi_gnvs: @Pointer to Intel Global NVS struct, see struct acpi_global_nvs
  * @board_id: Board ID indicating the board variant, typically 0xffffffff
  * @ram_code: RAM code indicating the SDRAM type, typically 0xffffffff
+ * @sku_id: SKU ID indicating the board SKU, typically 0xffffffff
+ * @fw_config: FW config indicating the firmware configuration, typically 0xffffffff
  * @wifi_calibration: WiFi calibration info, NULL if none
  * @ramoops_buffer: Address of kernel Ramoops buffer
  * @ramoops_buffer_size: Sizeof of Ramoops buffer, typically 1MB
@@ -204,6 +206,8 @@ struct sysinfo_t {
 	void		*acpi_gnvs;
 	u32		board_id;
 	u32		ram_code;
+	u32		sku_id;
+	u64		fw_config;
 	void		*wifi_calibration;
 	u64	ramoops_buffer;
 	u32	ramoops_buffer_size;
diff --git a/include/coreboot_tables.h b/include/coreboot_tables.h
index 54aeffb9889d..6e7686e360c5 100644
--- a/include/coreboot_tables.h
+++ b/include/coreboot_tables.h
@@ -438,6 +438,17 @@ struct cb_tsc_info {
 #define CB_TAG_SERIALNO			0x002a
 #define CB_MAX_SERIALNO_LENGTH		32
 
+#define CB_TAG_BOARD_CONFIG		0x0040
+struct cb_board_config {
+	u32 tag;
+	u32 size;
+
+	u64 fw_config;
+	u32 board_id;
+	u32 ram_code;
+	u32 sku_id;
+};
+
 #define CB_TAG_ACPI_RSDP		0x0043
 
 #define CB_TAG_CMOS_OPTION_TABLE	0x00c8
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index 6cbd08ad3982..c0c6a96debec 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -148,6 +148,16 @@ static void cb_parse_acpi_gnvs(unsigned char *ptr, struct sysinfo_t *info)
 	info->acpi_gnvs = map_sysmem(cbmem->cbmem_tab, 0);
 }
 
+static void cb_parse_board_config(unsigned char *ptr, struct sysinfo_t *info)
+{
+	struct cb_board_config *const cbbcfg = (struct cb_board_config *)ptr;
+
+	info->board_id = cbbcfg->board_id;
+	info->ram_code = cbbcfg->ram_code;
+	info->sku_id = cbbcfg->sku_id;
+	info->fw_config = cbbcfg->fw_config;
+}
+
 static void cb_parse_board_id(unsigned char *ptr, struct sysinfo_t *info)
 {
 	struct cb_board_id *const cbbid = (struct cb_board_id *)ptr;
@@ -302,6 +312,8 @@ static int cb_parse_header(void *addr, int len, struct sysinfo_t *info)
 	 */
 	info->board_id = ~0;
 	info->ram_code = ~0;
+	info->sku_id = ~0;
+	info->fw_config = ~0ULL;
 
 	/* Now, walk the tables */
 	ptr += header->header_bytes;
@@ -402,6 +414,9 @@ static int cb_parse_header(void *addr, int len, struct sysinfo_t *info)
 		case CB_TAG_CBMEM_ENTRY:
 			cb_parse_cbmem_entry(ptr, info);
 			break;
+		case CB_TAG_BOARD_CONFIG:
+			cb_parse_board_config(ptr, info);
+			break;
 		case CB_TAG_BOARD_ID:
 			cb_parse_board_id(ptr, info);
 			break;
-- 
Sent by a computer, using git, on the internet

