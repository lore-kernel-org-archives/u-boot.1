Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AC2C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4E48291D;
	Thu,  8 May 2025 09:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iC70sEP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DD38291D; Thu,  8 May 2025 09:29:18 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 416FF8211F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso3830535e9.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689355; x=1747294155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beFDnk4IYbbgcTy6igjGSo+Su7P65FiGvFnA46bepLI=;
 b=iC70sEP4oayHiz+Es5t3m1OPzohVUAFEuff4gVMVtzGc4Si8ohZzhHW8SwbGWXJy9h
 KDrrd0a2vb7CPH7uHq7vImiI9Ezol2L+WJq4ZJr7k1XYgYgGSrVznEC1b+5EQa+ug6XG
 jdxk8T1IuVpo5SnO1stQq12sWyAdVLWANI5+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689355; x=1747294155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beFDnk4IYbbgcTy6igjGSo+Su7P65FiGvFnA46bepLI=;
 b=QPmNxxWObHPQc/CnNOA+iaSp+d5WKQUQEzXVj528B1H6t9v0d1HYagj1sI/3U+mZky
 6a34MIPJYvud/MvOYd0TZHjxB3owuO7bgA9spAxgCnYZVg++jyNtpmAalzkZkhOZy84s
 k3Xl+AbP/6KHacDHdmE4SWAjota2bZ4iR1IthOa0kKHLnCK20p3aPwR2n47SKxFEyF1J
 4Miop70R/PteQD/ckwSGNxO4wdaeLGprgoJDw92rlT7WNfVTccAzMcJ6lLkByME+cATT
 EB7KQp+xJqFSh6b6xNGwAjFDoM1oepJiFRVQruUqp6vwklmmc1k9i/43+o68r1PAyDwe
 G1lQ==
X-Gm-Message-State: AOJu0Yxo7DdJy9AqQ6lry/VVYik9r6HAoE8YMf+bzUMhgDeS86Z1FWOS
 TVAJyej/Q1GhaP9AjcF9pSeHJd8heD0bhgImnRCqsRSQi30rlo72IjN9/nfw80R0JbfK9uJku9M
 4aOp6y2cFqQ==
X-Gm-Gg: ASbGncvRk5YDCHCTB5ub6Oe4SXdbHc3SMkmFYMxbfpldy7LeNTn0yzoCUwnbpZZ7Pf6
 nMz4+gZl3u1aH3j/CaLK9BwND/c4ZjAJ/JPnz1xWTpHS4sfTTOpHoMI0rtSXTFuec9rrrArTw21
 BIo2Lr1J1sLd3c/TPsSYm3sO6cnsSCouGCtNVBamqJ5i/l6Lf69gYWxago6kwMU6arGBvYqp9/J
 wHsu57ldXDtQCZqYa8GqJjLsLPJX3QLrhfDK0X600g2km4GRIFS9Yox8/SJYwPzKgpKg4P+RvV5
 cRZEZkn3kVuwn8oxZAjg4BWPRATEbKxztAdESw==
X-Google-Smtp-Source: AGHT+IGUFWdBHPTF5f6O4B0aUw6+63n+fQaNDHGDk1jLkNf8lFtYkLttRRWAgFsXP5q188swNMguzg==
X-Received: by 2002:a05:600c:8218:b0:43d:97ea:2f4 with SMTP id
 5b1f17b1804b1-442d02ed37bmr21612815e9.12.1746689355250; 
 Thu, 08 May 2025 00:29:15 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/20] u_boot_pylib: Tidy up quoting of cc and to
Date: Thu,  8 May 2025 09:28:25 +0200
Message-ID: <20250508072907.207175-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

The current approach to calling 'git send-email' puts double quotes
around each email address to ensure that it will pass the shell
correctly. This is a bit cumbersome and requires using a shell to sort
it all out.

Drop the quotes and use command.run() instead, to simplify things. This
will also make it possible to (later) set the current directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py     |  2 +-
 tools/u_boot_pylib/gitutil.py | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 3a34302fc57..7f9175ea44f 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -292,7 +292,7 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual('      Cc:  %s' % mel, next(lines))
         self.assertEqual('      Cc:  %s' % rick, next(lines))
         expected = ('Git command: git send-email --annotate '
-                    '--in-reply-to="%s" --to "u-boot@lists.denx.de" '
+                    '--in-reply-to="%s" --to u-boot@lists.denx.de '
                     '--cc "%s" --cc-cmd "%s send --cc-cmd %s" %s %s'
                     % (in_reply_to, stefan, sys.argv[0], cc_file, cover_fname,
                        ' '.join(args)))
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 7d3a0b68c53..e5a466c8cc6 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -396,7 +396,6 @@ def build_email_list(in_list, alias, tag=None, warn_on_error=True):
     >>> build_email_list(['john', 'mary'], alias, 'Cc')
     ['Cc j.bloggs@napier.co.nz', 'Cc Mary Poppins <m.poppins@cloud.net>']
     """
-    quote = '"' if tag and tag[0] == '-' else ''
     raw = []
     for item in in_list:
         raw += lookup_email(item, alias, warn_on_error=warn_on_error)
@@ -405,7 +404,7 @@ def build_email_list(in_list, alias, tag=None, warn_on_error=True):
         if item not in result:
             result.append(item)
     if tag:
-        return [f'{tag} {quote}{email}{quote}' for email in result]
+        return [x for email in result for x in (tag, email)]
     return result
 
 
@@ -524,13 +523,14 @@ send --cc-cmd cc-fname" cover p1 p2'
 
     cmd += to
     cmd += cc
-    cmd += ['--cc-cmd', f'"{sys.argv[0]} send --cc-cmd {cc_fname}"']
+    cmd += ['--cc-cmd', f'{sys.argv[0]} send --cc-cmd {cc_fname}']
     if cover_fname:
         cmd.append(cover_fname)
     cmd += args
-    cmdstr = ' '.join(cmd)
     if not dry_run:
-        os.system(cmdstr)
+        command.run(*cmd, capture=False, capture_stderr=False)
+    cmdstr = ' '.join([f'"{x}"' if ' ' in x and not '"' in x else x
+                       for x in cmd])
     return cmdstr
 
 
-- 
2.43.0

