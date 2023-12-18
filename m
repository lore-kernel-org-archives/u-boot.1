Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CF8C46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 167D88755B;
	Mon, 18 Dec 2023 20:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qsrtHFNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C58E8715C; Mon, 18 Dec 2023 20:11:49 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B8E0875E9
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d337dc9697so29410475ad.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926705; x=1703531505;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+idfjXEx7xcR45Sw8/x+FO8QwQU8BXe47ggiAU3oKU=;
 b=qsrtHFNLuJLCeLxP+UmnDNEZXukySpjOHmh61bkhtff/ULblTeG7gtVbKoasVmt3Kn
 0UN2ymE73myQCjwRqz53ckyRh1Ox4oUn3/zwma2gGnDXArTv3tQWBsD7Yh6Bv21SNE6v
 KYhrnBbn6CzMmN0FQSMpV/A3A/8rhiaMkj9eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926705; x=1703531505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+idfjXEx7xcR45Sw8/x+FO8QwQU8BXe47ggiAU3oKU=;
 b=jQ5YutZMrrfhuQaPjyZJfADawaugvvKXOAYNb94dF1uQMZjiXeilF7y2s71AGXPEng
 FfzegngFUwpRuXECVS3n2bTyXSNoA6dd+hv0VTMw/WfEE2rSp+ILVSDqK0nGFGvR/gAr
 kaTH5ObS4Vwi0TdpcIy+e99ag+RFSwMGO+TUP7OgpbqLSy5W8Aub3kxhlA15Ngdu7S96
 dY69qW+HsUX9n+Dikx0YBCc08aEFIa2PzLvgii+KYkhFgCf/NiVvFmLD0sak6zBaPa/7
 Mhb7w5oIz4/cCRO7pmg58+TJQHV4xq+oMnLP8vRkrzNTdi7It0n3qJCKAQv4UgdASx9w
 vnRQ==
X-Gm-Message-State: AOJu0Yw3qQ0S0nuNCXQ58LgYTssW1cTiLeibE6wEag24mGOyuiJfsCQz
 C+2K/QQNzXr4xa3xaRd65M2kyg==
X-Google-Smtp-Source: AGHT+IFlHFEHRJB+xfPrImltHn7eubtrqHqx9nH3Tx711a0JUd60nisC4mXygZX8xzPLh6nPxHzJdQ==
X-Received: by 2002:a17:902:b412:b0:1d0:69dc:954e with SMTP id
 x18-20020a170902b41200b001d069dc954emr17487379plr.24.1702926705329; 
 Mon, 18 Dec 2023 11:11:45 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:11:45 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 05/17] video: dw_hdmi: Add setup_hpd hook
Date: Tue, 19 Dec 2023 00:41:02 +0530
Message-Id: <20231218191114.129329-6-jagan@amarulasolutions.com>
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

Add support for DW HDMI Setup HPD status.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- none

 drivers/video/dw_hdmi.c | 3 +++
 include/dw_hdmi.h       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index 172e6b45a6..3e0e20e59b 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -1080,4 +1080,7 @@ void dw_hdmi_init(struct dw_hdmi *hdmi)
 
 	/* enable i2c client nack % arbitration error irq */
 	hdmi_write(hdmi, ~0x44, HDMI_I2CM_CTLINT);
+
+	if (hdmi->ops->setup_hpd)
+		hdmi->ops->setup_hpd(hdmi);
 }
diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
index d6de472cee..9a44b9e90c 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -539,6 +539,7 @@ struct dw_hdmi;
 struct dw_hdmi_phy_ops {
 	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
 	void (*read_hpd)(struct dw_hdmi *hdmi, bool hdp_status);
+	void (*setup_hpd)(struct dw_hdmi *hdmi);
 };
 
 struct dw_hdmi_plat_data {
-- 
2.25.1

