Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE21CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E098B86B38;
	Sun, 24 Sep 2023 21:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lYT1pxPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0812D86BC3; Sun, 24 Sep 2023 21:26:31 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB71C86B38
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so108482639f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583578; x=1696188378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhP20/J+z0W4sFtNvAkzJCRhwJFMRa2Cj+VUkoRHIEk=;
 b=lYT1pxPnpnI5zDJGXG8h6FJQ6GiMF++Jxzn/CE4pKQcf6ODP5duFGEVR4uF2wGivSa
 vdzAMomamt/1wVnQYL1fg80ZCMqm9vDWVHfCinl2P0FJBoVYRcAvG2C0f8YjBKsTjtJw
 AsN0gCeXPi4i8/EdLDmJ7XkYCDWpa9FtlHYug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583578; x=1696188378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhP20/J+z0W4sFtNvAkzJCRhwJFMRa2Cj+VUkoRHIEk=;
 b=gIfwzGKlp1/zV1En6AfZKXR3sZIAoBC+C1h1QXtpCFLAFjvkE02lGTcEoNLn0U4C0N
 jVFJzwNBlX2bpbmpmJL+l8tqv1MweGGtWyi6PEyIdFzOl5edwbL1Muyi/sAPhXwIFsej
 9Mi/Q7O6CxmfTEPuyIRaY3fuo7dT/YJ+qJM/OdrkrOkvmxCE8dqBGNMMFJIc/IhYIw8Q
 UM+d8q+S1k2YKqfy25XRDbPBy0j7XinmZ5kI/Tx01kjmmekHp8NKjuciF8L/8rdUS07F
 KRaSGuqWxMea95GjXJCIQfMTlgTUxQjXI1haV1wXPm8aV3HDlcWgdVPdMaGrpW17PcQv
 gk8A==
X-Gm-Message-State: AOJu0YyvO4E0J5Dv94RA+ZauUaqK1uhRJPh825uBxINHUwMM+fKYa256
 kmD5zARAIYCRjufYb3DHMqkUsETcRuVp80Qn04Y=
X-Google-Smtp-Source: AGHT+IGeFuIAqwc+P2sUI2dQyxLnBpKrgQsFuM/NnYNe0EHcYlvn8kM/2KHAKh2bAycmTFjI5tjTXg==
X-Received: by 2002:a5d:9742:0:b0:799:2163:418a with SMTP id
 c2-20020a5d9742000000b007992163418amr5541301ioo.13.1695583578474; 
 Sun, 24 Sep 2023 12:26:18 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Corentin Guillevic <corentin.guillevic@smile.fr>,
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v3 34/38] sandbox: Move the bloblist down a little in memory
Date: Sun, 24 Sep 2023 13:25:19 -0600
Message-ID: <20230924192536.1812799-35-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

Move this down by 4KB so that it is large enough to hold the devicetree.

Also fix up the devicetree address in the documetation while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Kconfig               | 2 +-
 doc/arch/sandbox/sandbox.rst | 4 ++--
 test/lib/kconfig.c           | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 21eaa5e815f9..5e79b5422178 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1012,7 +1012,7 @@ endchoice
 
 config BLOBLIST_ADDR
 	hex "Address of bloblist"
-	default 0xc000 if SANDBOX
+	default 0xb000 if SANDBOX
 	depends on BLOBLIST_FIXED
 	help
 	  Sets the address of the bloblist, set up by the first part of U-Boot
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index a3631de74932..23902dee89e7 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -614,8 +614,8 @@ that are mapped into that memory:
 =======   ========================   ===============================
 Addr      Config                     Usage
 =======   ========================   ===============================
-      0   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
-   c000   CONFIG_BLOBLIST_ADDR       Blob list
+    100   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
+   b000   CONFIG_BLOBLIST_ADDR       Blob list
   10000   CFG_MALLOC_F_ADDR          Early memory allocation
   f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
  100000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
diff --git a/test/lib/kconfig.c b/test/lib/kconfig.c
index 76225ba8ffa9..3914f699659f 100644
--- a/test/lib/kconfig.c
+++ b/test/lib/kconfig.c
@@ -22,9 +22,9 @@ static int lib_test_is_enabled(struct unit_test_state *uts)
 	ut_asserteq(0, CONFIG_IS_ENABLED(OF_PLATDATA));
 	ut_asserteq(0, CONFIG_IS_ENABLED(_UNDEFINED));
 
-	ut_asserteq(0xc000,
+	ut_asserteq(0xb000,
 		    IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED, CONFIG_BLOBLIST_ADDR));
-	ut_asserteq(0xc000,
+	ut_asserteq(0xb000,
 		    CONFIG_IF_ENABLED_INT(BLOBLIST_FIXED, BLOBLIST_ADDR));
 
 	/*
-- 
2.42.0.515.g380fc7ccd1-goog

