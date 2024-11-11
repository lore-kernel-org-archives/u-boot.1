Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C1BD41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766A3893D8;
	Tue, 12 Nov 2024 03:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DXqAC8f9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC5989393; Mon, 11 Nov 2024 22:10:12 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC4E589395
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20c693b68f5so50746285ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359409; x=1731964209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIAhI862F6cSXwGSndJPmyLuk/kADiMHMjCeShrsIPU=;
 b=DXqAC8f9JdUqPJ4Sy2KxUR+/DRjLk2KGO58w9XbULrb5FZknSKTkIx7CEnIXMhv22c
 ktINPYrA3rH9W9Dzd9NDvOACy/Us/btnZLNamOdSnIMFVU1Rupm+BfOs0YYp07psXeXg
 4QOuY3grmMaaQCR2asvbnhFqhxlxiBVnC/rP36O0+3c9Ce5Gl0ssaOHfvD0sIWIA4+3o
 dAe0ytXTKdUj+DPQopVG9HcjDfQ1XgMoBk2fc5UGgkuRXbvtMHRr4Q+grbE+TRF7VOzd
 KQ6TKR+NOitil24+kvGRYQVLokEdXfRqZQRjhnRMci/f6g5+LAbxsFuzs/SFF1qsqpw3
 e8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359409; x=1731964209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIAhI862F6cSXwGSndJPmyLuk/kADiMHMjCeShrsIPU=;
 b=aY6csVpf9KprWK9DGPjawtRz8bL1mZ36wTBytWmwWtOak63Sx5F/tT2QuGLrOgNK2K
 3j8SoywGX8sxUOVh3yKXEIocdtTd0eX29+z6VOERN2M5mh6K0+9big5wbwore7AiXp9I
 hWB8u3GhRPMnglpxviBDFVfG7bH+XKVmdONlOrDfg+1tkQCX4xkiE8rLtKJb2zQtYQWH
 lA4AcB+OlJ3VnbacRYv2ZHy/RZBRH7RNwwUtTZSRp1AbD8re7GFgIVOqKg3ULJpwjTaY
 U30gRlctllwpUhPuMQjA06G4wi7PCcnqYk2WCIPO0hOajBR14O6jAtsORINTJEz8T7cl
 LhXA==
X-Gm-Message-State: AOJu0Yy8EyMgVwlxa+O4RmgnGoKaLjnxD2fS9YMNYZ9rekOvXh3224SU
 d/od04mvNmabrc1RjlpV+vZJ1ljXgFK0053bzV8Zv3asnFMeeY8F4NzyO+59
X-Google-Smtp-Source: AGHT+IGBbidb7YzUQJxwOt/RpkKFXLYKUEX8pNpTttXUzszDDX8UoBoAgR6/pL8CAAtIAm0Bj6Lchw==
X-Received: by 2002:a17:903:1d1:b0:20c:f261:2516 with SMTP id
 d9443c01a7336-211834f3842mr195559005ad.8.1731359409238; 
 Mon, 11 Nov 2024 13:10:09 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:08 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 02/15] net: wget: let wget_with_dns work with dns disabled
Date: Mon, 11 Nov 2024 18:09:46 -0300
Message-ID: <20241111210959.560738-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210959.560738-1-adrianox@gmail.com>
References: <20241111210959.560738-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

(no changes since v2)

 net/wget.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 3bc2522cde..36158e0a9c 100644
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
@@ -556,18 +554,31 @@ int wget_with_dns(ulong dst_addr, char *uri)
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
@@ -581,7 +592,6 @@ out:
 
 	return ret < 0 ? ret : 0;
 }
-#endif
 
 /**
  * wget_validate_uri() - validate the uri for wget
-- 
2.43.0

