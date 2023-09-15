Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D6EEEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6667868D7;
	Fri, 15 Sep 2023 02:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NOwMeEIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B6A9864C7; Fri, 15 Sep 2023 02:22:53 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 797AC867C7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so43182239f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737370; x=1695342170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZp340yufFOpfOQYv2VU1ug3gX5JFmPTtu3Y5DE+gco=;
 b=NOwMeEIgBMZtwNN4pCz2cVHPuQI306qAwtKldJEjg7x5RleI9bTmZxH5L764GNVb96
 cp99pQz95Vej3fBFPDEQUFQRiGOzmdxoaUeqY05E2It9W0XbPu8WmAxY1bs2so2VwAt8
 cBgPeKDKoCo6uzcjnQdJJcN8avVDKQxz1WhJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737370; x=1695342170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZp340yufFOpfOQYv2VU1ug3gX5JFmPTtu3Y5DE+gco=;
 b=H6NhE85nj5hNy2AMfthQJ7Ye7smFHjclmIeAGbIXUMHyDCuwtdts8aOe+LUiAm7Yzi
 oIhxXxZRBQEgZ4VU5A0FG4JBVfzxMsZbRaT3VJWNCn0ANi/eyZrbk81XWMwlyloWaiqK
 Cx5B1JYMRCTwfXfHjxzr8Y/W31uS2QLvWF6QEu7x8/3KqsetymMTW8xBuX8S05zv2GlZ
 YdcpZLJ5cSC/KqDMuHfXRZRmTeO6sKiIa4+CTWbEAAQxhBg9c27KUP4OkVyYPJEtwMYJ
 cwsMFkAYrf3Tm2jGfZV+jJ4m7TZAaPBIYuVI7WHIC/CI+dz6rbE+c14+KPU0Qx8zdTw7
 lxBw==
X-Gm-Message-State: AOJu0YxwdO4dwoD3o7DUJ4qy19ddkfNYZoRh/AqUm8ooMaHaK+aImLBW
 3p1J5zs0TllTjZLps6rhaHIpx2M28T/2qKC6Bv8=
X-Google-Smtp-Source: AGHT+IGGNq/pBH88SDMhPHMpvDGQdMoTinXIvrDUa5vaHIcLvy4m7WBFqfUYRjrhERIj35+Yn9SN+Q==
X-Received: by 2002:a05:6602:2bd2:b0:795:d33:861f with SMTP id
 s18-20020a0566022bd200b007950d33861fmr2947548iov.6.1694737370150; 
 Thu, 14 Sep 2023 17:22:50 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/27] moveconfig: Correct ordering of asteval import
Date: Thu, 14 Sep 2023 18:22:05 -0600
Message-ID: <20230915002236.798760-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

This should be after the standard imports. Move it to avoid a lot of
pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 2f7dee88c7ee..a6dbda7bd0ea 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -11,7 +11,6 @@ See doc/develop/moveconfig.rst for documentation.
 """
 
 from argparse import ArgumentParser
-import asteval
 import collections
 from contextlib import ExitStack
 import copy
@@ -32,6 +31,7 @@ import threading
 import time
 import unittest
 
+import asteval
 from buildman import bsettings
 from buildman import kconfiglib
 from buildman import toolchain
-- 
2.42.0.459.ge4e396fd5e-goog

