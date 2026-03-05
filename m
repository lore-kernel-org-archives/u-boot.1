Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FD3EEF31C
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 08:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E919B83FC5;
	Thu,  5 Mar 2026 09:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I1nyk626";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4BD783F93; Thu,  5 Mar 2026 09:49:24 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEEFB83FAF
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 09:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b611274bso2781617f8f.3
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772700562; x=1773305362;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JNC/SVtbbF1gjifGF7rhJALkr26J0MzAHs+IK1Bd9cs=;
 b=I1nyk626yaA/3nx+sBS3rNKsZvUkjDlbLUwYIIxcmcqtRt157lHZNgODJTrGeUwiux
 dFykkQ7CaUsUg3oV6Io8u/I0zcew13EOUjYa1jBKW8lwv5+K7PhbLzH0qOYDH+Z5CQOv
 90xo5aWewLgj1yy6YaKco+aWq0p4jQHEFU6RBIt8yn3l9sPhBCzSLXCdYNPEKXilhDw1
 L9bXzzy7VVNNx+3+xbWgtgfpt6x16PVISlbX6E2w6yz76C+HB1DEr7k2MgA7qtDeLqOH
 D5mfTbsC1E1RCqFdOkQm7UJsuqFpeZlFZdsaqH7HgtKYMh+lb6aYbdvUEhp7BjvAGnGi
 d3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772700562; x=1773305362;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JNC/SVtbbF1gjifGF7rhJALkr26J0MzAHs+IK1Bd9cs=;
 b=fBpTiZOimHIZVqC1j5GsMvPaXiBNxWzxejtN7fZRoGwEqBpQiUYfkUwkMhWShvEdu9
 AeYSe38IjYd6D8uOrLiiZ3z6vur/Bx3eGnn7Q+Rz0SCwLhAuf1cLWxRvn+bUer7uVZwK
 zEMTWs49j6pmtgiVbpmi6xZchPoVuNS+A2wRNxdkkfCfc180241kg7V/bMAdyXi/afjM
 QSQK6FcUjuV20p24BR5RIXqv1o3k39HdwXgHB290tBVWuZRfPbuDxeIKuIOm1qW5r8Le
 bcP5YnfME0MDXwfquBsHMnAfazOy3iY2fiJM0aEKQeiypAwjDX1WSfqgzkOIVuIceYvE
 94Bw==
X-Gm-Message-State: AOJu0YzMfTAA4QqTPQ3HrLGal1zDweW6R7Bwoz8hc5W/ZUillHo726U0
 FIwrTbkxhgYTv1J4p7kFxpadY0QJ5uvPBWOfAHCod9gEqPW07Ymx7tklfETPQam6lOo=
X-Gm-Gg: ATEYQzxDxlUAjGTfyuA4y6+hlz4kCOgL1RUbT/Ie+BhkcY6OecmiJ7/L9H7FXWbydgJ
 InXr3AZybJsI4xtwozfUkWf2SHXFfqwHXFsqPcTtQs/f3aCD3CE4mUVucXcnvjxT3rCl85vtSLD
 2eWRTzRIM5+X1IrbOhyBoTH2ySjLKGwvvqdJGxp5nakk3Rj1/w/XXboJW5TuqqH7tAS7pUDiM6x
 SJ5tfvToGUB2ZL0oeRacTi30sTbdjLLzu3vBibkKSyCyqoF+x9lq5VS/qnYdT6y/KpiQbcXmYX+
 DQBhN0Rmt5ZCdGZ2BI/lUUSiwoljnYobFKO0tqXCc9z1R/FUaTsUyh2R8mzcJ8Dy002UnR46da4
 TqabkS4SJGyxRPtNye8YPsq8xeZYcKBLO/GC2ku94SLZWC6Xdu1McYYJzomGeMb5jMbE+BITnce
 NTbWLovuUqPqR/Q/mB3oHcTeMKlL/jfuXjOo+Yhv/muMLpdF/YqBj4/g5BgWJvfkNvZy3XOSZCy
 z+3xaIG8VEW+WGiHDmEvQ==
