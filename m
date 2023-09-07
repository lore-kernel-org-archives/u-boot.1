Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7893DEC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F82986AD8;
	Thu,  7 Sep 2023 18:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Je6YKE+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32EAB86B3B; Thu,  7 Sep 2023 18:00:33 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C320D86A88
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-77ac14ff51bso47767939f.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102426; x=1694707226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xD5RxK+XMIDAPUevKuxM+4fM45QZifEiRyKnEpplT8Y=;
 b=Je6YKE+LdJP4muchGDC1wnbASruMyOxM5ehZa3tLN3zKkcTag844eP/RVQvihHcH3S
 zOudtOIbJMGztJRnVg09rZOVt65LYInjHrAeTxUMndTwFOqN2LNJjZYj+X6skahbrupr
 fFDfgeB+2q9+NtLmIV+bBPIHpMUyRJ5qpUSKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102426; x=1694707226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xD5RxK+XMIDAPUevKuxM+4fM45QZifEiRyKnEpplT8Y=;
 b=P1sI4tR9qGPb+j4VXOh0zhxGYab9J+O9hG74cX28D5kdfg3COdoVTuvb+/Z2kwuNnP
 U/pXYZrvGcya96Kqx3qro1vwYGuVReS4fGCZhe8P0cc/b5SCcelQ+xbo/lcCCH2z029c
 /CCzvNUAuf2tPem1XBbHl/hSOTI+p05oJlUwhBSIowVITFMTzN8kWMKD3smkF5JQIKTY
 zxDUyMTffQsjKJxCuAO8K4314kmbi8UWjQY51X2sgkiL//cn5YQuLEmsxCSUjUeByTJm
 DDdIjKKgaoOlNUqWvXA0Ikgct7DrgKPkQFIvrec8NOpLWQf3FMElH6U1FTK67zzAmpt3
 GnMg==
X-Gm-Message-State: AOJu0YxXaS0q+R/sXA13rUwzgpaWrZfQpwxgwd96vPB6cB/efUEtLNVG
 jedw3GsQVwLTQYD2ZzRnidCquikXjFWN/N+tnbs=
X-Google-Smtp-Source: AGHT+IHe9R5njUKma5OK1m8K6TpRuC5lzwb1e7cMLxJu7wyKN9G6c9ZEWxkHfn9kOsffaVdmnaEUuw==
X-Received: by 2002:a6b:7f43:0:b0:792:8d16:91ea with SMTP id
 m3-20020a6b7f43000000b007928d1691eamr182016ioq.0.1694102426391; 
 Thu, 07 Sep 2023 09:00:26 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a02a805000000b0042b39b2289asm5699209jaj.102.2023.09.07.09.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:00:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/4] buildman: Keep all common output files
Date: Thu,  7 Sep 2023 10:00:17 -0600
Message-ID: <20230907160023.49339-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907160023.49339-1-sjg@chromium.org>
References: <20230907160023.49339-1-sjg@chromium.org>
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

Make a list of common output extensions and use it to ensure that the -k
option preserves all of these.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Redo patch based on dropping the binman restriction

 tools/buildman/builderthread.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 25f460c207db..6a61f64da1d4 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -23,6 +23,9 @@ from u_boot_pylib import command
 RETURN_CODE_RETRY = -1
 BASE_ELF_FILENAMES = ['u-boot', 'spl/u-boot-spl', 'tpl/u-boot-tpl']
 
+# Common extensions for images
+COMMON_EXTS = ['.bin', '.rom', '.itb', '.img']
+
 def mkdir(dirname, parents=False):
     """Make a directory if it doesn't already exist.
 
@@ -636,10 +639,11 @@ class BuilderThread(threading.Thread):
 
             # Now write the actual build output
             if keep_outputs:
-                copy_files(
-                    result.out_dir, build_dir, '',
-                    ['u-boot*', '*.bin', '*.map', '*.img', 'MLO', 'SPL',
-                     'include/autoconf.mk', 'spl/u-boot-spl*'])
+                to_copy = ['u-boot*', '*.map', 'MLO', 'SPL',
+                           'include/autoconf.mk', 'spl/u-boot-spl*',
+                           'tpl/u-boot-tpl*', 'vpl/u-boot-vpl*']
+                to_copy += [f'*{ext}' for ext in COMMON_EXTS]
+                copy_files(result.out_dir, build_dir, '', to_copy)
 
     def _send_result(self, result):
         """Send a result to the builder for processing
-- 
2.42.0.283.g2d96d420d3-goog

