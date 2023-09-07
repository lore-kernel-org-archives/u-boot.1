Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59559EC873E
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB5486AF3;
	Thu,  7 Sep 2023 17:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="got5krU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8823F86A63; Thu,  7 Sep 2023 17:59:51 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CF386A78
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34dee07e676so4362705ab.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102385; x=1694707185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yt09BtrpGSKexAEvRPD3m8ALdhGApkEe6kX9IW4j1yM=;
 b=got5krU1aJHT+ipO8mczCDM+fSx8ZaxN5GSnc0MiYMoJmJWO5UamrNEYFNCTPocPST
 Lyq5ZrPheycC7WDuC+yd1iehAwPsXJsjKVn2CcKVuHNQXsDCWue+DxFcGh7rriBTpwDA
 7sGGcsQedvfmfnSBvEAIklZJqQvOfFsaQqWFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102385; x=1694707185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yt09BtrpGSKexAEvRPD3m8ALdhGApkEe6kX9IW4j1yM=;
 b=ZE8NzUmZxIUpwkm3nSeDVuUYyjP4gRzSvqkp5+FpWZvHzsk5difMmAFQ1OVEXC527P
 WrwjOV/qdHX80874cngYbEz8pgASfpvdAycf4GVfD6PkkxWiMt3HLHG8gLscqH3eYjja
 HTF6riWaTuYrSm3X7FY47I0+uzIRBNEpAMH06juSS+dI5NSBI1Vg3xgcOW4ujGUsH8JX
 GQ2GQ+rv0xJfONjuJJSBv++H1cTFsiNjwencNMF9W1KMny3dSBeVLkHWP5Kqc4GCvx7X
 +k6Lwxnp3MpBjPWHIbXWEe1q+2jYmruc4ObzMnwedZiM9sW841o04nrCp1kZNt4FhiP8
 bywA==
X-Gm-Message-State: AOJu0YwgXl/yvrYbwohCiqSvjKBFwIXOuNcS+HRVnPFUsGJBpLENxcT5
 dSDFjAUmAT8zPpnx6Tuo39F3YmWArzwFas+lDXQ=
X-Google-Smtp-Source: AGHT+IGhzAlg7WqttgUyoj3e04Ha6WdLVscur6PV1Wt/mdyN39Vz0WQw3vrG6HjhrBh7SyTvuh9/ug==
X-Received: by 2002:a05:6e02:1c2f:b0:34b:ba9b:c764 with SMTP id
 m15-20020a056e021c2f00b0034bba9bc764mr78842ilh.18.1694102385053; 
 Thu, 07 Sep 2023 08:59:45 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 07/22] test: Move POST under a renamed Testing section
Date: Thu,  7 Sep 2023 09:59:12 -0600
Message-ID: <20230907155933.48511-8-sjg@chromium.org>
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

