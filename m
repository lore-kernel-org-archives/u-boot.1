Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F89BFCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9730B84082;
	Fri,  6 Mar 2026 19:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CI714ZYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5E08405A; Fri,  6 Mar 2026 19:14:27 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A36A84067
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8cd75abd09dso18511885a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820863; x=1773425663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BqNnKSi0OGO7Ou3oXVoEMj+qTiLQectdTqUfMmgqH58=;
 b=CI714ZYYDORSF/gf8/4Osk2UzfgxGQBBFSauQoiHsLfnB+vJliXnRNWQeg8s8jZoHT
 MHuNTz688eEnUcn/u1hTNamaC5U9jMMjG+9YEbS9qG8d28iDenT26o7xJjKc1SDPHRhT
 2oV9xnFGgFyMGTBMFyBZbMu12k72WrzAbsAkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820863; x=1773425663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BqNnKSi0OGO7Ou3oXVoEMj+qTiLQectdTqUfMmgqH58=;
 b=ApRK4cqtIk5ksfQjrSWuarszsNgP6tWa2SILxGwtlcGsXtyojA2sVPFDMP6qc1/+Uq
 DsE/nzGXDT2VFbC/2IkGNc/jYdq1BiO/tqz6YSGp3wDBBXuRKoyiTVqUvlQfXUuQk541
 I+MonQbviG+5REW0r8on02V3ZRfFbIbFqXwoCCbG42Hu8/os9DGK8URPaIzI7wLmI1os
 3diGsYoeFee9LvQ+ypethCm3BO2m1P/6yhrnsQDsk2LtDHVyq+vWnOWKmboeKV4uVJqL
 dnRKX/usI+KQ9Axm/hrrvuyDUFSU3WhHfuEzxrUnnUHc6wse7m+7h+jZhsuZp/jlNyyu
 ZmFw==
X-Gm-Message-State: AOJu0Ywvpx7NqIfKyeaNLPv4w86Nb2AxW9uSeOAaH7q3PBW1BjRVvR13
 PrALzGKhWHICYrskgSqd2EO33/vA/oQHLS5ndUPX5ADKDbOK8laTTBzWGzIzVsdfAOnAAy354fc
 qA0U=
X-Gm-Gg: ATEYQzwU2A0gb0Pv/0zLW8g7+BYIlc8t5HTQt5PS3xGLk+eZCrctv3O5mZAx2I/vpTx
 BiMNdiHs9henzuKzluSd3Fch1fVLkXo8JRK60dj8XXq8OIEP4Eb4Rf4SSZ2pUj5EdGMG5sX0aE5
 nCXNxMGCGg0X+W+DD8hLDfNtcOyyf1m7w6CfLvcO6Q7zdK4l3ynbW7T7JpwnnRjaVNl6EVihha9
 9YbOK/ZoVye8nw076C+Rw/4Ihsy7j8OPdS9dHFxpQkBQ/9F9R6mWyR1IGXr/9OS8EzQ4RjnKKtD
 mWkfyohnyYDfZxtyqqKHzzFrikUk3rIcBqftSwt65v3xZiLlxJqUUKT/a5Cn88yMQ2/fn8BGBlh
 ngETEO2T3/I3PUo2GAM55YyLbp2UMnUR6qpfExtu/xUtBdeAjo+umdxyjVTrZkVAlLP3aiDHz6J
 fWJ9smE6Cm8H8pALGfqw==
X-Received: by 2002:a05:620a:45aa:b0:8cb:50d6:18c4 with SMTP id
 af79cd13be357-8cd6d3ea36cmr408761185a.11.1772820863370; 
 Fri, 06 Mar 2026 10:14:23 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:14:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 22/23] binman: Drop the allow_failures parameter from
 run_test_coverage()
Date: Fri,  6 Mar 2026 11:12:50 -0700
Message-ID: <20260306181304.2426352-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306181304.2426352-1-sjg@chromium.org>
References: <20260306181304.2426352-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

The allow_failures parameter in run_test_coverage() is no longer used
by any caller.

Drop it.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 tools/u_boot_pylib/test_util.py | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index d258a1935c9..364596d7a0c 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -24,7 +24,7 @@ except:
 
 def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
                       required=None, extra_args=None, single_thread='-P1',
-                      args=None, allow_failures=None):
+                      args=None):
     """Run tests and check that we get 100% coverage
 
     Args:
@@ -95,19 +95,6 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
         print('Coverage error: %s, but should be 100%%' % coverage)
         ok = False
     if not ok:
-        if allow_failures:
-            # for line in lines:
-                # print('.', line, re.match(r'^(tools/.*py) *\d+ *(\d+) *(\d+)%$', line))
-            lines = [re.match(r'^(tools/.*py) *\d+ *(\d+) *\d+%$', line)
-                     for line in stdout.splitlines()]
-            bad = []
-            for mat in lines:
-                if mat and mat.group(2) != '0':
-                    fname = mat.group(1)
-                    if fname not in allow_failures:
-                        bad.append(fname)
-            if not bad:
-                return
         raise ValueError('Test coverage failure')
 
 
-- 
2.43.0

