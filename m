Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7622C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6BD84A06;
	Tue,  7 Jul 2026 13:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LsdSEJ6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4B0849F6; Tue,  7 Jul 2026 13:36:19 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BCC84A1F
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4472500e25fso1742673fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424175; x=1784028975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ntui8ZkA5yQ1T6fztGx5qnpRB1o+aWxhV+o1km8lNk=;
 b=LsdSEJ6C12RaKKffP1/nx5Xs3ksPvVVJKco0P7pBkDXydlwsGTGAQsMDvG9OgeBOSQ
 P4W5Nc7Sd4JHtbRdXyEj7H3iPLC1vTXtSUsWhKlDsfAOjC1RJ2lWKJH4J2PigMIxgyJh
 7DlQZj05uEt41+c33Ki03NWkdDIdLYoIRd4PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424175; x=1784028975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ntui8ZkA5yQ1T6fztGx5qnpRB1o+aWxhV+o1km8lNk=;
 b=WJAC9GCcTUJgM55Qs83pv4Bo39uWhL7sJdXXfdiprH3zUDNBIVXOxVSHSEr+Ldk/Pl
 QE+sRfhimkz0q/HgBwGJrA7auYLRwADK+fTFA32Zb/VoSAsoL36/Kk68VT24U1rft6T6
 BShSpuh7JbWXV00I7S7/qWW3RvL2yykbpdhlRrNDE54WBX1MPyVYCU1Bu//z/NrOWFAn
 jQp/ophVB2e+xzgQniRItBfSrv+MSukIJpn++TX6XFFNnE7YH4QdKe8vBcvjUSx5yujI
 4sAeuqLDWb7UMei1oTvjLH7lgp6jns00SH5q/XdLVwhKUp/wXH/AoZfkFjQqqj2oh0zC
 y7RQ==
X-Gm-Message-State: AOJu0YzPEt/wVP9QwCPW6anAlrKiOTk9hwjMj3BV14Q1Ow31hubgVKoN
 3s6p4/Zn6bPuuFwSQMhamobWSgtDi1kiO96Fep8ukZUn/eLWTenkDjSA1oR1JbJhG87SY4nyFus
 FJ6ShhA==
X-Gm-Gg: AfdE7ckse1pt/PVE+pLjCHp+n9Sr4BHR2i5o8ISAaR+/rscU1KsDY5f4mr0YUJOEZwQ
 9y7AOHB5w+65tT6anfzWwuFN9VwSS5GuwCk0zMHyheZ5OvXRK+fTeTAdtnLOzjYFdp2j5Yp7Oaw
 U8kaqECEz/5ZBcH8P/CDpvDYCvdnb+dZaqOmktCUZVRyeOBoGTuylp5UXtCWVtDN+BV2z6bhKUx
 17xSQSp7paqTt9SAejaXp22TLBzTs5ya58J8bdhH26tRgdgRpuR8jfvrKRs2W/zVaqu6uR2cCoy
 rzqMLxMsxT9eXw6xLjKgilIEMahgqnY9Xnz9+EOmyRiOBOnwHsGNwSCd2HhWApzHcFGDkDzc77Q
 q34uXUoysZhiUOjZ/awic/h3u5O4awI19iH9fa3SWPEhqrLJ52HrN3oQSdbeYkIC9Vd4fC5+oFe
 MS5unkibsccKFjkAy+ug==
X-Received: by 2002:a05:6871:7413:b0:451:252:16ba with SMTP id
 586e51a60fabf-451061babf0mr2915500fac.3.1783424175540; 
 Tue, 07 Jul 2026 04:36:15 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/13] qconfig: Allow buildman to obtain the qconfig database
Date: Tue,  7 Jul 2026 05:35:08 -0600
Message-ID: <20260707113538.3382145-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
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

Provide a convenience function for buildman to use, which builds the
database if needed, then returns it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 077d2fa4742..c8e5656e9d7 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -9,7 +9,7 @@ Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 Author: Simon Glass <sjg@chromium.org>
 """
 
-from argparse import ArgumentParser
+from argparse import ArgumentParser, Namespace
 import collections
 from contextlib import ExitStack
 import doctest
@@ -1714,6 +1714,41 @@ def do_tests():
     return 0
 
 
+def ensure_database(threads):
+    """Return a qconfig database so that Kconfig options can be queried
+
+    If a database exists, it is assumed to be up-to-date. If not, one is built,
+    which can take a few minutes.
+
+    Args:
+        threads (int): Number of threads to use when processing
+
+    Returns:
+        tuple:
+            set of all config options seen (each a str)
+            set of all defconfigs seen (each a str)
+            dict of configs for each defconfig:
+                key: defconfig name, e.g. "MPC8548CDS_legacy_defconfig"
+                value: dict:
+                    key: CONFIG option
+                    value: Value of option
+            dict of defconfigs for each config:
+                key: CONFIG option
+                value: set of boards using that option
+    """
+    if not os.path.exists(CONFIG_DATABASE):
+        print(f'Building {CONFIG_DATABASE} database')
+        args = Namespace(build_db=True, verbose=False, force_sync=False,
+                         dry_run=False, exit_on_error=False, jobs=threads,
+                         git_ref=None, defconfigs=None, defconfiglist=None,
+                         nocolour=False)
+        config_db, progress = move_config(args)
+
+        write_db(config_db, progress)
+
+    return read_database()
+
+
 def main():
     """Main program"""
     parser, args = parse_args()
-- 
2.43.0

