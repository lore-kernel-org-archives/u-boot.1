Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF660C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 08:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C104982EB8;
	Wed, 30 Jul 2025 10:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ir4Y6Jog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD4B082BA1; Wed, 30 Jul 2025 10:03:43 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A5B82BA7
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45892deb246so3230595e9.2
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753862620; x=1754467420; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TdCNxYILh12AdGc12YnOvcCjA/7CfIwbQCgLun4GCEc=;
 b=Ir4Y6Jog6NRQbIUhDbMH3sGxMEPc6LabliIsSmkmjSbCH5DwF52KpKsTOSWiIlduRp
 6R7m480cfLF5TycagF4EpoK+/3E/YGnXXC9n9p51k8FiO7SGJM6TlyXZczFABusFnaZK
 zGs8QWQ2bFqiYYpc3arXfMTuF9NpID0+6dTQixcZ82oYLplmit8BrkXUf3CKsoRCiZ3N
 Xr5vY89IVOLU8urtOMKnSot9c6m0C+4yfpmwG/YANORYrMz/WAx+8auBS5xlDiScGRoH
 zB5Y0A3G21adz+kU2YtGxo5ApNuyJ48q6qVNIkRjBbxpvyFVBDNeDy9A6ivgrOA61wJS
 /Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753862620; x=1754467420;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdCNxYILh12AdGc12YnOvcCjA/7CfIwbQCgLun4GCEc=;
 b=g8LtT76yWjruyc+CrscVO+dMzwtqkY7+RhOc2t+dSefhbrda8029Enmk22YdiTbngF
 zxaBxoaTjqj3WDWW1cYhTCvlxVveHl3PcOGmlv7ncsYnHGIlycilGjDiNrY09QEIs5us
 d1axuZWxIZY6tD32QinRNQS2WFZ86ZOtR4lWx2yl17bFL+yN4HNZFPxnn7DlPCiLcaSl
 cTSGpMc2dG71H/pX/6iV+tx5n9guRXniR9cEtmDX7BBZZp+6dFfNzVAu/IP7EZYqK/ew
 qDLme4vXd12ipmCUOgUlfLQf2K0uZsye9ZBezDEskW+mp8FbtOLU+tpYLrIO2VrJWGQm
 F/iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFn3vB2Its7Rth/pzUdOPOXUqeZfgqwIvNepVOrFkHj3RStkwZe1o1Mq1bznY5gJ4RlKNN0OQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwhBH9IhprVJHXjt4P66O8vUjv0sidaE1gOiBS66/LGjPp9xlWI
 /TcXlXKet1Tkuo0nj834q9iMldqabp1Gnosk9UBousPihCYmz0WbS9o5GdjVxlKl1VjTWA4NOAP
 ktod2
X-Gm-Gg: ASbGncs+L6L5NVik7VXzQzPfdrgF5I+a6BNf9LvpRZjELKZWsPwtMuRYiBR5ZBJNTHV
 cgfa7CA+GtnY4ITdVSpbRNkyZUPcEc6JHxK+7QCV8eSaV0jamlWgFZoEM2aDNFlVaVlGHTov9ZB
 XSxhB32eKHUXpWkqQQ/mkpWyOrH9QMLF4saApTXHjcKUu17spYxxkzSmFypMG7lO6dLF8yhKojY
 6vKsoZzNbrZYr7wV6rh3+ThztIL/mmlIwz90SJcwNx+4a9tVl2V4x/d+i+nNCdeVpRsiCvHnh/Q
 JIanBs3VDxWpSiI8UhKJo7ZckOlSVOJ9jBsX922xnexZIKkvjEQezMCMwWxb/OSat4tXu+3XwEx
 4K8LLHRqYFqhHgLzItGUZIyrzZk2w6NpfG+Sh+P1UAu+yk1gK88m6Dg==
X-Google-Smtp-Source: AGHT+IFs1kHHTYn88NPuQ4ACvl7DOpndkqsrSiC9bDiLbJKjC1MBV/eonZvsP0kvK8Colq6y2mERSg==
X-Received: by 2002:a05:600c:8711:b0:456:2066:5747 with SMTP id
 5b1f17b1804b1-45892b9c1femr25784835e9.10.1753862620614; 
 Wed, 30 Jul 2025 01:03:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b793519ee5sm3910619f8f.62.2025.07.30.01.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 01:03:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 30 Jul 2025 10:03:39 +0200
