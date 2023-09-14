Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA2AEEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C7B870A6;
	Thu, 14 Sep 2023 18:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PX+XRVrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5BFE8708F; Thu, 14 Sep 2023 18:56:40 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A628870A1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34961362f67so6032265ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710596; x=1695315396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tu/zMa1wej5KcoNGQJhJ2HquiOcbmCo7LCgZ2V4lbYU=;
 b=PX+XRVrYtLGBACG8aFX6tRPtMeWoWYusWLcMgiKYoCCxx9Mussf7kZFf9sxE+brepI
 3q72nfp1ecufm52M87xhBVSJLAVaQsWjDWWpF1s8PU5AexMC/B3L028yJ2RLYXdi3Pw7
 g9zBhx25ikAvanBWlpXIdZF1H0+4aTVlO1S7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710596; x=1695315396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tu/zMa1wej5KcoNGQJhJ2HquiOcbmCo7LCgZ2V4lbYU=;
 b=CFgQXL4NKJH1zJfrVkX44La0atSeIyLZ528GIG4LyIQCq1+iKe7Psy+5huJKVQI8xd
 SMQOv+YiIafy0SzUaV7K85OWkrMub7nT1EJHey6A3Z7aIDCY43d0DDfdV3tv5JWy2PZK
 lIxD5J4fRAF96R1EoqvQXuvtcm0TUW+hTXqXLDmZoyk/egJFl3fJRZZYWrbIq1dhgYTn
 uVf2IvwNqIarG74XzyNtzheu0HvMt3b5TKO0kTsLG5hXKHGwl7DGsm//7DzaLu6P48Js
 RnRiCMUgR4jHM3Z0/3nnq7x22cP72R2tcfMwDYbHyKDjXN77NNr9PDIzaRBkHhzYVSSg
 8sKw==
X-Gm-Message-State: AOJu0YwkXC/QK7/vaksI94sdw9yTvSCaRWVfRnvNIxR9UI4WiJJQgyOt
 z8VkRZZAZwsT8lFlcpe5qngFzl1glUFZU167sn8=
X-Google-Smtp-Source: AGHT+IEdnn1QAkFwNz70HaEJqX5fGr8VmXR53if1xtimWCrr2y/9EZI5zn3o1GhY8b1KHF+I31fP/A==
X-Received: by 2002:a05:6e02:17c9:b0:34f:963e:4484 with SMTP id
 z9-20020a056e0217c900b0034f963e4484mr2159266ilu.12.1694710596669; 
 Thu, 14 Sep 2023 09:56:36 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>
Subject: [PATCH v5 06/21] test: Move POST under a renamed Testing section
Date: Thu, 14 Sep 2023 10:55:44 -0600
Message-ID: <20230914165615.1058529-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

Rename Unit tests to Testing, since it is a stretch to describe some of
the tests as unit tests. Move POST there as well, so it doesn't show up
by itself in the top-level menu.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/Kconfig b/test/Kconfig
index 6e859fb7d0d..830245b6f9a 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -1,9 +1,4 @@
-config POST
-	bool "Power On Self Test support"
-	help
-	  See doc/README.POST for more details
-
-menu "Unit tests"
+menu "Testing"
 
 config UNIT_TEST
 	bool "Unit tests"
@@ -110,4 +105,9 @@ source "test/lib/Kconfig"
 source "test/optee/Kconfig"
 source "test/overlay/Kconfig"
 
+config POST
+	bool "Power On Self Test support"
+	help
+	  See doc/README.POST for more details
+
 endmenu
-- 
2.42.0.459.ge4e396fd5e-goog

