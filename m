Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3202FC3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1997482AFD;
	Sat, 10 May 2025 13:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vkyeg8gN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB65682AEF; Sat, 10 May 2025 13:06:19 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8AFC82AB9
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-acb39c45b4eso457979566b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875176; x=1747479976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHOa3EypPgkc/hKU14nsPnfGSSdsmoWOemGcG4LY7Oc=;
 b=Vkyeg8gNmbBt0u0HZNqKmwR2dXXeSF14IvGs/Fjxz04ijd0/mED5WT2txyqTYkv7Gn
 RpA9imKGrJzuIqryk8LQ4V0g1z5c617f6fFLunzF40BZzaUJEH3VglYPDvIX8AwGlNhU
 RYj/A/FqkYNEe5HJkJNKaTFRFEChlR2bddqmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875176; x=1747479976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHOa3EypPgkc/hKU14nsPnfGSSdsmoWOemGcG4LY7Oc=;
 b=V7NKZcBWzIixXNemFYoAW8KsYiVS4z8sfg+Ty9q/thEXhUHO4pSDuKHADiY+UeUvXT
 OGk5sRJSMA1lyQfjJRzI2CIfHwiRAYAL+Y+nSn64t3G7Ti5sNt0MTbMTDFdnwNCfGkMv
 P6l8RZLc8CVC+NvCgD8AJC1rnefg4gSw2fcF/Ftp7veSfcNOVPnRRnOJTy0/o5q89QJH
 HSi85U8azQ6xwj0kMwzxUqBCJ3suS0kETycEQ+3F92Gi9IULbjqZ1tFdBREbbQ2aO+pp
 O10ssqtFog99sH4z3gcJmDcznSlhmSG+ghyCdeu0vyxMCq4jBzCEdWhIVKxERcLnmJ2C
 larw==
X-Gm-Message-State: AOJu0YzDIUkwIxcgHpJSoNPfmEmjuyE6rF2yu4MzheTiYONxusk6F4sy
 E0z2uzgSXnaVkcy0ir5uTQli32u8ikaU55QRKuJotlV3YKlZXBmbMme58/u0LZBc1LmkLhMjtU2
 mixmtek9obg==
X-Gm-Gg: ASbGnctx3Hu8xoRGKhAEYG0fihVOl0/60Fb3lqM8UvSICywQnhjpP8qK1ma3F66dNZN
 tDSF1GFdF/m1C4+0zKl9Kin4e07wYyXZ+ZWj/VFCT7mtBX894PM+cUx/a4AnHPcPaSlfuFXGZsn
 oH4o1pEJz9+AW32m8IND2hrurvD/eLEyJclt0qWXfQVgB2o0CeFL5bur0u1JoOWUpyMtkrcdMTY
 857ObZBNKVU/sUBVkT3gTYXJZqrSR7gnQMkBp7YhOTdUaX7m8ZGLGaTqDOjc8ptwrVicdJVy5Kg
 dm6JwNKghthUbKy9Z1AcmcSurhunx44Isqxh0r3peBykvmk=
X-Google-Smtp-Source: AGHT+IFcvlgM8tmzvlDOgAcxgaYjs/4NBHClIHgI/JZEE53LmE4/MO4hYLQZ9PoYybn3jJmu1l+ryA==
X-Received: by 2002:a17:907:3f9c:b0:ad2:3e8d:6440 with SMTP id
 a640c23a62f3a-ad23e8d64bbmr110417366b.33.1746875176471; 
 Sat, 10 May 2025 04:06:16 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/25] patman: Support returning the parsers to use
Date: Sat, 10 May 2025 13:05:09 +0200
Message-ID: <20250510110535.1453745-17-sjg@chromium.org>
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

The parsing tests need to be able to try invalid arguments to make sure
that these are handled correctly. Provide a way to return the parsers
being used, as well as to pass in the parsers to use. This feature is
needed in test_series_no_subcmd(), for example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index e34cf126556..1b2a32c99f7 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -209,10 +209,13 @@ def setup_parser():
         test_parser.add_argument('testname', type=str, default=None, nargs='?',
                                  help="Specify the test to run")
 
-    return parser
+    parsers = {
+        'main': parser,
+        }
+    return parsers
 
 
-def parse_args(argv=None, config_fname=None, parser=None):
+def parse_args(argv=None, config_fname=None, parsers=None):
     """Parse command line arguments from sys.argv[]
 
     Args:
@@ -225,8 +228,9 @@ def parse_args(argv=None, config_fname=None, parser=None):
             options: command line options
             args: command lin arguments
     """
-    if not parser:
-        parser = setup_parser()
+    if not parsers:
+        parsers = setup_parser()
+    parser = parsers['main']
 
     # Parse options twice: first to get the project and second to handle
     # defaults properly (which depends on project)
-- 
2.43.0

