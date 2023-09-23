Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DB1CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F9CF86BB4;
	Sat, 23 Sep 2023 21:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aQj5XszV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EFCA86B57; Sat, 23 Sep 2023 21:44:47 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 290D58477A
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so120182139f.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498282; x=1696103082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HL3kUgvM8I/DEDkcw8SFc7Ejy+gs4FlC9kT/Dstl9rM=;
 b=aQj5XszVR1ruD32WWe2K+LablA00zhaZOCd43LxCySnKzXORCDDO3Dm6juUaT0bzNP
 zlpRmnMaWueoK9imGVd0HxIX1QNYTe4ymrYVhUKfLM31nP0+6Qm+pu1UhgPecZWJGmt6
 XNeS3/BqUnEO1ZNaGFBDEDqubBUwNObysdnUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498282; x=1696103082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HL3kUgvM8I/DEDkcw8SFc7Ejy+gs4FlC9kT/Dstl9rM=;
 b=Ih4BO7boqOp2JSswdN4YwVwfLBjndek8a+pO/1YQeeEvjJ5g6/mFj8xk11+cNY5yj6
 YUbum8ELxe1dmY1cwG+ZWP83DL/KCvNWx75tYnIslyGphyOuYtF2i8VOZnFAMa/2kcBT
 t+Zy7te9niJORtIy/nPH9tDKIKxV5YP83s6GADW72QR7qBqBlrCESaPoBj0Ld15EF3KO
 xypjr6E8Wmv+svdg8VYGCcKZACZhCvWeciejyXNpQADHtZoWPVvcXmRcmmz1AjFgDMSs
 6dNyZnfETiGseDR5bdjdJ2uJax04iITpsqBUm8jQUR8byis6dob3xgiymPGS+7Q+SIKr
 BWHg==
X-Gm-Message-State: AOJu0Yy9zUJmAtt5IS4iixg0tFCDnf++yygeaUbHifryejlfPR02eFj7
 Fj43UsSS4cBg5R/H7ujje8WIPIZTl91PMBdwsr4=
X-Google-Smtp-Source: AGHT+IFPqpF/kezp8nnmFpUmHNZgiWKfp//DlUdlVHZ67i4brC1O+cSGl1uFtgyvnfFZbw8xYA6Lsg==
X-Received: by 2002:a5e:c915:0:b0:79f:95cd:10f6 with SMTP id
 z21-20020a5ec915000000b0079f95cd10f6mr5125828iol.8.1695498282693; 
 Sat, 23 Sep 2023 12:44:42 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 14/27] moveconfig: Correct list-comprehension warnings
Date: Sat, 23 Sep 2023 13:44:03 -0600
Message-ID: <20230923194424.1739224-15-sjg@chromium.org>
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

Correct some pylint warnings about needing to use list comprehension.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 1dff89159312..d46433c6d8f5 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -1422,12 +1422,12 @@ def do_scan_source(path, do_update):
     print('\nCONFIG options present in Makefiles but not Kconfig (SPL):')
     not_found = check_not_found(all_uses, MODE_SPL)
     show_uses(not_found)
-    spl_not_found |= set([is_not_proper(key) or key for key in not_found.keys()])
+    spl_not_found |= {is_not_proper(key) or key for key in not_found.keys()}
 
     print('\nCONFIG options used as Proper in Makefiles but without a non-SPL_ variant:')
     not_found = check_not_found(all_uses, MODE_PROPER)
     show_uses(not_found)
-    proper_not_found |= set([key for key in not_found.keys()])
+    proper_not_found |= {not_found.keys()}
 
     # Scan the source code
     all_uses, _ = scan_src_files(src_list)
@@ -1440,12 +1440,12 @@ def do_scan_source(path, do_update):
     print('\nCONFIG options present in source but not Kconfig (SPL):')
     not_found = check_not_found(all_uses, MODE_SPL)
     show_uses(not_found)
-    spl_not_found |= set([is_not_proper(key) or key for key in not_found.keys()])
+    spl_not_found |= {is_not_proper(key) or key for key in not_found.keys()}
 
     print('\nCONFIG options used as Proper in source but without a non-SPL_ variant:')
     not_found = check_not_found(all_uses, MODE_PROPER)
     show_uses(not_found)
-    proper_not_found |= set([key for key in not_found.keys()])
+    proper_not_found |= {not_found.keys()}
 
     print('\nCONFIG options used as SPL but without an SPL_ variant:')
     for item in sorted(spl_not_found):
-- 
2.42.0.515.g380fc7ccd1-goog

