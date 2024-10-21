Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E38D0E6C9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C78F892FD;
	Mon, 21 Oct 2024 10:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Timj63th";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5122889309; Mon, 21 Oct 2024 10:19:41 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B16D892E5
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so5213184a12.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729498779; x=1730103579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RySU9SNJuPTnJAJohFIk82sXUfaym1q6BUu8QV6Bfi8=;
 b=Timj63thadiQQci5hZlhjEP0hGYalLvBJBOrcrgxAVZ7YvFgjrTEAESMxxCpkJhgBi
 FoTdvXHTNOD9xMhXstGL8oeU+57J5cnZEw7LmeOYpGJBm8tY3e+8xwAknF9rs0XeiJfl
 Xm3HJin13vtVnWleWXB/VkpLUuEWa65s5B5wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498779; x=1730103579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RySU9SNJuPTnJAJohFIk82sXUfaym1q6BUu8QV6Bfi8=;
 b=dYOKPz4lDxW4s3jwUvmVE6YqdN/3416fAd2ys3Gi+RaZB++3WT2FbYSfwDaaVtMMja
 vuR2llmXG9rtmCn+J4kM3Towr0eOsDcnvfTvGUsvAJlSuQRPbcB4pSQzDfqGUw2QAeWf
 AGGa5PcPnyiWHEq5kJluz/RLLq7GJS1zbStGnLXuKNcJ5+KHCpsZMlFDb8ozsxVlkLtZ
 GWZ421nVrgzLiyW9sZgfcUfX2HuyBIejMJlIWCEyE20y0GrGwMO4Vl3Y/uDGjB7q/OoH
 ifwK+pKDe5iCQwh4FS3ELIbocueX+RseBH5d+CUEAIhZoKXZRBjuFl/V98VmY65qrXsN
 vjIQ==
X-Gm-Message-State: AOJu0YzL1hIKFsmokspi+JDrgPbMznC74nmgdFVbg6UefQbxkfuEc65e
 BGPUoKKcMLmepUyF9LqpxCgqq2saEYK+deuBUgL/otgQ2+gsgSB41BtEzu/y8T0HAU5JR0ycLDY
 ZWVTd
X-Google-Smtp-Source: AGHT+IGEHQku2IuTBM1v0kCnIKNUCTGsko1EFC385yDScdxZq3gBfFZx0b0HstA/4sfKUAr2ERvPEg==
X-Received: by 2002:a17:907:ea7:b0:a99:46aa:69d3 with SMTP id
 a640c23a62f3a-a9a69cdae20mr1179010566b.53.1729498778637; 
 Mon, 21 Oct 2024 01:19:38 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm176057766b.73.2024.10.21.01.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:19:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v4 1/8] common: Fix up malloc() comment in reserve_noncached()
Date: Mon, 21 Oct 2024 10:19:25 +0200
Message-ID: <20241021081934.289473-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021081934.289473-1-sjg@chromium.org>
References: <20241021081934.289473-1-sjg@chromium.org>
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 common/board_f.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index f1bd70fdd6c..a87411ee350 100644
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

