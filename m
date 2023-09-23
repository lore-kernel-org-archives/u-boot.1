Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AF0CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510F286A28;
	Sat, 23 Sep 2023 21:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m2OQfOLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846E5869F6; Sat, 23 Sep 2023 21:44:35 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CD8863DD
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79fbbb2bed0so9884239f.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498271; x=1696103071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTmYFxksPf0lw8kokqHAqrx8/eJjAuIDSOjOCrlzMJA=;
 b=m2OQfOLkyxyk+Uho44OnJUfLzRnqf6MxqYw5pnosvx5JTmg8Ye3Hx6mM/hsWAqAz28
 x+mxMC4TQ1AinabsY6aXhVP3B9UaqtJwj/GnJEqKfqkX7up23hRe3Y1ehjvRgoiD4LNV
 5Q/K25dY1ogt7BiY9fPYQ0dEFQn6iQWGVJc4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498271; x=1696103071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTmYFxksPf0lw8kokqHAqrx8/eJjAuIDSOjOCrlzMJA=;
 b=vaq/kwJUa55GAmIievzHJ29YEdPgr8uVFsePNhnXeyLn4AGX8NoHl68s5yo4gIAmfR
 LSb8Z9m1oJzqNQhdWpjAWO7rqHJI9rr3vHDPqhktf6AB0UVMn/7OKhl0xmWrp0MGVeKf
 dti1xoPMXRk2v4LwgYDumFKULHmSC+h/DRpIMT+7p1ZmjNmsudnF5fjH7d2VnYh79XgZ
 nBDhZ5cJXqXT/0M1o2rHdK8iBBKPn3Hs8OzGRHAIMglQZwAM1bofCehxoVXb/yxu38CO
 C9C0eghHeq6PiQRSMD5V7CnS1bKWjjgySCkQXXPOAx3HeeGbHmfE+yZqd3qSnUbk1ofd
 kxGw==
X-Gm-Message-State: AOJu0YxYxKz4lPeFdEf1EBCfvfcKgq4uhj0fzRZ3/fY5WXhgLBykTZF5
 R0QlpjwKbfm9Hwni4Xo/uLNfNZmg3ZkXwmlNAQA=
X-Google-Smtp-Source: AGHT+IHVtESp6kYMA7rR/rU5aD0GqoKgpZ5j2yxWI6V110uHSKnQtXDdxBH8WIdkbdcWVDoYsrcf1Q==
X-Received: by 2002:a05:6602:2426:b0:791:ad01:3f3e with SMTP id
 g6-20020a056602242600b00791ad013f3emr5854729iob.0.1695498270783; 
 Sat, 23 Sep 2023 12:44:30 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/27] moveconfig: Drop -H option
Date: Sat, 23 Sep 2023 13:43:50 -0600
Message-ID: <20230923194424.1739224-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

Drop this option, which is no longer needed now that we have converted
all CONFIG options to Kconfig.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 6cbecc3d5c80..880a5594be05 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -1951,9 +1951,6 @@ doc/develop/moveconfig.rst for documentation.'''
                       help='exit immediately on any error')
     parser.add_argument('-f', '--find', action='store_true', default=False,
                       help='Find boards with a given config combination')
-    parser.add_argument('-H', '--headers-only', dest='cleanup_headers_only',
-                      action='store_true', default=False,
-                      help='only cleanup the headers')
     parser.add_argument('-i', '--imply', action='store_true', default=False,
                       help='find options which imply others')
     parser.add_argument('-I', '--imply-flags', type=str, default='',
@@ -2035,14 +2032,13 @@ doc/develop/moveconfig.rst for documentation.'''
     t.setDaemon(True)
     t.start()
 
-    if not args.cleanup_headers_only:
-        check_clean_directory()
-        bsettings.setup('')
-        toolchains = toolchain.Toolchains()
-        toolchains.GetSettings()
-        toolchains.Scan(verbose=False)
-        move_config(toolchains, configs, args, db_queue)
-        db_queue.join()
+    check_clean_directory()
+    bsettings.setup('')
+    toolchains = toolchain.Toolchains()
+    toolchains.GetSettings()
+    toolchains.Scan(verbose=False)
+    move_config(toolchains, configs, args, db_queue)
+    db_queue.join()
 
     if configs:
         cleanup_headers(configs, args)
-- 
2.42.0.515.g380fc7ccd1-goog

