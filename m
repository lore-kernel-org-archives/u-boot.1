Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C87C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 17:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F20874D0;
	Thu,  7 Dec 2023 18:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="GpgWkFYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2382C86940; Thu,  7 Dec 2023 16:32:39 +0100 (CET)
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com
 [IPv6:2a00:1450:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 114048715C
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 16:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3k-VxZQgKBlgF0D8A84B6EE6B4.2ECK-1EEJB8IJI.34DN.34@flex--panikiel.bounces.google.com
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-33331e69698so861729f8f.1
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 07:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701963155; x=1702567955; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+vsEAZ1V0elRgsirhoU5DZEbJW1W7XddfnT19SCMAoE=;
 b=GpgWkFYd5dQY4EJb3hn3St5FcooOQKyqGZSNrexmgDa3mXbbPJPKfofPbFBAcxkhpT
 j8ufFILkPMJChAbXOk9rtJa0TVIjm7OYezUTpYhJ523ztmj3/xA7JbvNz2jHjDS11I2j
 JBFjrV8UNAUsn/mqXMFdMS5Fn6RSMGi+tF3xRBtisl6s6sgGh5R1pxPlN9rmhRV4FXW6
 fNG9OVThH4MWlGJbVH1lRsSXMLx0TJxm+sjLrU0c8fjn+N2/m4k7/7kEzipEBzOlFqV4
 hLj/fM+WQ1GFHhU0Zg0lIB7uBfjLP4iYx+M1WOvHq10UmlzMyTGUGGkTed6Q7jnleiRj
 3Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701963155; x=1702567955;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vsEAZ1V0elRgsirhoU5DZEbJW1W7XddfnT19SCMAoE=;
 b=NY4kDOGXDoi/v+5ahMvyDjPIC2QBK0LBfLgVKtq/opOv8UMjpW1cqy+dfjuzegP/tS
 QaTxjv0eoKnQFMD3crCMJYhPQjxpBy+OG7lY9fsX0VsCV07VX+s1K02+YJB5N04Alxir
 ajj7utWaWitndd8GJKoGLaHlUnCemOB1RI+dKwtF6D7795lOhmeX6sVY6Y4Y5P8CS4JP
 +Tp1cbSyhsijwRo2FjlXOLv/t9epwPx4AHaIfiuzwmJGT/pfHu7kNPt70BReTifS8n45
 4wQhDkQzoELrOn4oDsLButiiD6ojirgcCmtydbbzqgHCsRis5hBUJwuOg+ci4OORA/N3
 0URw==
X-Gm-Message-State: AOJu0YyKLho6MTLiIyuW44J3FtEvhPqoItl/xmYuEGLxgHhuyEyQ6T39
 /y2mOgm4FwsWYkBtE3OQ2Bu9xOvI15TV6javWEKDpf8JPQZnCNqEo+s/cNKkwgDyydsnnwzxKfM
 6Nxpw+h4O6wLSJ65JR4aAcoAYDmP+aC858h+e75TY/Vq0hacxviFN5QF+k98t6uh1
X-Google-Smtp-Source: AGHT+IE+mk/PY90coKkxWO5RxDh9fsy8bvT+HAv+w5UcfXZnOXCqqarU09oKl27F4pQGq5kED/E261bWIO99ZQ==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:adf:9dcc:0:b0:333:5457:641 with SMTP id
 q12-20020adf9dcc000000b0033354570641mr17118wre.10.1701963155362; Thu, 07 Dec
 2023 07:32:35 -0800 (PST)
Date: Thu,  7 Dec 2023 15:32:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231207153230.2471652-1-panikiel@google.com>
Subject: [PATCH 1/1] ARM: dts: chameleonv3: Update handoffs
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: u-boot@lists.denx.de, marex@denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Cc: sjg@chromium.org, amstan@chromium.org, 
 "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 07 Dec 2023 18:15:43 +0100
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

Update the chameleonv3 handoffs with the ones generated from the final
FPGA design.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 ...ocfpga_arria10_chameleonv3_480_2_handoff.h | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/socfpga_arria10_chameleonv3_480_2_handoff.h b/arc=
h/arm/dts/socfpga_arria10_chameleonv3_480_2_handoff.h
index caaff604eb..37cd5d653d 100644
--- a/arch/arm/dts/socfpga_arria10_chameleonv3_480_2_handoff.h
+++ b/arch/arm/dts/socfpga_arria10_chameleonv3_480_2_handoff.h
@@ -13,9 +13,9 @@
 #define EMAC2_CLK_HZ 250000000
 #define EOSC1_CLK_HZ 33330000
 #define F2H_FREE_CLK_HZ 200000000
-#define H2F_USER0_CLK_HZ 200000000
+#define H2F_USER0_CLK_HZ 250000000
 #define H2F_USER1_CLK_HZ 100000000
-#define L3_MAIN_FREE_CLK_HZ 200000000
+#define L3_MAIN_FREE_CLK_HZ 250000000
 #define SDMMC_CLK_HZ 200000000
 #define TPIU_CLK_HZ 100000000
 #define MAINPLLGRP_CNTR15CLK_CNT 900
@@ -24,7 +24,7 @@
 #define MAINPLLGRP_CNTR4CLK_CNT 900
 #define MAINPLLGRP_CNTR5CLK_CNT 900
 #define MAINPLLGRP_CNTR6CLK_CNT 9
-#define MAINPLLGRP_CNTR7CLK_CNT 9
+#define MAINPLLGRP_CNTR7CLK_CNT 7
 #define MAINPLLGRP_CNTR7CLK_SRC 0
 #define MAINPLLGRP_CNTR8CLK_CNT 19
 #define MAINPLLGRP_CNTR9CLK_CNT 900
@@ -68,7 +68,7 @@
 #define CLKMGR_TESTIOCTRL_PERICLKSEL 8
 #define ALTERAGRP_MPUCLK_MAINCNT 1
 #define ALTERAGRP_MPUCLK_PERICNT 900
-#define ALTERAGRP_NOCCLK_MAINCNT 9
+#define ALTERAGRP_NOCCLK_MAINCNT 7
 #define ALTERAGRP_NOCCLK_PERICNT 900
 #define ALTERAGRP_MPUCLK ((ALTERAGRP_MPUCLK_PERICNT << 16) | \
 	(ALTERAGRP_MPUCLK_MAINCNT))
