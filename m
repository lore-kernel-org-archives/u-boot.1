Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53A9C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE42870D0;
	Sun, 19 Nov 2023 16:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JfQSksAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2506871ED; Sun, 19 Nov 2023 16:36:33 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398B1870AF
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a93b7fedc8so167058739f.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700408174; x=1701012974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9xsOZUrmuu+pDErx65tG/x/3ai9t5Y+oEfmmwQff0o=;
 b=JfQSksAF8U0iU7pHrGrwZ/Upmah7hdoywX7Ebs5J+GZ4POOufe+rkIzX+t3alQZjN6
 eLZrd8izv3dHVyfgwQbeaQDmKIoIvc5Tn5wCJiBQE+/A+0VMWHk+yiEqWM/R9EOWJiw/
 y8XAjWMrzGizozgoHSCV4aryNveqDUcNIh+2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700408174; x=1701012974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9xsOZUrmuu+pDErx65tG/x/3ai9t5Y+oEfmmwQff0o=;
 b=YV/eAFbD7tergMpp4TDjt1mhXRHDBlEUOC6ikqujAvTjmH+ucLaHbVcknP0Y+C7bK8
 DSG3uHkFhlTwFh5+qcjxLWHVUcI8Zbk3R8qYztKS1//ztADM+dI5BbYG1X+XZIg8w0+5
 D+6yCuwZZ8HuHClsDZfyyzGz6LN4YZfGUgbD5X1qPusnISOtv0t6KwjMgiGnCT8Ej8zE
 ANImtky8SkrtODJBiUahN116I0lyT3hmpN+46qh4Cln0cA1jYGTFcEKcmTFGPxy1optc
 20IxuxqryWSNCaT2NzRRANo/sdQoZyzPwYZ6mDcE2UYklr+dBYoclNI0ObSrBUi7Ohb3
 dXog==
X-Gm-Message-State: AOJu0Ywzc6tBJyf8TVlhWYpG9X7xy1qPtAiyI2miTGDQPKoGRknbW2uE
 Bl86W3NqS6CoHa/MmBw/wugNp8AUHARLEfSJarfOyw==
X-Google-Smtp-Source: AGHT+IH3rNfiLs0T4sfgCnG1C4I1g6SPoR47zz2ht5nJRDzpfQsOa2UzfnoHT/S8Zr8wAJK18WT52w==
X-Received: by 2002:a05:6602:21cb:b0:79f:ca2f:9198 with SMTP id
 c11-20020a05660221cb00b0079fca2f9198mr6252288ioc.2.1700408174784; 
 Sun, 19 Nov 2023 07:36:14 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 19-20020a0566380a5300b0046456924383sm1466712jap.73.2023.11.19.07.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:36:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/7] u_boot_pylib: Correct readme formatting
Date: Sun, 19 Nov 2023 08:36:01 -0700
Message-ID: <20231119153611.639252-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119153611.639252-1-sjg@chromium.org>
References: <20231119153611.639252-1-sjg@chromium.org>
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

Correct a heading which is too short in the readme.

Fixes: 75554dfac29 ("patman: Add support for building a u_boot_tools...")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/README.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/u_boot_pylib/README.rst b/tools/u_boot_pylib/README.rst
index 93858f5571da..36a18256d8b1 100644
--- a/tools/u_boot_pylib/README.rst
+++ b/tools/u_boot_pylib/README.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
 # U-Boot Python Library
-=====================
+=======================
 
 This is a Python library used by various U-Boot tools, including patman,
 buildman and binman.
-- 
2.43.0.rc0.421.g78406f8d94-goog

