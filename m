Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F373FC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A62FE87D67;
	Tue, 23 Jan 2024 18:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lPPlNnre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F08987DB1; Tue, 23 Jan 2024 18:17:15 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD47987D36
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3082d450adso238823966b.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030228; x=1706635028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zerQ22x/x8UOxAW3Wsxy4H6ymQPKhUl2gDGa7gIhMSQ=;
 b=lPPlNnre4P7QXXLi/KAd1vQXEhvhMmhyQh+gb40jn7Wys80zOKRISZgyPUC5qAgvfS
 lGt2gKt51XNcCr4LzYd5nwPckh5oxaFCN26wFhjEPbyrzC6p9b2BB++dFtwkD06N9aZL
 UgESZKMen7z1YdIBZEzVulnxbA/5d61Hny9Loq7VjMunDqQDk8QUmYVQaFtJDmnQUAQE
 2ZCIRqXEc6nSzwUkPdjFeqG/yqwm7XkDo0PCUXNbljNFz90XrsaYPqVwEDW/VMrIRE0e
 iAFZuw/ZRk2ursJO1qdd1rAmYTGje1J/Fc+CdBCVOuNhPuQwVW+5EUjrpVwkNslwzSll
 zSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030228; x=1706635028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zerQ22x/x8UOxAW3Wsxy4H6ymQPKhUl2gDGa7gIhMSQ=;
 b=dEvkpcZdcB7Dvm/9KL5GLbYED7kPy9+YOHK1hMtgK83EjUmaAcZiuTPGPNPaMziHhd
 Px/CwTaq75RcoYHtbvUjRYnN2UMO9a07M6hcsjaADD3jwe+GpEu93PIxZ+CeyD3nuK4y
 SH4ltd+QnlbhCTmAb2cJ07jq0pwcaf5Ilk18Jukywe5w86uqFyyh62YFdOtyGCZqjCSz
 TRKx0a0Kn57D94VDVlR2uG+9GiISY/M8/zoreA2F84A0qYeh5pLIUNzAk5PiF9PwKQZ3
 e8yfBVT9SFe/vK6NvbFK9r3Met8r9U37Q6LPbXfQYfCt3aWMsISZFqzPUnGNPIdv0BSD
 0w0w==
X-Gm-Message-State: AOJu0YzJ9FXq2/pPPKInnnsiDyFrqJwufecVCJozNMDnmeskbJTNqCI4
 JKTHQdQAbkgmdlkLBO4y17M7FuFJ8/EMoHCKpREbxRf1L5d72jSZ
X-Google-Smtp-Source: AGHT+IFYJf/p3UvTxbaPrDP1L6lX4rt0JG+wpyMa153AzYswfN/iNjN514M0YLA04CEVS/AoSAywZg==
X-Received: by 2002:a17:906:c9cf:b0:a30:393e:22af with SMTP id
 hk15-20020a170906c9cf00b00a30393e22afmr122204ejb.13.1706030228326; 
 Tue, 23 Jan 2024 09:17:08 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:08 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 06/18] video: tegra20: dc: add reset support
Date: Tue, 23 Jan 2024 19:16:21 +0200
Message-Id: <20240123171633.246057-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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

