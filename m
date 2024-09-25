Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C19BC369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA8EC88D16;
	Wed, 25 Sep 2024 14:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UTNgYvxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1951188D2C; Wed, 25 Sep 2024 14:58:20 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1649788D0C
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d3cde1103so634112866b.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269089; x=1727873889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHxGGzE48n9hnpEd5lhIabo3bkASk5LUsAs6F+WJDb8=;
 b=UTNgYvxmrmYz9O/ZAf0yroegn+v3ZJtx0TPH4Gna4QXbJmZjO+Xi/YjPqeiWhNxWGS
 1ViB/3xNSin7AcI+h51v8o63rmWPNk1WyC5A1SREgb63FX0k2vg9IzfC3rkOB+0o4MV+
 I7ukWxJe5i8pgiHQnULFb9fnAQ9DCkqIqdHVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269089; x=1727873889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHxGGzE48n9hnpEd5lhIabo3bkASk5LUsAs6F+WJDb8=;
 b=ja7utzkJk/9FrPFBetTXQt0tCBOa3aN5C2jqcJBgubjiPKfYcGD7D3WmTYWywbaCyQ
 lHPZlREt7P68X7VoD/9RkNiXTzqkX7FX1BsXyl4wN8Q9M+mt4CxS9SQJiQPQbQnqDQvz
 xTG8gDO1wX/2+R+2632fV07F4sKPhQWe0Qv2ZhlcSFFr3TY122f12xVx1p6I+b7vmlnX
 RYGLtLKXKenVqp5PILIAS9imS8QD6CqUceJwxO/PoRMV+mb/GZ3XKbMlg/bYuQFtRYzL
 OC0uiNS1nNG5fyuizCnp3PtqouEA3zfNbKv5fe7ojWAX4cFQobxoGoVvL/YofZ7Kiiuy
 EOsg==
X-Gm-Message-State: AOJu0YwMkyRwXcIKu7x0Ax1Sk07+ej8atMiIFQ6R4L+YmwvykgqJf1gQ
 f3kYmfyi8YH8oI0LAKa9AOihw5mZJ5K4t12++KSp+bWiz14C4AHyJLHbGNrne6wwd8MV/AvRIlZ
 njg==
X-Google-Smtp-Source: AGHT+IHotJf4salv9U+lSlGxT4PvtIV6Q/zwDoXq03ejba3eo6QkwkoT8TF9MTi+WPptWvdz5UgYIA==
X-Received: by 2002:a17:907:3d8d:b0:a91:158a:a900 with SMTP id
 a640c23a62f3a-a93a069bf67mr285129266b.58.1727269089157; 
 Wed, 25 Sep 2024 05:58:09 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 12/19] spl: Record the correct name of the next phase
Date: Wed, 25 Sep 2024 14:55:38 +0200
Message-ID: <20240925125622.197915-13-sjg@chromium.org>
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

This is only "U-Boot" when in SPL. For earlier phases it should use the
correct value, so update this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 623e486c210..2466b98f5a8 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -280,7 +280,7 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 		spl_image->load_addr = CONFIG_TEXT_BASE;
 	}
 	spl_image->os = IH_OS_U_BOOT;
-	spl_image->name = "U-Boot";
+	spl_image->name = spl_phase_name(spl_next_phase());
 }
 
 __weak int spl_parse_board_header(struct spl_image_info *spl_image,
-- 
2.43.0

