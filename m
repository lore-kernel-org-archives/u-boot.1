Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B6FD5C0F5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A48EB89282;
	Fri,  8 Nov 2024 16:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IOx6cwxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12BF588D47; Fri,  8 Nov 2024 14:40:09 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7BC58904E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso20724255ad.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073205; x=1731678005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UYti8F/bM2i9AOYlcSUsokOWSDRnisGipRST7lrwHs=;
 b=IOx6cwxiX0CnJwBNQgJRjddWcTBrICD6fj59jQSEpR8fm9tngkYypipG1IQ53jrS5F
 Uvm47wZEfP0y+APsDUKwHbmxbG6bKSYNRtylpYzeVspNwxFoQ/JXhl7//Wc87vRyO+k2
 Al/r8eJxjlavVL+q/MCQI7tiGyFKEL57RsXUr/CUp4Mei+zrX9lVgTbJ8c+l7FECyJZP
 XGXoEDXU3C7i6j+7WWAKzd8SLvjRwZOFwdxgl4c3Vr75MZ0++83C68xQbQiCuXP/M12M
 yeP579ftJtNIj5//xUgdEOVbI/BNXyoFmKFv2k7f05aMBMNkAwoU005kK7Ap/mprqU6S
 02Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073205; x=1731678005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UYti8F/bM2i9AOYlcSUsokOWSDRnisGipRST7lrwHs=;
 b=K0y4WhtFj/xKLO+PMoSZcN9HsAhDx9cuh5aeA0oWd2yWvQx9SY8nJ+TSqr/8AOldVf
 ktF9sZ1xBLlyy/AuwzpCGjcH+D0UyCvR7G5byi9MzZSbxZ0WvuUaB/cEiyGxR+FYkHb/
 r+h6iNW5a117V0ttV1cuUL0vFrbuX8/aM2yiarGB+LF+n5/pWU1jdk0jxYrCTcI4fwoi
 olIYP3bmDQ0ZMVu6ZNf9WKEm8dmSxLhc4aVff3w04mPIR+jmtchXa6YLEYZ18srh/0yR
 m8G5bqXzA/XYKWr4tgwjABxzcdrV3mB8Qx7mGPXLY+vRbHXkcKp38olktxeaNn/jC1OI
 rIkw==
X-Gm-Message-State: AOJu0YxfN/2UcDriyb5MwWO8ZVXeg7xuleoBJkwfAcmANKHfBEfSyhFB
 D2kHeHNiHNPdyuRSxRwJqJSrzXv70yButhOpJZt8alcPqY/fZxFrm6zHJAIdPE8=
X-Google-Smtp-Source: AGHT+IEYajXPF8iDt9Vg77AgmMUXGnI3pZl9hHDnF+8Lj1G6KodTC2xqkPdcrNMVr0XlFxtPbJtBGQ==
X-Received: by 2002:a17:902:ce92:b0:20c:f648:e3a7 with SMTP id
 d9443c01a7336-21183e40826mr35055325ad.50.1731073205202; 
 Fri, 08 Nov 2024 05:40:05 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:40:04 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 07/15] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
Date: Fri,  8 Nov 2024 10:38:42 -0300
Message-ID: <20241108133850.431075-8-adrianox@gmail.com>
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

Add the functions efi_net_set_addr and  efi_net_get_addr to set
and get the ip address from efi code in a network agnostic way.
This could also go in net_common, or be compiled conditionally
for each network stack.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/efi_loader.h     |  16 +++++++
 lib/efi_loader/efi_net.c | 100 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 291eca5c07..44d29e7967 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -125,6 +125,22 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
 				   size_t buffer_size) { }
 #endif
 
