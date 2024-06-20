Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6E4C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 13:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A1A88551;
	Thu, 20 Jun 2024 15:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z0SnTP1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D524E8839C; Thu, 20 Jun 2024 15:19:56 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB5D8846F
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-37594abcee7so3183125ab.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718889593; x=1719494393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlA9WNcIVyh8Ut8GQyUi+rz+ihpKo5MPTm/rUe0Ascg=;
 b=Z0SnTP1pmgk7ORe99LL+KxlVHZ8Mi4mLrE9C3Hs09XmtFwl+StpRXG1K3Rb0tkIHIv
 E1VvJ43zwiEmoTDlGA8+HnuNvH3WnJDFWKJ8HAjlEInkJ00B8L5axd6CfF8XOm+SNJfl
 VVysGWxb/dwmLJ/zR4dQo7rMFD1hJ7DnrHlIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718889593; x=1719494393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlA9WNcIVyh8Ut8GQyUi+rz+ihpKo5MPTm/rUe0Ascg=;
 b=T5evutr7nBjuNyzgnoNGDiTd705GCoWaLxbHzeX+yNm/Ebd1gASOm7l+4uc8hbr5Iw
 Dk+T89x3qIuwMzkYYkw1Sx03kJL8xZb9ME2LikFKqD4BqsFPZ5BQ4WZUm3o0sEBJqS05
 fmuVu+n6GZZJMlmAg2b3aZPhI+B52fIaR4yYi7FG08UgHfFHBWFHRnSf+SrfpFGojpOM
 T76XeiAz+Pwa3f3rgMskvRNFktV54j6qVb4np5ro7u9JMduLmkxG5wj1lWXbDmb8ccVJ
 NWqrlfXCCir3XKqwRvkI1qaFajGPdqYW8fIMbUKjE2/3+fyKSkxT1+hOzVzXwTB/IjR0
 0arg==
X-Gm-Message-State: AOJu0YzNTKQ1/rmWBCfCQL1lIiLO1QwVvdV48J716zSvKygnCIV2otVJ
 uoVGZji2OURfSr0HRTsCXSglTwTnyy8769NcJYC6bRGCi0Wqnr9XnWn5MggA0ayx3ilK0Ojxn9G
 e7A==
X-Google-Smtp-Source: AGHT+IEyB/bNO6RwEO2XAEY3tfG8PX69ejk54FeDqh/plB5Zkc7W7nVCInu62v5kVUhdgi3RxblDhw==
X-Received: by 2002:a92:c24d:0:b0:375:be9e:34da with SMTP id
 e9e14a558f8ab-3761d685e71mr57520555ab.2.1718889593359; 
 Thu, 20 Jun 2024 06:19:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375d866e260sm31807865ab.7.2024.06.20.06.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:19:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/5] u_boot_pylib: Use correct coverage tool within venv
Date: Thu, 20 Jun 2024 07:19:36 -0600
Message-Id: <20240620131937.1130446-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620131937.1130446-1-sjg@chromium.org>
References: <20240620131937.1130446-1-sjg@chromium.org>
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

When running within a Python venv we must use the 'coverage' tool (which
is within the venv) so that the venv packages are used in preference to
system packages. Otherwise the coverage tests run in a different
environment from the normal tests and may fail due to missing packages.

Handle this by detecting the venv and changing the tool name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/test_util.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index f18d385d995..857ce58c98c 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -60,12 +60,17 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir, required=None
     prefix = ''
     if build_dir:
         prefix = 'PYTHONPATH=$PYTHONPATH:%s/sandbox_spl/tools ' % build_dir
-    cmd = ('%spython3-coverage run '
-           '--omit "%s" %s %s %s %s' % (prefix, ','.join(glob_list),
+
+    # Detect a Python virtualenv and use 'coverage' instead
+    covtool = ('python3-coverage' if sys.prefix == sys.base_prefix else
+               'coverage')
+
+    cmd = ('%s%s run '
+           '--omit "%s" %s %s %s %s' % (prefix, covtool, ','.join(glob_list),
                                         prog, extra_args or '', test_cmd,
                                         single_thread or '-P1'))
     os.system(cmd)
-    stdout = command.output('python3-coverage', 'report')
+    stdout = command.output(covtool, 'report')
     lines = stdout.splitlines()
     if required:
         # Convert '/path/to/name.py' just the module name 'name'
-- 
2.34.1

