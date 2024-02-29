Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8C0C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 22:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B30B487E78;
	Thu, 29 Feb 2024 23:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kXxH4FyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80EF287F73; Thu, 29 Feb 2024 23:32:49 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D068765B
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 23:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5131bec457eso1367978e87.0
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 14:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709245966; x=1709850766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r8LNRzDgCaKyltHX1kF7iyphhft2LCh9mMOOcEBjnc4=;
 b=kXxH4FyVbf4+lo6fsYJaSzGJf71JhFKiTyx7hfKnqoeqiYfaW0lwzq4zEa8dGRHC+f
 FhqWCzAQHEs+zSrw9pMT3zrS0owdiKEYaqmQkKNe+8dywEEP35/m9dzdRiWqGNaN6FsJ
 rIaq4baKHqXfznZAJAAAHTJZlPmcKn8eTuxffdEsnomPO4qEjheIKfLgZcBMcPN/X85R
 s0XURkoNqrH8nufsMbSJ5LVh+glu2EleJQxyKsNUi3ZQqnHOyBoyv5luQW0IrbmE0oEa
 kJ/mWk7+FKi0u4YzhGSuJODQ4y/yrE/xpcUmirvTfsMZ6f/Sjcl8/6A1JvkVYqw9JWgd
 YU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709245966; x=1709850766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r8LNRzDgCaKyltHX1kF7iyphhft2LCh9mMOOcEBjnc4=;
 b=s2RZbelkZ9jgKeU8nNnLZmh/a+q2lucZc7h9Qw7ozEd/qIUuF5Z88VAz9MTB0lw4yn
 JrDfWsRCm805nsQMoytVy4cfgZOlPkSb4KMHwrrghhsfi4bbk+VLup4R+j7q62UQKUPQ
 5mW9UvCO3Oq3xQydNs36EI2PVzX1/9ewtaVhNoaZJKaarGaLoMmrC6lyHfkS7icYul4A
 oFMAzltvHh7ONiey8+Dnon822P+r1zBz15Cvg2DLqZGrehtzRJV1Ar3+Eo2V4h8Lo85E
 IBU2l3IwitwA50eTKV+a5rp9CUxdjrnQ+lbtfhVCNEsaqvmJue0ihITejNWnh4qyD0sG
 O6kQ==
X-Gm-Message-State: AOJu0YyctZYKFiCu7C9+UFOcrhvnlh+sA9UtZrg/A0PB+zMG6mxT60G2
 2kjUiyX3awhJle1RblAeRO8hcr8jaxfT0yb/X4yhBVtv8nQ/U5Tp/Zz3wJR2
X-Google-Smtp-Source: AGHT+IG2kMVAkmbKyPfvMCXfC4z6ENFEYSuyZsUqfRVH2/3DCwVF4ORCmrbuxihkT2X4WwRqDeIpCA==
X-Received: by 2002:a05:6512:3c95:b0:513:2508:d2f with SMTP id
 h21-20020a0565123c9500b0051325080d2fmr1694012lfv.12.1709245966148; 
 Thu, 29 Feb 2024 14:32:46 -0800 (PST)
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru.
 [95.37.3.243]) by smtp.gmail.com with ESMTPSA id
 j15-20020a056512028f00b00513172d5b40sm394262lfp.67.2024.02.29.14.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 14:32:45 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] autoboot: Add check for result of malloc_cache_aligned()
Date: Fri,  1 Mar 2024 01:32:11 +0300
Message-Id: <20240229223211.22489-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Feb 2024 23:53:15 +0100
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

Return value of a function 'malloc_cache_aligned'
is dereferenced at autoboot.c:207 without checking for NULL,
but it is usually checked for this function.

Found by RASU JSC.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 common/autoboot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/autoboot.c b/common/autoboot.c
index 5d331991c1..6f0aeae6bf 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -167,6 +167,9 @@ static int passwd_abort_sha256(uint64_t etime)
 		sha_env_str = AUTOBOOT_STOP_STR_SHA256;
 
 	presskey = malloc_cache_aligned(DELAY_STOP_STR_MAX_LENGTH);
+	if (!presskey)
+		return -ENOMEM;
+
 	c = strstr(sha_env_str, ":");
 	if (c && (c - sha_env_str < DELAY_STOP_STR_MAX_LENGTH)) {
 		/* preload presskey with salt */
-- 
2.30.2

