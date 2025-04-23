Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AB4C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 16:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B021805D7;
	Wed, 23 Apr 2025 18:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQSeo1m5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7438D80944; Wed, 23 Apr 2025 16:50:10 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2872C8059D
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224019ad9edso92385615ad.1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745419806; x=1746024606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MX1CGOIS64lLSJLwuwZWSUotudXFozbp9mWWugEJofA=;
 b=aQSeo1m5PAO0k4Gm2OZEwKS/Vokv6KORGiZt2BWnF++9ElZPu9mjBdEqf6liywsasu
 LAjz8csH3CrBKyvRd9O+WwJvxjFL+0bvgk9tRImyG/clBxAmG6OvmkE1ehjLuWrgHv9y
 PMR5UOHpsZd/mt1QGWGIjkEkLousJBZ1+V8jlI2Y5Vm2dfdVj8xfu0qehxd3VmepN+bD
 gW4idO3JfGvQLnVJvrMuQdoJKvEH+EQrBfQ3okd8ECLKrdyGsEpARhTCSinn7YxZDrdP
 r5u23yU3NwjjVMgL4V8j1yV5cBDOGBQbmRk1Ug8iqLQ8B0oEdgPG3zUYW7jsE8VBLt7R
 J2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745419806; x=1746024606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MX1CGOIS64lLSJLwuwZWSUotudXFozbp9mWWugEJofA=;
 b=FY2DpKBVuk1rPmi/L+1mrRPlGog1jPdCni+IAfPu/G7TtAZYJSL1lVG7Iw0jeW7atU
 3mqAyeIYsoykrdkT3yQHWqGh0sUxtn6SR/FoV/TlnIJtznW90r9KTLRK237NT2V1RyQS
 2dCwuw6wJEaK/ZZmm2BZhZFwuWcJRJgi/EsxDI2ejhpPSdydbpNVx1Grhrz/268KN5wr
 WSCYDc0LMJjVY9uPtaBzIp728EiR3h6tivbwB1tk9AY5cmTPocuKTAvQ80BTm3X7pGN/
 t3iCyqT9Gos0ylCx9Ll1kT95y3kZxvnewO7E38hAppjBTsReQ6pO1oDxPMvZlQQAqtG/
 1mTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9uUE5t7dsAoneA3VkEx5P63l7cvI5emNLCmeyBhDl4AQl5dpx9ASOYiFyKVmTwW8rsGOw0m0=@lists.denx.de
X-Gm-Message-State: AOJu0YzpQwwt1t7RjP25VieI3Ag5Vi4vLnjPIzCONyovwb/s0P8G41Lc
 KqMJJTdU/Dv+mhstujlGtWxXHHjmFJK1Rpfx1sXJBNrBYzR7Eha4
X-Gm-Gg: ASbGncuMQT5XywVLAp5rnKhugapTx9tmc05q3hErDUE9gRmSJJi+VXCo3KJdoYQb3r9
 /qxRBUlHFMTIyrlaLvJWzqTiZup4Mm3+ccuGWtEWyHCsTzIHBbx3Fd46r8J+ad7eJMA7WOV76yq
 88ddvjpAxl9UZmz80+V6GgNaBncEqtzF5VidNWj8/Vld1w7LKz0+bxFAhm/hSQ8pDf7nL5hTU52
 yBzSpPl9o8hgzXuXmMroGW9oBg1vm1dhB5DCt7AuEOkfa7c3hfSm1o7kuAaMsJW3BywIvAizU1Z
 plfvXszvFjPzmGM90S+umTH78CQ2bLnAJ4sQX9lLfADI6Ru6m43zuE5O2h307Ry4cDSLorrQKwC
 bC2avtpR47FYi/pVyryDjDe/a49nAV95sxWKKcNIcHzZ9E9c=
X-Google-Smtp-Source: AGHT+IG2rBeM4zHBBXbo3ZIpen+VYxiV9RL6b2D8uN+etiZfBjuRMFfr2eZ05pGB2fKU8fEBhUPsLg==
X-Received: by 2002:a17:902:c40f:b0:224:10a2:cad5 with SMTP id
 d9443c01a7336-22c5357a132mr307102635ad.10.1745419806336; 
 Wed, 23 Apr 2025 07:50:06 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdbad2sm105470005ad.226.2025.04.23.07.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 07:50:06 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, lucienzx159@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com
Subject: [U-Boot, v1,
 1/1] net: phy: air_en8811h: Configure the en8811h fw size as a fixed
 setting
Date: Wed, 23 Apr 2025 22:49:19 +0800
Message-Id: <20250423144919.9319-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Apr 2025 18:07:28 +0200
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

Given that the EN8811H FW has a fixed size,
exposing it via Kconfig is unnecessary

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 drivers/net/phy/Kconfig       | 10 ----------
 drivers/net/phy/air_en8811h.c | 12 ++++++------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 5b4cf30b0a3..db38b7e90ec 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -103,16 +103,6 @@ config AIROHA_FW_ADDR
 	depends on PHY_AIROHA_EN8811H
 	default 0x0

-config AIROHA_MD32_DM_SIZE
-	hex "Airoha Firmware MD32 DM Size"
-	depends on PHY_AIROHA_EN8811H
-	default 0x4000
-
-config AIROHA_MD32_DSP_SIZE
-	hex "Airoha Firmware MD32 DSP Size"
-	depends on PHY_AIROHA_EN8811H
-	default 0x20000
-
 menuconfig PHY_AQUANTIA
 	bool "Aquantia Ethernet PHYs support"
 	select PHY_GIGE
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 96bb24418a0..0e11f68a52c 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -443,12 +443,12 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	char *addr = NULL;
 	struct en8811h_priv *priv = phydev->priv;
 	int dev = CONFIG_SYS_MMC_ENV_DEV;
-	u32 cnt = (CONFIG_AIROHA_MD32_DM_SIZE +
-		   CONFIG_AIROHA_MD32_DSP_SIZE) / 512;
+	u32 cnt = (EN8811H_MD32_DM_SIZE +
+		   EN8811H_MD32_DSP_SIZE) / 512;
 	ulong airoha_fw_addr = (ulong)en8811h_get_fw_addr();
 	u32 blk = airoha_fw_addr / 512;

-	addr = malloc(CONFIG_AIROHA_MD32_DM_SIZE + CONFIG_AIROHA_MD32_DSP_SIZE);
+	addr = malloc(EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE);
 	if (!addr) {
 		puts("cannot allocated buffer for firmware.\n");
 		return -ENOMEM;
@@ -498,12 +498,12 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;

-	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, CONFIG_AIROHA_MD32_DM_SIZE, addr);
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, EN8811H_MD32_DM_SIZE, addr);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;

-	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, CONFIG_AIROHA_MD32_DSP_SIZE,
-			    addr + CONFIG_AIROHA_MD32_DM_SIZE);
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, EN8811H_MD32_DSP_SIZE,
+			    addr + EN8811H_MD32_DM_SIZE);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;

--
2.34.1

