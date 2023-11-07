Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF39C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9771F87671;
	Tue,  7 Nov 2023 22:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XhfqwUg5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3C8876A4; Tue,  7 Nov 2023 22:42:39 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A9487627
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso46749645e9.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393344; x=1699998144;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/ye0sW93OPRLvPu3qJ3fSHnxCSBl7aUl+BZ/vbc20w=;
 b=XhfqwUg5v9TxyaXyc9AMLcKCLDfwEErPJYugGt6Ett0KsVxZC0ybi+5RP8DNn3HNRA
 9wOb6BiniP4GwxFMU8zSkhqj6XzuOIGejJ8QLWPe/UZprMfeS3ZHb4GA4GoJuEQe4k5D
 gV/uGiDPIDC5HffFIVx28n5UG02S3R74AfAjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393344; x=1699998144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/ye0sW93OPRLvPu3qJ3fSHnxCSBl7aUl+BZ/vbc20w=;
 b=FAQmFvgSKeemCRVclLv4KZy/nGi462SyRe2Gqh5+9AKdptxyXSxKwIIfc97KO3xMGk
 ty2dI8rVOxIY2kM7QKHzdoTBQFLimpPZ7jHXdhzQdHnsgw9F2xl4wUPEfW3xFI2CVpO8
 /1CLxBKAtJUE0AVQx1uG00gzAMtN73JxbppgAWgiObDCF4CE+i3B34VrWF5MKozz1J8V
 J3WhrnTCTLJvhJ7ov7/7jaJ6q52GBXYlHndxevHIEBRaJMbSGlY2CB84EK55oonJqALl
 7cxsytzOK+AEFjv3utmK4dLx51PseFj4HjuLp/zVEI9Yxsx9zWJSHTNQE/XfhfPsqMi2
 yHTg==
X-Gm-Message-State: AOJu0YxDkEehsxAiytdw7wZVAZWvJ4Msh+aIoIuMKPIOx2ppatRwyivx
 d3XGFJqzz14OAo+YeteVKuoKzJ7XA/FusaSVWWc=
X-Google-Smtp-Source: AGHT+IFFfA9IMB4nKz2LnSj20c8Q0SkAZeZD/gGepHXMHVsl4dXQ0w2p1zLxD/MrmET5j8eYRbsj+g==
X-Received: by 2002:adf:f88e:0:b0:32f:7c24:e049 with SMTP id
 u14-20020adff88e000000b0032f7c24e049mr11511wrp.71.1699393344339; 
 Tue, 07 Nov 2023 13:42:24 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:24 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tony Dinh <mibodhi@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Michael Walle <michael@walle.cc>, John Keeping <john@metanate.com>
Subject: [PATCH v11 23/24] DO NOT MERGE: only to make CI happy
Date: Tue,  7 Nov 2023 23:41:20 +0200
Message-Id: <20231107214121.132079-24-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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
index 4641333809..3c36833f4d 100644
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

