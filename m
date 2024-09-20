Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43861CF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF4D89412;
	Fri, 20 Sep 2024 10:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gFDezDRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D1C89431; Fri, 20 Sep 2024 10:00:47 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6278189425
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-378c16a4d3eso1792621f8f.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819244; x=1727424044; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rRQw9hErepV7DnPqqgrdzAG1cgOdyL90LsW9f/pFcaU=;
 b=gFDezDRnWGY2609P6BmYFZw3srmliwgeh25IsmT1UKAkeHU5dzQwmSHmP4QUJjlwEC
 /nlr04T2XLsbSxK2cZ7cUJhfvtLVBltvDM7PVRT1844d1NiYEA07soh5lGoExkytXAic
 zkcKVxZzxKxi/NWQ+YF6xsr+yAyLH55DaUEpXQEiwgnU++opC5UXZ7s0ZO8iNRChsDYr
 wXd+diAeyObtdT+R+1UYM3r8odsry/g4s0V4nA5Aiz2dPqd7PBor9msAueR97cDKjklo
 x467k5fG8hIHRpv04f5zIRAsvEJ60j8HOJLWBhrZ5/W5pWGI3Z3lHbH8Nru6KWhltOmO
 JnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819244; x=1727424044;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRQw9hErepV7DnPqqgrdzAG1cgOdyL90LsW9f/pFcaU=;
 b=dxk99bqOdHx1/scv7jqcD7sUsm1Ew08vSE0eTXD2A0D1GjtmApYq/3/ZEVQmxiDs7E
 rDhMh/c8FKA8gwMq7ZwfmqBPAelTCb8hSAmAYvG74Sy/bxIf78Ibo1ZU3FFzg5uimiMs
 f6UL1Q+0utROBVmrkbnZ/wwp4ehBwcGyPJkycnUMFNICHhOL2itvGDvf/EKOVfBWIFB3
 Rv4jdx4uF9vAorw3zk8NWBluUqG8O+ZrQgCyD5d8w1UEKyePrpW30XN9hMSeE0TJScxv
 2/oIBxBtQEzuMWCiE2cr7SAo/9ldqq02gBLp9IoDn1P8nrRhzPK62LdFa9OJEzB/0Zdf
 pyOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpbs6GuN4IUOMnz55fZnN0CNpAnoo1UNYt8oJ7CFnQYjzUwt+NyS+EROroandg8CcUGk2oIWM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6I/sfV+Qeku99zap82z1dzOAkwWYKaB6/YL+UUgi2VOn1NEf9
 lmIFj5LgYQHuUwAEeDSlh4Y9IQEiaFPknQk6+SyLBRkz0te/inp4WGm1bIUNAmI=
X-Google-Smtp-Source: AGHT+IGDBMf//KPU2enupkrHm47ZlcFKJ14C6O+cOxzxC6jKMOjaaGBZHDUvtJYHVkaT/dE2SdiU7w==
X-Received: by 2002:a05:6000:1fa4:b0:378:8b84:4de9 with SMTP id
 ffacd0b85a97d-37a4225334cmr2130157f8f.12.1726819243716; 
 Fri, 20 Sep 2024 01:00:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 10:00:33 +0200
Subject: [PATCH v2 12/13] ufs: core: remove link_startup_again logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-12-65ae61e73eaa@linaro.org>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
In-Reply-To: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JhT/11URXvkq7wQRb8O38oqRy3fHS9dhagU2llSpbGo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SueZL6EO0YXTUlMm0/5tsgHdFBj+ayWVGVaoBim
 w87ueRCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rngAKCRB33NvayMhJ0QAjD/
 0X67FrVLPtmz4FhrbmK/ux622rbQTLSREbUzpk2FZIqA5ZO89UotM4ZVypDPRpvv5+34FF3Rf+a7NX
 6psEtWf1H8ReqXRJboIpBTYOhsehQSnvpAZbEnlv7Lkiw1XHQ5+bZcWfw0YFg1VT9X+gttlvbNksmB
 OIDj4Pd98pTq5JhSinxHSL604SdTBplZaF6RXG3RRrfLNz8QR94mkdjTM65zG7Qq8gVx4sZyDjY/l0
 9YuQUqnOWTjM1Wc56d9cSFvybsvK9j2VJon3nwivPXoUYB7Bf6Fu11kM8v9vgkjEDOkqFjO966gSGD
 bt0ttieeo6i11TSbAfot+037ArGnTJPwH8jK/QYCKiGGuf8DZUwYmc1n+fsI/dPbbE/5r7xzl4JDc6
 e0gjPIKsFwgJHk68k+AV8HSuDpDyI16YgYHRr+bedKkzysyASZWwJ0nItFPS/OJEFi15meQNT58ODo
 jC8rDMpCj8pgmN1x7rFIA0W40yJb50Xl/Zx+iMj88/203s4cC/vy786A5oxQdgRPI4p/xp/c1EjaER
 1Q2QLmi8mJv4KnKUbgzS3Tj+UC33OtzRCUEJLJxxispS5BjN+/vq4r3CiHZ27wXtXzMzGy/8nkeWky
 OdfpGLUxdVJOtvT4LhveUvCmikEw/O0YCl6iGZNUlCISKVm5OWNo17DUnFNg==
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

ufshcd_set_ufs_dev_active(hba) is called at ufshcd_init() right before
scheduling an ufshcd_async_scan that will call ufshcd_device_init() then ufshcd_link_startup().

The comment in probe says:
    /*
     * We are assuming that device wasn't put in sleep/power-down
     * state exclusively during the boot stage before kernel.
     * This assumption helps avoid doing link startup twice during
     * ufshcd_probe_hba().
     */
we can assume the same from U-Boot.

While it worked to far, it breaks link startup for Qualcomm Controllers v5,
let's just remove the logic.

Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index d2df5c26f76..e34e4586224 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -462,9 +462,7 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 {
 	int ret;
 	int retries = DME_LINKSTARTUP_RETRIES;
-	bool link_startup_again = true;
 
-link_startup:
 	do {
 		ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
 
@@ -490,12 +488,6 @@ link_startup:
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
 

-- 
2.34.1

