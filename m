Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BBCD69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F0D89D2D;
	Thu, 28 Nov 2024 15:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PjL0UKgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC08289D36; Thu, 28 Nov 2024 15:44:39 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2D789CED
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ea45dac86eso732555a91.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805076; x=1733409876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dQoA1DDh0i/SLBn1SH/BWqtJ1PhzGHfMY5Pu4+f+rs=;
 b=PjL0UKgqgD1dA+X6vS6Bewr5kHQcdCOrzZZAMYlEYdvb2GZvMeCiTIcgIn1twaIPha
 JyZty2yDNa57+t1qWbpjr1JUOTqH2xwcMuZVttDTF+HdqrU6qHvclVpc9zLNwM/Xg2JO
 51i83uL74jtQhCXh6GqjkVvEHXcRw6OwMr4CmXyTPKY6HNsXZRzs/PDR5P4NULZJRrOD
 EtpuF7CX+U9WhE7u2duTuYhvwutX8A26etYoIU5sF+S7exQSOB7eAkAyDLIFnvtrabul
 a638BEUgFlp2BpuMbRwlFkll3kpgpiZRSs1vfzmoOHywnUJ/nueyN81cPB43LcbzL60L
 xkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805076; x=1733409876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dQoA1DDh0i/SLBn1SH/BWqtJ1PhzGHfMY5Pu4+f+rs=;
 b=rNdia3PWXIHACHXjZBoBS9wagShSzhpan59NcZaL9RjUh7Vfa06c4+KADWFzAlpTRE
 Ka4h2Y+UM8dDjGbbvj2+MJBGHuLsPMJbMKDcJkV4DwSJ46aIAwxnWRhtYIqslsbwalGT
 cDn6LXN0/F1BTtZ1PThgL3JwfT1eHUO5grOZpHLGqNmxW446OMM8h8+esP0wqYL04W07
 BBYEBQ5xZC8vhLQoFBmhlHnuH42MyesJHQKPpm4oppSchIBAiXzMOuhe62sJpJxGZBRG
 Ygk08qTPmywvtiHTahGzBNalO0mN8cpGXfEL7xb1j//r3+tiszTY8oIjivXjsrCMdpmM
 +yvg==
X-Gm-Message-State: AOJu0YzkMpAw7thKioLa/th7MLdybAbj/orAJmOaeF66j8fEfAIf/CyN
 W2LUb+g+8yRb9//z7IhfDc1GlM2umMOpGJGjmnT/MC3EQunqoKIrPO3tyFOoBuA=
X-Gm-Gg: ASbGncuYVvUYCqhdMvqzuIRcdWLwWbO3pwiC3wGcppPaBkgw0D3hZcIQyIngWLJgrno
 ntVJcmCzgMnOJFmS4wEPZ9mDc5ZEUZM2cw2qpyzio5fMCvCp/DWL3RT+pYndWEpoRixiXxc5sKo
 YTJ47B8y6gL1Vr22tbbM57Q2T8Nkw88S7GWBr4yXZk3KyJMVaj9j/a582CEWZfHH+e9j5EQ4VUN
 fTNyN9iagqNfZeffFqgPcdA1KGRSSermwWFiM+LRSw=
X-Google-Smtp-Source: AGHT+IFu2syaLmO2baO38kRw5i5Z2+rUaRbxGqs0/UriEJLprOQdSfbB/S8CFxe68VGMqcwyUjzygQ==
X-Received: by 2002:a17:90b:1dd2:b0:2ea:4578:46cf with SMTP id
 98e67ed59e1d1-2ee094cb814mr9267658a91.30.1732805075702; 
 Thu, 28 Nov 2024 06:44:35 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:35 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 06/14] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
Date: Thu, 28 Nov 2024 11:44:08 -0300
Message-ID: <20241128144416.604126-7-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128144416.604126-1-adrianox@gmail.com>
References: <20241128144416.604126-1-adrianox@gmail.com>
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

