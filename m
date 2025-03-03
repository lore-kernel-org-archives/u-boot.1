Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D25C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 14:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6C48128D;
	Mon,  3 Mar 2025 15:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XC0VKuf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDC2E81423; Mon,  3 Mar 2025 15:13:34 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36FA981335
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 15:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2239c066347so25743955ad.2
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741011211; x=1741616011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mln0P3AuMnmxUYezQnYL0+nN7kJrz1Xct2XZ7rXhko=;
 b=XC0VKuf09liTys8T05IpqGgMFHPBupMjDm5GtqJxY1uNJYL8vPjyALEYMZgJsOPjTs
 9xmONvkjfggZwsc7+tx8THXeFiBFvJy5NCwW9zUNAlJskEhc9NxKMUnrRJE0a63GbNBI
 sn6jNhogEc67E7YpBugrVZ1ltqt38XL2Q7YcklqO+TJnnxUiijGruWBwqqLGMQSQxHUL
 HFLcvLbuP4OPUemuL2dr1UGfhEyRrc+Gu/zxBOCZ2DNGWaBgXJ/C6/X71hz80+SCPBC3
 V0Pv9TuZMsphSHRbmVlEbM1MpXGaoTFJIU1Jxuai9L2H1mkAiy2iPe0bG7uutcA8WLCR
 UDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741011211; x=1741616011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mln0P3AuMnmxUYezQnYL0+nN7kJrz1Xct2XZ7rXhko=;
 b=iF0ZG3wqeDuztxc0q4ZT1MM6QnVEEpqRRcNCL+OMBhAWcRt7DlkCBLgtsjJ2K90x6r
 69ZQVgCTddXOo7bXI+agc+kZk8e2ZKMznGQZEuc0Ytg/4n5NifKR9Aape3CbzfGFKvkL
 GA9Sgv1xYkmVtICAVeFMHif9njNzgFZUsCdV80SxkIp5JZmkoK30MY76WafnbGrTyPi/
 EoEUQy6TecUaK3ZcW3LLIm2ycv8XlpCZ3SWZCS9owkAynivTUL1GnEq7b7Fm+bmxJthb
 2vl31SAEfK1a4ARMbbtgG3B4331f80orwBp0NqboM/RDz21eOCkjhZbss7nzTmoWXDCI
 3zSQ==
X-Gm-Message-State: AOJu0YwbXFTN6O2FmdqtPV40x5ul/pMb+IxNDMP3TCMiwOL3Nc8aDmv/
 LCdxhMZIJepcp+Oj5TPojHImv6T4CJ9aTm8ROc6X/Bl3axDnB67SwgVSmNMKMHY=
X-Gm-Gg: ASbGncseivMfw++bRjJ3gH2yshr3OTOR4ctdhREVgNCB+oeh5gmUSb6f/1lubq+s/WN
 /uzfPXq7br8Q2dp3ll597+pB9aoN0p9XX/JhIpxbO8Evup6GiBEmJGAjc/BbkVixVEHPxC5hTRW
 sN6+ufcPpjCq4yFHIC2RrDkRN4/a4034dmbA/tRHfTgbL8RwcBpfA6t4QJLfXOulwZDrZIPnBmg
 HXEclxWzR6WqJzl2asyo6vp2RlzvidUmnDSRs8KAzKvaR+xoxEPfcs39rXms8m2Y9x9HD3AfBJB
 3tYq6nlf/Ouk5Cbt0Mc3pvpkFa6N0OG6Yu9MtEIgutoHlTfGBtityfE=
X-Google-Smtp-Source: AGHT+IHaWbRI87zjoRh89+ao2OR/ShHj/USrA6bUU3FPZnS3X7Aova26gfNCFKL/loH/eIKxYUD2HA==
X-Received: by 2002:a17:902:d4c6:b0:215:7446:2151 with SMTP id
 d9443c01a7336-22368f61abbmr187612055ad.4.1741011210663; 
 Mon, 03 Mar 2025 06:13:30 -0800 (PST)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501faa33sm77875265ad.66.2025.03.03.06.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 06:13:30 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 5/8] efi_loader: efi_device_path: Pass net udevice as
 argument
Date: Mon,  3 Mar 2025 11:13:14 -0300
Message-ID: <20250303141317.265098-5-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303141317.265098-1-adriano.cordova@canonical.com>
References: <20250303141317.265098-1-adriano.cordova@canonical.com>
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

(no changes since v1)

 include/efi_loader.h             |  4 ++--
 lib/efi_loader/efi_device_path.c | 20 ++++++++++++--------
 lib/efi_loader/efi_net.c         |  5 +++--
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index c2fb3e66eb9..47c043460eb 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -925,8 +925,8 @@ struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part);
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
2.47.1

