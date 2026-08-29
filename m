Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96161C61DE2
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 22:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2C3C80E7F;
	Sat, 29 Aug 2026 22:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXLDdVeGbqKz; Sat, 29 Aug 2026 22:45:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788043499;
	bh=eIHQyVIZFK8YKkBWW1Y4zH+gZv7punB1oyj695FbVf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rTH4a1kndHy9rdG9rkkLXDemtlFedKvpZTEbYCgeQ5UnOYZXWadG7LZr6IN+DkSDc
	 N+ppPGg1ttjO2f+MaaWzKnPivmTqzb7DLOaj8kWGF6bSmOU12SjPaN2nOqpCuj/yE8
	 HeuKhI0XtyIL74okVsRQuHWVEgvPp8w2wh6v1HsJG6jtAkyoX5PtZYcgouTfmuPY78
	 nFZx3AwC4lgkA+0TrNrv8ywLsXXSpUO1wSSAwakm/u45sDFbvgKBbl0ZBXnVNhW1XP
	 klKcK6706/sSW0ydUxaP0SYbEL62Sd6MdJnjGFaQyO3aG6lgWZvHr2fD5IpDQO9yKk
	 33QoYaV7igwyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E19F80E86;
	Sat, 29 Aug 2026 22:44:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EBD26355
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 17:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D24E840068
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 17:03:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oiHAQUjOJAKJ for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 17:03:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cde8tK50
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A59D140052
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 17:03:33 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48431648f33so314264f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788023011; x=1788627811;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eIHQyVIZFK8YKkBWW1Y4zH+gZv7punB1oyj695FbVf8=;
 b=cde8tK509bK8uj0UN5dej4q4ZutuyX3nGykUYa3QNNJvQfe8ExaZnY0IBq8C+foAvH
 7EA7Uai98ZFDaj+I5uZ4dROcoUzG6xQ9XWJCjtcT05OHrMojfNSGTItBEaKuWldNyt1U
 s+2m7HphOkSjwO1fMlJjzyjL++pcPhHHsik6QwYry5NmvzG9dQcL01g0nPLml2kIph/C
 95i8N34soJ0WLBHtRYHxL4z6lnpG6tXXbuvctxB8yQE5NRzhgtR0Jt8yZLYxxOdso+LK
 4BSZSea9Lbq1ntL8iVKg0SgR7Ampz8BGynyv7sGBeuT0+0DaqIX6bGyOyXfF+OjG0zm9
 oouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788023011; x=1788627811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eIHQyVIZFK8YKkBWW1Y4zH+gZv7punB1oyj695FbVf8=;
 b=Iq8DfvoRHNZhKmNVhvMsMazpryItQ6fxyh597LlRHKENNfEMCn1mM7MQ09uUUTDriK
 oPEXHDRaGbwKJPco/h6B3fbFQvkw/DB64O3NNZxIybNlRfmYS+hTeT9kb5AvKmo7uu6c
 SjPnJUX/qp1Tup45qxBDJLxHBzbsPeRjwpBJI2M0kjOikNfCNlpKbbzgfQcyyAQYOHY4
 F4+Cfe58O5AHgi0pjaLocp354slBVwQhTRl53xxE2DGBXRd5fDPlLDeVccPXNxs5PknK
 7ckcFwoMR5kASVpxQJ8I2umQvFa/wmFLTIUGlaC6vioQEKbd1D4CBCa8JK1vCCkFDAA9
 t+Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3CSBGuFzBml1IkO7c4ec4ugpMkNsAV9oFXZsECnJ6hJtpguCVKZGNH4vrtzkN0IbI1EYxsDQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lhIogCUQHKXAKmy5e4GyNE4gAIVwO+IT5pWynDp+Mz4vnIiDhO
 w7UcGtW35Aq55X4Zsqm0kZLNJBBMX3+1eFPuQxK3Vo3bH2yxLRatlDDKpuDxMg==
