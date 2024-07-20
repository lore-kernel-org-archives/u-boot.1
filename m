Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D493FC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6493588C52;
	Sat, 20 Jul 2024 08:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ErHNrjN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326D188C70; Sat, 20 Jul 2024 08:20:57 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06AA0886DB
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368380828d6so1096968f8f.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456453; x=1722061253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67e8PvXKUs0iQFDlNoC/VA61ZNrMnXIxCdxb7uoysEQ=;
 b=ErHNrjN9MPFwEXgNMY2TNPOw5fFZMalFRYHRrs8uFSYfjtDjw8asxASZTFy6ngPZGt
 Umk4SGRNEIRsNEXEA2s6XsYFtt1et7bJNGN/ZjO87LhupEtSjVlY61j4NyIPfWeFIxh5
 uMDmFT/nRVGWmFQ2xnDD8QmZvP7vhKIxw8vKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456453; x=1722061253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=67e8PvXKUs0iQFDlNoC/VA61ZNrMnXIxCdxb7uoysEQ=;
 b=wBcEYq7/zqC7GJs451t7h6DrZCpmCr9tx2afN3Aq6VyV3dnzyWyuupF/sJNjJxC2pw
 qhh7nqgud0MSzGtg9YxeHLx8G4yqiQm0np1kfBzSaXAhEhezrSJTMRQIL0HR/YZpo2J3
 4nYQUWm2SPkLV6qVfNLBdgiJsAFl7oByl/69YUlnqjFC44WT7sloX3Bl1OznRCRM/R4Y
 l7m8cFkBtRnCEfhNsrC42qtA7toebuY9F4wPyfTPRZB2E/ZrBKLRhiv3w7cYmaimiWK3
 q6xT1xrKC1IHmUKTCmVGenwhJmWuEDxcwz2RQDJpjDR30FXKyn7cGkPuLg7/xJq2LUoL
 Du1Q==
X-Gm-Message-State: AOJu0YxkpAjFof5d+opbkC5x4LIZIQ7EVSY43jkZAy9f0ug/9lZdtSCM
 37rfnWbMuVsChKx0FoYJPEDlQtiQclMRGSxspjaztvEFWBHpOpT+wRzwlz8SvZUXQiBrezZJmoQ
 =
X-Google-Smtp-Source: AGHT+IGeDRrt7okOiPhN6+/ft7ACWxKg/tyaD++bqcqetJthAzA0J4Aw2ZoYVQGaerhwOl/JzEUoFA==
X-Received: by 2002:a5d:660f:0:b0:368:68d3:32b5 with SMTP id
 ffacd0b85a97d-36868d33358mr2827885f8f.13.1721456453296; 
 Fri, 19 Jul 2024 23:20:53 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/14] spl: Use unified inline functions for spl_load_info
Date: Sat, 20 Jul 2024 07:17:04 +0100
Message-Id: <20240720061706.2644229-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720061706.2644229-1-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
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

Rather than declaring completely separate functions, put the code for
each case into the same function. This makes it easier to read.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/spl.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/spl.h b/include/spl.h
index 5dfdf778d2d..2f6a3e64c10 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -306,31 +306,27 @@ struct spl_load_info {
 		      void *buf);
 #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
 	int bl_len;
+#endif
 };
 
 static inline int spl_get_bl_len(struct spl_load_info *info)
 {
+#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
 	return info->bl_len;
-}
-
-static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
-{
-	info->bl_len = bl_len;
-}
 #else
-};
-
-static inline int spl_get_bl_len(struct spl_load_info *info)
-{
 	return 1;
+#endif
 }
 
 static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
 {
+#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
+	info->bl_len = bl_len;
+#else
 	if (bl_len != 1)
 		panic("CONFIG_SPL_LOAD_BLOCK not enabled");
-}
 #endif
+}
 
 /*
  * We need to know the position of U-Boot in memory so we can jump to it. We
-- 
2.34.1

