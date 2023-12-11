Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8C5C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06CD5876A9;
	Mon, 11 Dec 2023 10:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ur9qLnHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01426876A5; Mon, 11 Dec 2023 10:01:00 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A67387682
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d06819a9cbso23185795ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285256; x=1702890056;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uf1/iXzPahiK8ZQPG6CcR29J3l0KBzMEKuJia+8OjF8=;
 b=Ur9qLnHmyF9QThLNG4gqT4k9yrpXTv4P1I7JjKMYFaUuXI1BpLpqqAxVGkk95UWeMo
 9uZoxSLWT2qGGdsy/8SOmok/UGKtgMzRrDRImUT1XQjVdpn/O6ooFkNetw6a6kTGM9IO
 YrCiBclyGK1Pd4Rt6VGA0e4TGf0uccAnVWR4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285256; x=1702890056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uf1/iXzPahiK8ZQPG6CcR29J3l0KBzMEKuJia+8OjF8=;
 b=Q4fhDXESxeVZf45x6FyvpPyOYiPw72biPqGFUxXEzb2FmG0tD0G2XYKsB0+R1EULOg
 2dVdCDzyXxl9Wp0LA4r6eo/++gMvcgp5oDU/DA2LO3U5wRvUEH5XH7cvua2fAA7HX/BK
 VD4Tfv3ptA2IgjuD/9AYr1hmhlTOmcIWBqi0C/QlrLcPn86IL0mrAgptCjlpwtKo5OUA
 YEufBJjfJkov4+ZVjnB1cdVoVcy17VmB1TqmlywhoYuPMbe/ZDYd7HG9pjYSWE35yP1r
 SN2bNLJUNGQuBK0B7UenUXCFOOqVPP5im7ZxuehDxI8VooCCI/5woYQeSG+updsC6n/x
 Bcpw==
X-Gm-Message-State: AOJu0Yx/14w2V5Hre8spECIIyb+3t5PXE2u+yp0o23hNVf6dqyJsbP6e
 PL60TKC3h+2sUOskcbIUyAD5MA==
X-Google-Smtp-Source: AGHT+IGb1FwAWH0XDKBlRilrtw33lgHf41hAoa0e8XSjqQ9jYljRVEX1Jklz3Jkl/qdy/OGsRvSLCQ==
X-Received: by 2002:a17:902:ec85:b0:1d0:6ffd:ae0e with SMTP id
 x5-20020a170902ec8500b001d06ffdae0emr1698798plg.117.1702285255803; 
 Mon, 11 Dec 2023 01:00:55 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:00:55 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 03/17] video: dw_hdmi: Extend the HPD detection
Date: Mon, 11 Dec 2023 14:29:25 +0530
Message-Id: <20231211085939.5478-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
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
 drivers/video/dw_hdmi.c             | 13 +++++++++++++
 drivers/video/rockchip/rk_hdmi.c    |  8 +++-----
 drivers/video/sunxi/sunxi_dw_hdmi.c |  8 +++-----
 include/dw_hdmi.h                   |  1 +
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index ea12a09407..0a597206f0 100644
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
index e34f532cd6..8a65f2440e 100644
--- a/drivers/video/rockchip/rk_hdmi.c
+++ b/drivers/video/rockchip/rk_hdmi.c
@@ -115,11 +115,9 @@ int rk_hdmi_probe(struct udevice *dev)
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
index 4b67a1614e..513276d812 100644
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
index 4ad8b39f84..756560e092 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -568,5 +568,6 @@ void dw_hdmi_phy_init(struct dw_hdmi *hdmi);
 int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid);
 int dw_hdmi_read_edid(struct dw_hdmi *hdmi, u8 *buf, int buf_size);
 void dw_hdmi_init(struct dw_hdmi *hdmi);
+int dw_hdmi_detect_hpd(struct dw_hdmi *hdmi);
 
 #endif
-- 
2.25.1

