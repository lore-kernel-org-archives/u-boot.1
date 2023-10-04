Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8BBE7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50782875CA;
	Wed,  4 Oct 2023 18:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kRz8R8gT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5207A875C9; Wed,  4 Oct 2023 18:44:00 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9609875B3
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5046bf37ec1so42565e87.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437815; x=1697042615;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkdpxjslxeSGNTyP17QS73C3iSIW+zua4nHZR92i7tk=;
 b=kRz8R8gTXUh83FIrKFL4V15TOn2kbasYuULLpzI+2C1xtA2dkdpdp1/tj4513GkMpI
 Bwix0QkX9d9RZKfP846+5XFEuimu8+wcywOesX5rvZsUe8O9+efdfOjt4NfYLjYgTRbT
 Ggk4HmxDLGfYR/uA6fxnooToyNcMUtvqm8XTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437815; x=1697042615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkdpxjslxeSGNTyP17QS73C3iSIW+zua4nHZR92i7tk=;
 b=BC26M1lvL4JDykK/LkKE9bJoiH+I4Qr81ZkGwwHbq0Imq+wafpudnm0TafGfjGuu8f
 ToA18ZuDSMefZQmTBIacavnNUvhV36qSiqyClqGB4onfDllTDiIWXonIRNX0UBtqtIWY
 y3CVpOAMre98UJFVN3azO2Rmb8fCJ0JCozWjohjaP3gRSULb8ZHDo5CApqAut+Oro3E5
 rDEtsUv6OQRcch4Bqx5NrHpUA7RNBrZN0aJBZnSwV7am02WkEQQM/aecIEW89qqx8jzf
 7XxBdu0UjLun0uZsBDQN+mGrA3MOF+wNzDRUwd18jeSAvucbVyndwswcs9TISJsKYq8U
 MyZA==
X-Gm-Message-State: AOJu0YwKJzMhqGts/FdiOBHz2N3DE3KmQ0BnHuxPX3OD7EGSZe7Mugvd
 pVcN39BF7tCLj0IgTjpFzQJ5ss6y8qucXgCmv+U=
X-Google-Smtp-Source: AGHT+IFugwlEhW0u+xAfQdhNk3CSmc/ezN1vql6Q3mKR2Pw8oHObvGSC6YVSJy130Ycn8qf/11L0RA==
X-Received: by 2002:a19:2d1c:0:b0:503:303:9e2d with SMTP id
 k28-20020a192d1c000000b0050303039e2dmr2338958lfj.5.1696437815299; 
 Wed, 04 Oct 2023 09:43:35 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:35 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tony Dinh <mibodhi@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [RFC PATCH v10 23/24] DO NOT MERGE: only to make CI happy
Date: Wed,  4 Oct 2023 19:42:19 +0300
Message-Id: <20231004164220.15738-24-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

This commit set CONFIG_HUSH_PARSER_2021 as the default to trigger the CI with
this parser.

Nonetheless, the keymile (i.e. VENDOR_KM) board family is not compatible with
new 2021 hush parser.
Indeed, This boards used set_local_var() to store some variables as local shell.
They then used get_local_var() to retrieve the variables values.
Sadly, this two functions do not exist with CONFIG_HUSH_PARSER_2021.
A patch was proposed to use environment variables rather than local variables
but it does not tackle the problem, so complementary work is needed to make
this boards use CONFIG_HUSH_PARSER_2021 [1].

We also remove a #undef of CONFIG_FEATURE_SH_STANDALONE as it does not exist in
U-Boot and causes troubles in the CI.

We also set CONFIG_LTO for kirkwoord sheevaplug and phytec bk4r1, otherwise it
hits its board size limit.

We also disable some check for pylint as it was not able to find future for
commit object.

Acked-by: Tony Dinh <mibodhi@gmail.com>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
[1] https://marc.info/?l=u-boot&m=165541917618725&w=2
---
 cmd/Kconfig                  | 3 ++-
 common/cli_hush_upstream.c   | 1 -
 configs/sheevaplug_defconfig | 1 +
 tools/patman/series.py       | 4 ++++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 36595638a2..e113ed49ac 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -28,7 +28,7 @@ menu "Hush flavor to use"
 
 	config HUSH_OLD_PARSER
 		bool "Use hush old parser"
-		default y
+		default y if VENDOR_KM
 		help
 		  This option enables the old flavor of hush based on hush Busybox from
 		  2005.
@@ -37,6 +37,7 @@ menu "Hush flavor to use"
 
 	config HUSH_2021_PARSER
 		bool "Use hush 2021 parser"
+		default y if !VENDOR_KM
 		help
 		  This option enables the new flavor of hush based on hush Busybox from
 		  2021.
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 709c055d2f..243710ab51 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -427,7 +427,6 @@
 #include "NUM_APPLETS.h"
 #if NUM_APPLETS == 1
 /* STANDALONE does not make sense, and won't compile */
-# undef CONFIG_FEATURE_SH_STANDALONE
 # undef ENABLE_FEATURE_SH_STANDALONE
 # undef IF_FEATURE_SH_STANDALONE
 # undef IF_NOT_FEATURE_SH_STANDALONE
diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfig
index 2e4901b840..365f779cc8 100644
--- a/configs/sheevaplug_defconfig
+++ b/configs/sheevaplug_defconfig
@@ -16,6 +16,7 @@ CONFIG_ENV_OFFSET=0x80000
 CONFIG_DEFAULT_DEVICE_TREE="kirkwood-sheevaplug"
 CONFIG_IDENT_STRING="\nMarvell-Sheevaplug"
 CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
 CONFIG_BOOTDELAY=3
diff --git a/tools/patman/series.py b/tools/patman/series.py
index 6866e1dbd0..f99818e33a 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -316,6 +316,8 @@ class Series(dict):
             # Show progress any commits that are taking forever
             lastlen = 0
             while True:
+                # pylint does not find future which is set above.
+                # pylint: disable=E1101
                 left = [commit for commit in self.commits
                         if not commit.future.done()]
                 if not left:
@@ -333,6 +335,8 @@ class Series(dict):
             print('Cc processing complete')
 
         for commit in self.commits:
+            # pylint does not find future which is set above.
+            # pylint: disable=E1101
             cc = commit.future.result()
             all_ccs += cc
             print(commit.patch, '\0'.join(sorted(set(cc))), file=fd)
-- 
2.34.1

