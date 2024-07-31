Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59417C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92DE88A5D;
	Wed, 31 Jul 2024 16:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kVHJVxQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688C888A39; Wed, 31 Jul 2024 16:49:21 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D17D788A5D
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-395e9f2ebc0so33345035ab.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437357; x=1723042157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7l6MRzsmRbZLn3yhrkgcqlQ74+cI72j0xlnribpc3wU=;
 b=kVHJVxQnQYNx6p08KbVzjUYvqJ7ZR6QGyUW/wHnyVLnFjTOBIKBQOxiEFbemvDrSRD
 v/guitNJOVUmz7ljljcIAjXi8msK3Ll+Kt/3Ar3DXXqz1O2xSmPW1bLcFIN5pV+1UWqF
 DoQlM1oFepv8snCOo8PS4yj18iZTCWkxvzInM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437357; x=1723042157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7l6MRzsmRbZLn3yhrkgcqlQ74+cI72j0xlnribpc3wU=;
 b=oqsrkrRCS03i1eWrbcXeoqmeQDCGbZj+CSqC2x7dRzeA/Ug2NVk7NV0t2E8LtgiJpv
 70U1yfZN7m7CEwJSuMrsZftFT3Kw8SqhWxwvzVHdNyaDj0PtgHuaJt2WjUgw/5Gsx3vl
 WS6pQhFQeBMGkBy+FWAfSYqDTTgu+vFofMcz9yOdnqiADkE8KKCLN3oglLoBHxH2aEyn
 JPt5ajn3nYkUCgl0RinIzMq9ddjswrQnqxLNARawTmE84s7ZZZnJppPb1H2Qy6Y1DOr0
 +EiSaFqtvUgIxFiT/CSf8RTbPdKCAzxDrvar1WDijspbyNbW2fJqB3T60rro1nZ+Bm+b
 755Q==
X-Gm-Message-State: AOJu0Ywa6xDVWJemPDzHl050dCPRwq80ZtbjjiqLlhGlLxGgNw4A+YyH
 SHYJTIHpd3mKoYr4UJMaNaHKK6JH+C8fi5kNgs3FnNKyYXMd+xVY9gneyhkZKdxxKRrzixbo31g
 =
X-Google-Smtp-Source: AGHT+IG+tbFsy57vvRzGEJQduopWkCvvhNQ58DL978mw9FZ2j3AeGw6sPg7j2WwWEqI0fICR+HLNww==
X-Received: by 2002:a05:6e02:20ef:b0:379:40e0:b0b8 with SMTP id
 e9e14a558f8ab-39aec3fedd0mr154914955ab.20.1722437357444; 
 Wed, 31 Jul 2024 07:49:17 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm40671855ab.50.2024.07.31.07.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v7 7/8] rockchip: Ensure memory size is available in RK3399 SPL
Date: Wed, 31 Jul 2024 08:49:06 -0600
Message-Id: <20240731144908.795290-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144908.795290-1-sjg@chromium.org>
References: <20240731144908.795290-1-sjg@chromium.org>
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

