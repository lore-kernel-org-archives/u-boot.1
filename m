Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4242CC4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 13:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6639787852;
	Sun, 14 Jan 2024 14:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MqM4kVJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83BB98785A; Sun, 14 Jan 2024 14:53:25 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8971C87849
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 14:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BBB31416D2; 
 Sun, 14 Jan 2024 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705240401;
 bh=GNQSW27jkJU4fYW8LKp3sk1ZIyY0CFbGuQx5Vy3cfqk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=MqM4kVJMhqbL1d+NgebfX/9O7C72TGOGwmAesjjEdDktJP8xs5ETBD5+mdegR1C0p
 DGVkvQHKPO2H4ccaVCB3ZgrG1zYQX7iFZhUjOZBUdabiqRMSjdjUSRePDPQAldmTYi
 YGu3wAKStQQaJcH9iGM8CJzrAuuMIviZM9i06Hb7rmQVu0fq3SJOvXX8Su5V4BNTv7
 tt+HCCgWllkl1FgMHMIe7YB44JLrulc/AVYR6bodm1v0KbTZBxSwIRGDCakglhNybe
 astfn/rLGD9Wj2ONrjo6vpFhX1LeWbCAslNPsYjk8LSw/kXRwK5bv1USWovs+H1YxI
 h9xE0GZmsKjxw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: create index entries for commands
Date: Sun, 14 Jan 2024 14:53:13 +0100
Message-ID: <20240114135315.71371-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add the description of CLI commands to the generated index.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/acpi.rst        | 3 +++
 doc/usage/cmd/addrmap.rst     | 3 +++
 doc/usage/cmd/armffa.rst      | 3 +++
 doc/usage/cmd/askenv.rst      | 3 +++
 doc/usage/cmd/base.rst        | 3 +++
 doc/usage/cmd/bdinfo.rst      | 3 +++
 doc/usage/cmd/bind.rst        | 3 +++
 doc/usage/cmd/blkcache.rst    | 3 +++
 doc/usage/cmd/bootd.rst       | 3 +++
 doc/usage/cmd/bootdev.rst     | 3 +++
 doc/usage/cmd/bootefi.rst     | 3 +++
 doc/usage/cmd/bootflow.rst    | 3 +++
 doc/usage/cmd/booti.rst       | 3 +++
 doc/usage/cmd/bootm.rst       | 3 +++
 doc/usage/cmd/bootmenu.rst    | 3 +++
 doc/usage/cmd/bootmeth.rst    | 3 +++
 doc/usage/cmd/bootz.rst       | 3 +++
 doc/usage/cmd/button.rst      | 3 +++
 doc/usage/cmd/cat.rst         | 3 +++
 doc/usage/cmd/cedit.rst       | 3 +++
 doc/usage/cmd/cli.rst         | 3 +++
 doc/usage/cmd/cls.rst         | 3 +++
 doc/usage/cmd/cmp.rst         | 3 +++
 doc/usage/cmd/coninfo.rst     | 3 +++
 doc/usage/cmd/conitrace.rst   | 3 +++
 doc/usage/cmd/cp.rst          | 3 +++
 doc/usage/cmd/cyclic.rst      | 3 +++
 doc/usage/cmd/dm.rst          | 3 +++
 doc/usage/cmd/ebtupdate.rst   | 3 +++
 doc/usage/cmd/echo.rst        | 3 +++
 doc/usage/cmd/efi.rst         | 3 +++
 doc/usage/cmd/eficonfig.rst   | 3 +++
 doc/usage/cmd/env.rst         | 3 +++
 doc/usage/cmd/event.rst       | 3 +++
 doc/usage/cmd/exception.rst   | 3 +++
 doc/usage/cmd/exit.rst        | 3 +++
 doc/usage/cmd/extension.rst   | 3 +++
 doc/usage/cmd/false.rst       | 3 +++
 doc/usage/cmd/fatinfo.rst     | 3 +++
 doc/usage/cmd/fatload.rst     | 3 +++
 doc/usage/cmd/fdt.rst         | 3 +++
 doc/usage/cmd/font.rst        | 3 +++
 doc/usage/cmd/for.rst         | 3 +++
 doc/usage/cmd/fwu_mdata.rst   | 3 +++
 doc/usage/cmd/gpio.rst        | 3 +++
 doc/usage/cmd/gpt.rst         | 3 +++
 doc/usage/cmd/history.rst     | 3 +++
 doc/usage/cmd/host.rst        | 3 +++
 doc/usage/cmd/imxtract.rst    | 3 +++
 doc/usage/cmd/load.rst        | 3 +++
 doc/usage/cmd/loadb.rst       | 3 +++
 doc/usage/cmd/loadm.rst       | 3 +++
 doc/usage/cmd/loads.rst       | 3 +++
 doc/usage/cmd/loadx.rst       | 3 +++
 doc/usage/cmd/loady.rst       | 3 +++
 doc/usage/cmd/mbr.rst         | 3 +++
 doc/usage/cmd/md.rst          | 3 +++
 doc/usage/cmd/mmc.rst         | 3 +++
 doc/usage/cmd/mtest.rst       | 3 +++
 doc/usage/cmd/mtrr.rst        | 3 +++
 doc/usage/cmd/panic.rst       | 3 +++
 doc/usage/cmd/part.rst        | 3 +++
 doc/usage/cmd/pause.rst       | 3 +++
 doc/usage/cmd/pinmux.rst      | 3 +++
 doc/usage/cmd/printenv.rst    | 3 +++
 doc/usage/cmd/pstore.rst      | 3 +++
 doc/usage/cmd/qfw.rst         | 3 +++
 doc/usage/cmd/reset.rst       | 3 +++
 doc/usage/cmd/rng.rst         | 3 +++
 doc/usage/cmd/saves.rst       | 3 +++
 doc/usage/cmd/sbi.rst         | 3 +++
 doc/usage/cmd/scmi.rst        | 3 +++
 doc/usage/cmd/scp03.rst       | 3 +++
 doc/usage/cmd/seama.rst       | 3 +++
 doc/usage/cmd/setexpr.rst     | 3 +++
 doc/usage/cmd/sf.rst          | 3 +++
 doc/usage/cmd/size.rst        | 3 +++
 doc/usage/cmd/sleep.rst       | 3 +++
 doc/usage/cmd/sm.rst          | 3 +++
 doc/usage/cmd/sound.rst       | 3 +++
 doc/usage/cmd/source.rst      | 3 +++
 doc/usage/cmd/temperature.rst | 3 +++
 doc/usage/cmd/tftpput.rst     | 3 +++
 doc/usage/cmd/trace.rst       | 3 +++
 doc/usage/cmd/true.rst        | 3 +++
 doc/usage/cmd/ums.rst         | 3 +++
 doc/usage/cmd/unbind.rst      | 3 +++
 doc/usage/cmd/ut.rst          | 3 +++
 doc/usage/cmd/wdt.rst         | 3 +++
 doc/usage/cmd/wget.rst        | 3 +++
 doc/usage/cmd/write.rst       | 3 +++
 doc/usage/cmd/xxd.rst         | 3 +++
 92 files changed, 276 insertions(+)

