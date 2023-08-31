Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09426C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42EA8865A4;
	Thu, 31 Aug 2023 05:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XN9/0vuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718D886586; Thu, 31 Aug 2023 05:53:40 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B71A8658E
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34bb72ffb1fso1464025ab.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454016; x=1694058816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOhZ6V69zCZ3zF5au8Gbkfyd2x6uHoWmgV9aLc88Awo=;
 b=XN9/0vuG7wPP7+Jx/cwpPGjYzemndCr6cft6RS6hAgsE7Ve3Gef/ACOEPdg2geMgRa
 4Fe2ExtbaZ5XWm04ZXY1M5bu35wKBJlC7d6y4avqYU6vwHjiIu4sbkPSQ45M3JpIJhTT
 PnmGlhpgpc2yi0NJBtjjxL0b7fk2JEgihVp4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454016; x=1694058816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOhZ6V69zCZ3zF5au8Gbkfyd2x6uHoWmgV9aLc88Awo=;
 b=gTkrD+kfr7A826QOS8GMi0Cr1FLNZGSoaf/V3/cpSMYOkrk0U7Km0U3CndacSfEA3y
 LqFaKPhImgMpb/oHsJ59PjgvZieYrkyECFBy8Od9VzHaIK7SrJqfapY7rWA0F1ntwOyw
 ypcsoJuWLrbsG/XBVaG/1xHg6YDXAmy51fYiKFwSDiv10iKDjXPX4ClbpjbVq4h9Srl1
 gCltzbuiVaJ/HRbsrsWNWi/fGqYiljH0uj/Xe7svQ9fCHJTx5hFxq6awbbKWgDTKIciy
 7paCnffmjEHRzoliQMHiHM5Zz5XsEfkMnt3dz8ePFPr5TJg5o+C3LHJpFgaMzfmBX9Fz
 73hQ==
X-Gm-Message-State: AOJu0Yx+y+6fsvntr++0DYC0BitMWlyzCSP1jfnN70KkJBNGs9UaY1SM
 4eLT+UGSs+Gq+X/ZVvpyaMF8jy8wEACEFol49zk=
X-Google-Smtp-Source: AGHT+IECbkiD/uPnde1OQn1qyV5Z7NUN2sJ18ZiepuiN8KLEkDsG46lvnDCiJgL0Km6RswC8aKQfdA==
X-Received: by 2002:a05:6e02:782:b0:34b:ba9a:341 with SMTP id
 q2-20020a056e02078200b0034bba9a0341mr4165468ils.32.1693454015966; 
 Wed, 30 Aug 2023 20:53:35 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/19] test: Move POST under a renamed Testing section
Date: Wed, 30 Aug 2023 21:53:01 -0600
Message-ID: <20230831035319.2316665-8-sjg@chromium.org>
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
2.42.0.rc2.253.gd59a3bf2b4-goog

