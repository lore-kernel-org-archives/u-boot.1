Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88757D44D77
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C005B8920B;
	Wed,  6 Nov 2024 15:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdY/QUFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321B5891CF; Wed,  6 Nov 2024 14:04:20 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE1E88E5C
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e2e87153a3so4619954a91.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730898256; x=1731503056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F1FZy94mJYqvsulwmggbwrBJzPKrXy9n9+myRLsHZpo=;
 b=MdY/QUFvnR+mZ9hFQr4GooqluSJ6UHd2fUY2uFvsTdD0IpozdGHxmeiR9E8j0qZqAU
 B2dPvQLVlmEOUIRU/CdCfJLAKUMAZ6AoehNIFUBURctnZkbG1YDXW4K5hRkAegii0tvH
 PPnBXx4ZFA9LxH7ljGp8vdekMmFnZcOC9Muwsn4mEFG8mZATqpTuFnA7/ABhDQSFBwf5
 HFZGaMy49cWqS+0eGD96pOAg0Fj+MX30gstHAieUwrwVwCLymy9S2XSWxHOi+BDaKpP1
 yyZHoKixsPx8gQfcL9297fz8VRVePvc659fF8ASSHvVmmf+PkbGwZk2B6JLWMxVfYmKZ
 XzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898256; x=1731503056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F1FZy94mJYqvsulwmggbwrBJzPKrXy9n9+myRLsHZpo=;
 b=jzCrdPZiJs6CCPgFc2xwR4KuaZAbheT9cI3NpYQNbtD0Movlvoyb9TNCI51qSPiK3B
 q0abXZZXbktQPz9ZjjKARlHcy9uG980q0VrA/fWJFJexYqEMtmPbnnholLGuiYEfnaIy
 HAJnubzdXkfkilB9dZMyp8LvGlKWGz/PBi2fKPoX6E5lA+IQHmhZ8C3dA6u6+Sr5dps1
 CwSw1aTW/T4Tfe967Rtj3jWQp/qEwqqv/QWuswpAdNjYej32fjHYjfc7Xb16fb7OXiuF
 XsqoSbuKHniBu87CG4QXDe39GMr1+XcBRWB+4V+YirhiuD+Gym+b4dSwSC4lGI0KBwUF
 exWQ==
X-Gm-Message-State: AOJu0YyuxylUVd1rLclI4TZ5rFL6Omg2RAPRzBfBjt2lRn0ItbI0sEeD
 9gadppOxtMaND2Kaj1Hu6frg09cv/JkJViPsgHpogLT8jOA0SbxOLEA4M6hyWBA=
X-Google-Smtp-Source: AGHT+IFBECN8AtdFOUC0qCy9/HZEAgYbl78uQrmenkRdU1V/oCEhWQDyv/G7Fx8yLBuqJWOLsNxmEA==
X-Received: by 2002:a17:90b:5286:b0:2e2:cf5c:8edf with SMTP id
 98e67ed59e1d1-2e94c2abc33mr26904197a91.9.1730898256373; 
 Wed, 06 Nov 2024 05:04:16 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a62d6acsm1422783a91.53.2024.11.06.05.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:04:16 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 5/7] net: wget: make wget_with_dns return value compatible
 with its lwip version
Date: Wed,  6 Nov 2024 10:04:11 -0300
Message-ID: <20241106130411.211160-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Nov 2024 15:13:43 +0100
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

There are two wget_with_dns functions, one in the legacy network
stack and one in lwip, but the return values are not compatible.
This commit modifies the legacy version of wget_with_dns so that
the return values are compatible: 0 on success, otherwise a negative
error. This way wget_with_dns can be called in a network stack
agnostic way.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/wget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wget.c b/net/wget.c
index 24be0a4932..6cf721070b 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -576,7 +576,7 @@ int wget_with_dns(ulong dst_addr, char *uri)
 out:
 	free(str_copy);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 #endif
 
-- 
2.43.0