diff --git a/doc/usage/cmd/acpi.rst b/doc/usage/cmd/acpi.rst
index 6b9b8949f3..a630f1ec5e 100644
--- a/doc/usage/cmd/acpi.rst
+++ b/doc/usage/cmd/acpi.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: acpi (command)
+
 acpi command
 ============
 
diff --git a/doc/usage/cmd/addrmap.rst b/doc/usage/cmd/addrmap.rst
index 472fd547f3..6d0dbceefe 100644
--- a/doc/usage/cmd/addrmap.rst
+++ b/doc/usage/cmd/addrmap.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: addrmap (command)
+
 addrmap command
 ===============
 
diff --git a/doc/usage/cmd/armffa.rst b/doc/usage/cmd/armffa.rst
index 13fa90c129..4f41e3393f 100644
--- a/doc/usage/cmd/armffa.rst
+++ b/doc/usage/cmd/armffa.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
 
+.. index::
+   single: armffa (command)
+
 armffa command
 ==============
 
diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
index b85ceface1..e2b3c5379a 100644
--- a/doc/usage/cmd/askenv.rst
+++ b/doc/usage/cmd/askenv.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: askenv (command)
+
 askenv command
 ==============
 
diff --git a/doc/usage/cmd/base.rst b/doc/usage/cmd/base.rst
index db9cd4d978..0d030a1d1e 100644
--- a/doc/usage/cmd/base.rst
+++ b/doc/usage/cmd/base.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: base (command)
+
 base command
 ============
 