@@ -120,9 +120,9 @@
 #define CONFIG_IO_15_WK_PU_EN 1
 #define CONFIG_IO_16_INPUT_BUF_EN 0
 #define CONFIG_IO_16_PD_DRV_STRG 10
-#define CONFIG_IO_16_PD_SLW_RT 1
+#define CONFIG_IO_16_PD_SLW_RT 0
 #define CONFIG_IO_16_PU_DRV_STRG 8
-#define CONFIG_IO_16_PU_SLW_RT 1
+#define CONFIG_IO_16_PU_SLW_RT 0
 #define CONFIG_IO_16_RTRIM 1
 #define CONFIG_IO_16_WK_PU_EN 0
 #define CONFIG_IO_17_INPUT_BUF_EN 1
@@ -169,9 +169,9 @@
 #define CONFIG_IO_5_WK_PU_EN 0
 #define CONFIG_IO_6_INPUT_BUF_EN 0
 #define CONFIG_IO_6_PD_DRV_STRG 10
-#define CONFIG_IO_6_PD_SLW_RT 1
+#define CONFIG_IO_6_PD_SLW_RT 0
 #define CONFIG_IO_6_PU_DRV_STRG 8
-#define CONFIG_IO_6_PU_SLW_RT 1
+#define CONFIG_IO_6_PU_SLW_RT 0
 #define CONFIG_IO_6_RTRIM 1
 #define CONFIG_IO_6_WK_PU_EN 0
 #define CONFIG_IO_7_INPUT_BUF_EN 1
@@ -213,7 +213,7 @@
 #define PINMUX_DEDICATED_IO_9_SEL 8
 #define PINMUX_I2C0_USEFPGA_SEL 1
 #define PINMUX_I2C1_USEFPGA_SEL 0
-#define PINMUX_I2CEMAC0_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC0_USEFPGA_SEL 1
 #define PINMUX_I2CEMAC1_USEFPGA_SEL 0
 #define PINMUX_I2CEMAC2_USEFPGA_SEL 0
 #define PINMUX_NAND_USEFPGA_SEL 0
@@ -283,10 +283,10 @@
 /* Bridge Configuration */
 #define F2H_AXI_SLAVE 1
 #define F2SDRAM0_AXI_SLAVE 1
-#define F2SDRAM1_AXI_SLAVE 1
+#define F2SDRAM1_AXI_SLAVE 0
 #define F2SDRAM2_AXI_SLAVE 1
 #define H2F_AXI_MASTER 1
-#define LWH2F_AXI_MASTER 1
+#define LWH2F_AXI_MASTER 0
=20
 /* Voltage Select for Config IO */
 #define CONFIG_IO_BANK_VSEL \
--=20
2.43.0.472.g3155946c3a-goog

