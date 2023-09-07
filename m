Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2528EC873F
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B21986A78;
	Thu,  7 Sep 2023 18:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mmDLdMsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934EA86A88; Thu,  7 Sep 2023 18:00:37 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7964F86A78
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-794d98181f0so47897239f.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102429; x=1694707229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8epWVPfOFoHSUCS7XFIFlGfBzoAsutHgkphzLHDgg4Y=;
 b=mmDLdMsZ1nefaZJGd8VMz27KfqTZT0o8dFRGNyP8dYnt/C3/hHXnMIW+qW0tJJ2wZQ
 mEqC+im2KAWQtTS2OrXZ3F7LIXoa67IDPzHzXmBjmuuzukzhtsag80g/65tYQj1wzlPD
 YFN41XCjNzjXw4PFddpPQGSUaW3b9oHRz4QWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102429; x=1694707229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8epWVPfOFoHSUCS7XFIFlGfBzoAsutHgkphzLHDgg4Y=;
 b=GkINHxtS6TvyvwuMpDTdIjfLcunacD7QbMhv82W+21a+pqXPIhsaiRIi+R/yYZuLCC
 egLgoMkyTy/DpaohAGp2BfQYQ3AvZ7AgS/AHYe73smktrPhTlaBT6CS/89b7IxCavJZb
 BE9gYj8uGG0k9b5TpUOOOzsUq4dmCLw/L4m4dIHaQ1TLA/z/HSbkhHNlQW59ey+3NmPT
 k81fbrCoCSDqERD0y4v/c5vXVaQmSPYAecCjcw6BkLap30GcUGIefnOONCqg4fDeal3a
 esEbBA5E6x9fdnQY0tncvNA+vGBGeHrTlqxVdqCQV7N6iFGSaRyg7RvZuml72a6IryzQ
 paRg==
X-Gm-Message-State: AOJu0Yw0Ep0rS5FKMrIWVQhaR/xjvXppMbVEH26gts5SJjofxoJ6bCbc
 qZhEMNpH3oZnMqIrtdPu5sK4oDj99wLg1EwfeyU=
X-Google-Smtp-Source: AGHT+IEN2FDROjoOK1JTUxzH+ussPoYiGDiOkZjhg69B0woJf2ys5U9Sovr1NTzw/PfalDoNckTNgw==
X-Received: by 2002:a5e:9247:0:b0:792:792e:6616 with SMTP id
 z7-20020a5e9247000000b00792792e6616mr177538iop.2.1694102429090; 
 Thu, 07 Sep 2023 09:00:29 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a02a805000000b0042b39b2289asm5699209jaj.102.2023.09.07.09.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:00:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michael Walle <michael@walle.cc>
Subject: [PATCH v2 4/4] kontron_sl28: Use u-boot-update.bin instead of
 u-boot.update
Date: Thu,  7 Sep 2023 10:00:20 -0600
Message-ID: <20230907160023.49339-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907160023.49339-1-sjg@chromium.org>
References: <20230907160023.49339-1-sjg@chromium.org>
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

A '.update' extension does not get preserved by buildman, so change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Michael Walle <michael@walle.cc>
---

(no changes since v1)

 arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi | 2 +-
 doc/board/kontron/sl28.rst                        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi b/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
index 83750ab001b2..aacf181e2dd0 100644
--- a/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
+++ b/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
@@ -64,7 +64,7 @@
 
 &binman {
 	u-boot-update {
-		filename = "u-boot.update";
+		filename = "u-boot-update.bin";
 
 		fit {
 			description = "FIT update image";
diff --git a/doc/board/kontron/sl28.rst b/doc/board/kontron/sl28.rst
index 44435d90c624..2cb8ec62be42 100644
--- a/doc/board/kontron/sl28.rst
+++ b/doc/board/kontron/sl28.rst
@@ -39,12 +39,12 @@ Update image
 ------------
 
 After the build finished, there will be an update image called
-u-boot.update. This can either be used in the DFU mode (which isn't
+u-boot-update.bin. This can either be used in the DFU mode (which isn't
 supported yet) or encapsulated in an EFI UpdateCapsule.
 
 To build the capsule use the following command
 
- $ tools/mkeficapsule -f u-boot.update -i 1 UpdateUboot
+ $ tools/mkeficapsule -f u-boot-update.bin -i 1 UpdateUboot
 
 Afterward you can copy this file to your ESP into the /EFI/UpdateCapsule/
 folder. On the next EFI boot this will automatically update your
-- 
2.42.0.283.g2d96d420d3-goog