X-Received: by 2002:a05:600c:621b:b0:483:c490:8c0 with SMTP id
 5b1f17b1804b1-485198554cemr85557045e9.11.1772700562307; 
 Thu, 05 Mar 2026 00:49:22 -0800 (PST)
Received: from [192.168.1.64]
 (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net.
 [2a02:8428:e55b:1101:1e41:304e:170b:482f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b03db76bsm33638231f8f.18.2026.03.05.00.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 00:49:22 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 05 Mar 2026 09:49:02 +0100
Subject: [PATCH v3 1/3] drivers: ufs: handle return values of ufs_hba_ops
 callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ufs-ufs_hba_ops-cleanup-v3-1-e153ffab98f5@baylibre.com>
References: <20260305-ufs-ufs_hba_ops-cleanup-v3-0-e153ffab98f5@baylibre.com>
In-Reply-To: <20260305-ufs-ufs_hba_ops-cleanup-v3-0-e153ffab98f5@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

The return values of ufshcd_ops_link_startup_notify(),
ufshcd_ops_hce_enable_notify(), ufshcd_ops_init(), and
ufshcd_device_reset() are currently ignored.

Check and propagate these return values properly and emit appropriate
error messages on error.

While at it, remove the ufshcd_device_reset() wrapper, which just call
ufshcd_device_reset().

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs-uclass.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3c8e4299259..c09f61aa420 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -127,11 +127,6 @@ static void ufshcd_print_pwr_info(struct ufs_hba *hba)
 		hba->pwr_info.hs_rate);
 }
 
-static void ufshcd_device_reset(struct ufs_hba *hba)
-{
-	ufshcd_vops_device_reset(hba);
-}
-
 /**
  * ufshcd_ready_for_uic_cmd - Check if controller is ready
  *                            to accept UIC commands
@@ -512,7 +507,9 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 	int retries = DME_LINKSTARTUP_RETRIES;
 
 	do {
-		ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
+		ret = ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
+		if (ret)
+			goto out;
 
 		ret = ufshcd_dme_link_startup(hba);
 
@@ -598,12 +595,18 @@ static inline void ufshcd_hba_start(struct ufs_hba *hba)
 static int ufshcd_hba_enable(struct ufs_hba *hba)
 {
 	int retry;
+	int ret;
 
 	if (!ufshcd_is_hba_active(hba))
 		/* change controller state to "reset state" */
 		ufshcd_hba_stop(hba);
 
-	ufshcd_ops_hce_enable_notify(hba, PRE_CHANGE);
+	ret = ufshcd_ops_hce_enable_notify(hba, PRE_CHANGE);
+	if (ret) {
+		dev_err(hba->dev, "Controller enable notify PRE_CHANGE failed: %i\n",
+			ret);
+		return ret;
+	}
 
 	/* start controller initialization sequence */
 	ufshcd_hba_start(hba);
@@ -635,7 +638,12 @@ static int ufshcd_hba_enable(struct ufs_hba *hba)
 	/* enable UIC related interrupts */
 	ufshcd_enable_intr(hba, UFSHCD_UIC_MASK);
 
-	ufshcd_ops_hce_enable_notify(hba, POST_CHANGE);
+	ret = ufshcd_ops_hce_enable_notify(hba, POST_CHANGE);
+	if (ret) {
+		dev_err(hba->dev, "Controller enable notify POST_CHANGE failed: %i\n",
+			ret);
+		return ret;
+	}
 
 	return 0;
 }
@@ -2182,7 +2190,11 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	/* Set descriptor lengths to specification defaults */
 	ufshcd_def_desc_sizes(hba);
 
-	ufshcd_ops_init(hba);
+	err = ufshcd_ops_init(hba);
+	if (err) {
+		dev_err(hba->dev, "Host controller init failed: %i\n", err);
+		return err;
+	}
 
 	/* Read capabilities registers */
 	hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
@@ -2226,7 +2238,11 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	mb(); /* flush previous writes */
 
 	/* Reset the attached device */
-	ufshcd_device_reset(hba);
+	err = ufshcd_vops_device_reset(hba);
+	if (err) {
+		dev_err(hba->dev, "Failed to reset attached device: %i\n", err);
+		return err;
+	}
 
 	err = ufshcd_hba_enable(hba);
 	if (err) {

-- 
2.52.0