diff --git a/doc/usage/cmd/bdinfo.rst b/doc/usage/cmd/bdinfo.rst
index 5261085a06..a21fbc83cc 100644
--- a/doc/usage/cmd/bdinfo.rst
+++ b/doc/usage/cmd/bdinfo.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
 
+.. index::
+   single: bdinfo (command)
+
 bdinfo command
 ==============
 
diff --git a/doc/usage/cmd/bind.rst b/doc/usage/cmd/bind.rst
index 1a5cffcb72..2345778366 100644
--- a/doc/usage/cmd/bind.rst
+++ b/doc/usage/cmd/bind.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: bind (command)
+
 bind command
 ============
 
diff --git a/doc/usage/cmd/blkcache.rst b/doc/usage/cmd/blkcache.rst
index d3b2254cfa..0329261ba9 100644
--- a/doc/usage/cmd/blkcache.rst
+++ b/doc/usage/cmd/blkcache.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
 
+.. index::
+   single: blkcache (command)
+
 blkcache command
 ================
 
diff --git a/doc/usage/cmd/bootd.rst b/doc/usage/cmd/bootd.rst
index 380ef15283..619cfb601a 100644
--- a/doc/usage/cmd/bootd.rst
+++ b/doc/usage/cmd/bootd.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: bootd (command)
+
 bootd command
 =============
 
diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
index fb638b5807..658020e7c7 100644
--- a/doc/usage/cmd/bootdev.rst
+++ b/doc/usage/cmd/bootdev.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: bootdev (command)
+
 bootdev command
 ===============
 
diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index cb03df4e1c..3efe9e9df5 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
+.. index::
+   single: bootefi (command)
+
 bootefi command
 ===============
 
diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
index 27e1330ad8..16ba986dc8 100644
--- a/doc/usage/cmd/bootflow.rst
+++ b/doc/usage/cmd/bootflow.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: bootflow (command)
+
 bootflow command
 ================
 
diff --git a/doc/usage/cmd/booti.rst b/doc/usage/cmd/booti.rst
index d631fb571d..313efb83cc 100644
--- a/doc/usage/cmd/booti.rst
+++ b/doc/usage/cmd/booti.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: booti (command)
+
 booti command
 =============
 
diff --git a/doc/usage/cmd/bootm.rst b/doc/usage/cmd/bootm.rst
index a7e5f6ce69..e409ebc193 100644
--- a/doc/usage/cmd/bootm.rst
+++ b/doc/usage/cmd/bootm.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: bootm (command)
+
 bootm command
 =============
 
diff --git a/doc/usage/cmd/bootmenu.rst b/doc/usage/cmd/bootmenu.rst
index 684a18d8e1..294cc02b17 100644
--- a/doc/usage/cmd/bootmenu.rst
+++ b/doc/usage/cmd/bootmenu.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. (C) Copyright 2011-2012 Pali Rohár <pali@kernel.org>
 
+.. index::
+   single: bootmenu (command)
+
 bootmenu command
 ================
 
diff --git a/doc/usage/cmd/bootmeth.rst b/doc/usage/cmd/bootmeth.rst
index f632d74e1d..95651fdc7c 100644
--- a/doc/usage/cmd/bootmeth.rst
+++ b/doc/usage/cmd/bootmeth.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: bootmeth (command)
+
 bootmeth command
 ================
 
diff --git a/doc/usage/cmd/bootz.rst b/doc/usage/cmd/bootz.rst
index 78953e9ca2..b85875adde 100644
--- a/doc/usage/cmd/bootz.rst
+++ b/doc/usage/cmd/bootz.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: bootz (command)
+
 bootz command
 =============
 
diff --git a/doc/usage/cmd/button.rst b/doc/usage/cmd/button.rst
index ea41762757..6c6794f31b 100644
--- a/doc/usage/cmd/button.rst
+++ b/doc/usage/cmd/button.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: button (command)
+
 button command
 ==============
 
diff --git a/doc/usage/cmd/cat.rst b/doc/usage/cmd/cat.rst
index 5aaf497f27..b22dc6184a 100644
--- a/doc/usage/cmd/cat.rst
+++ b/doc/usage/cmd/cat.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: cat (command)
+
 cat command
 ===========
 
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index f415b48699..b39d708281 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: cedit (command)
+
 cedit command
 =============
 
