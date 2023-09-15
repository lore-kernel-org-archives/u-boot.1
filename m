Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E13EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5916A868C1;
	Fri, 15 Sep 2023 02:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XNm8/O7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA90586823; Fri, 15 Sep 2023 02:22:52 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C087B864C7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-792707f78b5so55547339f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737369; x=1695342169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qG4hY09LmLXEmxs/SRkA5fG7N0yoXGBDGkgwADjTfIY=;
 b=XNm8/O7b0zPWoh/az/zElipw6+l05ma91u9K6oxxOUMt5V/jtlDBWv5DidaXd7pjBs
 5ayhIRAy6f1mk2QNdDwJeOnLbz5U9l3mAOJlSnRuPxizAab8OwuuARX9o+3TfVweK7Pt
 H52VW9LJg2sKN92M8Wi8FPD7uFOD88o76NrSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737369; x=1695342169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qG4hY09LmLXEmxs/SRkA5fG7N0yoXGBDGkgwADjTfIY=;
 b=wXAQcRlIwaCvjP4sby6bEQ21fgTEqzZ6mlvl27KPwo6a6mxeV0VJePIjVCy2V4+3Fk
 Igq8/jsB2g2WGwFVJgwWopLCABJMUeeWEmNF/ndo23cT7UxrhgysECZV1wHjEYwGOKA9
 dgIXspWJjcFWBZqHEWAvT2foIcnCG7gx5w+x5A0iEpbsLNlFYdAB5lxlnkMDVR3iNIdp
 az8c8NnWZH8BMCeiy2lGnrNsm/fvY+hINz7tBcT7hDQ8kTRuZGcZPL5zzQJkHA5WsDtE
 kQIcV2p40AVGkGMrB+YVI/eBDnP6EKEpOurNLZZlJ18HpR2TqGezY2HK1BI74xPc/iEK
 ulAQ==
X-Gm-Message-State: AOJu0Yyjk8x+gc0nzBjPrN1GuGB3njbT72FzIq1ocLzU2hKoJYo2VFzv
 PzmVROXqZfYW3zwmYMU4MIoW52MO4eoJlpNLyVI=
X-Google-Smtp-Source: AGHT+IE2oW/nEfYhRayqfbTyslT3nd31wKk2WrNLbd8B8JZdWJ0bogW5nxqUcoiwZCxb8gFjKUTjdw==
X-Received: by 2002:a5d:9697:0:b0:794:d833:4a8a with SMTP id
 m23-20020a5d9697000000b00794d8334a8amr86346ion.0.1694737369464; 
 Thu, 14 Sep 2023 17:22:49 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 02/27] moveconfig: Avoid deprecation warning for setDaemon
Date: Thu, 14 Sep 2023 18:22:04 -0600
Message-ID: <20230915002236.798760-3-sjg@chromium.org>
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

Use the recommended new way of setting a thread to be a daemon.

This avoids a warning:

   DeprecationWarning: setDaemon() is deprecated, set the daemon attribute
      instead

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 880a5594be05..2f7dee88c7ee 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -2029,7 +2029,7 @@ doc/develop/moveconfig.rst for documentation.'''
     config_db = {}
     db_queue = queue.Queue()
     t = DatabaseThread(config_db, db_queue)
-    t.setDaemon(True)
+    t.daemon = True
     t.start()
 
     check_clean_directory()
-- 
2.42.0.459.ge4e396fd5e-goog

