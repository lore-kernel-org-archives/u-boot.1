Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BB9C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF25812BB;
	Wed, 26 Feb 2025 23:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ghFRUw+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C61F4810F2; Wed, 26 Feb 2025 23:16:26 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F5F280F88
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22104c4de96so3927845ad.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608182; x=1741212982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsV9y/c2Vqu+N+yjsaJeATvjvFiwcHdTEBWmyaCR2x4=;
 b=ghFRUw+EmuyjtuQVQmmL1uuBP4edzCavp82O7rmKrSa3BEkBKgK1YTkrUielAuoJlY
 9lNb1SuIrMjd0XdWOr6omVKn0t2cbFkMtwORuIuj1GhlwMBstXTz1ZXeK4oXeST/uvUK
 JxNPgEDYLKp06wE23B/12AmJqF2IZlJij4txE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608182; x=1741212982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsV9y/c2Vqu+N+yjsaJeATvjvFiwcHdTEBWmyaCR2x4=;
 b=I4Cr3jO3eQrMzvJJMyMufB0nYBlkAcRq54rPCVnM7yYzp/8cOqt7Phpq/75Jd0fVYT
 eJ2Qk1+ni5oOpaSfwzhfZ3bftUdbD6SpN1xB0pXbVha+T73JtW7mZavvp9R431WOt1Rc
 3ONvgJeEY+ntzDjGv0ROBpEkVvn/SZ8DjlPqJPxlpY0wrWkzf5kjtirFXprUJ5MSmcpW
 Fta56aFQe02U6bB5mGh9FxkRvxef/qClUC13KYdpde43v/MAiyxCFg3bP4sp6SQS8f6d
 Au+xH5jgA39uQT0tgR+Aa657VPlA9ptrlTct2rhm8LRdIuPMjjs7SHGM7OPD5NCIbqJN
 x8Rw==
X-Gm-Message-State: AOJu0YyQ7r2EWICSKBAFG/lRzrQ5vnZWcyTYGvrR0l88UTSwCAGDNvxN
 rc+ZsxG/repir7PZbm5e2QM2qH2Lnd6TDqAEal8ml+CnwN6j2GHFfETWKAGk6NLPZBSPY/MDgdI
 =
X-Gm-Gg: ASbGncsGOmAFtwt4bz217B08ATxtiR4WCCEfavMuJ9u80+CtaSXNH9oPlKGzXA/ZDba
 rv1r1xyNk7lcW+Zd3z6M8hMWPac551VyNqnYhVl6eCj0R61MGSYw3lBd4WYIEuBZ6Mr6JoXKaph
 UHoOxWM3TfCVebH0c7SrEto7AUH4H0xzcMY78dwUrYleTRAwltKIFG5z+qaLf9BLbf26BulfiBy
 jM7ljwBAZvRe4pkwTwUUbwp+xB0KJKA1K4KI7bgi8pQvUmeW9nImLSV8jM8vhB8O0XS8KQMYS58
 Mgd6Jf/+aYkb3C84Ms2Xyc/jGsQx1PRZOSdYVa+ugmFS2/2gR9VQza0H/UlvBDX1vQ==
X-Google-Smtp-Source: AGHT+IE4jV924y7QGR4rOJrp1Snix6lUfOur7pEgigQNC296vAT5x3O5Tb+tD/jt3JYALOl/cdHpLw==
X-Received: by 2002:a17:902:cf01:b0:21f:9c48:254b with SMTP id
 d9443c01a7336-22307b5af85mr152331115ad.24.1740608182601; 
 Wed, 26 Feb 2025 14:16:22 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-223504c5a05sm1208675ad.144.2025.02.26.14.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:22 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 09/15] coreboot: Parse sku_id/fw_config from coreboot tables
Date: Wed, 26 Feb 2025 14:15:55 -0800
Message-ID: <20250226221607.1283592-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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
index 3bd997dcca39..604a276ea72b 100644
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
index 36cd352818a2..67497d4d65b4 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -141,6 +141,16 @@ static void cb_parse_acpi_gnvs(unsigned char *ptr, struct sysinfo_t *info)
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
@@ -295,6 +305,8 @@ static int cb_parse_header(void *addr, int len, struct sysinfo_t *info)
 	 */
 	info->board_id = ~0;
 	info->ram_code = ~0;
+	info->sku_id = ~0;
+	info->fw_config = ~0ULL;
 
 	/* Now, walk the tables */
 	ptr += header->header_bytes;
@@ -395,6 +407,9 @@ static int cb_parse_header(void *addr, int len, struct sysinfo_t *info)
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

