Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B48AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 19:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A6A1884BE;
	Fri, 26 Jul 2024 21:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4y5IQ2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1B4D884BE; Fri, 26 Jul 2024 21:03:25 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828D088363
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 21:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=computersforpeace@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70aec66c936so1127540b3a.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722020602; x=1722625402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u+xo60tx0+0t+ttegyU3khfsJHjdnRP2MDE6Zz8UBHo=;
 b=J4y5IQ2iI3KVyVCnwHLHvr1YBC4LHjPGNHuH/y8LMVHUzOdyWARF45gV6kMrYOUDu4
 T8CIkWQs/U7Fj2oyZrrH4dArZSRA3h+UBsr/gShE6u92wo7QW0am7T8s/vu9SGEj5djw
 wTEvEvWBc7AQKPz1GG4nqmlxoogSBsJQXNUdmqtoYzTGC+2eQK891Ki5MdXLn19IBpMm
 lmpLqe4+8K+mAvsMglkIYhMXV6FrW1eVnJV+NFvyJlKBbvWeMEIrZvfJXmuMa/Tk0zZm
 izIrrKTERuAfDP0gI/JTgzrY3rEylLNZRyP125k+ZQxJiGq6xp04nA4NHHsmBHFOFAFY
 XJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722020602; x=1722625402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+xo60tx0+0t+ttegyU3khfsJHjdnRP2MDE6Zz8UBHo=;
 b=Z57frwdNXHUEFsD64I8UAZQOT0HbhjsnNvltz51YbEbyrCecEnE3K7Ss7f5mF13vtk
 nsdvQS5R3yC6aEW7m/IqEMQLq6pzR5YdWZj58weQ8lbS20p/ezecpce7Nyk9+4vL2bR8
 ZMTd5hN9MHyUFJIhzCyZHU3G1XRS+3IgOm7PcCKlEiwFLSlPkLIVUeBLp9zmk7NA5SYk
 Y5wd94vnGpxZ+7u8kSjHbdLRBVVcVqtTWeCUJBWt4gRd+V1t23y7WENMoCRA+6ORe8e4
 PWZE5NoOIXdz3fAMjTPtJQ6ALoLBkOmtkORAEG1V3QleNR8SvP5WaGjsPmRMXKsFfdKJ
 2TLA==
X-Gm-Message-State: AOJu0YwO8xPoT7QRJm/6lishjztu+k3Cp6MGIe3uPFF4+XZIHF0iZ4A7
 /LON0mXm+Jb97u+ekjYSVWk22oSApozWDwxAlRlMWspIk+0iXo2c
X-Google-Smtp-Source: AGHT+IGD8Y15aY7Zp7iVD8PBq1yTiS8VU9tUFAk45pRQZj1QZXzZKXrvtCOon52tOlHo6Qu7tCRv9g==
X-Received: by 2002:a05:6a00:2d23:b0:706:3580:ac4c with SMTP id
 d2e1a72fcca58-70ecea40f5amr537847b3a.17.1722020601857; 
 Fri, 26 Jul 2024 12:03:21 -0700 (PDT)
Received: from localhost ([2600:1700:38c1:1d7f:f66d:4ff:fe3c:3ceb])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71f1dsm3169707a12.3.2024.07.26.12.03.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2024 12:03:21 -0700 (PDT)
From: Brian Norris <computersforpeace@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] patman: Resolve python string vs. regex escaping syntax
Date: Fri, 26 Jul 2024 12:02:33 -0700
Message-ID: <20240726190240.167338-1-computersforpeace@gmail.com>
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

Python strings have their own notion of backslash-escaping, and that can
conflict with the intentions for strings passed to the 're' module. In
particular, I get warnings like this:

tools/patman/../patman/commit.py:9: SyntaxWarning: invalid escape sequence '\s'
  re_subject_tag = re.compile('([^:\s]*):\s*(.*)')

We should use a raw string (r'...') so that all escaping is passed into
the regex module, not interpreted within the string itself.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---

 tools/patman/commit.py      | 2 +-
 tools/patman/patchstream.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/patman/commit.py b/tools/patman/commit.py
index 684225c0e60d..ce37a3d95eb9 100644
--- a/tools/patman/commit.py
+++ b/tools/patman/commit.py
@@ -6,7 +6,7 @@ import collections
 import re
 
 # Separates a tag: at the beginning of the subject from the rest of it
-re_subject_tag = re.compile('([^:\s]*):\s*(.*)')
+re_subject_tag = re.compile(r'([^:\s]*):\s*(.*)')
 
 class Commit:
     """Holds information about a single commit/patch in the series.
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index a09ae9c73714..4955f6aaab99 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -48,7 +48,7 @@ RE_TAG = re.compile('^(Tested-by|Acked-by|Reviewed-by|Patch-cc|Fixes): (.*)')
 RE_COMMIT = re.compile('^commit ([0-9a-f]*)$')
 
 # We detect these since checkpatch doesn't always do it
-RE_SPACE_BEFORE_TAB = re.compile('^[+].* \t')
+RE_SPACE_BEFORE_TAB = re.compile(r'^[+].* \t')
 
 # Match indented lines for changes
 RE_LEADING_WHITESPACE = re.compile(r'^\s')
-- 
2.43.0

