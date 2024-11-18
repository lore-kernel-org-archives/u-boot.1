Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A617D591B7
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37145894B2;
	Mon, 18 Nov 2024 22:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O0WxR7ku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC0B894BD; Mon, 18 Nov 2024 22:09:38 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975F0894C3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2966ed13a13so893335fac.3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964174; x=1732568974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZcrSgoo2HQNIZY3MPn7MMzUcjW6mmDJS0m8ob45MGA=;
 b=O0WxR7kuSiyNf04MmN8Koqi/bhmW5yCQT+8335sn/vsbcVW+XM9xw7h4JnlzHHpGsb
 z42MQAJKxO6bBAZrviRSn27+jveGB5L5YDW0Y/Rs9kHAfJs4kfs0feR6isd1oRbgc/X0
 mgeZo5bBasE+vzNTFRkCpm6dH6/BB55DMU6wOcvz+geNAszCT4HbzAhPBH+dHZAADJFR
 /Q02bDqr0iMemKIKnhPG1bYJ3gdLsjlrcf2CJHgP1wlyG3X0RDGR7BBmIETmxD8xotmg
 idXMOjkRb/Dr9X2h17fSKQd92Mv8kpHNpgQR/WBTMOrznOssnUTzEGVRZXjt3xJwi1YX
 Jvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964174; x=1732568974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZcrSgoo2HQNIZY3MPn7MMzUcjW6mmDJS0m8ob45MGA=;
 b=wUMfm+vxg7I+cVVM95ZeUhK1XuRRdHiCjy21JTNsOUBPVNeDcSDlc2pGZ6GS/OErgv
 /viXDl7iy0NIW9fE3dE1x45CUv61ZrhkCkliOSbfuS/ugnTDbvJX7PDdVsLf94mStYf6
 Qurc2A4wVPTquhylUY5fcUgUF3FXSWVKjjxTXv/6twS5znJIbqpTB8e7QPaR5+qmiyJf
 Fup+g1DgzCN9zbo83FCPUFyIUXH2UqUcImMzxQjmH+Pae691dLIh9QUdUJ4tNtRg6lHG
 ryoCPxReuoR7qawphLfiqPi+bGeN6KbpsRPVyCYCB3a3I+RkBuufsDAJ8JyiOMb0E3hk
 03Pw==
X-Gm-Message-State: AOJu0YxIWTrYmPQqMANm64/LRPlssXLhx6OZklFz9YJpucPuk08+41cU
 Mr5NyBso6kxscqcDUvbd52SilcqaFgnUjgozsKd1FHjluCYjq/zqVqqnbeIi
X-Google-Smtp-Source: AGHT+IEK0kSA78S4cCFx+v4yb7CXbrT6iwrH3VeNQhCUaHv0fhqBFhKcASFjV6i5Rmt4+pUrB+gCDw==
X-Received: by 2002:a05:6871:44f:b0:296:88d2:6428 with SMTP id
 586e51a60fabf-29688d27f56mr3274488fac.16.1731964174363; 
 Mon, 18 Nov 2024 13:09:34 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:33 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 07/14] efi_loader: device_path: add support for HTTP device
 path
Date: Mon, 18 Nov 2024 18:09:01 -0300
Message-ID: <20241118210908.51196-8-adrianox@gmail.com>
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

Add efi_dp_from_http to form a device path from HTTP. The
device path is the concatenation of the device path returned
by efi_dp_from_ipv4 together with an URI node and an END node.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v4:
- Reworked an if-else

Changes in v3:
- Moved argument checks in efi_dp_from_http to the beginning of the function
 include/efi_loader.h             |  1 +
 lib/efi_loader/efi_device_path.c | 52 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 612bc42816..96b204dfc3 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
 struct efi_device_path *efi_dp_from_eth(void);
+struct efi_device_path *efi_dp_from_http(const char *server);
 struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
 					uint64_t start_address,
 					size_t size);
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index cdeea4791f..9ee03062ac 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1012,6 +1012,58 @@ struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 	return dp2;
 }
 
+struct efi_device_path *efi_dp_from_http(const char *server)
+{
+	struct efi_device_path *dp1, *dp2;
+	struct efi_device_path_uri *uridp;
+	efi_uintn_t uridp_len;
+	char *pos;
+	char tmp[128];
+	struct efi_ipv4_address ip;
+	struct efi_ipv4_address mask;
+
+	if ((server && strlen("http://") + strlen(server) + 1  > sizeof(tmp)) ||
+	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
+		return NULL;
+
+	efi_net_get_addr(&ip, &mask, NULL);
+
+	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
+
+	strcpy(tmp, "http://");
+
+	if (server) {
+		memcpy(tmp + strlen("http://"), server, strlen(server) + 1);
+	}
+#if !IS_ENABLED(CONFIG_NET_LWIP)
+	else {
+		ip_to_string(net_server_ip, tmp + strlen("http://"));
+	}
+#endif
+
+	uridp_len = sizeof(struct efi_device_path) + strlen(tmp) + 1;
+	uridp = efi_alloc(uridp_len + sizeof(END));
+	if (!uridp) {
+		log_err("Out of memory\n");
+		return NULL;
+	}
+	uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
+	uridp->dp.length = uridp_len;
+	debug("device path: setting uri device path to %s\n", tmp);
+	memcpy(uridp->uri, tmp, strlen(tmp) + 1);
+
+	pos = (char *)uridp + uridp_len;
+	memcpy(pos, &END, sizeof(END));
+
+	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
+
+	efi_free_pool(uridp);
+	efi_free_pool(dp1);
+
+	return dp2;
+}
+
 /* Construct a device-path for memory-mapped image */
 struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 					uint64_t start_address,
-- 
2.43.0

