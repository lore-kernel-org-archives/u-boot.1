Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9CAEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 06:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4355D87244;
	Tue, 22 Aug 2023 08:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ddxqeLQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B9C871C8; Tue, 22 Aug 2023 08:32:45 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0485F871D1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 08:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so4887081a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692685961; x=1693290761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnuJzyttXdYOO/Y5QuViyNLB5skqt6xD/FB7G0SDNwU=;
 b=ddxqeLQluaDgendEMkIeu41NlfGmW1aZtI5xWhuMJeW5lNnw61s9+T4mbuVe6v08Jz
 xmBPhj3Kpy09ZGfwzhmCa7jf5bkhiIONDge8D5SEkOeieqnfALaOmdaf58sFxLPJPXLF
 acLxOQo7Gmcu0uKzN/YjzEKiUObYPIi5CbZydJxlllaQK65Fl2woWsHN5IRmYRrfBDRg
 Fy8rh+EnUwBdPbvWnxctupBw3ry0flwkyJ40eu1k6VdJUoxlXqp+0FnBsg0jmyUjXhUE
 t1qfIlzW5e1EBzYyvpUYgkfezjoZ8yq6z/jZizku5lNA6KMk/oqvItSqUxdu4RP60HJZ
 g+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692685961; x=1693290761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnuJzyttXdYOO/Y5QuViyNLB5skqt6xD/FB7G0SDNwU=;
 b=OtdYEASGOv+s4eB+p/XBnblU16n/ryKsPFDql4mFzRfLjBSWLs01NrtXmPmMaAEJqW
 o94M7xIZSYyPSIC0zTjJQQQ5OripqH+LJTamVwapOPuXp0037pEIzeTnMIZE2uj6+GCA
 xK6X9TnaIFwSKfhO/py8hPz3M13uYnDFhKMrqr48/4XohSLRbkFYDYdt8xq/jZ0/Joye
 JXO6odljkMNJQoSP1UJw8FXnUUCEP6UcX0DRp6TUmyZtPIo4pCTqbh7F/58Hz0/LVuyW
 j0SAO8NgNteEhnsNVYYLr62WNJTEQwWbum82aKOpH8f4LapXQNREunExlsZOHOTDEcRu
 Ja2Q==
X-Gm-Message-State: AOJu0YzdFcdYQ1MZ+t3U4RtPBACbr3tCpyTg37qfv9Z+2zwYp5qypheH
 UppLU9KHrOAru6JXZjjqczA=
X-Google-Smtp-Source: AGHT+IHBr4sJRHX5Zxk2Z/bmXnn8lCAKdGSXIRPgoVG+Mlsf/MK66fS5VrAY7wp9G1cv/78MoBa/9g==
X-Received: by 2002:aa7:c508:0:b0:523:1004:1c9a with SMTP id
 o8-20020aa7c508000000b0052310041c9amr5315459edq.35.1692685961494; 
 Mon, 21 Aug 2023 23:32:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 dy21-20020a05640231f500b0052a19a75372sm784320edb.90.2023.08.21.23.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 23:32:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 2/8] power: regulator: palmas: fix ldoln and ldousb
 detection
Date: Tue, 22 Aug 2023 09:32:14 +0300
Message-Id: <20230822063220.5191-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822063220.5191-1-clamor95@gmail.com>
References: <20230822063220.5191-1-clamor95@gmail.com>
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

