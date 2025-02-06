Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26941C02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE04180CF4;
	Thu,  6 Feb 2025 18:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UjQdFj2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 932B080EAF; Thu,  6 Feb 2025 18:40:43 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F79280CF4
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f48ebaadfso9744965ad.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738863640; x=1739468440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8L5KHHXDflxQPCmL77zgapA34P7+u/m+VB/zfzXX08=;
 b=UjQdFj2aYY9z7Qyb67H8M+McUyHBvhJ2gjoVHKpKWwZbZzo7gXSh5GEBst/CyvtbIs
 UiyyQ/WVuvjhx69PtRF/sm09bdXq8nSjci270lWiClBGFV+FpJaq5Az9cZe9lZXdmjyt
 gfqJX0xkcUKd08lBvASi3c03vn37KFM7IlY5dc9WFVW6ybQ/FFJnPxFbB8/LTirAdTdN
 QkrdBFhmw8Pr1zM3zcAdLP+2EHQ7JgCYq8k4dcRPfrF/BqxsBwVNywMnSFbBXFiPN1Gd
 +GktroPIOUtLTCXLa60dnxOowcm95Ft3kNfsWkkuJxZhysqX4/4k7MhDcpT5gFBrqqJA
 MIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863640; x=1739468440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8L5KHHXDflxQPCmL77zgapA34P7+u/m+VB/zfzXX08=;
 b=esCBHa8UOJVEHQIM0ZmlQfAaxtzBcNXDcIP3oDXtUfLDsNtKOAWQ5JpG2snl5KwI6e
 iObMIepcEQWH4OQD0GGXZDi0NNhL2B0IyXNTGcpXH3SsoiXG9682kG0ULlgwlydjLHNw
 nriSfftB7PBcfn6fcYLDsDAC+rpy2nN1jCd2JUIq5HLSEeVejIKoLTVSPhR+qOo+LCAs
 2BZG+FM3ewlZHeiZho7hFw5B48Ac7dTmFa/XClc+B+AT3L9ssXxdi6hxMuNxGByjTZcB
 +Ku6OXZO86uI7hyrhTtYtSceN/hqIqQ5jmJ2X1dV1RgBntC1LQhof7PScoWuWChW9xb1
 2eAg==
X-Gm-Message-State: AOJu0YwkHBiYQlof2zbrhRUqClmfc1Jv5aRBlcdp/dxap53OxLTvtMFy
 USDfQi5HELlflxCeDdfZYxqFzj5Emfzhfk2/7pSDPgcyLI3aR71VpULXFw91S7QtdA==
X-Gm-Gg: ASbGncvNKy/FRgvtBNXoq8A09hUIrK0APHg2dURB3PSCPrWs90PdcEnJHGckVEm/MvN
 LsJ140cpM9QVurnK5r45vm/58JhTy3iBa1//kpeddM3OHQO5G+pSwoCxM08/K2xG+g8McUs77Qo
 2QJ6wmB2QW2wiqIi6+Iji5691wRa2GssGPxGkbAUfMOSkYKudsZqiz5h2KvJEyn9szALD5jk+MX
 C9JQELP90smYP6nh5m7p3RWcmorUq0ZZfYerr5I1PSbdDJqtHxaHjHM9Q8DJEtsI/CjzuBRevuO
 zuma8TieMUbuULCqklWNZys3
X-Google-Smtp-Source: AGHT+IH8hmDzHWptsplVwcryiKmlIIAuuxxQhcNEEE39zXNId48hRppNikoV0pAlr6LvNRa0tUothg==
X-Received: by 2002:a17:903:46c6:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-21f4e1cb92fmr19305ad.11.1738863639550; 
 Thu, 06 Feb 2025 09:40:39 -0800 (PST)
Received: from adriano.. ([191.119.55.28]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c31asm15476615ad.167.2025.02.06.09.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:40:39 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 5/8] efi_loader: efi_device_path: Pass net udevice as argument
Date: Thu,  6 Feb 2025 14:40:15 -0300
Message-ID: <20250206174018.465530-6-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206174018.465530-1-adriano.cordova@canonical.com>
References: <20250206174018.465530-1-adriano.cordova@canonical.com>
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

