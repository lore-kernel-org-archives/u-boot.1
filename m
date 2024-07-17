Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A31DC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D1D88B06;
	Wed, 17 Jul 2024 17:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SkaVbQ2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6254D88AFC; Wed, 17 Jul 2024 17:57:40 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7033188AD6
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-367a9ab4d81so4245525f8f.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231858; x=1721836658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9m5I9suodinHrzR1GRG/eJ8VwnXvYLUt5n8TqXNj+U=;
 b=SkaVbQ2E41THxRF10E3mPG79mEZKdmd5TVNnMcN+91tah7evVGMq9JyX1Dw4Bw6wRz
 R8z76W3JYvo1CbcMMozy4cDdjH10ikxfbCVgsKViUwtrj72IXhubENSEjdwMxd161i2E
 gE+f74oMKRd93FjE9v6oRH0NeaUUdwJUE1tMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231858; x=1721836658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9m5I9suodinHrzR1GRG/eJ8VwnXvYLUt5n8TqXNj+U=;
 b=hWEn+FuSI/4S0ZrkCkkam6xtptGRT87Vdr1QQ7tPJHk+VH+pRB4VZ3OgtTyzLnDOkj
 smbNs9JvoTbatv1szH/fAdptzgJfFpYTNuMs+IwgWSGqgmFooU2249IzKY+erb0cPfS2
 s3jnYqYLUf3haPC800FPhJc6WTEnoCSJmYHMtszMeJ1+8g/xbUlVG7QiDcF73ETj7HQ6
 fljhxULIO41Ix/W2dokNT5KEyotdXAlqWo+iO4OoxUdNLeI2UTdmJfWjLwh7sXLSyirV
 hYuSS8cIyjA7HksXzgosbCMGcCWLXaF/Vio50LbukrU4lGwDylS6krFV+96lj/YTvXnD
 9RIQ==
X-Gm-Message-State: AOJu0YwfETw38OEgB2kf6ze9BllUDiF7CRhfUuPjsmmy+oWNd/ompArx
 XnGk7oSs1Y8js8cPtC7hk9lDnFf3XIgjP+HeC7kLaa4mpsfDOX4Kkgvj3l71QAn1RPX9ITkA9Lg
 =
X-Google-Smtp-Source: AGHT+IFAZGUZIrgowlQiHGJh1gc0CauS5y2ZflS5xuiexu2438AQs/ERdRsEBrH6SoGSV3iYIEI6Dw==
X-Received: by 2002:a5d:53ca:0:b0:367:97e9:1121 with SMTP id
 ffacd0b85a97d-3683167b5e3mr1440919f8f.39.1721231857717; 
 Wed, 17 Jul 2024 08:57:37 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 23/24] qconfig: Move operation check into parse_args()
Date: Wed, 17 Jul 2024 16:57:11 +0100
Message-Id: <20240717155712.2913651-24-sjg@chromium.org>
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

Put the check for an operation being provided into the parse_args()
function, to reduce the size of main().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index dd24e4b398b..408807931ff 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1552,7 +1552,13 @@ doc/develop/moveconfig.rst for documentation.'''
                       help='show any build errors as boards are built')
     parser.add_argument('configs', nargs='*')
 
-    return parser, parser.parse_args()
+    args = parser.parse_args()
+    if not any((args.force_sync, args.build_db, args.imply, args.find,
+                args.scan_source, args.test)):
+        parser.print_usage()
+        sys.exit(1)
+
+    return parser, args
 
 
 def imply(args):
@@ -1660,11 +1666,6 @@ def do_tests():
 def main():
     """Main program"""
     parser, args = parse_args()
-    if not any((args.force_sync, args.build_db, args.imply, args.find,
-                args.scan_source, args.test)):
-        parser.print_usage()
-        sys.exit(1)
-
     check_top_directory()
 
     # prefix the option name with CONFIG_ if missing
-- 
2.34.1

