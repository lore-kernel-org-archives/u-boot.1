Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F314CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C942F86B9E;
	Sat, 23 Sep 2023 21:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aNoBr0Jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F97863DD; Sat, 23 Sep 2023 21:44:49 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D1386B5D
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34fc2773fa4so12837045ab.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498284; x=1696103084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKd+9yoqEroZXt0fsN39OeWi9URbgTySjvtmJpFiGEg=;
 b=aNoBr0JnYm5ASmIo7GpsECG8mn8rBEz3P6KSSyqEvOs/Rce2tmAuNBRO5JAT/Wp3mY
 +/fJxRbi8tvmseGX2KY0QdOcY9hriS9s/hfcxbp3n1CEwr5FxO/bWAoUzSu2hoGhRrrk
 18txABJdScGsmvXpyvGOpBnHpV+98BV4WQKzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498284; x=1696103084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKd+9yoqEroZXt0fsN39OeWi9URbgTySjvtmJpFiGEg=;
 b=kbR2Qq+8xzlXYGyo29LQLWCs2LodVCASz+lWOFgY2yi330E01QcmQtzEVgHneDfxN7
 hE92BAXFdZD5/zIJQPFNDIRBxwrfEjjpetsgeN3wAknQk8VwHaDzN4jpQFoeBAM3fWhw
 RWMHqSb1kHoE4cvWCOtFtw47r9Thx57+gNhD6kAvti58M/itj0WXHO0CxwI36zrHRCtM
 /rfw/kSlf9qM8Sa5fkmDHnoyGJAoLvL/cgczmbxD4qlyrlA1enZVjI+XC9BOcb6WHs6A
 66MGILsJSSrsquCXTFeNtf/lCjzMQ7+ah2irHwspac3SqM3svCXp+pVXEaTC1pLixMuc
 afEw==
X-Gm-Message-State: AOJu0YziEVNOoSpAA4Y/oV/9ArL2BW5IIKSF+lN4Yd8zrgbTgLek8Kd8
 avv+gFdj0kDTVQa0n83233gQwGzA7wvQfB6xd9Q=
X-Google-Smtp-Source: AGHT+IG+Q18QK0ns8vY4Nb9maXo/DFAwBx6cXO06zx/i00FW5loMm4gP8TY9QpC/uJtdkGjQNtJ3uA==
X-Received: by 2002:a05:6e02:1bcb:b0:349:796b:2299 with SMTP id
 x11-20020a056e021bcb00b00349796b2299mr4008008ilv.6.1695498283883; 
 Sat, 23 Sep 2023 12:44:43 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 15/27] moveconfig: Use an encoding with open()
Date: Sat, 23 Sep 2023 13:44:04 -0600
Message-ID: <20230923194424.1739224-16-sjg@chromium.org>
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

Fix pylint warnings about needing an explicit character encoding.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index d46433c6d8f5..9b716596956b 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -1457,12 +1457,14 @@ def do_scan_source(path, do_update):
 
     # Write out the updated information
     if do_update:
-        with open(os.path.join(path, 'scripts', 'conf_nospl'), 'w') as out:
+        with open(os.path.join(path, 'scripts', 'conf_nospl'), 'w',
+                  encoding='utf-8') as out:
             print('# These options should not be enabled in SPL builds\n',
                   file=out)
             for item in sorted(spl_not_found):
                 print(item, file=out)
-        with open(os.path.join(path, 'scripts', 'conf_noproper'), 'w') as out:
+        with open(os.path.join(path, 'scripts', 'conf_noproper'), 'w',
+                  encoding='utf-8') as out:
             print('# These options should not be enabled in Proper builds\n',
                   file=out)
             for item in sorted(proper_not_found):
-- 
2.42.0.515.g380fc7ccd1-goog

