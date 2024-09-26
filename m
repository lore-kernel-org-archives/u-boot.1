Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56694CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E2188FCB;
	Fri, 27 Sep 2024 00:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m15f4JYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6A188FCB; Fri, 27 Sep 2024 00:43:46 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D66B88FF6
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-45830ff5b70so10631621cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390622; x=1727995422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wmo+qKK//yuRPLF2knv74kPAgUPoYch3aMC6WyUDCKA=;
 b=m15f4JYf6JR4N1B6q6FkS3oxYpcBlqsc1Wm2Smv3A4jpQDqtt/uknw9P+gfjS0Amdf
 gy5FnF6PJYPwGmwimaXQyMqWk31DGodGDS/HjP/OjkSFk7FWuQUr7iXj4FcUV47+pQtE
 IZZ+UNtUvIc8wp7iC0+Kd4sgQWPcHy7YsgQc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390622; x=1727995422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wmo+qKK//yuRPLF2knv74kPAgUPoYch3aMC6WyUDCKA=;
 b=oFIJN4k/9RkQDb0DFXIl6//UdDkSU8HR/ViAyD5NDgRCWn/73Hv5Vb32y8ysd2P520
 PpVlL4CSCt6GkcU8t58uY5erPfD2X5z3F7dlbWfRmuqI63f0M+cKBXGqkOjnHZecQvWN
 leOimisRbAYnRltkhNNVlWDgAbpyYQntlMs0WU8URChkyVOIxY2ceM4OunEigA9lxQby
 D6YRkiie0LqUauQK/dvNjL0fEvN8/9Z3gf3gnWfe9rJHj0JTfPLGj2I662MYxldCyGHl
 4L8nP0MSrNI9Do3OFuP3pSgxj/wr1fjJDd0HpC7aBJGrDHD5AmrnseSES7uf9QY/74r9
 6WBQ==
X-Gm-Message-State: AOJu0YxWABHAx3f84rGjAoxNdD0mBrrU3ske5zTfq9sMOjzK3aDjGIWv
 +eq2ggz7kKK0cadf431+EWTXRLQ3KwabBBKM3Pih8lfvOMV1aQmCQcAxmDu4UKR6i+ikDa2IcnS
 zu7TCrsY=
X-Google-Smtp-Source: AGHT+IEQyPdGWlxi5gbe+Bh9i7zS1KVENP156hb9nlrONbmKSh7/ZIIQokHN8lrJOcCJqJxloH8uRQ==
X-Received: by 2002:a05:622a:1490:b0:458:1f34:55cb with SMTP id
 d75a77b69052e-45c9f222d08mr14567901cf.23.1727390621870; 
 Thu, 26 Sep 2024 15:43:41 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:43:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Andre Przywara <andre.przywara@arm.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 25/42] drivers: Simplify Makefile checks
Date: Fri, 27 Sep 2024 00:35:50 +0200
Message-ID: <20240926223814.1276764-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

The extra ifdefs can be avoided now. Tidy up this Makefile

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 1b7db812828..260bde957db 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -45,9 +45,7 @@ obj-$(CONFIG_$(SPL_)VIDEO) += video/
 
 obj-y += bus/
 
-ifndef CONFIG_TPL_BUILD
-ifndef CONFIG_VPL_BUILD
-ifdef CONFIG_XPL_BUILD
+ifdef CONFIG_SPL_BUILD
 
 obj-$(CONFIG_SPL_CPU) += cpu/
 obj-$(CONFIG_SPL_CRYPTO) += crypto/
@@ -70,8 +68,6 @@ obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
 
-endif
-endif
 endif
 
 ifdef CONFIG_TPL_BUILD
@@ -80,7 +76,7 @@ obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
 
 endif
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 
 obj-y += ata/
 obj-$(CONFIG_DM_DEMO) += demo/
-- 
2.43.0