diff --git a/doc/usage/cmd/cli.rst b/doc/usage/cmd/cli.rst
index a0cf5958fb..81487722f6 100644
--- a/doc/usage/cmd/cli.rst
+++ b/doc/usage/cmd/cli.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: cli (command)
+
 cli command
 ===========
 
diff --git a/doc/usage/cmd/cls.rst b/doc/usage/cmd/cls.rst
index b5c43e0a2e..828276742b 100644
--- a/doc/usage/cmd/cls.rst
+++ b/doc/usage/cmd/cls.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: cls (command)
+
 cls command
 ===========
 
diff --git a/doc/usage/cmd/cmp.rst b/doc/usage/cmd/cmp.rst
index 8d196ee578..5242dc3afc 100644
--- a/doc/usage/cmd/cmp.rst
+++ b/doc/usage/cmd/cmp.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: cmp (command)
+
 cmp command
 ===========
 
diff --git a/doc/usage/cmd/coninfo.rst b/doc/usage/cmd/coninfo.rst
index 76cb6c3329..a66cf90a27 100644
--- a/doc/usage/cmd/coninfo.rst
+++ b/doc/usage/cmd/coninfo.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: coninfo (command)
+
 coninfo command
 ===============
 
diff --git a/doc/usage/cmd/conitrace.rst b/doc/usage/cmd/conitrace.rst
index d9916c865e..38ec66ad52 100644
--- a/doc/usage/cmd/conitrace.rst
+++ b/doc/usage/cmd/conitrace.rst
@@ -1,3 +1,6 @@
+.. index::
+   single: conitrace (command)
+
 conitrace command
 =================
 
diff --git a/doc/usage/cmd/cp.rst b/doc/usage/cmd/cp.rst
index 12a24e19fe..518d4ed7a6 100644
--- a/doc/usage/cmd/cp.rst
+++ b/doc/usage/cmd/cp.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: cp (command)
+
 cp command
 ==========
 
diff --git a/doc/usage/cmd/cyclic.rst b/doc/usage/cmd/cyclic.rst
index 3085cc7204..ac1e4c663b 100644
--- a/doc/usage/cmd/cyclic.rst
+++ b/doc/usage/cmd/cyclic.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: cyclic (command)
+
 cyclic command
 ==============
 
diff --git a/doc/usage/cmd/dm.rst b/doc/usage/cmd/dm.rst
index 12b7edeed6..9bef2eeaed 100644
--- a/doc/usage/cmd/dm.rst
+++ b/doc/usage/cmd/dm.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: dm (command)
+
 dm command
 ==========
 
diff --git a/doc/usage/cmd/ebtupdate.rst b/doc/usage/cmd/ebtupdate.rst
index d90474ccec..22415ee07b 100644
--- a/doc/usage/cmd/ebtupdate.rst
+++ b/doc/usage/cmd/ebtupdate.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: ebtupdate (command)
+
 ebtupdate command
 =================
 
diff --git a/doc/usage/cmd/echo.rst b/doc/usage/cmd/echo.rst
index 861abdfd1e..ebc9ff5f84 100644
--- a/doc/usage/cmd/echo.rst
+++ b/doc/usage/cmd/echo.rst
@@ -1,3 +1,6 @@
+.. index::
+   single: echo (command)
+
 echo command
 ============
 
diff --git a/doc/usage/cmd/efi.rst b/doc/usage/cmd/efi.rst
index ef37ff2f4c..b19d36188a 100644
--- a/doc/usage/cmd/efi.rst
+++ b/doc/usage/cmd/efi.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
+.. index::
+   single: efi (command)
+
 efi command
 ===========
 
diff --git a/doc/usage/cmd/eficonfig.rst b/doc/usage/cmd/eficonfig.rst
index 30eb72bfd0..83a3ebf4f0 100644
--- a/doc/usage/cmd/eficonfig.rst
+++ b/doc/usage/cmd/eficonfig.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. (C) Copyright 2022, Masahisa Kojima <masahisa.kojima@linaro.org>
 
+.. index::
+   single: eficonfig (command)
+
 eficonfig command
 =================
 
diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
index 1bebfa4e71..a859e32798 100644
--- a/doc/usage/cmd/env.rst
+++ b/doc/usage/cmd/env.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later:
 
+.. index::
+   single: env (command)
+
 env command
 ===========
 
diff --git a/doc/usage/cmd/event.rst b/doc/usage/cmd/event.rst
index 47c900d17e..5c5e304373 100644
--- a/doc/usage/cmd/event.rst
+++ b/doc/usage/cmd/event.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: event (command)
+
 event command
 =============
 
