Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA33CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 13:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CBA68827F;
	Thu,  4 Apr 2024 15:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Blz7bRvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6647988286; Thu,  4 Apr 2024 15:20:07 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D2188276
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 15:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d84a5f4a20so2170471fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712236804; x=1712841604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MD4V59DZ0FT7BcjNHj1oMvqv9lQZOXXNk6ycPb10cnM=;
 b=Blz7bRvooYJogxccVqIh5pguB/SRf9d9FB9u7g+N+W81OZ/sdSBmpjYRn5WEod5Krr
 YMBWABu9pO5/phnLi1WQZ5VjrXGQsf3iVdMuOTgsOawcYwrTJO5RyJQGqKuNAKD/f6Ey
 GqoHHo4XXHQCBxN3ZpIg1X8aLi3R6DF7dXo+cqH2z8U5eyON2PVECF0wo8MR0HBHYaBR
 AP2xB12mu6JLPYglWxCNJnMedDIksccCn7NRCvpuaY+U7OCGgXQA5OcI/an6SFjeHLB/
 u3bG+yEEjMhgR4alBNAVXrjV+2nZT0F8OiN1uHh9dezVa0k0U/C7SEIWHFXdlu+7EWAe
 Nm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712236804; x=1712841604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MD4V59DZ0FT7BcjNHj1oMvqv9lQZOXXNk6ycPb10cnM=;
 b=NZ/qmmkSFV0uPDFvEYi0FjQdItPh67EKpFTp2yfD3iaaR96hPYDKHbpXZstTfCktML
 Q2O6HvhN7dwAVv6H/z927mXHhn+ewxzMjjgOBxJHGWu/V7SJBWbJkfdRFGbOd8O7G0Qv
 mvJHEE7jNXVko4sciNNUeVGJFkh1doKJL9qlOrrecWAngqNrMLDP/bUGYGWPD0jON9/b
 J4lMiubi22iPfRrGTXXqeyjWv1BwjTuMF88FqH8ZIRpkOmcney5izXAGSZnJAlVG4gID
 G89YYXW3hEm6Rw0EqG/EwVf5S4gKt6LTJVEm746y9vSYBHwGM7SAIzFhgbP5ZX09Kw3k
 12xg==
X-Gm-Message-State: AOJu0YxxEwcB5EDNR/1lS1kz1PkhSwBMv0U2lNGFzuETpHtOV2OwkJJb
 8Kj2CK/iLojl9cwqhVkBfxiTN4ZAYQQE8o8YfrngNsKFI9F8/kK7NF0T61pEO9odrQ==
X-Google-Smtp-Source: AGHT+IEiuAiIgh9N6N+dVJrXB9HDFMeL/UZUp5LsWLn/gJ0+rAftM4sHc7K/cNGYqy+fzzItSFRTjA==
X-Received: by 2002:a05:651c:97:b0:2d8:1b2a:6526 with SMTP id
 23-20020a05651c009700b002d81b2a6526mr1631196ljq.4.1712236803289; 
 Thu, 04 Apr 2024 06:20:03 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 g5-20020a2e9385000000b002d42b1c3750sm2092263ljh.67.2024.04.04.06.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 06:20:02 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, jens.wiklander@linaro.org,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 2/5] cmd: optee_rpmb: close tee session
Date: Thu,  4 Apr 2024 15:19:48 +0200
Message-Id: <20240404131952.3252301-3-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
References: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
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

Close tee session after each optee_rpmb invocation, as there is no
reason to keep it open, considering the absence of any available mechanism
to clean up all open sessions automatically before handing over control
to the Linux kernel. Without proper clean-up we might end up with orphaned
sessions registered in OP-TEE OS core (obvious resource leak).

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v5:
- Extended commit message, added more details about the reasons why the
  change was needed

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

