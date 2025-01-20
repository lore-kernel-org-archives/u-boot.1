Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCC9C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1975C807E1;
	Mon, 20 Jan 2025 22:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V0wYP0gG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D661080843; Mon, 20 Jan 2025 22:27:08 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A997D807E1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a9628d20f0so36904665ab.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408424; x=1738013224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVLrvMNknYakJS+q8AtcEU2uEPODcVFY6sTMn77CUoc=;
 b=V0wYP0gGVvVtz4IBF2Y6COcH81uyny8GY4eiFZ8nvNQ2zKmdsvv2FRXLMJ+xcjRJcZ
 4fcOEE87Nj+rHLhvNM6rDkd7XDU8hT6RhYfHUR454f+OMNnAj+idaF5vKqSwgKKYATDV
 wt0Tj9Y0YpGiLv0Ws8AGFoifoCP7scvUzZDP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408424; x=1738013224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVLrvMNknYakJS+q8AtcEU2uEPODcVFY6sTMn77CUoc=;
 b=RPK9mgSLvc5srcIIcQWbEWOfbNfwCVdDhd2+4wNelY6f+1ufNE2tO3+s+Dt/gJ1cRF
 vuLDjryu+w2iQ4P77n679nQ3xiiKf7BoIDbX66oMELoiIcrWl8xMKz5aB0oQoxbdtuRW
 ZgAnpz0/sLRBm8z1Ne2Yx8WJb90e2e+nLZnFzYo8B1p7e9c4wUTgrnQQ76RGTRiq/TAe
 kSxWl+0SImnjejF0XRSFfWjhn8or4T/mBK3J7XbOd0MrFt82xpYXn25M/6mLPaO4rz4F
 zWGmiWu8qfS1HzhyT3CYS8uMfLYfZYWpkfzUn7xOv8ZJ17AGZUze7H5dFhakt1EIh87S
 JdYg==
X-Gm-Message-State: AOJu0YxNmiq0LnTmsk8iPdWKk0mx4KmgD/pJZ94va9yjvG0nbSabRVXu
 Slat60hZD5Bb3cjlPwr4gGWvyvQZp0iMv4uW4tlfjhIRgirQJVpAcWjfZPlh1Oor4lUwF7NlDyc
 =
X-Gm-Gg: ASbGncviuFiEYCMLoEGDJZ4vbrP0zLpEuY1uD4GgHGu9HRMmLZWcz6nVp++/OMaieWw
 4lSijRMQSPJNKI+YejGMahK1aAnhzLfBMg9CH2pRwIGMcsspUtL9vaoZ7aAUvcKUeKalcx8HtSo
 6ovNGAn0ZkRcbxkEBe4Gpfu2iHxyOJkqSFt9mQu1pHObyVVx+D7IM5hopy7VrfrY/usxib8nl7Q
 VtTUB/RZyolLo52LBP1vOhvn+gbZ7FfnAuMmDKJEkvVh1Pbu0vNVh4O/fDbnbRejV+6/mcykCOc
 dw01ql6U17w1Ts8pYdCJQ8yUlxtcn3s=
X-Google-Smtp-Source: AGHT+IHqhzlD4pGTGcX3JR41c348kHdxjF8SbyqYlLn836hGwpmdxmoLsWut1gXd4VHNlE5HQ9je8A==
X-Received: by 2002:a05:6e02:2492:b0:3cf:5c1:5ff8 with SMTP id
 e9e14a558f8ab-3cf744b936cmr133144925ab.19.1737408424519; 
 Mon, 20 Jan 2025 13:27:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/44] test: Drop the function for running lib tests
Date: Mon, 20 Jan 2025 14:25:42 -0700
Message-ID: <20250120212613.516664-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h |  1 -
 test/cmd_ut.c         |  2 +-
 test/lib/Makefile     |  1 -
 test/lib/cmd_ut_lib.c | 19 -------------------
 4 files changed, 1 insertion(+), 22 deletions(-)
 delete mode 100644 test/lib/cmd_ut_lib.c

diff --git a/include/test/suites.h b/include/test/suites.h
index 587d6a5b473..08b35b276be 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -38,7 +38,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index db96a4ac2ac..27d090c7225 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -152,7 +152,7 @@ static struct suite suites[] = {
 	SUITE_CMD(overlay, do_ut_overlay),
 #endif
 #ifdef CONFIG_UT_LIB
-	SUITE_CMD(lib, do_ut_lib),
+	SUITE(lib),
 #endif
 #ifdef CONFIG_UT_LOG
 	SUITE_CMD(log, do_ut_log),
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 3556c4d199c..f38f4947157 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -6,7 +6,6 @@
 obj-$(CONFIG_$(XPL_)UT_COMPRESSION) += compression.o
 
 ifeq ($(CONFIG_XPL_BUILD),)
-obj-y += cmd_ut_lib.o
 obj-y += abuf.o
 obj-y += alist.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o
diff --git a/test/lib/cmd_ut_lib.c b/test/lib/cmd_ut_lib.c
deleted file mode 100644
index 90a8c0728b7..00000000000
--- a/test/lib/cmd_ut_lib.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2019 Heinrich Schuchardt <xypron.glpk@gmx.de>
- *
- * Unit tests for library functions
- */
-
-#include <command.h>
-#include <test/lib.h>
-#include <test/suites.h>
-#include <test/ut.h>
-
-int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(lib);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(lib);
-
-	return cmd_ut_category("lib", "lib_test_", tests, n_ents, argc, argv);
-}
-- 
2.43.0

