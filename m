Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01298E7716C
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 03:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B108941E;
	Wed,  4 Dec 2024 04:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iiFriFL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FAA8951C; Wed,  4 Dec 2024 04:05:54 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036A688EA3
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 04:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-215810fff52so33955085ad.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 19:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733281550; x=1733886350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDN5QwjAQjghtm32npdRJ+c9rEfPLFsrTYcWBMA2tAs=;
 b=iiFriFL4SnNyvxEPUkMc0TOB7t9g1sqlMX4OiOdbOpJWe2B26kxbJhjjYrHKdR/tT3
 O1MdbG9jtcr5Rj34mnOMk42jIy6+Ek5FNGrH4vzRJvLRMxorKHxqsWZqvKLkgOouKSgg
 3wTFl1dbMZUO26xJvYKuwH6fiwCmWGohhKdmLt5fNsdZr7b+EL7mUjHMcRzrUQJNo1pM
 Q4pIAMg9htAUVSJRaf0z0WOY0gdark64JE+nVQ6Wqcb34FBQITEB18BVsUq9UukVmU9N
 gTTnjhqYriOyGV8dFTCF/RPRSm8s+AsRpTUyj7TO6tHl7WBzHQsdmTfSRavyJEoP6wSZ
 43gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733281550; x=1733886350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDN5QwjAQjghtm32npdRJ+c9rEfPLFsrTYcWBMA2tAs=;
 b=gAct+9TKMknemTL2lLbjVbXseCmjenybKjZVguPNAO4+gIxsbk46NjuRjzte2dxHcm
 oPXF2D2qnaEQ2rmKsxLPL9xLTBZzaKgAWVzpjPWUDv3gqiMPdAuc+cJZg+45u+Yt3qVS
 utIfOuhfuZzyVXrc5CrgFApRDnlwrBiECLZmnpK5pOPMs6vQ66y8zhthfnRrHddwcTy6
 b34xurrXVmGIhCKflveOfBWTICkG72EEDtlQGJxW+xeW0fclPN6IGnQHhfKLVa5YbNae
 wVUgDK5VhaR75JetIbxO6iggS3zvBtdZMvWC1eoL0S85fSOtZHYkQzX9FSSGlfGEoPra
 u0Qw==
X-Gm-Message-State: AOJu0YzX9VqW/qja0u+xg04vlBkVHnwnB4OeMssrLBkLGNXFMfoNCtja
 w4wxXiGZkkOdH41yqxqWKA+Jc/X31jVIzYfLsxnzRxg2L+RUITYYUr/QFHc3H1M=
X-Gm-Gg: ASbGncvVohpMx9uzKfsrT7Jdt2RT9Zh5wOnz004x0RVj8YEi9NjwXVVmvbc+3ZuQ4Fi
 GJyV3yTQ61+oy7/f/wfA7VNssrl39QjtTvepA3KcZxuFQLZ7yxfSmaD/BHEDpzyqM48jDtuQaBh
 aXusKsjuE7g+dYY7B6ydpAVLzWFbNLPhXQOorfN0eBNKwBxn+kZYgkvLOlrlYlllXYQrwhoYkGD
 EZoonXpKjHjTMKOCMjyQ1Elv7oF2mWXFt4cK9vi/Dk=
X-Google-Smtp-Source: AGHT+IHywNhRsUUcVISkyfNW+AgPiYGFU7SWCyDWEHWJjfhH/8DBvFGc3BeLYaaQ0D3YIJ5Y6ehN2A==
X-Received: by 2002:a17:903:2286:b0:215:b087:5d5e with SMTP id
 d9443c01a7336-215bd26a2f1mr58729395ad.47.1733281550400; 
 Tue, 03 Dec 2024 19:05:50 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215714b4f77sm56196335ad.202.2024.12.03.19.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 19:05:50 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v7 06/14] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
Date: Wed,  4 Dec 2024 00:05:21 -0300
Message-ID: <20241204030530.2099776-6-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204030530.2099776-1-adrianox@gmail.com>
References: <20241204030530.2099776-1-adrianox@gmail.com>
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

Add the functions efi_net_set_addr and  efi_net_get_addr to set
and get the ip address from efi code in a network agnostic way.
This could also go in net_common, or be compiled conditionally
for each network stack.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
(no changes since v5)
Changes in v5:
- When possible use sizeof in memcpy instead of hardcoded value

Changes in v4:
 - Removed unnecessary casts
 - Changed char *ipstr by char ipstr[].

(no changes since v2)
 include/efi_loader.h     |  16 +++++
 lib/efi_loader/efi_net.c | 125 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

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
index 7cd536705f..3491d4c481 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -17,6 +17,7 @@
 
 #include <efi_loader.h>
 #include <malloc.h>
+#include <vsprintf.h>
 #include <net.h>
 
 static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
@@ -997,3 +998,127 @@ out_of_resources:
 	printf("ERROR: Out of memory\n");
 	return EFI_OUT_OF_RESOURCES;
 }
+
+/**
+ * efi_net_get_addr() - get IP address information
+ *
+ * Copy the current IP address, mask, and gateway into the
+ * efi_ipv4_address structs pointed to by ip, mask and gw,
+ * respectively.
+ *
+ * @ip:		pointer to an efi_ipv4_address struct to
+ *		be filled with the current IP address
+ * @mask:	pointer to an efi_ipv4_address struct to
+ *		be filled with the current network mask
+ * @gw:		pointer to an efi_ipv4_address struct to be
+ *		filled with the current network gateway
+ */
+void efi_net_get_addr(struct efi_ipv4_address *ip,
+		      struct efi_ipv4_address *mask,
+		      struct efi_ipv4_address *gw)
+{
+#ifdef CONFIG_NET_LWIP
+	char ipstr[] = "ipaddr\0\0";
+	char maskstr[] = "netmask\0\0";
+	char gwstr[] = "gatewayip\0\0";
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
+		memcpy(ip, &tmp, sizeof(tmp));
+	}
+
+	env = env_get(maskstr);
+	if (env && mask) {
+		tmp = string_to_ip(env);
+		memcpy(mask, &tmp, sizeof(tmp));
+	}
+	env = env_get(gwstr);
+	if (env && gw) {
+		tmp = string_to_ip(env);
+		memcpy(gw, &tmp, sizeof(tmp));
+	}
+#else
+	if (ip)
+		memcpy(ip, &net_ip, sizeof(net_ip));
+	if (mask)
+		memcpy(mask, &net_netmask, sizeof(net_netmask));
+#endif
+}
+
+/**
+ * efi_net_set_addr() - set IP address information
+ *
+ * Set the current IP address, mask, and gateway to the
+ * efi_ipv4_address structs pointed to by ip, mask and gw,
+ * respectively.
+ *
+ * @ip:		pointer to new IP address
+ * @mask:	pointer to new network mask to set
+ * @gw:		pointer to new network gateway
+ */
+void efi_net_set_addr(struct efi_ipv4_address *ip,
+		      struct efi_ipv4_address *mask,
+		      struct efi_ipv4_address *gw)
+{
+#ifdef CONFIG_NET_LWIP
+	char ipstr[] = "ipaddr\0\0";
+	char maskstr[] = "netmask\0\0";
+	char gwstr[] = "gatewayip\0\0";
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
+		memcpy(&net_ip, ip, sizeof(*ip));
+	if (mask)
+		memcpy(&net_netmask, mask, sizeof(*mask));
+#endif
+}
-- 
2.43.0

