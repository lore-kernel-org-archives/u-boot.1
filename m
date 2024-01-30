Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923FDC47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D9387E8D;
	Tue, 30 Jan 2024 15:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aMDThXF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D344A87E31; Tue, 30 Jan 2024 15:05:37 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7997787E31
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40fafced243so2318675e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623527; x=1707228327; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8gb1u2H94rZEk9mGhCSonGNtRpGSlOkG3bOT+lHb6Bo=;
 b=aMDThXF1dLW0H1Szls9NN/Id7bmMprZ5G/8dXQgdJzFdNV1WK9G+7jfFWt/j9Ixk6f
 yzwdDcs4Wk5BI9MzMHvVjr5P3+7WzJgE8FfH0HWlm5PCle8TTdBSPfyjC1fGte7bmYwq
 xwRI32eazNy/WIdfZp1Y2rm1g4dHLWFcxqkk1hiVqlRJjPCk3L2aVpKymrJmd1np2j/q
 aHkxYpnS+6O9jOPjU0mQcKR0IrTj7B54jqt16p4sEJHPAAjBWj3v0z+DMLxHJF6WwhKa
 OfvhZ5rKcgXp62M7cP5rXMRVZ8yxWFe1v4Ba+OjbByiLh6UuNiFMV0sBFvaqUD5CrTi5
 b66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623527; x=1707228327;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gb1u2H94rZEk9mGhCSonGNtRpGSlOkG3bOT+lHb6Bo=;
 b=g3y6SZdWGTXeVyvrX0fV37Y/rTRVk9kRkff67YDGK5nL3FOCwSGsuM/qDcUlPJDv1n
 VHyfBgwFD/LKK1DgRSiZ8omB26YwKrBIbUvSCTSpTHm5QlqbYAlbpEoa7sVS01QYYMys
 tJzS1If6pxi4al5zmLrcwMDNFkCRGmZ3DPyDtkjQKY1HpfEYpw7VrMujXqwGmK11FdBh
 ZmGo9tfkRFgN0OxLkLYEFcPun6Il6WXcjzPtwvI1jDfiVsGpzOPHrXeqNyCoRw1aeuN5
 x5K0N+vbq69g84dQz7VD9cIEJC0v7/w9UgmDuDtu0rXPrpjNNOPpLQ3F6TI4PlFW/2tv
 Zk2A==
X-Gm-Message-State: AOJu0YyU3elQoCQajWtUWxaz4CrDE2SlaHpXjWea/Hpt/vV+DHuWJnfp
 JSFgx3DTXQE0B6XbCnvGGPrPqiX3wmbxhwM26Fjb9Ez1YBoGnKtcyL89RgQX6As=
X-Google-Smtp-Source: AGHT+IEOYxBGfNWhlhZaJ+QcCwJgqsQ2N+p7vtt9evrIhuk76CJBgTHsJqdKuYuzfr1kCuYniC3Lhg==
X-Received: by 2002:a05:600c:1e06:b0:40e:f693:94f8 with SMTP id
 ay6-20020a05600c1e0600b0040ef69394f8mr4892243wmb.40.1706623527040; 
 Tue, 30 Jan 2024 06:05:27 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:26 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:06 +0000
Subject: [PATCH v3 18/36] mach-snapdragon: dynamic load addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-18-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=przxI8/7PZyFkZZFSLCCMOGz4UtgeSxzk00jFnxUd5c=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTIKy3zMd3nI6zW8N/tCw6ZCr7ZLE0hS3B6LfG70Zb
 mkrSC7oKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNJcmBkmHOr0pCljSnQJzb2
 0frANzWvgtLaT2l06065en7/wtm7YhkZ9varfn55xGj2Tt1HTkKNR48uCXjC6HEk9dFpjcWLi8X
 sFwMA
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
 arch/arm/mach-snapdragon/board.c                 | 34 ++++++++++++++++++++++++
 board/qualcomm/dragonboard410c/dragonboard410c.c |  2 +-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 03ea75cefc0d..c7a07c648fc0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1085,6 +1085,7 @@ config ARCH_SNAPDRAGON
 	select OF_SEPARATE
 	select SMEM
 	select SPMI
+	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
 	select LINUX_KERNEL_IMAGE_HEADER
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 3018cc462b8f..3f51c4ab42d6 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -23,6 +23,7 @@
 #include <linux/bug.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <usb.h>
 
@@ -160,6 +161,39 @@ int board_init(void)
 	return 0;
 }
 
+void __weak qcom_late_init(void)
+{
+}
+
+#define KERNEL_COMP_SIZE	SZ_64M
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
+	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_128M));
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
index 0136cc2237de..fbbfc0e65e24 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -88,7 +88,7 @@ int misc_init_r(void)
 	return 0;
 }
 
-int board_late_init(void)
+int qcom_late_init(void)
 {
 	char serial[16];
 

-- 
2.43.0

