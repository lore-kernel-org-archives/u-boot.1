Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD20CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 20:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44966889DB;
	Mon, 22 Apr 2024 22:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tPaSWLWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886D5889E5; Mon, 22 Apr 2024 22:01:30 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92362889D8
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 22:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6360B3FADB; 
 Mon, 22 Apr 2024 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713816086;
 bh=JV7R7w9JyqfIdqL8WKAbfdPq5mKXzvWrXxoj9CmPOkw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=tPaSWLWI/hoGGXtZl/a1aOxp1Iyci9JMxvzbE74QYV9zFHF58UQyLbLRD+GASSDPZ
 1FlHpv5Hj3i9bG4zHbqoQvAERZfx1GZOFVPGru8X78zzTfCIgZnm1g2OeKt+n9go7l
 DbTYSH+AmHNdbMJLny9uWThXWFmOHKRDOjcm54FS+fV065CbibkwAODqBkoJX2aOQM
 UklBK8E5MIqOMinfPUQt7TCrwMq+91Wgfk9BJVivhFh9Nu78iymXsLdK05eM11laoP
 n8DX/L/BD746W1dNShkKy2QfQkBgeHbHLQ61ITa41GtsCmKJdvTsWHRGiiHoWyVMUk
 BpR0xoU8lgNGg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: correct description of 'env print -e'
Date: Mon, 22 Apr 2024 22:00:56 +0200
Message-ID: <20240422200057.27488-1-heinrich.schuchardt@canonical.com>
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

If 'env print -e' is invoked without variable name, all UEFI variables are
listed.

Describe that 'env print -e' requires CONFIG_HEXDUMP=y to print content of
UEFI variables.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/env.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
index 040076bcc03..5478c541776 100644
--- a/doc/usage/cmd/env.rst
+++ b/doc/usage/cmd/env.rst
@@ -226,7 +226,7 @@ in UEFI variables.
     \-a
         all U-Boot environment, when 'name' is absent.
     \-e
-        print UEFI variables, all by default when 'name'.
+        print UEFI variables, all by default if 'name' is not provided.
     \-guid guid
         print only the UEFI variables matching this GUID (any by default)
         with guid format = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx".
@@ -372,6 +372,10 @@ info
 load
     CONFIG_CMD_NVEDIT_LOAD
 
+print
+    CONFIG_CMD_NVEDIT_EFI for UEFI variables support ('-e' option),
+    additionally CONFIG_HEXDUMP to display content of UEFI variables
+
 run
     CONFIG_CMD_RUN
 
@@ -381,5 +385,5 @@ save
 select
     CONFIG_CMD_NVEDIT_SELECT
 
-set, print
-    CONFIG_CMD_NVEDIT_EFI for '-e' option
+set
+    CONFIG_CMD_NVEDIT_EFI for UEFI variables support ('-e' option)
-- 
2.43.0

