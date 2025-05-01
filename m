Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7813C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EFDE8269F;
	Thu,  1 May 2025 03:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iLB30cgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A2482163; Thu,  1 May 2025 03:06:22 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA129807B1
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d93f4fe5baso1597865ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061577; x=1746666377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Vg+Hi1VUKmtd/vWwi00MKDlHhKEWlk40SWTlEofOXo=;
 b=iLB30cgHEQGd5ywUMIEZy7ZcBRb03OXacvbqlg5dDz6FBPDahTJBP0dbT88YaS0ofg
 rPbkQJj4fuq/EYYFGwdFxfcENVRKE4yPYFH7R8OVVIHdZeLh/Xv9L7k892+AKLJGwzOU
 pivCzcc+TsPLmA4x6IDi0b/EzyVlo5iWM2mVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061577; x=1746666377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Vg+Hi1VUKmtd/vWwi00MKDlHhKEWlk40SWTlEofOXo=;
 b=G3baGirJS/JEiXZj8xY9PwknOEtWYIpk0M6hBJKfYgxp8zcuGVKrCa9iwnEOU2JZlG
 Xia5gILVv3T5xm2uWTlQOLST2OMC+c1vnZ9FNRZoXPe5R2ANdBQpPZBXyfrJo53zdC3Q
 iQBKvQ+4D2TwR7sBQFB1t145GdHdAZY5+ZEXh/j8pPgwee6EYoqsc1vIc1cJqQVUdkKp
 YI1Py5m0Gnb1lLo7Xhpsi7k41Uqc2Sy8dZW1aTsMELCx8XO0wprCdDHY08NUo4wI3UGy
 42TA+ewvPX3BmPrqC9i/K/iuLz29faG9K8W4gXzaFr9w1RA0bOIikwmb4vOEw2XIaGTy
 n76g==
X-Gm-Message-State: AOJu0YzHCXgXPtpWBegDfd8pCj0gLdx5hBPhISl48UaAkahsFN5bkx/M
 gL6LdI9Xt2Un5VLWAm4Tjnn9B7qdGaC6vl+XfjNreIXlQhPsCztiEWilSojx5xwp9NjXBZjn+KY
 =
X-Gm-Gg: ASbGncuNOg7froKKt1stcLxennAhLxzwtlh+xnRImxwNSIBFhnLrGmqOZgdo+hO3i/Q
 M12ofhoa1MKue1e2KHdUQOfB/mypjpiM8ujqUsHAhQ0L4uKdEVDDgHe+bFj+6YAz+97LN9IQsez
 VjzPJqOf47rmraKoXFxMOHoAdq5tnmfurRB45eD4Tt7TvMm9aXjGTQCouJZH1J+I1/nEaDzjYwo
 Gbf7nJyQ7W7rsLoLxWL0ZdXaZ/kDsiMwzliUvxU/UDpmZwomP9yQEERfiR82VzAOGYDprDpNXgN
 H/2cSfL0XcwXZpdZj8l7CG8pwut1AMFZes68IHBfYyzjO0kFt1psdI6HFsfkxQ39ZE9ZEg70f+n
 fog==
X-Google-Smtp-Source: AGHT+IGVMMVIXTbF6AfKAuS/MTdM96iClE3eZ0LP5sBO5hTMps9jt6Ni7PnWH25OgE5QCmMvAPeBVQ==
X-Received: by 2002:a05:6e02:156c:b0:3d8:1d7c:e190 with SMTP id
 e9e14a558f8ab-3d9701cae81mr8099495ab.7.1746061576836; 
 Wed, 30 Apr 2025 18:06:16 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:06:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 22/22] net: Move env_get_ip() out of the header file
Date: Wed, 30 Apr 2025 19:04:47 -0600
Message-ID: <20250501010456.3930701-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This function requires access to env.h but it is a lot to include just
for the env_get() function. It eventually pulls in linux/byteorder which
causes a conflict with exfat which has its own byteorder functions.

Move the function to a C file instead.

Add includes to some other files to keep the build working.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v1)

 include/net-common.h | 6 +-----
 net/net-common.c     | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index f2613a41ad8..64b475b7292 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -4,7 +4,6 @@
 #define __NET_COMMON_H__
 
 #include <asm/cache.h>
-#include <env.h>
 #include <hexdump.h>
 #include <linux/if_ether.h>
 #include <linux/sizes.h>
@@ -464,10 +463,7 @@ int update_tftp(ulong addr, char *interface, char *devstring);
  *	0 to 255
  * Return: IP address, or 0 if invalid
  */
-static inline struct in_addr env_get_ip(char *var)
-{
-	return string_to_ip(env_get(var));
-}
+struct in_addr env_get_ip(char *var);
 
 int net_init(void);
 
diff --git a/net/net-common.c b/net/net-common.c
index 45288fe5f80..9ff06b165df 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <env.h>
 #include <net-common.h>
 
 void copy_filename(char *dst, const char *src, int size)
@@ -25,3 +26,8 @@ int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info)
 	wget_info = info ? info : &default_wget_info;
 	return wget_with_dns(dst_addr, uri);
 }
+
+struct in_addr env_get_ip(char *var)
+{
+	return string_to_ip(env_get(var));
+}
-- 
2.43.0

