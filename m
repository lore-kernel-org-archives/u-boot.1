Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8417DEF0702
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0594783D9C;
	Tue, 10 Feb 2026 17:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g0CsYq4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0352583DB6; Tue, 10 Feb 2026 17:22:52 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D45283CE3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4359a302794so2818143f8f.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770740569; x=1771345369;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JNC/SVtbbF1gjifGF7rhJALkr26J0MzAHs+IK1Bd9cs=;
 b=g0CsYq4BDvLMmIRNCRAqilw83+N4YxdIkCobrcxmukUvafxk45p4XKwMc/HbAHlPe7
 9ExcjpfhIjz3WWPvpZrqAEylQ3Ffd8+Ktvg4Fcl+Towijz38HZQxLJAqPU7pyw6MuVhc
 cirsrXY6S1sINwfdlxwfG8hbYO9zUldmMhW2vFBTmUN/mLVa91a4sYQ215K+NV4q9MWi
 oS32jKcG6+6vwQmyIlWkiv0hvD86wtF/kghowM11K0M1KzAHl1oYci5JtfEjoF2RH507
 t52WNMzbXGryvk+5jqBRaT+TsqMDFJ4nKfCWQVZPkfMPD/bwOPIU6cbKDSMBH3T7i/a0
 I7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770740569; x=1771345369;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JNC/SVtbbF1gjifGF7rhJALkr26J0MzAHs+IK1Bd9cs=;
 b=XRZgTqjPyTInegMAF7JnUwKVlvtIq+AUL7xdCh6J4QZ5TKUk4I4RLfpwhZj9mEvClQ
 1xEbsLb0JKWKpnVygaYxDsR40nhS+dHhXQBogqbttEXX1X+q7qHx65a5ZJBe3hUrAJu5
 zWzP5xprixEDO3/lcEHkviwbsjlO6u/HWwjJOib2Jt0Vh+6Lts93tcsGG+I2ajY4FQzO
 lOgnF5TesOuHNjYk/4H4rE7uQ1cb0borGwTC12tReEWfSsFu5xyDm+vlKxNNnyIc+sol
 pwuw1QdrHLcFVScKv+KUEBgeQ/EOJjq7PR4uuo6LRk04jr4bqm/AdYlbTjaN4gvI8Oct
 SH8g==
X-Gm-Message-State: AOJu0YwQMatVHpkmDPtDkA53l1JfmtS5d4QRcbSZvsAn1qOjUib1u+ls
 0dkkA5WlieqRdbq1y6edajr6YQELNlRseokPlBMsj/KBIrD4MrfLdrqoIz9I/1+WXn4=
X-Gm-Gg: AZuq6aJ0h8f6Oz4ymi2jz1KAN3j1woncrxoW33Fopof7BwBCW43BWs7iNkRDJ20gL4u
 AYXMVbo87iXqI9g948h44D7mt+92EQRcFYdSCKMd6nYnnzkhQcEBNXy4cuoFWL0RD4tY3/CprM4
 P7zwumk5Twx698SOfMU1qMKd/1oMwXN0ZXfilXO99HVRim8A2Y0iy4H0ciKjZ47uLAgZkaE9YLi
 9PNmn8j9K8zwNlxKB+dgyNdCZVbwKxWlOzWAbwiTS6QCGOy90moUYe+waKkvhlaGY2P2YR9+kUV
 tsmDjiRLRIqm6aQe7kXL8hK9NtByIIG34oTYTVcxXNUjl1tn3iyiRhIINsyqy18WFWyYCkgRhzi
 amBdNk/NbASrWCyItFoaR7lKuIwm28j3PmjEk0r3kS3VcULS5OpfW2UqFRKeICR2mjDFpZRuj7v
 oAPKwe4hgJ4z8KqrFurH8Kk/zAuVqJht7eRLB7NItO8aFODY+zWHXKKsRgXjVNe4NVAbVR8bWLc
 GWQDUrDnkLWh5nnQtsyGQ==
X-Received: by 2002:a05:6000:2c08:b0:437:6dac:4580 with SMTP id
 ffacd0b85a97d-4376dac47cdmr11563778f8f.62.1770740569422; 
 Tue, 10 Feb 2026 08:22:49 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-43a2-d2f0-c793-0a1b.rev.sfr.net.
 [2a02:842a:d52e:6101:43a2:d2f0:c793:a1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd4a1sm35185402f8f.17.2026.02.10.08.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 08:22:49 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 10 Feb 2026 17:22:43 +0100
Subject: [PATCH v2 1/3] drivers: ufs: handle return values of ufs_hba_ops
 callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-ufs-ufs_hba_ops-cleanup-v2-1-dd73da21aa92@baylibre.com>
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
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

