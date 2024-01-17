Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B514C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A125879EE;
	Wed, 17 Jan 2024 08:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LPeI2/Kt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D74E879A3; Wed, 17 Jan 2024 08:52:25 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A25876FC
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d5ecea2e46so9676025ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477939; x=1706082739;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l236HdIEw2Gj6YnaoCn15Mekmd9lvlrckksuEPkeWPw=;
 b=LPeI2/KtqH3ie1uAAXgwdGzO1kNr5sYR7xohjJCf51ieVvbww+Wh+k86s/3/8sMxm7
 8fihvp0uhMkGnYTlDGny1JfZ9djrqty3+Hc9A/DpOyLjum3Vrg70iLNx0T4/m+NgI7Tj
 J4qtfez3RNSZcshveu5NJogIvzz2TPpaWYqpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477939; x=1706082739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l236HdIEw2Gj6YnaoCn15Mekmd9lvlrckksuEPkeWPw=;
 b=EZtzTBNfMjpZl1XJaHUIv45Ipxsc3MP+mue8KDPthwRDbON1L3OVqgRMKjt2Vm53ea
 7DnRWOAsWG8g4c6OSDpM93ydjDqhO7dnfFwikkTvZ5BwUmdFJ6iAhnDi4wZOpHOew5Hg
 VgGB7mBMhLbfdahScTpFEqEVAh17MHUgir5oZCXlnwobblzrOEa7YwoGH9i+iZhDhFVb
 VIaCSYNou8FgoiyEOAHLYJrCkgrX2KOTjz6+OYPvzYLSCCjlFTrorDZP70IrBjn/OrrD
 ELfiqIphIWXh2OomhMqWkzqpPhIkcfuWsCh14V1CMl4YoomX7mrEU0dyklFNAwu9r/SD
 C1XQ==
X-Gm-Message-State: AOJu0YziqTGD96WN6YArFfTBYHsLK5P6ZwZjICJbgQ2fXA1gI+9JsBae
 kdI6FqjJVXagAKQHLBEWD42odQ7TrBPEzg==
X-Google-Smtp-Source: AGHT+IFOfMlpZRvRaYUba5DPoGBBZDrMAq1EBEZkt4RdQyr01dEBXx7yMwbCTAjE3MudWuDmLyq6VQ==
X-Received: by 2002:a17:903:2444:b0:1d4:1f71:8fcf with SMTP id
 l4-20020a170903244400b001d41f718fcfmr11716241pls.59.1705477939189; 
 Tue, 16 Jan 2024 23:52:19 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:18 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 01/17] video: rockchip: hdmi: Detect hpd after controller
 init
Date: Wed, 17 Jan 2024 13:21:38 +0530
Message-Id: <20240117075154.58747-2-jagan@amarulasolutions.com>
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

HDP is a hardware connector event, so detect the same once the
controller and attached PHY initialization are done.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v3, v2:
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

