Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B948EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020CD864BC;
	Tue, 22 Aug 2023 13:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cF/6rkMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E5F6864B5; Tue, 22 Aug 2023 13:22:48 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0AE886410
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52683da3f5cso5266382a12.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703365; x=1693308165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkSynOGWPqBWY/Jr3KDbDKbN2rDKko8pZ38Gh5RHUEA=;
 b=cF/6rkMePmkzH2zSinMnf/VOBHVd1eb7xE+odXiNBcsq86MslBGv0FG6WMzQcLWzBu
 7aM8BdNZ/sXyAQ11VBXnmT/C0fcioMpds5T3+Y2MBcNigYLsd2RSnksChCN598+7u28c
 FTkvUGAK/5vzsMKIU8L68k8xYSKiykBarFVAOn3+3kA5SdU4j3z0aL2b4F5FN6xZlquV
 GMSA88S787OCFDs7mp6WmBSI+4KPMyVzA8ouHeE5CMkqrer06yC/FI5zxoG0evNBi4dV
 3Nyid1XzaIdZy4TiXTF/Z+26vhif+4notjlChPFtGzA9SsjPvcPOfSiKn4GZVum4TFqW
 Lawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703365; x=1693308165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkSynOGWPqBWY/Jr3KDbDKbN2rDKko8pZ38Gh5RHUEA=;
 b=lxffynN5FI1llCHTn7cKqFF/mAJp6Y0s4SmHlYUDce70IRAU2NvHUyMInBAFz5KyMI
 FUmOOTb5M/21bGPCNx1rLWzwcWUfZCoRpo0RYCdfZjRBM4Hz5FBe+TpN6rMn3hYHkDYX
 uDsGSwgcBtHIl7krohszL7xN+nV2cQH4Kbq6qlOJ8XRn7iuCVDZjGsHYM6Fx0grCvDTF
 UVAgWx493NOgDE5ahntPnoa2DCKbBTMpBxRJkEjs4zzFcgG/tp7JZI3EzaNeljkfxT8y
 rBRV3VoHov5x1kB5iKdxOMlpt8maOoxOHBDZpeFad2Aun15IvnwE48GEdf7mgu2SivnO
 gVPA==
X-Gm-Message-State: AOJu0YyWxo+85xiPUQRpM4VEFJTqZCRLZpL9VHqzMRTP8qgkSCEEKzmI
 JM9QB1hTuOp4/9nWyu4JFGo=
X-Google-Smtp-Source: AGHT+IFohKV7KfNuxsSo+4GnSfg17Rqdb76+28dTwgGxdSPxUJFtemLfEBJCERGXYiiNRoHGTiDawQ==
X-Received: by 2002:a17:906:739c:b0:9a1:b85d:c95f with SMTP id
 f28-20020a170906739c00b009a1b85dc95fmr1488274ejl.58.1692703365415; 
 Tue, 22 Aug 2023 04:22:45 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 05/19] board: asus: transformer-t30: remove PMIC GPIOs
 configuration
Date: Tue, 22 Aug 2023 14:22:03 +0300
Message-Id: <20230822112217.4646-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

