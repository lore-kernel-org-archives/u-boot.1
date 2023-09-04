Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7EBC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF64B869BF;
	Mon,  4 Sep 2023 16:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DVKJdhTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E3DB869BF; Mon,  4 Sep 2023 16:41:53 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FFE1869D6
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-794d98181f0so66571739f.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838506; x=1694443306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yt09BtrpGSKexAEvRPD3m8ALdhGApkEe6kX9IW4j1yM=;
 b=DVKJdhTRpZHAeVl3ZDuqQvJBToziLj2BceGy4bw6meKUcl8+3zgXEgnlB/jLQ/dEKj
 ni6CEF69g64P8e5WnhvxBllANR3hf3q8cN8pOMprRuKbN4yPe4bhOJyK0r0hvouYT8nl
 W3R15ZSB+ntrR9fW2zw9LLux8qWhm108CPEN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838506; x=1694443306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yt09BtrpGSKexAEvRPD3m8ALdhGApkEe6kX9IW4j1yM=;
 b=S2qujI6NUeKdKSdQeFTc2w4Zb/Q0cBGAOCBIZNftB8+FizXODa7xfWF42TD+KOZFRJ
 feVxRt2Ac77tIx6UDKqgrNBYpZjjjbPQN6j77kbsR30Amk3gwLwSEOkB1sHdU3OOS3ID
 ydI5OtUXjvZ1NOYN1WsLRZFVnijU2OfColwDFRCFPqzrl3E0kGEDhZmg3weXg5ihtFMb
 qIiThFMw/IjCVqerHDFKBmtfoMMuJpiLgotrBaCZuK4X9tYu6wOle3NO//z4omm+CZJb
 1Js8651eUvVDZ6lGzoiA3j1bsCnceU9Ba6Zix43QBUQs6tLm/Rv0IFaZfom1VJzWr4rc
 nbuQ==
X-Gm-Message-State: AOJu0YxrNoHBe2unuFJwkltqOtrrK1JeemrGWooIug6GJsi1Le1a3qyY
 9+xhOWsFIBnv7NHL+5iiCoaRjlW3i/2+W2z8WqQ=
X-Google-Smtp-Source: AGHT+IG1XMMtd9RSo3ulIAm0zBcoScv619tZPaF6FxSMoOZJ+eYLiQ9QVeOXfJmY4uLCWNLTEZ264A==
X-Received: by 2002:a05:6e02:f44:b0:34c:a6c3:cd56 with SMTP id
 y4-20020a056e020f4400b0034ca6c3cd56mr10555369ilj.23.1693838506776; 
 Mon, 04 Sep 2023 07:41:46 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 07/20] test: Move POST under a renamed Testing section
Date: Mon,  4 Sep 2023 08:41:10 -0600
Message-ID: <20230904144131.2699824-8-sjg@chromium.org>
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

Rename Unit tests to Testing, since it is a stretch to describe some of
the tests as unit tests. Move POST there as well, so it doesn't show up
by itself in the top-level menu.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/Kconfig b/test/Kconfig
index 6e859fb7d0db..830245b6f9a9 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -1,9 +1,4 @@
-config POST
-	bool "Power On Self Test support"
-	help
-	  See doc/README.POST for more details
-
-menu "Unit tests"
+menu "Testing"
 
 config UNIT_TEST
 	bool "Unit tests"
@@ -110,4 +105,9 @@ source "test/lib/Kconfig"
 source "test/optee/Kconfig"
 source "test/overlay/Kconfig"
 
+config POST
+	bool "Power On Self Test support"
+	help
+	  See doc/README.POST for more details
+
 endmenu
-- 
2.42.0.283.g2d96d420d3-goog

