Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B968C3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2588B82B12;
	Sun,  4 May 2025 15:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a7wfDYh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F0782B17; Sun,  4 May 2025 15:24:51 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC3FE829CD
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so593243766b.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365089; x=1746969889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUyG5Ijkvzc9SuY9lgm2JdVjt5BH2M+DPWlDqmA2hDg=;
 b=a7wfDYh9/+4jleDuMM21+tq9Ctj39iAsgpcRlQysAM8ALD/XBdNXWeHuJ8dG6G06uE
 w2mCEhy7rU6yr7eA5hTCFNhPVPIvsLgXAc4z68zz6S+UF7IlzJ1oAWwInP8ra5T5VhB1
 7imNPRFcnOIjmN49aYRWGJEsZtjBYyfk+YxNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365089; x=1746969889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUyG5Ijkvzc9SuY9lgm2JdVjt5BH2M+DPWlDqmA2hDg=;
 b=bOvUYS+MhaX8LgnGtqku2UNyXuiUWNj6YeDkeA6mar9ch9ACUjXELUkV7Rze7Uagcu
 Lj3vyoJzLdMlXj4rJhjnwQewO3Dr1LZZLVvGo7v51vVCd/15cxlHqmWWYsnvf3UJ0aQJ
 58lL687v+dYsFxQGt/ZxBfBe4owv4hr6KsVyHPKwCIsZVFUP5xRe4ktcQkbhQVxdKHGq
 QdJF9WBrm/RoVPju0RO4sah+ZFyEMD/d/qfz0p7O4qVT4bvPTaxg0Ohg3R8relcvX22T
 NBHlq8uqjpanw8aw67xgEfrxl0JqnsnlloF0UFSyhJaE/Si8a5rSKJIrKBsCEW31km4E
 A4gA==
X-Gm-Message-State: AOJu0Ywhk/75Zi2aLaDMlhEvlxGRwiIQNuVvMYYKLFDROquyrP9MMsEE
 BfkGJ8JqfaoeBZv+4gjJNs23T1f/zS56GC3ticspWWY4wdQ/7ZkvXWhht6we8PBlELwQORn3IHJ
 IIgKMTY8=
X-Gm-Gg: ASbGncsOqZktJip8O8SUGQQamdnn/VJKbObKDQyfO/jOHjxzYkeuM4W2RYEEJbtRaSP
 MmAE2UChwCkGrHHmy7K7UPoKMlEAi2hE6h7Dv52D5L93o5bB8BXUtyfoSJjjaqcDdcmy6slaHqc
 tgYcQ5M33BEGK0M1FQHcDe4YjFx+a9OGANixRXXRyB1TykIcjpKtR8Ulm20o+9DqFWOXiVuZdl/
 PELwZgFoNKSO4zjcVc4ire9Hi12wVP4sn5/O1/tIKTHu+3qVhBihPEnotQTtGSlWQlryPXyzARC
 thfdkS4jOPNaxKz/GEOQVSIJLRuDeLPUfkVv
X-Google-Smtp-Source: AGHT+IFeHFQJb1nIEnb9/d5Ciiv99NP1xBoq1wVJ+5Y8xz6dAlTipo76j4MZt5mXNs2DzbOKXFUTPg==
X-Received: by 2002:a17:907:6e8e:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ad1906562b9mr459333066b.15.1746365088698; 
 Sun, 04 May 2025 06:24:48 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 26/30] patman: Use defaultdict directly
Date: Sun,  4 May 2025 15:23:42 +0200
Message-ID: <20250504132356.2317305-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

Import defaultdict to avoid needing to specify its module in multiple
places. Fix an extra blank line while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/status.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/patman/status.py b/tools/patman/status.py
index c114a432bf3..8fc2a50b426 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -8,7 +8,7 @@ Allows creation of a new branch based on the old but with the review tags
 collected from patchwork.
 """
 
-import collections
+from collections import defaultdict
 import concurrent.futures
 from itertools import repeat
 
@@ -55,7 +55,7 @@ def process_reviews(content, comment_data, base_rtags):
         list of patchwork.Review: reviews received on the patch
     """
     pstrm = patchstream.PatchStream.process_text(content, True)
-    rtags = collections.defaultdict(set)
+    rtags = defaultdict(set)
     for response, people in pstrm.commit.rtags.items():
         rtags[response].update(people)
 
@@ -70,7 +70,7 @@ def process_reviews(content, comment_data, base_rtags):
             rtags[response].update(people)
 
     # Find the tags that are not in the commit
-    new_rtags = collections.defaultdict(set)
+    new_rtags = defaultdict(set)
     for tag, people in rtags.items():
         for who in people:
             is_new = (tag not in base_rtags or
@@ -115,7 +115,6 @@ def compare_with_series(series, patches):
             warnings.append("Cannot find patch for commit %d ('%s')" %
                             (seq + 1, cmt.subject))
 
-
     # Check the names match
     commit_for_patch = {}
     all_commits = set(series.commits)
-- 
2.43.0

