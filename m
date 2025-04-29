Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160A6C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE138283E;
	Tue, 29 Apr 2025 15:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="czGlVPfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EFBF82918; Tue, 29 Apr 2025 15:24:00 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59A58297E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72bbead793dso4808130a34.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933035; x=1746537835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGCzDJmrKyCVmoceq6/ToG1p0TR5GQSISjQzqqG8nyY=;
 b=czGlVPfKK/cWC0Z5PIqO5rQkBtDWtu5M54H62sAHQHLVmPrAueWovi9syVBv9UqX81
 yBpD+/5d51rTZO3HExHxaQxVqn7984j2YKkAuYkDTxQbbBGoaN9PQ63FJspeYjZ7E0nv
 9qq/AUKtCovP1Oy3maKDykriBjoY0BUSEC00o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933035; x=1746537835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGCzDJmrKyCVmoceq6/ToG1p0TR5GQSISjQzqqG8nyY=;
 b=aXMw5cwyQC/Bv/n4MMWqLsu056u+aAuif2tXK/BO50UB7z6vc2EgP3hCya3FWTNyC0
 9DBIM1cKm1L4sUoN3OJWLNwzlY6pV2fmWJSBrWF7nablPPLb2L7uq0sR6XuWisAlHChv
 K+TFfP2Rf+6x4igcOnLVnlsUSknpvCfIcD6cX6MEZ5aL7yza66XOU/2s0pttbbRsVs37
 Wid3dtS61ZwThGuDEDdvL3OmLH4eACiLujrlTUa6lLuLUKUKTnx1u2m6r/j5wGCjJUWG
 uPO/dSp3f3Lh+BQPB1DY1hDUUlZtFuAJRlwUwO4ICc1TgmIxWv+NCaz/9g98n3dccra5
 mZZQ==
X-Gm-Message-State: AOJu0Yxc5IQeAt4gF4tl8i4AK3lAR7/gF9903wG3K8H6KyCID9K+UxmC
 7B58sfKXrONS3f8iqI8n+vH/P6GkBvaNPYKyyG4NjlCwpom5+AHa1yioQawVWixNuVb78JuEw/o
 =
X-Gm-Gg: ASbGncvxP0tLhW24bmomV1J4/TxlQ9DyY8AkNCPfrNQDLsUpfgLmze15th8cX2Qs92M
 PUNhU6e5heKDg/mG+L3ESJX87PjRDwgDX5pntqp6KB34nf6LFdNXoPgoqVV/c5O3niFO/Uc8aoc
 NZ/j17Gk4gpjzqWymk5eFUwTROjiC70iZYBh7hYgbCr+Uki0p4+Weh9NXfrYqbY5iiQi+kf8tge
 w10Fh9ZYUTz6gPot6eclBIyxcPg0GcisUi3AkFKfP3iFEP1cAs5BE+9lRZBIcP+Qet1OsVpDpMN
 lgqc3N551/P6qvPZpuFgS5VqxbxQKNO40P8p5RSmLVPoVHB/cyFe3HtK/3KGW00AcJHRo89qB9p
 ToA==
X-Google-Smtp-Source: AGHT+IGT5LJsr/LbzO8d7NsDRqyNjIOdmfR3J6GFlmka5D/E107qwgfPy90+CMp1n5j49+iIMFoY7Q==
X-Received: by 2002:a05:6830:630a:b0:72b:9c34:1361 with SMTP id
 46e09a7af769-73088b7bdb9mr2390664a34.15.1745933034881; 
 Tue, 29 Apr 2025 06:23:54 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:23:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/30] u_boot_pylib: Avoid concurrent execution of only one
 test
Date: Tue, 29 Apr 2025 07:22:04 -0600
Message-ID: <20250429132239.251756-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

There is no point in spinning up multiple processes if there is only one
test to execute. Add a check for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/test_util.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index f6b94265c9f..119ae60af33 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -191,7 +191,7 @@ def run_test_suites(toolname, debug, verbosity, test_preserve_dirs, processes,
         resultclass=FullTextTestResult,
     )
 
-    if use_concurrent and processes != 1:
+    if use_concurrent and processes != 1 and not test_name:
         suite = ConcurrentTestSuite(suite,
                 fork_for_tests(processes or multiprocessing.cpu_count()))
 
-- 
2.43.0

