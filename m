Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F6AC8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10B783164;
	Tue, 26 Aug 2025 00:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X3cMgK4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4F3830A0; Tue, 26 Aug 2025 00:34:38 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B5183145
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1b0c82eeso42212915e9.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161275; x=1756766075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yacumy8YfM9dKlnGJVc39RDJ3RjLkDx99buPn5M5CAo=;
 b=X3cMgK4dGTKv9Hhyf2aTkaKIoAabjxUf5sMcRN3Hio7+XOi0Mk55WQw7mltxkfjl4d
 ZU23ZosyvWryXYfkKiiqklN8zD9ZkOYP3430VrspRBSxumVBzOHIxuA/i6H0n8otAqIr
 PA0gDxXAHu94zAO7tlDw2jiiA+2MOBD39Kp4eRkRnwa1hPjGr1AAwrROC4fUsgTO2Va9
 R/WR/f611Tae16FPKb0oHmGQAzFsu+humgJDav5wOP4bMmmcSgpiBI0db55CuTfq67N3
 J9Iy5EsIyq2A/l9cXEx6PKYGoeUnicAStcScSc58C/2+o6oHNi3BSr92lDIcgiIeSs3J
 a+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161275; x=1756766075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yacumy8YfM9dKlnGJVc39RDJ3RjLkDx99buPn5M5CAo=;
 b=Wok4HCulzFRIEvE3W6ycygMlE1CfKTbozQ+Hd1BBgTzKiEwuZYSBGwFxZN7eReQ5hk
 X3/a9YdjnqIdGt/OPxVtFQ9sluWc1mQDItjAOFEapRrVQ3kKn0F6tvOZgJh+XDI7c3Oj
 mhq049pyorvaYbuZ9oJ9LGLfXjkUm2WKcVvOLh0OBSN4/vUfK1T7WN2rkptd1oFthXun
 WJVyOEQ2xo7Jm9WZMLbm/73kPWNJ6Z+RunO21bhfdrQL+hRQkkU/rtignIbAInx3uiH5
 Kao/I38W32gCymhaZI74+81n57AecQYkjEhSlBwZM7vd1nIYwJ6l6A5rm3sjnnx6NzKo
 eN0g==
X-Gm-Message-State: AOJu0Yw/uIdt7GSNVzSVbooC55+NKMIE1ls6oDs31Fo27zAgBAGNfzrc
 u5mi730gJIkQa5IdbsWy5Wsyof2TCy2PcsEhnttwogxN5KAG6qwu1uNBlT+eifrlQ2E=
X-Gm-Gg: ASbGncsIGgXNyAuZbNVk/tlty984I67QepXUVysAhcHI6mVixFAlJsQkgrehfVDSnEM
 czcJj9KCJNW2r7c2oqRjHi8FwpqB+U/qDUjOZSFEm0sYffkmL6eWaFf3gr3TUEksfwQU0xsrJyX
 5APZY5DzCJc94O3CazKJUhO5YNiplGBHEX2Qxh/6658w5jFA50GuSVKXBHOSSOdFfxtzRaF4M4m
 RUP8zJcBOFJqxmlEmMlrMUMHNqzoj3vLuL0gSv4GcOpUtDGHyel9viFRkQsy0xSryOV8AX451aC
 7MnI1LWiVZb/Xe5K926v1ZEoOhKJ0YWLPj96E3bEcK+PwFBTAvqbjDYgK5AQmpuBKOZIRpfSlE2
 psOtZhHvA7aqZHPxoPN0wNnYlelXx
X-Google-Smtp-Source: AGHT+IESlqhYBs3Ts0aKNp0oWTifvI2hOp9s6xQCJoy6MqCPVabcgOTm17GiNb7bBu2D3/QKsLkUdw==
X-Received: by 2002:a05:600c:1e85:b0:456:1006:5418 with SMTP id
 5b1f17b1804b1-45b5179f0d8mr122359795e9.13.1756161275166; 
 Mon, 25 Aug 2025 15:34:35 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:34:34 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 08/10] doc: Rephrase to be more precise and less confusing
 (build)
Date: Mon, 25 Aug 2025 23:32:35 +0100
Message-ID: <20250825223251.674591-9-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
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

It was "... doing the same build ... will not trigger a rebuild".

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index dafac017f0e..6b382942ac8 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1294,7 +1294,7 @@ shows an error::
 
 One major caveat with this feature with branches (-b) is that buildman does not
 name the output directories differently when you change the configuration, so
-doing the same build with a different configuration will not trigger a rebuild.
+re-launching Buildman with an updated configuration will not trigger a rebuild.
 You can use -f to work around that.
 
 
-- 
2.48.1

