Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976B6C282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 13:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 952F9812C8;
	Fri,  7 Mar 2025 14:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T5LXiJGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD2DA810F5; Fri,  7 Mar 2025 11:35:10 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7969480017
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 11:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e56b229d60so5229536a12.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 02:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741343708; x=1741948508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGBWrVHmKECWXoRG3noF7+yGNrBMzN8ye+pDXZzDUCI=;
 b=T5LXiJGKOt7qpXgcS4LWMOgs5FtylvV3IW/vnUl0GEgSLlNvuUk8plVyPYg08KNfrd
 tedXHxJSrZ+VyDKZ6elWw14qAoxqXTgrLZvjVN8k1bQy6hqja2GsJvW/+pSkvHj9j0Ty
 21kGwEkgWZ6zzH/Jf2mIEKIbu1f0AIFXcFeS59gH0c1WY/F6BrkasZ3VGuxhd4aSu8tJ
 quyIfF01iwENaClxaScUxYjoSJwLP1Iy2v/VBqLcD5gsW7FEjYKUjJp08oxjyp14yKrY
 Wj432Squ53g+NdWlhTr+YmVyROtpQFOlYY/CY1fj55BTMV6TXGQkVz4wQIk07s5cZU53
 HuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741343708; x=1741948508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGBWrVHmKECWXoRG3noF7+yGNrBMzN8ye+pDXZzDUCI=;
 b=vtc2w52sDCZTNQXZYL2LdHANHrfgadW04sWVLmcTUrJV6YTIJzcYOP88xHmLrfkEU+
 TWnBat2CqdYbjTA+YJ6OpRtcIGx8tFlYlq54aq0Ir30i0SLVgPyh52Fs0C9ytD1uPfT8
 h4IovJKZxjMOX6tO+zBHtpK33qbojfJXbotB3Jr73WnzVZdtplHTk28vliJvXsyUfB1L
 PuQemTx8pWwJLD9t7h4M9yk56KQ5gdwAZ5g8dKAU4ZSDK6ageO3nytwM09OrCU3fWGyA
 WfbnfGEhYLde3lc8ijyu3f5b6sU0KiT4uAEhO7NdIWe6C+VXPqfXZkp5EwxtKWFJeUBk
 fLrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv8stcjdrEZiamI/T1dj/TxgAxTnhYtKC0YYnEjI1r+MGbseavpmAWytoUIJor2s+Bk/L+NBY=@lists.denx.de
X-Gm-Message-State: AOJu0YxkTfcrHeyCkmPCgq+M3c0XQUiuIb8mJBgSmMV5x+ORQfo42Pn2
 LHGXNeDRemosK+eYVX5FUVK1sszML4WSbBt5tqA8FHq4uOXhr1cgX+QZ/2Cx
X-Gm-Gg: ASbGnctrpkqfUIvJ2eKcyMYhDDPI3pWAJT+DthEB29TGRpgwrbGvjDHYvOSGbuBmfeh
 Dt28mdZrq/+JRpoa3b1qXgc7vJVBIJImk/s0a3oexsFudcEtr8O5jb4SyLAOZaCCiGiXv4lEw7Y
 uiHeinuVU/VL/mW/DQlcYSDPhk6srlkX2kYSQ9XLrGis+Dt7ZekFOW6A9R4I/0y0JvbUSIHc77h
 JK7TGoIgLc6w0n/HoOOqWMWJlPR2XfBmyAQgNyUCr09FL+RMXikW+6R6jRZj4VH79RaQN78F+1a
 DOyORxgqgBDE6mPFGMokH4OQUBbeU6lrK5+qXp5vXyXwhUuRuYRZiov2HyOzADoaK/9wlzwc2pJ
 Vly7gEotaglUyTrXorbPysWc=
X-Google-Smtp-Source: AGHT+IGZTJ1Pe7hoBzisdk+30ZEbwFFFufs+3AM6PvCunRcgFlANArrgGV/qZDOijrX9LEClkmFLWw==
X-Received: by 2002:a17:907:7d8e:b0:abf:6f25:9881 with SMTP id
 a640c23a62f3a-ac22cd71628mr703229866b.25.1741343707702; 
 Fri, 07 Mar 2025 02:35:07 -0800 (PST)
Received: from ernest.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23988b403sm254867166b.129.2025.03.07.02.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 02:35:07 -0800 (PST)
From: ernestvanhoecke@gmail.com
X-Google-Original-From: ernest.vanhoecke@toradex.com
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/2] board: toradex: apalis/colibri imx6: Detect new v1.2
 SoM variant
