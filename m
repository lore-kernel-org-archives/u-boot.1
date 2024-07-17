Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB396C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A326588A40;
	Wed, 17 Jul 2024 10:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RuL6vp+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E9D88A2C; Wed, 17 Jul 2024 10:31:18 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34275886E5
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3680667d831so2867180f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205075; x=1721809875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doeX7YLpa/knGGNSjHOU/gG3kYEFsbgr+zRaP3YwJf0=;
 b=RuL6vp+WY+hZnExNnm6jUGy6gRMIABo7bLqTSbWQitMUwZjtdDeh5O/Z+5yMv0OekO
 HlC4zRJdJNf9hbmF+Lk9jIQ3Lu3YApP8DXK4L5oR/1DbeEQ2AgGsUdaSGtq82gB8yl+q
 gRFFS/cIZy/RdJNpoYC+bG/ppjYRCTiIsB4MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205075; x=1721809875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doeX7YLpa/knGGNSjHOU/gG3kYEFsbgr+zRaP3YwJf0=;
 b=Nrw7Rmvu+33RuG+tg+dXc9HJcf3Qta2yQIs6+UkMoglzUqOrK2OO4jnPZsUbPorBTu
 zngOI13Dc0ozdty3G+5c8gvmJ6GWOA/0aq/03C9KBDqX8qU9qQNcFofP0FlAl/lEm40Q
 Xicikqgsktr8tn0iQJEiCDUGVAMKXiAEFWXTYlme3dgxCXykbF3WpFliUJ39uW4227yk
 8txKxrcb5o9iv2zGdBpfbkbSJNZFlaya4uiS+hAimVd2H+jlJ5LnyppCgn5ORD7yOxWE
 bm1ud05N4vXqGmXo046vBMCkk7i6v4W1FhaTG41Xn0Vye6y1z3WQ2OO/D1ze/2a74vAq
 4Qzg==
X-Gm-Message-State: AOJu0YzyBSYNb8ROm7zVk5xvf4qhx0pAPIOQWMdkVaxqLzlLWpGUURsP
 Hs9+rwluV6OK3AtjuxsX4dMjUhSdDX4c2PrkZUVfChihZBaIvJbTpOZS2nMTPsfaG6qw0ErcNIg
 =
X-Google-Smtp-Source: AGHT+IGMOYuNshDWcAWeicZ8NtN2cVkA4z5IF6PZqob/r4jmqw1pzj6Hs0t72i6CUE6cjcc2OW5Jjw==
X-Received: by 2002:a5d:52c4:0:b0:363:7bbf:efcc with SMTP id
 ffacd0b85a97d-3683177854bmr662223f8f.62.1721205075489; 
 Wed, 17 Jul 2024 01:31:15 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 01/14] MAINTAINERS: Rename BOOTDEVICE
Date: Wed, 17 Jul 2024 09:30:51 +0100
Message-Id: <20240717083104.1963431-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717083104.1963431-1-sjg@chromium.org>
References: <20240717083104.1963431-1-sjg@chromium.org>
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

Rename this to BOOTSTD which is the normal name for the feature.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c6de3a1d84..9bee9284cca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -918,7 +918,7 @@ F:	drivers/block/blkmap.c
 F:	include/blkmap.h
 F:	test/dm/blkmap.c
 
-BOOTDEVICE
+BOOTSTD
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	boot/bootdev*.c
-- 
2.34.1

