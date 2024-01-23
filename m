Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7AAC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5449F87DC8;
	Tue, 23 Jan 2024 18:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WFAaIqgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F08387DAE; Tue, 23 Jan 2024 18:17:31 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9F687D86
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55c2c90c67dso2941305a12.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030236; x=1706635036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0X0ka47ay529bYddxaRPmhyOVqMPvkiJ3wYymdD15c=;
 b=WFAaIqgAOakRWVwpLuurZQS9xHp1+OEeZtZkTSIzxfd01jhE2BeOr80Xjeb0LuOwsZ
 1qRqXnUC6eh5M/juEcOFVCPIQfeQ7ix6x0IvG7KuZnapIH3RrCo1fQE9zGGOyb0zl401
 g36zVlpKGed2UEBhL8xVjZIcTQZa6VRQjMYSIDUHvlEpCfehTXUAdSzLrkBwLdeUauJN
 BexSpZpdPUogtR7FygV+PtKGwEOQmXCI1rBxZqECz92/IppY8AcF/jZdf9jxt60MlFlF
 LgZIb1ZzpI1eBkKmPVqQqmoSOCMoR4i0SZHNQcWYUq7Dr5FqFcD13kWRbBY/6ArKiVcg
 h9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030236; x=1706635036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0X0ka47ay529bYddxaRPmhyOVqMPvkiJ3wYymdD15c=;
 b=nV4ZxMuXXaB/t3LE6250DV1w8AeR9GnMTqRQcIVkQGr/6x4A6PRoMvkHR8jm8NvV/s
 Z46I6AsA7P5AgM8RqH5kK4K1YKfUsuvqyEzpQ3+wcUmUkPwqgWeevnbnDPdW3Wl56P0J
 Z6sa6YSKyt92BkIziqsITWYSZX8OiBPUtN85hyRPsDZ+5bUgRVxU5mxgCDLdESLv3zvp
 0GidV9tp37wuV1eshXgjNKbfc/HavdVf9EyD47nJwX96AA9Dt9j3bdB57EAeSzJLma4n
 RQM+mHKVJGOkFwqg0/KsXCgt4ZHBbNvb5E/GoESPdil77vVtabIZdrRet+moVhDcRxYt
 xtiQ==
X-Gm-Message-State: AOJu0YwJZ+uu1bSO0xql+L5Jzu5LRvRgAKaxIhwB+03mHG3xcRSc8nHB
 vEXZPmJql+R1H/VBbmwEQpnUHHPt3Lpu9fmDnHenNVz5PQPp6u7t
X-Google-Smtp-Source: AGHT+IHXPG37Ic33mmNHKjUrCq/1Ib0cMC7M/7BPw6WPNODUZk6gqIqiczxSZJDO2y8lnXVkneJjHw==
X-Received: by 2002:a17:907:7b8a:b0:a2f:dc6:afe9 with SMTP id
 ne10-20020a1709077b8a00b00a2f0dc6afe9mr101823ejc.55.1706030236183; 
 Tue, 23 Jan 2024 09:17:16 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 18/18] video: tegra20: dsi: use set_backlight for backlight
 only
Date: Tue, 23 Jan 2024 19:16:33 +0200
Message-Id: <20240123171633.246057-19-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Shift the backlight set further to prevent visual glitches on
panel init.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 7d63557d1b..13dae37806 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -766,10 +766,6 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
-	if (ret)
-		return ret;
-
 	tegra_dsi_configure(dev, device->mode_flags);
 
 	tegra_dc_enable_controller(dev);
@@ -784,8 +780,10 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 
 static int tegra_dsi_bridge_set_panel(struct udevice *dev, int percent)
 {
-	/* Is not used in tegra dc */
-	return 0;
+	struct tegra_dsi_priv *priv = dev_get_priv(dev);
+
+	/* Turn on/off backlight */
+	return panel_set_backlight(priv->panel, percent);
 }
 
 static int tegra_dsi_panel_timings(struct udevice *dev,
-- 
2.40.1

