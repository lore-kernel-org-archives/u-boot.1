Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5A7C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742C788AB5;
	Wed, 17 Jul 2024 17:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BqJmrCBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B87388AA5; Wed, 17 Jul 2024 17:57:27 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4928E88464
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso52650895e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231844; x=1721836644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQHVBnDYJbgEPzPJ/LWgNIgndBxCiuo4GIpaVhPZ/Lk=;
 b=BqJmrCBlD4xB8h3gVj08tS68j/j3uIXmGBtTaH6zGRVnz6gHWRcTWz2+94h6h6M3Cj
 odWPHn+LLa7H3KSn8bEvyEti2+Iub1pRBUyj03YXNByOgVJIAK1yo0gtclXsZobaUhT1
 E1fGWO8M2X0Ujb5BnZTxxDB0+Vf/qG841udug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231844; x=1721836644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQHVBnDYJbgEPzPJ/LWgNIgndBxCiuo4GIpaVhPZ/Lk=;
 b=fFpNkEU8sSZAKvForOXMfEd+pxv0GUwnShH/7OxZCR4LowaRYxCdeJ+rKzvjtdDZa7
 iMhaARh4vT6N1SSS85JPZF6ccGI6a4KhpfX1QvyN2c/E5Tzhu95eb76kwXpuSVaYfw9t
 SzMSn8VB0L9QRcnRvlOqLrKA2gDSoC3NH1xjdbZo7k7URY24CiX2XC8X1uiKnvbdbWDQ
 /JCOrZ6t588fMrlcF5TyNnb/HB9F4atbytBGtNtxodKUeUYIOGmwHChzqHYrQ+mol7es
 Nr76sUMScBsU5JE/ekjVwe5dOX8ufHvljT/hovfc5xj8wIG8grzH4WM3DSwcfcx8auTj
 WNDA==
X-Gm-Message-State: AOJu0Yzm25JXSrHgS1drBQTpBSdbXNTsNiciz19VJ8CJYL01cuGGfe2J
 Q+2M7ewhZZQnrKnFlsgR5BhrN6jOgJ6IHsi044Q5w4s+5LAyxNwl3sHdSyRzwG7lwblxDTt/OSk
 =
X-Google-Smtp-Source: AGHT+IGDbMue0Z2anokHx60Hm3YuF975Zp8reYbYuE4MIR8vtbh4eyfBl91vKsgHG3loH9h+sBlf6g==
X-Received: by 2002:a5d:59a2:0:b0:367:9073:3496 with SMTP id
 ffacd0b85a97d-3683160e527mr1875479f8f.29.1721231844332; 
 Wed, 17 Jul 2024 08:57:24 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 08/24] qconfig: Move arg checking a little higher
Date: Wed, 17 Jul 2024 16:56:56 +0100
Message-Id: <20240717155712.2913651-9-sjg@chromium.org>
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

Check for scan_source as one of the possible operations for this tool,
moving the check above the scan_source implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index d8f0a716fe9..6d263ce30db 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1534,14 +1534,15 @@ def main():
     col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
                          else terminal.COLOR_IF_TERMINAL)
 
+    if not any((args.force_sync, args.build_db, args.imply, args.find,
+                args.scan_source)):
+        parser.print_usage()
+        sys.exit(1)
+
     if args.scan_source:
         do_scan_source(os.getcwd(), args.update)
         return 0
 
-    if not any((args.force_sync, args.build_db, args.imply, args.find)):
-        parser.print_usage()
-        sys.exit(1)
-
     # prefix the option name with CONFIG_ if missing
     configs = [prefix_config(cfg) for cfg in args.configs]
 
-- 
2.34.1

