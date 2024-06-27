Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35944C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D6D88599;
	Thu, 27 Jun 2024 11:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q9kBWTsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437CA8855C; Thu, 27 Jun 2024 11:19:39 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9FB88247
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-364cdfdaf91so5409902f8f.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719479977; x=1720084777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7l6MRzsmRbZLn3yhrkgcqlQ74+cI72j0xlnribpc3wU=;
 b=Q9kBWTsad3SwAA0hyI6JczIEFT7O9w3gfiCBJRni+NvBHL96jhYzlIKCoQZGm6znEq
 /9RNNZjs+oyaGkGy+quAhSpRVcUVy5BGl6FUBZV5MztUzzkjaClpgZlSDCr1YDETLwYJ
 ZCxBFQSUYKN41lnjpx8ELSOc3DTeIfbIQpKyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719479977; x=1720084777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7l6MRzsmRbZLn3yhrkgcqlQ74+cI72j0xlnribpc3wU=;
 b=bKz9JhFLBAYtdG03DoKAWlcpNme8/j1PSsXNTQGPX8I3XXuXKL98GeC1teJfZ/LI+i
 HMBH7gNvKR6f0IP7+GYa89bjnkMucOOCU2JttPZU/gE5ETF/QWAlQ5dU8IJ7OaFYHfi5
 LYS1gcaBYeE+vR/Hx/8prAw9MXRCAsBKF5hVWGVeErPoPdTK8ORAh6mLSaEX+en0Y9Z1
 MAI9RJtuFGx+LvUOnnEacQQATLkKZahYCqvas2zq7QyzGNX+3jKssCbOBMmvJVmrgdas
 /jQ/spb2ODrBLWP0Mk67edhhA3l1hfGdKw02eWiEBcTMXrlUdUu0MEk+h62HPzZXyUoI
 1lcA==
X-Gm-Message-State: AOJu0YwQ90jZDiK5+6y9GV/epWC/K/RwtFxPDRppUB5McWaqPYQ6Nbhw
 aJbMgZdCi3PGUpEMQ9Po8UCMnMy5b7TCQIazVBjrC/J7/+xnYUQk1JAH0wss2jlpjnJmUcvp8Af
 vog==
X-Google-Smtp-Source: AGHT+IER/XJovSxZsB50G92UisFlD+Xe6UjicYwyOgTB6yUbS3F6fF5EjdLjWJmk+7wGJzpz4YXZDA==
X-Received: by 2002:adf:f3cd:0:b0:364:e963:bd1a with SMTP id
 ffacd0b85a97d-366e96c0d75mr7917889f8f.65.1719479976702; 
 Thu, 27 Jun 2024 02:19:36 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436a28f7sm1199818f8f.117.2024.06.27.02.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 02:19:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v6 7/8] rockchip: Ensure memory size is available in RK3399 SPL
Date: Thu, 27 Jun 2024 10:19:25 +0100
Message-Id: <20240627091926.374633-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627091926.374633-1-sjg@chromium.org>
References: <20240627091926.374633-1-sjg@chromium.org>
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
index ef9a1824b2b..bc79c034808 100644
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

