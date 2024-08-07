Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E310C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C8188B09;
	Thu,  8 Aug 2024 00:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lu1pUie1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 892C088B07; Thu,  8 Aug 2024 00:48:19 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B3588AF4
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39b3754468eso1564565ab.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070896; x=1723675696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEFravYCgLdOHXp+N/wNqevl0eu7dt2AANOehwQZ7iA=;
 b=Lu1pUie1jF+W25h4cEH4JJesh+5wNrTi96La9DDEFX1KyT+O8g1pc/d4vrf+kE7uxo
 FuP7FPdWy0ozHIrCcACJvdZHj/baNo0j+YHK3EfvlRbd7ez23vL+j8ntS3CssCLFNxWI
 RDiJnOlqazc1cxOnwRwIs1UVV3Od4H/93l4FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070896; x=1723675696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEFravYCgLdOHXp+N/wNqevl0eu7dt2AANOehwQZ7iA=;
 b=LzDp5U1T1YClOTj6cyLkQvHFUYTIGMVsMAXnQs3HiM3PCRG2ab8MfaWXigElwOm7eB
 mUVzI6sOv6Wm6P+Qn/0OUT4lpkEJWfCULGS/84seHV/ZpkO0X7x+83i89M9sympy1mgQ
 RaG0k0QyfKrPkJi5OfwpS/tRXueSCv8EuW7GMw7i1xbCZlMR8dNCRwGJ2V4OIAGMsK/+
 R+JXlvGOjRNp1A6E7xJT1EaJnZd5olQ41aS6U8cJzb/VXXZJUSguYrx8VvOdwGUF7AgT
 VGCtIcI5eHyA1aqde7flDPvs47cwc0Y1oumc6RdtVk+l9t+c6PPctOhE4B3vGby/nkto
 ZSJQ==
X-Gm-Message-State: AOJu0Yw2WAEu9XHCiLavZRsvbmtkvastqw9SYO/dnpBAn/bS3KwaatK/
 L/EvEoYFluGeztUQtEe/BZlOwf5AM9vEkK3fS68TpFoynkf7d5sPLv45YsVALuodzI30ucGiB/4
 =
X-Google-Smtp-Source: AGHT+IHzDIaiZYj5Q/v98viuYs05BLuKmNnSimC7K69TItvKz1FiEq5Xvpq8amn4hvRoLiVPYdcXog==
X-Received: by 2002:a05:6e02:1561:b0:381:d74f:b2f4 with SMTP id
 e9e14a558f8ab-39b5ed398f9mr612115ab.24.1723070896113; 
 Wed, 07 Aug 2024 15:48:16 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 14/21] spl: Set SPL_FIT_FOUND for full FIT also
Date: Wed,  7 Aug 2024 16:47:32 -0600
Message-Id: <20240807224739.3858517-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

This flag is set for simple FIT, so set it for full FIT too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Split out into its own commit

 common/spl/spl_fit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 2a097f4464c..527a5691ac6 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -941,6 +941,7 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		if (ret < 0)
 			return ret;
 	}
+	spl_image->flags |= SPL_FIT_FOUND;
 
 	return 0;
 }
-- 
2.34.1

