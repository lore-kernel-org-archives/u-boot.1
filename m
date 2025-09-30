Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F07CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30CAB834D4;
	Tue, 30 Sep 2025 17:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ztwd6F8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E54FE800B1; Tue, 30 Sep 2025 17:52:26 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0221F83335
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso3786830f8f.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759247544; x=1759852344; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wYPBbFOlnFi8XwomogB2dUHMhH5ng5yEHyiZ3X3UYRw=;
 b=Ztwd6F8nWCh+v53L4yot+4iSJe4M281L5pyCRvurmhzBr4B/2QUX+SBcj/UNm/vnK0
 ut+HP1lQ/eIbkiWHEfoRK5UxrP5/4ey0JrkiDioUJAbzy3VtBdsv6Vg11Fz41CnXaLpX
 niQsf+I2Bxxm88wXTH+AsM/olUdtIDngpOKKc4VW3OC3eLmXBToAnRRVYozTCswSCSPg
 R3+h4INa+wvGVM7JY7+WZGyck8M9ltPXl3FFXOv3zAcnB1F8Ziz7LMSz75GTEEyPmQN9
 mEIWMob3nJd4ZJM032izksXVsCLMPoBx2fNYhUNP4AgpPA45Q40oRG+zWYbyMWPhCJx5
 2fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759247544; x=1759852344;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYPBbFOlnFi8XwomogB2dUHMhH5ng5yEHyiZ3X3UYRw=;
 b=Y3pOAnRDSZdL9bAOo+aATfKPSSpGwKTyz6YXkH+KII/OhCRYb/hLaMqoHCzIxKal6e
 qNYinvAVYlTeBC39QECcch8jpBima1fDTV1i5Dx/IBF6rVgFyRgYt4I+SK5tUrtavUay
 pksbGYOTQ7xluJVkPFLlin73tHffTjMVA3pzSjZ/c7mUU9hQIwQP4JWTNKKiUh97q9ae
 Gw2Km9Xdpx+DPyOpnn2y+K2c/27w5sJD8ZGIDpUGL3jwfXMmmEKmO87oE/X0HREZEIqE
 iDMYn2H+fi1ndFp4biOobnZ1y05xhqjLr3q+Vnt+vE8+GlEJBWkrtWBjdFUC2C7exkBS
 NkXA==
X-Gm-Message-State: AOJu0YzIwgTjMpCdayBu60VgZOKZVV1wuyTMX1xEWGWOx0tqYWs8GRGn
 Rj1Zdeau2CtFk034qjZAE8sK0uwbdJmI6WsRSoxtDfsmjXFY2Wm97OkiJXBiQMAoFwEpkkg5DOp
 feUZ5
X-Gm-Gg: ASbGncsGX9qfMC6HtMlfj+hU1Y9Kq8vB44E8FdNskzuiCgibzOHjeZxmMRt2wL9yOfZ
 jbPX8TDCrYLIyWXg/StFoY+TmKeTlyvgpQ6nPuyKgJkMdgxvwddehuLjdHx4S5EDvbOoUzO7z/F
 TQHCK9NS7vBq0qhTg3dNn4SSbKb5tgmb7lVW5Mi/9uUB7InZ5QT4EmOJFqYRbflI2aaVRAAXuMs
 N22sHcoGhAnCWSWLQpJ1s1KtX78v3UKmbMl3u9y/a9n1fObEDxgLMtilNuF/hK+Ce3jkFU7jb2w
 aEWI6E1F8S48/e9Hd/CO26ZWdBZz2i+oJSIcjrktzPYHZKdysw4uXU7kJkgEc1jXDfRHjrBpWJX
 3JSPsYCLlIR/5K/XKJiRmp+y6LQW6vuO097V6z28h17S7iW0Fyp8J97OefQjnD3xJpc/riz+N/8
 GfpoVWJO2b
X-Google-Smtp-Source: AGHT+IHBMVhwZHk1sgwAJakGAS3WpSwSqBfPR7dNRlnUweoN+hIg8JLzsL+vlsnuZT11OdC/TpoTRg==
X-Received: by 2002:a05:6000:2dc5:b0:3fd:3bcc:c205 with SMTP id
 ffacd0b85a97d-425577cbf81mr209255f8f.0.1759247544346; 
 Tue, 30 Sep 2025 08:52:24 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:aed:2018:ed42:d786])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dcacsm64747165e9.2.2025.09.30.08.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 08:52:23 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 30 Sep 2025 16:52:22 +0100
Subject: [PATCH 1/3] usb: musb-new: Null check before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-usb_musb-new-v1-1-be0c9b79a8a0@linaro.org>
References: <20250930-usb_musb-new-v1-0-be0c9b79a8a0@linaro.org>
In-Reply-To: <20250930-usb_musb-new-v1-0-be0c9b79a8a0@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

A null check for the variable 'data' was introduced before dereferencing
it for set_phy_power but other uses were not so protected. Add the null
check for other dereferences of 'data'.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/musb-new/am35x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb-new/am35x.c b/drivers/usb/musb-new/am35x.c
index 42bc816e4f1e5ca0e6fa891c563fea65106e0b43..ca4d798642e731755473063df9507185b1d59205 100644
--- a/drivers/usb/musb-new/am35x.c
+++ b/drivers/usb/musb-new/am35x.c
@@ -402,7 +402,7 @@ static int am35x_musb_init(struct musb *musb)
 #endif
 
 	/* Reset the musb */
-	if (data->reset)
+	if (data && data->reset)
 		data->reset(data->dev);
 
 	/* Reset the controller */
@@ -417,7 +417,7 @@ static int am35x_musb_init(struct musb *musb)
 	musb->isr = am35x_musb_interrupt;
 
 	/* clear level interrupt */
-	if (data->clear_irq)
+	if (data && data->clear_irq)
 		data->clear_irq(data->dev);
 
 	return 0;

-- 
2.47.3

