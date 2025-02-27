Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B814C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 19:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D843B81417;
	Thu, 27 Feb 2025 20:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YOQZKQ0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50DF081429; Thu, 27 Feb 2025 20:27:32 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29ABD81253
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 20:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-8560dea3ceeso36564339f.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740684448; x=1741289248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IQKGjJaGVNbgYqOdnB+2uiYBVbT2v+tmo8lmDR3S/xI=;
 b=YOQZKQ0pSZuXj8mG+TxSEFGvck4T3rJEizeSnAV5yPhQcWnVGp/XaXhVmIB4SzMRCp
 laOBhbTqyDTXqRYcAjuJujcQLu2esxQvBz5qVg0f5DT5tBeGDBTSVLqtO3cAOxD9qfaa
 7hy30uDnlUxtPTzgMbBAppBzYynUeilLM5X58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740684448; x=1741289248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IQKGjJaGVNbgYqOdnB+2uiYBVbT2v+tmo8lmDR3S/xI=;
 b=fRCO4LDeKSaF6uNBHxnNDu6+75LHFK4HJjqHM2kmaIZXJ0BInQ2Hub4Ou8OOKQ6Kf9
 LRroS+tso0MjQqOrZLa3zh8Xp7FDVX59xCo+hF2rcbyxmyw2iynYRaNVDTzhZpB+bZ42
 TQexiQnAQjePyGuudV1GnZFWA5pRXbUzSjC91LOcJAMNDSmrlE+0N72ImhMUWvlk1Tli
 lfIzWHiWS4dFeBa7+5heGpaLHnVz7HfI5CdYv839NkFvtRjZtI/gAGHmnV/CieYaCeMu
 iTNpqJC6GW1cx7TY9+WmoKkP1zg3oRgiuF5pcbdItzYkyYgvMEHRZbJetQlJX0Xd60sr
 ArQw==
X-Gm-Message-State: AOJu0YzMflWWGrrt7X8bTEPV3enkEXsaTL4w8i8kiWq3Sg2TR9OS+DnU
 36alsyfFpevihJ62zrZb+l80AvXxtQp5PpRWLaPcxa783m4KN7YA3h8aiN3cv3bcL85OjOYfdUA
 =
X-Gm-Gg: ASbGncuoNIbwCaFJXi94Y6orIwZJl+HIM+0Wh+KmfJI7HRfUP0Aeo9fdYReSlDlQntN
 xtakxq1Fzq+cfigJ5F52ZAy5TUIpJrFN976cFAqcIK7dgo3LZmZbRfVEv2iqUTVJqVpfe6ruYWu
 ibu4yrqkv8r2lhsjNI50Wu4WOAUIUPSoldniDM0HpclHaSN2swXQu8sCNYyOQlcc/RwPd0fJpAv
 UKe7sEGWOJiB+FTGUjj7rxjJVeJjsN4mLmfJU7Oz0MGn37v42FUHlyAUHcpXyT9x2wyYh0CZMVs
 ltszGs2fK5hlCuGYyjI8YZ5Yq7en1HdyPZ4A5xaITrRWaVRhSoxvFZ+LK84CTaA=
X-Google-Smtp-Source: AGHT+IEgt8pFVJWgndCRBv9LSqW9Fy4kBm6Gxe6ZuahgQzvQ63bIRSWa3JicNmLKF60BP7GhpUwzXA==
X-Received: by 2002:a05:6602:3422:b0:855:9e01:9ab8 with SMTP id
 ca18e2360f4ac-85881effbc5mr24025339f.1.1740684447916; 
 Thu, 27 Feb 2025 11:27:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-858753cc685sm43075439f.38.2025.02.27.11.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 11:27:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] qconfig: Correct unhashable-type error with --scan-source
Date: Thu, 27 Feb 2025 12:27:19 -0700
Message-ID: <20250227192723.406066-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

This gives an error with newer Python version, so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 058d72cf4bc..9223ccbfded 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1453,7 +1453,7 @@ def do_scan_source(path, do_update):
     print('\nCONFIG options used as Proper in Makefiles but without a non-xPL_ variant:')
     not_found = check_not_found(all_uses, MODE_PROPER)
     show_uses(not_found)
-    proper_not_found |= {not_found.keys()}
+    proper_not_found |= not_found.keys()
 
     # Scan the source code
     all_uses, _ = scan_src_files(src_list)
@@ -1471,7 +1471,7 @@ def do_scan_source(path, do_update):
     print('\nCONFIG options used as Proper in source but without a non-xPL_ variant:')
     not_found = check_not_found(all_uses, MODE_PROPER)
     show_uses(not_found)
-    proper_not_found |= {not_found.keys()}
+    proper_not_found |= not_found.keys()
 
     print('\nCONFIG options used as SPL but without an xPL_ variant:')
     for item in sorted(spl_not_found):
-- 
2.43.0

