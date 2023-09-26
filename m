Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D8EE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A5986E33;
	Tue, 26 Sep 2023 16:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DcNmDMXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 259A786DEB; Tue, 26 Sep 2023 16:15:49 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA68186DFE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fe6da0049so19317939f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737739; x=1696342539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9tD08a7Va6oCs87yzlcGSo0etHLz8x5nJ2AVM6mTwc=;
 b=DcNmDMXRznAXrJjKR/Vnte/w5y+usWY1B39FwOhjzmMVH00qiD6fsARGLkxV1i9n3s
 BPg28OTFznakIPYvhZb8O/xYemsS5SJyotxE5/3N1UtYKBcO8xWgbh7kJqCtQfWAZjFw
 tjxB+wgdCLC7nvH2J0zckyZ+dVUC4N7v3JEfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737739; x=1696342539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9tD08a7Va6oCs87yzlcGSo0etHLz8x5nJ2AVM6mTwc=;
 b=Plm2YeZtjweZD9yVpx9sP7J5QwBKMavXhbCwak987AVvV67+OCkc3S0w2YcAfG/Ggh
 QBnin67k1V/En+cWaw8UyASlvCDgYT91CqVU57KTA0FT2GMhwP9wAlalsxelOxSNQO9y
 656uE/5VFUETBZ2Z2S4Zr8z8gJ/LjdFI5+uwXJ6wgcYlo4ZsJ6ml4mGR0adIRsx3NEWP
 SjlVvH7h/y3yqj2oqTIpKgKVBAMFVM/FGd8ucTpGOHyiZsJEMvaQiauF4qdTehp+z7DL
 psBuZV9DkWGl3MCacEInQ+2iGCHC7atiIGCNRfLdJIntZxr8jVBwOd57I1X0TPS1nvh0
 hxMA==
X-Gm-Message-State: AOJu0Yz1z7sCE0JsFfRKXlVJDgBAysNviuCZhOJReB3/yndnydEiLCzW
 irMxlZQ05dDuCvu44XuupgPPefWPU4w2BSNPWT0=
X-Google-Smtp-Source: AGHT+IG0HwuN6HWMuqVqyf2c14FoNwDnDUsB37yu2wAKGYL32/ItpfshaC+C6QTigSbi8wmI0YpHHA==
X-Received: by 2002:a05:6602:2155:b0:791:3791:527b with SMTP id
 y21-20020a056602215500b007913791527bmr10681518ioy.14.1695737739520; 
 Tue, 26 Sep 2023 07:15:39 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 16/44] dm: core: Correct help in TPL_DM and VPL_DM
Date: Tue, 26 Sep 2023 08:14:30 -0600
Message-ID: <20230926141514.2101787-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

There are copying errors in the help. Fix these.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to correct help in TPL_DM and VPL_DM

 drivers/core/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 4c5a00f6f9c2..fe5c41d57ecd 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -27,12 +27,12 @@ config TPL_DM
 	help
 	  Enable driver model in TPL. You will need to provide a
 	  suitable malloc() implementation. If you are not using the
-	  full malloc() enabled by CFG_SPL_SYS_MALLOC_START,
+	  full malloc() enabled by CFG_TPL_SYS_MALLOC_START,
 	  consider using CONFIG_TPL_SYS_MALLOC_SIMPLE. In that case you
-	  must provide CONFIG_SPL_SYS_MALLOC_F_LEN to set the size.
+	  must provide CONFIG_TPL_SYS_MALLOC_F_LEN to set the size.
 	  In most cases driver model will only allocate a few uclasses
-	  and devices in SPL, so 1KB should be enough. See
-	  CONFIG_SPL_SYS_MALLOC_F_LEN for more details on how to enable it.
+	  and devices in TPL, so 1KB should be enough. See
+	  CONFIG_TPL_SYS_MALLOC_F_LEN for more details on how to enable it.
 	  Disable this for very small implementations.
 
 config VPL_DM
@@ -42,8 +42,8 @@ config VPL_DM
 	help
 	  Enable driver model in VPL. You will need to provide a
 	  suitable malloc() implementation. If you are not using the
-	  full malloc() enabled by CFG_SPL_SYS_MALLOC_START,
-	  consider using CONFIG_SPL_SYS_MALLOC_SIMPLE.
+	  full malloc() enabled by CFG_TPL_SYS_MALLOC_START,
+	  consider using CONFIG_TPL_SYS_MALLOC_SIMPLE.
 
 config DM_WARN
 	bool "Enable warnings in driver model"
-- 
2.42.0.515.g380fc7ccd1-goog

