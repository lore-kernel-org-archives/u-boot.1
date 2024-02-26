Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD367C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947CD88008;
	Mon, 26 Feb 2024 18:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LoUDCb5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F4788008; Mon, 26 Feb 2024 18:26:56 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8480F87F6D
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d2b354c72so2449790f8f.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968402; x=1709573202; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mqX9gKzmz6CkmphhXhiOjQ+DBhpxEkZuaVr/s5JSveI=;
 b=LoUDCb5eZ35UAip8+kbgRNdV3OlK4szjq3xxcDE1mKzMAbTppbzml0aqx1avNl5wUB
 YMvyk6B882PEXc8m+rmnKf4g+klo6KfEKBeSzEZ/KBmmFHIWFqwiH3spXJ4MdMHaN+la
 ovY5gPBN447qE10GJDgWzk2ZZEal7YaUuol95C9mTN9yng0XXfsWjoXDUonpF2VpzlM8
 LlkcCdnxELB71cE6e4Y6t45HummwLJLk9Ois/MuyvZAi2L/L4sA97H97Npb4+sjdt/ZW
 mUw1hSitUFv0mUX/koeWoCSXwPg75SnCTjcTb9vEWHGk57cFbyNTqFzIpggtB5vE9Qhe
 6xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968402; x=1709573202;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqX9gKzmz6CkmphhXhiOjQ+DBhpxEkZuaVr/s5JSveI=;
 b=r/uQ7Rf+khFYiZQLqqQgBEUfmG7R4EgFRrO4a7Te0driL53XQy8LaT6eRnsT1XlWHo
 P6rkvov/oXKKrPu/FEhqKi7rdoODI2MoLOJFz4aMM7I2lcoGd2k2U0GGHnD6QM/QS8y3
 aTfzuj972Unojv4MhvSoMuPFCsdEcRSq3B/AASnCJwsx6pC3vZtSk7VRzzVw1ce4tBtK
 16+6l/227WuMmIo8Re+g0Dmb/6kWWJlxG5ewaYrIwBUxOYWmxEyBo+70NzwijIYU1hB1
 tfhl3Ni3YGe2jlCHPM/tNPXnFNmirUoFt9BoYnTzMoxxutnDzxjIwec1LmgBbBspGlCz
 YWyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjhgfewR9HmxbE6Q3zQfwUzOIH+4UNxaxRANecXEcv6H3bnc0w6sUJsBJ/rCZriiKvw9xTRA8f+lyhulUf/q5t3EGufg==
X-Gm-Message-State: AOJu0YylItYGM6CfjdjNSwoW/QpPXaI8FiNXG/hiQAn1F0TqiA9u/Jq8
 26vA9+rxoWCNPMHXixo+CC4baTRTpG8XxyzHD9xffD6EGDbq8+y0AZnZ+CpWcPo=
X-Google-Smtp-Source: AGHT+IFw9TI21oJM/x5KXrK6FS9Rr0GfQJIsnhnR4+277/6a8skcm2mWZ9SUltO9UH1klFRvB4ap3w==
X-Received: by 2002:adf:f08b:0:b0:33d:2012:a2a7 with SMTP id
 n11-20020adff08b000000b0033d2012a2a7mr4648510wro.64.1708968402100; 
 Mon, 26 Feb 2024 09:26:42 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:41 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:25 +0000
Subject: [PATCH v5 21/39] mach-snapdragon: dynamic load addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-21-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=f/T3E5TW/4ttTFWkAjM1QFvva3NY1zLyeF0dfoxuyJo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3f/Xz3dT1tV9JuInHKLrplHo9Hixsj61LWmIWtmG
 WR/fpndUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYit4nhv4fsrrZgBZvKrOo/
 n//0nZkyY6VjidPrf4G1DrtLJ9q2KjEyzGCbsfrxumdPhPbxylmr+fMcmO/f9jNi/nTLmdsiRLr
 c1wAA
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig                                 |  1 +
 arch/arm/mach-snapdragon/board.c                 | 34 ++++++++++++++++++++++++
 board/qualcomm/dragonboard410c/dragonboard410c.c |  2 +-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0c78c1b8e6b4..c7c236bada7a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1095,8 +1095,9 @@ config ARCH_SNAPDRAGON
 	select OF_CONTROL
 	select OF_SEPARATE
 	select SMEM
 	select SPMI
+	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
 	select LINUX_KERNEL_IMAGE_HEADER
 	imply CMD_DM
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index a1867852bcca..f445bed3af00 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -21,8 +21,9 @@
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <usb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -158,8 +159,41 @@ int board_init(void)
 	qcom_board_init();
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
@@ -87,9 +87,9 @@ int misc_init_r(void)
 
 	return 0;
 }
 
-int board_late_init(void)
+int qcom_late_init(void)
 {
 	char serial[16];
 
 	memset(serial, 0, 16);

-- 
2.43.1

