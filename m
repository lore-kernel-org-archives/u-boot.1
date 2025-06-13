Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17452C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68A082DB0;
	Fri, 13 Jun 2025 15:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GcWZL8Wr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ECAD82D17; Fri, 13 Jun 2025 15:22:04 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5261282C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so4473103a12.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820922; x=1750425722;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=plwRcu5NE2ivsvIrqCDQ1bP+Uq3U62BXw5bPliYLVrs=;
 b=GcWZL8Wrebec9BGNWjM6eOlkEQH42nzZBX1+wdcXk7M8q1c5DF6Wsc64Y4lnhxiRI5
 L5GGezDia866goHhSDz4AUZV8ZVkIffEuFgY5AiaqSciIzlps4s3+OV8cnGDsumBot+l
 QG+YcuKQEJv+YgnYDH+0BdzONlc5vG7XZenq2ahj9GqNBdjiah/iVs8D5l0Z6bRJZPyH
 5H8cSS2Qwax9c1XIblrQOGdHSkpUh+5e4qewlB7OnlyBc+Now46Q4Zhm+POh6AZxsEXT
 0F0VORRMzgO+cj5YgMUG6AubJobFJCxgcfuNrC5vtPnSfglxjexZMFTUGeDHnRaIoyD5
 VuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820922; x=1750425722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plwRcu5NE2ivsvIrqCDQ1bP+Uq3U62BXw5bPliYLVrs=;
 b=mqsANtozRTuOZ6/Q6IhAwmKcP7NzGVNZlAsSOluc0R3m3LP6MVAAA+BMSwUCitlZG5
 mrrNQW4jDdOGAp1u8iU6FqNo3L6DI9k4ojGqINcq3nfVffAtTTmTQs7bMY1ELgTDbs1I
 g6fHVr01L4c168/uR8Xs6kqcH6VEgwQ3o87Vp3BTONVmncjP7SNAeEqR23PG+BuqYhhp
 XHVqR167ZYwfvMeVPmRggFy8k0gxmw0CmdZDwMQQkYWErIUBYIREnrqazzf0Pi1HR8iB
 gQQ9licjVcCmOHXjdL0kxEuAMxKVMXDwI5IrIJK/zcQYpMQ9JlQVG8gssDyFhUhGlA3m
 Y0RA==
X-Gm-Message-State: AOJu0YytZ5vaL2/D8Ns6VvWl0G+TL73r//3iFX3LawyPTUTK4ntfLYqE
 aBDb2v+JR/VVwd/ExVfUJ+owTU4SCdwu+SOGdYGgq9+UKwJ66z6NoqTc1uQ7/I6gu/YGgoL7G1Q
 5JCiA
X-Gm-Gg: ASbGnctY5igOdLaZvL3G8tMQ5KPVgoag+yOfSsl1Zd6X9QTsqfa4FhuBWrRz3PUYuWV
 wZPb2m713wXMCPo9XqH/BhMUjMPzLViYONBj3/urKz5cz9ihxjQY9OoWnDLL+XKWyWpyOCxTD/h
 jm86As9IoEXDQy2iE6WxcDBRRu1PF05eSfHKPrGIpAQCJsvNFJmGrls0S3LGJEiPsUrZzmWucnz
 ZgmGR/adFl/MOV0NOhOJNqpO8j7StOXcwGYoSuL35hflKtZgYfzY5hcXst+lxrF9g8XFpDDEdWB
 iM7dl5O2WU5p/7ER/ofdcy9nMSjfZKU+uEYKEmU7LBcmy0WvbUksKIYaAV4=
X-Google-Smtp-Source: AGHT+IH9if8G+AfyxmRJjDkF/7jHpiDkGe9Lb+HMdXv9GF/R0LUvbcxyZew1XyRBRiQfg8wHeSKMoQ==
X-Received: by 2002:a05:6402:13c8:b0:608:47e7:508 with SMTP id
 4fb4d7f45d1cf-608b4929519mr2654149a12.13.1749820921735; 
 Fri, 13 Jun 2025 06:22:01 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-608b4a8c34asm1215060a12.55.2025.06.13.06.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:01 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:27 +0200
Subject: [PATCH v2 07/22] arm: mach-k3: common: Helper for LPM meta data
 address from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-7-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3031; i=msp@baylibre.com;
 h=from:subject:message-id; bh=KaUDm38GegnTqtI6utdjrnvi1yOBkypZKcbKu7iDo1A=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1Rn/TsS/nLLPp7bk7W1ni3b3904uAZaK69d+mxHLe
 dp21sQnHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARzXMMfyU33v7KV6LL8k5/
 j6efhI/2jbrp7r6xMVyfw07oefRvWcbIMCPGPObMiowX+ROULmzgmx9bvl0i49hDtp/ZeayaPa1
 NPAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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
index c6b230ad46a891ff0250a2bc65af2aa72d09fbc9..706dc9a300cd90dbd7b3da10e7bb0eee11ffea38 100644
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
index 53a509f4ff5159b32d1c359ab458ec9a7aa07956..096b4859040c464394c0d4a543917b783ade1597 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -51,6 +51,7 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
 bool wkup_ctrl_is_lpm_exit(void);
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
 void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))

-- 
2.49.0

