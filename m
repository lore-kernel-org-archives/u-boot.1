Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E44C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9406F875B6;
	Mon, 18 Dec 2023 20:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OwpHWZS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446F987578; Mon, 18 Dec 2023 20:11:45 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EDE8874ED
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5bcfc508d14so2869042a12.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926701; x=1703531501;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPg+m5HZ6I3LK6nZnG4Ei8RRT7tmgMvNqIyj3YZ1Rdk=;
 b=OwpHWZS6WeiU1UNzZi5177IXgwYr90Rz3HifE7VnW2kyFVLD0B4XuE+RSEbNIhjkId
 qROuFZ0lNAnuPmY41yLdzPQL8XgzlapT/kkpvta6pgLFyF7s+lvOK6ZZdEVj17B2g4gI
 ihDR3hE7gbzaLga4t4IdlDDg07guLP0odsaH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926701; x=1703531501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPg+m5HZ6I3LK6nZnG4Ei8RRT7tmgMvNqIyj3YZ1Rdk=;
 b=KB5BGLLOD5shPY9b/0dSqjAuzU4f+nV+JtpzGY8VszL319sZOTJ3NO18cbElUEyoOu
 KS5IVdE3gdSFQtPd+AGvYsycAyGfcdhH6C/Bsd3atLziL9z4rWE5WwnQBHK7IYzF5fE8
 tFAuz5z/qyCxTRI1xmZZKVGyh0i4g09gCv1ZlkczmdW8NSJ8V4I7w6Cvirs9CCzKZrFa
 y7cCPZwh04IfmRKmLb8E2i+1/dLS0WvwRajyoAnwcfKePdo2kDza7JPepYT5fbfOv7Tm
 cuOcLNnm9iPpXSTuSKimKUG2Na+nvG0ugmdJUgHf4Zb32aab6KoayZZN4FGeB7zfXmoB
 1PMg==
X-Gm-Message-State: AOJu0YwAx6nJUndj/i7Lx+fZ3ylzFUTvGuimYzhb8NfhenvkJfCUrOOO
 pcXQJ0rr2B5H9jabUvOPAobCxA==
X-Google-Smtp-Source: AGHT+IEWbRMjWgSJbUgPBiRlyXsFnpX8zSluV84jnXb2mALedB/XwWUI8EWRkmEaJIVKOXZ4qMf+Tw==
X-Received: by 2002:a17:90b:903:b0:28b:683b:7954 with SMTP id
 bo3-20020a17090b090300b0028b683b7954mr1486168pjb.88.1702926701481; 
 Mon, 18 Dec 2023 11:11:41 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:11:41 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 04/17] video: dw_hdmi: Add read_hpd hook
Date: Tue, 19 Dec 2023 00:41:01 +0530
Message-Id: <20231218191114.129329-5-jagan@amarulasolutions.com>
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

Add support for DW HDMI Read HPD status.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- none

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

