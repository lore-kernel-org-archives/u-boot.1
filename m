Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898D9C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 18:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 010AE87D9B;
	Wed, 14 Feb 2024 19:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="CYWCJ8A7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8588787D9B; Wed, 14 Feb 2024 19:35:14 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C23C580E9A
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 19:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3d62da9d25so85042266b.3
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 10:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707935695; x=1708540495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euEPLM3uwR7syEL7xD1whGsndjA8rrfy2Zq8OUPZ0qg=;
 b=CYWCJ8A7QiIciklE1A5qaeRlXSLsiySXE9pUn23urDz7jms4+eOf3TnotHK0ondzvO
 TCPc9UJnRQT02P81+qf0+8oaCpJO9OFaAYhqmq+vtJTKjP8ejsz3RKcuR5XZJ1aWee2C
 B+4DQCV+VPKb1DRf+ocZNv3qhgTXvkqhi7F1yaX09f390IRETl5+FxgIMEpl4qPurkhM
 aq/0cyD8GcmpXLGAbeu8wHybjO4A7oXf6+CGvsLQNUie1wi2iSfmM8nmRh95rre3Qx4a
 5vAyWcOBBLBLiM2I120K87XB15jt/76jOQl7r2R39PSPGj/BkCLAVrRIGHYkuPit/SQv
 sR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707935695; x=1708540495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euEPLM3uwR7syEL7xD1whGsndjA8rrfy2Zq8OUPZ0qg=;
 b=vFfa5udQV1Ze1LgqWSyZRYKqsxZlHjsY848m9xQk3J7tN7iH9jF5FWd7HU91cGLOgL
 Cw/MWknIZ0HywnMKMIhlWvAahmJWv/8ezteC3o2JOpXhHOU63bIqikgYHqPQGkZp4Jud
 YMUIreIyrE1kA1acIpEf3k/CXWZJlFACXTEJNdYSPbAW0SrhFId7xb3LC5BW8KPPlZrd
 cqDym+ldrZivF2616xCX1H0zioweRMKs0nopbNyJtrWu4aR0R9Oaqc9uIaRdClPHNg7V
 GaoMtfzFvfII5yKJkp6jLmp2T8kKX1yAD9B2lN39/wFbuij/e4FhYrY6zXz0V/dtAHwS
 U7DQ==
X-Gm-Message-State: AOJu0YwLciwXQ8k0kYKr/nWOcJeb1IeJBy5dQ7NuWxg4X7oX3i7OTffF
 hLSnnjIR9FmzDFKz19MupQLYzT6pnXIr/q8ijLN3gVZkA9o9Av2CdT64cfQRXZQxKP2qxENXtJX
 3mvo=
X-Google-Smtp-Source: AGHT+IEYZtMml9cOiAG65yofYzpK3FJ/jU3DAP90+7anglpMZstXqUw3i7s1u+0Q0JcclJcFIGKEzg==
X-Received: by 2002:a17:906:a2c9:b0:a3c:8299:9c5f with SMTP id
 by9-20020a170906a2c900b00a3c82999c5fmr2389977ejb.75.1707935695435; 
 Wed, 14 Feb 2024 10:34:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUR84sohPPIItyzhyIQBDpdM0X5g0e2olpUy5ssD+TvdMNMj2KSq16EmA07ojx8EU2bv/JcHYkYRJn6F4cSePKW8hDVdj+N7mrRTRVtCRTOqrraixOdeAE4pvKVyPR78nZoksYBJj396q2vOVEmuc7zmi8NDdUo3CX6iONq38nZXGPNf9oWbN8kmapYJuzFYwW58sBilhkIJOYGpqeulcQd
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 vg14-20020a170907d30e00b00a3ceecd6cfbsm2160778ejc.56.2024.02.14.10.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 10:34:53 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
X-Google-Original-From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/5] tee: sandbox: fix spelling errors
Date: Wed, 14 Feb 2024 19:34:41 +0100
Message-Id: <20240214183444.493629-3-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214183444.493629-1-igor.opaniuk@gmail.com>
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
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

Fix spelling errors in comments.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 drivers/tee/sandbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index 86219a9bb1a..ec66401878c 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -14,7 +14,7 @@
 #include "optee/optee_private.h"
 
 /*
- * The sandbox tee driver tries to emulate a generic Trusted Exectution
+ * The sandbox tee driver tries to emulate a generic Trusted Execution
  * Environment (TEE) with the Trusted Applications (TA) OPTEE_TA_AVB and
  * OPTEE_TA_RPC_TEST available.
  */
@@ -23,7 +23,7 @@ static const u32 pstorage_max = 16;
 /**
  * struct ta_entry - TA entries
  * @uuid:		UUID of an emulated TA
- * @open_session	Called when a session is openened to the TA
+ * @open_session	Called when a session is opened to the TA
  * @invoke_func		Called when a function in the TA is to be invoked
  *
  * This struct is used to register TAs in this sandbox emulation of a TEE.
@@ -140,8 +140,8 @@ static u32 pta_scp03_invoke_func(struct udevice *dev, u32 func, uint num_params,
 			provisioned = true;
 
 		/*
-		 * Either way, we asume both operations succeeded and that
-		 * the communication channel has now been stablished
+		 * Either way, we assume both operations succeeded and that
+		 * the communication channel has now been established
 		 */
 
 		return TEE_SUCCESS;
-- 
2.34.1

