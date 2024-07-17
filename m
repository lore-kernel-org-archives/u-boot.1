Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5E4C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D2B88AB9;
	Wed, 17 Jul 2024 17:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PgBnu6Ld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F381088A69; Wed, 17 Jul 2024 17:57:27 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE0088A85
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so6142815e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231845; x=1721836645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3tgN5Fs5W0eB/pfg55+8Ss6D483RJ8zAQwysfZ83+I=;
 b=PgBnu6LdLIg0JJatgVRqk5gKeiXW+edDB/ZCY/OyleN7ZIu9u35njn9bXTcvovD/Gt
 JfjNfDYD40HB8OpKOEOpFsxgwAHiCUThnEz4JUATC2eSMO99CISqCHWtTmk7AaQwrQKi
 8HJct7mgZfd2SvM+aKeI0sel4ogZHslVuQvDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231845; x=1721836645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3tgN5Fs5W0eB/pfg55+8Ss6D483RJ8zAQwysfZ83+I=;
 b=h776yopotLkNk4SS2AFAqOLPWEc8rS8x05PwkXYgQWsBKDL0sVLcPB613yFo3FnULC
 yMCA4HH2QpfnTeeQwHdGVlVUUhJFVYMc0NAOHb4ac+BTho3JSK6AKqzsAm7Nzv/osye0
 STEchpC+JPNQm2/loSJBTAIwXTUg9uLe03WRG1AzNKD5Dka+DugUxVLqqqogYEPAKeAf
 0djbViLgkzw3509N5gkifHkrNeutqf0ljHeEXPh/Po9kA9/Gop64Qiubr9DF9Dbf3dL/
 7cO9M0zbzP+wK5ezSG9QXOmR4fnOsmZOl8SoKiUGiuzEjeP1jxGiJauT4xsYTPuWBn/o
 9UDA==
X-Gm-Message-State: AOJu0YxCbl7jJSaEe4/1P22/x7v5+lpSymJ6rcYIBr/RQ5HlfEQqabBx
 ZLDpJqpU2NmHucLqmLnLiGuDkszTBxjlw6FHSZdWQrCy2OOS55glrT/dmJTcxh5v8p/z04V7p98
 =
X-Google-Smtp-Source: AGHT+IG0NzHBgvNgCIlpIjwc6h5bfAeiPtUguCeKtf4TF8EbxKsRg960zMZ53IEkE5trrXXhJ9Dm5A==
X-Received: by 2002:a05:600c:3152:b0:426:6252:61d9 with SMTP id
 5b1f17b1804b1-427c83992e7mr519285e9.11.1721231844984; 
 Wed, 17 Jul 2024 08:57:24 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 09/24] qconfig: Move arg checking to the top of main()
Date: Wed, 17 Jul 2024 16:56:57 +0100
Message-Id: <20240717155712.2913651-10-sjg@chromium.org>
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

Check for 'test' as one of the possible operations for this tool,
moving the check above the implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 6d263ce30db..9052aedf57d 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1524,6 +1524,10 @@ doc/develop/moveconfig.rst for documentation.'''
 def main():
     """Main program"""
     parser, args = parse_args()
+    if not any((args.force_sync, args.build_db, args.imply, args.find,
+                args.scan_source, args.test)):
+        parser.print_usage()
+        sys.exit(1)
     if args.test:
         sys.argv = [sys.argv[0]]
         fail, _ = doctest.testmod()
@@ -1534,11 +1538,6 @@ def main():
     col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
                          else terminal.COLOR_IF_TERMINAL)
 
-    if not any((args.force_sync, args.build_db, args.imply, args.find,
-                args.scan_source)):
-        parser.print_usage()
-        sys.exit(1)
-
     if args.scan_source:
         do_scan_source(os.getcwd(), args.update)
         return 0
-- 
2.34.1

