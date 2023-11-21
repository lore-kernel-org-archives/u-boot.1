Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6733C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34708761D;
	Tue, 21 Nov 2023 18:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MuXXcg2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB5587620; Tue, 21 Nov 2023 18:09:56 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6912787656
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso27274445e9.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586583; x=1701191383; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5JwO7H0CO0rNSIM3J+Om/vnoVqJWoFMenFd2J31IEok=;
 b=MuXXcg2CznqkHQ5CJ1wcSLt+5szJDSlAnXL87ilu0aVGQ/oczk24zGm2YbYc7ICO8z
 T5UruuEC6mluzNka1QWkQkFe0fNSVcFLM6Q9VU88L/bJrSEMkbjcRCy5tEySEcbNlPc9
 Ges9EQbzVI94z7cnDiH0wGKuwguoHCWyxWIgzPUcOkKja+DNfk4yJpK4cYFENjcoC2Nc
 6YIEXHEhba2iRDpfcUL2nXAbd4sA2h5fz9tthR90wooVS+akmIiissqgccGFsohJYQjH
 D/XiZ4uG8ZLqVM4+zm1CJ7dfh/3WLzhYxehO5c4ILvJ0aR95UQ6iMA8vLf7Ir1HgcZtf
 GxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586583; x=1701191383;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JwO7H0CO0rNSIM3J+Om/vnoVqJWoFMenFd2J31IEok=;
 b=hpl1r+8tO91GgawOCN4CmHv7h9+MT+k1+HZpvz1WRr0dnfzZkp4gXRRwzYUQYfIgW0
 JRcH0laVFB2aqXFbuSx4f0ZH0wN4OyqiXF11RXkUccqHKfmnn1ZYS1eigSeXbB1rlC5o
 zh3/R9wfWhRv99Flya/79jW/q101WenRv06jkq1QxTPgrDdxBEoaruZF7whY1VAREB80
 57AsFhC22PzAkf+nHuXHp7UqhzJ/q/J2RsjGv6zctgci7dLKNVxi4jaerUL9ILAlq00p
 t3m4jmCjvJaq3svYmgUJaPDdTigddr4k23wzPUgpvU+f1MmMAjL3CkY23gW6sNmQKrEe
 mqsA==
X-Gm-Message-State: AOJu0YzxTZAbWYRLdcjI3KAOqsH0E6bH6S60jGYnmugZkxSRr6nhzs+V
 EnJw6xrPBYLi+qmCwV4akyzEQw==
X-Google-Smtp-Source: AGHT+IE16W2SvvJRQghKs/kM1O4Z5zwZjp4ZL1CgdHez5F/Y0IlQyhEiuks9qDR9NiDsMoBVh/9CWQ==
X-Received: by 2002:a05:600c:893:b0:409:773:cf62 with SMTP id
 l19-20020a05600c089300b004090773cf62mr8655115wmp.39.1700586582866; 
 Tue, 21 Nov 2023 09:09:42 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:42 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:37 +0000
Subject: [PATCH 14/21] mach-snapdragon: dynamic load addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-14-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2990;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=O8tWvtaJi1ZtA2reOV+LQWoIGYMz0k3Cazcsex8n7bg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ26K7UEajer/WyTtP1zxv/XTJ0jYrOXBSrZ1hyReR
 a6aHX+3o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzkdgfD/6KLDC3P9AuKhPKd
 mBT/nH06Serk1Y7zbLw8dUwNOxW1zjIyTPnAGRaa+ORK8K89L62vNUT+WrBZTS04PIT/Vds9lWs
 fAgA=
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
 arch/arm/mach-snapdragon/board.c                 | 36 ++++++++++++++++++++++++
 board/qualcomm/dragonboard410c/dragonboard410c.c |  2 +-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1faa70bb658d..ae44fabb1609 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1075,6 +1075,7 @@ config ARCH_SNAPDRAGON
 	select OF_SEPARATE
 	select SMEM
 	select SPMI
+	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
 	imply CMD_DM
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 521390ed6eed..765a2c2a95fc 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -18,6 +18,7 @@
 #include <linux/bug.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
+#include <lmb.h>
 #include <malloc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -110,6 +111,41 @@ int board_init(void)
 	return 0;
 }
 
+void __weak qcom_late_init(void)
+{
+}
+
+#define KERNEL_COMP_SIZE	SZ_32M
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
+	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_96M));
+	status |= env_set_hex("loadaddr", addr_alloc(&lmb, SZ_64M));
+	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
+	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_96M));
+	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
+	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
+	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
+	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
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
index bee8034ef92f..ab652e0a7c92 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -113,7 +113,7 @@ int misc_init_r(void)
 	return 0;
 }
 
-int board_late_init(void)
+int qcom_late_init(void)
 {
 	char serial[16];
 

-- 
2.42.1

