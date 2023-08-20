Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F659EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 19:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D49C869E9;
	Sun, 20 Aug 2023 21:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jr/4zMHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 058C386F9B; Sun, 20 Aug 2023 21:04:30 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C1B586AF4
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 21:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fee51329feso7063985e9.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692558265; x=1693163065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Msrb6/nmtExFC8B0sHWpf3s96bn/pi+WsRWwEFGprnc=;
 b=Jr/4zMHnYYGEetV0NEX5UGXaz3vANADDc+pmkdgraAtqDiZ1SA4mZRr8RrAsxHm6MT
 5KNGF8xv6Yj4sCe4TWAnhjnnilfd6XEO3QAFphuyGW2KFD0uU/x/YQB5oYqUWJdezDCy
 CxbDJGaQcLOMcSDOEQdsXtY55EpnKUXxNMusUq4593V8Mw7ma3XIuwdwYsrLFK3kkoSV
 DxnsPWIb1IqeotIp2Yea2P1ulHc4TnXipcfZEN2hHkZuBGDacAj7pedZ417vXF1swx6F
 t76zYzFmi9FGAwvU8OzdQwsJq+PRyZfZ7H9BfO5Dzj54gd3duCXzGuyWCHPBY/i9tQLJ
 OENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692558265; x=1693163065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Msrb6/nmtExFC8B0sHWpf3s96bn/pi+WsRWwEFGprnc=;
 b=irA4W0Nj9vwuaLqypU1Jcheu+rb1Z248S1tKovQxJ3SRb4FMxVfXFr0qcTJaxyHxR3
 GQpik/t5j4TS5a0daE7zuygWDeuuyEdtShlZJrnDqC4Ywb1VgBDyhwC0D7j1EBhPrLb9
 btRRju+c3leLcbSABLLzliC0ngN1IzsnDgnTqJDOIMWOFen1S+r40e9YG66HHEtneUyk
 N+2QXbzRnoLI1O1q9wLVW6+ERckTeVtkf2W5mi5KJPuC498Q5lDuIYbBhukHZ41DjCOR
 DoLJ0G/UwBwTuypNxpqI2Vzwn4rz6s0FqRQeIZEQ0mt8DUYkpfIzqCXOvMwxM99m6CDV
 SmrQ==
X-Gm-Message-State: AOJu0YwB4bvz9IMCOM6AvRAyR8/egKpaNakWoWBO6qbCA2+VK1bxMJTe
 x9z5IYxt2AmuFHXrawfzyRkYDBGYJJ2brBds
X-Google-Smtp-Source: AGHT+IGwyZ5r4bCt7e1nNOn/3pSca+QC16g2pvaFtapd+w+oXIOIGoOa+nRCW2EB6dfnO+lVFpuJEw==
X-Received: by 2002:a7b:c38a:0:b0:3fe:215e:44a0 with SMTP id
 s10-20020a7bc38a000000b003fe215e44a0mr3644036wmj.18.1692558264793; 
 Sun, 20 Aug 2023 12:04:24 -0700 (PDT)
Received: from fedora.. (cust-west-pareq2-46-193-56-152.wb.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fed78b03b4sm8253797wmc.20.2023.08.20.12.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 12:04:24 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v1 3/4] scripts/gen_compile_commands.py: fix docstring
Date: Sun, 20 Aug 2023 21:04:11 +0200
Message-ID: <20230820190412.21266-4-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820190412.21266-1-jmcosta944@gmail.com>
References: <20230820190412.21266-1-jmcosta944@gmail.com>
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

The referred tool is now in U-Boot. Replace "the Linux kernel" by
"U-Boot" to make the docstring coherent.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 0227522959..63d036a773 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -5,7 +5,7 @@
 #
 # Author: Tom Roeder <tmroeder@google.com>
 #
-"""A tool for generating compile_commands.json in the Linux kernel."""
+"""A tool for generating compile_commands.json in U-Boot."""
 
 import argparse
 import json
-- 
2.41.0

