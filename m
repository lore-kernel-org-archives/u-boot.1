Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D07D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EDF893BE;
	Tue, 12 Nov 2024 03:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UgJWEwHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136BF89393; Mon, 11 Nov 2024 22:09:20 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9CFB8931D
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso54403715ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359356; x=1731964156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtQDfjVZKJaazOG3mwifxz6rNtT2yBhIiysJWigZBAE=;
 b=UgJWEwHbPEKAjsy4gIN5IvLfqIE2nJ6lffPgP/kd4cflRtnMddFYe6a0sQu9FvAhig
 x6UAuTK2Dtgxcwvzd88C8iQ89p2rNO+8rwIHRz9uy6oJ0KAQJ+zCwCYngJmAV90vtNHP
 WmZsHFLKIq8fUBjYPalmGuGvqE0qhm8e3nfN7bQ7UA98sjA+5FHACzdF8lhMlJNeEJ1v
 upjhu57p7ow+2ocCHvXx885kd+/pppzsZd78o/LDgEeUz2GXwV/SpGxViIwAmfJlR6Je
 nsgnHEbg5e9m/Vmya29Pd1l0LOg9inC6VqDxKvAHqWQxNbr6VkdZxw31FAv9mC3LKvHO
 DpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359356; x=1731964156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtQDfjVZKJaazOG3mwifxz6rNtT2yBhIiysJWigZBAE=;
 b=tSiJSUBWVMmnjBqG00wVlq8NJ1j1MQo+6QdvEpK0EuhylMcWHEAYCB2txq8pIWd02c
 8itEjWlY7hMxp8cVyXyUxTZQGMOr+EurIIQhik4g3gslPekubsaYHrqLE4/qkovwSixm
 uSeonU6hl+K4s4Ahtm5PIpL/Lqm9X2DIxDrArwYV1f5K873Vio7S93vIdzUxrr0kGRs6
 qQvQoMyYk3iQXIcMB5FKa+k0oJDD3lMxlo+cyANG8aHgc/r7QBEIN7K52eXWd9/j7U89
 gI3VZduze7v8ZdtdbUpTCkDHnXOQl9CZ8sfcjdAxz+kGSj9zpKOXNsgnj7KMEqAVMSDj
 1ilg==
X-Gm-Message-State: AOJu0YxL8Gyd1Pv8ujFD/bV10XK19SQoHj31CmKJ4nIWshXrdaw72Srk
 cGCyH+21I2CJL5alYiBUSFTQpJef2uu+vAR1v0YmhjFmkR3RNYzin0vkCZ5K
X-Google-Smtp-Source: AGHT+IG2M2wBa0MZEp/Si6BnX7xuh7PpqMm2oprWGzlcgWKFO+DGUmriyAha4N7IBf7UbpaP+b955g==
X-Received: by 2002:a17:903:98c:b0:20c:9da6:65b0 with SMTP id
 d9443c01a7336-2118358c055mr214977245ad.35.1731359356416; 
 Mon, 11 Nov 2024 13:09:16 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9068sm79807415ad.2.2024.11.11.13.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:09:16 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 5/7] net: wget: make wget_with_dns return value compatible
 with its lwip version
Date: Mon, 11 Nov 2024 18:08:59 -0300
Message-ID: <20241111210901.560691-6-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210901.560691-1-adrianox@gmail.com>
References: <20241111210901.560691-1-adrianox@gmail.com>
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

There are two wget_with_dns functions, one in the legacy network
stack and one in lwip, but the return values are not compatible.
This commit modifies the legacy version of wget_with_dns so that
the return values are compatible: 0 on success, otherwise a negative
error. This way wget_with_dns can be called in a network stack
agnostic way.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v2:
- Remove wget_with_dns from include/net-lwip.h, as it already is in include/net-common.h
- Adjust return value in the documentation of wget_with_dns.

 include/net-common.h | 2 +-
 include/net-lwip.h   | 9 ---------
 net/wget.c           | 2 +-
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 1efb0db9ff..3cd0f34374 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -495,7 +495,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
  *
  * @dst_addr:	destination address to download the file
  * @uri:	uri string of target file of wget
- * Return:	downloaded file size, negative if failed
+ * Return:	zero on success, negative if failed
  */
 int wget_with_dns(ulong dst_addr, char *uri);
 /**
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 1c3583f82a..4d7f9387d1 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -16,15 +16,6 @@ void net_lwip_remove_netif(struct netif *netif);
 struct netif *net_lwip_get_netif(void);
 int net_lwip_rx(struct udevice *udev, struct netif *netif);
 
-/**
- * wget_with_dns() - runs dns host IP address resulution before wget
- *
- * @dst_addr:	destination address to download the file
- * @uri:	uri string of target file of wget
- * Return:	downloaded file size, negative if failed
- */
-
-int wget_with_dns(ulong dst_addr, char *uri);
 /**
  * wget_validate_uri() - varidate the uri
  *
diff --git a/net/wget.c b/net/wget.c
index 21f1875866..3bc2522cde 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -579,7 +579,7 @@ int wget_with_dns(ulong dst_addr, char *uri)
 out:
 	free(str_copy);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 #endif
 
-- 
2.43.0

