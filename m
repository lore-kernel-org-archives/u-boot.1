Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4E4C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 12:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE2D8874D;
	Thu,  1 Aug 2024 14:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GrZ/YbsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B9688A6D; Thu,  1 Aug 2024 14:48:00 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E14886F0
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 14:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39aebcdee9aso21342015ab.3
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722516477; x=1723121277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fe9popL7aFiOIStHqHo3MaI9bFhWkA3rmZ/NRrtPJz4=;
 b=GrZ/YbsGGcZ7Y9ToiV7LhMlNL857f6aUGqMYeAlpbTQfLpYfnlS0ClCL380Sgr2ON2
 uwKlbzfcqhLe+iEffHBEdVpnFEPlcdPg2fe1hSW2GxkqVdEuPpllcYY26fUgRpub5uBB
 K4PCTePdOoeaRmuK6JyUdfxxM8jygGZFbUpjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722516477; x=1723121277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fe9popL7aFiOIStHqHo3MaI9bFhWkA3rmZ/NRrtPJz4=;
 b=Lui4Lg82cUbvm7nWIaMZdoPtl3VilNF3eU1AjfNzqunQP9sQ9BAVi5RNlpRs08lRa/
 ab+gGI6+O8LPE/NFKf8WP8nBtzJaO2WDrJhOR8UPmtYWBGuTkfKzpNNqim1jQH/6qqeA
 GPJUMozrQZqm+THuesjjLFSGElSGfgKaRlYH5hbFhNMQtFWq+TnJp3jccMYq5kMm/OhL
 BhVdtH5PXto1znupE1Tm5zTdmON6WYcRZR71kbLFbnKAvySMjq6gdmqdNZlXQskMmYK3
 AF2dzU6xgfguB2KvcF+JVw3jKbbHDRpItkaChY8yy51pNhfPMX8WATnBKjdd9La8eMzr
 r+vQ==
X-Gm-Message-State: AOJu0YxMcFBUgmJerczo6tY9BH4tMs52x/fneMqNL9IYpLnTbUITxcOW
 fAsdTC4QuvjtZbCbODHdr14BzykDtzkeBsJjaws7kjJK1XVwCJMKATOfV8vR3oEK1yDujluQzqg
 =
X-Google-Smtp-Source: AGHT+IHiAJPXv+wysmGiY4Vi24wVhr3dt8hhRtomMHagd8UALNobx9Uis0FyJpSCz4f7O8wLLNl82A==
X-Received: by 2002:a92:cf42:0:b0:398:b998:fa54 with SMTP id
 e9e14a558f8ab-39b1fb9bb46mr553895ab.12.1722516476704; 
 Thu, 01 Aug 2024 05:47:56 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm48720935ab.50.2024.08.01.05.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 05:47:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v9 7/8] rockchip: Ensure memory size is available in RK3399 SPL
Date: Thu,  1 Aug 2024 06:47:22 -0600
Message-Id: <20240801124723.770213-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

At present gd->ram_size is 0 in SPL, meaning that it is not possible to
enable the cache. Correct this by always populating the RAM size
correctly.

This increases code size by about 500 bytes in SPL, since it must call
the rather large rockchip_sdram_size() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v9:
- Avoid adding rockchip_sdram_size() to TPL even when RAM is inited

Changes in v3:
- Cut the patch down to bare bones

Changes in v2:
- Add new patch to correct memory size in SPL

 drivers/ram/rockchip/sdram_rk3399.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index ef9a1824b2b..58f3745ffa5 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -3142,19 +3142,25 @@ static int rk3399_dmc_init(struct udevice *dev)
 
 static int rk3399_dmc_probe(struct udevice *dev)
 {
+	struct dram_info *priv = dev_get_priv(dev);
+
 #if defined(CONFIG_TPL_BUILD) || \
 	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 	if (rk3399_dmc_init(dev))
 		return 0;
-#else
-	struct dram_info *priv = dev_get_priv(dev);
-
-	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
-	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
-	priv->info.base = CFG_SYS_SDRAM_BASE;
-	priv->info.size =
-		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
 #endif
+	/*
+	 * There is no point in checking the SDRAM size in TPL as it is not
+	 * used, so avoid the code size increment.
+	 */
+	if (!IS_ENABLED(CONFIG_TPL_BUILD)) {
+		priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
+		debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
+		priv->info.base = CFG_SYS_SDRAM_BASE;
+		priv->info.size = rockchip_sdram_size(
+			(phys_addr_t)&priv->pmugrf->os_reg2);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

