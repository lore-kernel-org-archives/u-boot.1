Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AE5C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7450A8882D;
	Mon, 15 Jul 2024 12:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G5NKfpPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A7588820; Mon, 15 Jul 2024 12:14:02 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87FFA8884A
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-427aeebaecdso4931685e9.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038439; x=1721643239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jon6/z+lIgH7ru10lNPYXh8zVegmWDy75NeAA7ZEOiY=;
 b=G5NKfpPWis6onE37mgpeauehXHnEN0K3fY7U3vtLuL4F3OJ+zwlyKnPsPpGMAjav0t
 mq5hZPEU9eN03Fuq4EjXGMaC7wJr1ybQEofFHYDkQF5ucBo99ubU9i2U2EnvyDCJ3M+r
 u3f+UX0MJm8Y7SMsXWUV1tnOxOZceHXJj30PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038439; x=1721643239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jon6/z+lIgH7ru10lNPYXh8zVegmWDy75NeAA7ZEOiY=;
 b=QGnsdJvhkvacbw1Aay2xIve1GwEwGeT2IUdqRu9JBkTJFPvC80KNt1L9Ll8BwLzSty
 PQagjA9nWgF0gE4yHmWbTswh7ve9C+CaihcUSbjJT72WyvaOjJPYFx89yyXiKauvXXTM
 UnPgGOhaJejUIw4dSut3idfwdDMD6/TRz5qa6xaKO9cPq3j/yW9Ps3WoGVhL8zX2hOPr
 CESSqtB/7HR/BCOkwUzeySFNSDSwtHuRJLVESMfAus33kHd/TgxcE9R24Net3Dn3F0KG
 t/IqgsGnZgrvBRRbgFINeBzYb5IKLYjC+3Omi8TG/a2PhC5Qm2g7u6sF1R8P4jv9kypR
 obrw==
X-Gm-Message-State: AOJu0YzFYJEDCYFqUzNX29Qo0+N0eg7oxq7QGawyBkiFGesegabxgPea
 H9C1p9zVc3EOL5ceuK8Ki+X/6e3xAFLqIt2seQJRJ5efEYHvR1UYttnpLHbtSqXM8RqgOn1u808
 =
X-Google-Smtp-Source: AGHT+IH+0CPWvsC36jDVnwwKYBiujb/NtRaRLX2cf54Qh6Z+pjA7e02UTtxmU4E/rw8vYrNlo82gnA==
X-Received: by 2002:a05:600c:2284:b0:426:6416:aa73 with SMTP id
 5b1f17b1804b1-426707d89d9mr122940705e9.12.1721038438765; 
 Mon, 15 Jul 2024 03:13:58 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:13:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 01/13] MAINTAINERS: Rename BOOTDEVICE
Date: Mon, 15 Jul 2024 11:13:42 +0100
Message-Id: <20240715101354.97895-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715101354.97895-1-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
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
---

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

