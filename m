Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60746EE8004
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C807886AC6;
	Fri,  8 Sep 2023 15:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q416S07D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA3486ABC; Fri,  8 Sep 2023 15:56:13 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E601286ACC
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2bcc331f942so25289921fa.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181370; x=1694786170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHXWqgTf/sMFZxv9oq24wQUKGoOCwB4OY4AAJ/pkjjE=;
 b=Q416S07Duidun2Jo2psxBsuHWBrpWy3AYMWuzWYJ7G2wvnNyJ1nyO8dMRoJhc7G7yv
 Od43vkVsU7wlapgLJ6419GHSDZ6/GUGPp4mN94uc/RsywbgTQhWQ8QKBJtDoUXOQzotT
 Z52GV1OujGBd6oM7AtgPNXNn4OZc1OWIXveFczUmlGeY5j9NnEVbaWzdZu9N3Jgjmnhk
 FRRExAaAS/02kRfnVEKPKdcxDnQl4BTWgTSu2pI5RcIkF7BlhU4Eh5APG1wm0wztYR0C
 hRo+sKgLLJB8QqGSNcJD9q7dU2C57DxD38yEK9cZ3o95tAFBaejL87C8mJuv9MJ6RCf6
 WfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181370; x=1694786170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHXWqgTf/sMFZxv9oq24wQUKGoOCwB4OY4AAJ/pkjjE=;
 b=Ww4uMyeSb7qEGGetz/knG5HbZJB6lXaFeP0VeO+cTdBcfLgphtIefxlx33uRSZEJJx
 DOPf6m8th5Qx7uWsxIl9bEN9/0YTreu8xdGmDwch0gjcul06zgZkQdY/cg8dkorTOt/n
 Np1rsYpd9fqTsS7jsUoBIYHbEoKbyi+qwZBmFSXUwRa/PzG0mrU1upo0CJZllj50sDIs
 vipSHYRWAD/qCu8Eme+MuYWia1CC2rIQauAnRGpHsFL0iBRFFIQOx2KN9RGYNipR9J1w
 SgkaJJapjB/6tcK7EWbbwvOnqCD/Xlk/DUqsmgg0gKWS6gP7VLKfzRHfdsVGHpfYmCQv
 H3Wg==
X-Gm-Message-State: AOJu0Yz0jocX/pswyQAWuVNHVLmgPNyEhM4yKVE8l2+F9HvfAiu5AW8g
 JgWkw+R8YlMkZqtzHrqON4Awk2QH8yj3QfBPja1xPg==
X-Google-Smtp-Source: AGHT+IELUHUeSnMpAareYksgpWGn0X7JVhAU0KZcRgNyp+plC0NY4KnaSG4Qk6iBoScFk/qzRu5z4w==
X-Received: by 2002:a2e:9c83:0:b0:2bb:c19b:710c with SMTP id
 x3-20020a2e9c83000000b002bbc19b710cmr862975lji.5.1694181370123; 
 Fri, 08 Sep 2023 06:56:10 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:56:09 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 15/15] net/lwip/wget add port selection
Date: Fri,  8 Sep 2023 19:53:20 +0600
Message-Id: <20230908135320.7066-16-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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
 net/lwip/apps/http/lwip-wget.c | 40 +++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/net/lwip.h b/include/net/lwip.h
index 1e92f9871c..6de646771e 100644
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
index 5c432056b1..7de1c962c6 100644
--- a/net/lwip/apps/http/lwip-wget.c
+++ b/net/lwip/apps/http/lwip-wget.c
@@ -63,18 +63,38 @@ static int parse_url(char *url, char *host, u16 *port)
 	p += strlen("http://");
 
 	/* parse hostname */
-	pp = strchr(p, '/');
-	if (!pp) {
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
+		if (!pp)
+			return -3;
+
+		if (pp - p >= PORT_STR_SIZE)
+			return -4;
+		memcpy(portstr, p, pp - p);
+		portstr[pp - p] = '\0';
+		*port = (u16)dectoul(portstr, NULL);
+	} else {
+		pp = strchr(p, '/');
+		if (!pp)
+			return -5;
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

