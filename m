Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92EECE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D4B786B97;
	Sun, 24 Sep 2023 22:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S5zlYPLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85D786B7E; Sun, 24 Sep 2023 22:40:31 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A568F86A43
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79fa425855cso126018139f.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588028; x=1696192828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kc0gKTaQl9Ewiua3cr7T2fBVbNA86Vr83NFW8YNIXPM=;
 b=S5zlYPLoE+ZU+O69bABm8qN72URIojN6zo3XPpRcyNU3lbsHiUjBGJtRy3Pq8re0sL
 Jj4oBOTrbi7BWo6w0Bm6fTfHEbp91RkSNRqwNm+wAySRLxn379A7tyIGcsQzNzJQNIo3
 Z0b2oJhyuApSjzasTxyE29oT+GOJErREmroWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588028; x=1696192828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kc0gKTaQl9Ewiua3cr7T2fBVbNA86Vr83NFW8YNIXPM=;
 b=vcLDIn3FBG6dEjeEXFBvlcL089sR9RROiIKay63tL5xAPVKM+dCnQBjJjTf9b+n7hi
 9AV2bXV1+Y3m6c1rBkMDhBHS8dqZxMU5xPTus+7XzSdbcKhdWG4Amqoj3Wg/EJJxyKyg
 nvYTtkrDVadEkoAPLRKHpNlQWvRJ8f/Jw+7crZzZYTpgTPnO3htyMbT5i3oCrd4BQkvD
 nU9q/12gQSKpXbO9imT4msy9kZvel8VUC+ZLA5JN0NBioJjzw/K814zU8RWUqcKZJ/SM
 HmE+GefnfgATmIeWBWJ8Yw7f1gv9+xxrlruZdi0WCEorvIUaQwdUrUT1uOyFuLAXxy1b
 JjWg==
X-Gm-Message-State: AOJu0Yw93P5RP5vqp6BCpEglNAxd08RghGsp3cFhPRxDh7Nn/DwrYG5V
 AN1tA/u54rub2jz4eRor1geHSfmNTwjt1UKJjSg=
X-Google-Smtp-Source: AGHT+IHx/OmLmEfuLvQK+fD2lAPqzZRvS4PPG2K8WhztyyIPNoK9GvfHaJ8hJtHuoUoex/8uQ0nNXA==
X-Received: by 2002:a5e:8e49:0:b0:792:72b8:b8a with SMTP id
 r9-20020a5e8e49000000b0079272b80b8amr5751051ioo.18.1695588028323; 
 Sun, 24 Sep 2023 13:40:28 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH 09/25] cli: Always build cli_getch
Date: Sun, 24 Sep 2023 14:39:27 -0600
Message-ID: <20230924203953.1829820-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

This module is used for user input with menus, not just with the command
line. Compile it always, so it is available even when CMDLINE is disabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/Makefile b/common/Makefile
index 5c1617206f07..15ae46f596d0 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -8,6 +8,7 @@ ifndef CONFIG_SPL_BUILD
 obj-y += init/
 obj-y += main.o
 obj-y += exports.o
+obj-y += cli_getch.o
 obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 
@@ -37,7 +38,7 @@ obj-$(CONFIG_SPLASH_SOURCE) += splash_source.o
 obj-$(CONFIG_MENU) += menu.o
 obj-$(CONFIG_UPDATE_COMMON) += update.o
 obj-$(CONFIG_USB_KEYBOARD) += usb_kbd.o
-obj-$(CONFIG_CMDLINE) += cli_getch.o cli_readline.o cli_simple.o
+obj-$(CONFIG_CMDLINE) += cli_readline.o cli_simple.o
 
 endif # !CONFIG_SPL_BUILD
 
-- 
2.42.0.515.g380fc7ccd1-goog