X-Gm-Gg: AR+sD10LY+CEbLbLYZF5+c1WO5502/9MPazdeOa5LPgtXGVgcV1miGU+E3sVa1FPhAy
 aJ0booaHYIEft96bj8a3VQiK8rQ5fOvCIX5ryoq+go4mlPHBq81fNBbduTf8RqC+FhQ/fcC3Jds
 kfIkXLiB2DQuc9yc2Frg1rlVl0aRILTh94iFmp6uXoXe/DB1JcwplFQTuH/mCt0VPooR8qC+h2m
 FZKXaESK95zZ5Jm3/5Ce5pRTEtjmMpH5a6RL3a41tNu7xkiCpMVvTmcMN/Tn9P1reQc58xTc/UV
 AMnCcR44/XMHC6f5p/FwQbERjXb2MTEH5nAe/Fs64oh8eMIuRdYotD7rreYYuGO976rHJJeODM8
 v5KAFA7HQHoMVJiNmIptDbFRTuwElSY3ddLejF262RLWTSMYroULukQkjVQBkfN2xq19ZaXOKfA
 m5/+T5OkKkHvarJj4PvSOqDUFSUEBC/RLOil2rNG6kmjgipoYHj1teHx8xUCJADGVb+2A9L8g=
X-Received: by 2002:a05:600c:55d6:b0:49b:914a:94a2 with SMTP id
 5b1f17b1804b1-49b914a960emr175204225e9.1.1788023011148; 
 Sat, 29 Aug 2026 10:03:31 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.168.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb32ce2sm12163133f8f.33.2026.08.29.10.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 10:03:30 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 29 Aug 2026 19:03:12 +0200
Subject: [PATCH 2/2] ram: rockchip: px30: allow multiple DDR types
 selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-ddr-multi-v1-2-c0c7837aed20@gmail.com>
References: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
In-Reply-To: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 29 Aug 2026 22:44:54 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Allow the inclusion of more than one DDR parameters set in the PX30
SDRAM driver. The driver applies included sets in a predefined order
(DDR4, LPDDR2, LPDDR3, DDR3), stopping at the first one that makes
SDRAM initialization function to complete with success.

The default fallback behaviour is preserved: if no DDR configuration
option is selected, DDR3 parameters set is included.

Due to limited PX30 TPL maximum size, including support for more than
one DDR type requires disabling some configuration options such as
CONFIG_RAM_ROCKCHIP_DEBUG.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/Kconfig      | 67 +++++++++++++++++++++++++++++++--------
 drivers/ram/rockchip/sdram_px30.c | 35 ++++++++++++--------
 2 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index 61a3193b3f5..d74980402ad 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -24,38 +24,77 @@ config RAM_ROCKCHIP_DEBUG
 	  This is an option for developers to understand the ram drivers
 	  initialization, configurations and etc.
 
+config RAM_ROCKCHIP_DDR3
+	bool "DDR3 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30
+	help
+	  Enable DDR3 sdram support on Rockchip SoCs.
+
+	  Note that enabling support for multiple DDR/LPDDR types may cause TPL
+	  to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
+	  other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
+
+	  The driver applies selected sdram parameters sets in the following
+	  order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
+	  sdram_init_detect() to complete successfully.
+
+	  If no DDR/LPDDR option is selected, DDR3 sdram support is enabled by
+	  default for backward compatibility with existing board configurations.
+	  Therefore this option is only useful for multiple DDR/LPDDR types
+	  selection.
+
 config RAM_ROCKCHIP_DDR4
 	bool "DDR4 support for Rockchip SoCs"
-	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
+	depends on ROCKCHIP_PX30
 	help
-	  This enables DDR4 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable DDR4 sdram support on Rockchip SoCs.
 
-	  Note that even if multiple DDR/LPDDR types are selected, support is
-	  enabled only for the selected one that comes first in the following
-	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
+	  Note that enabling support for multiple DDR/LPDDR types may cause TPL
+	  to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
+	  other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
+
+	  The driver applies selected sdram parameters sets in the following
+	  order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
+	  sdram_init_detect() to complete successfully.
 
 config RAM_ROCKCHIP_LPDDR2
 	bool "LPDDR2 support for Rockchip SoCs"
 	depends on ROCKCHIP_PX30
 	help
-	  This enables LPDDR2 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable LPDDR2 sdram support on Rockchip SoCs.
 
