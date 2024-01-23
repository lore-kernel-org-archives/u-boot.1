Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7121EC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4223687D99;
	Tue, 23 Jan 2024 18:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gnNwQkfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A67187D25; Tue, 23 Jan 2024 18:17:19 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF3887D54
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5100409e31eso1844558e87.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030231; x=1706635031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGHNEz8FtB6j+wMC/wy2IJ7jO33KtBYiGIY2+h+MCMU=;
 b=gnNwQkfI4u7/dMOmZdpEFkHLQ3LUQVH5/GmJOsXkCTMouaexjcZt/MyT6kMlseuHZs
 xeWEBuzc5+pLWFAoVBsdiCol90K5fA3fLWOG6JrS6rcXIdMcW2b1Igpbk4JCEvgp+5Uz
 vvPeI0QZj+IS3qOEFWj/d8/Uf8XKxNTUaT6nK2CJ0cu2MvHs0TpDHmiMh5+XohyWWJ/l
 Y6NHlXv2Fm9Pye74TDdHWd3eKqNwZj+Em8D5pSRnCdKRT76QzfZLMrMpA1zzBftMnqAy
 0f8bPbKx5BLcNFFx9obkn4pT/Uhd3sJuZncJnImzZPGHR+xUFlMROpPujyhGW/huWXuq
 g7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030231; x=1706635031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGHNEz8FtB6j+wMC/wy2IJ7jO33KtBYiGIY2+h+MCMU=;
 b=IG7sO2dNuAgZR2HObdW0dnpoPX/O+XiAs+20eRjBxFFIILg1VT0EhMJ0wovy9XZKyo
 80iXmfOe5DNz63Z6kDGo/PMomhPH7Bp8OvXEghXMZtyqzn809EHXGH8Q+jDPr6oBJQuS
 devyMm26VlsVjeLisO4L7Jw0sJ21AeCGB3Ere/AX8ComtX85y8rwiEF8eqN7GXadLGgi
 RtLcLeM3ySsbqIDj0/7523OVXcyhMssyDgYwKpV0f0tqJ2C3igm/Vetmi5ReXsUbRSau
 a2H54SvZtzePv777YOtl9RAwv9x19XiwpbXgpz3fU9j1gGUPQzSCMplezjby75wFBsnH
 6//A==
X-Gm-Message-State: AOJu0YySlOez3koCMZh4Rtq7EIr/UsDQ2kzq36QEvcHA8UqUTj9h2n/A
 ITGuOxZQcg9dULwAHpDkrysmcX+sQ1nIo+fqe0OXim8IyRd5LoPy
X-Google-Smtp-Source: AGHT+IHn+oPdpGjD2TRUB6ZIp9eFI8kCKRWReMcAPw1N09rs8ye6zS8IXqbVX9+/SB7SZdEDpg4J1Q==
X-Received: by 2002:a05:6512:1188:b0:50e:b4cb:bf30 with SMTP id
 g8-20020a056512118800b0050eb4cbbf30mr3950738lfr.59.1706030230851; 
 Tue, 23 Jan 2024 09:17:10 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 10/18] video: tegra20: dc: enable backlight after DC is
 configured
Date: Tue, 23 Jan 2024 19:16:25 +0200
Message-Id: <20240123171633.246057-11-clamor95@gmail.com>
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

The goal of panel_set_backlight() is to enable backlight. Hence,
it should be called at the probe end.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 000a0e02f8..ac6833229a 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -414,12 +414,6 @@ static int tegra_lcd_probe(struct udevice *dev)
 		return ret;
 	}
 
-	ret = panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
-	if (ret) {
-		debug("%s: Cannot set backlight to default, ret=%d\n", __func__, ret);
-		return ret;
-	}
-
 	mmu_set_region_dcache_behaviour(priv->frame_buffer, plat->size,
 					DCACHE_WRITETHROUGH);
 
@@ -432,7 +426,7 @@ static int tegra_lcd_probe(struct udevice *dev)
 	debug("LCD frame buffer at %08x, size %x\n", priv->frame_buffer,
 	      plat->size);
 
-	return 0;
+	return panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
 }
 
 static int tegra_lcd_of_to_plat(struct udevice *dev)
-- 
2.40.1

