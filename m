Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA11FC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3F2D87147;
	Tue, 24 Oct 2023 09:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XV5CDhcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AE58713C; Tue, 24 Oct 2023 09:41:40 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5F5870E0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507bd64814fso6061107e87.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133297; x=1698738097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnuJzyttXdYOO/Y5QuViyNLB5skqt6xD/FB7G0SDNwU=;
 b=XV5CDhcU9DABhKCNxn5ZTVMQmT/ruxyoVXkm5cgb0NaTuKWm42K6Vzr3UofSJ+PcmH
 NdWm1mvWrYmwxdwM5pT3uR0IhAim0rXl2uZ8lBnNWSDqF0AlUy7BhrZ/5QUKOg+gvt0t
 MIF7WZeQU7BgPLW//zKeREpg3BS5S5ge6eEZMD0Bpg7q9+rbZFkIJ4bGkFCVMOmP7Jv3
 SyLSpva0ZYyKjFA+lZHiq9XBpMyWLjmhHVSa1gEwijv49a6D7wjrpQbv5flnGVgpooeh
 Ei2cm4TBtaSmDeC+yUlPZTp5RYc4jWvET5GIFR5mrkXhCcBt2bNe81qPRMSwhFYmLQy3
 mNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133297; x=1698738097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnuJzyttXdYOO/Y5QuViyNLB5skqt6xD/FB7G0SDNwU=;
 b=iDC5nKqhTh9N+LCCz9vmNtHw1LVkHzpd1N3w7p4213DKMzML5D9qqWrdlHcV9ChpVZ
 DxfYWMGm/gG0lFZx46FllJRKcsr6LmeG9ZK9DYaSFoPePT6xi73E60x2fx4a+IgQloLD
 zrAHm+AAJIQFWM7yp0LfiH8PgpCNLMzS7NbiiQl7/rfw1L3QBGx+V9EJVEnJXk9MAr8E
 haiClmeUKnhntu7lwwO03nEjMV7KFU6f0oV+1gkmNyb5S0mjh5hkTTu91xNm3Ss76YQ3
 YiHqrsrvyd2jfbDiTScjgTZB5rppLYwbERAJ3775WepWjVyQ0N1+zK8Z+nNTxogdxxc2
 yJiw==
X-Gm-Message-State: AOJu0YzI+HREFvYClkI50EcnZ3s+kPsIXzYQRcrZk/n7Ef4SgvNEf29G
 Df7gqGJqiaAAIWsD9htu7ycL2yXRT4Q=
X-Google-Smtp-Source: AGHT+IGPoD1iQLiJI3ESDp8TSD1LJrdTe/D8ChDIyFzLlWtnPYAfHQ0R4pnu8BX79JvI8OPzGnA7Yw==
X-Received: by 2002:ac2:54ad:0:b0:507:9a12:b655 with SMTP id
 w13-20020ac254ad000000b005079a12b655mr7392668lfk.23.1698133297315; 
 Tue, 24 Oct 2023 00:41:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac25e6a000000b00507a089caf6sm2017580lfr.219.2023.10.24.00.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:41:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v8 2/8] power: regulator: palmas: fix ldoln and ldousb
 detection
Date: Tue, 24 Oct 2023 10:41:04 +0300
Message-Id: <20231024074110.199623-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024074110.199623-1-clamor95@gmail.com>
References: <20231024074110.199623-1-clamor95@gmail.com>
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

dev->driver_data will carry the tail of ldo if there is a number and
if there is no number it will be an error code, anyway it will not be
zero. This results in a wrong ldo regulator detection.

To avoid this check for non-numerical ldo first and then manipulate
dev->driver_data.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/regulator/palmas_regulator.c | 24 +++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/power/regulator/palmas_regulator.c b/drivers/power/regulator/palmas_regulator.c
index 3c4eb83be7..d615e94734 100644
--- a/drivers/power/regulator/palmas_regulator.c
+++ b/drivers/power/regulator/palmas_regulator.c
@@ -301,19 +301,23 @@ static int palmas_ldo_probe(struct udevice *dev)
 
 	uc_pdata->type = REGULATOR_TYPE_LDO;
 
-	if (dev->driver_data) {
+	/* check for ldoln and ldousb cases */
+	if (!strcmp("ldoln", dev->name)) {
+		uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][9];
+		uc_pdata->volt_reg = palmas_ldo_volt[type][9];
+		return 0;
+	}
+
+	if (!strcmp("ldousb", dev->name)) {
+		uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][10];
+		uc_pdata->volt_reg = palmas_ldo_volt[type][10];
+		return 0;
+	}
+
+	if (dev->driver_data > 0) {
 		u8 idx = dev->driver_data - 1;
 		uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][idx];
 		uc_pdata->volt_reg = palmas_ldo_volt[type][idx];
-	} else {
-		/* check for ldoln and ldousb cases */
-		if (!strcmp("ldoln", dev->name)) {
-			uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][9];
-			uc_pdata->volt_reg = palmas_ldo_volt[type][9];
-		} else if (!strcmp("ldousb", dev->name)) {
-			uc_pdata->ctrl_reg = palmas_ldo_ctrl[type][10];
-			uc_pdata->volt_reg = palmas_ldo_volt[type][10];
-		}
 	}
 
 	return 0;
-- 
2.39.2