-	  Note that even if multiple DDR/LPDDR types are selected, support is
-	  enabled only for the selected one that comes first in the following
-	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
+	  Note that enabling support for multiple DDR/LPDDR types may cause TPL
+	  to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
+	  other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
+
+	  The driver applies selected sdram parameters sets in the following
+	  order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
+	  sdram_init_detect() to complete successfully.
 
 config RAM_ROCKCHIP_LPDDR3
 	bool "LPDDR3 support for Rockchip SoCs"
 	depends on ROCKCHIP_PX30
 	help
-	  This enables LPDDR3 sdram support instead of the default DDR3 support
+	  Enable LPDDR3 sdram support on Rockchip SoCs.
+
+	  Note that enabling support for multiple DDR/LPDDR types may cause TPL
+	  to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
+	  other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
+
+	  The driver applies selected sdram parameters sets in the following
+	  order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
+	  sdram_init_detect() to complete successfully.
+
+config RAM_ROCKCHIP_DDR4
+	bool "DDR4 support for Rockchip SoCs"
+	depends on ROCKCHIP_RV1126
+	help
+	  This enables DDR4 sdram support instead of the default DDR3 support
 	  on Rockchip SoCs.
 
 	  Note that even if multiple DDR/LPDDR types are selected, support is
 	  enabled only for the selected one that comes first in the following
-	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
+	  list: LPDDR4, DDR4, DDR3.
 
 config RAM_ROCKCHIP_LPDDR4
 	depends on ROCKCHIP_RV1126
@@ -66,7 +105,7 @@ config RAM_ROCKCHIP_LPDDR4
 
 	  Note that even if multiple DDR/LPDDR types are selected, support is
 	  enabled only for the selected one that comes first in the following
-	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
+	  list: LPDDR4, DDR4, DDR3.
 
 config RAM_ROCKCHIP_LPDDR4
 	bool "LPDDR4 support for Rockchip SoCs"
diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index 37e62120504..ac9f5827d1d 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -126,11 +126,17 @@ struct dram_info dram_info;
 struct px30_sdram_params sdram_configs[] = {
 #if defined(CONFIG_RAM_ROCKCHIP_DDR4)
 #include	"sdram-px30-ddr4-detect-333.inc"
-#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
+#endif
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
 #include	"sdram-px30-lpddr2-detect-333.inc"
-#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
+#endif
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
 #include	"sdram-px30-lpddr3-detect-333.inc"
-#else
+#endif
+#if defined(CONFIG_RAM_ROCKCHIP_DDR3) ||         \
+	(!defined(CONFIG_RAM_ROCKCHIP_DDR4) &&   \
+	 !defined(CONFIG_RAM_ROCKCHIP_LPDDR2) && \
+	 !defined(CONFIG_RAM_ROCKCHIP_LPDDR3))
 #include	"sdram-px30-ddr3-detect-333.inc"
 #endif
 };
@@ -682,19 +688,11 @@ out:
 	return ret;
 }
 
-struct px30_sdram_params
-		*get_default_sdram_config(void)
-{
-	sdram_configs[0].skew = &skew;
-
-	return &sdram_configs[0];
-}
-
 /* return: 0 = success, other = fail */
 int sdram_init(void)
 {
 	struct px30_sdram_params *sdram_params;
-	int ret = 0;
+	int ret, i = 0;
 
 	dram_info.phy = (void *)DDR_PHY_BASE_ADDR;
 	dram_info.pctl = (void *)DDRC_BASE_ADDR;
@@ -704,12 +702,21 @@ int sdram_init(void)
 	dram_info.ddr_grf = (void *)DDR_GRF_BASE_ADDR;
 	dram_info.pmugrf = (void *)PMUGRF_BASE_ADDR;
 
-	sdram_params = get_default_sdram_config();
-	ret = sdram_init_detect(&dram_info, sdram_params);
+	do {
+		sdram_configs[i].skew = &skew;
+		sdram_params = &sdram_configs[i];
+		ret = sdram_init_detect(&dram_info, sdram_params);
+	} while (ret && ++i < ARRAY_SIZE(sdram_configs));
 
 	if (ret)
 		goto error;
 
+	if (ARRAY_SIZE(sdram_configs) > 1) {
+		printascii("Applied sdram config: ");
+		printdec(i);
+		printascii("\n");
+	}
+
 	sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
 
 	printascii("out\n");

-- 
2.34.1

