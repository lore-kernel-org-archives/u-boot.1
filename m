Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A01C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C729D82AEF;
	Sat, 10 May 2025 13:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="maT9RMIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C7582AC1; Sat, 10 May 2025 13:06:17 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E689F82AD2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad2440926adso1397866b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875175; x=1747479975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kn8320zcu+i3j63zMQ0lTGwlZd4ugZUxcOcg1ZSJ2fw=;
 b=maT9RMIa9D4/KSQMju69WbWblKAkWNafrr9qf+I28NTdnDe1LP1hHKugLB5zu/kU1D
 8QPvbZhgonb0ceu1Ux4rAjmYNDNamGuxv6ZPiYYgoQLWxpcF8w0HS6Tvf3eKucjMi7lw
 2JjnFhtlmXk9Ug+3WIXogqSJ29qP6kcY/uDKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875175; x=1747479975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kn8320zcu+i3j63zMQ0lTGwlZd4ugZUxcOcg1ZSJ2fw=;
 b=Bn3bO5+XFRvlkuFew5ossCxs/NuYA0EazJiAbEGDkx6u4ZW8vjSwCVYhbXn95bWcWJ
 CsnfqRXgQUOKNXYU178/fgnRXWm5rkWl1/RXRu3l7ersDTaHfl/ZpscYKAuViOuzxIAO
 cEE3ml4I1LQX++FFky4//3ylU3CrJlpTmIC4Nr88FDsxtwsJCe5LpfMXSMt+QX1fYvBF
 3QJJ/QgCfe/PFyC/4gSVNVjbjkzWUj4u097axe0pS2odfb6tBMf/5wDGKGFNYtxnyNXV
 QMNnYW0a93TCNDD0NsDvNgwDrHHBWHvM6ZUd5YdFUO4PEz/CQEPtTQL4ws4XCIDkUxRj
 9mXg==
X-Gm-Message-State: AOJu0Yx9Oe495S9/1rGfxQpOQG8mhfELNLpFd3pCwobGt2fvsTP98KNT
 unB4ExD5PhSVSFkzfEw8inRFsPqRxTcaiNbis5gctLML3m/4OPyTHX0T8d3DHoSo6OUVkMShaYR
 KOQtxX3MZAQ==
X-Gm-Gg: ASbGncta1KJkcKv00VY6BiddC/90G1YULYKpnVF5Y0hcDtpjgI8c/i/fVfznlzJ4TQm
 i7UH8W0md/zMwBWWgNdASUIu+uMh80DO0m9jU6jGqiEAgFPOv+igh475qlBrVu3pJvr2y8bCv8T
 d0ZKx3yODBJGynCt6RUhsLMs5i90o+OzF5m6E4+san3B9maugJS96T9BpFaRtIof8OdWkabOCZ6
 3V3054usCTKTA64AiM05pY51UKhjw9tbN7rHMFsM45B0xHV7WOPHwrfZkyvopGQiqtsP0UUtHkk
 7zkcmnYOeAUvwZgYb3op2xYyFAvOzIXd0L80LKRfcZludJ8=
X-Google-Smtp-Source: AGHT+IFAP98RbJypWwNturXMalY+Z7HKIWHV6SGLQH8bUj696BmDI+IypOw3+gUMy6k7uCqYwv9x7g==
X-Received: by 2002:a17:907:980a:b0:ad1:766a:9441 with SMTP id
 a640c23a62f3a-ad218f1adc9mr661915166b.23.1746875174902; 
 Sat, 10 May 2025 04:06:14 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/25] patman: Use -c to show patch comments
Date: Sat, 10 May 2025 13:05:08 +0200
Message-ID: <20250510110535.1453745-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

We chose -C as the flag to enable showing comments because -c was used
in 'patman send' to specify the patch count. Now that the 'send' parser
is separated we don't need to do this and it is OK to use the same flag
in a different subcommand.

We want to have a flag for cover-letter comments, so it makes most sense
to have -C for that and -c for patch comments. Update the latter.

Put this in a function since the new 'series' command will add this flag
too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 8e10c7bb14f..e34cf126556 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -111,6 +111,11 @@ def add_send_args(par):
         help='Preserve Change-Id tags in patches to send.')
 
 
+def _add_show_comments(parser):
+    parser.add_argument('-c', '--show-comments', action='store_true',
+                        help='Show comments from each patch')
+
+
 def add_send_subparser(subparsers):
     """Add the 'send' subparser
 
@@ -147,8 +152,7 @@ def add_status_subparser(subparsers):
     """
     status = subparsers.add_parser('status',
                                    help='Check status of patches in patchwork')
-    status.add_argument('-C', '--show-comments', action='store_true',
-                        help='Show comments from each patch')
+    _add_show_comments(status)
     status.add_argument(
         '-d', '--dest-branch', type=str,
         help='Name of branch to create with collected responses')
-- 
2.43.0

