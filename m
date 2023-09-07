Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB312EC873E
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599AA86A7D;
	Thu,  7 Sep 2023 17:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jaPu4+6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C8186ADA; Thu,  7 Sep 2023 17:59:48 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8F186A34
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34cc8e8cbd4so4991005ab.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102382; x=1694707182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfMLQRyS3HX575ElJkxU+JP5qGOenzoFDNtinWhNVCI=;
 b=jaPu4+6dlM9L2i9r+pCYBMvQQkQPjl8A7PBrifziZL9+M3NDZFH2cHVupL2vSXtga2
 98DcNK4HSOP9oG1BPsT95e2OeUFno1oxAE7LoH6ELPPKN9YFBbEQ0xLCRUrDpbb6o5rY
 JbuMzYUdRoQkm8hIGhlDHEz5DMgMfSUDuIxV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102382; x=1694707182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfMLQRyS3HX575ElJkxU+JP5qGOenzoFDNtinWhNVCI=;
 b=ASs7jXKKHWMN3OPseO5ayamrL6PXYD5F5dW1BJseTghtR5qim92nuW9j9bQ1byPrbX
 YP86lsh2i9nN87ETXbQnbizX4pfLGpi+fi/t8bP4ZQnCc8JmfkaIYPkUmcWA7f0+j8Df
 LKIZWDsZknKEZoLku+mFb6kWEX/GJnIjVg2yalU8V5SBFqWc1nohg2J6vZglxPclNSXV
 qL5I0W4p5VDLtQvioXIqMSfZHJx4bRlMiaAcLCLeU+e5IJXpQvTGBWrapiU2PY4kp+Rp
 IxnPdOBhQKOd7PiYhcfsIHxvqLSv01/ZLP3q/zkjS49ArfQBG9Lsw/Caj56cb1dlA6bB
 ATZg==
X-Gm-Message-State: AOJu0Yy2++oLn/BTJVZ35wfRgcx8QGr21MNLr2TM3mCqDLYPnpHpD7v6
 JWR0RSYbwMSRD/0TEpReokVAJ2xl0Ri3hEGEASA=
X-Google-Smtp-Source: AGHT+IHQJVo/1whthu2zje6e37CA7xnjO7lTdNSIxPNoIO1nFnNym0yU042BODynG/gU1ly4w/bMog==
X-Received: by 2002:a05:6e02:1d91:b0:34b:aa34:a5c4 with SMTP id
 h17-20020a056e021d9100b0034baa34a5c4mr42153ila.30.1694102381803; 
 Thu, 07 Sep 2023 08:59:41 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 03/22] video: Move bmp code to drivers/video
Date: Thu,  7 Sep 2023 09:59:08 -0600
Message-ID: <20230907155933.48511-4-sjg@chromium.org>
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

This relates to graphics which is only active when CONFIG_VIDEO is
enabled. Move it into that directory.

There is no harm in compiling it always, since it if not used it will
be dropped by the linker. So drop use of the BMP Kconfig.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to move bmp code to drivers/video

 common/Makefile                 | 1 -
 drivers/video/Makefile          | 1 +
 {common => drivers/video}/bmp.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {common => drivers/video}/bmp.c (100%)

diff --git a/common/Makefile b/common/Makefile
index f5c3d90f0675..0a3f75f2f1c8 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -45,7 +45,6 @@ endif # !CONFIG_SPL_BUILD
 
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTAGE) += bootstage.o
 obj-$(CONFIG_$(SPL_TPL_)BLOBLIST) += bloblist.o
-obj-$(CONFIG_$(SPL_)BMP) += bmp.o
 
 ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_DFU
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index d13af9f3b19b..6841d8965842 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
 obj-$(CONFIG_$(SPL_TPL_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.o
+obj-y += bmp.o
 
 endif
 
diff --git a/common/bmp.c b/drivers/video/bmp.c
similarity index 100%
rename from common/bmp.c
rename to drivers/video/bmp.c
-- 
2.42.0.283.g2d96d420d3-goog

