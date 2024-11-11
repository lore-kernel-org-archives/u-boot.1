Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BC0D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F728893D2;
	Tue, 12 Nov 2024 03:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NrJJTgk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6DD89308; Mon, 11 Nov 2024 22:10:23 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B00B89393
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-210e5369b7dso50540075ad.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359420; x=1731964220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppGu4oViOSyUP2n883MocjPry4GKUwBDmlCEeLvj5/s=;
 b=NrJJTgk2AhVEa5F2am9Z8hXUeGs7EK2fghA4kCyfNU2KICtP6zhe8kEDIvk6vCrSj5
 qg+qHrJsuWc2VFVkRYC0l8n+9OM++RBqpSd1CJNh1OVHbLc8keJeuBG+7aMIT8mWFtjS
 M8eU2oSKzVUf4f7/v5qTydS6qGLOfeNTybdKdD2+KspCwL6fg2WBM6ItI55rre6pT9FI
 G649C4WpWLRU/154vmRovjFDiGH0oxW2M0TEnnclrKPAV/cb6m4jGbJqR7vMamr8y96y
 ufWFcz1E9XssmiUlV7eke+f2AEyKge+TIBtCHe1KPoXlcC/Prm3nfIJtCI5x74EJ0M2D
 GDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359420; x=1731964220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppGu4oViOSyUP2n883MocjPry4GKUwBDmlCEeLvj5/s=;
 b=ourI/EizzOxWG3PuMFMGLnJ3uf83fGaa7RSpO7ZNDhGiXFi4TUtCVHmndeM32MvcQK
 1eWeqYQ2h63kIvrx5jDhsMfyDPPuZyljU7vzfJZU55NQgdkIoC56ZPmudJ8G2YhEwplF
 ee581QsRoKAWzdmwKMpf/UiUMk9ED+WUuyNeRWWxitd9i5ab1s0ZusS+VttYZCmsCDTj
 MlhL6tdZH54RJyNfErOr+9KLFxR0jMguGeWkSOWR7AM+qAiqa/uq1hVHP2BTZ13hGqZA
 19HJkl02HXqTXbmqLQ3vEH4gQqVRlZs9JHiOeRkuOpb2xA+vjkLdHi/dj48XW9H4C2KH
 4Gig==
X-Gm-Message-State: AOJu0Ywh/VbRghe8/rjmQFELfxUVSzzyy8x8F9ATsAAF8ksqKRtuUWE1
 gRa27BLKkgvwjG8G9QfrpmS2F0CHN4iG1ZY3b1iL6TOrv6bxah1t2GPkLUHP
X-Google-Smtp-Source: AGHT+IFNaWaMDktieRsV/9hhAaCt3ygJHiOm3RQpH3ZJDorJvbqIcbWu+Mu0xo63xecLX+h0wsVTOg==
X-Received: by 2002:a17:902:e803:b0:20b:920e:8fd3 with SMTP id
 d9443c01a7336-21183d5532amr196265185ad.35.1731359419709; 
 Mon, 11 Nov 2024 13:10:19 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:19 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 07/15] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
Date: Mon, 11 Nov 2024 18:09:51 -0300
Message-ID: <20241111210959.560738-8-adrianox@gmail.com>
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

Add the functions efi_net_set_addr and  efi_net_get_addr to set
and get the ip address from efi code in a network agnostic way.
This could also go in net_common, or be compiled conditionally
for each network stack.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

(no changes since v2)

 include/efi_loader.h     |  16 +++++++
 lib/efi_loader/efi_net.c | 100 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 39809eac1b..612bc42816 100644
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