diff --git a/doc/usage/cmd/exception.rst b/doc/usage/cmd/exception.rst
index 27df88bd5c..9cb492d604 100644
--- a/doc/usage/cmd/exception.rst
+++ b/doc/usage/cmd/exception.rst
@@ -1,3 +1,6 @@
+.. index::
+   single: exception (command)
+
 exception command
 =================
 
diff --git a/doc/usage/cmd/exit.rst b/doc/usage/cmd/exit.rst
index 3edb12809c..2f250bf4bd 100644
--- a/doc/usage/cmd/exit.rst
+++ b/doc/usage/cmd/exit.rst
@@ -1,3 +1,6 @@
+.. index::
+   single: exit (command)
+
 exit command
 ============
 
diff --git a/doc/usage/cmd/extension.rst b/doc/usage/cmd/extension.rst
index 6366cf56e7..4c261e7495 100644
--- a/doc/usage/cmd/extension.rst
+++ b/doc/usage/cmd/extension.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2021, Kory Maincent <kory.maincent@bootlin.com>
 
+.. index::
+   single: extension (command)
+
 extension command
 =================
 
diff --git a/doc/usage/cmd/false.rst b/doc/usage/cmd/false.rst
index a17fe86021..510377e22c 100644
--- a/doc/usage/cmd/false.rst
+++ b/doc/usage/cmd/false.rst
@@ -1,3 +1,6 @@
+.. index::
+   single: false (command)
+
 false command
 =============
 
diff --git a/doc/usage/cmd/fatinfo.rst b/doc/usage/cmd/fatinfo.rst
index af2eba4344..2e05ab8bec 100644
--- a/doc/usage/cmd/fatinfo.rst
+++ b/doc/usage/cmd/fatinfo.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: fatinfo (command)
+
 fatinfo command
 ===============
 
diff --git a/doc/usage/cmd/fatload.rst b/doc/usage/cmd/fatload.rst
index 93acb27a53..6c048b7bda 100644
--- a/doc/usage/cmd/fatload.rst
+++ b/doc/usage/cmd/fatload.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: fatload (command)
+
 fatload command
 ===============
 
diff --git a/doc/usage/cmd/fdt.rst b/doc/usage/cmd/fdt.rst
index 36b8230877..3e8c32cdea 100644
--- a/doc/usage/cmd/fdt.rst
+++ b/doc/usage/cmd/fdt.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: fdt (command)
+
 fdt command
 ===========
 
diff --git a/doc/usage/cmd/font.rst b/doc/usage/cmd/font.rst
index 8ba149d759..adcd5126d0 100644
--- a/doc/usage/cmd/font.rst
+++ b/doc/usage/cmd/font.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: font (command)
+
 font command
 ============
 
diff --git a/doc/usage/cmd/for.rst b/doc/usage/cmd/for.rst
index f9e504979c..4c98419b28 100644
--- a/doc/usage/cmd/for.rst
+++ b/doc/usage/cmd/for.rst
@@ -1,3 +1,6 @@
+.. index::
+   single: for (command)
+
 for command
 ===========
 
diff --git a/doc/usage/cmd/fwu_mdata.rst b/doc/usage/cmd/fwu_mdata.rst
index ea3c22724a..f1bf08fde1 100644
--- a/doc/usage/cmd/fwu_mdata.rst
+++ b/doc/usage/cmd/fwu_mdata.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: fwu_mdata_read (command)
+
 fwu_mdata_read command
 ======================
 
diff --git a/doc/usage/cmd/gpio.rst b/doc/usage/cmd/gpio.rst
index ee902138f1..4b0dc2716e 100644
--- a/doc/usage/cmd/gpio.rst
+++ b/doc/usage/cmd/gpio.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: gpio (command)
+
 gpio command
 ============
 
diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index cbbe44ab58..8534f78cba 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: gpt (command)
+
 gpt command
 ===========
 
diff --git a/doc/usage/cmd/history.rst b/doc/usage/cmd/history.rst
index 33d3fcd624..564a159665 100644
--- a/doc/usage/cmd/history.rst
+++ b/doc/usage/cmd/history.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: history (command)
+
 history command
 ===============
 
