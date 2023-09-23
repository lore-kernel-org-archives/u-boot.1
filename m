Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9308CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A356486B29;
	Sat, 23 Sep 2023 21:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PFMaec1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D898086B55; Sat, 23 Sep 2023 21:44:39 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA94F86A43
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34fd43afcc5so11971655ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498276; x=1696103076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDZpzBgS2sv622PD+QTJBcWMhtxlkzrvrSxGuDN6lVk=;
 b=PFMaec1ssaE2StCOB90urh+PE+nGTl6UIUpLFi+tqCsBQkiI4NwDHSXjCmHp7vASxX
 Mp+0+32eFu94kD/XJtzyUDdHZHFROmcDJzx5qaASQVFVKTqFVWT4V1Wr6ppjlxze67xx
 m+0fwpzQfTPAAYiY6LmfYpJ1pTdlGilLd9a8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498276; x=1696103076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDZpzBgS2sv622PD+QTJBcWMhtxlkzrvrSxGuDN6lVk=;
 b=P02BTSKXoyXbkvzpsQNnQNpqegq16S80Ix8rhVt6X9/3G77wqQdqZAWnNIM/UKxIkQ
 UuD/jYuqL9uk0j+W4xjTsrP1z08B/9hQaocGAu+bj50/4DyRIxcn71PLQxjpCv3KTo3x
 +95KFkf4Nnn2AwnnyB8TghUWZca0ynza/3jP/F6jxPFo1+nSTOGeWESV0INavVUVLocN
 MsJUWmY1OfOyFSJDEfaDbPjhuLGJZ2OW1ptQad6wc+mCd9Un/TtVAwU+1WJGk2R5XeHF
 PmQhQUIkkrX0P4ONvdkmY1jn13+C1qQyx8E/Q0Rs2pLMHv2A8Xul+/VeOh0YU8UJtyDb
 XF3w==
X-Gm-Message-State: AOJu0Yzkvrjcfs/s8CrYUVQjKKrp6Pq/w5oBy4VkmxnPcSWpU58L9LbQ
 zHdOoUzX7sJ4J2ibBENEYoMu7n4qOQx72dh+9S4=
X-Google-Smtp-Source: AGHT+IGmLjik2q30OcQHmDrbU4naofvN/2qJb4AIA1oczlnVb9GZJ/9oMIDHEIUpTbdeM6ooKQzplA==
X-Received: by 2002:a05:6e02:1a23:b0:34f:30f0:d4e6 with SMTP id
 g3-20020a056e021a2300b0034f30f0d4e6mr5689248ile.1.1695498276264; 
 Sat, 23 Sep 2023 12:44:36 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 07/27] moveconfig: Drop suspicious boards
Date: Sat, 23 Sep 2023 13:43:56 -0600
Message-ID: <20230923194424.1739224-8-sjg@chromium.org>
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

This code isn't needed anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 87a670f6e855..36202fe5134c 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -601,11 +601,6 @@ class Slot:
         """
         return self.failed_boards
 
-    def get_suspicious_boards(self):
-        """Returns a set of boards (defconfigs) with possible misconversion.
-        """
-        return self.suspicious_boards - self.failed_boards
-
 class Slots:
 
     """Controller of the array of subprocess slots."""
@@ -684,25 +679,6 @@ class Slots:
 
             write_file(output_file, boards)
 
-    def show_suspicious_boards(self):
-        """Display all boards (defconfigs) with possible misconversion."""
-        boards = set()
-        output_file = 'moveconfig.suspicious'
-
-        for slot in self.slots:
-            boards |= slot.get_suspicious_boards()
-
-        if boards:
-            boards = '\n'.join(boards) + '\n'
-            msg = 'The following boards might have been converted incorrectly.\n'
-            msg += 'It is highly recommended to check them manually:\n'
-            msg += boards
-            msg += '(the list has been saved in %s)\n' % output_file
-            print(color_text(self.args.color, COLOR_YELLOW,
-                                            msg), file=sys.stderr)
-
-            write_file(output_file, boards)
-
 class ReferenceSource:
 
     """Reference source against which original configs should be parsed."""
@@ -780,7 +756,6 @@ def move_config(toolchains, args, db_queue):
 
     print('')
     slots.show_failed_boards()
-    slots.show_suspicious_boards()
 
 def find_kconfig_rules(kconf, config, imply_config):
     """Check whether a config has a 'select' or 'imply' keyword
-- 
2.42.0.515.g380fc7ccd1-goog

