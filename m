Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBEEC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3B888967;
	Tue, 16 Jul 2024 09:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iFMcCxH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752C88896A; Tue, 16 Jul 2024 09:04:30 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FB788865
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-368255de9ebso226406f8f.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113468; x=1721718268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7Ec0yVOybre4Ge8swbGUjOd4w0BWmN+imKPhpvgVtY=;
 b=iFMcCxH2VN4l2L6M8zMsr5N6wpzTHjTbTS5ifZyUnZ1jwxIMu8gPRLGVSmS1aKMqSz
 kqRCxwy45WCsgGxxiLqeTQZO/WPD7Zj6OeJzTy1NQCSyR54MXW3igD0SRHgbgV2DGs3d
 VhS26+M+89w3B3uJXiskuQVv/4L9L7Qhc467g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113468; x=1721718268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7Ec0yVOybre4Ge8swbGUjOd4w0BWmN+imKPhpvgVtY=;
 b=sP3DmE8MgcZV9pWkNtsSxI7d8yC6O5tj/eeKPEXJC7xbUSkkesEkteDnjHLMEuKhRi
 nWs6VacXv0eDSL+5ygQqhElvGK96KE26Ev9jkzwa59ZAXoaivQILnsLKnVeESs8KdOgZ
 ZfNtfdwO0t2Y3y56xkfLB8szi37Y/oQqk4ZJVQRQOZbRcFTmU3cHrBG/tyx6VEkcG3pI
 T/Yd2o5AuICnR2FiFDthha35oYnSh0ADNueXp0VskmVbhEqD3gXJIzZF3PsfXneDr/AQ
 04Cd5aA8QvoSkRVbVCaddFqMk+djTt688xxUO4dtZybjcXiUFROtfQGfmneQrlxfSkrb
 NCsg==
X-Gm-Message-State: AOJu0YwmVunVqBepG5UzINi66vFORGW8keXUwzHXUbCwg6MaxWixyqnK
 cJnb47i1H+n0eBaDW2kObfzKajixvLuh6mAIemCDPdgYRNJLpfavLf3TUwrmpF1rYbQREUNRc+w
 =
X-Google-Smtp-Source: AGHT+IHicM9xDy3HZYChaHTRAuAMyuxTbfTpWI/IAn71crGVXf4bquGAVXlx6o48xFxHWTnJJMEXAg==
X-Received: by 2002:adf:ff8a:0:b0:363:b3ea:7290 with SMTP id
 ffacd0b85a97d-3682753b33bmr655376f8f.20.1721113467822; 
 Tue, 16 Jul 2024 00:04:27 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 01/14] MAINTAINERS: Rename BOOTDEVICE
Date: Tue, 16 Jul 2024 08:04:06 +0100
Message-Id: <20240716070419.1897560-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716070419.1897560-1-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
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