+#if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
+void efi_net_get_addr(struct efi_ipv4_address *ip,
+		      struct efi_ipv4_address *mask,
+		      struct efi_ipv4_address *gw);
+void efi_net_set_addr(struct efi_ipv4_address *ip,
+		      struct efi_ipv4_address *mask,
+		      struct efi_ipv4_address *gw);
+#else
+static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
+				     struct efi_ipv4_address *mask,
+				     struct efi_ipv4_address *gw) { }
+static inline void efi_net_set_addr(struct efi_ipv4_address *ip,
+				     struct efi_ipv4_address *mask,
+				     struct efi_ipv4_address *gw) { }
+#endif
+
 /* Maximum number of configuration tables */
 #define EFI_MAX_CONFIGURATION_TABLES 16
 
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 7cd536705f..dd84b3f18d 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -17,6 +17,7 @@
 
 #include <efi_loader.h>
 #include <malloc.h>
+#include <vsprintf.h>
 #include <net.h>
 
 static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
@@ -997,3 +998,102 @@ out_of_resources:
 	printf("ERROR: Out of memory\n");
 	return EFI_OUT_OF_RESOURCES;
 }
+
+void efi_net_get_addr(struct efi_ipv4_address *ip,
+		      struct efi_ipv4_address *mask,
+		      struct efi_ipv4_address *gw)
+{
+#ifdef CONFIG_NET_LWIP
+	char *ipstr = "ipaddr\0\0";
+	char *maskstr = "netmask\0\0";
+	char *gwstr = "gatewayip\0\0";
+	int idx;
+	struct in_addr tmp;
+	char *env;
+
+	idx = dev_seq(eth_get_dev());
+
+	if (idx < 0 || idx > 99) {
+		log_err("unexpected idx %d\n", idx);
+		return;
+	}
+
+	if (idx) {
+		sprintf(ipstr, "ipaddr%d", idx);
+		sprintf(maskstr, "netmask%d", idx);
+		sprintf(gwstr, "gatewayip%d", idx);
+	}
+
+	env = env_get(ipstr);
+	if (env && ip) {
+		tmp = string_to_ip(env);
+		memcpy((void *)ip, (void *)&tmp, 4);
+	}
+
+	env = env_get(maskstr);
+	if (env && mask) {
+		tmp = string_to_ip(env);
+		memcpy((void *)mask, (void *)&tmp, 4);
+	}
+	env = env_get(gwstr);
+	if (env && gw) {
+		tmp = string_to_ip(env);
+		memcpy((void *)gw, (void *)&tmp, 4);
+	}
+#else
+	if (ip)
+		memcpy((void *)ip, (void *)&net_ip, 4);
+	if (mask)
+		memcpy((void *)mask, (void *)&net_netmask, 4);
+#endif
+}
+
+void efi_net_set_addr(struct efi_ipv4_address *ip,
+		      struct efi_ipv4_address *mask,
+		      struct efi_ipv4_address *gw)
+{
+#ifdef CONFIG_NET_LWIP
+	char *ipstr = "ipaddr\0\0";
+	char *maskstr = "netmask\0\0";
+	char *gwstr = "gatewayip\0\0";
+	int idx;
+	struct in_addr *addr;
+	char tmp[46];
+
+	idx = dev_seq(eth_get_dev());
+
+	if (idx < 0 || idx > 99) {
+		log_err("unexpected idx %d\n", idx);
+		return;
+	}
+
+	if (idx) {
+		sprintf(ipstr, "ipaddr%d", idx);
+		sprintf(maskstr, "netmask%d", idx);
+		sprintf(gwstr, "gatewayip%d", idx);
+	}
+
+	if (ip) {
+		addr = (struct in_addr *)ip;
+		ip_to_string(*addr, tmp);
+		env_set(ipstr, tmp);
+	}
+
+	if (mask) {
+		addr = (struct in_addr *)mask;
+		ip_to_string(*addr, tmp);
+		env_set(maskstr, tmp);
+	}
+
+	if (gw) {
+		addr = (struct in_addr *)gw;
+		ip_to_string(*addr, tmp);
+		env_set(gwstr, tmp);
+	}
+#else
+	if (ip)
+		memcpy((void *)&net_ip, (void *)ip, 4);
+	if (mask)
+		memcpy((void *)&net_netmask, (void *)mask, 4);
+#endif
+}
-- 
2.43.0

