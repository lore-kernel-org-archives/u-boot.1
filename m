Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECEFC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3E281CAF;
	Tue, 11 Mar 2025 14:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IApKEsgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF448164E; Tue, 11 Mar 2025 11:33:19 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E33481703
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso8473359a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689174; x=1742293974;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7tGQ4IbB7fEUgeJ16X2ELmyHKoXpZqUQ5vocGpos/9s=;
 b=IApKEsgM7zVABXo4QmAT/5tZv5gCluCKW5YSrWNGQEWerEHmpQ4dzlpFrtuJ3KSmKs
 TC1wGhQ5a9ReN/IctOW+yQPrDZy84kjZfSEIhQPh1eM19V8XdULeepcttywtGAmucV1h
 eKh6YaQJcrMHB5iWauMsQREd/z9x0pbblVgUJF5PIOx8/kzSg/qHnTv/afpCQ5Lp0Xu6
 X/jYGSg9PEHs2IEuseIYruv2Y4PX27S9lNk/2oTBUy2Z4TUcwwAFpZh9vz0lkMVkqvOr
 jIcf6IsZ6237FDyLdzeB/aXCdFIBiA9WxXOVmDw/krWXAMWF+3Zamz2DnivOsfSWlVB+
 GcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689174; x=1742293974;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tGQ4IbB7fEUgeJ16X2ELmyHKoXpZqUQ5vocGpos/9s=;
 b=ISULtBxZOZbEBwgSP7p2fvpmq3O/NKQSNk75YTVs6O6QfmwTRnjLlh3PMoY3fl0g6L
 ssnDAn+ztTx+PG1qWQPRzLKulWer/qJRxYJZvLFd3ct0jkkkAZj77V8+ZYtvNxe9k07r
 VpdzgsU6m4Dxn6NQv+hJMABsehYfRFx2lYX2Cms/Pwu2J0LAhHvSZaUVWEaWlBo6ToVM
 4zjfcWVyP0IQN82TjwwjQlIodddOTnragoKVISn1+jmr0yREq1DnFzs/KbJlOCVd66W+
 WjF46DvJ1HnVFcddQ1kwNX/poWDJHCM9xNtu2PjFT3tiI1lxcCc36FwuMhOHV0kl6MTE
 mTWg==
X-Gm-Message-State: AOJu0YwQYchoVDvCPsSgCTRdUEgjkW43R6N6l38sI3GLd0KZQpzVGyCJ
 YUA8nIxecNRxtCN2L4YL2/Adc8Iy9OPeMv98YhNWvACA25l+oP5FDADMEOhlqFW/E8hy7q05+Bv
 x
X-Gm-Gg: ASbGncttbzgz33n8Nf4oE9zihpXcow/7Pgb1MSZDSvlKHMnpQ+VvSIBzzpPvURBLDJo
 vo0W3FwynuLcTZ9OkSnF1Ug2SfF+EsRH1WzpCUa5nRKDjKh+Ijjq8locaJDTOns0LE3jcZ5oNbC
 /fs2I6uGm9vi50p+THAgplJFOZuwzRL7c4bZedf9tLRXAA+4/26BI7yFZmmBAsG6/ccv/0iMoZ6
 cMVJgjV6RnV7ZWhYpQbQ0Koag1YZZJrFT6hwHJC3nKbmK0u8A84hV0HxXV/AEuqdx3FlTlen+Ym
 oi7X5RYuhuLq62/oXi5qL3t7l1ZKgres1bcLAolv
X-Google-Smtp-Source: AGHT+IEfKdygOdNU3kVJl6hGFDir3IPZm3mDz6MSrSgPlFEZfE51QumKhKoGQO72iXDrHIBjoHu7CQ==
X-Received: by 2002:a17:907:944e:b0:ac1:dde7:b57f with SMTP id
 a640c23a62f3a-ac2ba513a8bmr280360566b.23.1741689174530; 
 Tue, 11 Mar 2025 03:32:54 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac23973a74bsm884708666b.123.2025.03.11.03.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:54 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:46 +0100
Subject: [PATCH 07/19] arm: mach-k3: common: Helper for LPM meta data
 address from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-7-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3031; i=msp@baylibre.com;
 h=from:subject:message-id; bh=DsUMdCFZjwuI8QxOxL2pEHGu4rF9QalOSNqGKGRGwLM=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCHIfKZjFbD+t94fKIaZ/W2+33w2f8OSj6Ivf/05s4
 zTMyIr71FHKwiDGwSArpshy98PCd3Vy1xdErHvkCDOHlQlkCAMXpwBMZCkDI8MtnhsiWRP1l097
 4XboibJ/f9or52NXYu8d6ki98/WCkUIuw//w77xvGz5e92O8Y+V4tNf9tXktZ+hRVXXdvln+lgv
 KjzEAAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 2d9f34e61d916ce3a252e9cc3c2fd5475e60799e..7ec1f864a63d33ef1fd5576fb828c289dc5cf98a 100644
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
@@ -33,6 +35,7 @@
 #include <wait_bit.h>
 
 #define CLKSTOP_TRANSITION_TIMEOUT_MS	10
+#define K3_R5_MEMREGION_LPM_METADATA_OFFSET	0x108000
 
 #include <asm/arch/k3-qos.h>
 
@@ -153,6 +156,42 @@ bool wkup_ctrl_is_lpm_exit(void)
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
@@ -190,6 +229,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
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
index 47f2dbf2accd9029d6f1905fe8d3f93381032a81..c50dd3b76b37f762f345ae48dd2537ace5df3c02 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -47,6 +47,7 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
 bool wkup_ctrl_is_lpm_exit(void);
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
 void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))

-- 
2.47.2

