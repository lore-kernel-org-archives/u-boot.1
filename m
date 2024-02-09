Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1D7C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 19:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56FD87E6E;
	Fri,  9 Feb 2024 20:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="YanXU9g3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F2D87E8B; Fri,  9 Feb 2024 20:20:59 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D42B87E7B
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 20:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56003c97d98so1695166a12.3
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707506456; x=1708111256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cEU/P1WawNCmmR0UPeIYaPLufQ7CKdlJnkGwsdhZqQ=;
 b=YanXU9g3RV/N2KIQDj7d0U+Qn+BRS4FBWuQEfJx6e8Mgx8K/IShoJ7pCzmuAS3Ltto
 LpR+ZmEO87x2BZ6lHR1P6R6wdvkNW8CnndVhvdjIb88G7Yk6Gb5f2I6Ry8k9T/Jdzjzu
 gdIGlW/qZ2m2zBo87eWJOVoo2InjT0gQ/10SCb+h7rKso+UtAdQLy1loWzHKZxdEUjjZ
 iLRzFOlYTG0gaPj60F1MJUdaUCH3UP1ULkLwU310vHREUS45SvAWorAQ6uupvyWGbpqd
 0v3zlsVpa2BB7ONf5tYZ6xnpV+XBertg5bDWjKkmUAtcyn0g8yXreVh4zs74+dpsa8hy
 j6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707506456; x=1708111256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cEU/P1WawNCmmR0UPeIYaPLufQ7CKdlJnkGwsdhZqQ=;
 b=SErc8uTWKrIx9R1cUDShSPc+iHfA3+F36yR5786xxIAHsNo+BvXJuh0iVAul+Ydc5v
 e2Gzb+zVVQ26aOfzWvFhYtEDlFMtZ6sqPe/S1b99PzjXliQcNLXWiNSeAPKpms/8Vp0+
 X+QEprTVHdpq+LWILKaL3VIOgHeRc/MAbNiX/DcWfsRqKq+nvGE235G/Tgsc8UcYBO99
 55GA/VkjZUMG7Yq+N7RoQiSrL88pxxkXbSRMcbNot23aVmi8dcEjZJ3wAQKiBsSEgoQH
 aLFC35oD7LauN7tYWY5G7nV80d4qT4H2Jfr11L7PunUYCD4QFrYiVvf1DBKPUIYP4/4k
 dikQ==
X-Gm-Message-State: AOJu0YweziBD37gfJr9yNanlvBLjZSI1OkSLC9gJ5ZoOPeS9IagGjTSA
 rXG+VnPOn2lJz/p+mQGdAh6Z3m+ECa5Oa+jALmXHn7Ks8pArSfNpopjfX0K0wdReIuYsRbZDZBq
 Zreg=
X-Google-Smtp-Source: AGHT+IF5XvZhuFsqWQswFRncrqvuC/yzPpRDorN584bK5UYobpzV8oSkrQLZeIsYakjQFsg9WZeKKA==
X-Received: by 2002:aa7:dd06:0:b0:560:4ee6:cf78 with SMTP id
 i6-20020aa7dd06000000b005604ee6cf78mr2628266edv.31.1707506455928; 
 Fri, 09 Feb 2024 11:20:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUM9HGCqmoAt7QXtYy80jiZrrqDzhnTLEPWlBATkCNmYVKpY4+HqNrQmIwT9CnPqYX6u0s64Wvw+QMEPJSGC2Pucsf9RZ4nGGrAtTdvWEjAnj7b+fMgPE8Uzrr7Oena4csuJOZhUikrXI5WF13txF1kQFwiDaooYYvs9bWQXkNgkjxwmBZ4Y0sT1R7ylvoXekY=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 z21-20020a05640235d500b00560fdb4c9c0sm23014edc.96.2024.02.09.11.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:20:54 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/7] common: avb_verify: don't call mmc_switch_part for SD
Date: Fri,  9 Feb 2024 20:20:39 +0100
Message-Id: <20240209192045.3961832-2-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Mattijs Korpershoek R-b tag applied

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

