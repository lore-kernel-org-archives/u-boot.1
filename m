Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF953FD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F4983FBC;
	Fri, 27 Feb 2026 00:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bdX8jtl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9A383F6E; Fri, 27 Feb 2026 00:49:22 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC84983F60
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-899cbb1bea0so12983876d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149754; x=1772754554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFDPYz7iIiInY4q5sSZxZ3Pg5yTA3i00N0TjIXDXSGM=;
 b=bdX8jtl0qKhL4+CS/iRjfnhSENVAiG1+7/oi5GY08ICiCWgPWItuMY0w2HUGuQ7ygy
 YnxNRs/qxT9vHQ1qpL02jIiPVyVwCdKZa4HxxOW2SIJ4o7OMCK3COmk/ybK5CP7g9A/w
 sBgqrDywLycigtBaOWGmDRJcMka3dQxGRtXOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149754; x=1772754554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kFDPYz7iIiInY4q5sSZxZ3Pg5yTA3i00N0TjIXDXSGM=;
 b=FZxhjbX6jspiKxFD/XjcmE5L6ogRvqOMjWohGfoaVzslIXzxzU5IVlwml3vIEX0KF+
 9Ftigt3H/HyctmjBkPCW6xRWO0aamtUeIoGk9FAf5Xlmgt+azvbqZUkvub8UI5uyly5i
 7oWIiWv+zzCUiAv2laWz0Y3bR2e2wTkB99MQftim/uq2KnTUUovk5e9neJ8zOJty6z7b
 9aRYKnAAhq1PH5hnbk5tpfN0A9/X9NttsznaxCbQMx3A/z+RVjPKr9uKBw19Ybv9+72i
 0I3yIwEZYlYoXKq4+0FaSKxNBZH+x8aLWquqZN17V1Xso4fOnJ6FS8Wlqmt+g4N51DC/
 f92Q==
X-Gm-Message-State: AOJu0YypcpDtF6gRF2HmVV3Y56cKGo0M6JoYuML/qTmZ02BX+/AFK19y
 7o02rEeKUR86l49VwRTT27Wvpj1D+p4pxflqJPiaj4N4gbMkq2cJh4J5zz0sudy71/56ttGlvxK
 vLcI=
X-Gm-Gg: ATEYQzwCUg+WeTpNGF2rQdltF4y3p4OSCaJ70Xexqxr00wWhenyXqLdzsegpYGOXkgA
 X4cDbMR3pFmtBjppXF1C9VaYTm93yJ48c0dCZYBwYp8VeYFs+3mDcalgiuW3bSAzpjbFu/lnfOo
 IcSJG8cm2qEWGix9VxdJxQb+UyF96rnF/i5qViAzMkCYzHS6hXCeXbDeb6Kqi7SJ2mhYawIuLXE
 t5+TCGm11CQ1uwUz8aTuNiKn7JS6T/OXz9IrGmIdFjPaqP6hCHoDZOTslMC2awnXi8hmDaRWQCm
 HDXhlzPq4KqGJM2BZpbA6kvqVQ6zgOFt4XIeYfqlM7xHdVaAgzqreVVGyn6k1eN2fSPuv6NHf2N
 WDnYvnW6/CyoBpaFwirrCVZwUF2OSY4Dzw2ZASXiw+i+xYkVbrJJpkdnx5gDsurB0OhXzl+cPyp
 wWd85Wda3HsbJjRV0AYg==
X-Received: by 2002:a05:6214:21c6:b0:899:a57e:887a with SMTP id
 6a1803df08f44-899d1d84730mr14820296d6.8.1772149754498; 
 Thu, 26 Feb 2026 15:49:14 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:49:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [RFC PATCH 16/16] binman: doc: Update binman_tests.rst for
 subdirectory layout
Date: Thu, 26 Feb 2026 16:47:56 -0700
Message-ID: <20260226234802.345968-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226234802.345968-1-sjg@chromium.org>
References: <20260226234802.345968-1-sjg@chromium.org>
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

Update the documentation to reflect the new test file organisation:
replace references to numbered test files with their new subdirectory
paths, and update the guidance for adding new tests to describe the
subdirectory structure instead of the old numbering scheme. Also fix
a stale comment in ftest.py.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 doc/develop/binman_tests.rst | 11 ++++++-----
 tools/binman/ftest.py        |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
index 78b02e6f435..e0baec05125 100644
--- a/doc/develop/binman_tests.rst
+++ b/doc/develop/binman_tests.rst
@@ -453,9 +453,10 @@ help with this, but your code will be different.
 
 Generally you are adding a test because you are adding a new entry type
 ('etype'). So start by creating the shortest and simplest image-description you
-can, which contains the new etype. Put it in a numbered file in
-``tool/binman/test`` so that it comes last. All the numbers are unique and there
-are no gaps.
+can, which contains the new etype. Put it in the appropriate subdirectory
+under ``tools/binman/test`` with a descriptive filename (e.g. ``fit/`` for
+FIT image tests, ``vendor/`` for vendor-specific tests, ``entry/`` for
+general entry types).
 
 Example from ``tools/binman/test/vendor/nxp_imx8.dts``:
 
@@ -610,7 +611,7 @@ In the above example, here are some possible steps:
 
         Entry_section.SetImagePos(self, image_pos)
 
-   The solution is to add an entry, e.g. in ``340_nxp_imx8_non_empty.dts``:
+   The solution is to add an entry, e.g. in ``vendor/nxp_imx8_non_empty.dts``:
 
    .. code-block:: devicetree
 
@@ -641,7 +642,7 @@ In the above example, here are some possible steps:
 
        def testNxpImx8ImageNonEmpty(self):
            """Test that binman can produce an iMX8 image with something in it"""
-            data = self._DoReadFile('340_nxp_imx8_non_empty.dts')
+            data = self._DoReadFile('vendor/nxp_imx8_non_empty.dts')
             # check data here
 
    With that, the second red bit goes away, because the for() loop is now used.
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 0f1a799821d..2434e912d51 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2130,7 +2130,7 @@ class TestFunctional(unittest.TestCase):
 
             # Unfortunately, compiling a source file always results in a file
             # called source.dtb (see fdt_util.EnsureCompiled()). The test
-            # source file (e.g. test/075_fdt_update_all.dts) thus does not enter
+            # source file (e.g. test/fdt/fdt_update_all.dts) thus does not enter
             # binman as a file called u-boot.dtb. To fix this, copy the file
             # over to the expected place.
             start = 0
-- 
2.43.0

