Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4A4C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D451E876A7;
	Mon, 11 Dec 2023 10:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Qs4/7hsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E13C876A7; Mon, 11 Dec 2023 10:01:08 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC010876BA
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d0aaa979f0so23304345ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285264; x=1702890064;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Mnj7OdI4LnZ36BVF/UlkNA9jO9H6+F++74rcOHuE1c=;
 b=Qs4/7hsfujePvqixKFHE29ZmPNlChuMdCHKauTOa+Fy0CSsRdRnMnfqmI4ruCG7PBn
 qroFGfQ+i51tbQg8pyBdUiCBKkfWPyGVKUpv4BIbDoCl52Sgwky9S9jShPzAkpexRgjO
 VnA83kmER/nY/ZqHMqxAb3WYZKhv6q2ymZmA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285264; x=1702890064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Mnj7OdI4LnZ36BVF/UlkNA9jO9H6+F++74rcOHuE1c=;
 b=f72qVQegrPUowUwGoDGVyE7Xg0nMLcee5brSGUIGFljx7A0pXlSa3yD7tSAeEedK6x
 GWycDpJFFGY50VNbALDlGxAskjVeID47woqJvL7CSClLgN7vBmdaPgPJDRnt7Dq4cJZ+
 RthvZHEryE8ytz3KLXcXqcR4D4w4lgtkfmDXiwCMdm9W0vjLB49h0tU1M14uN6v+4kqy
 EXKCXvUotimrt+KjGIaMjOlw12YjjoriPC/C/UslCyaz8qnMH4w34pyEvVXRSxvg7FT2
 QwbyAZAy0CKH79sw3urKuvhar1wO7TWButZ3IPO5USlPvixNF8bilopC8htQ5GGIRv9k
 RD2Q==
X-Gm-Message-State: AOJu0YxN2IiBsnB6Lq7FD05eNk5WjGLEIvO0E8wZopmVZyaV/bbWS7BG
 J/yoWRWPSEaEDick5egriohxng==
X-Google-Smtp-Source: AGHT+IHzjvrOOAzxOQdtS2BPquPem4diLgEQJC8SEOs634Xn7Vz3VQBddEJZq8Ur6tJo4r0TFTB5Kw==
X-Received: by 2002:a17:902:da91:b0:1d0:bcb2:b905 with SMTP id
 j17-20020a170902da9100b001d0bcb2b905mr1528512plx.121.1702285264099; 
 Mon, 11 Dec 2023 01:01:04 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:03 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 05/17] video: dw_hdmi: Add setup_hpd hook
Date: Mon, 11 Dec 2023 14:29:27 +0530
Message-Id: <20231211085939.5478-6-jagan@amarulasolutions.com>
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

Add support for DW HDMI Setup HPD status.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
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

