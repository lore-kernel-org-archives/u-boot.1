Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BC4CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 11:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A6D83A79;
	Wed,  5 Nov 2025 12:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hTE1PqZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC0EC83A71; Wed,  5 Nov 2025 12:07:33 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C1983A5A
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 12:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-8804650ca32so31170846d6.0
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 03:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762340850; x=1762945650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6L7QHq6fV0FFqgRfBhyiKS9CQh4kD5j7xLKXarsz4fY=;
 b=hTE1PqZnvnDa37/ZxmXsyIZgyFzRTKDHFSIoxllrEr9UF1jxmM5Q/QF0YeORJ85Zvj
 x1fvVRoOHsNF0zrykMDPwscUBmo3h64jvGoRuZnpPYTNdskBOqi6iSWYre9g7zZVfd/u
 g9wYnNqqkEE3m95pE3CP5IYxdwAWXgNzhwtDrveVKJuDyZowChzJuLkmnTTasvJ4SNWu
 Q+DiprSB8rAs3KqPV8fDItl0weLkpAnBtADCBCT1+xbGN0cJyxJmJQxmts8tFgvQZdTb
 jCm3Lt5ZgvJ4AtM5KRk3bAoeU0Ttz2b50/PuEnpSlzfMYy6XV1oI4SVQhTKaHImrCBxL
 Yaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762340850; x=1762945650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6L7QHq6fV0FFqgRfBhyiKS9CQh4kD5j7xLKXarsz4fY=;
 b=Z89eFvrK1IR4U2seq/gwjL5yklJzd2AXTYfGzF99vKHIAZ7A298EnXr0+YsFysFEal
 szLlgzF6KBiErNT6fkO8hGp6CBoJCukPNueef/4GMBIPlul31LOyedSaIQV3ZzdLrd/7
 R9h6T9QSTZn7uAgYR5d6eESKKL9ZENSfU0VVLGBT+opO7LCiU27wOOGb9OueA6PF8xC8
 ZPKFGkyxmwHkl5j4IE1cE6Hd1gFufN6C9hmMNP40aLMDM0sHm9lD6JFIQTIJ30i5MFtu
 YQX+EBx17b4FB+eOrZFBarPwtJnan+HIAtJp1ORfsffdLbEjWoZqxOW0BM076vFwXfJH
 BxZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLaJKfI0vFra1unzuroAR8D/Jb+O2kaoQssK7Aiprj21+VEV9VJgplwmuv2LDdJWjhZYeCtOg=@lists.denx.de
X-Gm-Message-State: AOJu0YwZ3QHnpQ9nxommc97iQouIK2slcDMhYphPyDp+lSzbUQw9RN22
 viRyB2AM/AVOIN+aBoXezVHQeqX0UcTAnwYc+aZS1HKZX/RrKB7rp4Ul
X-Gm-Gg: ASbGncsQu6nJI3mWtjhcgWopujuCfhUVq8zuHX/35ErFPPXm2ewNJs7s3j5Wv0q/fd2
 c6gJgoQbvJiUiYAoCEyCFeUQYvZVkt+wf4zLf2nnDONZ5WWL9sUzoezqfHapwZCkVl6SXxZh8tk
 gCsiNK/YCaOMmlz2JsiBiQWeSNKgDlzXXJ0qPevRjwzkBlkysgu6CXhKAtFla9l7HADnAlLU5LZ
 3YvsZ8xJV+RFjLaj6qpNSTmWnTyRZNI+7xnIPge1AqYf2fTbJ/tYtzoY/ovSwyJ0HUB8hQR61tM
 K3KRE8DptinwZsPBTwjDC/JuCeFQTzi5qaJoXyhKgIHjsNz/xX5EOxScQoM7qn7CYWzVvSgPS86
 WtgXxGYNIJTRWoGrG0AVtdsCuhSojBlrH3AdZODdoxwHn3drhHgyMF4omHNeI55OD8b3RsuM=
X-Google-Smtp-Source: AGHT+IHLSR3A/g6suzDD4Sklnxlm2OI0Kehafhuc3+Ls3YZ0x6+4xFxFjZJUAW3OYI7DTQhDFqi7Vw==
X-Received: by 2002:a05:6214:e89:b0:87c:2024:4d5c with SMTP id
 6a1803df08f44-880711ef9e4mr37898296d6.35.1762340850521; 
 Wed, 05 Nov 2025 03:07:30 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88060de9b44sm38661336d6.20.2025.11.05.03.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 03:07:30 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH] scsi: Fix the name string memory leak during scsi scan
Date: Wed,  5 Nov 2025 19:07:24 +0800
Message-Id: <20251105110724.634741-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
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

There is a memory leak during the scsi scan process due to the
strdup'ed name string is never freed. Actually it is unnecessary
to pass a strdup'ed name string to blk_create_devicef() as we can
use the name string on the stack directly.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 drivers/scsi/scsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 05608399be1..b414d022f3f 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -584,7 +584,7 @@ static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
 	struct udevice *bdev;
 	struct blk_desc bd;
 	struct blk_desc *bdesc;
-	char str[10], *name;
+	char str[10];
 
 	/*
 	 * detect the scsi driver to get information about its geometry (block
@@ -600,10 +600,7 @@ static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
 	* block devices created
 	*/
 	snprintf(str, sizeof(str), "id%dlun%d", id, lun);
-	name = strdup(str);
-	if (!name)
-		return log_msg_ret("nam", -ENOMEM);
-	ret = blk_create_devicef(dev, "scsi_blk", name, UCLASS_SCSI, -1,
+	ret = blk_create_devicef(dev, "scsi_blk", str, UCLASS_SCSI, -1,
 				 bd.blksz, bd.lba, &bdev);
 	if (ret) {
 		debug("Can't create device\n");
-- 
2.34.1

