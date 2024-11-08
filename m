Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A80ED5C0C2
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A5B8921A;
	Fri,  8 Nov 2024 14:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gt2oq4Li";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530E988DB6; Fri,  8 Nov 2024 04:46:40 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29A2E88B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e607556c83so1142945b6e.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037597; x=1731642397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9UYti8F/bM2i9AOYlcSUsokOWSDRnisGipRST7lrwHs=;
 b=gt2oq4LiSyvxD+Ak3J7t7AHA7HNDbgcpEphzwmccEBvZN8t9X3t4TvfQnc1RnjOO6c
 SbMNvHAJv/k5z6RaR6PnS/S/fXmpnymjOOMpMtdZOH7x5lrTnboKCq9P7srlMdWHJghV
 536WbfvEUVZvTRlEgCU9DnO0wz1Ct4ls3kCWMjiIGD/ZX18CsKUQqtNfv/tm6skehKbH
 DU4i1Q7rSc1DeEscF+39Es7zx5eZ7VwWuPnKMgoIfJ1oI4lS6nTxo5ZhXLcVlUCkfV6g
 13pZpFfmnfsL9PrITWAOCLx/lKaoGY8LeN0xq2YI81yBHvWVqMfQPGLpcpTAUa7ZVHTK
 HR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037597; x=1731642397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9UYti8F/bM2i9AOYlcSUsokOWSDRnisGipRST7lrwHs=;
 b=MgRelrppvbkmCgGsG3Vs6tOjlAXcfiN9nrTV3IERr3lgiNsWV6+vtOtIaFwNW9C03Q
 tUoZNW1PTfMX2JtM4Sg96FzQgyzGrn9DZHAemai6semABt0+F1GeUKJk1dTc2/fQo5xa
 ETNwLHU71KRVunvp0wuitly6JuiIg8E+shx31MArK/N6PO/7UhAn3SqEMPhJSvDJ0CqW
 8Dg1N48jkKDpa2yEISBc7TEXuKYUsF+xx/sT89vztR5SN34aB4n8c9pyrWsrZG7v5wRz
 92JQAq/jy0yWilpS4C7Rl6FRKJc09KpvTbOac47mpfx4zKYfmp2J7uYqHPtiasHp0sj8
 qcjA==
X-Gm-Message-State: AOJu0YwBe1S06Dcp2erywyRaUMu/jtacaijVE0X4FJ5ckJI2fyFmqCBN
 RxFsqBNd5PkKytHporBgnSMn1eHMim4Ig6h30O2s2adhQuPvfsbUtPONzqphLas=
X-Google-Smtp-Source: AGHT+IG8lpItIc3vVph2YaAsy3JKLXg0dZKmtPVRxrjfYQyd+l2z3bOtHeMwWKSE6O1B1LkXzgzegA==
X-Received: by 2002:a05:6808:228e:b0:3e6:3b52:df16 with SMTP id
 5614622812f47-3e79470a201mr2032640b6e.34.1731037596839; 
 Thu, 07 Nov 2024 19:46:36 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f644db5sm2349049a12.55.2024.11.07.19.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:46:36 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 07/15] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
Date: Fri,  8 Nov 2024 00:46:31 -0300
Message-ID: <20241108034631.346350-1-adrianox@gmail.com>
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