diff --git a/doc/usage/cmd/host.rst b/doc/usage/cmd/host.rst
index e14508986c..072497db90 100644
--- a/doc/usage/cmd/host.rst
+++ b/doc/usage/cmd/host.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: host (command)
+
 host command
 ============
 
diff --git a/doc/usage/cmd/imxtract.rst b/doc/usage/cmd/imxtract.rst
index 16be60b4aa..235d15e445 100644
--- a/doc/usage/cmd/imxtract.rst
+++ b/doc/usage/cmd/imxtract.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: imxtract (command)
+
 imxtract command
 ================
 
diff --git a/doc/usage/cmd/load.rst b/doc/usage/cmd/load.rst
index 2c892ee1cb..bfa45c6f36 100644
--- a/doc/usage/cmd/load.rst
+++ b/doc/usage/cmd/load.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: load (command)
+
 load command
 ============
 
diff --git a/doc/usage/cmd/loadb.rst b/doc/usage/cmd/loadb.rst
index 0464b1f41c..4f9a52c793 100644
--- a/doc/usage/cmd/loadb.rst
+++ b/doc/usage/cmd/loadb.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: loadb (command)
+
 loadb command
 =============
 
diff --git a/doc/usage/cmd/loadm.rst b/doc/usage/cmd/loadm.rst
index b657114043..005840a27b 100644
--- a/doc/usage/cmd/loadm.rst
+++ b/doc/usage/cmd/loadm.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: loadm (command)
+
 loadm command
 =============
 
diff --git a/doc/usage/cmd/loads.rst b/doc/usage/cmd/loads.rst
index e4cb063df6..0a2ac14acf 100644
--- a/doc/usage/cmd/loads.rst
+++ b/doc/usage/cmd/loads.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: loads (command)
+
 loads command
 =============
 
diff --git a/doc/usage/cmd/loadx.rst b/doc/usage/cmd/loadx.rst
index facca9b969..661b36723c 100644
--- a/doc/usage/cmd/loadx.rst
+++ b/doc/usage/cmd/loadx.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: loadx (command)
+
 loadx command
 =============
 
diff --git a/doc/usage/cmd/loady.rst b/doc/usage/cmd/loady.rst
index 3f8227ecf2..8367759471 100644
--- a/doc/usage/cmd/loady.rst
+++ b/doc/usage/cmd/loady.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: loady (command)
+
 loady command
 =============
 
diff --git a/doc/usage/cmd/mbr.rst b/doc/usage/cmd/mbr.rst
index bddf2f612a..925a118105 100644
--- a/doc/usage/cmd/mbr.rst
+++ b/doc/usage/cmd/mbr.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: mbr (command)
+
 mbr command
 ===========
 
diff --git a/doc/usage/cmd/md.rst b/doc/usage/cmd/md.rst
index 7e9944e0dc..9ea148a8dc 100644
--- a/doc/usage/cmd/md.rst
+++ b/doc/usage/cmd/md.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: md (command)
+
 md command
 ==========
 
diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
index 8394f647e8..5a64400eea 100644
--- a/doc/usage/cmd/mmc.rst
+++ b/doc/usage/cmd/mmc.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: mmc (command)
+
 mmc command
 ===========
 
diff --git a/doc/usage/cmd/mtest.rst b/doc/usage/cmd/mtest.rst
index 81d1f8fd1b..e01f2a6d57 100644
--- a/doc/usage/cmd/mtest.rst
+++ b/doc/usage/cmd/mtest.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
+.. index::
+   single: mtest (command)
+
 mtest command
 =============
 
diff --git a/doc/usage/cmd/mtrr.rst b/doc/usage/cmd/mtrr.rst
index 531153bb3e..c65618950b 100644
--- a/doc/usage/cmd/mtrr.rst
+++ b/doc/usage/cmd/mtrr.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: mtrr (command)
+
 mtrr command
 ============
 
diff --git a/doc/usage/cmd/panic.rst b/doc/usage/cmd/panic.rst
index 115eba5bde..ba5ea62610 100644
--- a/doc/usage/cmd/panic.rst
+++ b/doc/usage/cmd/panic.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: panic (command)
+
 panic command
 =============
 
diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index eee5225cad..58be38781e 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: part (command)
+
 part command
 ============
 
diff --git a/doc/usage/cmd/pause.rst b/doc/usage/cmd/pause.rst
index c79e399c02..6cdd83d316 100644
--- a/doc/usage/cmd/pause.rst
+++ b/doc/usage/cmd/pause.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later:
 
