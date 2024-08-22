Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A8EC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B93A88B08;
	Thu, 22 Aug 2024 15:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KH1u8yW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77ED88AA9; Thu, 22 Aug 2024 15:55:40 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2AC88A29
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-39d380d4ffcso3128005ab.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334937; x=1724939737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGWJdMAfyvTb8HlgvhDn+wOmF7sywth4BqZtm/aortc=;
 b=KH1u8yW6+CsWYVHjOYoP6J4tssyFnruqNtp/pvPmIEHzrqADxFfGAHFjkq0A9by4x1
 FC8AiBx4Cf+c/HRPJ41izvQixX7JBp/jsEprRjP/FLqFtBW5+9NeLbtd5Fq2em4VkqBe
 rNrJ3Q3K0GUTKlMXNufx0+OmW17B/SoXpImyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334937; x=1724939737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGWJdMAfyvTb8HlgvhDn+wOmF7sywth4BqZtm/aortc=;
 b=SosKqO6yYAWhO6NV5jcRKndLqXSFo8bDyBrNPeLv9pCbxXM1gOGr0ENbG4KIwdhevD
 rTpvIWPgYOJhN9rRXZFdxFowpbO9dzW1FwSHUahtOU/fZeJ3C6v1KYcHWQvHPAUsDlh7
 YCgQa3X3ukX+UzpzdgF331qFSLPSSdqvnZkrsagtjUzkGjR/vBtUgu88Va11dpFC1sgO
 KbdydeU2cSUwp5NP6gjfbMofgt4tdD6cJnOtMfjUON6HBjI6+2BFcH5dOags5+WUVcwc
 o0xaP9mIeijfjiEm0snOrzlPzyV2MIOJsuc0v972rfGh9d/hAIgjaX+p68JOApxyYB1w
 zapg==
X-Gm-Message-State: AOJu0YxwCQrijWoSUAsVF83AA1uXQH3E1bIgCjF8+K/miY0caninZzbH
 nNE0ZIRUEGMSoL/boYkop02yJrp7AI5t03Z0eURda6NbT6KryDSpMXzUm0RGKsyZdCN86gF2+ps
 =
X-Google-Smtp-Source: AGHT+IHwHtQmeb5zeELFrIoGaHBEWSvNJ0mv1K3qm1DZK6P6Bra2NF7sg3NXGxj4XKmZ+pr4FcZQcg==
X-Received: by 2002:a05:6e02:b21:b0:375:deb0:4c28 with SMTP id
 e9e14a558f8ab-39d6c357d7fmr52168825ab.6.1724334937196; 
 Thu, 22 Aug 2024 06:55:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 12/14] spl: Use unified inline functions for spl_load_info
Date: Thu, 22 Aug 2024 07:55:01 -0600
Message-Id: <20240822135503.2363706-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135503.2363706-1-sjg@chromium.org>
References: <20240822135503.2363706-1-sjg@chromium.org>
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

