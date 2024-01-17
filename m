Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447D7C47DA7
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82260879E7;
	Wed, 17 Jan 2024 08:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nhR8Shat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF134879A3; Wed, 17 Jan 2024 08:52:31 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9764D86F67
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d5b87ef0d3so28943455ad.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477947; x=1706082747;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcY3tcF9lvTUIAIHxg7y/BWxLqFSNGB/AHAGsXlAnYs=;
 b=nhR8ShatKj9gepoQy9lQ5bnyK+/6k3LVRUR+/QaEtVwbpWKV+HGNqF6biKY4KeDCEw
 ghOCHy8u/xED0B8uNUe04VC8dA0rFK6W1dbCoW3QhmFRQqwzA6dRRwNP+/7wFbdancAq
 ACmmyR0Oi+KIAa8D5oLc84bmQdry3h1ieS73w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477947; x=1706082747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcY3tcF9lvTUIAIHxg7y/BWxLqFSNGB/AHAGsXlAnYs=;
 b=lYN61T7SOr+c63zAaQYzesSyH+9eCrpChw8d9MUO92U9kbBODke0enhpkGWxOy0mnQ
 Vl5moFWve/VuZtNE2kdX4n7fBmZVWmGPG8dG1Z7AkjuXhUp9ggfRfzh/vbPuX9I0cOV1
 3xaDuTI5Hss2JKz/amX2AS7R3QIr5YX74Kqxs0thGhMr3MF9dlNCguE0saSv/rlVngIW
 wLnvfphu8Fw261nnsoqS6RkJPbWL8TwJ8Z+DSnEEHxCvlJMp4I6uBnZYh1fdp2tegeZb
 vdUo9a8/uhKes+YFuSVnBZloFfNPR6gi6rCqDDOm0WDRJhy1mroXOQ3QzCesXrHoIra2
 X8YA==
X-Gm-Message-State: AOJu0YzDpHiVBDwlZZjg2jhdvDyyJr24e/D0tvwDZo4FMjPFHkVX0CC+
 37Iss1Th83R/UI6/LsShTu4HqZAaNrLfVA==
X-Google-Smtp-Source: AGHT+IHx1lDB7xocNjnTNAIpEMlCozAJLIpPMcDA0+R31O7nqXXqP6mwtP3eOXZ9a56HAC3R4f4HOg==
X-Received: by 2002:a17:902:eb86:b0:1d4:be6f:5eab with SMTP id
 q6-20020a170902eb8600b001d4be6f5eabmr11594160plg.6.1705477947060; 
 Tue, 16 Jan 2024 23:52:27 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:26 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 03/17] video: dw_hdmi: Extend the HPD detection
Date: Wed, 17 Jan 2024 13:21:40 +0530
Message-Id: <20240117075154.58747-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
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

From: Jagan Teki <jagan@edgeble.ai>

HPD detection on some DW HDMIdesigned SoC's would need to read and
setup the HPD status explicitly.

So, extend the HPD detection code by adding the dw_hdmi_detect_hpd
function and move the default detection code caller there.

The new read and setup hdp will integrate the same function in
later patches.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v3, v2:
- none

 drivers/video/dw_hdmi.c             | 13 +++++++++++++
 drivers/video/rockchip/rk_hdmi.c    |  8 +++-----
 drivers/video/sunxi/sunxi_dw_hdmi.c |  8 +++-----
 include/dw_hdmi.h                   |  1 +
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index 4914ba6146..3a3b9b7a21 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -936,6 +936,19 @@ int dw_hdmi_phy_wait_for_hpd(struct dw_hdmi *hdmi)
 	return -1;
 }
 
+int dw_hdmi_detect_hpd(struct dw_hdmi *hdmi)
+{
+	int ret;
+
+	ret = dw_hdmi_phy_wait_for_hpd(hdmi);
+	if (ret < 0) {
+		debug("hdmi can not get hpd signal\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 void dw_hdmi_phy_init(struct dw_hdmi *hdmi)
 {
 	/* enable phy i2cm done irq */
diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/rk_hdmi.c
index d5b5a529d2..16f6303513 100644
--- a/drivers/video/rockchip/rk_hdmi.c
+++ b/drivers/video/rockchip/rk_hdmi.c
@@ -114,11 +114,9 @@ int rk_hdmi_probe(struct udevice *dev)
 	dw_hdmi_init(hdmi);
 	dw_hdmi_phy_init(hdmi);
 
-	ret = dw_hdmi_phy_wait_for_hpd(hdmi);
-	if (ret < 0) {
-		debug("hdmi can not get hpd signal\n");
-		return -1;
-	}
+	ret = dw_hdmi_detect_hpd(hdmi);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/sunxi_dw_hdmi.c
index 986e69d66b..a5e8d39e98 100644
--- a/drivers/video/sunxi/sunxi_dw_hdmi.c
+++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
@@ -358,11 +358,9 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev)
 
 	sunxi_dw_hdmi_phy_init(&priv->hdmi);
 
-	ret = dw_hdmi_phy_wait_for_hpd(&priv->hdmi);
-	if (ret < 0) {
-		debug("hdmi can not get hpd signal\n");
-		return -1;
-	}
+	ret = dw_hdmi_detect_hpd(&priv->hdmi);
+	if (ret < 0)
+		return ret;
 
 	dw_hdmi_init(&priv->hdmi);
 
diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
index 17bdd2dbf9..ba2ce5ea7f 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -562,5 +562,6 @@ void dw_hdmi_phy_init(struct dw_hdmi *hdmi);
 int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid);
 int dw_hdmi_read_edid(struct dw_hdmi *hdmi, u8 *buf, int buf_size);
 void dw_hdmi_init(struct dw_hdmi *hdmi);
+int dw_hdmi_detect_hpd(struct dw_hdmi *hdmi);
 
 #endif
-- 
2.25.1