+.. index::
+   single: pause (command)
+
 pause command
 =============
 
diff --git a/doc/usage/cmd/pinmux.rst b/doc/usage/cmd/pinmux.rst
index 9f4392cd0d..30c5eb16a6 100644
--- a/doc/usage/cmd/pinmux.rst
+++ b/doc/usage/cmd/pinmux.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: pinmux (command)
+
 pinmux command
 ==============
 
diff --git a/doc/usage/cmd/printenv.rst b/doc/usage/cmd/printenv.rst
index d4184fd65e..dfdb362493 100644
--- a/doc/usage/cmd/printenv.rst
+++ b/doc/usage/cmd/printenv.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: printenv (command)
+
 printenv command
 ================
 
diff --git a/doc/usage/cmd/pstore.rst b/doc/usage/cmd/pstore.rst
index 1c8374513a..63a437135e 100644
--- a/doc/usage/cmd/pstore.rst
+++ b/doc/usage/cmd/pstore.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: pstore (command)
+
 pstore command
 ==============
 
diff --git a/doc/usage/cmd/qfw.rst b/doc/usage/cmd/qfw.rst
index e734b26671..40770acb3c 100644
--- a/doc/usage/cmd/qfw.rst
+++ b/doc/usage/cmd/qfw.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: qfw (command)
+
 qfw command
 ===========
 
diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 384d5d60f8..126db21cdb 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: reset (command)
+
 reset command
 =============
 
diff --git a/doc/usage/cmd/rng.rst b/doc/usage/cmd/rng.rst
index 1a352da41a..274e4d88df 100644
--- a/doc/usage/cmd/rng.rst
+++ b/doc/usage/cmd/rng.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: rng (command)
+
 rng command
 ===========
 
diff --git a/doc/usage/cmd/saves.rst b/doc/usage/cmd/saves.rst
index 5823f88379..b380a4feb6 100644
--- a/doc/usage/cmd/saves.rst
+++ b/doc/usage/cmd/saves.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: saves (command)
+
 saves command
 =============
 
diff --git a/doc/usage/cmd/sbi.rst b/doc/usage/cmd/sbi.rst
index 713e0b9c81..5492925a8b 100644
--- a/doc/usage/cmd/sbi.rst
+++ b/doc/usage/cmd/sbi.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: sbi (command)
+
 sbi command
 ===========
 
diff --git a/doc/usage/cmd/scmi.rst b/doc/usage/cmd/scmi.rst
index 9ea7e0e41d..9591cdc07a 100644
--- a/doc/usage/cmd/scmi.rst
+++ b/doc/usage/cmd/scmi.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: scmi (command)
+
 scmi command
 ============
 
diff --git a/doc/usage/cmd/scp03.rst b/doc/usage/cmd/scp03.rst
index 7ff87ed85a..5fdddb3e81 100644
--- a/doc/usage/cmd/scp03.rst
+++ b/doc/usage/cmd/scp03.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: scp03 (command)
+
 scp03 command
 =============
 
diff --git a/doc/usage/cmd/seama.rst b/doc/usage/cmd/seama.rst
index 356c00a723..17fd559f48 100644
--- a/doc/usage/cmd/seama.rst
+++ b/doc/usage/cmd/seama.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: seama (command)
+
 seama command
 =============
 
diff --git a/doc/usage/cmd/setexpr.rst b/doc/usage/cmd/setexpr.rst
index 4d19fa340d..d245a13ca8 100644
--- a/doc/usage/cmd/setexpr.rst
+++ b/doc/usage/cmd/setexpr.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: setexpr (command)
+
 setexpr command
 ===============
 
diff --git a/doc/usage/cmd/sf.rst b/doc/usage/cmd/sf.rst
index 71bd1be517..24d5dc692d 100644
--- a/doc/usage/cmd/sf.rst
+++ b/doc/usage/cmd/sf.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: sf (command)
+
 sf command
 ==========
 
diff --git a/doc/usage/cmd/size.rst b/doc/usage/cmd/size.rst
index f0c35e4826..306fcba0ba 100644
--- a/doc/usage/cmd/size.rst
+++ b/doc/usage/cmd/size.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: size (command)
+
 size command
 ============
 
diff --git a/doc/usage/cmd/sleep.rst b/doc/usage/cmd/sleep.rst
index d19e5b3af8..a372e4da0e 100644
--- a/doc/usage/cmd/sleep.rst
+++ b/doc/usage/cmd/sleep.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
 
