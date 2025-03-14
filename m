Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBCCC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 13:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F47E81CAF;
	Fri, 14 Mar 2025 14:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SIpHsHLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA8F81D25; Fri, 14 Mar 2025 14:57:29 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 390BC81CAF
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDvPdg1695769
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 08:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741960645;
 bh=+4I7nHUrguk9damAB7WO7RQ+w1kFCPmVGa0wKxV8HSk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SIpHsHLdLuUmwz5etY0uaVtlGNQDazflK2772Omxj/togcCgXLFB4EOtgdNWdhsl3
 qx/yZvTYvvPUgC1oK58arPhhZx5YOdzf+orLycfal3pIxm01A12/B7owJ36Wd6mKOU
 48LMKiwWHGMHeDQzgRjFNRGf6bRvsDZrGSYWfqvk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDvPmA020754
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Mar 2025 08:57:25 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 08:57:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 08:57:25 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.181] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EDvOIo128918;
 Fri, 14 Mar 2025 08:57:25 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
Subject: [RFC PATCH v2 2/5] doc: cmd: add documentation for fuse command
Date: Fri, 14 Mar 2025 19:27:03 +0530
Message-ID: <20250314135706.184807-3-h-vm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314135706.184807-1-h-vm@ti.com>
References: <20250314135706.184807-1-h-vm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Add documentation for the 'fuse' sub-system commands.

Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
---
 doc/usage/cmd/fuse.rst | 156 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 doc/usage/cmd/fuse.rst

diff --git a/doc/usage/cmd/fuse.rst b/doc/usage/cmd/fuse.rst
new file mode 100644
index 00000000000..6e330eddfea
--- /dev/null
+++ b/doc/usage/cmd/fuse.rst
@@ -0,0 +1,156 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: fuse (command)
+
+fuse command
+============
+
+Synopsis
+--------
+
+::
+
+    fuse read <bank> <word> [<cnt>]
+    fuse cmp <bank> <word> <hexval>
+    fuse readm <bank> <word> <addr> [<cnt>]
+    fuse sense <bank> <word> [<cnt>]
+    fuse prog [-y] <bank> <word> <hexval> [<hexval>...]
+    fuse override <bank> <word> <hexval> [<hexval>...]
+
+Description
+-----------
+
+The fuse API allows to control a fusebox and how it is used by the upper
+hardware layers.
+
+A fuse corresponds to a single non-volatile memory bit that can be programmed
+(i.e., blown, set to 1) only once. The programming operation is irreversible.
+A fuse that has not been programmed reads as 0.
+
+Fuses can be used by SoCs to store various permanent configurations and data,
+such as boot configurations, security settings, MAC addresses, etc.
+
+A fuse 'word' is the smallest group of fuses that can be read at once from
+the fusebox control IP registers. In the current API, this is limited to 32 bits.
+
+A fuse 'bank' is the smallest group of fuse words having a common ID, as
+defined by each SoC.
+
+Upon startup, the fusebox control IP reads the fuse values and stores them in a
+volatile shadow cache.
+
+Commands
+--------
+
+- **fuse read <bank> <word> [<cnt>]**
+  Reads 1 or 'cnt' fuse words, starting at 'word' from the shadow cache.
+
+- **fuse cmp <bank> <word> <hexval>**
+  Compares 'hexval' to fuse at 'word'.
+
+- **fuse readm <bank> <word> <addr> [<cnt>]**
+  Reads 1 or 'cnt' fuse words, starting at 'word' into memory at 'addr'.
+
+- **fuse sense <bank> <word> [<cnt>]**
+  Sense 1 or 'cnt' fuse words, starting at 'word'.
+  Sense - i.e. read directly from the fusebox, skipping the shadow cache -
+  fuse words. This operation does not update the shadow cache. This is
+  useful to know the true value of fuses if an override has been
+  performed (see below).
+
+- **fuse prog [-y] <bank> <word> <hexval> [<hexval>...]**
+  Permanently programs 1 or several fuse words, starting at 'word'.
+  This operation directly affects the fusebox and is irreversible. The
+  shadow cache is updated accordingly or not, depending on each IP.
+  Only the bits to be programmed should be set in the input value (i.e.
+  for fuse bits that have already been programmed and hence should be
+  left unchanged by a further programming, it is preferable to clear
+  the corresponding bits in the input value in order not to perform a
+  new hardware programming operation on these fuse bits).
+
+- **fuse override <bank> <word> <hexval> [<hexval>...]**
+  Override 1 or several fuse words, starting at 'word' in the shadow cache.
+  The fusebox is unaffected, so following this operation, the shadow cache
+  may differ from the fusebox values. Read or sense operations can then be
+  used to get the values from the shadow cache or from the fusebox.
+  This is useful to change the behaviours linked to some cached fuse values,
+  either because this is needed only temporarily, or because some of the
+  fuses have already been programmed or are locked (if the SoC allows to
+  override a locked fuse).
+
+Examples
+--------
+
+fuse read
+~~~~~~~~~
+
+::
+
+    u-boot=> fuse read 0 1
+      Reading bank 0:
+
+      Word 0x00000001: 00000001
+
+fuse cmp
+~~~~~~~~
+
+::
+
+    u-boot=> fuse cmp 0 1 0x1
+      Comparing bank 0:
+
+      Word 0x00000001:
+      Value 0x00000001:0x00000001
+      passed
+
+fuse readm
+~~~~~~~~~~
+
+::
+
+    u-boot=> fuse readm 0 1 0x83000000
+      Reading bank 0 len 1 to 0x83000000
+
+fuse sense
+~~~~~~~~~~
+
+::
+
+    u-boot=> fuse sense 0 1
+      Sensing bank 0:
+
+      Word 0x00000001: 00000001
+
+fuse prog
+~~~~~~~~~
+
+::
+
+    u-boot=> fuse prog 0 1 0x00000002
+      Programming bank 0 word 0x00000001 to 0x00000002...
+      Warning: Programming fuses is an irreversible operation!
+               This may brick your system.
+               Use this command only if you are sure of what you are doing!
+
+      Really perform this fuse programming? <y/N>
+      y
+
+fuse override
+~~~~~~~~~~~~~
+
+::
+
+    u-boot=> fuse override 0 1 0x00000003
+      Overriding bank 0 word 0x00000001 with 0x00000003...
+
+Configuration
+-------------
+
+The fuse commands are available if CONFIG_CMD_FUSE=y.
+
+Return code
+-----------
+
+The return value $? is set to 0 (true) if the command is successful,
+1 (false) otherwise.
-- 
2.34.1

