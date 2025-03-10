Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14075C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0F78193A;
	Mon, 10 Mar 2025 13:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KQKWBbt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 047A481898; Mon, 10 Mar 2025 13:06:14 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C19812D9
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224341bbc1dso41248185ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741608370; x=1742213170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rUs6lLDFAVoOt4QhFop6JGh+8wtUlxjRkNIITvX33k=;
 b=KQKWBbt7DFQvHw7utmH+px8KkcK2Cir7gLS7uvPQGSJnoALzfeBlQBB9rJAOnSXVoe
 DEAOV+Tz/30IseYbY0OdDIoaRY/k78PoFqJZ5HwKQRTWefJY0mnGjLVY436y6Vw1Sq8U
 4CeC1C593fdjbkH5oDYf1pzUm74Lhl+PuasXP7r2APgOCvMN7cERc2+K29VaCjVQATl+
 VVzKAqN0Z5V0nXXD2uVg2Cc56Bh55PR4BarQAxAaKWeNUb31pPVHyXJFlfUsScg/NR8+
 qZ4sQXxunRPhWHo2Fu0bqP/ntr9bE+nJWvCVfoBqpq3t1E9WQGRZydI5ab+rintIk6iP
 XIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741608370; x=1742213170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rUs6lLDFAVoOt4QhFop6JGh+8wtUlxjRkNIITvX33k=;
 b=MJnjKafNGLzUolLm9uL9XNL9/3B7ZQe70WXvKaHJX5AlZc9tHI/vNibnIEbR4xNOOy
 TQ78ZB2UPsiEJGrpdp2faPXcWteyNr7m6PkgsMIBvTOG7BjXeepv82suFsF6VrBss1FO
 eNQL+W3IeRaTlVouR68AC5EGpNNf/s2fHG+4gzgNs3RHUzgjAnnmaG+VpCaYo+QFV3D7
 C36N4da9MRVzJOYkAUdVGeulp1LmDOVn8cxfnrdD2yQkyPV1WuCjR+jSdqScnsjsSWSc
 zUP+1aPreQFo6pN2bpuSiwW+QFoh6LXLtkeSeVXbSXKq8nxq3GjM0tBVC9AuMAiEopEt
 44OA==
X-Gm-Message-State: AOJu0YzfZX4JE83BKiHVGJP0H46MIYeicIZJoZ2K1DxfH8LW0JMmA5eq
 297KfCjZyjZ5Jq1971ChQxqSE5lSHUGUL1TAJ521PjSBA1wNj/+hyDnwZdayAMY=
X-Gm-Gg: ASbGncsdMsDbrfOEzP8+I1EMqvBO0VI1qPcqQP2/68KINvi3rHfKtgBwWZ33GwOzr0S
 RT1UNRXP3D1YHQR1X1jmehs4NtJIvIvdq3dNwoTe2Mfw5GlN45oc7IP897w3rau+iKbjWTZo1BU
 32fBJhRME5d2TA2JXQcoYYU5YSNuOTR509iG/lra1jWh+Ub0b2bhuPWNkHG720qAT9VsRD3DwB+
 DERLvEhoSc3FNMYpFkiOq7iLU/N7NArQuHfTHNcll5gg+ieEkGv7sv/0pRB0AM/41+wmn+KdvFc
 wXRZXOwzwvLgFJE/0WG2n2iRag0BWKHtt+Nj9MJ3OLr9nLW5jadrDSQ=
X-Google-Smtp-Source: AGHT+IF5EgjV6MjCmsZkags5Ok+bg1O6FNRtVkPFtIeIo8ysucdcOe24Ga8X6i6e2yK7EZUNE6yzVA==
X-Received: by 2002:a05:6a21:7a44:b0:1f5:8678:1832 with SMTP id
 adf61e73a8af0-1f5867818dfmr2305316637.11.1741608369839; 
 Mon, 10 Mar 2025 05:06:09 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a8b61f76sm6968899b3a.103.2025.03.10.05.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 05:06:09 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 5/8] efi_loader: efi_device_path: Pass net udevice as
 argument
Date: Mon, 10 Mar 2025 09:06:04 -0300
Message-ID: <20250310120607.186999-5-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310120607.186999-1-adriano.cordova@canonical.com>
References: <20250310120607.186999-1-adriano.cordova@canonical.com>
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
2.48.1

