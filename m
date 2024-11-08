Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B55D5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD9B891D7;
	Fri,  8 Nov 2024 14:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eCOgl3Ob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFA188DFA; Fri,  8 Nov 2024 04:45:11 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9CB88B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-718119fc061so1054076a34.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037507; x=1731642307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/hDsCvgHBO7FxVodrwe4ZzkTd763fpMh5T2pvdGFDvk=;
 b=eCOgl3Ob2UMbEJHt4YVzfnVJ4om99NIGB5xlOb4ios+mHcHQiTS1BOw67ShOG5D5Vj
 EH2AmsQ7opJS/WkFILss/7PwbOGDbLNLJSFzuTM0C03gnL1z644zt6wT0WB5l7IlxQZo
 p8RlCtWYYDSU3i0q1LoGTaD+QOxBaY3l6q2Pkj138Ez/QDNOUvZDDNUN2NCkTVOuV2ys
 Rzvb2Ha8yesUaux8h43Op3/PB90d1v3dUzPHY0FtVrgQXUXRuw6fWwL54KHt9Wk5GHck
 7+213/ubwSgKThFUnjBUGxwbbyJXl/Q+T/lX3S7/higkVSTk/na1g8Wg+dPKL8fEZKaE
 UVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037507; x=1731642307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hDsCvgHBO7FxVodrwe4ZzkTd763fpMh5T2pvdGFDvk=;
 b=AjLBQmYTtOJb7N35q6CXDC+NGNn2WPIC3UP5GipqrhCpyNo974aMG5AuIh5/hBd03h
 D3vnzvysSwDcmVrupnnBNVlh5uJRNodhXd3KhrJ6d4l27/DWZNGetYqruwV05oxEGzYe
 yMGnFeTr7Iq9EcCnhP/1+Baw7kYHmV5fQWG/N5/9k2ecLuE8a29UlzwZKT4Igq7H01ua
 TXujvT9UYxjeoFxecHE0IzuiVjdVlE92NysVTWXTPqgiRWldQB2Evi/ada6viX0ORCIm
 nrtYVTSazZ2SFGjxmi0ef6iJmZZMLnAvMF4AJ+hdUZZnM6QGw7CxdK5+ADnrq6h2p1F8
 CWHQ==
X-Gm-Message-State: AOJu0YwjNklOffSrLvxP+7HYciZzgQ929I1f6OrQZpiJAoRwQhhbfT8F
 sTHJyoPbOemGPJ1piBs8V1mU8Jz9vMttcbNQrYxrFZd9biit26hJj9dw3XRVONw=
X-Google-Smtp-Source: AGHT+IE/S6BfPQix1nkmF6dCQ/VoMASFMxghCRFX3FW2e2TxLamcARByO1h5Nh311nAcAKJHYR8TnA==
X-Received: by 2002:a05:6870:440c:b0:25d:8d4:68ab with SMTP id
 586e51a60fabf-29560335530mr1365755fac.40.1731037507443; 
 Thu, 07 Nov 2024 19:45:07 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f5c9af3sm2346021a12.31.2024.11.07.19.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:45:07 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 02/15] net: wget: let wget_with_dns work with dns disabled
Date: Fri,  8 Nov 2024 00:45:01 -0300
Message-ID: <20241108034501.346196-1-adrianox@gmail.com>
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

