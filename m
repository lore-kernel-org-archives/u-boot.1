Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED31CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B48288FDC;
	Wed,  9 Oct 2024 03:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aNgPhOR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD74D88FD1; Wed,  9 Oct 2024 03:50:32 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9493288FDA
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a34802247eso35608025ab.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438629; x=1729043429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozWclEMjbjwC5DUkOadZ9YV74jfOgwNTVjadGrUpDaU=;
 b=aNgPhOR69LSje0iftpUHcwmoy9tgDeZUH7Z6TSdAUqMj+bgZP+z36sXQTTBU53dYG0
 zvk9NlBlp5u2LFHmXFh7U0Zdj8FerwYWXDCV93Q82rCKDdv3tgkO91mXGzGdjGSeL8Xr
 ZP0AEkPflx2+5JuaDhXwk8RYx96j4Yt1XrFx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438629; x=1729043429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozWclEMjbjwC5DUkOadZ9YV74jfOgwNTVjadGrUpDaU=;
 b=bmlU/EW/H/t3n093DqLPlVYkuYc2yg6bOpSZVdxW5IZIFuukjyIxA3mo8n6LnhPzSp
 PDTS6SEIPy5lmQBtJRaFz5OxLatBWp5SuoVPRV1+WZI/21eGRfC3a5pc4E4pETkUEKDc
 P2IlP3yPDqvHRzymjHBhmhUhqVgilH6T5/DMK3afAiYc0TRL3zKaJp4RUWcdhu54PuI7
 0HgTE+Fjv6L6AXATqEoDvyMMQaPpeWM/FlGlylj5bRBrwCO6Z0WWXAZmvd+ybQzpa7r1
 uPSsqsZzF2BVL6iwIQAizZhta9nJN/Cb5DaGZl81X2S9OCaraP7DtyUqdT9dPk+Z1hSN
 Vl0w==
X-Gm-Message-State: AOJu0YzUoTSrLm6VsdWBnntbBJdImF9fZGdlf15VPoRJdEGvJgGke1xm
 oQgrhcTgbY6Ro/upZXoqZljsMFGEkQrHZHkNNFjgGAOuI/3+Eydzr5OxKFCS3W2xY63pgYqBdsF
 OLw==
X-Google-Smtp-Source: AGHT+IEWMlqcS7ybBDkWzxYg1wPkbsG4M7BwdIT07He2y94OOnsuR/hV+X4hMCFHcT4Q2vNEGAT+ZQ==
X-Received: by 2002:a05:6e02:178d:b0:3a3:9337:4ce2 with SMTP id
 e9e14a558f8ab-3a397cda124mr7447155ab.2.1728438629199; 
 Tue, 08 Oct 2024 18:50:29 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a868967sm20677585ab.67.2024.10.08.18.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 18:50:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH 1/6] common: Fix up malloc() comment in reserve_noncached()
Date: Tue,  8 Oct 2024 19:50:13 -0600
Message-ID: <20241009015020.25817-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009015020.25817-1-sjg@chromium.org>
References: <20241009015020.25817-1-sjg@chromium.org>
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
2.43.0

