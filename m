Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EEEC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 21:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFC588025;
	Tue, 27 Feb 2024 22:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iQQq1IWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693108801C; Tue, 27 Feb 2024 22:51:18 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C59A87FFE
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 22:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7D70F3F201; 
 Tue, 27 Feb 2024 21:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709070674;
 bh=MM6lSsyA9cfxDBYI0ibiZB90vFeuOHd3tmouLlMgzfI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=iQQq1IWvj5X/BpDwVdhVfxHhvT6Ep9KuHUUJJifnfheZXNBn0ULvhjF+Ki19TWu2M
 q5VEKTk06XDpqzyl5252EYgdHKNmpqOO5M3S3RxzZlB93yRVcDCBLMAEiOqVd/MBOs
 ply7mVwKS0/EwvKRr0Hq+9hVkMSrDi+wfj6IduPRktYzH8dHVmgmjiUjir75AJrpM0
 Nf/CIfuWtpHbMlldoe/6lyaqevyolaSwnlCZX5pc/lQ+PBRTQtn7T3FQbR7bGoHUmk
 s1c5JukcOqDqLJ96nnK/dgeLSDBW/kTA5j7eZlfq02C0cJARCpytUBRUupvbiuLJjc
 aNum4Q1STB/gA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dtoc: avoid invalid escape sequence '\s'
Date: Tue, 27 Feb 2024 22:51:38 +0100
Message-ID: <20240227215138.236403-1-heinrich.schuchardt@canonical.com>
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

\s is not a valid escape sequence in strings.
Mark regular expressions with r''.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/dtoc/src_scan.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/dtoc/src_scan.py b/tools/dtoc/src_scan.py
index 3bef59d616..2437200a42 100644
--- a/tools/dtoc/src_scan.py
+++ b/tools/dtoc/src_scan.py
@@ -291,8 +291,8 @@ class Scanner:
         """
         structs = {}
 
-        re_struct = re.compile('^struct ([a-z0-9_]+) {$')
-        re_asm = re.compile('../arch/[a-z0-9]+/include/asm/(.*)')
+        re_struct = re.compile(r'^struct ([a-z0-9_]+) {$')
+        re_asm = re.compile(r'../arch/[a-z0-9]+/include/asm/(.*)')
         prefix = ''
         for line in buff.splitlines():
             # Handle line continuation
@@ -470,8 +470,8 @@ class Scanner:
         re_of_match = re.compile(
             r'\.of_match\s*=\s*(of_match_ptr\()?([a-z0-9_]+)([^,]*),')
 
-        re_phase = re.compile('^\s*DM_PHASE\((.*)\).*$')
-        re_hdr = re.compile('^\s*DM_HEADER\((.*)\).*$')
+        re_phase = re.compile(r'^\s*DM_PHASE\((.*)\).*$')
+        re_hdr = re.compile(r'^\s*DM_HEADER\((.*)\).*$')
         re_alias = re.compile(r'DM_DRIVER_ALIAS\(\s*(\w+)\s*,\s*(\w+)\s*\)')
 
         # Matches the struct name for priv, plat
-- 
2.43.0

