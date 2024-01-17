Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF00FC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5E887BC7;
	Wed, 17 Jan 2024 18:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hxuyKrDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D72587B5F; Wed, 17 Jan 2024 18:17:30 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BDC887B5F
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so1186020766b.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511846; x=1706116646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zerQ22x/x8UOxAW3Wsxy4H6ymQPKhUl2gDGa7gIhMSQ=;
 b=hxuyKrDZDnIC/VAFROVzvlSB5e75OwRnIZJVfOWHmT7SD6AbV5VZsuQndnC1i/lcLf
 fAbBrn7swSciBNaRQV+fUBkWO0/V3I1el7/aX6te+HbkhD2By/p7lM9W0w3srRowICVi
 dc+kTJNcoi/IxvDl8Ra1UQ4S8NSdRLqdbtPwgux8DKRGq33FIofhFWCqsc5XI/CaSUIv
 8lnnhpbyt+WIfdV1lC4jhhOLmkrGfcSRK7MzzFkclKYP1Y5lcOHAEXHBZGOPtH+CuOj5
 0uR1tfXnBaCfAIP52fqlOiao7AOfUEenkWPyg8EP3LgXW/20nEI4cio2EjdJiOtfuk0n
 P/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511846; x=1706116646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zerQ22x/x8UOxAW3Wsxy4H6ymQPKhUl2gDGa7gIhMSQ=;
 b=OqRc9XrfuRDFoMqJUfu8AEVUB8ilPbZVWxp6UgvwnjFo4vSC2g0CXdg/iJCdLOk0xA
 Ax0QwMtvj6AVGJwlyOyHdL6GKinwAc0FgaNEeT01frsGDcRJ7FKTQmr4uLuHmmBnH74T
 6NFR86CTwHkDgIeR/lNyIRGwfifd1JoOB+PgkI1qZhXI72rLL4+q3vpr9QpdfUvjNKEa
 EkRj2QoW/Y2EfaiKJPHsI03JwcXmjEgz7Z07weAmuZGYJkAnqCUHXHMGTBGK/bL216+J
 P6CSgLts6wSlX6iCxS74EPJffQhhYF36LbZbveTUXaXRxZIBQ4UAESAsWqNadH9J4xz/
 STtA==
X-Gm-Message-State: AOJu0YwpKbyWe6wG+H9Oj5aaG4uePAcv+rq4jjEgcDE9azgMN6lo4GNv
 rXkBJWS0q2FGD49tY2yW1Ok=
X-Google-Smtp-Source: AGHT+IG+frRZod46/yc93tVpKQAzoUBKYB+6kmpcv7gzFG8CSTlsaw4NkF8PqmWt0/mNvyAWOvwskQ==
X-Received: by 2002:a17:906:ca0f:b0:a26:8ab0:43b3 with SMTP id
 jt15-20020a170906ca0f00b00a268ab043b3mr4356542ejb.74.1705511845843; 
 Wed, 17 Jan 2024 09:17:25 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 06/13] video: tegra20: dc: add reset support
Date: Wed, 17 Jan 2024 19:16:51 +0200
Message-Id: <20240117171658.22324-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
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

Implement reset use to discard any changes which could have been
applied to DC before and can interfere with current configuration.

Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 56a23b3c97..35abb6fe46 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -10,7 +10,9 @@
 #include <panel.h>
 #include <part.h>
 #include <pwm.h>
+#include <reset.h>
 #include <video.h>
+#include <linux/delay.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/system.h>
@@ -342,6 +344,7 @@ static int tegra_lcd_probe(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct tegra_lcd_priv *priv = dev_get_priv(dev);
+	struct reset_ctl reset_ctl;
 	int ret;
 
 	/* Initialize the Tegra display controller */
@@ -349,6 +352,20 @@ static int tegra_lcd_probe(struct udevice *dev)
 	funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
 #endif
 
+	ret = reset_get_by_name(dev, "dc", &reset_ctl);
+	if (ret) {
+		log_err("reset_get_by_name() failed: %d\n", ret);
+		return ret;
+	}
+
+	clock_disable(priv->dc_clk[0]);
+
+	/* Reset everything set before */
+	reset_assert(&reset_ctl);
+	mdelay(4);
+	reset_deassert(&reset_ctl);
+	mdelay(4);
+
 	if (tegra_display_probe(priv, (void *)plat->base)) {
 		debug("%s: Failed to probe display driver\n", __func__);
 		return -1;
-- 
2.40.1

