Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DD7C369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A11088CE1;
	Wed, 25 Sep 2024 14:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UaAW0c1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E15688363; Wed, 25 Sep 2024 14:58:02 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA1688C4D
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a910860e4dcso479394166b.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269075; x=1727873875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sz/ZOT7ytDV4v/a4UL7/PrWJUf3vE5YjIJm4k7cpkzI=;
 b=UaAW0c1S5uvxun4Xm9syCyTbd/9CzzWs8lnqkFXOiQKDpMJQgjr3Wuvcpx14oqB5a5
 PVTn/LNZ337hkQZfRQ3hewDrGjQeT7hgh+nUf96c/9UDc4rNemBxAETTaqXDze35w/Yy
 pAW99SHGp3RT4+8o4yZiNU7CQzm46xFQOsbEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269075; x=1727873875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sz/ZOT7ytDV4v/a4UL7/PrWJUf3vE5YjIJm4k7cpkzI=;
 b=nz7LlIuRsTjvQ9d6V4CQVuTE2cxdsZx6m5Iem7jEc3iDBWtGC0jPy2L8slzcxcoqwh
 3O3yi4TuFiO7zjsNQW+ca6n6yF0iKR89jiHrSMBup57uTh9BuxLMln2cAaxkRepZP2Ac
 itWVD96UkQWvL3qTmiMajUdF2AyN9SZoUH4LGHVWd0wrL6xTDWD6ywlWp7Ik+VH3ZhLk
 IoXsw/IURjxci4xkS0CmNzWjA8xDlfNhlls2pvfKhqfi8JbGoCP+eZNiHvnYlVDAsC9B
 czyCehgMCpgB8UMlDQwTfI4xtnvzaTn89OG5qLM/Lfm7noIUU4G7lddNYB4DBYor9lPC
 8mJw==
X-Gm-Message-State: AOJu0Yz/a4R0keLxHieVJ6EQ8jl9JVlYXmHgW6ey8wpuVHlL73JVSTSD
 vL9TcPmOdBBcK2czaNoKVhJmP/7psbYJfOh/lZ8KAwsnac3qQGB9qLAFSnwknEUd58PINlHnNCE
 GFw==
X-Google-Smtp-Source: AGHT+IF4IGrZdNf9ZvkWMt5hIVUI/EyNYeiMT+OxfIEEIzwpD9I53T1pGhb0Flauf3atUVuibo0EjA==
X-Received: by 2002:a17:907:74e:b0:a77:eb34:3b49 with SMTP id
 a640c23a62f3a-a93a03b4aebmr276968866b.37.1727269074706; 
 Wed, 25 Sep 2024 05:57:54 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:57:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/19] lib: Mark crc8 as relocation code
Date: Wed, 25 Sep 2024 14:55:31 +0200
Message-ID: <20240925125622.197915-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Mark the crc8 code as needed by relocation. This is used as a simple
check against corruption of the code when copying.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/crc8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/crc8.c b/lib/crc8.c
index 811e19917b4..bbb229c3892 100644
--- a/lib/crc8.c
+++ b/lib/crc8.c
@@ -6,11 +6,12 @@
 #ifdef USE_HOSTCC
 #include <arpa/inet.h>
 #endif
+#include <asm/sections.h>
 #include <u-boot/crc.h>
 
 #define POLY	(0x1070U << 3)
 
-static unsigned char _crc8(unsigned short data)
+__rcode static unsigned char _crc8(unsigned short data)
 {
 	int i;
 
@@ -23,7 +24,7 @@ static unsigned char _crc8(unsigned short data)
 	return (unsigned char)(data >> 8);
 }
 
-unsigned int crc8(unsigned int crc, const unsigned char *vptr, int len)
+__rcode unsigned int crc8(unsigned int crc, const unsigned char *vptr, int len)
 {
 	int i;
 
-- 
2.43.0

