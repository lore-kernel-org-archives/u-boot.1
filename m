Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5A3D3C544
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F225B891B6;
	Fri, 18 Oct 2024 05:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JdJ+7brV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57489891CC; Fri, 18 Oct 2024 05:00:56 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDDD8919F
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83a9be2c0e6so70884139f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220453; x=1729825253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FUxevx1kgAFJv+wY3lwHPasHzhJUdtYXpwsbkEhLBI=;
 b=JdJ+7brVv+mZ9XZFjHheSD5hW8wpsw86JVlZD75dZX/TGT2+668aTYbG1jN4gzgb8P
 kNrnyRuAhwdxH0AI0UHUQYShV7UciWgNxGUGYR79k5esbOSBC0qYJYW/xYA4e8C88XZ8
 S0wnUEZgPbPxtT1Be1qOLUHST8TrUarzEirCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220453; x=1729825253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FUxevx1kgAFJv+wY3lwHPasHzhJUdtYXpwsbkEhLBI=;
 b=U7GCi/fKdEFAa0bKIXndasBvrIzPvwFaDVx8cRL3MGR/QAoHJX/iqtiRfcVgG0nu4T
 02zf5UAUGL766RHT9w6xw9mBWHh9qGi1zgEjtn/weQYHRhlFn0gO3JtKCQQk8gsCUYnM
 3AfvmrcjugUpGN3eEpTc6e1x6KwuCdwZhfUlzjL+oeVClUbUkVG6wplwLxCUOmUupkd0
 cxf0a/2kq/c82o92S2F0U7Be1+iOuZWFYPlUWTrXNr7GmGbLHy6xUZ27mr1NBzBX9iRo
 q9n3na35pwBMh8Nh+JJi2CBTLlz1JiMvFhSlLEOTqFf+n8njmhXw+h1tAJMGrtyAcn0T
 e4Eg==
X-Gm-Message-State: AOJu0YyzN8uaHc/gTgwTqcFBSHKf6ttNYCGQvW3aw5fk6+a2gE/mtGwp
 i6zUD7TnD1Vw5YyrMN9cTkc300hsz7UFRxZVMfvXGp1bxuQVeurA3XW//FcG8o5XK50ovXkWbew
 =
X-Google-Smtp-Source: AGHT+IHf5MsmYlQDDhfmmkRNWCeIeEy9C/BIDzFqxqjKBiJGDuF5e4r0SqIXAW2D9rKQYM3Zj2kKCA==
X-Received: by 2002:a05:6e02:18c6:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a3f4054723mr8130405ab.10.1729220452783; 
 Thu, 17 Oct 2024 20:00:52 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83e6dsm192499173.39.2024.10.17.20.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:00:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/8] membuf: Correct implementation of membuf_dispose()
Date: Thu, 17 Oct 2024 21:00:24 -0600
Message-Id: <20241018030027.842749-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018030027.842749-1-sjg@chromium.org>
References: <20241018030027.842749-1-sjg@chromium.org>
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

This should free the pointer, not the address of the pointer. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/membuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/membuf.c b/lib/membuf.c
index b13998ccdbd..695d16d051e 100644
--- a/lib/membuf.c
+++ b/lib/membuf.c
@@ -384,6 +384,6 @@ void membuf_uninit(struct membuf *mb)
 
 void membuf_dispose(struct membuf *mb)
 {
-	free(&mb->start);
+	free(mb->start);
 	membuf_uninit(mb);
 }
-- 
2.34.1