Subject: [PATCH] pinctrl: sx150x: reformat and fixup Copyright header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-topic-sx150x-copyright-v1-1-c2e2074b8942@linaro.org>
X-B4-Tracking: v=1; b=H4sIANrRiWgC/x3MQQqAIBBA0avErBuwwrKuEi3MJp1NikYY0d2Tl
 m/x/wOJIlOCqXog0sWJ/VHQ1BUYpw9LyFsxtKKVYugEnj6wwZQbKTIaH+7I1p24aj2oXqpOmRF
 KHCLtnP/xvLzvB6YbA0xoAAAA
X-Change-ID: 20250730-topic-sx150x-copyright-baa7865838c9
To: Tom Rini <trini@konsulko.com>
Cc: chalianis1@gmail.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=rhhHq7K+1AmeOkqSCBMBv9nOMjdMMKB2y69oThNLW2M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoidHbjUftBu6kebpR7hiS4Cx7RxwGUol29REYJKjG
 XUBQ1wWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaInR2wAKCRB33NvayMhJ0T8AEA
 CO9pDb6VxH4YJCsj9APjCV3Ui5bP5Qm/R4CMfqcZmBZN6bHoivOWEnEvPwKmCWIfXsPTg3tjCxc7NU
 C+ssbDKy9FZNwRrqFWXIW4H4dFXXZ2Gf4wqmF6NFLtHVkmLp//ua25AZBhCUlwJlk0oF7vZTjaoBVc
 A9GeElwWXzoGir9bnd06Chm3JhyOgGjov6Sd1l4nXXdCZkiwF7293HS/oNrewLapvIUU+PQXD6ECqK
 vA10V463ztNR3IQnMN5Q37wsQK4bmOvo3c1oYeZPvIddzkDawvu0yVWibNDkl1NgYDvf83akHI8uNC
 ol0gwHyzPTK5AftatsOZm4speFK494RaI2NhEtirnclNfAurk8myPNn/zmc/1LvKivTtPJUK/sXfA2
 UKPX301gXBYHMnsJANqFkeukWYZRbiobtV8l38gJNvNjUQ9gV0ke8HqBIrl2nyYoiNYhhC22fup0v9
 ecJaKUhm0axhcQNwqoYyVvVBsVV/m0G0H2E5+ugQ4SGWsVY7n4qJHB6eXay3miHfGboNuRuGHZQmMW
 pl6wzcs9HJSzkrxB1TDfbTrIeybApE2pKUzbGp6lc4oQ9imkJboF09UjILDExeDjOURGwnkFQWgkzM
 wQmWZ1clZ0BwZ9mAikC1rlKnZ2SSWRhpOStSSSWdnL3phdPvMWz4RxpUJbwA==
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

The Linux pinctrl-sx150 was originally written as a GPIO driver
and fully rewritten by me as a Pinctrl driver and extended by
other contributors.

Fixup the Copyright header style and correctly report the
Copyright headers from the Linux driver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/pinctrl-sx150x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index 324d7af8fcd003905d23dc438d9459187403b782..20355fbddabedb5ccbd289c64bfbab5f7c143556 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -3,8 +3,12 @@
  * Copyright (C) 2024, Exfo Inc - All Rights Reserved
  *
  * Author: Anis CHALI <anis.chali@exfo.com>
- * inspired and adapted from linux driver of sx150x written by Gregory Bean
- * <gbean@codeaurora.org>
+ *
+ * Inspired and adapted from the Linux pinctrl-sx150x driver:
+ * Copyright (c) 2016, BayLibre, SAS. All rights reserved.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ * Author: Gregory Bean <gbean@codeaurora.org>
  */
 
 #include <asm/gpio.h>

---
base-commit: a8f20bb6650df56d2600cda2c66f9349df9e49c8
change-id: 20250730-topic-sx150x-copyright-baa7865838c9

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

