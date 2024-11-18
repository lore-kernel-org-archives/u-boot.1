Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB88D591B3
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B74894B5;
	Mon, 18 Nov 2024 22:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jl0olceb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743EA894B4; Mon, 18 Nov 2024 22:09:21 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC3488C10
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2960a001f01so2356347fac.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964158; x=1732568958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGdmlQcYh6bbQGY0ENMUXddwAAmmhQaS+HREEAFhcHI=;
 b=Jl0olceb7UQUJg3CLQbCgh2LvnJtI5jA+3hue5ZMN8EsnYbTwejqSZ/UGQH4hgi4Ke
 gU2B6YcwGSs4sbQiJ4fPs4J5doiECe0ZRd3b1cYF7ik8XO1JSvrZQTbqj6hmxJV2rLRb
 gn9iMO4qFjbCs+NagyZpYd0jV3onF0HbZvqNW9kiupqIp36LZEUkk1CKdYhFvEQpxDUC
 aXnkjNXT+yyCkiJBGlggqaX0OK4OVh+maCjF5cTERcEXZUE6vZSTB3SlxTCkNmsbRHOM
 WYyt5JpDOL71yVv8D8MosSRpRYMeFlAB04WwwnZXG3CT/xyhAJm/N2HdmQYDwiUtfn8f
 SSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964158; x=1732568958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sGdmlQcYh6bbQGY0ENMUXddwAAmmhQaS+HREEAFhcHI=;
 b=Iyh9mEr8yfU6Dg5LKemvBJmSNOlLsFXP+grLhA/3hA5IU6ip6f6nhGwCOJdC9DSIgE
 RRmvYPNlWiiu6QDwI1C3wavnyKHt6m9F+OJdSPcF/zbY26f+NE/jdeMSbnUAZh0Q9qLI
 OjOlH/C9iD5vFNV0thulHvDVsvxoiwEqLRPZYi/q6TLI1LBWa2lu5l6fLYaThYhiK0tv
 imQCSpBFUUiEnmnoOqDibA2qvVfazfgLlL+0FR2TBqGayDd79s33KpHB5JmHgvt+u1fi
 yIFO818tcx9TVdbVU6MIlxNEP+DJpFCdD1zXxLKa5n+LKvmKuklynafi1Aei72frhtCV
 t+SA==
X-Gm-Message-State: AOJu0Yw465bCt34ykxBNDPrGRv+7hZF47ghUaDEMU+2GUU+EfNWbWePd
 Je9l1N/e0ZFIGg0SwiHNmeAcejlD3gjyaU/hSec3YbGwC25Bc7hFdwS7IBvb
X-Google-Smtp-Source: AGHT+IEHSWM5Qoj9ThI5CxvfDehwcSI5nEHRIjvqWGMMZ2ceD9xnZaR45XoKHk/xYUxAGaeERRKnRA==
X-Received: by 2002:a05:6870:2011:b0:277:f09f:9eb7 with SMTP id
 586e51a60fabf-296aeb5d355mr592120fac.7.1731964158007; 
 Mon, 18 Nov 2024 13:09:18 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:17 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 01/14] net: wget: let wget_with_dns work with dns disabled
Date: Mon, 18 Nov 2024 18:08:55 -0300
Message-ID: <20241118210908.51196-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241118210908.51196-1-adrianox@gmail.com>
References: <20241118210908.51196-1-adrianox@gmail.com>
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

This was marked as TODO in the code:
-Enable use of wget_with_dns even if CMD_DNS is disabled if
the given uri has the ip address for the http server.
-Check for port in the uri when transforming to legacy wget
syntax inside wget_with_dns.
-Move the check for CMD_DNS inside wget_with_dns.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

v3: 
 Removed console output inside efi routine.

(no changes since v2)
 net/wget.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 3bc2522cde..1166aa5aa6 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -530,12 +530,10 @@ void wget_start(void)
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
@@ -550,24 +548,33 @@ int wget_with_dns(ulong dst_addr, char *uri)
 	s = str_copy + strlen("http://");
 	host_name = strsep(&s, "/");
 	if (!s) {
-		log_err("Error: invalied uri, no file path\n");
 		ret = -EINVAL;
 		goto out;
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
+	if (string_to_ip(host_name).s_addr) {
+		s = host_name;
+	} else {
+#if IS_ENABLED(CONFIG_CMD_DNS)
+		net_dns_resolve = host_name;
+		net_dns_env_var = "httpserverip";
+		if (net_loop(DNS) < 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+		s = env_get("httpserverip");
+		if (!s) {
+			ret = -EINVAL;
+			goto out;
+		}
+#else
 		ret = -EINVAL;
 		goto out;
+#endif
 	}
 
 	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
@@ -581,7 +588,6 @@ out:
 
 	return ret < 0 ? ret : 0;
 }
-#endif
 
 /**
  * wget_validate_uri() - validate the uri for wget
-- 
2.43.0

