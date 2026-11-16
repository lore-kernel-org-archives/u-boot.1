Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60C606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H1KwcIAQ;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=s4YeX6q4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A2D560824;
	Mon, 16 Nov 2026 11:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qU6X-LZydOTy; Mon, 16 Nov 2026 10:59:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E231C607A3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826799;
	b=AmUL8PwNDd0/s8ZpeMJ84ITB3jRAk3uxHRw9U9zp8z5W7Ab1vYaF5cYWvU4cMXOlYEJk
	 zWAym047on2R1vYNY7ElM5AbzAH+Nx4X8rwy1iO/JYHeBzUNTBm/xP70WcgsA8Y/lz4Lw
	 Fuahwskwts6IXCnGmy7QVvFmvwXHuY1bGnCz9B2d59ImRZ7FINj/mGzo3x1G9qcCJ98Q4
	 46AMLTKfFcJefr2Lxstct5B2fvix73gOuTEzw2cEqE1SpPkdbD+lgTTzuhVYf3Q8JnqY8
	 MhizzzZ3DpnqMtkA63E3+SIuw5KzUOxlD84SvDmQIgJ7uTRxBFe1Vh7bPxjowEu2Amg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+apbvMt7AamGZlDDWJoSf/aZgtGSM07yfTVZ/5VqX0E=;
	b=sxLKT3U3VqicQyersZu2n44mPsIdPt2QIuxk3KUwE30jt+Nc8YKaH2DaPw5nU7+H7jwl
	 VftfVnGzgFypj5RBFG8o5zne2Knh3ZemQGo3y2kHc95er+sOiS04XPXK71T3Fu1kcA4Vw
	 tXeuK39tJ6yyk15zko5J8/9KRF7LshAQuEqVnZRZHroR3sgaAkvBz3cZPM9dQiBcq9xEK
	 rHCgfHzzLs9W4YZw7WjUVEuVyY/+K0oHl+AnkB2zG7Pl0HH71F6NB1Ih2y4wGm4z1n9i9
	 1bJCvZe2g0dSlRmj6WcKeuYfknESQyvFBCg4pCc6lE+VJEfDl1WZe6BYO3MGxWUDvzA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826799;
	bh=+apbvMt7AamGZlDDWJoSf/aZgtGSM07yfTVZ/5VqX0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H1KwcIAQHAq9p0+h5K7HYt8ddMXdXI74oGfXzQi1GI+8Qdmv79gWTLWfU6wN0PQwh
	 cdIXHOR3igfKYluu8WUbMxVrzlSaMksl6j1iKo6FhLzKb0XHoicmvZgFGyJnrTRS1d
	 GqEkIvMuyJrMHyIHKoWhGLp008EqeoC5tAzmjssZXCdPo3S0jjz13dxRUlBW+/oRIp
	 UFJNcn/BNLhIYbr4bOUDH9RN088JtYVs+zH8Q/7uSpjPmI/riV1HeDQkVDxFWaCUcM
	 HzFK1yS3WI/jctTWkXyiq1C5wzu8pd9pV8STIN3ztls+JgXsknUCRqHUOPwiSyqd4n
	 TWPyD7RbJvwYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E231C607A3;
	Mon, 16 Nov 2026 10:59:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 934104DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85A3E40068
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pA7SeD7upFqy for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 831E040070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=s4YeX6q4
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 831E040070
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:39 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso19639225e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826777; x=1795431577;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+apbvMt7AamGZlDDWJoSf/aZgtGSM07yfTVZ/5VqX0E=;
 b=s4YeX6q4A5m6glryTb5ZmjsWtRO071QSeNRdt5HhjYHvqDhgWQuR+i7toVL0UCIMMR
 Pt6hufDJiad88lywpcm+iIN9s7SME4RGEzUklQyB569EuXpo05MgAYzYmduaUyOeryET
 CSNh+NZhcTWAysnX4P+sNDv8RQNmARFEayU4Im9FUcZyAoYkXOiETPB+p74vPC7zMyya
 XvCCgVHuYpPd1C2mvpBRWx4dIz/HAzzQyDEkxuPr4AaxU1rOIw0BljKAQM2Uui9GrRMn
 5T8qubHJvZU6wUmWugbZbuVwxACiIM9kPF066y58zt9hLiDitqTy6DtjgwcWANdyTt1x
 EyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826777; x=1795431577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+apbvMt7AamGZlDDWJoSf/aZgtGSM07yfTVZ/5VqX0E=;
 b=BQ0Y8L8UQLDm1rU00UMLDaAgj7XsNZifL/hg98R7tCL4qDxF6nl8JT7w07dMw8d2zW
 fgOkLA4krBYIZx66qTDKtGT0CL5sbqqlwtp8gMr+dkar2xxkx2YoyLVv7hwuw/xSvxcS
 1wSP4UNB8M7H3QOr2scTCcFJ0NicNoy++uBO7kFOnWaZe2zvcXM4OjjC+7uqNRCBeEfZ
 2R8mGq8PkaE19qoFAQtBXKqu7koQHqyNjNV7baC1L1ysOhpIoKx6pHo85IxBd80njSGN
 XmPIAwR8Ks/t78h6gAcdOE56ZTb7mqPfL/4FBNvO0R76WMYMyFxoaCVemjqippph4osE
 tUsA==
