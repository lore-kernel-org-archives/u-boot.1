Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E829C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A513E82B81;
	Fri,  6 Jun 2025 08:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dFK50LU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6FD82B33; Fri,  6 Jun 2025 08:42:33 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4982082B0F
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so1029004f8f.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192150; x=1749796950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ub47U3EQPiKvxy0dJsIaomYQRoXBFHjiWzQis+R7uQY=;
 b=dFK50LU1cn58ClUNuZsICU34QmHgM3yIHbUxOZjh28RlVoiCPPXVyZxCJ7JUP1zAc8
 cjr5qFXDn4tpPfbc7AhveBbrZY7W6kX+YfJGSqudLbFJKa3mgORDxeJkCFvqM5+q3EzT
 QAo2hQq/MLbCENzvDZs8J9jVXjzT4h3H8VXZasNUzhr2KQM+Sh4iAIfXeWP3HHHolcmR
 pbxUvavoXnRGv6XfuQtxx7X2skbVUwDVhl54n88TfTMQihVLN7aEj0f/gWjfd/lb1p6l
 OaMN5nj0AVaYct8kdhwgdS6QQ3s27HxbmXw7/RpF8QaftEmT8NAr/sfhqDzjhYp4pq6z
 6oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192150; x=1749796950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ub47U3EQPiKvxy0dJsIaomYQRoXBFHjiWzQis+R7uQY=;
 b=eUnGGXqmVXNBgVpBRnNH6p+0X5ve1ZxcjLR1NtmD3k5OkjxfNJ00EAYTxxKqHn3Sf3
 vXISJx4KpJjPUWl/WSLx2QqUoQLU1x6xHPg3j7N3VLqWfapOMBd+Dys4nOCYPKLjd4sS
 U1bYzn7ZijvDUIVqcNkBF5e+gp3A/vhDxwykK4XhOH3QA64R0NtxEAwv5l7cgqQaHFm7
 oMAW/XYcPY5BbGDNz9lTJnErAm84AF4w9wssXCwK80aNve0vspGtJKjlhslacDne0+9A
 scjsrwgPu+DhSH27XerhtCCQfum+w0JVUUiDCj8v4nGLsKcU6T2cvByzvkk7pow6PXt/
 DS8g==
X-Gm-Message-State: AOJu0YzybIM/mGdW7omKd9tV9tgmAW/dn0BprD94cHsS25cuyteQYTqw
 kusTo3APeDIE6coNtfskVEbvIwmy5btpkxMjMpq/ss/UxH6qsseSZl4+5A/QY8jXfWkVGBjEXom
 hz+QB
X-Gm-Gg: ASbGnculS3r4DX8UHz6HH1dv86nG24wA34uKWtvaLj6sd0F4CxmsQFExeFHPC0GmEOh
 WEMX7Jz27VxIZGPAMQLOqLYTOJXQ6V98/U22Iwn5KIjbiPYUcL18gO3k5+WXrCPPV3HuMv4eVL0
 XxZMSwhvRasoRdr+xqLaC7ZTNUoixBjDF2fwh0JdFO+z3a7Ir1vqaNJSYcRxk5a5s1JREe9IfFD
 uGfrLjOGaek39Oz0wW0m9dIz6iFdB+XEBfyiBGCkldaNEfZ3XRrUR3NTtui/cdKcJ3mHhtX8F0L
 8xWzitOJa0mNbYXZA9Hn7E3iVw+Jf3QwrH1RfMaSDFXVMIAFzB8ZtZSgnWNRhVFgc+UKJvw=
X-Google-Smtp-Source: AGHT+IEF8oIgVavlbihFfT3XhNKVWtIpFYYTHWKwBUWZ2h+DgvYK/NPKltdN7oDnPK/cFUiT83p+RQ==
X-Received: by 2002:a05:6000:2584:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a531885518mr1688915f8f.24.1749192150493; 
 Thu, 05 Jun 2025 23:42:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/13] lwip: add net_lwip_dns_resolve()
Date: Fri,  6 Jun 2025 08:41:44 +0200
Message-ID: <20250606064211.3091237-9-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

Add a helper fonction to convert an IP address (supplied as a text
string) or a host name to an ip_addr_t.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v2:
- New patch

 include/net-lwip.h  |  1 +
 net/lwip/net-lwip.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index cf3cf513b2b..4240aa4b0b2 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -36,6 +36,7 @@ struct netif *net_lwip_new_netif_noip(struct udevice *udev);
 void net_lwip_remove_netif(struct netif *netif);
 struct netif *net_lwip_get_netif(void);
 int net_lwip_rx(struct udevice *udev, struct netif *netif);
+int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
 
 /**
  * wget_validate_uri() - varidate the uri
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index f05c4cd3f64..c9a7114bbff 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -6,6 +6,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <hexdump.h>
+#include <linux/kernel.h>
 #include <lwip/ip4_addr.h>
 #include <lwip/err.h>
 #include <lwip/netif.h>
@@ -315,6 +316,44 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
 	return len;
 }
 
+/**
+ * net_lwip_dns_resolve() - find IP address from name or IP
+ *
+ * @name_or_ip: host name or IP address
+ * @ip: output IP address
+ *
+ * Return value: 0 on success, -1 on failure.
+ */
+int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip)
+{
+#if defined(CONFIG_CMD_DNS)
+	char *var = "_dnsres";
+	char *argv[] = { "dns", name_or_ip, var, NULL };
+	int argc = ARRAY_SIZE(argv) - 1;
+#endif
+
+	if (ipaddr_aton(name_or_ip, ip))
+		return 0;
+
+#if defined(CONFIG_CMD_DNS)
+	if (do_dns(NULL, 0, argc, argv) != CMD_RET_SUCCESS)
+		return -1;
+
+	name_or_ip = env_get(var);
+	if (!name_or_ip)
+		return -1;
+
+	if (!ipaddr_aton(name_or_ip, ip))
+		return -1;
+
+	env_set(var, NULL);
+
+	return 0;
+#else
+	return -1;
+#endif
+}
+
 void net_process_received_packet(uchar *in_packet, int len)
 {
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
-- 
2.43.0

