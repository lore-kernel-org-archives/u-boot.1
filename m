Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0489DEFCE3B
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 18:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3113E838BB;
	Wed,  4 Mar 2026 19:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FoUbOr5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E71C83AA9; Wed,  4 Mar 2026 19:49:22 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AAC383642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 19:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8c9f6b78ca4so943101685a.0
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772650159; x=1773254959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zj30fUGTZ3bSvhem4rSZRFbQGzSWV9/GW1fIM9FpgH8=;
 b=FoUbOr5lDZkr90yPPrMQL5ifYp3i5+IEENjWRIG56VTg1ryanbx/XOggQIjy3xVviP
 sPZriFkJqreyWAwzxjcblHoHYpaD+qhKmypc9Pnl3bzH3zLanJzoYnZSpOIP2vZZMFmx
 gHtG5CiEY8ZVmQoXehItNevprcJJjc5xYx3j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772650159; x=1773254959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zj30fUGTZ3bSvhem4rSZRFbQGzSWV9/GW1fIM9FpgH8=;
 b=r+By63jK4Jg2auldD96X9u6SbViXxRZ9I5EBlfpS5wVSWPAOPYL6oEmx1WZA0g4pBA
 m3/yv8dFUj4oZtuYRwraLm1HoytY3WtrhnC8Kkmr6mwa6tsA8zili7d+ToiC4V5UUPEp
 SyIi3WCQOamUhQSH6i8wNZiLx5+UDaGtzsRqlks1DhsfS8ZUUhYwLD24Nwij4Pz5jvLJ
 SdLp5YtEVSq2S7SB4gcQES19NSHhHxXEa2FYUvJzlS3qJESLXQfqg2p6tGq7ZIjeTkcv
 AXk+jeCZ9nEiXk6XtAsgPW1KNl6gIHsDHLp81FZRsJbmM13sR0gfIerNMzaid0aQ4Nn6
 yPcA==
X-Gm-Message-State: AOJu0YwQBL5OzPvIDAns4m0q7sSq7aY9C56qKiFjpnBuHDsmVm/qNsgV
 DHXr55l3QQvlxoybLXoGRVhswUe/k5ZAVTCXWTENKLLcMxCy5BbhFb3DagWJAD0DQRbPc3TURqy
 GFVg=
X-Gm-Gg: ATEYQzxW2fP5M2+5LBtk///jylP6/Hc8/DWpn7hhyQYKHk/5QPEn3tsZHkNak8VK92Y
 GToPf+fsJVyfXnH59/4zp1TS92ETebN23HJXU0O89DyvAYDgaHRo+UNZPAxA9gV/LugwNtmHcs3
 SPIDR7RfEWIHh9OLFcA9H4Rb9V3kRnJDABZ2Qjow2ulg5juTQmyyQiAFENJiepK43ibLZH780h7
 ITpO+q/JLZovdglcLanWG8/y42Qs/ImrRuIZrCS51185Yh4OLAY0xJmqmhaDFr/uGaictpUTdYH
 Z40uSwR0/CiBQnvmmdmUmxEEHwIEcIwGSBa1iU4eWY/xSd3JiAO+WDTU1c3zh/PlSPRy+zN+dVh
 pQ0tCGbMhJYvh1t4Z6FrY7CLfX0rrDHbF1wAU6rUpNTRmRd41GsW0AIF8LForsYpoa+EFbg0lsK
 mUSyYohG3SE6uwGgPkXg==
X-Received: by 2002:a05:620a:45a8:b0:8cb:68ed:cc26 with SMTP id
 af79cd13be357-8cd5aed61eemr396622685a.6.1772650158653; 
 Wed, 04 Mar 2026 10:49:18 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm1653227885a.22.2026.03.04.10.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:49:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] kbuild: strip sub_make_done from test-script environment
Date: Wed,  4 Mar 2026 11:48:53 -0700
Message-ID: <20260304184900.3104058-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The exported sub_make_done variable leaks into the environment of all
child processes. When make targets like tcheck spawn independent
make-invocations with O=, those child-makes inherit sub_make_done=1,
skip the KBUILD_OUTPUT setup and try to build in the source tree.

A global 'unexport sub_make_done' cannot be used because the build
system itself re-invokes the top-level Makefile for syncconfig (via
'$(MAKE) -f $(srctree)/Makefile syncconfig'). Without sub_make_done,
that child make re-enters the KBUILD_OUTPUT block and recomputes
abs_objtree. With a relative O= path this resolves to a nested
directory (e.g. build/build/) where .config does not exist.

Instead, use 'env -u sub_make_done' in the test-target recipes so only
the test scripts see a clean environment. This allows their child make
invocations to process O= correctly without affecting internal kbuild
recursion.

This is not strictly a bugfix, but compare with:

commit 27529f1cb02d ("kbuild: skip parsing pre sub-make code for recursion")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use recipe-level env -u to avoid breaking relative O= builds

 Makefile | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 5df869213b6..65bac2e5b26 100644
--- a/Makefile
+++ b/Makefile
@@ -2737,21 +2737,19 @@ help:
 	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
 	@echo  'For further info see the ./README file'
 
-ifneq ($(filter tests pcheck qcheck tcheck,$(MAKECMDGOALS)),)
-export sub_make_done := 0
-endif
+run_tests = $(Q)env -u sub_make_done $(srctree)/test/run
 
 tests check:
-	$(srctree)/test/run
+	$(run_tests)
 
 pcheck:
-	$(srctree)/test/run parallel
+	$(run_tests) parallel
 
 qcheck:
-	$(srctree)/test/run quick
+	$(run_tests) quick
 
 tcheck:
-	$(srctree)/test/run tools
+	$(run_tests) tools
 
 # Documentation targets
 # ---------------------------------------------------------------------------
-- 
2.43.0

base-commit: 80d0a2f6016d32b4e732a4d6eae8341d68fafe5e
branch: fix-kbuild2
