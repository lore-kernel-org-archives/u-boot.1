Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C432C369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 13:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD8A820F8;
	Mon, 14 Apr 2025 15:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PHZykger";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B4682103; Mon, 14 Apr 2025 15:19:33 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F27820E8
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A2BCA3F16B
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744636770;
 bh=OWPf94//TfjzIYsO70+dxOr78W+W0Ii6+kWk+YBXpnc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=PHZykgerPn1r9jZ2oCajYq3ArmHBSIjeciPhOs6u8SZWdku7aZtWt1rsRa9TR/bUc
 4wYNaEK2YSX7qUU3epJTVBdvy7hzDy0JOdiCUh/aGiWkUy0FZAKyTyouGjLTg3tnwb
 DOgsIC5zsQoxyAXjSEEVqil1ermw8hHqUrVQHumMGsfjidz5zXCyVCRAnEs12oeYfA
 aT23vkYOtbXrqha9SXgVnJV+DhzAeojK0LaHTUrEz3Tj6ISVRY8Qfh/oekmZCBm8+r
 97NmuCIS7LIYHNJ6hnY63jEm6VVaEAzoY0Am0Vj9Eq2MVeeDDG3oF5zHRCNw53JAVG
 K6a332nC5qFOA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso1565514f8f.3
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 06:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744636770; x=1745241570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OWPf94//TfjzIYsO70+dxOr78W+W0Ii6+kWk+YBXpnc=;
 b=ikVOS3dzTsEyFkHJM1okv+U/l/O6Pjp4MyDHM2y/Ik/faO2ed/JelKNnRw+esNh7Kt
 mQUFehoZAVwxgvgpiYYTG1BBAu+YNAuTTNe1ubT2emWbQiyY5eLCiRNnq/YM7z3h4qzc
 fyue8iJy3vIb2Mi6aqqr5Msd5ceGtF+fkIBni6TJHxpw1fS6+olKeEhUG8xjflOGG+ie
 wXduAhMWKOSqzjKP8B++LHJHQS1sW8Sd0zmtkYDCtDbHJdBwSsAHU/yxcdTXU7z/7qwa
 Z0eT2k7G1gc+VZn9NmNDiC0V8eyxthAcWTa4MSVm/RAviIa303vdoIfpDZKj0NQguHkz
 IdVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtcmOZDWKtg7jh3SbKKtSySjlRFAdVb0QHa1zrriRres9N+rFKuCGQNExLjGvI1RRfPAiROpA=@lists.denx.de
X-Gm-Message-State: AOJu0YxzURhlHBIaclnqG94b1zaSUOrI+RGEur62Jr9kOgQOslhPiqjg
 bEj1h1jRNEOMXQazJU/huB1l0HK9BANw2qxbe+42doxyeUZo/R7OmcAyQGC7uwI/j1W72Qwh2l8
 4X9/R7CUZ0ypfoRawR0tb3J1Vb3vd2P1wSyszAcsMX19RkezdimXsZ89FHkmrVA5VNGU=
X-Gm-Gg: ASbGncvIXCqX1O7VJHRdE6g/psPMj1Aycw9wxRYtD4qYd1PLSQOrguIOtSTldtlcWdV
 v35oH0A1bVQjDyV5eaHyIcMqIwD1jExeG/QblV96Tjunobb2ywTyg6tu26V4Kt59VZQZbCq3y6+
 DKrPLbPzece54wMSQ88gU0NqtGf+4M+WUWr7nKfYCL6W/yN8JnYbYxtXCLm+39oeuFWpamS+zHA
 QlfIn7eL6x87djfN53cuflFAJdsgGckbo/KRlmUzBmYKGotC51q07ol1NcNRqaPw7TpttPqUm5J
 dZvbt3/3g9TEtVpBdFzOTtwnEpQByzbRtCBjNHdNAFbbVgsZWChzzHYcsz5CsKl7///VEfCRdWH
 JeOOa3GXOeOI0hg==
X-Received: by 2002:a05:6000:2405:b0:39c:1257:feb9 with SMTP id
 ffacd0b85a97d-39eaaed586amr9178485f8f.57.1744636770131; 
 Mon, 14 Apr 2025 06:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlurClnvL5Jm9eC8DXRXNbR4QxXoHfNmRP6wP5zGr3j0y5FeeNknsDlmheDKuVMs0HlFVOKA==
X-Received: by 2002:a05:6000:2405:b0:39c:1257:feb9 with SMTP id
 ffacd0b85a97d-39eaaed586amr9178456f8f.57.1744636769702; 
 Mon, 14 Apr 2025 06:19:29 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43d38fsm10992168f8f.71.2025.04.14.06.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 06:19:28 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joao Marcos Costa <jmcosta944@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>,
 Andrea della Porta <andrea.porta@suse.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] fs/squashfs: avoid illegal free() in sqfs_opendir()
Date: Mon, 14 Apr 2025 15:19:24 +0200
Message-ID: <20250414131924.86672-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

* Use calloc() to allocate token_list. This avoids an illegal free if
  sqfs_tokenize() fails.
* Do not iterate over token_list if it has not been allocated.

Addresses-Coverity-ID: 510453:  Null pointer dereferences  (FORWARD_NULL)
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Fix typo in subject line
---
 fs/squashfs/sqfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 7c364686f14..2dcdd60f683 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -949,7 +949,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 		goto out;
 	}
 
-	token_list = malloc(token_count * sizeof(char *));
+	token_list = calloc(token_count, sizeof(char *));
 	if (!token_list) {
 		ret = -EINVAL;
 		goto out;
@@ -987,9 +987,11 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 	*dirsp = (struct fs_dir_stream *)dirs;
 
 out:
-	for (j = 0; j < token_count; j++)
-		free(token_list[j]);
-	free(token_list);
+	if (token_list) {
+		for (j = 0; j < token_count; j++)
+			free(token_list[j]);
+		free(token_list);
+	}
 	free(pos_list);
 	free(path);
 	if (ret) {
-- 
2.48.1

