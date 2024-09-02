Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B12C54FC6
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B8EB88A0D;
	Mon,  2 Sep 2024 03:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AgUdCXhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D95C881A5; Mon,  2 Sep 2024 03:18:39 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F03E881A5
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39d2ceca81cso13273475ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239916; x=1725844716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nihB5JTut1wXXZyckj6IkA6SsjHcOQm8TrSUt0edjXA=;
 b=AgUdCXhV19P6LV+BB7lRpCHh4pmwgbiZk0Nf7M/mufSNnT28Bi7Zl9Us4ZyH24RIYT
 1oFhCGVIJvMjMlIRfQ4NCeHJPw6vAERwqHojHMgrZxifn2thaNdHajFHXAbJZqEOVywT
 /hV9+B7cpQfIXh07UWlO0wZ122yRaF3Ad9vCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239916; x=1725844716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nihB5JTut1wXXZyckj6IkA6SsjHcOQm8TrSUt0edjXA=;
 b=v0Vd0DFcGw60AIRya95zPLfO5gjnuCN83p4ZDJl5l84hWzSc1duquvrH7Z/usHqpPf
 Ostgsbh0iTO3lm4MzUpneArRbqaIfO3NZzTPA7BarUUzsixyj/W0MaCTT3M6FygoQzQk
 FBX4tUE+IgBfb0e8UhkIzXqb7nSjMvQQgU6L8qZd6J+dhSxagx14z0yKHHFY/vJDL9Xu
 j79FyNfLQcHIjsojlKwzYeklCG2w7ejDZOJOx+YOtp+upPP+9slckJojTLzIMWnJYdTp
 0bcJ7uv+iF1MKu7u/2H2nD7IkcRHL8m/hF59TS9K+s8ya2HkaWeMguC9OsDG82NN390g
 BqpQ==
X-Gm-Message-State: AOJu0Yx9107Ai6GCqnDhuJcNTbmIYIPdq54RLjyjzLfqrg+SPdArCFsB
 6VtX2WMcHs0DHusNX7Gv/vjlIjPkr0v/biUJXP5W9lthRfWQoilnghLcUGDyZBPEbASVlaoSfs4
 =
X-Google-Smtp-Source: AGHT+IHTf6DZHnmNbsYJy+IvDfBkrTiCQGaPB1dX9VWKVdNhayc09ioytp03IbNM0VwhNqQMDzSotA==
X-Received: by 2002:a05:6e02:219c:b0:39b:936:83b3 with SMTP id
 e9e14a558f8ab-39f378fdc20mr142202705ab.9.1725239915778; 
 Sun, 01 Sep 2024 18:18:35 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 02/14] efi_loader: Put back copyright message
Date: Sun,  1 Sep 2024 19:18:13 -0600
Message-Id: <20240902011825.746421-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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

This was lost in a later commit, so add it back.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v5:
- Drop Fixes tag

 lib/efi_loader/helloworld.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index bd72822c0b7..586177de0c8 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -2,6 +2,9 @@
 /*
  * Hello world EFI application
  *
+ * Copyright (c) 2016 Google, Inc
+ * Written by Simon Glass <sjg@chromium.org>
+ *
  * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  *
  * This test program is used to test the invocation of an EFI application.
-- 
2.34.1

