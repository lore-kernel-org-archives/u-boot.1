Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9140EE49A8
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8CE864C9;
	Tue, 22 Aug 2023 11:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ft1egoKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C302C86484; Tue, 22 Aug 2023 11:39:00 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3206F864C2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2bcb0b973a5so40105071fa.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697137; x=1693301937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyVVhq97bTFV5m7BUfxOEu9H57jzS8dXbBxMhu+QAU0=;
 b=ft1egoKLQ05pYHtPt/hysUUaUvsITAfHIFKxACJcnAug+4edw7wMy2O09O46DecDW8
 X5PpyoeJX9SsHO7LkMprEVoQ1K6uhAqwbkJuMy7v4u8ijeZ33ROoft2X+BReD98ojJHH
 kk7E7XOueQDLiIl0h8PILbdsa0uGD4W1+g6DWN7oro550/uXsGiXu33Djiu8A0ZI2egK
 KdP8i1KZAoKTFYmbmt1dTp6GTr04woH+8qjHYcMDp0ezPXpB8sFPa6Jn14I7HWW8x+aE
 KWSc2l8nv6vsnHDISp0iGljblyIwX2Ln1eJgq6HVY0HZGB7ArentM05ba+lDa2SH0Bmj
 nj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697137; x=1693301937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyVVhq97bTFV5m7BUfxOEu9H57jzS8dXbBxMhu+QAU0=;
 b=JWXI4S2ce+Ae8GFH/1X9Tsg6IB4VXXcx3+h+cWGF56AaoWg4Xl5RpTn24rtXcjg4GP
 qmz6w0DBpaDk1EnJORGiYy+KYoO5jqQ2MYQfs2npXFRFvu/CC5/dRm+uoEHBlQOfVCbI
 qFC8Amwx3SWkApHqoPIZe2HEaiJy2K4+OjRxrBYc4T4Dm/ngO04srDjJ7fTGjDQl+YCC
 iTQukcHlqbyinmqqfYvmKMijCT/d8+eH5j07XtQHfCmIuBKgzOfsP946JYl9RU1hvXPc
 jjxWTLcW+06Htg4duYqtY/+V802cfRYsW9Sl6JIw72t2vlEMKrcjRSDEGIxFfP7JHIt6
 QMWg==
X-Gm-Message-State: AOJu0YygKA4aBX1hUQzQF/CpYcylVOUaGaXp5i6ZLCWBSePR3/1e0bz8
 bk5UEcR/IX1hJLw7jxmAYtJFHYMxj4ddL1doTT0X6Q==
X-Google-Smtp-Source: AGHT+IHN4c44SdBo5ga5cDJVM42sBo068EEKg7vGAUqDvWNq543t2NZg+DCtj0Qoq5ru4el2RS/aug==
X-Received: by 2002:a2e:8059:0:b0:2b6:ed80:15d1 with SMTP id
 p25-20020a2e8059000000b002b6ed8015d1mr6595090ljg.24.1692697137425; 
 Tue, 22 Aug 2023 02:38:57 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:57 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 15/15] net/lwip/wget add port selection
Date: Tue, 22 Aug 2023 15:36:14 +0600
Message-Id: <20230822093614.4717-16-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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

Allow to specify HTTP port instead of just using default for wget command.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             |  2 +-
 net/lwip/apps/http/lwip-wget.c | 45 +++++++++++++++++++++++++---------
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/include/net/lwip.h b/include/net/lwip.h
index aa82d71715..c66551a14c 100644
--- a/include/net/lwip.h
+++ b/include/net/lwip.h
@@ -54,7 +54,7 @@ int ulwip_tftp(ulong addr, const char *filename);
  *
  *
  * @addr:  start address to download result
- * @url:   url in format http://host/url
+ * @url:   url in format http://host[:port]/url
  * Returns: 0 for success, !0 if error
 */
 int ulwip_wget(ulong addr, char *url);
diff --git a/net/lwip/apps/http/lwip-wget.c b/net/lwip/apps/http/lwip-wget.c
index a9bb29e156..01aa146b13 100644
--- a/net/lwip/apps/http/lwip-wget.c
+++ b/net/lwip/apps/http/lwip-wget.c
@@ -65,19 +65,42 @@ static int parse_url(char *url, char *host, u16 *port)
 	p += strlen("http://");
 
 	/* parse hostname */
-	pp = strchr(p, '/');
-	if (!pp) {
-		printf("wrong url\n");
-		return -2;
+	pp = strchr(p, ':');
+	if (pp) {
+#define PORT_STR_SIZE 5
+		char portstr[PORT_STR_SIZE];
+
+		if (pp - p >= SERVER_NAME_SIZE)
+			return -2;
+		memcpy(host, p, pp - p);
+		host[pp - p + 1] = '\0';
+
+		p = pp + 1;
+		pp = strchr(p, '/');
+		if (!pp) {
+			printf("wrong url\n");
+			return -3;
+		}
+
+		if (pp - p >= PORT_STR_SIZE)
+                        return -4;
+		memcpy(portstr, p, pp - p);
+		portstr[pp - p] = '\0';
+		*port = (u16)dectoul(portstr, NULL);
+	} else {
+		pp = strchr(p, '/');
+		if (!pp) {
+			printf("wrong url\n");
+			return -5;
+		}
+
+		if (pp - p >= SERVER_NAME_SIZE)
+			return -6;
+		memcpy(host, p, pp - p);
+		host[pp - p + 1] = '\0';
+		*port = HTTP_PORT_DEFAULT;
 	}
 
-	if (pp - p >= SERVER_NAME_SIZE)
-		return -3;
-
-	memcpy(host, p, pp - p);
-	host[pp - p + 1] = '\0';
-	*port = HTTP_PORT_DEFAULT;
-
 	return 0;
 }
 
-- 
2.30.2

