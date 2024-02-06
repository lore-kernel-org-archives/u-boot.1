Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE54C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 22:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFACD87C93;
	Tue,  6 Feb 2024 23:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE009876AE; Tue,  6 Feb 2024 23:32:02 +0100 (CET)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3E2876AE
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 23:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5114a21176cso1355733e87.1
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 14:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258720; x=1707863520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNjPCCwE4bQz2Zn/IhDIXv3ByYtXVT9kgvh3YH/mlbQ=;
 b=GJI/VJUztG01U2sK6jkvTO8IYRa5R/kMcLsJYcxt7rG1a2b/E9Kk8/zKZL38SKy7At
 GqtOtqvBVSavO0SRoN++wAd1yzlIFqbhR3Q8yVsxS8acK45ySkIyZ165atksA3Rw8KLn
 JSVXN4604GAKGtrxVLwnYAqGb8IgdCLSzGPqX8szO2N2E8VKj3T/OXi3wxvmju2YEf6g
 aEDdyLdn3Cz2XOZPlZn5lgP5m+Qbs02q3i2AWe0YwmATUNQmiJ+FdrtCKHOiBrykDS8X
 EeC5wZX8slcLv2TEg3mZ0ExR6a+6SiznS4PvhYBIskHXpe2FBgKExiGzvjMaqq6LLest
 YvDg==
X-Gm-Message-State: AOJu0YziRw0Oi/UTlCSBQL13iXSBz1yGINV0YL4DtME7iOkKuIvBL+Wf
 df9cVBrHJhq5cEjQN8sFLDHe2Mss2BcKpO8nkDl7SFzEkJPRAvnDs4buLvYPzznm1A==
X-Google-Smtp-Source: AGHT+IH5+dL8B47JiqgOGUKbHayn9BdCsotxcLTXn5sYYzR/u3iAa2VZ9a5a+UjphBalK//aDrSDcg==
X-Received: by 2002:a05:6512:511:b0:511:5b35:d119 with SMTP id
 o17-20020a056512051100b005115b35d119mr2199921lfb.2.1707258719430; 
 Tue, 06 Feb 2024 14:31:59 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVR4qDyfnD//AINFxAwfrALCU802sHmkaiSQ8Geix0XJlED2DFnrBO0ZeH4USdU0bAMfpqCGzpOm+Zbjwcm9BINXGSZU1VDFj7TuCsBY1xoI9PlQ2p4aptMKdRtHMMutvQQzuPb3S8f7Juh0FVdj8rNdlXXapzxVvUfMj2r+IuYZ9AVrYVUVSJCox9IKd+O6mg=
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05651203aa00b005113abb16fdsm356005lfp.284.2024.02.06.14.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 14:31:58 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/7] common: avb_verify: don't call mmc_switch_part for SD
Date: Tue,  6 Feb 2024 23:31:47 +0100
Message-Id: <20240206223153.3060433-2-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

mmc_switch_part() is used for switching between hw partitions
on eMMC (boot0, boot1, user, rpmb).
There is no need to do that for SD card.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 common/avb_verify.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index 48ba8db51e5..59f2c25e0de 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -358,9 +358,11 @@ static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
 		goto err;
 	}
 
-	ret = mmc_switch_part(part->mmc, part_num);
-	if (ret)
-		goto err;
+	if (IS_MMC(part->mmc)) {
+		ret = mmc_switch_part(part->mmc, part_num);
+		if (ret)
+			goto err;
+	}
 
 	mmc_blk = mmc_get_blk_desc(part->mmc);
 	if (!mmc_blk) {
-- 
2.34.1

