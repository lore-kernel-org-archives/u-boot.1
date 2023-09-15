Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2BEEEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DB986823;
	Fri, 15 Sep 2023 02:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cBrphKPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F71186823; Fri, 15 Sep 2023 02:22:52 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 262D480274
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7950fac19f2so58458139f.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737369; x=1695342169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ua3iDW4u6JHt3RGej3C5mgbiKmXEKhdV7Cs2gRsV1cc=;
 b=cBrphKPfojuqA2uEd6sNoEZ31Ccv0O6kT8xoVCInKbaGyxyMgx2fKRHyqtHncrpx+Y
 P1wT7CelNinnliLe068UQoQplJ83T4uo0jy25pEGmASeIhFFKhSndJnR9BEMW+/W31AQ
 PBB69XcNhXUy6h6KT72rewB+wSJxi0lWsYvO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737369; x=1695342169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ua3iDW4u6JHt3RGej3C5mgbiKmXEKhdV7Cs2gRsV1cc=;
 b=Rbu6tUmEtv7fUeBP7GSUn/IutBhqRaDpXBWsoIbXAvov3bec9PWkBiPFa95wunaEsP
 g6fmv2geJYW/z5tjDYUzbPt6oxu65R62NiM6ic0BdxWw3l37BI4L8alhFtT065bBv/7v
 kJ1ezPzgcodMDFOT2clJZ5Ln0kqp0lZGKpsnL5hCaqqCSDGForhlw1iW3f3GzRD0gPIF
 Osig9dt2AXfVNGrDP2UgJPBszzbXK2irTxuojOtrAiM55eOuKXBe/u8WQ6FDhVsdDRSb
 3zBGe96rDabVYwzp/AVVwh7+u3que2He9JPnbwrGb9vIsGookTB1sHeIsIg7Xt1gz/YR
 asbA==
X-Gm-Message-State: AOJu0Yz+m36cZ0qKacPNU0s3Oa2ac0hDMDFAGnIuhhb4QOxpvJzmVUbF
 dX98Nd5AmMYvZPhu1JRNnrhBU5DgyCAg0KnNTGo=
X-Google-Smtp-Source: AGHT+IFABTV4d812rdhRP/TWFICfleZaR9kUihFa/RW+Soh/pnBRLQzCYQDGV0vtf++6zz+B2vOGyA==
X-Received: by 2002:a5d:9a89:0:b0:79a:b526:2f17 with SMTP id
 c9-20020a5d9a89000000b0079ab5262f17mr80928iom.3.1694737368733; 
 Thu, 14 Sep 2023 17:22:48 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/27] moveconfig: Drop -H option
Date: Thu, 14 Sep 2023 18:22:03 -0600
Message-ID: <20230915002236.798760-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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
2.42.0.459.ge4e396fd5e-goog

