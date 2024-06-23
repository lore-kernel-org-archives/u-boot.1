Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB577C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 18:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F018388630;
	Sun, 23 Jun 2024 19:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C6X1ufNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D158587D10; Sun, 23 Jun 2024 19:56:32 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E034F88578
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-375af3538f2so15412935ab.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165388; x=1719770188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIaUHtmxOCoDPB8Dr2EtcMBBfsP4hsti4aYZcgI3OQk=;
 b=C6X1ufNe64VenVJs9zwAM3qUMahVzigpAGtPEb25ylCn/T5o6aYo4S1J+eGAzsAuEm
 SmtW0NLVBFwaQ3KN5b4/TghbsJvsd4VFXj2FbLY1JlUCYG6aoKSVeXpMo52nrLTWSAa9
 5l6BPs56Imt3aqTVDfKEj0Dfw8O1Dv9X6wP3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165388; x=1719770188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIaUHtmxOCoDPB8Dr2EtcMBBfsP4hsti4aYZcgI3OQk=;
 b=pOtqhKyWgjKWvzaufHtgGekKIYLoZQ0okyIpg7EgEhE6j9hnQ/ojj5jI9e+THJkLMf
 ncEHQmIZSOURO+4t5WbEqj02jMy6fEacqjSObpdVsUQfqAWmqshTNtuo9G0Rm/ByRWot
 ImwAkXkFtIU57xdqn6NTSxONN6fdrb40vKXA418aN1Rda3TBpiq+UJCzT4g8sDwtlwHP
 GypBLFNcMPdSxpkjarGUyBIsK5V8V1fBK1zxT0zYmF298IqNCYSkGysxpsVMJCVtCur+
 bhiacP12BZeG9zjEKemEE9EVgxIOVuXug7Ag/NogKhba9BbClKLCSoRDHDRuTm4olw3V
 YC6w==
X-Gm-Message-State: AOJu0YxrhlLxrXUlhNGpbWcKENOgWDdyg7Q6QGgZZH3+ayW4ZEeUPtFm
 9e5CUMjE6jSYZtPtXK8A259Z+JaRp9dwPf/hhXojNZ639yZSRKVfEU9WyeC18h3xgnEf7cjOwIi
 orw==
X-Google-Smtp-Source: AGHT+IGe3H6LRMdJ65/o9U+tc6l3ZQDlMQytjXMf/bynrR1biga45AN5HUafJ9lEI6betldPVWq0BA==
X-Received: by 2002:a05:6e02:180b:b0:374:9a34:9ee with SMTP id
 e9e14a558f8ab-3763f709301mr29017455ab.31.1719165388593; 
 Sun, 23 Jun 2024 10:56:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3762f2fb1bbsm13551465ab.12.2024.06.23.10.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:56:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 5/6] u_boot_pylib: Use correct coverage tool within venv
Date: Sun, 23 Jun 2024 11:56:21 -0600
Message-Id: <20240623175622.1468600-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175622.1468600-1-sjg@chromium.org>
References: <20240623175622.1468600-1-sjg@chromium.org>
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

(no changes since v1)

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

