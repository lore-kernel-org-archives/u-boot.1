Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A056FC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB7548846C;
	Tue, 28 May 2024 10:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bwMkKyui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6208588418; Tue, 28 May 2024 10:36:26 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 611C688445
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e716e302bdso6420311fa.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716885384; x=1717490184; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ONLevqx63BYWdNaxUe7ag17CBQ3vtm2NsbiE6YYH5Jc=;
 b=bwMkKyui22WBllhLSALtap0i0FyOMNjuvusrOFX3iH1houdOFbTuG2PAgsjigobBOc
 WWfXDeJ+IDnVpABsIgz95cYek+442dr4KisM3pA6w2Q6xQJex440U90hQ2n3dXxVAN43
 cp0IpvjE+ZU/o2g6d0fnNHVvi4ixgFRxcsUY6S4/8kkU7qGaKnWbtw5pOKluZB3VLjJQ
 el43FA1RGq06YFgkHLsTvpSBq6Ar4MX6+kIsjmudhB2awfF1hGtFvgGE/4PFFw7JW0y5
 B8Ra9JQPh67D5pfAeuqJnqHx/YAa6ofllEHvR39BSWk70FtkEU6QZeYM57g2/TUQz+7f
 UAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716885384; x=1717490184;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ONLevqx63BYWdNaxUe7ag17CBQ3vtm2NsbiE6YYH5Jc=;
 b=Jnei963IDWLvCig0r662QweuxC7Z7wTlw96BcQKsnp22hn38+nKnTA/sE+uroV2N7T
 icReDfyMURLB7wTbZ1KG06HcJfx7gNgoYbtvgrnYgJX+sUBQ8JPCTZrTHI7juFe6RpbQ
 QyI61Ik6T9dhV3fqBadIgk0sIqjhNayT8M5NlaUSDUk94aZ72BrxUGPasy7QRDCK1WE9
 bNL8vXe+ksailu8XJ679277vfwuYAETT4jxhL1Zdl0RAPV6BmYLjR2rwUouXGgUHsAJb
 R5BjbREMkJgBX1xmrka57O03Qq7DjiFhJl0ySiEwsfr0xN0UD/xJXTM0qE48pIfNHrmR
 q0kw==
X-Gm-Message-State: AOJu0YxW/r7x7q+mSOdKfyW6NRDrHjT1GzDYF0QWGn68K2d+9Be8KaMi
 2Vur8tyotf+O3u1kwHl2aZQnXoGx+ZRfFa5+E3um5UkOIg6n+NEjjsodEEPJhWk=
X-Google-Smtp-Source: AGHT+IHSlLwf04hu3wYV6yDqJ7fSUs56NNjSQ+Oti6piJ7Lpd2uY+q7rl1prU/FR+xrLDCTJ2r5WPw==
X-Received: by 2002:a05:651c:1031:b0:2d8:e05f:633e with SMTP id
 38308e7fff4ca-2e95b0416a6mr66431591fa.1.1716885383448; 
 Tue, 28 May 2024 01:36:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210896f442sm133246975e9.11.2024.05.28.01.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 01:36:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 May 2024 10:36:21 +0200
Subject: [PATCH] ufs: core: remove link_startup_again logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-topic-sm8x50-ufs-core-link-startup-again-v1-1-146ca43e80b6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAISXVWYC/x3NwQrCMAyA4VcZORvoyqbTVxEPNaYzqG1JOhmMv
 bvF43f5/w2MVdjg0m2g/BWTnBr6Qwf0DGlmlEczeOcHN/oJay5CaJ9pHR0u0ZCyMr4lvdBq0Lo
 UDHOQhHfyFM/uRP1xgJYrylHW/+p62/cfEOznSXoAAAA=
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=M8rk0mLXc2wwQ5GRo8+tlC0WJdOZXZZ5CqZ67aRWgtk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVZeGhkxemWMBBYevPHN0jDew0ojfZSK7qxnL6F/Q
 nzpNX4yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlWXhgAKCRB33NvayMhJ0aRlEA
 CxB9HsXml5PEYWDoVTe6SVkKExIzb/AaqKX32+0hRf8XvE99O23wbRGTLA3LEUhiS555gFQT3zO53k
 GivvGxpv9sQZsvcCfXxZKEVTF2KyxB69UUOUrosRcLSi65Lc57YwJYL2IlU7/Gs8jMDEYzuA0QJsDQ
 pHsk7aAGst2dgk3mrcc655s1CC5J6fRKvHwsbmTTL8MOyLzhpiHz2HGkVSDZBBhtS31vX/VL9s6YEl
 m/6Ec7s+uSsdRkXkyOl/Q5XiVYeFUUNzZqwp8VHXawrpT9/ZIOXWSzIXoOLKUt5Luw/xOZLKAWLmVa
 q5Aw8bfQEtkOYCXAdSnChCtaZwouV4SXhsS4PJQqazYmhCVFzhfPjJJjD43w8sHcTW3JSTQtRwCwL/
 qmASrPrY2ynRLpQhdrSIlfeLn+CcXbKwNnBXm10b2pd+oc3pHe55xx6v1QPKIJufhiunKZ7NieKOxS
 IFPjvyyVN2/LL3eYLqXegBOAP0bM45ZeV+4y+MPtdXCz1oZlxHuLuO//rTr8J9FYa91272ilLjMhR4
 u3tzZ1imv5ETSAS4YMNRA435Ln19zjYxQ0/94dB7ElVBiqSbbz7mOBazp6KxBee2e0nGZ8ahFa+CAx
 iWkmVDvYhlPuj9RNXbnRPvshmTfWmp2Rjg5W/pJoCQ56m62qx/5Npzkg3UUQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The link_startup_again logic was added in Linux to handle device
that were set in LinkDown state, which should not be the case since U-boot
doesn't set LinkDown state are init, and Linux sets the device active
in ufshcd_init() for the first link startup.

While it worked to far, it breaks link startup for Qualcomm Controllers v5,
let's just remove the logic.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index be64bf971f1..28c244b70e5 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -456,9 +456,7 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 {
 	int ret;
 	int retries = DME_LINKSTARTUP_RETRIES;
-	bool link_startup_again = true;
 
-link_startup:
 	do {
 		ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
 
@@ -484,12 +482,6 @@ link_startup:
 		/* failed to get the link up... retire */
 		goto out;
 
-	if (link_startup_again) {
-		link_startup_again = false;
-		retries = DME_LINKSTARTUP_RETRIES;
-		goto link_startup;
-	}
-
 	/* Mark that link is up in PWM-G1, 1-lane, SLOW-AUTO mode */
 	ufshcd_init_pwr_info(hba);
 

---
base-commit: 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf
change-id: 20240528-topic-sm8x50-ufs-core-link-startup-again-bc2cf907c164

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

