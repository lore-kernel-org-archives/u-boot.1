Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67529CD493C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB1786D81;
	Thu, 21 Sep 2023 03:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K2fQg9Mx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 522F986CFC; Thu, 21 Sep 2023 03:57:55 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B576186D4B
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7a8b522ae46so195501241.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261466; x=1695866266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nU0wv3ZU4lsIXf9E8uGrdO0PZg5qar3W+sqdidBtN4=;
 b=K2fQg9MxEkDX9jlmgl7cVplwf+aOktfHar90fzxPCCGZmoa6ctMBpswvDQXqB0EQmY
 KQBbTsZz9yjNIL7c8c1wNhJJGAYvow4oLBT3eRk1/zU/FAQaUFsZKghF7h031VhKTdoV
 RqEZ9O+HPMzDVvOCwj8Yo5n+9NAAtsXZkhMTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261466; x=1695866266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nU0wv3ZU4lsIXf9E8uGrdO0PZg5qar3W+sqdidBtN4=;
 b=bB2tR83/KFpM6qmex9iHzdyhlioOUNROqyddbw2GtXT1mCdR+9HmY6Mk+/K5blishL
 ju61EP1h40lgGbUU5qx9CKmMO/04VwTuy654lXSeaoRy5jK5f9U4dKk/5/JYVJz3BpNl
 L+fi74p4YhSTzUl1/9BhtZ8baHMsXYqvLI3+KTG+I29RYmwSMxN0fcyFh6hPf3qCPERU
 bScFokY+nujq31iXs5ts8/zcFkYf0dPGqvnx0SgEx+EyDUxHJi+BQmNvDmT/c5mtxt6O
 s9ug5vFTBKRktCbjucaojhEJ36K/5Uonip1Vgyg6uwO2gvzNb45fuwIptqT2szDXP7Sa
 +YZg==
X-Gm-Message-State: AOJu0Ywno27KF1UvR6m8H/60/HqpEQZ+DVIs1PaVRcpJvToZ3eLaDi9o
 fl5PjV9RH2/yQiA7cJXcPwpTPyNVyRPzRnEpisI=
X-Google-Smtp-Source: AGHT+IFZwC9UsJ6PpLaezZPbQ9no8EBIUdw+qeuQrLA7g+WZL/Uwj8ck2JvpSvBv1oo4P0pm1Z/BUQ==
X-Received: by 2002:a67:f3d0:0:b0:44e:bc13:b761 with SMTP id
 j16-20020a67f3d0000000b0044ebc13b761mr4949578vsn.14.1695261466309; 
 Wed, 20 Sep 2023 18:57:46 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Andy Fleming <afleming@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>
Subject: [PATCH v2 05/32] spl: mx6: powerpc: Drop the condition on timer_init()
Date: Wed, 20 Sep 2023 19:56:54 -0600
Message-ID: <20230921015730.1511373-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It doesn't make sense to have some boards do this differently. Drop the
condition in the hope that the maintainers can figure out any run-time
problems.


Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Explicitly copy two maintainers as it seems only Mario was auto-cc'd

 common/spl/spl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 90e6dc2b5c9b..80a3a3f1516e 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -762,13 +762,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		if (spl_init())
 			hang();
 	}
-#if !defined(CONFIG_PPC) && !defined(CONFIG_ARCH_MX6)
-	/*
-	 * timer_init() does not exist on PPC systems. The timer is initialized
-	 * and enabled (decrementer) in interrupt_init() here.
-	 */
 	timer_init();
-#endif
 	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_init();
 		if (ret) {
-- 
2.42.0.515.g380fc7ccd1-goog

