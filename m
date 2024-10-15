Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393BED216A2
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB62885D1;
	Tue, 15 Oct 2024 15:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZU+b1Hl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18EC883D4; Tue, 15 Oct 2024 15:33:12 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD0888365
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8354cecdfd3so217025639f.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728999189; x=1729603989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Igmve9qA3lMrhqZfAyFyCGIJytUeWsMmlGs6BJ6XcW8=;
 b=ZU+b1Hl5GI7WoYuCt9/0XulF2WfpjXJGc1ZkR7Pb82I1s/32qU+F/VmGQZxF1I1A7S
 xTL7vXInCerlwvPwVvAu7EinvZuIiFykpfEaJQsFe4xoj9unpC/pNKzaDjnXQthhOaVy
 /Bbe+i8LwwXxg1Lwkxlp2s4lA91y2nkasJtMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999189; x=1729603989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Igmve9qA3lMrhqZfAyFyCGIJytUeWsMmlGs6BJ6XcW8=;
 b=Mg3ZikUHU7D0Z1vZxcpXmrUSe9GeOiLwnfwyavANKokXy9RJaIRFdYOeRH9oV5O7Lc
 bcrUWISpkCB7MEtFuuO5Ciu5usQXzSEjKIwDuXIDYDA6o/8HcRnNV6BJIl+CWMTVJm3K
 MxJqgb6+kxQ77/tPL+h1Qix1wOCTQ34OFF+j88DLZSA1dEgYdyjg7r+vnz5jQUP93Ina
 9PNfgtvPLwio5EykEaBaIzHN1FiEZa3EEVtUasCs2Oj9AQDZnOf2cf/DwGiBNbr5G4B8
 ujhpcgiy/0la6Sm059mZEEIP2ssxijutCzBaNw8pJ97ipRsOvMCI7BHtjmSfmmJwbiH+
 Hekw==
X-Gm-Message-State: AOJu0YwlrAvRGBD55UvCKw6H9lJ6NNI8uz5v4z1Hsbz8MGO98mHVUeAf
 wgdGHtqtWdYXGU947YBE8xuRyVq4IUoZ4taxgfrHjIO5ZMo8h7EQEXCRiQvGs6QtdAbMIxdP36B
 Qbg==
X-Google-Smtp-Source: AGHT+IEmcuHgGzm6sKMkX0TFE6LJf/Jg928G4Q/ZDtKvmNPObj0AQx08NKAy0MPn2OYIgOZf2Q11jw==
X-Received: by 2002:a05:6602:487:b0:82a:7181:200f with SMTP id
 ca18e2360f4ac-83a9448a03emr41226539f.9.1728999189168; 
 Tue, 15 Oct 2024 06:33:09 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83a8b28bed6sm29794939f.8.2024.10.15.06.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:33:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v3 1/7] common: Fix up malloc() comment in reserve_noncached()
Date: Tue, 15 Oct 2024 07:32:58 -0600
Message-Id: <20241015133304.2874735-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015133304.2874735-1-sjg@chromium.org>
References: <20241015133304.2874735-1-sjg@chromium.org>
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
2.34.1

