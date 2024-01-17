Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5421CC47DA7
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18251879A0;
	Wed, 17 Jan 2024 08:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qaK3T/N0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1B8879D8; Wed, 17 Jan 2024 08:52:40 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B20D87A14
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d5f388407bso7358595ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477954; x=1706082754;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHdQkQnmdgnYaJIJjTxMCNAhTAjrNee2jPQbtZqO0mc=;
 b=qaK3T/N0z/rMoCMHSfG/CBTdoNb0b856lm6TIgnxc5G10kt83UsK4mQoZ+z6S8nIys
 QU/O5/RVrDcTfuoOucJkTGwIenIdzv7C5pmTDzzFCLMevUfub6f3qqsC625DpX8xdyNI
 wIdeT+YML8EQpETBqZ7ihECXf+4/UysumD7ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477954; x=1706082754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHdQkQnmdgnYaJIJjTxMCNAhTAjrNee2jPQbtZqO0mc=;
 b=ahnEVmOhbDyTCxqd+gAu8ZhY1maLn0OT743O4Dtv5pQ35h7P0AfNHQNNrIuVQcqfJH
 P8dtT4mYPHurRM2cv3PV9lsklxayzLXtHCXVupYD+IVjBS11vBwi0BOeqxsxRV6rXcbK
 lDu7YxcXadACu+tLIHlKopvMpIVvT5rxYGMEpnMHWKon0bYfuu13DqAQMoUh7cU4ESiO
 Y9pMZIsbU3M2MgGbwiyYXlp8nU/rWRtralcTx1zmllyu8XZKMlYqT4sLWB90qyQMMzCl
 A/+pSW65ID3rKPD0RL2UqDNPUUGWpxK5CRL0+9JyAFpTqZnN+suHrt4PM9CoF99hzJ08
 FFtA==
X-Gm-Message-State: AOJu0YzYG3RYluVJj9mxpqpzHeK7pOMYSm5SQmoVrKIFJONvpEb4gogj
 3MxB0rsKZmVkXfTu8VIoRnlLfUgQjeYLOg==
X-Google-Smtp-Source: AGHT+IHBBIHa6E6Nvn7glj9Nf4T4HExha/kFHGVUJfhXLswjdk8RWXXLoi3cXpByjoAI/o4BoRGqhw==
X-Received: by 2002:a17:902:dac4:b0:1d3:45b7:bc26 with SMTP id
 q4-20020a170902dac400b001d345b7bc26mr6310759plx.54.1705477954230; 
 Tue, 16 Jan 2024 23:52:34 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:33 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 05/17] video: dw_hdmi: Add setup_hpd hook
Date: Wed, 17 Jan 2024 13:21:42 +0530
Message-Id: <20240117075154.58747-6-jagan@amarulasolutions.com>
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

Add support for DW HDMI Setup HPD status.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v3:
- check hdmi->ops
Changes for v2:
- none

 drivers/video/dw_hdmi.c | 3 +++
 include/dw_hdmi.h       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index 989b7ab2db..ab4811cfc7 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -1061,4 +1061,7 @@ void dw_hdmi_init(struct dw_hdmi *hdmi)
 
 	/* enable i2c client nack % arbitration error irq */
 	hdmi_write(hdmi, ~0x44, HDMI_I2CM_CTLINT);
+
+	if (hdmi->ops && hdmi->ops->setup_hpd)
+		hdmi->ops->setup_hpd(hdmi);
 }
diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
index a1f0e64507..f4d66edace 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -539,6 +539,7 @@ struct dw_hdmi;
 struct dw_hdmi_phy_ops {
 	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
 	void (*read_hpd)(struct dw_hdmi *hdmi, bool hdp_status);
+	void (*setup_hpd)(struct dw_hdmi *hdmi);
 };
 
 struct dw_hdmi {
-- 
2.25.1

