Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26611D41C01
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 04:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C8B8952B;
	Wed, 13 Nov 2024 05:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DWhSFFdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0C789537; Wed, 13 Nov 2024 05:50:02 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F24E89515
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cec93719ccso8333697a12.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 20:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731473400; x=1732078200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pku2bhDKDLK/dBIWCLpSXuhollEghV1AN0DdaW6alEo=;
 b=DWhSFFdgr/zFuYPAOfGYcBdm0PA8eSHwbisdk4Nzd14accO1y3M3dofSiFEVHolA9L
 ryjVrK3C5O0Oc68yF4H0xJaHEKngCK8ygfF7aZ9UHwe+EAZXIRZgpD5MgVs7yyo8XgDj
 bJ1/Geivm+lnS/2jMygB14eT6I0oLbmfvfjRPWeGaFVyEp0m/FrDfsaMGoAcXAPL9NPl
 EnxjGcKSkekc/a5ZrSl1sroOcEM2XqlQpFWUN/kjy//RjNW1mMRg9mmoZh7g1Q9ra93k
 8jQvcKSbEW0wIl5ujZHLXxGpCBxAedb5Jl3yifTyJUcAeAw8f/DZGK4YR2r+LDKM5S7d
 EZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731473400; x=1732078200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pku2bhDKDLK/dBIWCLpSXuhollEghV1AN0DdaW6alEo=;
 b=qK4AqA0UuvgeIOGEoQVqqxp+5Z9Gv2Sk+5QqKVtuuzF02vcWi+lIrwQj4aV5DHd91C
 Av+4YxfL629q/DUg3jIafnCVqW+J75/k3DHKeBgDTnVRgcg80PHu8pGKCjgzbfSaiYXb
 rTJKsW27TFbyKlWonivwl2Hzq3VLuQ2KwO6x6WWXzdnu/h+1tu8ESWhZNN2PI35D2lJs
 NdhyAmO1EVm1sw8F4jQ8U0YxXgwuNTFe512YN3P5DzM7Hj4XaVU/cym17eFrgH4nw/n8
 Fox7/T8MDm1eCBlrQXiPpIww1EBlhnBpWdymepun8QmG/mvDblquxzsDDGtTrXay9Tfn
 d1Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMEybWVJJ2lLmkqHtbEJVtGdl454ZEpWlVOdniwcZ+l7OHFKb1eSZSm7xRFL05Dmabiih1dyE=@lists.denx.de
X-Gm-Message-State: AOJu0Yygdotg7sMgdss4BMdYxdX2LPwFrfuuXkGK5YVbPKIXJ7DXnRxB
 0MytfOhPjUvCE+C2WWBZnAwiCs+We0nzw7AedVTGnhLzFoYdkbeuTRWCJtfTBho=
X-Google-Smtp-Source: AGHT+IFnSl4VIEPBv74Cneauh9N4ZrQUw24pLH44DCfHV1aLg/76O9qxReJPpl+OkOyEKUljDBF5yA==
X-Received: by 2002:a05:6402:40ce:b0:5ce:fc3b:d46c with SMTP id
 4fb4d7f45d1cf-5cf4f362882mr4755914a12.18.1731473399912; 
 Tue, 12 Nov 2024 20:49:59 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf642f9eabsm439241a12.23.2024.11.12.20.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 20:49:58 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Alexander Dahl <ada@thorsis.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] fs: fat: allow FS and device to have mismatching sector sizes
Date: Wed, 13 Nov 2024 05:49:46 +0100
Message-ID: <20241113044956.1836896-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

The Qualcomm Robotics RB1 and RB2 boards feature MMC storage provisioned
with a 4k sector size GPT, with factory partitions formatted with
filesystems using 512 byte sector sizes.

Whilst certainly unusual, and really not ideal, this appears to work
fine in practise. So demote this failure condition to a debug log.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 fs/fat/fat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index e2570e816768..a84ca301cad1 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -645,13 +645,12 @@ static int get_fs_info(fsdata *mydata)
 	mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
 
 	mydata->sect_size = get_unaligned_le16(bs.sector_size);
 	mydata->clust_size = bs.cluster_size;
-	if (mydata->sect_size != cur_part_info.blksz) {
-		log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
+	if (mydata->sect_size != cur_part_info.blksz)
+		log_debug("FAT sector size mismatch (fs=%u, dev=%lu)\n",
 			mydata->sect_size, cur_part_info.blksz);
-		return -1;
-	}
+
 	if (mydata->clust_size == 0) {
 		log_err("FAT cluster size not set\n");
 		return -1;
 	}
-- 
2.47.0

