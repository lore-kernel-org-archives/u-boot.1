Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D137C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F380788A91;
	Wed, 17 Jul 2024 17:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MPjn1RQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228C088A94; Wed, 17 Jul 2024 17:57:26 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E2D88A7F
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-36798ea618bso4040420f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231843; x=1721836643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxhS3QzmIeiePQwfniISwPF25W9ft1nDSpcuXnmBmQA=;
 b=MPjn1RQg5tMz3U5D0ZOS0B6p2EYeBi3sN2AxQqNgqfLH93XGpmVtOLAhCVCUZ4na+e
 rcvKzq6Z5B330XVnCGndyhrhGB1KemxIl7VZqTyU7ZIMMZVkd5PvDTppeWf/AehMQzLk
 dW9+fX8wFEA0aEh20NX3Z50TL+4LlJy9mJubs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231843; x=1721836643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxhS3QzmIeiePQwfniISwPF25W9ft1nDSpcuXnmBmQA=;
 b=HPHUlKxd9WxsPC1Ol6gro3pvLApdYAU2lOkNyM2yhPsUIQimGqBPsqtJs5uJ0pihX+
 +HGU8Eux2mz0ChYAHHFsqzyuslZ/4A1wdqrUaAJMcG7aRlzyBNxYnatXEkUUEBCJylYx
 VuW/OIMc2PNTzHXop+4JvqPn0w7IHYA6JN1T8J+hgzEk66+L+gLjjAHEGDTrcHHHSFq5
 pJtmHFQKYzpuaRFhn9/uWUpEqYbyaWCCTYdllYtkxApOExBCwtzQnvdC8FqEujOV+GOY
 z9+plqwsRrQB72gv3YGFulKiJqmLEscRzkCz2U/i1oqRzEwUXyG2i6qZAoaqByt0RxZI
 CxTw==
X-Gm-Message-State: AOJu0Yyu9oGej7MvO+Phqdm8ZWbtiv0mj4pCy91D38LXv/oQ3EeEzZMw
 cMrqUiGV5ZRhZPajavwad3sr0pub412SgbKf/egAqhiQjsr688hY53pq6n+BSWaqPp96VJjodwE
 =
X-Google-Smtp-Source: AGHT+IH9I5jpT7ow3umedjDfPNEx5MdQq6wNbmzNQ9llSmjn3BuPdH2F6CPdJm9tpLRWNNWOsluk9Q==
X-Received: by 2002:a5d:528a:0:b0:366:eb61:b47 with SMTP id
 ffacd0b85a97d-368315f6189mr1446514f8f.8.1721231843512; 
 Wed, 17 Jul 2024 08:57:23 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 07/24] qconfig: Move arg parsing into a separate function
Date: Wed, 17 Jul 2024 16:56:55 +0100
Message-Id: <20240717155712.2913651-8-sjg@chromium.org>
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
For now the parser object needs to be returned too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 07d78387465..d8f0a716fe9 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1453,8 +1453,14 @@ def do_scan_source(path, do_update):
                 print(item, file=out)
 
 
-def main():
-    """Main program"""
+def parse_args():
+    """Parse the program arguments
+
+    Returns:
+        tuple:
+            argparse.ArgumentParser: parser
+            argparse.Namespace: Parsed arguments
+    """
     try:
         cpu_count = multiprocessing.cpu_count()
     except NotImplementedError:
@@ -1512,8 +1518,12 @@ doc/develop/moveconfig.rst for documentation.'''
                       help='show any build errors as boards are built')
     parser.add_argument('configs', nargs='*')
 
-    args = parser.parse_args()
+    return parser, parser.parse_args()
+
 
+def main():
+    """Main program"""
+    parser, args = parse_args()
     if args.test:
         sys.argv = [sys.argv[0]]
         fail, _ = doctest.testmod()
-- 
2.34.1

