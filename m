Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1076CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9AD883981;
	Thu, 30 Oct 2025 14:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eMImz0DX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 259848352B; Thu, 30 Oct 2025 11:01:40 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B819800B1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-429b85c3880so531727f8f.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818497; x=1762423297;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0pMIWjtH2pKqLf2cQd0bbEpdZVBXpXF3spOrmkLIg2Q=;
 b=eMImz0DX9m+K9cyZpIg3tT7nCXjMrSZS0KslUk+FxwhR0ExnkGIMJq+34soU8N6vaV
 iNifmSk0b4SWhQIYeZjobY7uoiLMQ5BLS7dEzfks2ySagLbmjmzfDQj6Svdufe82by2r
 37NinzUWx3NE06/FLVkkbNan9s3904q+2WKH7EKqe2mjMoX8BmGC2X+RjvKI96cn3I0R
 7DTH4SiyMMNuanyd1aHip8FGyewxnVxJxFl1P6XPH8O0IrU8XmKPo2ERrJsDw5JaHRmc
 qGzogYbWAwcBXY3oKJeCSCpaTVIZF3jghMBw8dhTMwO8iRgMjbk0tGu5dfdH/Kv5TmE0
 X32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818497; x=1762423297;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pMIWjtH2pKqLf2cQd0bbEpdZVBXpXF3spOrmkLIg2Q=;
 b=q1MzFwRI1J+yil5vkw6l7wAgDY+iidDpzBNjsAKD7N6tinMtSEY6kUHkhHhkknWYpe
 CPecl5vI9GA0owDN7fIFvCLb0Uhi6u1bjVcSkJXl7F4J7BijHxJP6S6jp7f4Qa0dhyZS
 WU8rSUNd8WYaAc17p2dmey7sTTlWinYEB1Cae6gSkzzuEBJrAYcDCZhT5c40U5HFT/S0
 HuGVRB8rgpyInRedwNWanUyl+rHq9/nDuQGMejvYLhHqwP0P5Le0URFhiTEMiVSGbK/r
 koTJ5+2f9r9FORX3kLAQLVVXlZtSxOVllad7t0q3iEj5oAvHtdj4GUumB3I0rKE5afCD
 8wpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk2PgNfyMc+t+9AhbqKiVRpjGGwY8Y4tjeu7qvG5C9MVFqqKF10PN4XCyCfuGWmPUyquIu65U=@lists.denx.de
X-Gm-Message-State: AOJu0Yxhy1nT/IHFHuBzNaW1h/iltMqX/6LVO8sSyvb0EY18s1NY4eQS
 tX9Tq6kT68FkIWZ5xw3bwZSQE164CKDn7ii29GKih6D0Vj+zMADo5XUtw/Qv1XevJ6U=
X-Gm-Gg: ASbGncsaCsxBIjpkQuDc0lEs7xIqMHDH5nw8xL0yNobs9cWbOpCYYgtqPLb/J6p96Hx
 lZs3JA0to3fYc1asim4daobILrq4R9ktUVtH4n683zuXcJnNUV2pP/dF1trrBNL3KJw4nG3rNqg
 EfVUCfiVDKv2skGVsZYqPSV45NCRMUAmQWUUVqvZK2I+/vPEDFvaR3ooNWcE9SxrPVTseFezj07
 aFUwsH0/i79nqtu2dJP0+BK+J/7Owo1gtgLxezaEB5hm/gElsw45W8G+D9Yb0jSjQkYDOCp5TAC
 i+TzQkBEnF3unmHux4gQfPTX5f5ovKcFx2reHJmIcDDz3o7hl6uXtY6+GoE5AFbKd0ZZAVrbE+T
 HJ+s7jTefIr/dzM0DFcnDTxAUg6vElB8ahqzcHDuiF9xYkmy8GyDmyV0f/om5dP50BIgrronT+g
 ==
