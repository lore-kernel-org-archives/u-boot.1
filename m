Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A019C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3383D817D8;
	Wed, 12 Mar 2025 18:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1DIXtj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AAD819FC; Wed, 12 Mar 2025 18:59:31 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F60981782
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so19654866b.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802369; x=1742407169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdN9z4ZEpfVytbWjaNQzrrt1hyfLls/jjFW9/Nps7u0=;
 b=A1DIXtj1TZkheweshayH3OjxtrMMFpOOJGw7vDdns1QVCQ/UJC0VGQ6YDX4qTf/vyy
 vnG3E5FxuyWRiomoJtWs+NrXgl8ACdm0sygEpGXgS5xfW4ktvQG48Ut/b6j62r8/Un/k
 cMkss5EvU1zZel82ZjmhbqvUXt2/VmfKRzndSzYjHhXPoes3Fw4Tq91qp1Y31lgcu1oJ
 GcZnvX3niDqJp53KEI8+0J9aTDVsiD6Mp7rW+V+LTBAtxF8WwCMnOVIAH2KzZx2UiDCi
 i6/d78m0Ge/838+w3voUYODQWLCql7L3+95rgaDJOsAet+8ADvvUtO+Ps2na7R4BDG/S
 /Trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802369; x=1742407169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdN9z4ZEpfVytbWjaNQzrrt1hyfLls/jjFW9/Nps7u0=;
 b=AD2rvZg/B+wT5XGZ+OvhklPMUHQ+J+W5IcUpcZxgC5cdECLHMefRGofJJiOgYjaoWc
 pLmNJFZ24KvocuzOQXBHT9xaUY1MiPl/oFQHDu9Pe6r/JKFUNEYI+zZRucN+YZoZiA2a
 gpk8EWKTm6d81NQ39qtP4ObCv86KUUdT+YnXTiMi3bVrN3Uym8fP7dvAJ3DjnIQiPfLi
 14phGh2TF89bR944hvrD/WNo1tsu5oq0jSntGaDNR63Bw1nL5Rs8eOIZ//E0+3aNw93f
 ntCKUn4hF2X2HRmp9WMF59MseltFNMu5eRgtsg36RnB3DKWRstop+L6CskgWXEFiewrj
 44GQ==
X-Gm-Message-State: AOJu0Yx4YpWnataSDjoVFKYWV45aY2obPvYBUatKqrKRU6955HwCIuyh
 pS3CaRADKR+yO8CRQAmD3uRRtOXanBn5TA52fibaVBFAKx4CupiV
X-Gm-Gg: ASbGncs8yz10Da0hXshVfvb8ywMmD2QBa3bQf5cS4E6D6P58GlnQBZvmnC2bi0r9nIO
 /qv2TxlicyU25s8fRZv2FHFREmGqTBhip9oIQmBqtcFqDi8d+Rsz+BvQ6Bw0WsbocRhB4mc08EW
 I1I1ArDmtKhyz85rpVbCHa1XSnFa8xPJMnbHqwgK831aZT2sf7VMNkW003GRsWAPXNfWPahI49L
 AlCClflMrp2jtkdDPEyHqkFPhVV3im0KSSITufhJCu+u2xKsKiqxJLe1YcMse0683p+/IPuz2jm
 Q8DFL3Tw8q4KJRHrdCzou/GOJSFstgiSOLBu
X-Google-Smtp-Source: AGHT+IGZsGDylI0UK+ixM9RuGfLZ5E1XPoTO1PWcm39/Xiq1vlEGwNFJru+JhK0Up3GL1ZCkiLYNZQ==
X-Received: by 2002:a17:907:3e1a:b0:abf:7a26:c47e with SMTP id
 a640c23a62f3a-ac2b9ea39e3mr1189309866b.43.1741802368606; 
 Wed, 12 Mar 2025 10:59:28 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 08/10] video: tegra20: pwm-backlight: convert into DC child
Date: Wed, 12 Mar 2025 19:58:55 +0200
Message-ID: <20250312175857.120313-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
References: <20250312175857.120313-1-clamor95@gmail.com>
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

Establish the backlight as a DC display controller child.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-pwm-backlight.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/tegra20/tegra-pwm-backlight.c b/drivers/video/tegra20/tegra-pwm-backlight.c
index 79d8a021a3a..998f0df1991 100644
--- a/drivers/video/tegra20/tegra-pwm-backlight.c
+++ b/drivers/video/tegra20/tegra-pwm-backlight.c
@@ -17,9 +17,6 @@
 
 #include "tegra-dc.h"
 
-#define TEGRA_DISPLAY_A_BASE		0x54200000
-#define TEGRA_DISPLAY_B_BASE		0x54240000
-
 #define TEGRA_PWM_BL_MIN_BRIGHTNESS	0x10
 #define TEGRA_PWM_BL_MAX_BRIGHTNESS	0xFF
 
@@ -106,14 +103,11 @@ static int tegra_pwm_backlight_enable(struct udevice *dev)
 static int tegra_pwm_backlight_probe(struct udevice *dev)
 {
 	struct tegra_pwm_backlight_priv *priv = dev_get_priv(dev);
+	ofnode dc = ofnode_get_parent(dev_ofnode(dev));
 
-	if (dev_read_bool(dev, "nvidia,display-b-base"))
-		priv->dc = (struct dc_ctlr *)TEGRA_DISPLAY_B_BASE;
-	else
-		priv->dc = (struct dc_ctlr *)TEGRA_DISPLAY_A_BASE;
-
+	priv->dc = (struct dc_ctlr *)ofnode_get_addr(dc);
 	if (!priv->dc) {
-		log_err("no display controller address\n");
+		log_err("%s: failed to get DC controller\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.43.0

