Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACFEC021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 446AA80FF0;
	Wed, 26 Feb 2025 12:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P1qjPNa8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C269810EB; Wed, 26 Feb 2025 12:54:21 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B12380FE2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abba1b74586so980928266b.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570859; x=1741175659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lx0p3HorPAuIy62ceQooMbP33OoC0mqWPXOw3ssUSJs=;
 b=P1qjPNa8wtR+aZFniBLcReV3uMjZEnoM/XVpelUHlk9qwTGQTaMJTcVYaf84tXGmqN
 s+HVEkcwLTUXWYUvBnCZwyI2xqPmr5tv/1K/WyndAFYk5xmtEKE70aEzNgf2JaFVPBZy
 HiNpOkKOyJWq65lq+eslEPj2MEfGnWoXItkJ7P1h6NEZgmf3OnhRiGZeFuR8Nhp3nzty
 uAcRXXOQwe3+0DgZyevVdoPvI3NjDJ9QgxEtfab1fBJiCFrscaj1unM1dj2arLclmRR/
 sF7VZTiXcNkpOBedYFuGfuD/0qLQAqbhScKxCvd+LK6eNhDeoC+CoY3MWfGo3auD3gT8
 /cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570859; x=1741175659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lx0p3HorPAuIy62ceQooMbP33OoC0mqWPXOw3ssUSJs=;
 b=TpMw9ydRL58OLBaM+BZ0KqDAr2CzqznfmhH7AB5XjFnrpP8F3JsiBr2jM664y7FRl4
 VOTWekMXntOciHm1lDU3VErXbnV+KXjyvyB/wVdqd2WQC7NmpY2Mkhqyu8AMy7Eg1iZw
 3QDNME5puWgQcYtIUQZXy3UsQ6oovmh5UzlD/xZ3ibJrB48zodzEvN96lBB/ed/AklGn
 FKq4E5sTUwISDug4R91iwCXZX72ypbu5a8q0l9PmOFYmEYt1QaR173J++WiyeOeyo0SG
 O9ifpBBG0zvNjDvSPKpiD9RmHpY5rZ4A+pB5CKTiiIyub0l3B6QkVmLQihSfHYZzUyBA
 qsaQ==
X-Gm-Message-State: AOJu0YwlUDAFRytIWRXnXJ2lDmuMFMd5C3Qi07aGDKs7yMhcQBE+uXRF
 ue+uegHq9vhyEXeL0z9PeqDpO0EpzGNLC/rJ1pRB4B26xMXmcwnd
X-Gm-Gg: ASbGncsRqsLvhjvqMc7YWLiC0iN5bAe6R6aiGjBj53B6ll4evtn5PEVXldCOB9eiECE
 cjyZbCsNIXXlz7kBVNVgBEThlZNe377K3qVEnqwzQ0F4wKq+8WVMB2cBIbGc3U5IJlQhBLkmb0t
 QajN7+EUUtFfLFw0fGbWbVMaBNO2l7IHuEcNFBe/pPxQEJUfShnKKq4DycBYZU3BajXq4Mix10g
 r+JJrjAD7jQ3VY2oipse0q2MemFWqof+ynLUR8pZLAPYz4gDAwQCM/ExwPo0YgaMVXMxT2qfBcI
 q2J/fZS3zogaQyhAFQ==
X-Google-Smtp-Source: AGHT+IGL/ExY4ho81ZUq2/G6vQ9zZLRg1x0nAFVJVtnuZxuTn8GrUhoI4AJwJlYNm5Nuk9U0Rfvt6g==
X-Received: by 2002:a17:906:1712:b0:abe:e09e:b4cd with SMTP id
 a640c23a62f3a-abee09eb78fmr481052866b.48.1740570858534; 
 Wed, 26 Feb 2025 03:54:18 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:18 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 11/12] video: tegra20: dsi: pass source on DSI configuration
Date: Wed, 26 Feb 2025 13:53:37 +0200
Message-ID: <20250226115338.42832-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115338.42832-1-clamor95@gmail.com>
References: <20250226115338.42832-1-clamor95@gmail.com>
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

Parametrize DSI configuration by passing DC source pipe. This
should resolve possible failure if second DC is used with DSI
for some reason.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index b132a23432c..079b00e0f61 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -650,7 +650,7 @@ static void tegra_dsi_ganged_enable(struct udevice *dev, unsigned int start,
 	writel(DSI_GANGED_MODE_CONTROL_ENABLE, &ganged->ganged_mode_ctrl);
 }
 
-static void tegra_dsi_configure(struct udevice *dev,
+static void tegra_dsi_configure(struct udevice *dev, unsigned int pipe,
 				unsigned long mode_flags)
 {
 	struct tegra_dsi_priv *priv = dev_get_priv(dev);
@@ -681,7 +681,7 @@ static void tegra_dsi_configure(struct udevice *dev,
 	value = DSI_CONTROL_CHANNEL(0) |
 		DSI_CONTROL_FORMAT(priv->format) |
 		DSI_CONTROL_LANES(device->lanes - 1) |
-		DSI_CONTROL_SOURCE(0);
+		DSI_CONTROL_SOURCE(pipe);
 	writel(value, &misc->dsi_ctrl);
 
 	writel(priv->video_fifo_depth, &misc->dsi_max_threshold);
@@ -786,7 +786,7 @@ static void tegra_dsi_configure(struct udevice *dev,
 	writel(value, &misc->dsi_sol_delay);
 
 	if (priv->slave) {
-		tegra_dsi_configure(priv->slave, mode_flags);
+		tegra_dsi_configure(priv->slave, pipe, mode_flags);
 		/*
 		 * TODO: Support modes other than symmetrical left-right
 		 * split.
@@ -815,6 +815,7 @@ static void tegra_dsi_enable(struct udevice *dev)
 static int tegra_dsi_encoder_enable(struct udevice *dev)
 {
 	struct tegra_dsi_priv *priv = dev_get_priv(dev);
+	struct tegra_dc_plat *dc_plat = dev_get_plat(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct display_timing *timing = &priv->timing;
 	struct dsi_misc_reg *misc = &priv->dsi->misc;
@@ -880,7 +881,7 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	tegra_dsi_configure(dev, device->mode_flags);
+	tegra_dsi_configure(dev, dc_plat->pipe, device->mode_flags);
 
 	tegra_dc_enable_controller(dev);
 
-- 
2.43.0