Date: Fri,  7 Mar 2025 11:34:13 +0100
Message-ID: <20250307103454.32661-2-ernest.vanhoecke@toradex.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307103454.32661-1-ernest.vanhoecke@toradex.com>
References: <20250307103454.32661-1-ernest.vanhoecke@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Mar 2025 14:08:51 +0100
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Apalis/Colibri iMX6 V1.2 will replace the STMPE811 ADC/Touch controller
which is EOL by the TLA2024 ADC and AD7879 touch controller.

To support this new version, we detect the presence of the TLA2024
during boot and set a new environment variable named "variant". This
will allow us and users to select the correct DT easily.

By probing via I2C we have a robust detection method instead of relying
on the existing "board_rev" environment variable which is set by the
config block. Users can use "variant" in their DT selection and do not
have to map the board revision to a device tree.

"variant" environment variable behaviour:
* Empty or absent for all versions below v1.2 (STMPE811)
* "-v1.2" for all versions starting from v1.2 (TLA2024 + AD7879)

Usage example:
setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: Fixed the "From" field
v1: https://lore.kernel.org/u-boot/20250228095317.621037-2-ernest.vanhoecke@toradex.com/
---
 board/toradex/apalis_imx6/apalis_imx6.c   | 31 +++++++++++++++++++++++
 board/toradex/colibri_imx6/colibri_imx6.c | 31 +++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index ec0f223c4aa6..e0a7c661270e 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -36,6 +36,7 @@
 #include <dwc_ahsata.h>
 #include <env.h>
 #include <fsl_esdhc_imx.h>
+#include <i2c.h>
 #include <imx_thermal.h>
 #include <micrel.h>
 #include <miiphy.h>
@@ -77,6 +78,8 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define APALIS_IMX6_SATA_INIT_RETRIES	10
 
+#define I2C_PWR	1
+
 int dram_init(void)
 {
 	/* use the DDR controllers configured size */
@@ -689,6 +692,32 @@ int board_init(void)
 	return 0;
 }
 
+static bool is_som_variant_1_2(void)
+{
+	struct udevice *bus;
+	struct udevice *i2c_dev;
+	int ret;
+
+	ret = uclass_get_device_by_seq(UCLASS_I2C, I2C_PWR, &bus);
+	if (ret) {
+		printf("Failed to get I2C_PWR\n");
+		return false;
+	}
+
+	/* V1.2 uses the TLA2024 at 0x49 instead of the STMPE811 at 0x41 */
+	ret = dm_i2c_probe(bus, 0x49, 0, &i2c_dev);
+
+	return (bool)!ret;
+}
+
+static void select_dt_from_module_version(void)
+{
+	if (is_som_variant_1_2())
+		env_set("variant", "-v1.2");
+	else
+		env_set("variant", "");
+}
+
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
 {
@@ -696,6 +725,8 @@ int board_late_init(void)
 	char env_str[256];
 	u32 rev;
 
+	select_dt_from_module_version();
+
 	rev = get_board_revision();
 	snprintf(env_str, ARRAY_SIZE(env_str), "%.4x", rev);
 	env_set("board_rev", env_str);
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index 64cf99e9cfcb..69a3c5f3dfd6 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -33,6 +33,7 @@
 #include <cpu.h>
 #include <dm/platform_data/serial_mxc.h>
 #include <fsl_esdhc_imx.h>
+#include <i2c.h>
 #include <imx_thermal.h>
 #include <miiphy.h>
 #include <netdev.h>
@@ -71,6 +72,8 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define OUTPUT_RGB (PAD_CTL_SPEED_MED|PAD_CTL_DSE_60ohm|PAD_CTL_SRE_FAST)
 
+#define I2C_PWR	1
+
 int dram_init(void)
 {
 	/* use the DDR controllers configured size */
@@ -609,6 +612,32 @@ int board_init(void)
 	return 0;
 }
 
+static bool is_som_variant_1_2(void)
+{
+	struct udevice *bus;
+	struct udevice *i2c_dev;
+	int ret;
+
+	ret = uclass_get_device_by_seq(UCLASS_I2C, I2C_PWR, &bus);
+	if (ret) {
+		printf("Failed to get I2C_PWR\n");
+		return false;
+	}
+
+	/* V1.2 uses the TLA2024 at 0x49 instead of the STMPE811 at 0x41 */
+	ret = dm_i2c_probe(bus, 0x49, 0, &i2c_dev);
+
+	return (bool)!ret;
+}
+
+static void select_dt_from_module_version(void)
+{
+	if (is_som_variant_1_2())
+		env_set("variant", "-v1.2");
+	else
+		env_set("variant", "");
+}
+
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
 {
@@ -616,6 +645,8 @@ int board_late_init(void)
 	char env_str[256];
 	u32 rev;
 
+	select_dt_from_module_version();
+
 	rev = get_board_revision();
 	snprintf(env_str, ARRAY_SIZE(env_str), "%.4x", rev);
 	env_set("board_rev", env_str);
-- 
2.43.0

