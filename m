Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD93D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31F4893F3;
	Fri, 11 Oct 2024 23:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HRrUYH7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CE3893F6; Fri, 11 Oct 2024 23:40:40 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDFB2893D6
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a3b0247d67so7497085ab.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728682837; x=1729287637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rL50ks0y0EhyXTrxGqLT47sxa2NDBH9aWXpHla4eNwo=;
 b=HRrUYH7KSTLdVpvgpJgsrKi06NNqELGv+yBnLUFERSvKqkwj6hnJLFGBH0PGQmUZjl
 bKHH2MioR1WhbBux4rgFyM1w4DFPBuuaVqtssnBRv6lLvWiuCfCcI5zC5dV0BFWjvnu5
 udPWmp7mFklXWkufn9dQp6VIO8H5u/Lc1Ooxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728682837; x=1729287637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rL50ks0y0EhyXTrxGqLT47sxa2NDBH9aWXpHla4eNwo=;
 b=myXL1LclkvqYRXRHz/IGlu7Ih2kHL4/6D2q49a93B6SwnfmmyT3HHMSxhbsayZj13L
 6rbEQkOYWtZay+b7KbvCBGLhqR6pXyTqWNlyBJW2UxwDmyB0Kl0BC0jiziqJI1cYrLl9
 s+K13apMW+VKA+M6zTEX1Kg7YJyF87QTK6LLjeDQqbsFTE/sezALliQ0OKNEec1jYK8u
 b8hgP3GrEup0tK5E5581kTM0yMmQHGVhoF3eT64KZng7UZy8Tnub1MBkmc0OmwTfwRq5
 dk7M9vP50zcDRR8a49ZsETwbqHqna2NLXMA8T3IgxK8DiqDXgobH3OPxesXhOVCd5A3G
 QaHw==
X-Gm-Message-State: AOJu0YzUmIIJ4/uubMG4uafhlJtswtSSCOzqHZstt88GXpdaUCcTWmxs
 vC6UaXbXno3NxodKDopbmJAIfFXEg+Ff9+SqIf3/hpq4lIhaMcTzK47LaDo1YfJ/uuTYjq6DOjE
 KhA==
X-Google-Smtp-Source: AGHT+IFZDE5wkQCqrMYdcI9u3eC+KuwxMzAjpTbUX82efXaWDxh8tXPDPrXqo/5ft9SJ3/b4SYGLJQ==
X-Received: by 2002:a05:6e02:1446:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a3bcdbb5acmr7585325ab.7.1728682837360; 
 Fri, 11 Oct 2024 14:40:37 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a3afdae0f1sm8830475ab.11.2024.10.11.14.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:40:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/7] common: Fix up malloc() comment in reserve_noncached()
Date: Fri, 11 Oct 2024 15:40:25 -0600
Message-Id: <20241011214032.760072-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011214032.760072-1-sjg@chromium.org>
References: <20241011214032.760072-1-sjg@chromium.org>
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

The function name has changed, so update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 154675d0e40..2e04a47b546 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -501,9 +501,9 @@ static unsigned long reserve_stack_aligned(size_t size)
 static int reserve_noncached(void)
 {
 	/*
-	 * The value of gd->start_addr_sp must match the value of malloc_start
-	 * calculated in board_r.c:initr_malloc(), which is passed to
-	 * dlmalloc.c:mem_malloc_init() and then used by
+	 * The value of gd->start_addr_sp must match the value of
+	 * mem_malloc_start calculated in board_r.c:initr_malloc(), which is
+	 * passed to dlmalloc.c:mem_malloc_init() and then used by
 	 * cache.c:noncached_init()
 	 *
 	 * These calculations must match the code in cache.c:noncached_init()
-- 
2.34.1

