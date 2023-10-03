Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAD8E75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B6F8744C;
	Tue,  3 Oct 2023 08:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gFRGcXgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9028726B; Tue,  3 Oct 2023 08:37:02 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA4387236
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50481a0eee7so4823677e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315019; x=1696919819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkSynOGWPqBWY/Jr3KDbDKbN2rDKko8pZ38Gh5RHUEA=;
 b=gFRGcXgMCX+NjmRobCNQyJ/0PLCta/WOTlnfpShDHzfwGTMLwcFqMvpbKHerbHZiiS
 L+sTIZDqakJRX736RRS/8R8nEsTix2prv3e/QTp3dkXkW7VRrzZExKS9eqoHTRlqYizc
 4z9ML/lD5+SgDzSVI6Zb+GVp46yiDIBc782Jg6xd28Rb5NQmVUPBNHXsVMOYF/TSfqa3
 AhrQo6MXiPcshAqDS4krFBUmEMxSzfeG1HegMVCFZkBNAuamVWOEouuUnxrhu0SMOxqZ
 17PFgRXTE5qQS8X2ayWLi1V/4ygDbRwC2/tBdLcUkzPXkXL7ggA2zNqPrWuUqqc7geqS
 dR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315019; x=1696919819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkSynOGWPqBWY/Jr3KDbDKbN2rDKko8pZ38Gh5RHUEA=;
 b=rLxGiLGjmX9O36FC2Zw+nIsstJkWWL28/Uc0mMl9oSOIJ5YQlX3XGcQLxFPzscDOmH
 b7++Mj6sZKBQsUt7YxarKJivmgWjsijyEcW8X+cQU1gkBLWnmSkv32IhbnzVWiXRYEug
 vukAzofOb6JoBil/g22twlSnQBYIbPP8+EQmjgrwMiE6y0vO424aZ4LmHNncBNQScfCI
 O2e7EI+QQwbX14F1QDGadShwueltdarMQLSDZukYdDm7RrCAKsn5WIK5tmyMEyBOJMIe
 ikPmAdwzoznQnzCj6awJP95TGlTJXkPOecy2bdgeo96Deti/f57XJClteJpNYFWBncDN
 gE2w==
X-Gm-Message-State: AOJu0YxHU23BDv7IUZV4CVmV0cZo1e09VGzpz73zF5uk3WbtzUbueoKM
 wNg51m/lLF4f2P9KT7Mju+XM7soOtR0=
X-Google-Smtp-Source: AGHT+IFT8FpxK0+lgRObkcMcZUuvLA+N5dYSDxoV8yJ9KmlSrxXPUyXsbVCzbQ/MQpDpzqv5NCG6rQ==
X-Received: by 2002:a19:f805:0:b0:503:2941:3a14 with SMTP id
 a5-20020a19f805000000b0050329413a14mr1391781lff.27.1696315019579; 
 Mon, 02 Oct 2023 23:36:59 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:36:59 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 05/16] board: asus: transformer-t30: remove PMIC GPIOs
 configuration
Date: Tue,  3 Oct 2023 09:36:36 +0300
Message-Id: <20231003063647.42770-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Default configuration matches values which are set in the board
so this configuration is not required.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/asus/transformer-t30/transformer-t30.c | 25 --------------------
 1 file changed, 25 deletions(-)

diff --git a/board/asus/transformer-t30/transformer-t30.c b/board/asus/transformer-t30/transformer-t30.c
index b6fd19d28e..5c1bac004f 100644
--- a/board/asus/transformer-t30/transformer-t30.c
+++ b/board/asus/transformer-t30/transformer-t30.c
@@ -33,11 +33,6 @@
 #define TPS65911_LDO5			0x32
 #define TPS65911_LDO6			0x35
 
-#define TPS65911_GPIO0			0x60
-#define TPS65911_GPIO6			0x66
-#define TPS65911_GPIO7			0x67
-#define TPS65911_GPIO8			0x68
-
 #define TPS65911_DEVCTRL		0x3F
 #define   DEVCTRL_PWR_OFF_MASK		BIT(7)
 #define   DEVCTRL_DEV_ON_MASK		BIT(2)
@@ -146,26 +141,6 @@ static void tps65911_voltage_init(void)
 		if (ret)
 			log_debug("vddio_usd set failed: %d\n", ret);
 	}
-
-	/* TPS659110: GPIO0_REG output high to VDD_5V0_SBY */
-	ret = dm_i2c_reg_write(dev, TPS65911_GPIO0, 0x07);
-	if (ret)
-		log_debug("vdd_5v0_sby set failed: %d\n", ret);
-
-	/* TPS659110: GPIO6_REG output high to VDD_3V3_SYS */
-	ret = dm_i2c_reg_write(dev, TPS65911_GPIO6, 0x07);
-	if (ret)
-		log_debug("vdd_3v3_sys set failed: %d\n", ret);
-
-	/* TPS659110: GPIO7_REG output high to VDD_1V5_DDR */
-	ret = dm_i2c_reg_write(dev, TPS65911_GPIO7, 0x07);
-	if (ret)
-		log_debug("vdd_1v5_ddr set failed: %d\n", ret);
-
-	/* TPS659110: GPIO8_REG pull_down output high to VDD_5V0_SYS */
-	ret = dm_i2c_reg_write(dev, TPS65911_GPIO8, 0x0f);
-	if (ret)
-		log_debug("vdd_5v0_sys set failed: %d\n", ret);
 }
 
 /*
-- 
2.39.2

