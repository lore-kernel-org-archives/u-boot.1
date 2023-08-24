Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6295BC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB3286989;
	Thu, 24 Aug 2023 21:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oU1SIjgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F9EA86A24; Thu, 24 Aug 2023 21:59:39 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F810869EA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-792409bc1cdso8561139f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907174; x=1693511974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TilY9BszYv4iBiEtazzpw4Jqgtah4UuSA5DVQsqBVNw=;
 b=oU1SIjgLFlwYy5kxJAC93gjtzvTuKQewvkdgyVp3rvzcGpvP5Arr1yYB0rbYd8Q9ap
 +CVYXMnAuqdFJ3PjiQCt1xAFjMkPlHTgDot4L+trkW1ri6msuUVrLIJbKgGDcih2zWNq
 cbYwT/+uyNpDdmv4PIEyTL1TpMwn3Mo+W+rug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907174; x=1693511974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TilY9BszYv4iBiEtazzpw4Jqgtah4UuSA5DVQsqBVNw=;
 b=UIqr6NiOZ11Xz0D18hjkue1CZDnViVKfG5iolGLL7MgTKuuw6oJbKXM95rlPhmvX8X
 IYd3hYr6YXBrVJht1J0F6AmFhUHNzDKutow+nbgrywzBuQ6X29w2K0VJxuXLJdEf+CWw
 Y/6ZxQu5zUbulWQx0NE2R7nvkt8xMs2S8tpO/JsV4kVee+/D8ypcSoIh8NTUbc7px+nO
 IqbElz0aC/311lVoCoroDEyyXAtgyCVTxwpyrIYD6azaAsSScJtxyr2G1nSPOeQ6mOvq
 gAw+ayE0UC8c/xnsY6lZoBDUPYxB90NJBAI4YPdOitawanBernqFQrgE1DSqDqYvaK12
 ya4Q==
X-Gm-Message-State: AOJu0YyhshlanTRKArGYM2thFEXKi5SgSvJCjcyepBSuFQZ6U1M1bWmK
 LEbPdoVS2E3EUC8NfD7E+Yoo2HEP3oC25YKfXRU=
X-Google-Smtp-Source: AGHT+IEHGQu+gcE7B1MuOlbrPIYQNPJjVlZJgifI0TeGmBnt39ihrHq+leT1oN0RsvjsYmxrLUBrMg==
X-Received: by 2002:a6b:5f12:0:b0:792:77a1:d8a1 with SMTP id
 t18-20020a6b5f12000000b0079277a1d8a1mr1360392iob.6.1692907174113; 
 Thu, 24 Aug 2023 12:59:34 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>
Subject: [PATCH 07/19] test: Move POST under a renamed Testing section
Date: Thu, 24 Aug 2023 13:58:58 -0600
Message-ID: <20230824195917.1687886-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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
2.42.0.rc1.204.g551eb34607-goog

