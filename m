Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496DAD5C0F5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D99891E9;
	Fri,  8 Nov 2024 16:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I0t+qFJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CEC88DF5; Fri,  8 Nov 2024 14:39:57 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BE588E81
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20cceb8d8b4so14617155ad.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073193; x=1731677993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Da/ty0MoRcZdtECQ3eJPi04Qj8kGIZjpNkf5V5IEP9g=;
 b=I0t+qFJ9gUc7soytSbyle1eCxSQzBJYeYPv5EZFcr4O1yzduoe7olHAkFO3TmEmPLI
 yDWyL78Cx9idEJG9P6UsHRAfk6gsXiwoZxQIbKbGGHJOqSikj8MiclMM/ml1Pgo6T8lK
 j8N+TEXK3NczKI6neGo4NcXr3xOU5tybUMriXRo+Mvt6+fNkUFjYd3kbcHAO8c0Wup5t
 bschVKu5r5MC6HY+d+4Dqwyidg3I37kEDLbPZ1euhysR6Y0hrpQlV9WkFtjT90VjYQee
 RZJkuaZEQ67RaUL7f0dokbfGRnnPrp6VDcvjvFAxhXN5fcQ5VOkPk8UHi3Yzhc5pM+Ry
 ZmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073193; x=1731677993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Da/ty0MoRcZdtECQ3eJPi04Qj8kGIZjpNkf5V5IEP9g=;
 b=GDo/a8dkC07v6bpZu+RSxtsApeVs1963+55nVsJerx+KP7IP4RxYIf7t/e5BOtxMeo
 Zv9kzJheJsIUKAFR/lWc+yRtp0vK9mZIzCvUYE/87M8KPcXjOIMI/kFplX+WTumZT3fW
 L2lbO2xWc6r5B1mkt5379hq/uNVKTs8wJqECD0+vyNONtqjr5C+QPF8VZoJokHiv4Ccv
 BlXCKU68Azio8hP8G8oLvTGvNAPiN36st/R7pwCui1cSOM6PoWOz9tuKaK+lNUc8X1F7
 a456YJhnOPzWgkXGznZKJ0Qh6DiMTWL7dXYYzbGMp/IfWB+scOoJPefs6wtIlC04K7gu
 N4pw==
X-Gm-Message-State: AOJu0YxU3/SbInJ6yYgmBghK55O4OHdL4xqqRByBbY7kq8mPq5G/swU6
 CcR7+i1xAWCcsribD5pHD+7M26196HZlySrIKVN7f0RvR09i1AwPV/hpB4bRZ+U=
X-Google-Smtp-Source: AGHT+IF9gG+poVJXpnbluRVWUWPDgKeNpmbmGScBw2i1ODvBWhsfuc2HFRFQwkCdHCoCbJcgo67UNw==
X-Received: by 2002:a17:902:f691:b0:211:3295:ec7b with SMTP id
 d9443c01a7336-2118208a76cmr55551265ad.0.1731073193527; 
 Fri, 08 Nov 2024 05:39:53 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:39:53 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 02/15] net: wget: let wget_with_dns work with dns disabled
Date: Fri,  8 Nov 2024 10:38:37 -0300
Message-ID: <20241108133850.431075-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108133850.431075-1-adrianox@gmail.com>
References: <20241108133850.431075-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:56:12 +0100
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
index 2d931c2bc6..1b6f031b72 100644
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
+#if IS_ENABLED(CONFIG_CMD_DNS)
+		net_dns_resolve = host_name;
+		net_dns_env_var = "httpserverip";
+		if (net_loop(DNS) < 0) {
+			log_err("DNS lookup of %s failed, check setup\n", net_dns_resolve);
+			ret = -EINVAL;
+			goto out;
+		}
+		s = env_get("httpserverip");
+		if (!s) {
+			log_err("DNS could not resolve %s\n", net_dns_resolve);
+			ret = -EINVAL;
+			goto out;
+		}
+#else
+		log_err("DNS disabled, %s could not be resolved\n", host_name);
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

