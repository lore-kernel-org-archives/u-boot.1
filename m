Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED61E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CCCC86DF9;
	Tue, 26 Sep 2023 16:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lpeR7A9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC7B86DCE; Tue, 26 Sep 2023 16:15:38 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D5B86DD2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso309314739f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737728; x=1696342528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geYaUv4VmenRR2WsCe/YeSsWmS604ImD8Ds2Dz74OJc=;
 b=lpeR7A9XTQWdZHSRcxCx9OI2byY/8Ec9ux+dCbZHb0kF6kbVnVHcdGTKZH+RJ9AIcU
 rKljLshg8o9n4sd4COF+OKijLPBu811hQABHqE8nM8TbLJhq89arU0vgKW3pYVhi5DTn
 a1qRiLu+5dejpLh/i7Z1KjxoKw3fxsd6HdH5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737728; x=1696342528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=geYaUv4VmenRR2WsCe/YeSsWmS604ImD8Ds2Dz74OJc=;
 b=Fnqn7DIyQt6G/O/2k/DMqQtWLhM26M4MeX7ZACd18peck0JhJMcebKgPxqAEHIZS+z
 fozwgtJ8RUr1RHYbiI4RxNGW/QIz/12WYvqYQrTCbKQcSJrP8J+to5dvrZfzX6n5y+Y0
 LN4TZEn8jEqBpUnhEsJkP0xHGlfMMpxt6h8eTlJCrrOyYYYxPv7niq2czx8BuKVkhTTr
 YdVk/FjDnnibb8lM1AxtvgUhZzujddAOe3oOZuyFhmBB+97JH3u48PMxlOvX0chOZJSP
 tXqqropslvAb93MJHAIdHTTRcYEuNUsa1/TBjp6yplzydbcd0v2cs2DX1IrvotqZi1v2
 adQw==
X-Gm-Message-State: AOJu0Yy9MWPgDOAzS97FmK0Qs54Mvunc24ZFhBMjYE4hSbSIOZCGl4iw
 dqBU19XkPF/OfIROGkPQC9sXbbBQpN2jfcMkxCA=
X-Google-Smtp-Source: AGHT+IEB71qguEj+5h0ng7BX5tNBjYwiB+NKfxHNmWGutdHQJeWydXMmdpO99P3EzR3U/ut/bgYYxw==
X-Received: by 2002:a6b:6f01:0:b0:794:d7e8:d239 with SMTP id
 k1-20020a6b6f01000000b00794d7e8d239mr10846224ioc.17.1695737727836; 
 Tue, 26 Sep 2023 07:15:27 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Andy Fleming <afleming@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Priyanka Jain <priyanka.jain@nxp.com>,
 Stefan Roese <sr@denx.de>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH v4 05/44] spl: mx6: powerpc: Drop the condition on timer_init()
Date: Tue, 26 Sep 2023 08:14:19 -0600
Message-ID: <20230926141514.2101787-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

This has been tested on qemu-ppce500


Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Mention testing on qemu-ppce500

Changes in v2:
- Explicitly copy two maintainers as it seems only Mario was auto-cc'd

 common/spl/spl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 5cc86288145b..4233390d7de2 100644
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

