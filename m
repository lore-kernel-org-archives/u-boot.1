Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB58D591B7
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7677894A9;
	Mon, 18 Nov 2024 22:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sobj80UZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18683894D9; Mon, 18 Nov 2024 22:09:36 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7221894BC
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2967c76318fso202643fac.2
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964171; x=1732568971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P//JQbW1qBOpqmscLVfzZcs5O8i74H6XD9eMqZYSwdI=;
 b=Sobj80UZq5AD/x+jCYhe1fUeFR8jruVfiVDELO22Bzcsab3x3x7JoaoAHS7tiWQzG9
 XNobihg16YSLZfsFOkoSGW4WVQOFMAeJ8RgvZVpiwnkAEQslPdONde3ve8wQSW2zMmMv
 SNKC/ZHkSQiMh1MvunSpm+KBwEC8o2LC3rZr3ALFzq5JJZiy8cCxrHni/hHKYWtzuVR4
 zXt/M8AFRoPpLkWZjoQLq7G9tRSrCSn9DrXUPBblR2gAVMLhO0pb7IDavavtV98tQtBT
 I9vSnLRYM/tdNOofQY5fmeb6qhV/GOOXsqT/eVZyIoTk/nqWVz1qepwchFjsIRIg+kMn
 XBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964171; x=1732568971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P//JQbW1qBOpqmscLVfzZcs5O8i74H6XD9eMqZYSwdI=;
 b=PN5MB9u/mcgDzWC1hdLe8WONoD4x4tD9kKNqaYl3emukErZ7yTmJlO4oFjH5OBoI3A
 Dna4K/T8wo07j2/u1S/rHzUmljaHGS4YVhZqWnBR4qVbO8G81qUtRK9m5O1d1O02ziit
 GrBJ/Yk6x/qU/OHAI9HwaZ9q+tViBTHhPrfv28/StONGmHzRzEMDog04t6+8avy90m3F
 qKgtoB9ijSi7JDntFTnd4DeHItQmbajNIYo1bGZbikbM/FhKbWhBkJzBrJJtBZL2R21+
 JGGZ54hMmVvPH5OsHytLf+idfKABbE1819S3rGXMf667FMHg6EvqBQjneCa5jpEtZqJ4
 0M8w==
X-Gm-Message-State: AOJu0Yxb+v5hhjejyYCG/Sq9XQM6Sl6ybxHzDgDp3hZSCpjeUa/MYpvA
 thaLsf+9+kofkXBa9W3vfN26NislOIOpN5+6KVREVdi2aOxVPQj5Daq7Dihj
X-Google-Smtp-Source: AGHT+IH92aqmxd/2wb9NOTgnX3zg+WvQZSvYyU20TqFSWnluN9XJiP2h5K8y0zeGRNj2BJLyZvgcQw==
X-Received: by 2002:a05:6870:6488:b0:288:8aaa:ed0e with SMTP id
 586e51a60fabf-2962dc9e018mr10841272fac.8.1731964171466; 
 Mon, 18 Nov 2024 13:09:31 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:31 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 06/14] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
Date: Mon, 18 Nov 2024 18:09:00 -0300
Message-ID: <20241118210908.51196-7-adrianox@gmail.com>
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

Add the functions efi_net_set_addr and  efi_net_get_addr to set
and get the ip address from efi code in a network agnostic way.
This could also go in net_common, or be compiled conditionally
for each network stack.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

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
index 7cd536705f..3f0b571cc6 100644
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
+		memcpy(ip, &tmp, 4);
+	}
+
+	env = env_get(maskstr);
+	if (env && mask) {
+		tmp = string_to_ip(env);
+		memcpy(mask, &tmp, 4);
+	}
+	env = env_get(gwstr);
+	if (env && gw) {
+		tmp = string_to_ip(env);
+		memcpy(gw, &tmp, 4);
+	}
+#else
+	if (ip)
+		memcpy(ip, &net_ip, 4);
+	if (mask)
+		memcpy(mask, &net_netmask, 4);
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
+		memcpy(&net_ip, ip, 4);
+	if (mask)
+		memcpy(&net_netmask, mask, 4);
+#endif
+}
-- 
2.43.0

