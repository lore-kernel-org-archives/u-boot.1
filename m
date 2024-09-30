Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9095ECF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C94F88E24;
	Mon, 30 Sep 2024 03:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T+hWS5M2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795C488DD4; Mon, 30 Sep 2024 03:50:17 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C069388DB3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a0be4d803eso12306785ab.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661012; x=1728265812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36vFZOza+LM0nQqmS9ICzxhOs0sKTWoKuUc0cf1FvJ0=;
 b=T+hWS5M2J6ZjwBbx9uBjz79H9mYoSQVeQ7LZ9hccUP/h0e0qJmoK3xIPCSTYeDI7eI
 4oSmmjF1ZbUSqEJ5ynTFXlPC3LpOPqlR9MBcGmILHV2KtvNGftvsQqP4XaAX6MRDkXRd
 FPbLO53MHQ4Yr6UONL6pwsswLiZJhEup2NA9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661012; x=1728265812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36vFZOza+LM0nQqmS9ICzxhOs0sKTWoKuUc0cf1FvJ0=;
 b=kbB7cdQL5krHCjj2rQY0zset8Qyqn5GXr91ApDCPAvhhy9w45f0tdquoGwhi8i/DHs
 0I4jrI14ZRjMBXWMIt4sXrmFGWO/GJf5hCL/RRPVCxbcayVBNc5z7v5VrSYn/tfecu5S
 cn6w7mLRHV9L+oEoKhR7xKXMHrEnuqLyPhciuRlqwVU/ze9WsdqRNkc9YJrPyjjplvJi
 S7o8UP+bUJLhMgL/ptmVUZ8RtYnquZmMF1oFn4CGyI14sYH4zWBiqy5d/6YHfyqF3HR3
 h3uZ0y4BSkd+bm6TMryYWALF/ECh8VIu51PaBFXn+HT8CZSL5rw3SR1sYBTBEtrPMRGM
 nlzQ==
X-Gm-Message-State: AOJu0YyQho4u7KS6rRMtCo8s0TNlEGYkMhf9rUJ70zOSFE30RhzYcTvz
 YVDhY1BoaNLwCbTuxJuvFSlcaGjmDpoHHEhkZKsr636Bj3rmkK0yTvz6H6C510SP+FmThcWnsa5
 ZpA==
X-Google-Smtp-Source: AGHT+IGE+yjAEZeo/0+BmQK+SoMhiYvpR9sbvwORYqt3ipctOQK6eT8ZoGjoijVJsYUcf3NG8xcj2Q==
X-Received: by 2002:a05:6e02:198f:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a345179e49mr81785295ab.12.1727661012304; 
 Sun, 29 Sep 2024 18:50:12 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v3 06/33] stdio: Make use of the SERIAL define
Date: Sun, 29 Sep 2024 19:49:29 -0600
Message-Id: <20240930014956.1434060-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

This is always enabled for U-Boot proper, so simplify the condition
in the common Makefile.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Move earlier in the series

 include/stdio.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/stdio.h b/include/stdio.h
index 7b999a519ba..e7325795533 100644
--- a/include/stdio.h
+++ b/include/stdio.h
@@ -9,10 +9,7 @@ int getchar(void);
 int tstc(void);
 
 /* stdout */
-#if !defined(CONFIG_SPL_BUILD) || \
-	(defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_SERIAL)) || \
-	(defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD) && \
-		defined(CONFIG_SPL_SERIAL))
+#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(SERIAL)
 void putc(const char c);
 void puts(const char *s);
 #ifdef CONFIG_CONSOLE_FLUSH_SUPPORT
-- 
2.34.1

