Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8558EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5826E86B2D;
	Thu,  7 Sep 2023 17:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mdheA22Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B6386B22; Thu,  7 Sep 2023 17:59:57 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF7586A6B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34dee07e676so4363305ab.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102392; x=1694707192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iflYQztJCEPcaP7lKi4MoPC1ezC0wxmJfayVc7ql3M0=;
 b=mdheA22Yme5dSSGTvctN39PsMI4rcCM5XqGHf9J45/gGwNgWn2q4u19n5Td3LAZTpN
 PyY/dj6kMW+LTzWxsfqBT+z/hzW1OfeWxsdPImQFdZ8eC/PrNeR6HGk+0wdXbdjewNfz
 l6EyyLRGGNHYlC7X5cnzgErd9H0F6eKB90Sz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102392; x=1694707192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iflYQztJCEPcaP7lKi4MoPC1ezC0wxmJfayVc7ql3M0=;
 b=juKO1Y84odTDa9DZ+J7fpBGdxV9gVHI58nRm8eHND5JIdKxLzDiwEp2nbLutnskcTV
 Pp9QAS+6fe/dXdFdMn+PnsCXHIn/TQW+X4QJwAWIZ+hkBrvmfb48vS3C3tCt+9VwmSWR
 TixYPABdzpe/qJAioSZomEbxNEo91VtiVc2WDY5yscHMxMLP/lGZahQ3Cq7td/uf23QN
 /smdnfL4nY63ZR8+6Ypa/FBZamKL9vwVuUA0DwOdnMMJ+hheQSlk3feUnVPs1BfsYkCU
 h4UyAFbKH8Usjuv45Tws5wfeusggk+8+Ai6txYOM5aktEfPhQ6QWLi8TeN25VTZCbnIr
 3nXw==
X-Gm-Message-State: AOJu0YzurEM4wil3HHfHPI6sSkGc3xNIsV74Ncp1WH4NAe7BUgznUecH
 39kDJG0I+IqwXCee8R55VFg01etwTqFtZPFY+LQ=
X-Google-Smtp-Source: AGHT+IHDaoptAcbNPlIPYrOo4MAr7Tk4n1ZIYMXOJ1J7Aj8OgMEFs9p6aGTLbymZGcpR6hJMVfIFdA==
X-Received: by 2002:a05:6e02:1068:b0:349:8811:fc51 with SMTP id
 q8-20020a056e02106800b003498811fc51mr41788ilj.20.1694102392656; 
 Thu, 07 Sep 2023 08:59:52 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 16/22] boot: Make standard boot a menu
Date: Thu,  7 Sep 2023 09:59:21 -0600
Message-ID: <20230907155933.48511-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

Collect these options into a menu for easier viewing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9b09d636d057..a885fea692f6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -372,8 +372,8 @@ config BOOT_DEFAULTS
 	  of U-Boot to boot various images. Currently much functionality is
 	  tied to enabling the command that exercises it.
 
-config BOOTSTD
-	bool "Standard boot support"
+menuconfig BOOTSTD
+	bool "Standard boot"
 	default y
 	depends on DM && OF_CONTROL && BLK
 	help
@@ -393,6 +393,8 @@ config BOOTSTD
 	        U-Boot)
 	    - bootflow - a description of how to boot (owned by the distro)
 
+if BOOTSTD
+
 config SPL_BOOTSTD
 	bool "Standard boot support in SPL"
 	depends on SPL && SPL_DM && SPL_OF_CONTROL && SPL_BLK
@@ -413,8 +415,6 @@ config VPL_BOOTSTD
 	  boot. It is enabled by default since the main purpose of VPL is to
 	  handle the firmware part of VBE.
 
-if BOOTSTD
-
 config BOOTSTD_FULL
 	bool "Enhanced features for standard boot"
 	default y if SANDBOX
@@ -673,7 +673,7 @@ config BOOTMETH_SCRIPT
 	  This provides a way to try out standard boot on an existing boot flow.
 	  It is not enabled by default to save space.
 
-endif
+endif # BOOTSTD
 
 config LEGACY_IMAGE_FORMAT
 	bool "Enable support for the legacy image format"
-- 
2.42.0.283.g2d96d420d3-goog

