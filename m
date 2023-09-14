Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12187EEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F31870BF;
	Thu, 14 Sep 2023 18:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jHVKsuDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA1F870D2; Thu, 14 Sep 2023 18:56:48 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2877870BF
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34ca860051fso3565135ab.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710605; x=1695315405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1AF2DO1qcoKyiFUz7FVhILhkFjlW/eqrjkultAIwok=;
 b=jHVKsuDtcbiH5W7wZkSUv869YDl1paXCt7bCRx1sK2Z1CPi8oBcD6PcZu5pmIXXV4P
 SClk9PvMh16K2uoGJiJwEZjWHrd8g8hjIdiY+lJEkMddPJ8tQrGkxvZiYam5LruZe2IS
 vMlxmDE9KbnMZaYc5WeN/UTiw8ixYWJEKGS44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710605; x=1695315405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1AF2DO1qcoKyiFUz7FVhILhkFjlW/eqrjkultAIwok=;
 b=K9XCdaQQmLbQiNONyR+CHGvfSqOWuD+ct+TvENc4e3EwxNsuSdHu2yyvySqx//v+oY
 3GsvO2nknvGcJ9cDhAMUBOg/lxPAbPRLDcsFUdzdSXya8ZM4e6xf689V5PksGJt6bTvN
 m4cDJGjPyP1TW6ldQWccNrmq/2Gccew1dl2Quhbk4KlRXCC178HzuWYqi4biaHb/SC0x
 izQJprZydkLkormwlUSdQBcNrz1ij5+JakxJIUPm5qKqE/Z1aErbTBa01JFYbIjx9f8A
 Aiu1urbXjJOcLv7Cf10+BmM1ssS2whRAjFcnMHGxN+9sqamWpwflQVFpeCwUgzRofJFQ
 gy5g==
X-Gm-Message-State: AOJu0Yy/HQNno1cC2VYJ5ZDrD7+G1Bs/6xfSWLYMsLWZMyhLaeawh5VD
 IvGmcaxN6lXQ6J1rYu38uVT0nKcGRzz8byFXJM0=
X-Google-Smtp-Source: AGHT+IH05dBoL3sRSmvxCP6a+FfjDRz4LzvS8X5V9tMvZXtD/SGq0mFOmjnziNc3TlfzEHsHe25cAQ==
X-Received: by 2002:a92:cd83:0:b0:34c:d0d6:5137 with SMTP id
 r3-20020a92cd83000000b0034cd0d65137mr7412791ilb.8.1694710605502; 
 Thu, 14 Sep 2023 09:56:45 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 14/21] Kconfig: Move SPL_FIT under FIT
Date: Thu, 14 Sep 2023 10:55:52 -0600
Message-ID: <20230914165615.1058529-14-sjg@chromium.org>
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

This option already depends on FIT, so put it under the same umbrella, so
that it appears in the FIT menu.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f564cb8dd84..9b09d636d05 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -140,11 +140,9 @@ config FIT_PRINT
         help
           Support printing the content of the fitImage in a verbose manner.
 
-endif # FIT
-
 config SPL_FIT
 	bool "Support Flattened Image Tree within SPL"
-	depends on SPL && FIT
+	depends on SPL
 	select SPL_HASH
 	select SPL_OF_LIBFDT
 
@@ -195,7 +193,7 @@ config SPL_FIT_RSASSA_PSS
 
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
-	depends on SPL && FIT
+	depends on SPL
 	select SPL_FIT
 	help
 	  Normally with the SPL framework a legacy image is generated as part
@@ -243,7 +241,6 @@ config SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
 
 config SPL_LOAD_FIT_FULL
 	bool "Enable SPL loading U-Boot as a FIT (full fitImage features)"
-	depends on FIT
 	select SPL_FIT
 	help
 	  Normally with the SPL framework a legacy image is generated as part
@@ -341,6 +338,8 @@ config VPL_FIT_SIGNATURE_MAX_SIZE
 
 endif # VPL
 
+endif # FIT
+
 config PXE_UTILS
 	bool
 	select MENU
-- 
2.42.0.459.ge4e396fd5e-goog

