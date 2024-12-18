Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1A6E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 02:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCBE8027E;
	Wed, 18 Dec 2024 03:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K5RQ2v3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02D8E8021D; Wed, 18 Dec 2024 03:55:52 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41058021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 03:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a7d690479eso49270205ab.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 18:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734490548; x=1735095348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82TzHW3siJQgzez/++9O7m+yGcNW2CNYUyL9lLQzNJQ=;
 b=K5RQ2v3uDytd1jsNoTr5Jedb5zj9VP3d46TJjvD1Aow5YGkH0MOyamBeNthSi2K1EO
 KSY/3hBVODV8EGSW2OBkHui0jTnS7fYfUeSfSUs5eanEWietMqekcsz2/EgGQYkojwjz
 i5EjMGLzdAO3FEvHZLMRA71WilDwff3d0kHkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734490548; x=1735095348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82TzHW3siJQgzez/++9O7m+yGcNW2CNYUyL9lLQzNJQ=;
 b=sUQNC0NQEwz/tR9IjP9ctWU/3ZRg2AhRCAEG61BAtivh1VqvNtYLKxv2+Vpkicxz7B
 vS1GNu+09ETX7a3ifNRadDvwGp7rgNp1bFX0oy3z4QFw8Aqgj4De4Hn881oehrlcVqvx
 oq3zszHDrpTnl0RzkDaRqbXx2Zgg+scDZj5EO4NTrVheV2bSSZ1E5IIPZ9YDqXc0tDLb
 t3bn3Ftj5waQWRNp5y6r/rvu5anJgrJPfT7hNa2aeikG1AdyjJNHiLPWq8g/7sZ5Jcyt
 QjYiv5E5n6BGTeR1+JclMfKAhgjVmhPJpftD836rYioHRs7yyzFV+1inc8QIz3dZSexK
 /aRw==
X-Gm-Message-State: AOJu0YyMbo6ZO+pY7dtOum37wZwxajyduPfNDOUEafBydV5dqBOfIwxX
 QV0G0kqV5m9lZ+F0MpzNyZkrZMNOJ9s1SqiAj/AEHNGCsmGG8cSlUMbbmQV47UU/4IYAUw68ts8
 =
X-Gm-Gg: ASbGncvt8aRscbXo0wI9H35+CjlhxHqUM4aD9r2dV9cSRJjlAGLm1lFlXUY7M6JFwqA
 dLiFtOwSfGL7ZjWE/MobHYXOTmLUhB5uw55Dk1GAvA6ZwGfKs4f61tsERJbgySF+vNj0wT4L99X
 7mRq541yXwIeJStQpijaunWlWoMC8vt0A9Xws8h+vsphDBFjlrzVZ67RR5aSgdnG5Jt/6e8ub86
 JxBz3iVlGWZQVOMGx7PnuGbYvQSIRJGQ8etdAITYU/7Jl2Cb2TJxPbnn5KtTWbLPCj3NtSCXC6P
 MICKQtvgiU7+4jmoGg==
X-Google-Smtp-Source: AGHT+IF4GpWA5Pg8bgy+3r8gbYnIuHTmF/ws3KRP8pJQYncUrhppaKeXadS5NLzYV3ttVYzZQp7VBQ==
X-Received: by 2002:a05:6e02:138d:b0:3a7:e3e3:bd57 with SMTP id
 e9e14a558f8ab-3bdc437aa75mr13314235ab.15.1734490548048; 
 Tue, 17 Dec 2024 18:55:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b2475aed5dsm23816525ab.1.2024.12.17.18.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 18:55:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] gitlab: Resurrect the Beaglebone Black in the sjg lab
Date: Tue, 17 Dec 2024 19:55:39 -0700
Message-Id: <20241218025540.3025522-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218025540.3025522-1-sjg@chromium.org>
References: <20241218025540.3025522-1-sjg@chromium.org>
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

This is working again, so add it back.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5fa417e79c6..3d778d66fe4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -644,11 +644,10 @@ rpi3z:
     ROLE: rpi3z
   <<: *lab_dfn
 
-# bbb has a hardware failure 30-Nov-24
-#bbb:
-#  variables:
-#    ROLE: bbb
-#  <<: *lab_dfn
+bbb:
+ variables:
+   ROLE: bbb
+ <<: *lab_dfn
 
 kevin:
   variables:
-- 
2.34.1

