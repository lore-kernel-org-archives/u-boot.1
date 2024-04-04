Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B348DCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D073E883DE;
	Thu,  4 Apr 2024 10:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UlvmDQY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62DC6883E7; Thu,  4 Apr 2024 10:14:10 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75898883DE
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-513dca8681bso234463e87.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712218447; x=1712823247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P76sNKMUNnVBtjMQCGQx54coxrxwSfHgwuQDNLm7P1U=;
 b=UlvmDQY11cIcHr0aAIsivrD+gRX/akWMTozW75qv/7AeM3q972KhHtfrLkgYMDmO+6
 y0OSdmkOkxubNJNPjmLXm0VcmxE18i5okiKI45CI9jPuLU0WvgdFz/Dk+b50zQ88EivB
 C7ZOck4yqxvJ/dwVUqliSlPf80sehrj/WGa3MK2e2CohTHHL2gViyynNKT0vSn1uRnOo
 4tfMDbseJkOcD32rPgL/ifLki1aGBzreL1+SmygdaPl7D+pKalWx3avDx866GXcCK9oh
 7C2Dw1QWWActei6QCN63a80995y+z6lUNulWKOaefN0l8OBePFcnPQBBBT4J2OlYctEN
 TX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712218447; x=1712823247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P76sNKMUNnVBtjMQCGQx54coxrxwSfHgwuQDNLm7P1U=;
 b=QwR+Irn5s4c9fvQDO3X2e96nmiP7AoLu8s9tvS11XpMfBVjxzKE4L4LHxDzJpwtEJY
 EY8mkzzEzdCpZHnfIPqh+Uhjyh7T6u3GOj5NYJXCF42PDYyA5AxzSufULRNutcoQuenV
 dfenlVAbPvXVsRtkTUgbeblHqJrK017mf3u+kr9TiX2z8KYh3eol/8SWzdn/yTl/Gine
 Vxi9cyArOYxq9LUJGIady4BKurusrXN5pdRtB2RHiy9XQi0VgbL0nm5WCv8k7RPLsAZ8
 5cPr0CPeOyifwFmTZM5LjKC7PsVFCcGN/2TzvJnm1BcD1ygNXkcy3G625a0UnLG67qKL
 P14g==
X-Gm-Message-State: AOJu0YyIodmSYuTUUFvSatHnZqgh8rqaVWMRTel+wG2AHtrRYVTrBBCg
 auuPCq3FifjeNxLSEKMEORlGVlbYZ9HoAPjQZP+Yt90jtbFYfY9oAs+OSTQTaI6wpw==
X-Google-Smtp-Source: AGHT+IFk58c+ZgoN96sexKAE3jls9Q+Oz3AFzw+bH2VKnQ/3E4kkmZCnlgnvTttzYn2rT4ZRpXT6kA==
X-Received: by 2002:ac2:465a:0:b0:515:920e:eecd with SMTP id
 s26-20020ac2465a000000b00515920eeecdmr1151838lfo.1.1712218447029; 
 Thu, 04 Apr 2024 01:14:07 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 u20-20020a196a14000000b00516be925768sm388157lfu.292.2024.04.04.01.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 01:14:06 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/5] cmd: optee_rpmb: close tee session
Date: Thu,  4 Apr 2024 10:13:49 +0200
Message-Id: <20240404081352.3224643-3-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
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

Add calls for closing tee session after every read/write operation.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

(no changes since v1)

 cmd/optee_rpmb.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index e0e44bbed04..b3cafd92410 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -87,8 +87,10 @@ static int read_persistent_value(const char *name,
 
 	rc = tee_shm_alloc(tee, name_size,
 			   TEE_SHM_ALLOC, &shm_name);
-	if (rc)
-		return -ENOMEM;
+	if (rc) {
+		rc = -ENOMEM;
+		goto close_session;
+	}
 
 	rc = tee_shm_alloc(tee, buffer_size,
 			   TEE_SHM_ALLOC, &shm_buf);
@@ -125,6 +127,9 @@ out:
 	tee_shm_free(shm_buf);
 free_name:
 	tee_shm_free(shm_name);
+close_session:
+	tee_close_session(tee, session);
+	tee = NULL;
 
 	return rc;
 }
@@ -139,17 +144,20 @@ static int write_persistent_value(const char *name,
 	struct tee_param param[2];
 	size_t name_size = strlen(name) + 1;
 
+	if (!value_size)
+		return -EINVAL;
+
 	if (!tee) {
 		if (avb_ta_open_session())
 			return -ENODEV;
 	}
-	if (!value_size)
-		return -EINVAL;
 
 	rc = tee_shm_alloc(tee, name_size,
 			   TEE_SHM_ALLOC, &shm_name);
-	if (rc)
-		return -ENOMEM;
+	if (rc) {
+		rc = -ENOMEM;
+		goto close_session;
+	}
 
 	rc = tee_shm_alloc(tee, value_size,
 			   TEE_SHM_ALLOC, &shm_buf);
@@ -178,6 +186,9 @@ out:
 	tee_shm_free(shm_buf);
 free_name:
 	tee_shm_free(shm_name);
+close_session:
+	tee_close_session(tee, session);
+	tee = NULL;
 
 	return rc;
 }
-- 
2.34.1

