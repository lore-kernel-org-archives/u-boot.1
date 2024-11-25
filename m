Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CF1D3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5441C899BF;
	Mon, 25 Nov 2024 01:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P0SFPrtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C53CE8929F; Mon, 25 Nov 2024 01:58:43 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F0A895C5
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7f8b37edeb7so3315392a12.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496320; x=1733101120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nck0eBp+AVgHPNWYdK0DuV7BwjDL7/TP1js1stoKrmE=;
 b=P0SFPrtTY4bNLljbIaYIk0Bk5SekBXCUjE5ruHZlUxgrRbkg0puSim9tCBTxQxsR8b
 o0F4k1rwBVm61ftfsPXKB2puGuU2k8jxwI8o4vOUlrA1Z8xG8jRpkpobaUdPH2SM+1xJ
 kHvRBXb4HrWXGbBWOuZUevD77YM3cfGQk/YWUrTLBnDS3aNlAInRNIHbxoansienNuFU
 SUZoSBJOWBQdWCpMtMNDMO+fw6Jhi/PL3T4rKzBaP5Hb9B2yFrv8w/dx9E3wO/EKjiYu
 as2+3UtKuDH3JR2C7AKPlgpsLaUmrilRsh2iAdztFHdifPyp2zk/zdnZP8OF+/5Uu8qy
 dcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496320; x=1733101120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nck0eBp+AVgHPNWYdK0DuV7BwjDL7/TP1js1stoKrmE=;
 b=OpVjKwq0xGFR4HP0UWHeTi/nEe5Q26Wt2GHPQJOB7jGFb3FUcS+SLr04V3gKNXaNey
 v1MuWtMunqu4ZRBAyV1de4nPMV38uyFwJbaUzKecTyKEZPvK+PAo44vs+33cXHQoZ8O5
 WkrZQz7BBFRzjOt/KbxwwgHGtqF2yRbrwEWFjgFV9z7WOkLAqKMoYyT/HrzCUL7neMAR
 7uy4EJcYpcrL5XNGnkfxK9gjPY1Lv8hZ+TjnWySBAYXj3pI3WfAnHxXuifwQNzlpIoRF
 MFvquPPyTnA5xq2fb60RSr/2+Y3sqNvWE3aBLJXYH2xpn65GzwA4jBrdNAP+BACgwScA
 f7FQ==
X-Gm-Message-State: AOJu0YzO/Ak6b6PSupqMWCdH0nX65cppji9u9qZ/0fhtu1RrMMZ+2Vcb
 m1FpMsRuS63FV+LofSDHuF1Mfy1XUMBQUfydnJ7QKZ61DoqW7u3pbCxu+RD//EU=
X-Gm-Gg: ASbGncvlmDYVoPp2LnBnKt9CNjJHcIaigcQck9V1lsTDNlwQMWMU+bI/mGDqzpfzkfX
 2xIV8sK7BIRZvjT5CbXA/QXzYESLVOaw/GN2tqPLLiWu+WS5qAdt9+0y1nAWYL4aAHAfgB9XtOL
 bnIa6Qra5lM7W8Oq1gC0FfO7IAgIThP//Q8/RDrAa8+0OzT0BwzvFhThvznbu8P9rt1HDR4jn1c
 OUKxDog6PXQ4XPRQ/8H5iwyJthHx/DCyhL33cD5rlXI
X-Google-Smtp-Source: AGHT+IFKNKKiKSfPGzn/Fa1mXof81UEma9QmoEydfjwXJskSAGDlhw2PbeOdV5PwtPSOQfeVxNwCFA==
X-Received: by 2002:a05:6a21:10a:b0:1e0:bb0d:b1f4 with SMTP id
 adf61e73a8af0-1e0bb0db6f1mr7421562637.11.1732496319970; 
 Sun, 24 Nov 2024 16:58:39 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:39 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 06/14] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
Date: Sun, 24 Nov 2024 21:58:06 -0300
Message-ID: <20241125005814.236669-7-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125005814.236669-1-adrianox@gmail.com>
References: <20241125005814.236669-1-adrianox@gmail.com>
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

