Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BE4C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA70E878AC;
	Tue, 19 Dec 2023 17:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J+zjEoWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340F6877CB; Tue, 19 Dec 2023 17:04:57 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA3D87817
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c339d2b88so50896505e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001879; x=1703606679; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wgMWuDvGVcEVx9PLuavCvO43mXySJWj1lDk62kGmP7c=;
 b=J+zjEoWloGWm8s60HXhG4Mc6vWKeD7adb9tuHK6rmxRSroQJ5RHaAMGYyNU741oVmS
 FePUuiThlckSULzJoISBSdEBrj+d3eT69QI7RAzZYXXoky2d/2EPqIYso3FHvzmxc2hj
 4rtHCGHvTbDqUFCdLBykFmSafLIkWeuPXmczsHXC+8qudlZR9oKzojVM+Dr107pNtq38
 HSIBtAEcm6A3q5KkaZhFNmAmiyea/aQDTv4dZBrOQvDKNLOCO6aeOEu9rAwwfiROywMC
 nm+NgR/XCN+hRL/X0F7/BLV0oyv7xuk6iu+AW/ZvDTYLBhGd6SrXKcIfI5Rr5aPdN8IX
 fcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001879; x=1703606679;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgMWuDvGVcEVx9PLuavCvO43mXySJWj1lDk62kGmP7c=;
 b=bh4aggMVDtomU7mFgRx2nKw3/0tsYO2Q8pQxxaagtv7vyLnXhuwyBTpu4S4XzRLh6C
 gZL8EmK0szQHePa9dktHHgTlpv0JOZDpbpLX2TAlGTdRT9Vc+2NGKg03FUG3WrV8yrSa
 KbkB52mitp+bn5LzKCIZQLbfyxmWsQqZXnPE80Nbft3n2kxnkcWCEO+2AsmGGp7pv6pk
 wxe19nItD9gE6YuYthXoDJaVzR1FsikEfzk1e03CHOrV3fqSBgXN1zX/Qrkaz+D9Ln+f
 +I0wqIemIf4xE1cZBMP1KnvKSCCZ5UslJ+jc33QwwQj/DjQ0qdPkNRe4IP3pNKolHalZ
 Tv9A==
X-Gm-Message-State: AOJu0YyQlJ+J4XEX3/7AiUYwE2yQsV01Ln87TF72QWS2JWg49fScoVdX
 3WJh9V+STYi2V2SZ/scJ8t1MAg==
X-Google-Smtp-Source: AGHT+IGICov5uxB0DCIv6VkwgcKWxeux6R7hxPbkegW0NBye3eWWlnOwyOhdUozDPRJm+JSG1H/qPg==
X-Received: by 2002:a05:600c:3b8a:b0:40b:35aa:bfdd with SMTP id
 n10-20020a05600c3b8a00b0040b35aabfddmr8511577wms.27.1703001878908; 
 Tue, 19 Dec 2023 08:04:38 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:38 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:17 +0000
Subject: [PATCH v2 16/32] mach-snapdragon: dynamic load addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-16-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2945;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=txcnT6R4iyi/uw1WyGnpA/FiKqq7joOZV7jXyneMllI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/czrOfbNbng4hYNJfKaks3ym7OOkH9r8UanR7vlhz
 BMnBq/qKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABPxF2Zk2DCte7/91N+cBZIt
 vx/rZf7VKDOunvWP97zckp1uUszMigz/bB82X9ny5u2DTzd+73D8sY+tYuuPV6HToj8e+3Q6eUu
 NhgIA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Heavily inspired by Apple board code. Use the LMB allocator to configure
load addresses at runtime, and implement a lookup table for selecting a
devicetree.

As some Qualcomm RBx boards have different RAM capacities and base
addresses, it isn't possible to hardcode these regions.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig                                 |  1 +
 arch/arm/mach-snapdragon/board.c                 | 35 ++++++++++++++++++++++++
 board/qualcomm/dragonboard410c/dragonboard410c.c |  2 +-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e814910cb495..5ed9cbf378fa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1075,6 +1075,7 @@ config ARCH_SNAPDRAGON
 	select OF_SEPARATE
 	select SMEM
 	select SPMI
+	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
 	select LINUX_KERNEL_IMAGE_HEADER
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index bf9b57682178..b00f536d38b4 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -20,6 +20,7 @@
 #include <linux/bug.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
+#include <lmb.h>
 #include <malloc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -112,6 +113,40 @@ int board_init(void)
 	return 0;
 }
 
+void __weak qcom_late_init(void)
+{
+}
+
+#define KERNEL_COMP_SIZE	SZ_64M
+#define SZ_96M			(SZ_64M + SZ_32M)
+
+#define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_2M)
+
+/* Stolen from arch/arm/mach-apple/board.c */
+int board_late_init(void)
+{
+	struct lmb lmb;
+	u32 status = 0;
+
+	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+
+	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
+	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_128M));
+	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_96M));
+	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
+	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
+	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
+	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
+	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
+
+	if (status)
+		log_warning("%s: Failed to set run time variables\n", __func__);
+
+	qcom_late_init();
+
+	return 0;
+}
+
 static void build_mem_map(void)
 {
 	int i;
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index e403ecf0ad7c..2a502c7c2841 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -77,7 +77,7 @@ int misc_init_r(void)
 	return 0;
 }
 
-int board_late_init(void)
+int qcom_late_init(void)
 {
 	char serial[16];
 

-- 
2.42.1

