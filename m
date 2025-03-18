Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45227C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBEC981951;
	Tue, 18 Mar 2025 11:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pxl+Trwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4CEA81D25; Tue, 18 Mar 2025 11:51:17 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4406B8168B
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52IAp7WX3044640
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Mar 2025 05:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742295067;
 bh=QmGl7DN3XkQjuDRwAuwNy7Yvgpk/GsgzJsJjxTsmPkU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pxl+TrwunuqcwmsYnOBjkX75eZ9Nnj2rlY6sH2fFEItwXcN8yRnQGLm0PMoNotkTZ
 7DxO3KzbkTGeeRPEki+BR/AKJKC5gVbzd3MV32mI150BByLbSjqXa4WiEjpOv8z8/3
 Ls4aDXc8/os7OdSjvOwyomqaNqAvm634v0aTnSpA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52IAp7uA015185;
 Tue, 18 Mar 2025 05:51:07 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Mar 2025 05:51:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Mar 2025 05:51:06 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.181] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52IAp5vB094976;
 Tue, 18 Mar 2025 05:51:06 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
Subject: [RFC PATCH v3 2/5] doc: cmd: Add documentation for fuse command
Date: Tue, 18 Mar 2025 16:20:44 +0530
Message-ID: <20250318105047.256022-3-h-vm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318105047.256022-1-h-vm@ti.com>
References: <20250318105047.256022-1-h-vm@ti.com>
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

Add documentation for the 'fuse' sub-system commands in
doc/usage/cmd/fuse.rst file.
Remove doc/README.fuse file.

Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
---
 doc/README.fuse        |  67 ------------------
 doc/usage/cmd/fuse.rst | 156 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst    |   1 +
 3 files changed, 157 insertions(+), 67 deletions(-)
 delete mode 100644 doc/README.fuse
 create mode 100644 doc/usage/cmd/fuse.rst

diff --git a/doc/README.fuse b/doc/README.fuse
deleted file mode 100644
index 1bc91c44a6a..00000000000
--- a/doc/README.fuse
+++ /dev/null
@@ -1,67 +0,0 @@
-Fuse API functions and commands
-
-The fuse API allows to control a fusebox and how it is used by the upper
-hardware layers.
-
-A fuse corresponds to a single non-volatile memory bit that can be programmed
-(i.e. blown, set to 1) only once. The programming operation is irreversible. A
-fuse that has not been programmed reads 0.
-
-Fuses can be used by SoCs to store various permanent configuration and data,
-e.g. boot configuration, security configuration, MAC addresses, etc.
-
-A fuse word is the smallest group of fuses that can be read at once from the
-fusebox control IP registers. This is limited to 32 bits with the current API.
-
-A fuse bank is the smallest group of fuse words having a common ID, as defined
-by each SoC.
-
-Upon startup, the fusebox control IP reads the fuse values and stores them to a
-volatile shadow cache.
-
-See the README files of the drivers implementing this API in order to know the
-SoC- and implementation-specific details.
-
-Functions / commands:
-
-   int fuse_read(u32 bank, u32 word, u32 *val);
-   fuse read <bank> <word> [<cnt>]
-      Read fuse words from the shadow cache.
-
-   int fuse_sense(u32 bank, u32 word, u32 *val);
-   fuse sense <bank> <word> [<cnt>]
-      Sense - i.e. read directly from the fusebox, skipping the shadow cache -
-      fuse words. This operation does not update the shadow cache.
-
-      This is useful to know the true value of fuses if an override has been
-      performed (see below).
-
-   int fuse_prog(u32 bank, u32 word, u32 val);
-   fuse prog [-y] <bank> <word> <hexval> [<hexval>...]
-      Program fuse words. This operation directly affects the fusebox and is
-      irreversible. The shadow cache is updated accordingly or not, depending on
-      each IP.
-
-      Only the bits to be programmed should be set in the input value (i.e. for
-      fuse bits that have already been programmed and hence should be left
-      unchanged by a further programming, it is preferable to clear the
-      corresponding bits in the input value in order not to perform a new
-      hardware programming operation on these fuse bits).
-
-   int fuse_override(u32 bank, u32 word, u32 val);
-   fuse override <bank> <word> <hexval> [<hexval>...]
-      Override fuse words in the shadow cache.
-
-      The fusebox is unaffected, so following this operation, the shadow cache
-      may differ from the fusebox values. Read or sense operations can then be
-      used to get the values from the shadow cache or from the fusebox.
-
-      This is useful to change the behaviors linked to some cached fuse values,
-      either because this is needed only temporarily, or because some of the
-      fuses have already been programmed or are locked (if the SoC allows to
-      override a locked fuse).
-
-Configuration:
-
-   CONFIG_CMD_FUSE
-      Define this to enable the fuse commands.
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
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index fc058476f39..372ef56c967 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -72,6 +72,7 @@ Shell commands
    cmd/fdt
    cmd/font
    cmd/for
+   cmd/fuse
    cmd/fwu_mdata
    cmd/gpio
    cmd/gpt
-- 
2.34.1

