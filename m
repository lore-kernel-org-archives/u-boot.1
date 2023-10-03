Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AD9E75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0567D870BB;
	Tue,  3 Oct 2023 08:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dye8ubON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A55871B9; Tue,  3 Oct 2023 08:29:56 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C70F386E15
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50336768615so619427e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314591; x=1696919391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnuJzyttXdYOO/Y5QuViyNLB5skqt6xD/FB7G0SDNwU=;
 b=Dye8ubONFKWW3k1aHfurwp9SNCLEtAYP7EPMq2Sx/I7NQFLdhVBwFJSjm/gAa7eH9X
 0eLgXGJZpxqvwkEISfSdODZRBQqT4G/n6QvW8izldE4ivw3ntoD7qFitHiYLG0woLAVW
 lQP2OecLMaUhqFItLsyI4AglWztd+0Ofx54lA3qNCFGDDLR/6GR2lDXO7C+BKfYGvDx8
 KBBkmLdE1hZXmS8uueZxfPPRbUmjgTcv6KLMQ5fsMu2z25hHUOH6VNrap3XvK0v27+u2
 1eqrvJCUxsHTw1iudYvzXAAeFU7bJpTnSv5vE4kRz0+8idXziq3E2ycEzTgxUdNjieqs
 MKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314591; x=1696919391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnuJzyttXdYOO/Y5QuViyNLB5skqt6xD/FB7G0SDNwU=;
 b=FrTq31TJkKjDt0B/joHKj2Aa369kDhmp44dCUenRekFZccIXyh5wpdu7hQy+/TThaY
 o3DCXlFq4+0YM3tlKr4pQ3gOkql1rm+jvb0U9wOs5B6rE1QczMRa0h6U6iyNcWbXFCvA
 LQYKpQVJpQwuvmxsx5NV2p3tXZgzAxxmjhh4LmkDe5CW5O2YHZTMA4McryrWLuBmrj2V
 x19b+5O1DZNi1bVMdBxRXtKBHwZoy3KxfzKnTkRkW1JGkSbfuPf4jsRYye3k/yurTlrZ
 vVClWElPqn6RTRXf5L7oJPqP218ZQ0QBAr5okStUSbUT+UoLhCw/8+kBRVUNmaKliCNU
 +EPQ==
X-Gm-Message-State: AOJu0YzE4swkFGebLfJtKRndPQMr6iPWrbc/C5GT7AZe1YyByIyrYsj/
 KQMpRp4hqTLhotIkJ0qis+E=
X-Google-Smtp-Source: AGHT+IGAoh3BcE4JsKIdWuJqQS/A4EvsZkX+SBh7tm3OVXJN2zuPk3nJhU1O+gYG6G47MhxLoiqbHQ==
X-Received: by 2002:a19:ca11:0:b0:503:1adf:b4d5 with SMTP id
 a17-20020a19ca11000000b005031adfb4d5mr10416403lfg.52.1696314591045; 
 Mon, 02 Oct 2023 23:29:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 j27-20020ac253bb000000b005009aa86582sm78583lfh.55.2023.10.02.23.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:29:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 2/8] power: regulator: palmas: fix ldoln and ldousb
 detection
Date: Tue,  3 Oct 2023 09:29:35 +0300
Message-Id: <20231003062941.42501-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062941.42501-1-clamor95@gmail.com>
References: <20231003062941.42501-1-clamor95@gmail.com>
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

