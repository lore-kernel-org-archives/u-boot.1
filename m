Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0C9C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF89884CA;
	Sun, 11 Aug 2024 14:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WaNXwC+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF6A8885D; Sun, 11 Aug 2024 14:29:47 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C61888875
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f94ce2272so137010239f.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379384; x=1723984184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGWJdMAfyvTb8HlgvhDn+wOmF7sywth4BqZtm/aortc=;
 b=WaNXwC+BWm7WDB3PGKOImugWb9pAhviARhJMj+v2973MfrE0WzyqbXzKm2Y88rC75i
 pHsGdIpe5mktxJ9u/G8QP9nTnJCJuFdbNpzer4KLO4Yq/sJJPCtamLL62TBJ5G4TFkcw
 CdYjjgeTeCO3VOuUqeGQ2H7+wKJxuPUhOdJ0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379384; x=1723984184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGWJdMAfyvTb8HlgvhDn+wOmF7sywth4BqZtm/aortc=;
 b=mt/29HjUzAG+bRK4tobD/WdalM2xcBwaNlZb4Yvss/wnmf3IBp0OMFTBvVi0f3X7UF
 yI0P95n6/qoY94TX3UpbAaX7tQ9KrxzM8PGHJFGOrafmGzQyfuGMSrv/3DbO/kxu6k5R
 d0Rj3WJWIpx/70YNqEm9G4g6Vdhff3CwuEwTZCdWRMiXDBJY+snXmJmd0fq6TRUqB5aq
 vcJ2hfzKQ1fQd+17XZA61AbvEb0LnD8cPRTUfloIbKsJ2C8y4zNvkDqkTLpsSgrD2cxn
 W3ERnG73F44B7KevuWTZoco2G6W3bjJhXiV2Mtr9hEQKkF0ud9D73o2ILO/7xZTR/j5i
 L/4Q==
X-Gm-Message-State: AOJu0Yx1g5A3FYTiG9gbvZmePKB6imTG9l+t/DVgywM1fkA3lq0nf2zF
 PYQqn74SvveQuBNNQhdz06mrlmmmn+pBuK9ZH2JJ9RCHUywV/SrBVhK6WDePmxsRcr8o9ntuuOA
 =
X-Google-Smtp-Source: AGHT+IERVfaqLsepdg1fZoAf9V3zCV7chs/OoI2JLF1qOTqoHZe2KDN7NJXB7A0KXCEV+38isPos5w==
X-Received: by 2002:a05:6602:168d:b0:809:83e3:a35c with SMTP id
 ca18e2360f4ac-8225ee77040mr779162139f.7.1723379384229; 
 Sun, 11 Aug 2024 05:29:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 13/15] spl: Use unified inline functions for spl_load_info
Date: Sun, 11 Aug 2024 06:29:22 -0600
Message-Id: <20240811122924.4035982-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811122924.4035982-1-sjg@chromium.org>
References: <20240811122924.4035982-1-sjg@chromium.org>
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
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 include/spl.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/spl.h b/include/spl.h
index f92089b69ea..fb26e3f5537 100644
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

