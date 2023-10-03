Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE30E75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD1F87206;
	Tue,  3 Oct 2023 08:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iZs1tvvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C0687218; Tue,  3 Oct 2023 08:25:52 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1235287203
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c27d653856so47070491fa.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314347; x=1696919147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVxD021MVTrYNE+DC0MuYlYJBSs2FO9uD+/gTJsLcNQ=;
 b=iZs1tvvoHW2xuKPMkXGnAnbt81/RvtsM67i2e2x4ZuyR8yoJXfmOK1SQhIzK5qjhJo
 ydjx6jdaLtqG1wCdO9N+NL6KoE53Z+hqow2W3EICQCKlit+sGRdwGEmc5j3IQvihsGlV
 aItm0C9rvG0w85AW+XZfZEjQh/M4dBz850N06+XWiuTenDG4lRxz8OLZVwTcglQEJvCD
 Y7Hh2N4DUJiEodT4nv2DTWM1uyJfpFHpZRzOwta/Mj7LNnXRWLvRoypdaNYg0gsDuFYr
 AYm1brevNHSYn3wt5o9xwYDZFq6R78S7AB3aY5207SDaIdkWo7fltvwkzQoVrT6nTOMX
 H19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314347; x=1696919147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVxD021MVTrYNE+DC0MuYlYJBSs2FO9uD+/gTJsLcNQ=;
 b=hO+WoAyPVqY2ydjKK6dhdVzsURuJJrEQz0S1rfDAHMRl8tnz06qoW2ITnpsiPPLYif
 eaVrStMIwyrb2tfcyhtWmvO25Gwxaii6UceHKLPO02YRQLn8P3agv/WzAcdkK4th6huK
 SsZHnIb9oGbqTViyLYPIMydOCNWjTmr7duqCTJi29SKpfZW92w1pHtZhcp78i8zmUzoC
 kgZM+KJY05SQ/ow/tVJvwj9USdaVJvuAi+HO+Z06I7pz9a82fSIbK8vx3YwE2vVHZGQ4
 wcWd7/tRAX4ght0IPJ7UavsNmmLaFc4h2OSIP4bNA5J49wOjMAt4s+84Gimj1VP84hpM
 UxEw==
X-Gm-Message-State: AOJu0YwB/wZTxrawTJgOuruk1UualsTmiaQjlShrVu92yhNek/8hNte7
 U53NytVk+C7swqu48M8mrhs=
X-Google-Smtp-Source: AGHT+IGZQUKjeDCJFDaG3rhl4Z+dZdLNDnNQM/gKfTp+GE7f4hIIY3iTgYMCOS2ftEsqOi2MKNP7JA==
X-Received: by 2002:ac2:4c23:0:b0:4fe:b97:e361 with SMTP id
 u3-20020ac24c23000000b004fe0b97e361mr1127454lfq.18.1696314347298; 
 Mon, 02 Oct 2023 23:25:47 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 c10-20020ac244aa000000b005031641b40asm74615lfm.159.2023.10.02.23.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:25:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 1/3] video: pwm_backlight: use
 regulator_set_enable_if_allowed
Date: Tue,  3 Oct 2023 09:25:32 +0300
Message-Id: <20231003062534.42325-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062534.42325-1-clamor95@gmail.com>
References: <20231003062534.42325-1-clamor95@gmail.com>
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

With the commit 4fcba5d556b4 ("regulator: implement basic reference
counter") the return value of regulator_set_enable may be EALREADY or
EBUSY for fixed/gpio regulators and may be further expanded on all
regulators.

Change to use the more relaxed regulator_set_enable_if_allowed to
continue if regulator already was enabled or disabled.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/pwm_backlight.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/pwm_backlight.c b/drivers/video/pwm_backlight.c
index aa0e292866..1c747d98d7 100644
--- a/drivers/video/pwm_backlight.c
+++ b/drivers/video/pwm_backlight.c
@@ -100,8 +100,8 @@ static int enable_sequence(struct udevice *dev, int seq)
 			plat = dev_get_uclass_plat(priv->reg);
 			log_debug("Enable '%s', regulator '%s'/'%s'\n",
 				  dev->name, priv->reg->name, plat->name);
-			ret = regulator_set_enable(priv->reg, true);
-			if (ret) {
+			ret = regulator_set_enable_if_allowed(priv->reg, true);
+			if (ret && ret != -ENOSYS) {
 				log_debug("Cannot enable regulator for PWM '%s'\n",
 					  dev->name);
 				return log_ret(ret);
@@ -181,11 +181,10 @@ static int pwm_backlight_set_brightness(struct udevice *dev, int percent)
 	}
 	if (disable) {
 		dm_gpio_set_value(&priv->enable, 0);
-		if (priv->reg) {
-			ret = regulator_set_enable(priv->reg, false);
-			if (ret)
-				return log_ret(ret);
-		}
+		ret = regulator_set_enable_if_allowed(priv->reg, false);
+		if (ret && ret != -ENOSYS)
+			return log_ret(ret);
+
 		priv->enabled = false;
 	}
 
-- 
2.39.2

