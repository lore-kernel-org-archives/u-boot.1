Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CD5C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F6388E21;
	Wed, 21 Aug 2024 18:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eb8WdeeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 616AA88E24; Wed, 21 Aug 2024 18:19:44 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5404788DF2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7091558067eso3031607a34.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257181; x=1724861981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H15pf+CnaZS8PjkQ+VQrE1LaigVIod877FLN8S4r0Wc=;
 b=eb8WdeeBrN7n/TbBvZWJfJBQlw2lNhKSbMJWHxzIM1ZIyKH8kkMA+W1QS1ntkuWhml
 C6jMU7DqSeKmWFH0Xa83SAjG3Z6ZGS1koOKf1NL3j1uUno5ZKu0wPL+H9jF/ijKkxzjJ
 149m3hFS/Ecmp7QZY5//tfB1tTSdOiTV3Kalc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257181; x=1724861981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H15pf+CnaZS8PjkQ+VQrE1LaigVIod877FLN8S4r0Wc=;
 b=twsYa8mgcDXpY+lO4HlAbvy7nsXa0s7Eq02RFmHF+qcVL+CUj17z45jnf8CO3hzW5w
 HN8H7MlWZfnP0QtWy2pYQnBEDkNvYP0r4yTOqf5D137ptI3iJnIcJ5eWABuaBXuFsKm6
 2HB7hLlqv5Hh3XGwf37++Y//ont8i7gvq6m82f6gNfnzYdnNn7vAirlN0MlNm6mFb5YO
 ncdGs6TnaCKKZ8d0xk4BwcFv0e7ykdEKE+DudtcXpsq8HBIgM+JxSJIYaw6k56iCJa2H
 Rb90n0SZXxHG/25uaspy9T4PP18weogiigAF50rxmMFZFIEzle5VRK1VhRickUhCZU1S
 naEw==
X-Gm-Message-State: AOJu0YzQpph5YuMkTw6x6w5nFtznbq0+aJ6qF5wfzvphFxIcIQRqlTiV
 OJpiXJMcUSsCMQ6UacYEa7ThGu2Zpt97+urrSeTYHcpYJ1khBxMfTkyA8zofBpV97t+hijwmGSs
 =
X-Google-Smtp-Source: AGHT+IFxI8fd6BZOU0NHF4ZS+GQ8hDuxKUo3lVJPH7ZuWOySWCgFhOlyqyh3SIroF16oWBhnHyW9gg==
X-Received: by 2002:a05:6830:4184:b0:709:419f:2ae7 with SMTP id
 46e09a7af769-70df8a951f7mr3428733a34.29.1724257180672; 
 Wed, 21 Aug 2024 09:19:40 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 06/35] arm: friendlyarm: Avoid accessing global_data fb_base
Date: Wed, 21 Aug 2024 10:18:58 -0600
Message-Id: <20240821161927.695717-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

Use the new video function to get the framebuffer base.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/friendlyarm/nanopi2/board.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index c8cbc5a15fa..b32dfc6b570 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -11,6 +11,7 @@
 #ifdef CONFIG_PWM_NX
 #include <pwm.h>
 #endif
+#include <video.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 
@@ -492,12 +493,8 @@ int splash_screen_prepare(void)
 					 ARRAY_SIZE(splash_locations));
 	}
 
-	if (!err) {
-		char addr[64];
-
-		sprintf(addr, "0x%lx", gd->fb_base);
-		env_set("fb_addr", addr);
-	}
+	if (!err)
+		env_set_hex("fb_addr", video_get_fb());
 
 	return err;
 }
-- 
2.34.1

