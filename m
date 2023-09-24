Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07431CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6DF86B6B;
	Sun, 24 Sep 2023 21:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P6MUAf61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1442E86AF7; Sun, 24 Sep 2023 21:26:03 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A7C86B03
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so108469439f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583553; x=1696188353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCiekGWLHuuzOj1fsEP1OUNt+puW/FfVJmCSUW1YIV8=;
 b=P6MUAf61y9v1KljGL9tW8lXp4TeJOfHyxg7oRPSGJEGxj1zqM2WICHkAMl20rD51t9
 hL5fkzB5g4ivaEJn+fNxlbSmQZ7jzW+UUfiFjTbM6eLf0OfagpFIXs2AjHIilNzpSPOK
 7Ko2o4JipXlLbJj4dWnXMEkwzHQRnAu4R3Qbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583553; x=1696188353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCiekGWLHuuzOj1fsEP1OUNt+puW/FfVJmCSUW1YIV8=;
 b=m3J671bgFd6gaiV+L433HDLwLS7msQzbJLXhuleF5wkM3xsHlOw9vj8i32dFpFkcCh
 KH14DyUB2HAuX76PoRCmFnWYQaJo5XbZzna2UtIKzo7pIi2h9jDH6AK097MTo4hACWvX
 4teEx+vhObaIJBJV9BucIkgCIKgEB7nNwaClB69a3urDlfcf8r+XluM68Tzyb369UaV7
 SUVowOYbBcJW9FC2+kC2vmU4s9J1shgWdHRqv/KfVfY4DwHHRrfxqk96ViRBmeHlfquh
 M7yjuP9h4q4OVz9eXmjqF6G3ZnIPV3zTepH5UyuYec9EySXrOPeHMvYbcpmJ/S1Yt3KB
 bMFw==
X-Gm-Message-State: AOJu0YyWFh6NJg7BynYwPCQKlgBthzHiI4F8NKt3HcMNuaHzxtLC8w4C
 UrpgQFDliFqsRKRXMUChOM2d8mlkMRzv/C0usxY=
X-Google-Smtp-Source: AGHT+IFFjxQAnPW/fX23w7xdyPtmSqMkjBWlutuLAziDE0kgjnOPdqXattRKJq7qUGehGBRCRu7N9Q==
X-Received: by 2002:a05:6e02:1bad:b0:351:c42:f6a3 with SMTP id
 n13-20020a056e021bad00b003510c42f6a3mr7479754ili.6.1695583552854; 
 Sun, 24 Sep 2023 12:25:52 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Andy Fleming <afleming@gmail.com>,
 Bin Meng <bmeng@tinylab.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>
Subject: [PATCH v3 04/38] spl: mx6: powerpc: Drop the condition on timer_init()
Date: Sun, 24 Sep 2023 13:24:49 -0600
Message-ID: <20230924192536.1812799-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It doesn't make sense to have some boards do this differently. Drop the
condition in the hope that the maintainers can figure out any run-time
problems.

This has been tested on qemu-ppce500


Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Mention testing on qemu-ppce500

Changes in v2:
- Explicitly copy two maintainers as it seems only Mario was auto-cc'd

 common/spl/spl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 5cc86288145b..4233390d7de2 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -762,13 +762,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		if (spl_init())
 			hang();
 	}
-#if !defined(CONFIG_PPC) && !defined(CONFIG_ARCH_MX6)
-	/*
-	 * timer_init() does not exist on PPC systems. The timer is initialized
-	 * and enabled (decrementer) in interrupt_init() here.
-	 */
 	timer_init();
-#endif
 	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_init();
 		if (ret) {
-- 
2.42.0.515.g380fc7ccd1-goog

