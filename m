Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C295C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9B8871C0;
	Mon, 18 Dec 2023 20:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F+0CMj5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725238715C; Mon, 18 Dec 2023 20:11:41 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 357A187505
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28b7a0d1665so743512a91.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926697; x=1703531497;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+JsM+j1K9PtobYZky9vV79n9QQZttxYnoeEDtDvgLs=;
 b=F+0CMj5VC13evKCLQ3y2BZ8yl9Zl0D5HFoYCpyO7ZGUxunlJTzG28UIf7VFpZWJWfm
 OB/BIDrSUl5x03v50L9tQQKn7MfkzZ0rR3wcYwqvrN9sdwJrY/oPDQVK5+MGs70Vn6qg
 0UecFaG94QKl6mzgF0jjoguocBRlUxSpc6FzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926697; x=1703531497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+JsM+j1K9PtobYZky9vV79n9QQZttxYnoeEDtDvgLs=;
 b=dGvQtWlm4CJTZTKCMRcDM+semf8wbCDJFZygINREqaK3R74E9Ui+yQrXKc7hVoSL2B
 JetlQ3DExoBH1zgsFVCFNlDBbFfzrzHpxvgCL9MDr6utqgeqPSVfHagRbcpV28/QrMom
 an7a82PX9Oz5K88tTLhkPQoiHCP+PxBA7RGYBfpLbYCm1iN2U/AJoa2K5pJzPYmuK7y2
 er9brYPJBkOT04WN2ioAj7xooDbeqoROudicAt6PWdNXuqVBRP433AMFf3+K2j9kF/7M
 IWADn3F/PaFdtjCEvAXBMp3z1kqRyCRz0QWbsIoywqbEDoB0TSjFB0n8WrUhRANCFV6/
 xUJA==
X-Gm-Message-State: AOJu0YzhyZYKWPHfHeWw6roXmAU0+rCIsrDBzWnvY/JwrWFoeiSjFe3B
 jilhHhbdNv2/g6kQRwc2HBy6Cl/uUj8SNCeBiZPiUQ==
X-Google-Smtp-Source: AGHT+IFvALH5WRBIgPK2KzruUwY5h7h+Ed182QDApzNRkB9Rzy7rD6qwIjMRUinTH7PJUMYJkeMZFw==
X-Received: by 2002:a17:90a:2b08:b0:28b:105c:2ce4 with SMTP id
 x8-20020a17090a2b0800b0028b105c2ce4mr2844311pjc.66.1702926697540; 
 Mon, 18 Dec 2023 11:11:37 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:11:36 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 03/17] video: dw_hdmi: Extend the HPD detection
Date: Tue, 19 Dec 2023 00:41:00 +0530
Message-Id: <20231218191114.129329-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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
Changes for v2:
- none

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

