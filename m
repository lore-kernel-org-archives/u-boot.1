Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF69C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BCA87BAF;
	Wed, 17 Jan 2024 18:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lgoMqbjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B4187B7D; Wed, 17 Jan 2024 18:17:35 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D8987BA9
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a2dc7827a97so420319666b.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511850; x=1706116650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZn6/uxg6r1IwvYRfh8ty8ZUnZEuYkBnACGTUPyycFc=;
 b=lgoMqbjw0VZdNzDD2Cme37HrLy6N0UvVG5s+MlOqsHkong/UfHU2eZA7FiJjiJGIPE
 Z34GpNg55eegR2P7erxNaIzJprfIJ9qLj+nLCeCfZITNHxicShSwXsteRAogIS5dGiAd
 irEIZ1yGEGINfFEK33DiCjp2MxwKHHC79fguYtDmf2/JTE8EgUDGzTTEvGG0WJtKIyfl
 HVs6NS7TFhRtTtzKygpHDHJKxihnZmwmeCuIOsQ4u/+T26Nl9g73Ij1tcTyLI2Z8MVuT
 Lx3LMa1msmfH/r7K6SJ/+9mjQr7RMpzlgyyhS2JZXQcDCtbJ58C7/58iCGknC4QmOqj/
 7Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511850; x=1706116650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZn6/uxg6r1IwvYRfh8ty8ZUnZEuYkBnACGTUPyycFc=;
 b=ecxprxV/UnRnh40IPaR3iee98G1TqtxeutiZEzywb8qUpU+e5Ny+qnKfBec1dy1ZVF
 QqmkrHEwRRPWfLIjm027h9jMmVpZjzEa+1Z2FQ+JNKft52l77tiaKycxAg4kiTkKe3Xt
 DYEaQg5U90LTiA3HyrlSSesyajqyYC0y4ZBDhwahLIvMzXTQm588rNWnf18KgUAHaJa6
 iD7/oOmhnDYhyNwm34qqbUj35F1M06CXQnTf0L1JmFjiwJWg3n4dP3P6XCmSNjq2UNbi
 LpV0iKUv1YGuY08skuMZIzkyh/e3JIH264tfAjeuYsp1hgTMhocIwOaHa7Xxhj+NXUCO
 rLIQ==
X-Gm-Message-State: AOJu0YyFsEitHdDaduYvn/VI9QHI4BUjuTUf6b82Yf+773x1gXgzEyaW
 uNrQeUTI6uBmP2Xpjl7FiOk=
X-Google-Smtp-Source: AGHT+IE09FOY3+oh6HjkEY9IFuOtTHtgiky+G/klZmyXp9EuYzuht5GQZbqzpbC3h27wbkGkG8fvoQ==
X-Received: by 2002:a17:907:c719:b0:a2d:54ca:1ff9 with SMTP id
 ty25-20020a170907c71900b00a2d54ca1ff9mr2865268ejc.150.1705511850134; 
 Wed, 17 Jan 2024 09:17:30 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:30 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 12/13] video: tegra20: dsi: remove pre-configuration
Date: Wed, 17 Jan 2024 19:16:57 +0200
Message-Id: <20240117171658.22324-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
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

Configuration for DC driver command mode is not required for
every panel. Removed.

Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 6408026808..e60a1d2ac4 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -766,8 +766,6 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	tegra_dsi_configure(dev, 0);
-
 	ret = panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
 	if (ret)
 		return ret;
-- 
2.40.1

