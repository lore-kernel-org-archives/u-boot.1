Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D19CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 055B588F33;
	Mon, 30 Sep 2024 14:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TclONR23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FF288EB6; Mon, 30 Sep 2024 14:44:47 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4662E88E39
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso33261295e9.2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700285; x=1728305085; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rRQw9hErepV7DnPqqgrdzAG1cgOdyL90LsW9f/pFcaU=;
 b=TclONR23Zs/Y9jCmmznkjl0JPcxZOoIIiBcRnDt4oHTSPbPJCIGdOfgOCtQgR0FOZ9
 ZeNq3/OAIVFbOuWV0Ua2aPuSTsT8Wx5W0wINnWq0NyzGIsPAAD32nlPFB6qk44Kh6KVd
 Tow5b5WV3WdNeVnLnmOXeU0a32RdgG+Vy3gzx2USdi9JwEODUSs+K4rcuoYbsTVgAS8B
 8RD8xzKbKg4/sak6Mf/Y/FxamrxI0y2VLmDqVnjLFFhjHlmZwc+XeSLFlLRDxCB8iwfP
 o05S3qG/UXlecbFmKOTRtNjvsdCdUaV52KAwg9FSxHqfPm8Y8nu/0bHx0+PzPrTNqBUF
 1VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700285; x=1728305085;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRQw9hErepV7DnPqqgrdzAG1cgOdyL90LsW9f/pFcaU=;
 b=JkLOp4P5X3aKGUAhSfLXNnBFOXynyZWPe4GaxksnUF3Ht6Aho+HfU5xlyj2Mzzpcm3
 ngXv7w96fJXPoEy+OkasbVk9S+0LdvzZHuRI1SpWJMuc90MR97L28hC4tuLr1iI8yVBY
 kLq8FmLKZYe6lysaHpUra9VLB+e3J2C0Ad7amzZBi+qLx0cV85W7Ro3HMerwkWr2TGDt
 h6UYY/EFrDfwbnO6U6ICw5kXW9bz5UK4fBqCSSL3SY5AnBrn0V32MynLwrDsA4B2lFL8
 diqrX8D2tI5aMCwodbIBDsfY3osb+7FlchXk/LFdJvPDz0A/ZWKFshRTDbyG1RFx+xEH
 qgRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAnsC/Ji5dFKryD14VB979oJn/geLpnaUIR1KbsfnWGpNkq/Q8/lZ0AizyzSj+DqwN/KHZnA0=@lists.denx.de
X-Gm-Message-State: AOJu0YyT9iQU3odA85l/xwF/urXDM/xgWTa8MEIkE3IqP2oemOIZD/HP
 Y96vtljf+IkxXLJ/cvl+qN7/FHI46GISEk7kj3lgEcP1cOgDo7tJH9JktjqNBhk=
X-Google-Smtp-Source: AGHT+IGgf6A/17Nk0Ggt78tX1xIY36uVhrk1wcob4Fq1/CQ3vTUWGu8iEsCKyEiViClVyGGdJ9BHgw==
X-Received: by 2002:a05:600c:3ca6:b0:426:6710:223c with SMTP id
 5b1f17b1804b1-42f584128f9mr82071355e9.9.1727700284651; 
 Mon, 30 Sep 2024 05:44:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Sep 2024 14:44:34 +0200
Subject: [PATCH v3 12/13] ufs: core: remove link_startup_again logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-12-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0twtymCWmbEwEktWA9wyh8EWwMT/CRcvG7CpOS
 RQVFwG+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdLQAKCRB33NvayMhJ0e2AD/
 wPmwgz3GwoIrQZLthMRcpFZNVlj3CCyNEIsYvAYkhcFShYYjiLKOpQLQhXBM4EDoiX9Hj2cbpVn9Eb
 pUurEm6ooHZViJnnHFRIC0lQ6VcxWS/26LL7wwINDWX9H+LhtEH121SzLQ8HcuXPj32OvQoAPaQZMe
 htQxeKJMMqp/lkL9RZA1JrgKyZf6hpcWTUdfXIYJhKK8hWk7TggujOgU9YbqgCaPvj2qBvlRv83Vsq
 UQEzKX//XsQcwcm9mLfiorx4xODYE0IXg1st3G1VqMPWu4hm4nbEn9kDuSItcoDSpSk0X2eybT+5/z
 fuKf3E31zEYsWu9txk41c4hrEGmfh4po0UwNLkTlhRnqqN9C+Q9+VeWTXS9O5fykxMuuMFZo27FNvG
 zHQvmrw85I5omvUEKvtMUWJAOLcJaz7RUEzKajsbm6GVDYtzbSAZRePpv1NLIS9UBKbmNELml7LQZ1
 Ta9Y+kzsKNRlPsO1yc8Y6A2DslOKeR1le1LAQcGZkJJpKZEeFNcoEsSoiXiqKMCWvdFjoCcUuzWQUD
 CthTevpugxF87Pb0ZxV9aLrPW7BkfnbphQT5SesoFdQ0FAJlT+hyUp1njZafLoN/wNDBQXur4lcUPu
 Wj4dWD8Q2+HiG9Ic5GwyMkTfA8jorPBQI18paDhnCULDW4iasgpsds1TDfGg==
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

