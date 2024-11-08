Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F607D5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C94C89083;
	Fri,  8 Nov 2024 14:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aOaeFtjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69F988B8F; Fri,  8 Nov 2024 04:35:07 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E9E88D5A
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20caccadbeeso18100275ad.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731036904; x=1731641704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/hDsCvgHBO7FxVodrwe4ZzkTd763fpMh5T2pvdGFDvk=;
 b=aOaeFtjjMY0Xhz7aTBFH+rAXRJDcznpi1ItZAIwhs7nmauvYymJ5lzhBTbY5OpY7Ic
 pm64QvgAyyD3/BLYI1s2rnH2i+y98cx3wv3kcyGxb45lgaL8+/tyArc5TqhWB2hVQZXj
 ENgKr4bavFH2G8TfNSh0UDth/Vo5RW3obRDQybYmdpc1q9YzVRqgOZwv4UTnWgi/8bo+
 714x7KxfAGbD0VxeAFJQ/K44EpVtrtnr3yBNaCe42Gt8Gf5LWqJaZ8/O+JZZm9TlMnrG
 5wDBpjHM46npch3pupq9oMD5UvECG5ZbDTwJVD7QNq+yGVDxy8+Y2p+Bby/uJfWS3nlH
 R0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731036904; x=1731641704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hDsCvgHBO7FxVodrwe4ZzkTd763fpMh5T2pvdGFDvk=;
 b=TbLJt+8H3yDiJlBdm03rnU1FWk4oaepklAvmTxzFiyN7H30DgRa8oOJyoA3q3EMNit
 YYY8N1aaxFnUzqa7Njk7E1+gz283Y6oDwX8kTowppEsv+G3PA6+lF1gmd38/bv8pNtMG
 euSeUPSud3fuFBoWrRLaxoqNpsGw1cmklN6EDbjHaYbxmpl7wbz/nZ29WYidRVXW1JQ7
 6vveYGKtjUMrAa94HiGufN3xmN3P2fcW2XQ1BlS8sJVvazq1y2QgHOt+M51Z2aGcHrNz
 jT7jk9TF9m1nn8idJM9w1wjcBKgAStEnbGZ2CVkj1UPeM3013Vs5VpgL10NE1/ThBUrv
 M03A==
X-Gm-Message-State: AOJu0Yw1JJgMYYPKquND9lI4YxbXkOk2zIFTI5TLtcZeZ+AEKJlUc5S4
 DGYsonZ4JllQ6crg3Wwu9qbA8mRdi/Q061e4RqPjtAfmhn0dkCr88/I1GjSwtpc=
X-Google-Smtp-Source: AGHT+IF9lio7bybXPhm+H6nEsJ9ZclvsU0TnULh2PuyUapUUOtqrZvgxD70fNxUVJBNrfkalqjHjLw==
X-Received: by 2002:a17:902:ce03:b0:20c:ea0a:9665 with SMTP id
 d9443c01a7336-2118354efbdmr16210595ad.32.1731036903949; 
 Thu, 07 Nov 2024 19:35:03 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e62dd4sm20522955ad.218.2024.11.07.19.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:35:03 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] net: wget: let wget_with_dns work with dns disabled
Date: Fri,  8 Nov 2024 00:34:44 -0300
Message-ID: <20241108033445.345514-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

This was marked as TODO in the code:
-Enable use of wget_with_dns even if CMD_DNS is disabled if
the given uri has the ip address for the http server.
-Check for port in the uri when transforming to legacy wget
syntax inside wget_with_dns.
-Move the check for CMD_DNS inside wget_with_dns.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/wget.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 2d931c2bc6..5bb61a2b8d 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -528,12 +528,10 @@ void wget_start(void)
 	wget_send(TCP_SYN, 0, 0, 0);
 }
 
-#if (IS_ENABLED(CONFIG_CMD_DNS))
 int wget_with_dns(ulong dst_addr, char *uri)
 {
 	int ret;
-	char *s, *host_name, *file_name, *str_copy;
-
+	char *s, *host_name, *file_name, *str_copy, *port;
 	/*
 	 * Download file using wget.
 	 *
@@ -554,18 +552,31 @@ int wget_with_dns(ulong dst_addr, char *uri)
 	}
 	file_name = s;
 
-	/* TODO: If the given uri has ip address for the http server, skip dns */
-	net_dns_resolve = host_name;
-	net_dns_env_var = "httpserverip";
-	if (net_loop(DNS) < 0) {
-		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
-		ret = -EINVAL;
-		goto out;
-	}
-	s = env_get("httpserverip");
-	if (!s) {
+	port = host_name;
+	host_name = strsep(&port, ":");
+
+	if (string_to_ip(host_name).s_addr != 0) {
+		s = host_name;
+	} else {
+#if (IS_ENABLED(CONFIG_CMD_DNS))
+		net_dns_resolve = host_name;
+		net_dns_env_var = "httpserverip";
+		if (net_loop(DNS) < 0) {
+			log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
+			ret = -EINVAL;
+			goto out;
+		}
+		s = env_get("httpserverip");
+		if (!s) {
+			log_err("Error:  %s could not be resolved\n", net_dns_resolve);
+			ret = -EINVAL;
+			goto out;
+		}
+#else
+		log_err("Error: dns disabled, %s could not be resolved\n", host_name);
 		ret = -EINVAL;
 		goto out;
+#endif
 	}
 
 	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
@@ -579,7 +590,6 @@ out:
 
 	return ret < 0 ? ret : 0;
 }
-#endif
 
 /**
  * wget_validate_uri() - validate the uri for wget
-- 
2.43.0

