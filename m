Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CB9C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A2387D84;
	Tue, 23 Jan 2024 18:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T5LayW2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BFE87D36; Tue, 23 Jan 2024 18:17:28 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9A487DC6
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a30d2bd22e7so69754066b.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030235; x=1706635035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkrVmWvSkp/mJ2il5S6WAUSi84UecrHKdXD6/WYdGtg=;
 b=T5LayW2CFCpvbjnP8p9/eY7ByG7FYrYp8ayUFuu7tnIa6T3lb5EEs1uVIeJhpfT2N+
 OuRL+PSUb7+GfqIeeyf6iBgpqm/I7vvTvhp84WngAcVh8oFzEpgCQUgjooCTd8amwurq
 7JYGi/w+6nQ9ViiQz2hyS/rQhVT6vX45pdKm8w7eCOce03VWvdS8Qyy2VLYoRDxjJ1sI
 ec40U48aQKGOkD+STJk1GxP5qw4MGLibwqN6B5xhTlZSbh1Igc/Ov4Y8wthlqKUrEebo
 TuDKAHXqnNaDjYFFjtRkc5Qp6U9FDNS8Qj+tl90FjqbTjYVgGQgbpuDZ3C4B9Z5bBRX9
 mBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030235; x=1706635035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkrVmWvSkp/mJ2il5S6WAUSi84UecrHKdXD6/WYdGtg=;
 b=Mh1JOQfRyb4wtdRt2lBfnbGprr8Wa/aicVFmVjVuu+ikXBn1V915vFBZL08+ik99p/
 jVsVq96cnwllV0TMbfDxHwoZDDmpn1nmvx6f3bqdYmbzOKOoA4A2wO5DkPX81xWo2+6t
 /2Yj50nJzOb22hIafLopWX9yQQN/YrZ+0tbDx0+hyCzDOHDqrehPZdESNNOhq9w44eZz
 AUat/nDMx+u6YUthJg82Za3Z3+MnWXnLmL8m9knp5G0e7b6eGtQfc7900+/rdgdPDhtU
 J3q9OrVr2GfB+ARgnt5IYf9s5t8mz5mjZdiOQvjqZGr3pa9ewtatHOCF1N44b5qYlkFw
 1GXQ==
X-Gm-Message-State: AOJu0Yy1J4GjMB+q5oLI+AHkr0bj6jA6mAWRlErUCEW8nCY5WYGwXPFL
 /K8lgldsVwjLTGQscXLW2JyYBvoeyXdno/YD+3nniGefs4suuXAm
X-Google-Smtp-Source: AGHT+IHytxWusLbCLbDeBSWf6PKAAKvaI6vExhJnuTBxuZGVk2hDQ9lTD5zREEdWuNNV/6UhOkpaPA==
X-Received: by 2002:a17:906:3b0d:b0:a30:ab58:1638 with SMTP id
 g13-20020a1709063b0d00b00a30ab581638mr148852ejf.30.1706030234869; 
 Tue, 23 Jan 2024 09:17:14 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 16/18] video: tegra20: dsi: remove pre-configuration
Date: Tue, 23 Jan 2024 19:16:31 +0200
Message-Id: <20240123171633.246057-17-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Configuration for DC driver command mode is not required for
every panel. Removed.

Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index fc9ca1310a..ddd74540f2 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -766,8 +766,6 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	tegra_dsi_configure(dev, 0);
-
 	ret = panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
 	if (ret)
 		return ret;
-- 
2.40.1

