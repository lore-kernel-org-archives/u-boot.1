Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A70C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 17:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF788367E;
	Sat, 24 May 2025 19:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e0V06Yuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DD382ED0; Sat, 24 May 2025 19:07:27 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F41834BC
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 19:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8647a81e683so21164539f.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748106444; x=1748711244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMvDGEweaug6rJN03dr56/xx8QhxFWH4frJE7Pj3YVA=;
 b=e0V06Yuz27aBDrSIkNbdDNhAS69J6mqhms9G1Z8eNwuARdCSH8068ZU2S5GS4nhbXr
 ORMdSrrA7WFy0iHixGTloEWyAqa2YwIItysZ5L217CZ+CRuAOCwKCqe1hcLLtwwdgjwe
 h20xUSEbZwRLe8ZI5tlSE+ploS58s2n0fb90A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106444; x=1748711244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMvDGEweaug6rJN03dr56/xx8QhxFWH4frJE7Pj3YVA=;
 b=hxN2W0G8sl3lMz9zkFIV+dXzQOdYeIEoftTbxczX3auoo1GI3n0+KBsu1DYqQpTmz9
 MJxyw/799OIaYwkBKLn+7Ah0CyuHKKWTKfioIZUka+xjGFjzzM5OaOCrarO40mcK6IEr
 XDORKIUEw5dZBXkjyjOikh3sgSFdf2uif/mRI4pdN9PLMFqHnuR0gg9y2IxNwu7EEsAk
 +EMtOSIEsU7ySEQTt5qABCAeKs0FfGAXeNrd6MxiBPxYlAB+kWqyC65RTpCE3YFebxjw
 rfxvLEGblutWTRKl7KgTqIDFYbTkaREsClL67CF63QpxZdb2phzx4hfswwZk6s2/tHl4
 ICsg==
X-Gm-Message-State: AOJu0YyJV1HRFPNV5af/s365HU7Ffqvs000TTNxPzmWMs1LQh0SU2E4W
 8Yos9Ud98TWQozb/Lh++9bFwOrdOH6sukV05RLjfF2ribQhXKWHdEJ/0vLaOYnBhTCEjWbIVoln
 7K8wS+S4E
X-Gm-Gg: ASbGncvoaOmcppNiqQVH6LC+U+HBr41zBEUZfKLpKiqhZKjdO3yHZ3avgKb389DQ6/3
 XJCrxV5hYnOt3j9HRw/d732yiruDEPG83aLa7F1cPfzwHE07chmTSqZ+dQ4F2K+Mw903B1rb0ub
 n4A/17uQ+ALqnPCtrTO10TUCaM7j1btvknS89YdDUVBUDi9Ieo/+UEvVyKp0+YqoWFlIeQYUzxA
 8B0UXlCAjZJzr6JQeBeav7q7XdFhnvL8zYBtfCRGuHtyLoaxLuBc+tCziT6SpODOt40PTq9MxB3
 IFk8AdtCa8hWt1qTZfGp5yC1eKJ7CSMVqceytHkQI/VBY1cI6nbsG6YbIjJxE7y0KxeNLc0GAhu
 2ppewHLNqbcUf
X-Google-Smtp-Source: AGHT+IGCAU41q93uutqIgKyGjVy9Crxp4Og861iYvV1yUUc5HDz0RM2cgL52y1j24MOdQTUm4OIYJg==
X-Received: by 2002:a05:6e02:380b:b0:3dc:7a56:18f6 with SMTP id
 e9e14a558f8ab-3dc9b73636dmr28733015ab.22.1748106443947; 
 Sat, 24 May 2025 10:07:23 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc9e7d18c9sm3940355ab.53.2025.05.24.10.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 10:07:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/7] patman: Correct parsing of branch names
Date: Sat, 24 May 2025 11:06:54 -0600
Message-ID: <20250524170701.1238642-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524170701.1238642-1-sjg@chromium.org>
References: <20250524170701.1238642-1-sjg@chromium.org>
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

The name 'x86a' must be parsed as a branch name, not as versio 86 of
branch 'x'. Correct the regex and add a test for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchstream.py  | 2 +-
 tools/patman/test_cseries.py | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index aec7643838c..37c66cf5a7e 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -83,7 +83,7 @@ def split_name_version(in_name):
             str: series name
             int: series version, or None if there is none in in_name
     """
-    m_ver = re.match(r'([^0-9]*)(\d*)', in_name)
+    m_ver = re.match(r'([^0-9]*)(\d*)$', in_name)
     version = None
     if m_ver:
         name = m_ver.group(1)
diff --git a/tools/patman/test_cseries.py b/tools/patman/test_cseries.py
index 1189a1344e8..aa9160bcb66 100644
--- a/tools/patman/test_cseries.py
+++ b/tools/patman/test_cseries.py
@@ -3255,6 +3255,10 @@ Date:   .*
         self.assertEqual('No branch detected: please use -s <series>',
                          str(exc.exception))
 
+        name, version = patchstream.split_name_version('x86a')
+        self.assertEqual('x86a', name)
+        self.assertEqual(None, version)
+
     def test_name_version_extra(self):
         """More tests for some corner cases"""
         cser, _ = self.setup_second()
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: pate
