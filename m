Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6208C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5258F835A2;
	Sat, 24 May 2025 01:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F6q8+yHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1038338C; Sat, 24 May 2025 00:59:13 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DC283340
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so286815a12.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041149; x=1748645949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cC9utU8UAjsJ/Xa5DG5ULlgeLK6o/9a66p5cN+bC5U=;
 b=F6q8+yHa9s+1f28Pyv9ea/vpxfXoz2LFubOK1ePdDFeatZZgsWadkEG6TlnTEkcjiu
 T4qarxR0xtkaQ3Uf8drCb1VnA+qJW7D3Ahqi3dAaWezaxvEGBs5a4D0wq+FA6apudwHt
 pZVCzmItyEJG9HfTZQSRg61CDNNgFcfe/iX7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041149; x=1748645949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cC9utU8UAjsJ/Xa5DG5ULlgeLK6o/9a66p5cN+bC5U=;
 b=dq6xdgb92EjagSOoktCY8nnStDxHQ0wXSal6HNnr04TyPDOHaBWcIUIGj5BXBZBWj/
 oaHmgeFYYLCTycEM7a82t+xMz4z/7HPGcyNZSUzER48hmGJr3MiQoiJFyTjvnwel5M+5
 CUkeveHdQu1mQsoIpUBVm2Dj0zNu1ln4gkbteor6KjDmKQqYkDFQMyu6En/0kGcztbes
 teHGe/8x8+HVN9ig0o37vvgQoJbwML94YlEshxfybJWLTdhGCsj6tfEthgtCSvAWFuiB
 hqmcWpaUQYMFwQafROpe0DjKDfWp/A8LjS73wl7GUr7rRbzGVcpRlyCX4whrUHIdm82W
 XfUw==
X-Gm-Message-State: AOJu0YxyNkGDqVVQgGbAb+wHhka3WGviFvIRzzHISIAu6/NCvQ9AGvXm
 Gr9MJ2+HBJ/C+7T5u8hOUrbl9AnxpyUPh+GiwhQsrm5vkKKypO68QrGNPpOrJeJJh3BfK+H2YRQ
 Z+0o=
X-Gm-Gg: ASbGncucqAS8vSefBCTzHvsKcxaO2w4vwG1RqdUx+7K+RRdEmnyj8ETYcjMyVYgnNYm
 YwUh55zLFgJ9aQGDXP5tbizmJNy1sYzXfYp+c9d1mtTL/K2SP36jshrk1m+yc/PnlaC+ZKzgdnx
 3AD2zuWlM1fdaicNk/WGmQZjfVK1YQ+ghqJ467MC4w8KOC8mwjZtz0w7qAHxogCj6k07uLa9xcQ
 1Ns0Pz89OSwPj6ryt+Ehj1sCZp9/HtXi2oNTS3QqpmlyjX288snlPL7MUBjIm96GugOjJa7RGUA
 KYr1DJ6nlNf9Ns4uIQMEKz1VZw8GUSwbDQsGsajR4Re+lQXfXX2AWuVDuSbEvz3peIysEt9Z1CF
 lyzs3uvs3vN7bzdc=
X-Google-Smtp-Source: AGHT+IEfA0e9Q0JarnKA0hOcPaoPHnjqblMedq0HJFNilk/h0h5m7GG9lSfntjZHwsq654A5uUKNWQ==
X-Received: by 2002:a05:6a20:d04f:b0:216:1476:f6c with SMTP id
 adf61e73a8af0-2188c2672d2mr1539451637.13.1748041149041; 
 Fri, 23 May 2025 15:59:09 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b26eaf8e13csm13285020a12.45.2025.05.23.15.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:08 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 14/28] coreboot: Parse sku_id/fw_config from coreboot tables
Date: Fri, 23 May 2025 15:58:29 -0700
Message-ID: <20250523225845.2311989-15-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

