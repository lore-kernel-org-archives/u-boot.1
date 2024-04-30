Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E64C19F53
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB8C889C8;
	Tue, 30 Apr 2024 15:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YzP86jdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9325885A4; Tue, 30 Apr 2024 15:36:07 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6795A88516
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5ac8c73cf88so3768807eaf.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484164; x=1715088964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fMTqVSGYkbgCMKe3oTa1OkY/bWoUts2xNgb0LXDOT4I=;
 b=YzP86jdCP26HYj0wsq3y8UGb/Zhzz1WVTuKUqkPVM//eL18n1x//nT1lkNlvYk9ecq
 mAmHiYeKSfFQRu0YUieJ5vQzeHjotKw5nGw00Wawt3oTcyHWqKA6x8o3wiJJT0INWUYS
 Y98IQAbocpsEzDtdIjzI3LXEZ/1QrSnuXFxCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484164; x=1715088964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMTqVSGYkbgCMKe3oTa1OkY/bWoUts2xNgb0LXDOT4I=;
 b=Vt021AfBVstmprkMPTuteNFllSKBRpTKalhOEqmnVcCdHosK+fepszIjHRFRXuK62O
 5VCYk6HXB+hvO0PiEyi+jQkhzZxEsF79raIbOaQVHBbdolZ6pUdDxtENTGtBTk3yEMnQ
 nJgJIlRIew2AlpJqDyGilGfWI/N+yoyCGfLO5ETsUDung5PtuUzmYNaI7RGTZQonEKS3
 zJN/49YmCtcMF49U+y38NzIPFfCwzk31sVbpxc56HhGXg/NrvOVnilMgo3vv6x9zSmvc
 TgEg3IWAZdG631cb7V4/RNZ2klehRkONNo0bxyf5pW6us2ux6Ps+C3UKFTeK0AvYw87L
 3gvA==
X-Gm-Message-State: AOJu0Yz9tzRMSTH2dHMl/iFnwkidXtq5nJLyO+swnlA9E+KrYBqoK30g
 daWWzm/sKIY8kQd/3b8Ko7fxD8KX25HdFm15XT+8l04nIsbfNzE9JFM16Kq2do8TyLbtRSsdJuD
 mM/Gn3g==
X-Google-Smtp-Source: AGHT+IEKTsLEZLQwvcM5Zsuke9vT52NpD/ma5jyPuIb6ZhMhsJsN59VENNYeMypThYWcTTMSdWQMgQ==
X-Received: by 2002:a05:6870:308:b0:22e:c860:9a6a with SMTP id
 m8-20020a056870030800b0022ec8609a6amr16022352oaf.49.1714484163933; 
 Tue, 30 Apr 2024 06:36:03 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 02/33] include: Add missing headers in a few instances
Date: Tue, 30 Apr 2024 07:35:28 -0600
Message-Id: <20240430133559.1836389-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

A few headers rely on indirect inclusion of <linux/types.h> or
<linux/kernel.h> so add them directly. In the case of <netdev.h> add a
"struct bd_info;" as well rather than the large header chain to resolve
that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/mailbox.h       | 2 ++
 include/netdev.h        | 3 +++
 include/phy_interface.h | 1 +
 include/u-boot/sha1.h   | 2 ++
 include/u-boot/sha256.h | 2 ++
 include/u-boot/sha512.h | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/include/mailbox.h b/include/mailbox.h
index 323b6c2bc5d8..e70266fb61c9 100644
--- a/include/mailbox.h
+++ b/include/mailbox.h
@@ -6,6 +6,8 @@
 #ifndef _MAILBOX_H
 #define _MAILBOX_H
 
+#include <linux/types.h>
+
 /**
  * A mailbox is a hardware mechanism for transferring small fixed-size messages
  * and/or notifications between the CPU on which U-Boot runs and some other
diff --git a/include/netdev.h b/include/netdev.h
index 2a7f40e5040e..2a06d9a261bb 100644
--- a/include/netdev.h
+++ b/include/netdev.h
@@ -10,9 +10,12 @@
 
 #ifndef _NETDEV_H_
 #define _NETDEV_H_
+
+#include <linux/types.h>
 #include <phy_interface.h>
 
 struct udevice;
+struct bd_info;
 
 /*
  * Board and CPU-specific initialization functions
diff --git a/include/phy_interface.h b/include/phy_interface.h
index 31be3228c7c4..b74f4ccd84ad 100644
--- a/include/phy_interface.h
+++ b/include/phy_interface.h
@@ -11,6 +11,7 @@
 #define _PHY_INTERFACE_H
 
 #include <string.h>
+#include <linux/kernel.h>
 
 typedef enum {
 	PHY_INTERFACE_MODE_NA, /* don't touch */
diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
index 09fee594d263..c1e9f67068d4 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -14,6 +14,8 @@
 #ifndef _SHA1_H
 #define _SHA1_H
 
+#include <linux/types.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 9aa1251789a3..a4fe176c0b46 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -1,6 +1,8 @@
 #ifndef _SHA256_H
 #define _SHA256_H
 
+#include <linux/types.h>
+
 #define SHA256_SUM_LEN	32
 #define SHA256_DER_LEN	19
 
diff --git a/include/u-boot/sha512.h b/include/u-boot/sha512.h
index 516729d77506..90bd96a3f8c2 100644
--- a/include/u-boot/sha512.h
+++ b/include/u-boot/sha512.h
@@ -1,6 +1,8 @@
 #ifndef _SHA512_H
 #define _SHA512_H
 
+#include <linux/types.h>
+
 #define SHA384_SUM_LEN          48
 #define SHA384_DER_LEN          19
 #define SHA512_SUM_LEN          64
-- 
2.34.1

