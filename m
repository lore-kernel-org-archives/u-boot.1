Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8583ECF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C441A88D08;
	Sat, 28 Sep 2024 22:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="md5Uk4ux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DE9088CC1; Sat, 28 Sep 2024 22:00:57 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E97D88CB8
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso10905265ab.3
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553654; x=1728158454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fP1RmEvIU2Sh7Be5Zg+73FY0r6t2TbCqXiAwHWLxaN4=;
 b=md5Uk4uxlwhVcwBF3xAMqWFYBlksXjoK/f9KcMbVdMZ7jeaxl8bbjGg+yRoDZY00zG
 abe6aqc9Xoz695h4xAYLyUIN1ZO7ZrVdBTXgZQQBkJkNLqrqaLRNw61ET4p2C5YPVYwQ
 3coxes0i6DPnca93j3BH8xyX8iAGxH4FvoWK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553654; x=1728158454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fP1RmEvIU2Sh7Be5Zg+73FY0r6t2TbCqXiAwHWLxaN4=;
 b=aFaykAU4ZIbSmVgaOWs+XOQOw3uk07hgg7A5nUu8vsg1MlPjNNlATNVx9/on3vNegp
 OqAr8oM+ZGi+Ntjz5dUEPvefib5OW86rEN4t/ckU6+hs2YSnBHRzo9x1QTHzD6aF9oQF
 npurnWYQajq3ASc22sto4wkaTqLe3kw/JjomM9R70CM/nMqsK55vmnswN9wqiOP34FqC
 rMFzP/PnO2k4Z6lewyzoMBmCwj0tku1UHzYIJkfqxkEQf2C8yCnRCDBJa0IgXlCYxyBC
 YAfQuWLEZFprUL7X1K81IAudQq5roID7qwh2lrmVel2nyFVI4FXq9En028DlWbou1WhY
 Rk9A==
X-Gm-Message-State: AOJu0YwtJPA7zMAcIKuYo+KOO+ZQO7bS/OT20DknGEshCPL0pzvoqCNI
 0Pu1MhCQ32Z6yICIHClZcXAxs5C003TJCA7Ix3gmRdfYg+BqSX0SSvmSJI2VKCCetRUT9uaenSM
 f6A==
X-Google-Smtp-Source: AGHT+IHi0QSPnrQfNGN+xHpYj7s+N3AjwBvGcwMgL2Cuf666JWbRDLGO7wt2SV8g6nyFnRjJsLTUXg==
X-Received: by 2002:a92:c266:0:b0:3a0:9fc6:5437 with SMTP id
 e9e14a558f8ab-3a3451a2361mr56747975ab.18.1727553653689; 
 Sat, 28 Sep 2024 13:00:53 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/30] qconfig: Add XPL_BUILD to ignored symbols
Date: Sat, 28 Sep 2024 14:00:11 -0600
Message-Id: <20240928200030.194546-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

This now appears in the code base, so add it to the list of ignored
symbols in qconfig

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/qconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 8c2fc9efc5f..71e911eeb3b 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -77,7 +77,7 @@ IGNORE_SYMS = ['DEBUG_SECTION_MISMATCH', 'FTRACE_MCOUNT_RECORD', 'GCOV_KERNEL',
                'IS_ENABLED_', 'IS_ENABLED_1', 'IS_ENABLED_2', 'IS_ENABLED_3',
                'SPL_', 'TPL_', 'SPL_FOO', 'TPL_FOO', 'TOOLS_FOO',
                'ACME', 'SPL_ACME', 'TPL_ACME', 'TRACE_BRANCH_PROFILING',
-               'VAL', '_UNDEFINED', 'SPL_BUILD', ]
+               'VAL', '_UNDEFINED', 'SPL_BUILD', 'XPL_BUILD', ]
 
 SPL_PREFIXES = ['SPL_', 'TPL_', 'VPL_', 'TOOLS_']
 
-- 
2.34.1

