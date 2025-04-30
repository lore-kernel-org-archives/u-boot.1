Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84D9C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C2A82BAF;
	Wed, 30 Apr 2025 16:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MZMrAfkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB51B82B95; Wed, 30 Apr 2025 16:40:26 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F228210F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so33279565ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746024023; x=1746628823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/gpf2M9mvWWhxVt4rKC10XtunU5UdKNkpjRNVX6ikA=;
 b=MZMrAfkPvO4yfGbnNsTjA5/wJdhHhuL7lZQWtS/RG0Ojr5JV289ACTBZTgzaGqc4LR
 gcthKhE9G8fqnOV06hpQpUE7by92yiYHOmtRYKftU7Z/WOgof5UPoFgIQx82wyjZg4Zv
 /VuhXV4EYod2uBfKVRKGw9AH9uN+bOyMRVBa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746024023; x=1746628823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K/gpf2M9mvWWhxVt4rKC10XtunU5UdKNkpjRNVX6ikA=;
 b=THHw9dP1smanYHlob9QVge9JuPiW9u+HenQ+8Bn361WJZAqMKpXRqay/g+l1icu/I3
 Et8kEht9FHI2bVVAPcx/1BZ5J4eyZtDfHVfVOEUvOxBh10i749pdKp2yFX0Vk6lMCVrv
 rtcDusZXeYGe3SmW8ApI+Vp7NUSeb1xBzD548XpzHqcUeXQCU2KpL0uWDr36Z0mW2Sof
 jIhfE6ChcMwHv8+JhokTVhlnVUpLuuYyD6KbU3OChvoM/NpNLa/hf+GSB2lSEN5jVPUm
 lqAZs39dvLJY340ho6zF8Tgxt1hY+YZapNdQdnA62460DgDvPY1wSbZLUVWN0KrR94/H
 BEGw==
X-Gm-Message-State: AOJu0YzN9/hi3PeX0eqW/4jZVg6QAG9WKz9lDLB34B1dGvS9m4VZFCVt
 ctLwvBvp+P3fMnTQLYA8WdOv2oHEPuD6F8caRdtU525sQvIy+ZHWVUTvJAP2ustJbfxVoQokp4U
 =
X-Gm-Gg: ASbGncuFg9skLWy7gCBSKwSC30Hjbjv9uP4tAhFlIAbmTIGNXqqzWnoVxJUmpZAB6xd
 aOgsYKfVZffHqZ4K7fIUt87pt24WOrHd6CI7i30pURZ21yWQswmQyO3LSJxPGf9q8hNQ6HbLuXw
 hC5DoMViJbr2fpe2QuQFVHZRVTuiVbnP/IOTU6nt4i6gyjTtKPzeY/7+QX8UmaCya0MUHl9L3na
 XKdyAB7C62+nN/sw3mFeKRCvaednhjc+MDK2GjyaR5kCSU8+mFoef5Yto22M8CuJq9BS3oQLkU3
 uObd889LcjE+5ny5LTtCm8XZuoSVrw/iYOlrnnNHtTKTLjXyypGn6x6EDA1oHsmjjVKYNwkk9dc
 WCw==
X-Google-Smtp-Source: AGHT+IHAiB/fgKuv1MAWgApJzNzsT4OThF8lDdpuebMwfOxF5aiprXEhQKEzFJFBlTkBZ/MnTl9H+A==
X-Received: by 2002:a05:6e02:1a89:b0:3d9:6379:86e9 with SMTP id
 e9e14a558f8ab-3d967fa3bcdmr27469465ab.5.1746024022866; 
 Wed, 30 Apr 2025 07:40:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f2a2f73sm8580995ab.3.2025.04.30.07.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:40:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 2/2] net: Move env_get_ip() out of the header file
Date: Wed, 30 Apr 2025 08:40:01 -0600
Message-ID: <20250430144014.1698011-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430144014.1698011-1-sjg@chromium.org>
References: <20250430144014.1698011-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

base-commit: b5d6220dd2f4612912989f3c2b5a710f2248cb36
branch: fix-net