X-Gm-Message-State: APuU4Z8f0PhePmTbZsiSkyf+NeKQw0unvwmoR/0OS9vCoiblSC0bctJz
 2rTaDJhe4xWgc9AK1N0jglASOU9VXU4pWfO5T3jHaUz7uEe7UTZAYU0pxsOoXuSTlGk=
X-Gm-Gg: AYBFou3ZzP2Oek0WmX4bWg07zdv1jcLJMSdh6AwROc4N+RAiy2worydHweeVdT9Mqkv
 q2APtGE9hnAxAD07+WLmlpLwETxzbyn7Y4Y0tD5rDyL3ORsJQLFaMEwnfJj7daFjgEOnQcI6hlL
 6WKJyTdaBN2C7jcsyd6dKEnttLxOoY5kY6LK679v6SH5sYkDLNdejwExfbYmpoU0WnmDpbU92yH
 +WVJAy3BZePiwYlyuSPUPabJg7Bv7CSMIYCqrsjPf3AhI4jJztWk+dS5HXdGouG58yO2D33szWp
 n7zMUcFDEU/fB5CSj2Rs5b8Rp8jfvt1wfTRAdesaODq5aPyHUU4fdgOkYaH+jT/vFzAgmQEU0WU
 nrmI+uSrwMlAs73DRKnHHDQRgExAcUg3g2Y+mPi9KGrEsXooLk6WpmI41TL/z+5gBJmTSavrvBb
 N2who7C/cVHzQ18qpDAqTNyPIxcim/iJkMUW+W7RMzVE+b4wEtNb1apXeiNE/O39tvMwGUGQAue
 dlS9KIZYz4RwIpVkLLsmApJZUZ2p0wXBhEfp6OZoN+sZS0+sibOLyeST9KVePrK95bVb3ltcZTf
 WW2BsA657kdXDX54anQZ9u36CvRvED0wJJpmKu9ogBDcPU8+
X-Received: by 2002:a05:600c:8b8a:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4bb55abbadamr220926865e9.31.1794826777088; 
 Mon, 16 Nov 2026 02:59:37 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:36 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:33 +0000
Subject: [PATCH v3 13/15] buildman: Cope with CPP="gcc -E"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-13-b6cf7e96944b@linaro.org>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
In-Reply-To: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow the use of "gcc -E" as an alternative to "cpp" when set in the
environment as the value of CPP. Accept it as a valid command for
running the preprocessor and adjust the test to not depend on a fixed
number of arguments. Also split it into parts for constructing the
command list so that the validation for running a command does not fail
when it tries to find an executable named "gcc -E".
As well as -E accept --preprocess. Also accept clang instead of gcc.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/buildman/boards.py    |  4 ++--
 tools/buildman/func_test.py | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
index 5d5d3a3822b..1e871c9921d 100644
--- a/tools/buildman/boards.py
+++ b/tools/buildman/boards.py
@@ -12,6 +12,7 @@ import glob
 import multiprocessing
 import os
 import re
+import shlex
 import sys
 import tempfile
 import time
@@ -244,8 +245,7 @@ class KconfigScanner:
 
         temp = None
         if b'#include' in tools.read_file(defconfig):
-            cmd = [
-                os.getenv('CPP', 'cpp'),
+            cmd = shlex.split(os.getenv('CPP', 'cpp')) + [
                 '-nostdinc', '-P',
                 '-I', self._srctree,
                 '-undef',
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index fce615ba8b8..7a5f9ba22c1 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -378,7 +378,12 @@ class TestFunctional(unittest.TestCase):
     def _HandleCommandCpp(self, args):
         # args ['-nostdinc', '-P', '-I', '/tmp/tmp7f17xk_o/src', '-undef',
         # '-x', 'assembler-with-cpp', fname]
-        fname = args[7]
+        # If 'gcc -E' is defined as the preprocessor then the args list will
+        # have an additional item, '-E', at the beginning which changes the
+        # number of items in the argument list. In order to guarantee picking
+        # up the filename use -1 as the position which will always be the last
+        # item
+        fname = args[-1]
         buf = io.StringIO()
         for line in tools.read_file(fname, False).splitlines():
             if line.startswith('#include'):
@@ -424,7 +429,9 @@ class TestFunctional(unittest.TestCase):
             return self._HandleCommandObjcopy(args)
         elif cmd.endswith( 'size'):
             return self._HandleCommandSize(args)
-        elif cmd.endswith( 'cpp'):
+        elif cmd.endswith('cpp') \
+                or ((cmd.endswith('gcc') or cmd.endswith('clang')) \
+                and ('-E' in pipe_list[0] or '--preprocess' in pipe_list[0])):
             return self._HandleCommandCpp(args)
 
         if not result:

-- 
2.47.3

