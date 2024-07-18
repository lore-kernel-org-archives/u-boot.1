Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE3CC3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 09:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03A188AD8;
	Thu, 18 Jul 2024 11:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ErvwtLhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B621C88B05; Thu, 18 Jul 2024 11:12:01 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C64AC88AC1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 11:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-427d2c8c632so314755e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721293919; x=1721898719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5bh/8yLLkdkS29f86OrEaE8zuEZCrK1vMYqGTA3TIA=;
 b=ErvwtLhEnhZ5B2MTd+CtJGJVDc8dZDsLRkayODKFOCyG9mhdYfm9J69+Z1Whaiajq7
 8qFiHixFw6nA4flxe9KSJkYUDlkRrAaCz/dP0qP16fDnA/XFobbxfQ203ZbYNoyiupOb
 kf6Qqde42vVuMY8EwnnK3ZBTfhvXhmQQRk2Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721293919; x=1721898719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5bh/8yLLkdkS29f86OrEaE8zuEZCrK1vMYqGTA3TIA=;
 b=IBj0dQH5NRjyrTB4x+vf07H5R0Vp0DIHQJYkyShts5Ymyj/3NMAj+uVgnjqz4HShI7
 Zd/SQQaFWUF9vd0CkyU6s9bQPU/bO9z0ML/J3DwT373Zp5Jzb5u4gdbAPlbPiN1hTfWV
 7dKh9tE9LzxI7DP04vqUaS8aNtWsAaDEiJTOKKVv7nXuvwkLMIIygD11lf2NrXBGkgzi
 3+jriP87CcYXuF1LQiimLJDcJz0V0U5eTg5p7FhgNVh8BVJLLhJjrTv5QVQDG1fjiQ2v
 +OGo/h+TSEZKLI3kUsOa8F6ByjSeIIOlVjjK5lE1/+e0NL1vVsWZsCcFvI7NDwI5BqW1
 Tnuw==
X-Gm-Message-State: AOJu0YzYnviYQSe5Wxif6XG3GTchGPs6Tgg2rVaHm4ZAudwyWNay34oh
 rADwqSWYTCAKBNvpnuOJnTWP/XHH7RkWZS3W7xwhsqaTAnh0ZndrE8x6tnFetQpbleUvsJB6HJI
 =
X-Google-Smtp-Source: AGHT+IGSsF/h1JUwmmsfpSfF0tdj2Il3q5VGUtzhi3b8A3J84NHBDscJTz0jnXtvSzj0cix+81q2Qw==
X-Received: by 2002:adf:f206:0:b0:368:12ef:92d8 with SMTP id
 ffacd0b85a97d-3683171fa78mr2324207f8f.52.1721293919081; 
 Thu, 18 Jul 2024 02:11:59 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368525f0353sm1064403f8f.115.2024.07.18.02.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:11:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 26/26] qconfig: Support a 'list' format
Date: Thu, 18 Jul 2024 10:11:25 +0100
Message-Id: <20240718091125.3788990-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718091125.3788990-1-sjg@chromium.org>
References: <20240718091125.3788990-1-sjg@chromium.org>
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

Add a flag to output the found list in a more user-friendly format, with
one board per line. Omit the board count.

This can be useful with grep, for example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to support a 'list' format

 tools/qconfig.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 241bd9efe33..7b868c7d72c 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1100,7 +1100,7 @@ def defconfig_matches(configs, re_match, re_val):
                 return True
     return False
 
-def do_find_config(config_list):
+def do_find_config(config_list, list_format):
     """Find boards with a given combination of CONFIGs
 
     Args:
@@ -1108,6 +1108,8 @@ def do_find_config(config_list):
             consisting of a config option, with or without a CONFIG_ prefix. If
             an option is preceded by a tilde (~) then it must be false,
             otherwise it must be true)
+        list_format (bool): True to write in 'list' format, one board name per
+            line
 
     Returns:
         int: exit code (0 for success)
@@ -1141,8 +1143,10 @@ def do_find_config(config_list):
             has_cfg = defconfig_matches(config_db[defc], re_match, re_val)
             if has_cfg == want:
                 out.add(defc)
-    print(f'{len(out)} matches')
-    print(' '.join(item.split('_defconfig')[0] for item in sorted(list(out))))
+    if not list_format:
+        print(f'{len(out)} matches')
+    sep = '\n' if list_format else ' '
+    print(sep.join(item.split('_defconfig')[0] for item in sorted(list(out))))
     return 0
 
 
@@ -1535,6 +1539,8 @@ doc/develop/moveconfig.rst for documentation.'''
                       help='Find boards with a given config combination')
     parser.add_argument('-i', '--imply', action='store_true', default=False,
                       help='find options which imply others')
+    parser.add_argument('-l', '--list', action='store_true', default=False,
+                      help='Show a sorted list of board names, one per line')
     parser.add_argument('-I', '--imply-flags', type=str, default='',
                       help="control the -i option ('help' for help")
     parser.add_argument('-j', '--jobs', type=int, default=cpu_count,
@@ -1688,7 +1694,7 @@ def main():
             sys.exit(1)
         return 0
     if args.find:
-        return do_find_config(args.configs)
+        return do_find_config(args.configs, args.list)
 
     config_db, progress = move_config(args)
 
-- 
2.34.1

