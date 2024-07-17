Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6FAC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D8F88AD0;
	Wed, 17 Jul 2024 17:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ji+ShPfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F91088AC0; Wed, 17 Jul 2024 17:57:31 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27EF488A69
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-368313809a4so477097f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231848; x=1721836648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qg3rhF32PsH3MyXwfa1YyNRCD4DwBvQNO0VRHSmONw0=;
 b=Ji+ShPfVpk0vm7122zBkfL+jFIVRILaU4BAkfqsxCJ1FdytJOyYhULd8UUUTkM0+98
 mgdq6JjuQSDK7JYmjTECRTE5q8Swqib+xTyS3pUKscUWWJqM7pKJ33khmHSbhsuDudbG
 aI5NPoHr/3PkwxX6P9e1ulsUB3ZgSz6FkrIJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231848; x=1721836648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qg3rhF32PsH3MyXwfa1YyNRCD4DwBvQNO0VRHSmONw0=;
 b=HNC/Y6l7RcpFRkauHntoZurJzlK2c+fzaC4h/k7I+qa7XgtjPKEn5YRuiHexKES2Wv
 FEtxRH22/1vNGYv4r8U74Tc3/nOVh7jWvtHOWMV6sCJczDjaZcDul5Em844sGaGwsonj
 PpP1KNSNtuWrMfroJuWz2xKa4itkmf8r699BrC5gLF+ARFhNonw/H6jl1+6EexiY0ASf
 19PiS2NeuyfFwX3qj43B2ChUV2F6zhpLnRsPAgcz3jQlqbrd7Ut0V+txRb5j8kkpa7+m
 y1yrV49XQEyuAW9MIsb6HFqinbCuodpn+rDYFWT5GpsjcuKA+y23qzD0ySwJubMR4JPG
 IaVw==
X-Gm-Message-State: AOJu0Yyepq+qjpT3m2NT/dwxT9o9fRnmmPkknMsDppWxpRpFkPOlLmmJ
 +N0f7FEx5L0oKO/T8Nrb0ZH7f6ESrVUbHQzpdxJFQlW4ZqpBnA15xbt6VmE/6NdUpZhyCQqpwas
 =
X-Google-Smtp-Source: AGHT+IGr3ZgtLaTSBpsD1g1EpidcKsmuH1d8owXr3BnSZ57oBgljWOBzf2sA6o7bBdR48c8opC7TUA==
X-Received: by 2002:a05:6000:e46:b0:361:e909:60c3 with SMTP id
 ffacd0b85a97d-3684b38a212mr27964f8f.9.1721231848436; 
 Wed, 17 Jul 2024 08:57:28 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/24] qconfig: Move testing into a separate function
Date: Wed, 17 Jul 2024 16:57:01 +0100
Message-Id: <20240717155712.2913651-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

Reduce the size of main() by putting this code into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index a33fb2aa22b..0bdabccba07 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1521,6 +1521,16 @@ doc/develop/moveconfig.rst for documentation.'''
     return parser, parser.parse_args()
 
 
+def do_tests():
+    """Run doctests and unit tests (so far there are no unit tests)"""
+    sys.argv = [sys.argv[0]]
+    fail, _ = doctest.testmod()
+    if fail:
+        return 1
+    unittest.main()
+    return 0
+
+
 def main():
     """Main program"""
     parser, args = parse_args()
@@ -1535,11 +1545,7 @@ def main():
     args.configs = [prefix_config(cfg) for cfg in args.configs]
 
     if args.test:
-        sys.argv = [sys.argv[0]]
-        fail, _ = doctest.testmod()
-        if fail:
-            return 1
-        unittest.main()
+        return do_tests()
 
     if args.scan_source:
         do_scan_source(os.getcwd(), args.update)
-- 
2.34.1

