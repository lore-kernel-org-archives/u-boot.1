Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CACC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5DA81DB4;
	Fri, 28 Mar 2025 16:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UxegJmIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A1581EBB; Fri, 28 Mar 2025 16:35:53 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE5F81ED8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8dfso68527139f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176149; x=1743780949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDZYbCANs+oDTwPhSeiewF+MloaTA7lZ++Gou2LVcMs=;
 b=UxegJmIGudvOixYHZ8Ogzd1WoIrVCDw9vZdJ/6PZp9Togk+nr8F+XiClI4yTMWxUMd
 zBCrohvg6uaMR6CderQyZhjPPMzq7XPGH9xdRQLRv8Myd0KoKk3QbG+jBZMuiIwLVpKt
 ULQhXV5ve/DZVk1n0s2dqr+pBkzd+ukwBShVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176149; x=1743780949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDZYbCANs+oDTwPhSeiewF+MloaTA7lZ++Gou2LVcMs=;
 b=WBrk3iFu9/FXQG4a+cfwSIt/ZlWvweREx3O1AK2pltwg4St1PUZh2aPpAvbnoqYuJ5
 MR/6ZKoWWn2Ynh7aLPobFsZMq1lSWtjTYjOL3CIRo0/fB1pPi7qqXIrCGMfwxjTx5UJp
 BkjReEiPUztSFBK1C1g4IymoNkEk90WLXCimNlf3UspQpEnHQt4VfdJFZjdRjqDIuGS/
 aZKE1QwUMGrTDfSW+QaT2w4Ox3JeOUMZ4sdq8nfysMZPXOpzr/D4oD/prWr+L98LEot9
 1IA5A7LvZXPRqHpCoGj3PReht3Kv7qdx7+5m1V10mAyTK96pZ/01w/ifDLFO56xGZPD/
 cHYw==
X-Gm-Message-State: AOJu0YyY2KN0FOsr5D1OO6oBV0u0wgX67fyI7V5N9RWownAaRNtxibZt
 4e1IPv+5IshIyafp3/Icznm5WWhO1cl+HQM5RpORdT5de+af+q16YewbLxomRbdhUBZDbFxR3Lk
 =
X-Gm-Gg: ASbGncscnKjOg7zD1xw0rqczszJkt2HXgEJAqwrEgwE/2tNzz9GmzqIfsh10zeCBF3K
 y2lShswuOyxxMUCkTC8EOYTRgX6Nqy8KGQOxfMGXnydksqD1Ouep9/uOpSukM1FQQ2Ieh3g09Ku
 3+ElO8XBZK62jIxqt5RvrBIUlQDvih8FABHazgxys1ry4XDKyU18G0xOIOqRa2eSELQYTbTQeaC
 +vNBjPYRzIiB15NGyBBSmoFN1XfmcfO19HOgbB5GcRsk8+zwdp1VfoE3+X9WJ6hNNqSJ48W/FGc
 57q3WTu+cv/vO/mQ1xlSTXChtmxMP2rhMkoFS2gp1uD2w2extFZOzdO0ZccoTZ+hy7nYm8SiWe+
 OaZc6tw==
X-Google-Smtp-Source: AGHT+IGVTorOYx9iOt8U54/Xv8yYALaMsMG88LFuGhXB0blovaQM+ZkUslECrahUxs+VKsdW813NsA==
X-Received: by 2002:a05:6602:408c:b0:85b:5869:b66 with SMTP id
 ca18e2360f4ac-85e8200a4d4mr1007665239f.1.1743176148901; 
 Fri, 28 Mar 2025 08:35:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:35:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 04/31] rockchip: Allow RAM init to happen in SPL on rk3399
Date: Fri, 28 Mar 2025 09:34:44 -0600
Message-ID: <20250328153522.3555472-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

