Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F5AFCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92D28407E;
	Fri,  6 Mar 2026 19:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iG9uUQOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E047283F2D; Fri,  6 Mar 2026 19:14:29 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 506588408D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8cb3825b0fbso933639585a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820865; x=1773425665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpqd2ijmQrXCNoPXwzGshFsG5MrEA++IJ9Z1nwRjcZg=;
 b=iG9uUQOMvDZ+R4kue1Oqpl4EAIoBmiDFTxZ7a0UF8BqsL1nkpUGKKQ+O8YvA6EXT46
 DH/u9OK2A+lOR4pGRGT3yffDgaPGz0ikfd35E23v5+VvgTde5jjbBhD4XJ98jmQLlf9t
 bbSckHUWgQN/j2XegGFuUHhn8RYV0UPS/XbyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820865; x=1773425665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dpqd2ijmQrXCNoPXwzGshFsG5MrEA++IJ9Z1nwRjcZg=;
 b=actvgImwjQbTadZPsqvkzI4E/yMdIPus4Q8vG3sRmTeCz/VuAKYtKFm3Qcu7w91FYc
 cz+azmNgSdQRp8r8e8xnOPyifXLuGB5PrybmYNgK8FE+D1nJuSQjr5Qba15cyWnVb5Rz
 LdvpYCtOUWNVjzQGZJg9EpjD5QCZzkUGUh1shEw6BEdW8UOTs6k4TLXS8Dapx5wgUS50
 JuY3nrx/IyzNJqBcx8vgxNYd5drLpyylIeDCvcJk+jEFU9aJKKHjLeay1CHwxT34bgVw
 HwbjcHz0+xumW3eBGcxqfDFneAz70WcecsOmN+LWMKev4B4t4+9VA3gfVZC23nEYYNpx
 hd5w==
X-Gm-Message-State: AOJu0YyO1+a5NwVHCAFCIlIe+B+xU5ZiK9UxFMa+puJLRH2ny9jbS7lk
 +iH0CWmNrO5AoVbOnkzRmQurDm3CADbHH0NMGvP/jyPL7dRZ5U5VdliDJzLIsONh5AqUwAY/mC7
 62Bg=
X-Gm-Gg: ATEYQzyrqR1h3WcBbZVPBJBxmhLDk+6o170GkSubznGS97QcAZQKjobYe3KNCZ6aecS
 Leir2c75zciTCigVHh5TNZv8wfKcAbsF1mN060pHmALmukgH5+0/wf1WanbKG3c1BcNFxw6+CFu
 KsimrxvJKzB4sIt2DBy5sg0pHczidMzWLeAQT6Ystv3atefvf0eAWFDmkwYgEwBSB6E1VAOMzny
 GMztjQv2dUmZADw5UhfBnAKZzCN+nwcToEcc/vtnb4wBogZjl//u64E/C+HgIKfbTgp5DBgF5id
 UOnPtEVrgvGnOnkTaul+iXUUTLVi2e16NOUFvbLAgZexjKMOvaVEnhRpdXeWZ8KmSmIsbIvnkTA
 Cq8v036bu0KYl6w4l6jRPWQQRmDy9S1BhQKj0x4ROSwxXuBfnP5hWqNb4z2bPJWgLVcKzF3JP4o
 2Ds0fVsoBu8YTjUpwJ+g==
X-Received: by 2002:a05:620a:40c3:b0:8c6:ed6b:5865 with SMTP id
 af79cd13be357-8cd6d29e6e6mr407077485a.0.1772820865597; 
 Fri, 06 Mar 2026 10:14:25 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:14:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 23/23] binman: doc: Update binman_tests.rst for
 subdirectory layout
Date: Fri,  6 Mar 2026 11:12:51 -0700
Message-ID: <20260306181304.2426352-24-sjg@chromium.org>
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

Update the guidance for adding new tests to describe the subdirectory
structure instead of the numbering scheme.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Fix awkward wording per Quentin's suggestion
- Move file-reference updates to the patches that rename those files
- Drop RFC prefix
- Use literalinclude for nxp_imx8.dts example

 doc/develop/binman_tests.rst | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
index 74a2d0e8ef2..40865912911 100644
--- a/doc/develop/binman_tests.rst
+++ b/doc/develop/binman_tests.rst
@@ -453,31 +453,15 @@ help with this, but your code will be different.
 
 Generally you are adding a test because you are adding a new entry type
 ('etype'). So start by creating the shortest and simplest image-description you
-can, which contains the new etype. Put it in a numbered file in
-``tool/binman/test`` so that it comes last. All the numbers are unique and there
-are no gaps.
+can, which contains the new etype. Put it under ``tools/binman/test`` in the
+appropriate subdirectory (e.g. ``fit/`` for FIT image tests, ``vendor/`` for
+vendor-specific tests, ``entry/`` for general entry types) with a descriptive
+filename.
 
 Example from ``tools/binman/test/vendor/nxp_imx8.dts``:
 
-.. code-block:: devicetree
-
-    // SPDX-License-Identifier: GPL-2.0+
-
-    /dts-v1/;
-
-    / {
-        #address-cells = <1>;
-        #size-cells = <1>;
-
-        binman {
-            nxp-imx8mimage {
-                args;    /* TODO: Needed by mkimage etype superclass */
-                nxp,boot-from = "sd";
-                nxp,rom-version = <1>;
-                nxp,loader-address = <0x10>;
-            };
-        };
-    };
+.. literalinclude:: ../../tools/binman/test/vendor/nxp_imx8.dts
+   :language: devicetree
 
 Note that you should use tabs in the file, not spaces. You can see that this has
 been cut down to the bare minimum, just enough to include the etype and the
-- 
2.43.0

