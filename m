Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AF9C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC5E82B77;
	Sun, 25 May 2025 12:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cWYYqryd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1B5982CCE; Sun, 25 May 2025 12:48:16 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D1B82AA7
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442d146a1aaso16860475e9.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170094; x=1748774894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNgfw161dCItCFM25CvHTcw95xyOr5cAIYoy4bUX6/s=;
 b=cWYYqryd+NOAykS96pH92RzLzUiGyTth5a6ldXipT0BOVXpglDwd0G1Lwd4xF8T/vB
 5SK48KO4U+NJoh/oyWP7IJF0rJmZtSZCbH5h/Y1DqYL2wf7Vsw1b3+s1glSylzTlBLqE
 ++Yz/zUHcSdLlOMf2MzV6oeethnr+VEfBS7ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170094; x=1748774894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNgfw161dCItCFM25CvHTcw95xyOr5cAIYoy4bUX6/s=;
 b=tpvBeDWWqVKwCQfnCjZa8bYzPHohlPZ+ujQFhC+bUenO53loi0jRf6OOeJhVW26x5q
 GXr7r56vX4mlW9j9G+5hVBCl6SHxnuayrKXpkRWi+0J+w5VCh+Y6SiE8f3jAZH4B2Or1
 oXVwS1UdMESDgSKMdV5FPB9eMF5GBjcH+JTlvH9ZcvBoTPrURSF75E/D7OkWEyUxefb8
 SIRcsLkD9kX6nrIWiPXf83+k6eI1nSzZ4dppmx5CA+uk7Eew+Cwr7TphEg+17bbYgc79
 KGIzNvyZaqq9V0EeV4p7uL+0dHQOWE6VriM7Sef2nYJlUro2Twh2bLr1OQYKM+5NVp5H
 bEzw==
X-Gm-Message-State: AOJu0Ywwwmo06kuR/x1lbB8+zDkKkRNDeTAcEh0oXen68Go7/mCc8eVj
 LlB7K7OIHbqNXej7sRITWWTYKTPnjKYne9wgKAROHtHnIYonhR/23cREmxTBCN2kDri+fECbdhY
 +Kuf+IQah
X-Gm-Gg: ASbGncvDPqzDTQ5MurT/ngFGztozYjmPfmg8PGnTN9m1hSCGxPxlUDK42x6H/Dd5swM
 cup6qz9WVVX4fYZFc8xeV9R59Rl4CvZMrY93AfLijWNgZcjlsz15REqCsyX+9oUycylsqxWibIF
 ko2J65oFBifM+HNqxhk2Ag0txVSqKaMuPRxp5pnOkDiZ7V4LdAwTVn8L0eUB/8/Qhi6xuDWNm+R
 4QY+ShuA80c4H9opAcvhv1kMCP5ZSL5liyJOuJyLz6cI3X7J5D91rAsIz+O4OlkseATm8nYxOgJ
 xCFkYeQHV1RO2ZWNIrVWTlbO36BKP7kHdGgSws1tyNCB2jVXQQQRG9YHtNtzVQ+0it95ZiM=
X-Google-Smtp-Source: AGHT+IEw0Qekm20VF3IXekQfEALSEl+Jtudk5XHu0qXcBZXKWJU6v27Z/ZZrjI3Fm34+k/iSa236VA==
X-Received: by 2002:a05:6000:4383:b0:3a4:d5e8:e33e with SMTP id
 ffacd0b85a97d-3a4d5e8e396mr1029937f8f.21.1748170093823; 
 Sun, 25 May 2025 03:48:13 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 04/25] rockchip: Allow RAM init to happen in SPL on rk3399
Date: Sun, 25 May 2025 11:47:40 +0100
Message-Id: <20250525104801.1440260-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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
2.34.1

