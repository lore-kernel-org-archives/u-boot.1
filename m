Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41512CA0FE9
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A009C869CD;
	Mon,  4 Sep 2023 16:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GgOK6BbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80CA869AC; Mon,  4 Sep 2023 16:41:46 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32686846D2
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34dee07e676so5538915ab.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838503; x=1694443303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfMLQRyS3HX575ElJkxU+JP5qGOenzoFDNtinWhNVCI=;
 b=GgOK6BbAivLDwe+jEUw6PoP5F4b9yN1c+HeFC6JRmGHHbr+J9jzF6texPh/uY21fPC
 Q6kMb37pNIC3fsN7+z0JxYhY4xMe7MLJSLeUzuTNF444NPvjCGDrDTRReMek7Wgh4fih
 ZH0i41IlREKE1kq3c5aeAU1aMTY5wWqrCPlmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838503; x=1694443303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfMLQRyS3HX575ElJkxU+JP5qGOenzoFDNtinWhNVCI=;
 b=jm/+U0id53G2RatMK9uY7yGLfLyLJWQIe/jCziW9HXxwDv9RKrq/CYWpWB5zDXhVAy
 +ywVtqgaTETQLfcotgi62fspy3JpmKLwpaX+v1cp63E+XDrzIHPD1pdcsY82aIx5jKJC
 fWg5wwV7/FU1S55mwzQZq+w8KWd1l3UsdkT75IlbDHSUoQqa9oo3jSHXdRP42vls3MPS
 qMk2Q2T9n4eC2nM/qdVmALRnAkJGamyEq1Ua0APaxBSVM/GluqBGxqTv9VkLiGFjHqrb
 mvQl1RosBqnK2tFxIVmdLauEDj/M03I3ExdM2NSwIRk1NmhVwHprIjdvhjTeVhml77cO
 Pvyw==
X-Gm-Message-State: AOJu0YxM0hnIP8nXJiuekiN7UIry5DEntHuTBOZqwAjlmqvxlqcbKG89
 EID36uT5aUQ4+ScUf1XRU92Hrwy9SnVQLCbYnwk=
X-Google-Smtp-Source: AGHT+IEp4EFv6qDEEdqJcKxFJ/nXCxF+iV3gZATFXdrmNu1dSUrKeViwMUjJRFE947py0PRtzMBBMg==
X-Received: by 2002:a92:c809:0:b0:348:8b42:47d with SMTP id
 v9-20020a92c809000000b003488b42047dmr10596074iln.28.1693838502845; 
 Mon, 04 Sep 2023 07:41:42 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 03/20] video: Move bmp code to drivers/video
Date: Mon,  4 Sep 2023 08:41:06 -0600
Message-ID: <20230904144131.2699824-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

