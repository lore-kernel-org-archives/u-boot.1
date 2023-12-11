Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EA9C46CC5
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B96087661;
	Mon, 11 Dec 2023 10:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C9A8JkDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F6F875FE; Mon, 11 Dec 2023 10:00:47 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 936D887682
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5c1f8b0c149so2159655a12.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285244; x=1702890044;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfhFmISy7TpLID85G+fj1JtvnjYvzFcqsx7bGP/aKbc=;
 b=C9A8JkDQFhcmii7ixW7yBQBPpezx9q0U+ou7ca2VzPKjnpG8Bv7nRSWauMwASyAffz
 ARqgKOP2JLp1H3IrAwY/yCEPsoNUpTwr4r+k5ujlK/rXbpdEMnM/KGddfWAeOg5uaR08
 vcqyOxvKIVKeL/egme9zbGOy05BkiOP0PsysM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285244; x=1702890044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfhFmISy7TpLID85G+fj1JtvnjYvzFcqsx7bGP/aKbc=;
 b=a/kDX1tVbvkb97vfm0rsbQ17xwNoQzk93Ogbb9R3ZlYKOUBVYhhtJJXqEonnUv2aHi
 AE9yOr9Ifniq9tXZg8nXT9RbuU9/MMaBw67xgMBgEeWnhKv/5/kohkUSu8Vw0rqkRWcB
 eSoOgHabXlfw1pOZ6ZPkqBOe8dfIyUW1jjmAqkVHsgp5fn704rc6e9tDEQni924C1IDr
 ctSFNaTHMsBy3Atbjn+zhu5tCCe6dz6nNG2E8x9Z5+9hymCzDBUIqh+GFaTV7m9roDRW
 tCQaQN9RV7YzjJP23XV3Zv52L23hgie4ZuC9w0ksGrL1JgsyAmysElf1Imxw9GqyI1+L
 HiBQ==
X-Gm-Message-State: AOJu0YxjsNS7IzZfPYgNWI+MyBq06E7JEBHkVQ4cT4s8ZXnmFRxEZ/5R
 PITfuWSylWp6N2vVfS3V0cm/lw==
X-Google-Smtp-Source: AGHT+IGkXQb1IQ55IGUXFKAftoBOoa0nYD84albETXKAjEffq79gLW3vshqHYVZXX3o2maVOO+aWJg==
X-Received: by 2002:a05:6a20:914b:b0:18b:aceb:7a79 with SMTP id
 x11-20020a056a20914b00b0018baceb7a79mr1747848pzc.12.1702285243913; 
 Mon, 11 Dec 2023 01:00:43 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:00:43 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 01/17] video: rockchip: hdmi: Detect hpd after controller init
Date: Mon, 11 Dec 2023 14:29:23 +0530
Message-Id: <20231211085939.5478-2-jagan@amarulasolutions.com>
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

HDP is a hardware connector event, so detect the same once the
controller and attached PHY initialization are done.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
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

