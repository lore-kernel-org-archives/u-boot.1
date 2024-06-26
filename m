Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20F5C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB308857C;
	Wed, 26 Jun 2024 18:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZBF0IJIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC758884FC; Wed, 26 Jun 2024 18:00:20 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5F9884C7
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-424ad289949so8688545e9.2
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417618; x=1720022418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZnXyn6Jzq77UX2P2PeQLgXugpfuE0Zwk119HlDUNrM=;
 b=ZBF0IJILBbYYXlGC2wxoIRPGRiWZFYl5HtGABeV8zKbJlUPyLIyD6AjUNKu8gd9mnU
 dEDKTvMnlu+ZneeKuA8yLZIxYkatT6TplpUoPr4tGqmnyv5SkyuPImi6ZwAQ10k+MZS3
 smdO/b+i2uyvj5OVcFPBaJ60uJy+bZW8zpoyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417618; x=1720022418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZnXyn6Jzq77UX2P2PeQLgXugpfuE0Zwk119HlDUNrM=;
 b=PIYLfXpxDFHbQVFo0w6JBEpV6Gt6hd24s7FSDzvk8AFu01MkBpgCtDyOIJG33VevWK
 VImAsWFaaBnndqPxHF3M2rXFa8snXZXSVuHuRN7zxRX3AgoA/1RfjEI1mg3DvE8q115T
 xKGEHdp8esy44Oibifd5S9NwFXuP7GZTyOf2ai5I8X4FYyHq2R/x+P9U7cGKLk4IhGy0
 6N1ZFDuo8ro2Dm6dFWec9iw9il+E7UKqU6QAecQz6WZ9AuQxN/00sEpS3fZQTX/0tnEW
 T1LdHOJ1eDYSo3Svq2tMz+vNmJHCO5UVP606mZ3Fdb2NC4VsbhIf6mTq+SVCpfckCGiM
 woJg==
X-Gm-Message-State: AOJu0YxK0XGasNd3Wagz0KrpZl1nX9BtrKg3VGxlumK19ZkYH9jQFL72
 804GxbQzdQE4RuSGeV0/EW+FS6GdOkqtqDGPYTjq6KhKcPOPU7/4kgtDsvlDx8F6m+d10Mcg3TE
 FyQ==
X-Google-Smtp-Source: AGHT+IGSCEiFmNX76OZmN5vGzY3YCSrraqxMG6OJvL21Le/0vlfTb+i//TxAugatoFHIrOPg/dC2LA==
X-Received: by 2002:a05:600c:464f:b0:424:a312:908 with SMTP id
 5b1f17b1804b1-424a312098emr31382525e9.6.1719417617827; 
 Wed, 26 Jun 2024 09:00:17 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 13/16] rockchip: Ensure memory size is available in RK3399
 SPL
Date: Wed, 26 Jun 2024 16:59:42 +0100
Message-Id: <20240626155945.278640-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

(no changes since v3)

Changes in v3:
- Cut the patch down to bare bones

Changes in v2:
- Add new patch to correct memory size in SPL

 drivers/ram/rockchip/sdram_rk3399.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 02cc4a38cf0..3c4e20f4e80 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -3142,19 +3142,19 @@ static int rk3399_dmc_init(struct udevice *dev)
 
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
+#endif
 	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
 	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
 	priv->info.base = CFG_SYS_SDRAM_BASE;
 	priv->info.size =
 		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
-#endif
+
 	return 0;
 }
 
-- 
2.34.1

