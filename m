Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CE1EEAA56
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA4087090;
	Thu, 14 Sep 2023 18:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VfKyxicS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2027586E5D; Thu, 14 Sep 2023 18:56:37 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D1787082
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79275d86bc3so43456739f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710593; x=1695315393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLx6Iouph+2w/7aU2aQsBjuRt6jcVyV3R5BD4v8SGiQ=;
 b=VfKyxicS0U2gt/Wgx/qJ0MT1BaVDmEEEaViuVnTx1dKvrVn0ckruXda6G9Y2p87h39
 JFRobBHNcssHgWcargQz31l8m84Va8+Tj7vxnFcZveOC2feUDsHtdDo5FP4r186AadPI
 4Hl+/BNt57rwngbJjAHKMCAje2D+PHfAZkz+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710593; x=1695315393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLx6Iouph+2w/7aU2aQsBjuRt6jcVyV3R5BD4v8SGiQ=;
 b=aUk5kyWMUsc6rSdq3D59OtZU3p6IKpN9i3Xxj4bwH63cD9S4CvoEy4X7UC3x9RTeTF
 YrpxWoJhptrju+sOj5nKSBkrebG08r6WVVMER4bW8qs6DB7K8YKc4tIx0mRRhw96KiF7
 +tJrckWb5tpeuvFo8CVbyEzqBR7fwS+zCuR/Ug2r8FEQvXhntNjVFC5/EcgB+ubQfywK
 UnK1IFzj6Lil1/jxJo/GfPl0P3xadCATQw5P219r0pNoFSc+nGcE6kkGlHQcW34XAE+W
 og2/BqPt2i32HCoCWbaglLwS3RgWTY+D8EM11PYEK/F0P99vgRpEGTqfrWDRjBOXJ9eJ
 BN2Q==
X-Gm-Message-State: AOJu0YyZlzuhUBsU9TJGDcy3JbBIOvqqD5D6AkhN/jeC4/I0boOIlLLN
 CrkcanE/y9p9cbsImC+qsjwE+lMAu4OMv6y5BbI=
X-Google-Smtp-Source: AGHT+IHkni/GM4JrEHixOZObvOOOvoUkAG1wRxH6Aa4BYMEr6+ZqEAWfVzlzPY3HubwqqWDZIoM/kw==
X-Received: by 2002:a6b:d913:0:b0:795:fa0:c15 with SMTP id
 r19-20020a6bd913000000b007950fa00c15mr6564220ioc.6.1694710592970; 
 Thu, 14 Sep 2023 09:56:32 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Marek Vasut <marex@denx.de>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 03/21] video: Move bmp code to drivers/video
Date: Thu, 14 Sep 2023 10:55:41 -0600
Message-ID: <20230914105554.v5.3.I7adfecb5689d5dfe545e0c3b94d0bca5a301901f@changeid>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

For most boards there is no harm in compiling it always, since it if not
used it will be dropped by the linker. But for the EFI app this is not
the case, so retain use of the BMP Kconfig.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add back the Makefile condition, for efi-app builds

Changes in v2:
- Add new patch to move bmp code to drivers/video

 common/Makefile                 | 1 -
 drivers/video/Makefile          | 1 +
 {common => drivers/video}/bmp.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {common => drivers/video}/bmp.c (100%)

diff --git a/common/Makefile b/common/Makefile
index f5c3d90f067..0a3f75f2f1c 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -45,7 +45,6 @@ endif # !CONFIG_SPL_BUILD
 
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTAGE) += bootstage.o
 obj-$(CONFIG_$(SPL_TPL_)BLOBLIST) += bloblist.o
-obj-$(CONFIG_$(SPL_)BMP) += bmp.o
 
 ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_DFU
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index d13af9f3b19..fdc29376324 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
 obj-$(CONFIG_$(SPL_TPL_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.o
+obj-$(CONFIG_$(SPL_TPL_)BMP) += bmp.o
 
 endif
 
diff --git a/common/bmp.c b/drivers/video/bmp.c
similarity index 100%
rename from common/bmp.c
rename to drivers/video/bmp.c
-- 
2.42.0.459.ge4e396fd5e-goog

