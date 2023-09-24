Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECE0CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E99EC86BF4;
	Sun, 24 Sep 2023 22:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="htV44ymc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D23AE86BEE; Sun, 24 Sep 2023 22:40:40 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06B086AE6
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1dd1714b9b6so725851fac.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588037; x=1696192837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1etzCB7wzHco8rhhRZj0OHXqWXCYq+noOMNDO4v9yI=;
 b=htV44ymca/rVgoKeVK+cOKOmaeUeB/HG+RWymp7d6bXyTwJZFgO5pwc3dfIvQwk76x
 Ll9nKg4qONFnkpejpakQ9zPvLTfAudXTFpkVwGLF0OAyZ2QNeIWsKs4IlAxDYZMf22RD
 yM8zOryZks7TT8kIYNZ/6Ae/RGhkdjKdevefM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588037; x=1696192837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1etzCB7wzHco8rhhRZj0OHXqWXCYq+noOMNDO4v9yI=;
 b=Vioj8g66YkH21Iq/pzlEwiCMThLvygg3lhr8sO70lg1HZImH/w0auT7Wvyf7Suf0hx
 XdJE3nrt6CHPMj2dTyzMvSPPGY5bfmlApGq9zuWIISZSM11DTjs4Ta72m4cS1tKpCJ/1
 J+3esF90yQFZGNT8v0Qo072THXWxbOKEgg3LejIEbYAooI/amoahFb6ZjSzRjjsku0Sy
 6pb+Oz8hC87fj2ovQtmOEvBVnOGVwXpyBle1pFIeA/vu0icPhjL0JveQa6vSvlcBHXQo
 +Y9lSwq4XDvLduw5zKpq4Y23vefh80TzuVFQSBE1UJbnW2hgtCcclaodwgBH03t1IsnX
 mpyA==
X-Gm-Message-State: AOJu0YyGYStQT1g0OlsZm3botCfsb1tQBNmYdTvCwP/r4TKpb21zLwtX
 K/XQoBMYWFKdAku0Lg8QCf/+63M3+hm1Z5hK9ZM=
X-Google-Smtp-Source: AGHT+IEFDibn2oNzpqXURxmaOjIXEXC5wZ3gpWBYGMPes4YXIBW8a+lquIA2T/B+xEI3p8+gVEmIbQ==
X-Received: by 2002:a05:6870:2391:b0:1d5:b9e1:d363 with SMTP id
 e17-20020a056870239100b001d5b9e1d363mr7886777oap.14.1695588037326; 
 Sun, 24 Sep 2023 13:40:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 20/25] video: Allow use without CONFIG_CMDLINE
Date: Sun, 24 Sep 2023 14:39:38 -0600
Message-ID: <20230924203953.1829820-21-sjg@chromium.org>
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

Provide a fallback for when CONFIG_SYS_CBSIZE is not provided, so that
the console can still be used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/console_truetype.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 0f9bb49e44f7..8186b5b49f0b 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -124,7 +124,11 @@ struct pos_info {
  * Allow one for each character on the command line plus one for each newline.
  * This is just an estimate, but it should not be exceeded.
  */
+#ifdef CONFIG_SYS_CBSIZE
 #define POS_HISTORY_SIZE	(CONFIG_SYS_CBSIZE * 11 / 10)
+#else
+#define POS_HISTORY_SIZE	(250 * 11 / 10)
+#endif
 
 /**
  * struct console_tt_metrics - Information about a font / size combination
-- 
2.42.0.515.g380fc7ccd1-goog

