Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9867C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2672686582;
	Thu, 31 Aug 2023 05:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UN4OVjO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA1CA86592; Thu, 31 Aug 2023 05:53:37 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102F98657B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34bae4fa2a8so1595885ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454012; x=1694058812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WO+9eHcdHHOY/zTW24p1VoopIgBo+UX0W0hid8s97jo=;
 b=UN4OVjO64VJVZPvux0tLE+8R/aWJS7yChFAztTjC00sOSp0SKzjqXHyTpnReAHOgxC
 934CLod2AC/wDPEb9CuZWbn6i/fFSjEOdcjCRovlXyp1hsRkbgDhiWWk7NAsXuDd22Bb
 mxQawgi5Z1lTYWj2RVTgYb+RsJ7RJpRfoxpuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454012; x=1694058812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WO+9eHcdHHOY/zTW24p1VoopIgBo+UX0W0hid8s97jo=;
 b=bp3H2pfE8hjeIgNiF6VKrRSlUXZmxZk5siLMpD8qnkyYpI57YlXRmnO6QtjYA+8T2u
 gXgGXi/2cvscL03kZlxRXcf85HdVmZ+Ds3jdm7cc7TY1oMyMSq2BTrZ9J8MbohB9wEmy
 gKjpn2gAI+oXl52QvMEsDsKBd2kluVU9s+kznVTTzrs306Rt9LEo+aFNSnIU7Y26/Pqd
 5XZ7NPy8chdLtzBldCAtu1S4eAp8guPSjr+evtjoa1LqQGrdU+8m72CF5CNF9bO7sXBO
 8lNYJh0Wlu9+ReOZZ1jZrhGG8NYFxLeRbpM159bYjeImnZcUYixI7rzMcljr/Oj4Ur6K
 x+PQ==
X-Gm-Message-State: AOJu0YyVd64HjyHbYKdISyegpMxjO0r1HWf5gsczVFbRTKGzsIByndZ+
 K30kH0P/dnNEe91W19Z2QzB96HzsXvHCJdDf5fY=
X-Google-Smtp-Source: AGHT+IE6SInYvCYfFK9O7DEvB6f/lDfcH7qogB4f5UhuiZJumaET1uNfjS4Z5+IGnPrPQMZg+jSkLw==
X-Received: by 2002:a05:6e02:80b:b0:349:3503:253b with SMTP id
 u11-20020a056e02080b00b003493503253bmr4350206ilm.17.1693454012699; 
 Wed, 30 Aug 2023 20:53:32 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 03/19] video: Hide the BMP options
Date: Wed, 30 Aug 2023 21:52:57 -0600
Message-ID: <20230831035319.2316665-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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

These appear prominently in the main menu at present. However they are
selected when needed so do not need to be visible.

Make them hidden.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 0b09bd68bd13..844531a59eda 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1169,12 +1169,12 @@ config IO_TRACE
 	bool
 
 config BMP
-	bool "Enable bmp image display"
+	bool # Enable bmp image display
 	help
 	  Enable bmp functions to display bmp image and get bmp info.
 
 config SPL_BMP
-	bool "Enable bmp image display at SPL"
+	bool # Enable bmp image display at SPL
 	depends on SPL_VIDEO
 	help
 	  Enable bmp functions to display bmp image and get bmp info at SPL.
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

