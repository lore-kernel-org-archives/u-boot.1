Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164DCC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2F887FEE;
	Mon,  4 Mar 2024 18:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KNxODON6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A94BB87C4C; Mon,  4 Mar 2024 18:45:12 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE8187EE4
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d90b322b0so870927f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574309; x=1710179109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P76sNKMUNnVBtjMQCGQx54coxrxwSfHgwuQDNLm7P1U=;
 b=KNxODON646zNiPhcIjl9W8fYCRAhOKxjTzarhPS8CkczJnKu7h1K4gmfpq7nVCAyKa
 9zoo6gINFasvUhn+1j8q4IQl2iq0jjlcHXXylg3wZX3oaNv2lyhSn0XU8kUqNbABNwRi
 nJhzrqHTdfwYbjI+JkroPXXtDTNuMJqTbdgcHqzep0rfXhL/gmT4N/DL6vryjGPCdQWm
 gB6rIL5GcTZEPmA1JbV5uYvAtdjyZ8p6ghHWbznMKpGumJ9FR6VF/GDRAJPfAUxfhJ3o
 2/wnFk+3mH3PdarO3Cep4MHqRNmBEJAlsjcG0TJYaW86fIiX6aq7NqJZLCnLq4FdIYD3
 ru4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574309; x=1710179109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P76sNKMUNnVBtjMQCGQx54coxrxwSfHgwuQDNLm7P1U=;
 b=kLHUe4Nu3QKq7In6ho1lIB3mV5iG3h8VtBfT5AMduy0tHSePmsrYsVKCQi+6jImklj
 ET48RGjqUPKsd4jCp0BgsD3/mCgVseuvDEEN86mLp+1+GPuiUKN1OLHXTdc6uehFFw1v
 o8ZzqUU/ztcR8pGZ/9VepoH3IqVb4XZQiuAlc6SfLZW4OUtSB8dWr1/JUAedqQngUtS1
 aXrwqMqOwDSqq9zRyLPJUwUQ7HT08GnJsLUH9CZrerXiNGSjHmrO6oqihd+CteujWsfz
 SEcGyk2UUVYYi5Zs1t2J8DRKPAT+Gc8i092KYMefU6EGI8PL7FEVPAfC3+28sTSHNQdB
 CTHQ==
X-Gm-Message-State: AOJu0YzbZCed33WIsdDhWDO+FOiKBQmL3EDwUvRAr9aWNCwdLIx1Vi7x
 yuioqyxSS13da9epPCBFmozHY5a5PrZqlDFTFuErky1UH1PeXnMSKSQM8BifLsI=
X-Google-Smtp-Source: AGHT+IG3tBHHwpGN1je7eTwIfx/f3MMKYlkQV6UjozXA7sz4S+/svR/wBYFQ2ClJ6C+/Yz2lbVVY5g==
X-Received: by 2002:adf:fe0b:0:b0:33e:c9e:991 with SMTP id
 n11-20020adffe0b000000b0033e0c9e0991mr6763856wrr.6.1709574308744; 
 Mon, 04 Mar 2024 09:45:08 -0800 (PST)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 j16-20020a5d6190000000b0033e0019b814sm12706356wru.34.2024.03.04.09.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:45:07 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/6] cmd: optee_rpmb: close tee session
Date: Mon,  4 Mar 2024 18:44:51 +0100
Message-Id: <20240304174454.1484507-4-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
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

