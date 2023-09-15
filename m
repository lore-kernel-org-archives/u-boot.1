Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BD6EED60B
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 16:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 161B08658D;
	Fri, 15 Sep 2023 18:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ebdc33wx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84980864B3; Fri, 15 Sep 2023 18:01:42 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E29086529
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 18:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbrunet@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso2105980f8f.3
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694793700; x=1695398500;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vG7ZtuKg5eIzhI0aNTrLPK0kdV66ygP6v/rM0qUAPVA=;
 b=Ebdc33wxrSu0vLVs2eaZHwjcIsLfI6P/G0ncCZ7GRURujEUIK+S8WZvLrVhpquyKce
 IriWhocB8B9awW01DL8t0VvVRzcUvp8QwhT/YUaON+1aimuvT5EOtdkzmGBjWHW8M17p
 j86x33GWMqpZlIMowBra2um37DF5MXT4Xo2AwJjDiI1int/pn0y3Z/Afy6Lz2nTOq0sl
 oTPVtqGpyd9DMJUUnYgwxL0S9s0zY5zFBZj77UmsYjm7+v3ZtSswuomz+ZX4u4SHlNHF
 mk2QReQOgfdC/D8VpV3+Wr6DuWBz/BiJz4QrDaSikJv1/uTWBW1L8+4Sk8S1uQz2+SbF
 iyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694793700; x=1695398500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vG7ZtuKg5eIzhI0aNTrLPK0kdV66ygP6v/rM0qUAPVA=;
 b=QsabjOPmDFLm/BW6Smnav9ekWdIuRi8yzylPSpTb3UZ+BtI4E2PK5sGirLfFO7ddZE
 z+01qyYoNKowEwUmBfAXJK8maz4iCX7IgyImiCxim0o527facSbjhqvUQd9Hx7svXosd
 //DNxt67u5Ze/hTQL5PUCbIJDqn5kVk4krbKWbO9UYAx/hPNtnziQ0py6BmpHuS7jTH2
 qFDIbs6g7TWS5Ikezi852ebDe9FvWinFBkz5GggZjSDWU3zsILk3gVuDZwKecGXizV+u
 HkrK8Tuf1/2uOZvCcfGT3j74gV+0cMovcaqUd8SOfl/++lIAfx2e6CqwuB1JKbHlvCbx
 SbZQ==
X-Gm-Message-State: AOJu0YzDIq/dhLv7d6tIiVfanivZw16vnbvFbKdI9uMjD4qv2yPQbip8
 mMfZGA+o87pIeV8gTLbWM9pXOA==
X-Google-Smtp-Source: AGHT+IFnD7SzHHYEA4duL63u1iLm05hiqiTU2q9fM311LY34w8FjSsqvcpLLP695ZYzhoL8vslUCdw==
X-Received: by 2002:a5d:49c8:0:b0:313:f395:f5a3 with SMTP id
 t8-20020a5d49c8000000b00313f395f5a3mr1822374wrs.38.1694793699879; 
 Fri, 15 Sep 2023 09:01:39 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:cc7c:a70f:b3d:d73b])
 by smtp.googlemail.com with ESMTPSA id
 p7-20020a056000018700b003176aa612b1sm4761766wrx.38.2023.09.15.09.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:01:39 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: [RFT PATCH 2/2] mmc: meson-gx: set 270 core phase during the
 identification
Date: Fri, 15 Sep 2023 18:01:30 +0200
Message-Id: <20230915160130.352099-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
References: <20230915160130.352099-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
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

It has been reported that some devices have problems with a 180 degree
core phase. Setting 270 helped some of these devices. Other continue to
struggle (while it works fine with 180 in Linux ... :sigh:)

Poking around the HW, it seems that setting a 270 core phase during the
identification, then using 180 for the rest of the operations, helps the
device operate correctly.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/meson_gx_mmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index c6168792cbae..284be2b9dca4 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -54,9 +54,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 
 	/* Clk always on */
 	meson_mmc_clk |= pdata->version->clk_always_on;
-	meson_mmc_clk |= CLK_CO_PHASE_180;
 	meson_mmc_clk |= CLK_TX_PHASE_000;
 
+	/* Core phase according to mode */
+	if (mmc->selected_mode == MMC_LEGACY)
+		meson_mmc_clk |= CLK_CO_PHASE_270;
+	else
+		meson_mmc_clk |= CLK_CO_PHASE_180;
+
 	/* 1GHz / CLK_MAX_DIV = 15,9 MHz */
 	if (mmc->clock > 16000000) {
 		clk = SD_EMMC_CLKSRC_DIV2;
-- 
2.40.1

