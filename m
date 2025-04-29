Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E922C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D678277D;
	Tue, 29 Apr 2025 15:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mipnT6HZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172CB8277D; Tue, 29 Apr 2025 15:24:11 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E586A8215E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7301c227512so3649990a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933047; x=1746537847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TuGI2zJul3237jkkc01WID8h5muntr5tULJb30CFPFE=;
 b=mipnT6HZFuAbOXVLrRjgyfLUG9BoSNhlnCMlhvMrtGZ79gZcnYUC6xOisIRqMVlIDA
 GslLd5Qtiatv3fe0YTKdLFhcp0bsCWHgtb+WK20pCOzwP5IjOm9P9qhHNCf6d5f6u+2U
 fvbKgaeydT4QiVjHXB14xeKvD5E4F2/iIqkdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933047; x=1746537847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TuGI2zJul3237jkkc01WID8h5muntr5tULJb30CFPFE=;
 b=l/5MOkdpXk94P4LHLYfvdr//2YCZdJaK3a0tk8ESzxG1WbG8Xew77aZgIZEyamzu9+
 7hiZtJ9VtyO3IS8wTrFlrRcBaMA7ddLF5iQ5CX5jGQHfkiCOhsMCfvpm2sbfeGoEesOo
 FxZyQypzhl2YGVczUgoCVI1mzcDX1Y42+Pipid/y4dJ6scSg5PLfH58bjiPxIrRWlfSj
 0LDQA0fucIsMRu6Rddxr4839kCn/h1G2/fJSJ9a0KB/z2Cath60QCYAqJvKyWJYpK+4K
 LbIbvkBMbD0mYd+eyPHwDYncYoQcPzTXBshz3y/0rjSz4voDSiUkCwgycmiPOrk1d5wS
 t/8g==
X-Gm-Message-State: AOJu0YwMjnA/2QJLVrHyGUsoJmH7zIp+sklMWzPZdXhMRTuetCalXSOx
 bTv6rs9kw10lz9If1RulkY21SKrcPCbmbmkKSK28iIFGezEG+JxFcuwNaknj/aKi7FTzTkUKFvc
 =
X-Gm-Gg: ASbGnctiJwCHuVAG+M1f6umIo4iMfaYyg6CWPYKA2BfqKqOcNZoCNrEJl40U2FS0Vh6
 plUBzcUfBZXHiXGMzEBBq9dUr6lRZsah8TIar0mpKT7EwZ2OWWFpJFSSyzFlvuS4p19i3lNvYLe
 o4TTKIUrd7NCqHSIlw3ZVmVLE+R7e7Zi1oIyOur8JQiKTg6Ro8DsNWfHlNvrW3T/rm0on01eQpt
 15VbxHd/RcjbQmQ1/S7CSKxFnde1oxiDSMhxEaVqoDKRBx+2lWWD8EbEmOvEPVy4rCQfGH55GNs
 3p5561e+RCAP6FzaStHll9wkc+oQcJNwxht//W3sLWsJeVN7lkp41RlT4tFVkvuZtsvjKL2zQHL
 TCQ==
X-Google-Smtp-Source: AGHT+IE8g/B5g3BCSYu5h8SWew/cwszJfgJ9OdcElu3GKzE+aPemsyW9fBWmBrLKP1hFNw3GImj0nA==
X-Received: by 2002:a05:6830:699a:b0:72b:9d2d:804 with SMTP id
 46e09a7af769-7308a5a2600mr1447311a34.26.1745933047120; 
 Tue, 29 Apr 2025 06:24:07 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/30] patman: Rename test_basic() in test_checkpatch
Date: Tue, 29 Apr 2025 07:22:08 -0600
Message-ID: <20250429132239.251756-12-sjg@chromium.org>
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

This currently has the same name as a test in func_test.py so it isn't
possible to select one or the other with 'patman test test_basic': both
are executed.

Rename this one to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/test_checkpatch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index 3bf16febbf6..4e8d163184e 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -137,7 +137,7 @@ Signed-off-by: Simon Glass <sjg@chromium.org>
 class TestPatch(unittest.TestCase):
     """Test the u_boot_line() function in checkpatch.pl"""
 
-    def test_basic(self):
+    def test_filter(self):
         """Test basic filter operation"""
         data='''
 
-- 
2.43.0

