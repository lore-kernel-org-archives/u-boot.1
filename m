Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9DEC77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EC0082EA3;
	Mon, 23 Jun 2025 14:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NM9GRZU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7ABA82977; Mon, 23 Jun 2025 14:10:38 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC63B82977
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ade76b8356cso701642866b.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680636; x=1751285436;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X4XOylh46D3T75ao1EuotwvRaSRvPmApkmB0VCyRPbc=;
 b=NM9GRZU7xaeewyoYomValZMXt5/DycwM6dwQq1Cpaho/aPAkhpXlLwpxZGgkKabaFL
 4ey8FRywzYFGF1LxCnlqzq5d/eyGazN1sv945pbCUsUoH8IKAjMU7WRGsmjSRIbbjX4X
 t5scnuqH+p2VSfV9nfgB2WbB6OH0j7+DKNuD8Ba09NVwWArGVoLY6i2MDRnEvU9MZ9zO
 9OtIYNEVvNuSQpLqsuL7wnr31febjo5eY6yFHdJiL/db27om8vlg7sp2Xps2X7dHHBaD
 JhYCY436xI9DUf1b5XrgDE3WVB7jxO9oHPVUPuXkAL4sdX0UzTZi183eN3ytR/S3/WXo
 kPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680636; x=1751285436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4XOylh46D3T75ao1EuotwvRaSRvPmApkmB0VCyRPbc=;
 b=kR/9VnI+ghhwgaseBANU10KwBqdLthPLtTT25Gw9si6k/1hYNTMfhz+0foFtkM9CvE
 lgbUDoXUAmsqKSXEAepo0ioVxVRJLCGhlqg1+IOnKIFJBhTdjuxptTJU4EI3e7OAkdWm
 TZhcmeCdQ4Eppe5eHWQ5MEXlpLb60gXdhgO+T33j5kAY3+qcsIM+FUZMkPl51JMIQx4G
 UzvfDjxDA3zNH8pPjD1YCTR1U5fNcptXHx+qGcBDncZvheXI+65+P8Ip5XFMlYdmatsq
 IUGy+mWTddpgGm3nN1kQ8daSqoXRkjb15KuJWlE2YzEgsSQA56AFZklmaplGNQ7Was+4
 5M5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjdKikNw+sc7abfxTgkDIkgW0ypXIdy46iJ0wMXxnDIvnogdRYTeoR2ZBzPQsK1+3FEs1Qd+g=@lists.denx.de
X-Gm-Message-State: AOJu0YwUxYdE4muPPQM6UWMwkzJflpDUtRitWMz4iLFL1MmUMtDJa5vB
 8dfWqYxsSRgXxrCOQUbzWCr/Fmnes8qa9gbji0jYl3VKLEMFWpNiUNB6/gSyQYpDme4=
X-Gm-Gg: ASbGncuxgT7W7qo1NBdBM/3fxv2uXvd+IESgar7qqULFB65xpqQpv77pJAyb/xbEUx5
 pcESCPtyWIuYy6AYtaxn+PvYimDuVETBQfdRNuKNNrfpE4xdTc0tlt5O6xsRG8aJVhYlqSar+/P
 IusIZxSYkHfTXVTJOWJu1332zMHDAqr4Sbcegg4xnhAL2uDnBQvoJEr3kG51hoR2bxx4b/BhZyX
 nv3Jvoitkhfj4He1SsDRdrTQb2DPg/tpD2jsCuOgz0ZPVqiltgLmevwtdbf7EdZs5VNzrq9M36P
 uZM6cBG+QJwaVCwpKPgPfiWwlHQidKy7GslamAuXSKBSP8FF6zRi4jsshhaJN8nHYb9bEQ==
X-Google-Smtp-Source: AGHT+IFTKbVm8eGvU8WwHmhbsupDP9sPlZm9ZRKYlB+Gn8hKx8PNUOjfnBEENFcZtulWjKiZxaiLCw==
X-Received: by 2002:a17:907:3d92:b0:ade:9b47:9242 with SMTP id
 a640c23a62f3a-ae0579c0d9emr1083911766b.0.1750680636134; 
 Mon, 23 Jun 2025 05:10:36 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae0541b7242sm699938966b.118.2025.06.23.05.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:35 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:30 +0200
Subject: [PATCH v3 07/22] arm: mach-k3: common: Helper for LPM meta data
 address from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-7-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107; i=msp@baylibre.com;
 h=from:subject:message-id; bh=HoDIL3srxSNLtHF79OGkliljHutV73f/TKWUHzxBvPw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI5wcyy2xm3n34YqG//4n8rw46TFO5fmtsYWCePqs32
 tL0a6xmRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExkRjIjwxY3fv2o7PS+P2uT
 IiwkNeOWux86/euEiPD6lkUTL97ftIbhn2Fo0jrGlpBCFvZ6h/Pb3zfemF720HrmhYp3+hM6lGx
 O8wEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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
index 1ef560e2fb936c4245323bbebc5af3ec277b8792..98974d446fd76872869f2c9b88abd060213c234c 100644
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
 
 #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
 #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
@@ -187,6 +190,42 @@ bool wkup_ctrl_is_lpm_exit(void)
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
@@ -224,6 +263,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
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
2.49.0