In preparation to support multiple EFI net objects, support
constructing device paths using an ethernet device different
than the default. Add a udevice argument to the device path
generation, and keep the callsites with eth_get_dev() to
preserve existing functionality.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h             |  4 ++--
 lib/efi_loader/efi_device_path.c | 20 ++++++++++++--------
 lib/efi_loader/efi_net.c         |  5 +++--
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 54801cdd260..5a256f733ca 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -940,8 +940,8 @@ struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
-struct efi_device_path *efi_dp_from_eth(void);
-struct efi_device_path *efi_dp_from_http(const char *server);
+struct efi_device_path *efi_dp_from_eth(struct udevice *dev);
+struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev);
 struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
 					uint64_t start_address,
 					size_t size);
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index c0633a736b6..64183d40340 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -954,20 +954,20 @@ struct efi_device_path *efi_dp_from_uart(void)
 	return buf;
 }
 
-struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
+struct efi_device_path __maybe_unused *efi_dp_from_eth(struct udevice *dev)
 {
 	void *buf, *start;
 	unsigned dpsize = 0;
 
-	assert(eth_get_dev());
+	assert(dev);
 
-	dpsize += dp_size(eth_get_dev());
+	dpsize += dp_size(dev);
 
 	start = buf = efi_alloc(dpsize + sizeof(END));
 	if (!buf)
 		return NULL;
 
-	buf = dp_fill(buf, eth_get_dev());
+	buf = dp_fill(buf, dev);
 
 	*((struct efi_device_path *)buf) = END;
 
@@ -984,11 +984,13 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
  * @ip:		IPv4 local address
  * @mask:	network mask
  * @srv:	IPv4 remote/server address
+ * @dev:	net udevice
  * Return:	pointer to device path, NULL on error
  */
 static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 					 struct efi_ipv4_address *mask,
-					 struct efi_ipv4_address *srv)
+					 struct efi_ipv4_address *srv,
+					 struct udevice *dev)
 {
 	struct efi_device_path *dp1, *dp2, *pos;
 	struct {
@@ -1010,7 +1012,7 @@ static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 	pos = &dp.end;
 	memcpy(pos, &END, sizeof(END));
 
-	dp1 = efi_dp_from_eth();
+	dp1 = efi_dp_from_eth(dev);
 	if (!dp1)
 		return NULL;
 
@@ -1029,9 +1031,10 @@ static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
  * and an END node.
  *
  * @server:	URI of remote server
+ * @dev:	net udevice
  * Return:	pointer to HTTP device path, NULL on error
  */
-struct efi_device_path *efi_dp_from_http(const char *server)
+struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev)
 {
 	struct efi_device_path *dp1, *dp2;
 	struct efi_device_path_uri *uridp;
@@ -1047,10 +1050,11 @@ struct efi_device_path *efi_dp_from_http(const char *server)
 
 	efi_net_get_addr(&ip, &mask, NULL);
 
-	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
+	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL, dev);
 	if (!dp1)
 		return NULL;
 
+
 	strcpy(tmp, "http://");
 
 	if (server) {
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 68051852dd8..ebb7f4afd3c 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -951,6 +951,7 @@ efi_status_t efi_net_register(void)
 			     &netobj->net);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
+
 	if (!net_dp)
 		efi_net_set_dp("Net", NULL);
 	r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
@@ -1078,9 +1079,9 @@ efi_status_t efi_net_set_dp(const char *dev, const char *server)
 
 	net_dp = NULL;
 	if (!strcmp(dev, "Net"))
-		net_dp = efi_dp_from_eth();
+		net_dp = efi_dp_from_eth(eth_get_dev());
 	else if (!strcmp(dev, "Http"))
-		net_dp = efi_dp_from_http(server);
+		net_dp = efi_dp_from_http(server, eth_get_dev());
 
 	if (!net_dp)
 		return EFI_OUT_OF_RESOURCES;
-- 
2.45.2