X-Google-Smtp-Source: AGHT+IFrqZ9qlmQ/iQW3pRTbiNugct97XnSdq02iGgrXJ4z8dYLDzLQrTvzKPJrG/Aj/wT4XBX5RnA==
X-Received: by 2002:a05:6000:4202:b0:427:151:3d9c with SMTP id
 ffacd0b85a97d-429aef7b212mr4936694f8f.16.1761818497449; 
 Thu, 30 Oct 2025 03:01:37 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4772899fe36sm31485825e9.2.2025.10.30.03.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:36 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:25 +0100
Subject: [PATCH v4 07/13] arm: mach-k3: common: Helper for LPM meta data
 address from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-7-4cef18af0226@baylibre.com>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3116; i=msp@baylibre.com;
 h=from:subject:message-id; bh=b0tXPXijF1ieT4T2qAWJY9CWMgL49R2W+540umHv98U=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmc4OnRrtUO7aFCf+R8Mr3Weire2LBviTd8MpY7r97F
 qx6JnO/o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACbi+oyR4c29w/OSphyc4jA9
 P6K9SFA1xe1Jo/SqFiFG9pKNvrl7PjAy7K+J6+Te9+mVg2jbBbVVvBlPHxnwdLZs+sygtMI36eJ
 GXgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

Add a small helper that uses memory regions referenced by the R5
devicetree node to calculate the LPM meta data address.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 69134a1fce1b1ab9131d9f6e4c40b291c10cd2a6..f59ca4f500bc94f71843afb8b67cb8eb53c87ec9 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -16,6 +16,8 @@
 #include <linux/printk.h>
 #include "common.h"
 #include <dm.h>
+#include <dm/of_access.h>
+#include <dm/ofnode.h>
 #include <remoteproc.h>
 #include <asm/cache.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
@@ -36,6 +38,7 @@
 #include <wait_bit.h>
 
 #define CLKSTOP_TRANSITION_TIMEOUT_MS	10
+#define K3_R5_MEMREGION_LPM_METADATA_OFFSET	0x108000
 
 #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
 #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
@@ -190,6 +193,42 @@ bool wkup_ctrl_is_lpm_exit(void)
 }
 
 #if IS_ENABLED(CONFIG_K3_IODDR)
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
+{
+	struct ofnode_phandle_args memregion_phandle;
+	ofnode memregion;
+	ofnode wkup_bus;
+	int ret;
+
+	wkup_bus = ofnode_path("/bus@f0000/bus@b00000");
+	if (!ofnode_valid(wkup_bus)) {
+		printf("Failed to find wkup bus\n");
+		return -EINVAL;
+	}
+
+	memregion = ofnode_by_compatible(wkup_bus, "ti,am62-r5f");
+	if (!ofnode_valid(memregion)) {
+		printf("Failed to find r5f devicetree node ti,am62-r5f\n");
+		return -EINVAL;
+	}
+
+	ret = ofnode_parse_phandle_with_args(memregion, "memory-region", NULL,
+					     0, 1, &memregion_phandle);
+	if (ret) {
+		printf("Failed to parse phandle for second memory region\n");
+		return ret;
+	}
+
+	ret = ofnode_read_u64_index(memregion_phandle.node, "reg", 0, meta_data_addr);
+	if (ret) {
+		printf("Failed to read memory region offset\n");
+		return ret;
+	}
+
+	*meta_data_addr += K3_R5_MEMREGION_LPM_METADATA_OFFSET;
+
+	return 0;
+}
 static int lpm_restore_context(u64 ctx_addr)
 {
 	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
@@ -231,6 +270,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
 	image_entry();
 }
 #else
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
+{
+	return -EINVAL;
+}
 
 void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
 {
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 3333b30b56e711b082d4da7f6773cf0002bbfe30..c579796a7a3baec12792ad137c5c03e7ea361d55 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -53,6 +53,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
 bool wkup_ctrl_is_lpm_exit(void);
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
 void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))

-- 
2.51.0

