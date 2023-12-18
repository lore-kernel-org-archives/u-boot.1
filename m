Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2571FC46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90D59874CA;
	Mon, 18 Dec 2023 20:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H4Blz1a3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3F7871C0; Mon, 18 Dec 2023 20:11:33 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C988747A
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28b4d7bf8bdso818356a91.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926690; x=1703531490;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5CPSZSVSZEhnTkUxeBYjhQcEGgMTeuhLENLedn8m1A=;
 b=H4Blz1a3ZlnGm4GCHfpdc9+owUWDisZoAGTrQsa1ZOCpacCgbKoUoJP2AAo8cV3b5m
 m/YGYJe8vvvK5EdwTIs2H0kLaXJ32RR15hv6JpLi+OsKRYx5OdTUy9XFeSvFK/to2xt8
 US0RHPIAV2clZRC/bxOE54hoxGKyEb4ApOVyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926690; x=1703531490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5CPSZSVSZEhnTkUxeBYjhQcEGgMTeuhLENLedn8m1A=;
 b=crSAIKvgi1imCzWd03uzoqR5UvoEz1jXosdYMheIO7kyRssttKOEnOgLKOIXK6apC4
 MlaonC9O4kh3JFvArq84tiCLTmONKMQnmOGBvjQEd914ihp0k8/PWYigvfYKCOqKIGic
 0XWOzjOmEOiL6mCbh+EpQcBJrWZkMwarNrjhDqD0BH7mR3vovIW0+gIxz2bVW1Xm6VKi
 IYzi1LNe/Pq9Hwy3qpNJ2A2VD8HAeTj96ogvGyJzZ1PKAks/bIs0j49B4NNJub4INd+K
 er9hwbJu/DBqKOOuqw9XRdrnzjfwCAMI6SbADoZCn/kkNfkjjLxihbMy5MiIORt18bEg
 etFw==
X-Gm-Message-State: AOJu0Yx3oVZFzNnJpl5kjIU2IsEi4bFZ85NEIZbo4FILHAiYcAi6DTCI
 IYst+X1eDFUFE3BAPR3SkvO06Q==
X-Google-Smtp-Source: AGHT+IGhhj402xnhaVXUROU8SjfzC86v/kui2Ptv/4mb2Zk3kz4ZcPPBGUd8eGoa/ylp1jUF/v09ZA==
X-Received: by 2002:a17:90a:f492:b0:28b:b6fa:82ec with SMTP id
 bx18-20020a17090af49200b0028bb6fa82ecmr34101pjb.52.1702926689733; 
 Mon, 18 Dec 2023 11:11:29 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:11:29 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 01/17] video: rockchip: hdmi: Detect hpd after controller
 init
Date: Tue, 19 Dec 2023 00:40:58 +0530
Message-Id: <20231218191114.129329-2-jagan@amarulasolutions.com>
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

HDP is a hardware connector event, so detect the same once the
controller and attached PHY initialization are done.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- none

 drivers/video/rockchip/rk_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/rk_hdmi.c
index 8dcd4d5964..b75a174489 100644
--- a/drivers/video/rockchip/rk_hdmi.c
+++ b/drivers/video/rockchip/rk_hdmi.c
@@ -112,14 +112,14 @@ int rk_hdmi_probe(struct udevice *dev)
 	struct dw_hdmi *hdmi = &priv->hdmi;
 	int ret;
 
+	dw_hdmi_init(hdmi);
+	dw_hdmi_phy_init(hdmi);
+
 	ret = dw_hdmi_phy_wait_for_hpd(hdmi);
 	if (ret < 0) {
 		debug("hdmi can not get hpd signal\n");
 		return -1;
 	}
 
-	dw_hdmi_init(hdmi);
-	dw_hdmi_phy_init(hdmi);
-
 	return 0;
 }
-- 
2.25.1

