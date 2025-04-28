Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE1CC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B80A829C7;
	Mon, 28 Apr 2025 21:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mgljxSu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5895C80FDA; Mon, 28 Apr 2025 21:24:51 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B7680EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-af9a6b3da82so3378046a12.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868287; x=1746473087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cC9utU8UAjsJ/Xa5DG5ULlgeLK6o/9a66p5cN+bC5U=;
 b=mgljxSu6x+VOJkwiI+qHjJ9Ydu72hxFyhwaMuhPYO+MXLNknJPF9Z+7Iahewyx8Btt
 Rkl+twC1eotvbxbhSwI+fFdeNeHmixcrBowgHBr6XvqEaYFVvVYPI7Qnv5TFl6vtRXC+
 qdTu6a3r103bxWMaV12puMSW1hdtPV9WjDOsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868287; x=1746473087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cC9utU8UAjsJ/Xa5DG5ULlgeLK6o/9a66p5cN+bC5U=;
 b=Io8xTHWFGjZA+u4oX5kTHWF3pr8e6uxQk+nfdMw9RE6zjK8945PsUmcNMubU6s7n8F
 p25lyAgWpGYNDuMpFnJ7LBm8OEnLQqG0S6X3H9ZIqA7N32w8wZzEuFiV55krzAP8HKHU
 //LDBLSHUe7UEbrnDrfVlXOJ/OsM2dfx1UdN1TFmE7kdmO0nwDAK+cWMhMVGkwzL/lX/
 qXQ0quTulsEd65X0uYoMkNYtLrhUmgDD1Mu46u3vc+9DC34J+3y8gLJs5oTCNI6zxdmk
 VH5eyUWQlroijwF80VgNY7FJX7LoCWMQ7tiBj35yXeQ5FWX93qkc++YP7Y/wGxnXQvqo
 ZYRQ==
X-Gm-Message-State: AOJu0Yx71SFcr7NAh73+wemNFjEOO16xp0OUhwwutarPzKQMOj71p/O0
 qiUhcfNXxzLoPHdEsojd6pGLyrULfWJk0AOUdrI0Uq+B9MNai3VFWTyYtinZZsbO/dlvnCUnFR4
 =
X-Gm-Gg: ASbGncv6Kx1yyk+vCOcIIpH04/a61RAY8U4hfYzmDq7CW/wXT9FhrjEtyUepInmXD+g
 CNpc4y5dlR4fOSNdz1gt/Wlf+nT6SkiTRx3qOu3vxWSwL5Q6xm/B/1TmvMY01qdLcvjMsnyXKDv
 DLp7ABTxjAakPrxEdoVuy2pjmp79yKz+jxlrl3m+pfSRI7KYwsoZVwysOdI1AmxMjoVOL7qX+Ye
 M5/uOBjbhjd0J5e1CKtyF3wfN6yjKHxvDUeaBI3aiDunDkh6lwJAlc4jfT5WqAi4rtkRMc1s9Tz
 XWSeKPFrz61Lgw2O3CNjitXodRhEwPM24gN2Jnr7fQmwbozENvLHIr/qswLwaseOc4HhiHAlkY1
 6YyZoobZ4aDqY
X-Google-Smtp-Source: AGHT+IGNTKNLlIpgfhuXUonF8vaC9ujaZPk51dhISfEc/vXca+kh5pKtlTT7exrrXhKXVGEvvIag8w==
X-Received: by 2002:a05:6a21:3284:b0:1f5:64a4:aeac with SMTP id
 adf61e73a8af0-2095cec8c80mr289562637.33.1745868287240; 
 Mon, 28 Apr 2025 12:24:47 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73e2591349esm8414008b3a.8.2025.04.28.12.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:46 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 11/17] coreboot: Parse sku_id/fw_config from coreboot tables
Date: Mon, 28 Apr 2025 12:24:18 -0700
Message-ID: <20250428192427.3877612-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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
index f24099fc0ef9..b11d42be549c 100644
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
index 101e5ff4037b..2e9b98d3ced5 100644
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