+.. index::
+   single: sleep (command)
+
 sleep command
 =============
 
diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
index f6524a1c2e..b767647d77 100644
--- a/doc/usage/cmd/sm.rst
+++ b/doc/usage/cmd/sm.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: sm (command)
+
 sm command
 ==========
 
diff --git a/doc/usage/cmd/sound.rst b/doc/usage/cmd/sound.rst
index 2cfe9b7ad1..97d610f374 100644
--- a/doc/usage/cmd/sound.rst
+++ b/doc/usage/cmd/sound.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
+.. index::
+   single: sound (command)
+
 sound command
 =============
 
diff --git a/doc/usage/cmd/source.rst b/doc/usage/cmd/source.rst
index 697f644745..0de5f33390 100644
--- a/doc/usage/cmd/source.rst
+++ b/doc/usage/cmd/source.rst
@@ -1,6 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
+.. index::
+   single: source (command)
+
 source command
 ==============
 
diff --git a/doc/usage/cmd/temperature.rst b/doc/usage/cmd/temperature.rst
index a5144ec50f..945bc8204a 100644
--- a/doc/usage/cmd/temperature.rst
+++ b/doc/usage/cmd/temperature.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
+.. index::
+   single: temperature (command)
+
 temperature command
 ===================
 
diff --git a/doc/usage/cmd/tftpput.rst b/doc/usage/cmd/tftpput.rst
index 52ba7b179a..351c9faa38 100644
--- a/doc/usage/cmd/tftpput.rst
+++ b/doc/usage/cmd/tftpput.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: tftpput (command)
+
 tftpput command
 ===============
 
diff --git a/doc/usage/cmd/trace.rst b/doc/usage/cmd/trace.rst
index 3bdf4f0a86..ad6db12394 100644
--- a/doc/usage/cmd/trace.rst
+++ b/doc/usage/cmd/trace.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: trace (command)
+
 trace command
 =============
 
diff --git a/doc/usage/cmd/true.rst b/doc/usage/cmd/true.rst
index f9ef71b2d1..adf641386b 100644
--- a/doc/usage/cmd/true.rst
+++ b/doc/usage/cmd/true.rst
@@ -1,3 +1,6 @@
+.. index::
+   single: true (command)
+
 true command
 ============
 
diff --git a/doc/usage/cmd/ums.rst b/doc/usage/cmd/ums.rst
index 3cde5fa1f2..9d379e3c82 100644
--- a/doc/usage/cmd/ums.rst
+++ b/doc/usage/cmd/ums.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. index::
+   single: ums (command)
+
 ums command
 ===========
 
diff --git a/doc/usage/cmd/unbind.rst b/doc/usage/cmd/unbind.rst
index 594e4f0689..0309e90f6e 100644
--- a/doc/usage/cmd/unbind.rst
+++ b/doc/usage/cmd/unbind.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: unbind (command)
+
 unbind command
 ==============
 
diff --git a/doc/usage/cmd/ut.rst b/doc/usage/cmd/ut.rst
index a3039634f2..ddc48ec42d 100644
--- a/doc/usage/cmd/ut.rst
+++ b/doc/usage/cmd/ut.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: ut (command)
+
 ut command
 ==========
 
diff --git a/doc/usage/cmd/wdt.rst b/doc/usage/cmd/wdt.rst
index 8bb8b36178..f48b884090 100644
--- a/doc/usage/cmd/wdt.rst
+++ b/doc/usage/cmd/wdt.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: wdt (command)
+
 wdt command
 ===========
 
diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index 8e7383b6c6..b8ca35bb14 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: wget (command)
+
 wget command
 ============
 
diff --git a/doc/usage/cmd/write.rst b/doc/usage/cmd/write.rst
index c16870d6dc..f42dc003dd 100644
--- a/doc/usage/cmd/write.rst
+++ b/doc/usage/cmd/write.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later:
 
+.. index::
+   single: write (command)
+
 write command
 =============
 
diff --git a/doc/usage/cmd/xxd.rst b/doc/usage/cmd/xxd.rst
index 13bb4389cc..f010a9dbb4 100644
--- a/doc/usage/cmd/xxd.rst
+++ b/doc/usage/cmd/xxd.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
+.. index::
+   single: xxd (command)
+
 xxd command
 ===========
 
-- 
2.43.0

