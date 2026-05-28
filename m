Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67401CD6E45
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421D8846E6;
	Thu, 28 May 2026 19:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JQu8DeEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08558341A; Thu, 28 May 2026 19:11:07 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C5AD846B4
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7df05fc49e5so12723992a34.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988264; x=1780593064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDZYbCANs+oDTwPhSeiewF+MloaTA7lZ++Gou2LVcMs=;
 b=JQu8DeEyZo6wroCgSNhmTm3kTYcFKkEUSc8UJJDMj8D7baQrsw3UjTkJSDOym38Nnm
 Jg193rRvAhzSLS3hYZ4VjVoRVVaptIxmzJuwAkiv51hWzSwOXIissvDXEh/6ZaIA1CTL
 YGxaad6X+3vkSrYmKxs6q561SMU41X1GlihPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988264; x=1780593064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WDZYbCANs+oDTwPhSeiewF+MloaTA7lZ++Gou2LVcMs=;
 b=YXsNqC9874/n2j7CX3C1Sq6IWVN0M4Q4Wq8o6QwLD2xai3EYramJQc1CiK6oJoBPF6
 uWcjveytlp//BZEU8yQEgA8q/zmiH5MUkpVSIHtb+B8kEPRUvu7WT6spUb6Y1CvgG3qr
 TVVOTUR9K5FrBmLp2/W3N1HrzMZ2FILAZs94XK0jkg+XDb2r+QO0vECfU4BOze+l3/7f
 5eZP6fEyMJcshctgugwPyrAZooUgC71caiIOA803eonilCh5aEamaYigdiwEyOyAdUx9
 zeZtW72uZcHIr8CVazsvVNgw2Xoudc7E+pEg8rRzDbbXnoVAPGkAkWrNs44MvIBuZHJ5
 ElTQ==
X-Gm-Message-State: AOJu0YyrD8y77YykWMIw84mCZcsL7Qst42bwzFndn9EgeJUr341g0CpY
 YUoyohTDfNCpfQRJBFqO8GHNq3aefkWpn/1NkSNcUoTKws+Elka6HvHmAH4Qeiym3GaFdaZnCoi
 4Akd2Y3vsDVU=
X-Gm-Gg: Acq92OGjcCmN0QimYLjHw3UQHvixsTMgZMV5v556DRIDXa7lUW+cxw6aad3Jh0do+bo
 LvCMGQ3/KntfpNC6RZXE9UEgyxS1kyRZ46/MblLRrhc7o61DaFG5XU18vQNlzkFCWo1g9qfyU/s
 XGe3DQ8bVgn5EK/aSOeGsgc/oNVWZq0zYg4NX5CkrvLElsCww3uTjHzkNNZ2PC7DRoczO74AK33
 HNJdOo0+nLL7aCDQP2Z8Zl2+J07mhI5O4JpRKsWdd7kaGuvnfauaZzx+21CtuApv7u7e71AWGxi
 YQH56ez7c+26K5L/x51XaiV8esYtcLGO9Qjc2AvM6pffhYBUONr5JgFSCOXx+lBTdxkNwJXlv2V
 pZTK6BYSuaGq+xlXr4LIju3SITCPYR/j8AX7Hp3jGMQkPgorWyi9Qs6aBH/OACh1gUMk/DZtXTt
 yfbLNA5D3np8/u5HoxC/gG2QVCNk/X
X-Received: by 2002:a05:6830:6418:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7e5fec7fb5cmr17966869a34.5.1779988263915; 
 Thu, 28 May 2026 10:11:03 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 04/22] rockchip: Allow RAM init to happen in SPL on rk3399
Date: Thu, 28 May 2026 11:10:11 -0600
Message-ID: <20260528171043.910264-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

TPL runs before VPL. The earliest updatable phase with VBE is SPL. We
want to be able to update the RAM-init code in the field.

So when VPL is being used, init the RAM later, in SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/ram/rockchip/sdram_rk3399.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 6fa8f268770..9ac16dfdc71 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -194,6 +194,7 @@ struct io_setting {
 static bool phase_sdram_init(void)
 {
 	return xpl_phase() == PHASE_TPL ||
+		(IS_ENABLED(CONFIG_VPL) && xpl_phase() == PHASE_SPL) ||
 		(!IS_ENABLED(CONFIG_TPL) &&
 		 !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
 		 !not_xpl());
@@ -3195,8 +3196,9 @@ U_BOOT_DRIVER(dmc_rk3399) = {
 	.of_to_plat = rk3399_dmc_of_to_plat,
 	.probe = rk3399_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+#if defined(CONFIG_VPL) && defined(CONFIG_SPL_BUILD) || \
+	!defined(CONFIG_VPL) && defined(CONFIG_TPL_BUILD) || \
+	!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD)
 	.plat_auto	= sizeof(struct rockchip_dmc_plat),
 #endif
 };
-- 
2.43.0

