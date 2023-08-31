Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0AFC83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C108667A;
	Thu, 31 Aug 2023 05:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ekGPF6MB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C78448658D; Thu, 31 Aug 2023 05:53:46 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD48865AB
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so8776039f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454022; x=1694058822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=249GrM5rs/Sl8lO6+eoXCxx0qU6Zg+q7kd+/4JSpQHc=;
 b=ekGPF6MB7wxpADYPFy7/PQvruC9kZ252V081OtFhSFvJSBbXYGNPwmLhWamreEI/+8
 qTgPAgYt0WowVyDSJoqmYOFeOon5hBPUeNhZh4zxiYhhpcFlkKkUezCjpxRweca/5f/d
 W35Wr04WSSbPBUNAZJWhlddWL7oRWVdm/W6HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454022; x=1694058822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=249GrM5rs/Sl8lO6+eoXCxx0qU6Zg+q7kd+/4JSpQHc=;
 b=gmObpkaheMaJnl1q1MG74UpXc8GxRfjCm/ZvWfZqrjl2q6IT0Vax4+pXnUh97k5JJJ
 AoUkN6wOSQCekyaQowAf8qeSBpCHUULZZvTOAxkh8Lmt1N+CVyCTWBOxwSfD2XPh/FxT
 eEYqwHBTAGmhzx0zAH4yLcJ0/fHwvKk6qayINxSnOgklwlcNS/kl7fdo1ZyBEMSfvXw/
 04ZAappKBmqPAygWUcP6Na2tkE+BqZJqh5uUKNfqdx7rOnPH4yCx/ai3vAakdz9dnGGV
 5Td5m0sWd3j5+yC8Z+SKlf/50lya+wdC0NDSd9Ju39LJDiKQt5nYa+f3PGwCT+SPLoJP
 A+oQ==
X-Gm-Message-State: AOJu0Yxol1Y+LcE+QxLfPj4K0mq5mAcN7//mGLqc+vFqmXxZ0wpI5nys
 Bo1yg5Ml8Wyj5j8kxc6cerq7EkH9rxF5XDZ1Doc=
X-Google-Smtp-Source: AGHT+IE2oecCa7+0Bq25/pVGl+SlemMbAPCMmFfCD8V4poo8hi4pYaQtpGL90KzdrZruGGpSzsVtyQ==
X-Received: by 2002:a05:6602:4896:b0:794:eb37:b0da with SMTP id
 ee22-20020a056602489600b00794eb37b0damr1321526iob.2.1693454022172; 
 Wed, 30 Aug 2023 20:53:42 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/19] boot: Make standard boot a menu
Date: Wed, 30 Aug 2023 21:53:09 -0600
Message-ID: <20230831035319.2316665-16-sjg@chromium.org>
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

Collect these options into a menu for easier viewing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index c9b7d3f710b6..17f54b926f05 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

