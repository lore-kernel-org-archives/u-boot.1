Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D98C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766C9876C1;
	Mon, 11 Dec 2023 10:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qfabxFMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE09876BD; Mon, 11 Dec 2023 10:01:04 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17911876B4
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d0c4d84bf6so22915225ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285260; x=1702890060;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6q9bwNqhqyuVzPURRT4RClZQyYkBtiIYyl3yAVR5sg=;
 b=qfabxFMYRfONSFRxR7RNorMuW6Tzea1Lt5feIj5gOXqBGV+SQStnWbjEg5RR3eCUnc
 UNYMKaqZhXIoMG+id9ymPht2kTfPozqeZz5aAE2z3TQcevCyIxrwVhQjVG6y1d12shVZ
 3JJKpSRZVzGUZY/1F1jZVLo+N1qCq6r3hPhFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285260; x=1702890060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6q9bwNqhqyuVzPURRT4RClZQyYkBtiIYyl3yAVR5sg=;
 b=kLeGJXWgYw2OQbIigZ1QnYwzV1YKYcD5y3pDrQUtUMJdfLC6J207p1JNeWbYKLu8Q6
 m8PTiW9wKW0BqR5zFEfMRxCrkJOyf7ky7ASjB61TvxBDStKUFvwZJ0i9D8seF2ocanbP
 hThDcT+ZF3SPhwCnB92y6nG/5NqQAZ7ha7s8Q8ZBS4izp+5PC9ClGKhRxAxE2FGgryXa
 zXKZV8a42WDsUXzGjCstj2m6ZSSJi5pKXGtKeHffiOqSuonqkawGEo8QHN+6InlzDHvb
 dFlJKB2W3dXgJsgmqxmj+PstFuDPj/KnQbvGpga5MfipLN2dNIh7t2ukKxSS9W0C0Phl
 godg==
X-Gm-Message-State: AOJu0YwqtyL1TlDrwXKvhoTPAV7JmJtixhNYQiZFsKwmdXqQGgWAV4XX
 TZI/W8ZQwHvS11FAPscvY+wbvg==
X-Google-Smtp-Source: AGHT+IHrqfYNg9LXrfWw9fr3BYCCspcqwGKBz1x/8Atvdn5QD1ThFNJV3jLTcV1N5FokGh3E+oGqLQ==
X-Received: by 2002:a17:902:8696:b0:1d2:eea4:a7cd with SMTP id
 g22-20020a170902869600b001d2eea4a7cdmr1505743plo.15.1702285259978; 
 Mon, 11 Dec 2023 01:00:59 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:00:59 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 04/17] video: dw_hdmi: Add read_hpd hook
Date: Mon, 11 Dec 2023 14:29:26 +0530
Message-Id: <20231211085939.5478-5-jagan@amarulasolutions.com>
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

Add support for DW HDMI Read HPD status.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
 drivers/video/dw_hdmi.c | 3 +++
 include/dw_hdmi.h       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index 0a597206f0..172e6b45a6 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -946,6 +946,9 @@ int dw_hdmi_detect_hpd(struct dw_hdmi *hdmi)
 		return -ENODEV;
 	}
 
+	if (hdmi->ops->read_hpd)
+		hdmi->ops->read_hpd(hdmi, true);
+
 	return 0;
 }
 
diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
index 756560e092..d6de472cee 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -538,6 +538,7 @@ struct dw_hdmi;
 
 struct dw_hdmi_phy_ops {
 	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
+	void (*read_hpd)(struct dw_hdmi *hdmi, bool hdp_status);
 };
 
 struct dw_hdmi_plat_data {
-- 
2.25.1

