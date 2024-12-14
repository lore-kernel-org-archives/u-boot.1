Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE08E77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 18:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6725A8007A;
	Sat, 14 Dec 2024 19:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lCd2XEK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B47F80073; Sat, 14 Dec 2024 19:20:47 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6868C80192
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 19:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a9cb8460f7so21629075ab.2
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 10:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734200443; x=1734805243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPJ9hEUkAkj74pHDDYFLC74XS47p2f+iEhZ5F2nrxE0=;
 b=lCd2XEK92NX0XhYjOIowsNZ0ATgg5Q9wVjKygpTWXLEjuU8nWGsXTGh1pZyRUrBh9u
 yqjvSYvJyNRWyyMTPLoQvCFfFYnFgV/E4XH8UEbNFBhcyZX99wSLYOTOWANuAfTJS1MW
 O6X3BtR/2WFr8BgRTbJg8cQcBiUiBPrNH+OA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734200443; x=1734805243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mPJ9hEUkAkj74pHDDYFLC74XS47p2f+iEhZ5F2nrxE0=;
 b=dovGy2CJqn4G2ZAvuEy7EUg1ll5kWwu4tGC8DIBr3PS+lQ23lV9kW/VhErVxQjSu5o
 tsLJsWNh8fg5Tw0kt9SI8EqzlSciTHviQqAzrx4exAlTZ/PbvCIKA18L5df6kIvw3F32
 UwCZjkNRom1ZG+9pbFdXud15GotPjJ6rxhVbaUI3mpy2zsX+S0sqIEZoLrUXf0iCGbKk
 MJn3+XSs7dfDVICaq4wZ0UCZ4JsyudaK8HVY2Af6/+2DD6s584Uf//3nZRN0rpj5Stw3
 AmgL8lSB0/Bv/V0HlKgVhYay/JrPYWaJF37EDG11JvmYrv42/FrCMQkJuUsTH1uglC9D
 /eBQ==
X-Gm-Message-State: AOJu0Yzk3QWOMnfbNsVmV76IEq13UaQuhLc/rYYhW+ts3b3g60Jkgijc
 OOC6HzjL3FT5tNJodwuWgdGdRtIPwNhKV8f1vyEdI8xdRjiSk8wmomrT7/dfClm2Jde1DAucA70
 =
X-Gm-Gg: ASbGncuy9hCDdbSW836OmR2kXpVSG+suD9Vg2uvPHA4aSm4N+fuHjtsAw2OTOKe2yF2
 kHYCSdbBwXQEmaNOcHwJSBvwStWRKqacBKTYo7ocr1jq7iDx8PSbC3ydWeNO+wlenKh00TtZOiT
 z5R0dAKDC0QDmlOfVd5SW0fxHoW353874grwsnpCfKEIhLJmPxeEoyMXAloQvPzLqkRmD7HHHxa
 QSDbtSUzrZlofW6n0UDMo5aF4V0YqKNaEkWegD9pdgScxvnqAwVOGa2A9Dgo7J83UYyoptb/EtU
 jkTCEt0BOM5P+4wDyw==
X-Google-Smtp-Source: AGHT+IF2Edl4JSX+FbwhNPUmK9eJncLqyqKUMFrPfAJMfmU6xc324PghID8ac9LrRZs+fl4oeQ7Pfg==
X-Received: by 2002:a05:6e02:1948:b0:3a7:8c3f:edce with SMTP id
 e9e14a558f8ab-3aff4619adamr81120335ab.3.1734200443183; 
 Sat, 14 Dec 2024 10:20:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5dd620e20sm415135173.0.2024.12.14.10.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 10:20:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH 4/5] buildman: Record an error if a toolchain is missing
Date: Sat, 14 Dec 2024 11:20:23 -0700
Message-Id: <20241214182024.1954974-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241214182024.1954974-1-sjg@chromium.org>
References: <20241214182024.1954974-1-sjg@chromium.org>
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

Buildman has always treated the lack of a toolchain as an infrastructure
problem rather than a build failure.

However the logic for this is not correct, since it does not write a
'done' file in this case.

As a result, one of two things can happen.

1. If a previous build ran in the same (output) directory, the outcome
   of *that* build is recorded as the outcome of this one
2. Otherwise, no outcome is recorded

Obviously this inconsistency is not ideal. While (2) is rare, it can be
very confusing as the build sort-of fails but does not produce any
summary output with 'buildman -s'

Overall it seems better to attribute a toolchain issue to the boards
that it affects. This results in clear failures which can be examined,
no matter what happened in the .bm-work directory previously.

So write a 'done' file for each build when a toolchain is missing.

The end result of this patch is to make missing toolchains much more
obvious. It should be things a bit easier for novice users.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builderthread.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index b5afee61aff..29e6cf32af1 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -19,6 +19,7 @@ import threading
 from buildman import cfgutil
 from patman import gitutil
 from u_boot_pylib import command
+from u_boot_pylib import tools
 
 RETURN_CODE_RETRY = -1
 BASE_ELF_FILENAMES = ['u-boot', 'spl/u-boot-spl', 'tpl/u-boot-tpl']
@@ -555,10 +556,10 @@ class BuilderThread(threading.Thread):
         if result.return_code < 0:
             return
 
+        done_file = self.builder.get_done_file(result.commit_upto,
+                result.brd.target)
         if result.toolchain:
             # Write the build result and toolchain information.
-            done_file = self.builder.get_done_file(result.commit_upto,
-                    result.brd.target)
             with open(done_file, 'w', encoding='utf-8') as outf:
                 if maybe_aborted:
                     # Special code to indicate we need to retry
@@ -638,6 +639,9 @@ class BuilderThread(threading.Thread):
                                 result.brd.target)
                 with open(sizes, 'w', encoding='utf-8') as outf:
                     print('\n'.join(lines), file=outf)
+        else:
+            # Indicate that the build failure due to lack of toolchain
+            tools.write_file(done_file, '2\n', binary=False)
 
         if not work_in_output:
             # Write out the configuration files, with a special case for SPL
-- 
2.34.1

