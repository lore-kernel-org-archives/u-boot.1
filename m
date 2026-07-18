Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC37C44523
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 757C283E76;
	Sun, 19 Jul 2026 03:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Qb76ZsPA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JntS8Glt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3FF284118; Sun, 19 Jul 2026 01:46:44 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7550084105
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 01:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h2k2T5Sg2zKrxq;
 Sun, 19 Jul 2026 01:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784418401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVPU8FBwgglN/mLM0FAHz8rTDfacQIUOCBeDHGfisPY=;
 b=Qb76ZsPAJS36VyTnJKtjONesyZ1xkZFERGaeqSZ7MpMl47W8tqMPzb9Z7m5d61tULkXwhN
 Wd2uJNueB1gstbI2JzLFrgQkj9+RVDnG82NPIqjDzn/07WMKFN0myKd50hnrA7/FvKqd7C
 P4OzfHGHvAD0BtZF5X37gXboCW8oAuVZm3/Dz2MYkrwMIvybFMlAectqfdOI4t4AAspkAr
 I7FieSL4KnngqacDpKou4bq4nBEH/YkCVGihJuLX+B5gFf4ZcD3MTER1XC44qylHxIxqdj
 6auKYnKk289HLB+Zf1tPiLZ+k7vPrULC07zkDFGhMECAwV2mvs0KI0BACNbsJQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=JntS8Glt;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784418399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVPU8FBwgglN/mLM0FAHz8rTDfacQIUOCBeDHGfisPY=;
 b=JntS8GltUYv4nXA6gWPczeUWGM+pTOgfumGu35t8s9swApDPSYZk5SgU923I51AqRFFoPq
 exbjEVak8A815DFnwlEZYaK6JeIOSOVrzYK+zOqwT7xDeReDut2QKeZqVyMkTR7qRi0vCW
 qEFIFujw6BRdTIlPAS3DO+eKAMp/Yhc+L/XDSn1+2lPb/dhhPFgM6ZFydoNnpOciQ/8N/i
 F1oURv/wRHvIdDCW3X5qeWhANJ81Gq4tTUeWy8col6Yvd3cZSOx7AqYg5MjIwCHi5KGbWB
 2/22wSCl9VIpX+JGijT8H9mHcXKadAt+HpvPmrR4gBHAtEV2LRZDJJNvpQYUVQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Daniel Golle <daniel@makrotopia.org>, Dillon Min <dillon.minfei@gmail.com>,
 E Shattow <e@freeshell.de>, Fabio Estevam <festevam@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@ew.tq-group.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] doc: Switch from printenv to env print
Date: Sun, 19 Jul 2026 01:45:49 +0200
Message-ID: <20260718234617.98664-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260718234617.98664-1-marek.vasut+renesas@mailbox.org>
References: <20260718234617.98664-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 69368ff984bc4511b23
X-MBO-RS-META: zfgwdbwshnawy4omu86z38jz8wkmnf7e
X-Rspamd-Queue-Id: 4h2k2T5Sg2zKrxq
X-Mailman-Approved-At: Sun, 19 Jul 2026 03:27:40 +0200
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

The "env" command is the recommended environment management command,
its "print" subcommand is the equivalent replacement for legacy "printenv"
command. Update the documentation to use the contemporary "env print"
command instead of legacy "printenv" command.

Note that the "printenv" command is unlikely to be removed from U-Boot
in the near future due to it being integral part of the command line
ABI.

Implemented using:
$ sed -i 's@\<printenv\>@env print@g' $(git grep -li '\<printenv\>' doc/) README

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Dillon Min <dillon.minfei@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>
Cc: Hal Feng <hal.feng@starfivetech.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Kamil Lulko <kamil.lulko@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Minda Chen <minda.chen@starfivetech.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@ew.tq-group.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 README                    | 8 ++++----
 doc/README.odroid         | 4 ++--
 doc/android/ab.rst        | 2 +-
 doc/usage/cmd/askenv.rst  | 6 +++---
 doc/usage/cmd/memsize.rst | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/README b/README
index 5cbc9c152b5..a17f121a12e 100644
--- a/README
+++ b/README
@@ -754,7 +754,7 @@ The following options need to be configured:
 		directly type `$name' at the command prompt.
 
 		Global environment variables are those you use
-		env set/printenv to work with. To run a command stored
+		env set/env print to work with. To run a command stored
 		in such a variable, you need to use the run command,
 		and you must not use the '$' sign to access them.
 
@@ -1655,15 +1655,15 @@ The "bootm" command is used to boot an application that is stored in
 memory (RAM or Flash). In case of a Linux kernel image, the contents
 of the "bootargs" environment variable is passed to the kernel as
 parameters. You can check and modify this variable using the
-"printenv" and "env set" commands:
+"env print" and "env set" commands:
 
 
-	=> printenv bootargs
+	=> env print bootargs
 	bootargs=root=/dev/ram
 
 	=> env set bootargs root=/dev/nfs rw nfsroot=10.0.0.2:/LinuxPPC nfsaddrs=10.0.0.99:10.0.0.2
 
-	=> printenv bootargs
+	=> env print bootargs
 	bootargs=root=/dev/nfs rw nfsroot=10.0.0.2:/LinuxPPC nfsaddrs=10.0.0.99:10.0.0.2
 
 	=> bootm 40020000
diff --git a/doc/README.odroid b/doc/README.odroid
index f0592dd57fc..8fe226cf4cf 100644
--- a/doc/README.odroid
+++ b/doc/README.odroid
@@ -200,7 +200,7 @@ Odroid #
 Note that this automatically sets the many IP address related variables in
 U-Boot that is obtained from the DHCP server.
 
-Odroid # printenv ipaddr netmask gatewayip dnsip
+Odroid # env print ipaddr netmask gatewayip dnsip
 ipaddr=192.168.1.10
 netmask=255.255.255.0
 gatewayip=192.168.1.1
@@ -256,7 +256,7 @@ Loading: ####
 	 40 KiB/s
 done
 Bytes transferred = 46935 (b757 hex)
-Odroid # printenv bootargs
+Odroid # env print bootargs
 bootargs=Please use defined boot
 Odroid # env set bootargs console=ttySAC1,115200n8 root=/dev/mmcblk0p2 rootwait
 Odroid # bootz 40080000 - 42000000
diff --git a/doc/android/ab.rst b/doc/android/ab.rst
index 7fd4aeb6a72..b0123db28e4 100644
--- a/doc/android/ab.rst
+++ b/doc/android/ab.rst
@@ -54,7 +54,7 @@ or::
 
 Result::
 
-    => printenv slot_name
+    => env print slot_name
     slot_name=a
 
 Based on this slot information, the current boot partition should be defined,
diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
index a8867ce4d26..0aebc70214f 100644
--- a/doc/usage/cmd/askenv.rst
+++ b/doc/usage/cmd/askenv.rst
@@ -44,7 +44,7 @@ Value of a environment variable env1 without message and size parameters:
 
     => askenv env1
     Please enter 'env1': val1
-    => printenv env1
+    => env print env1
     env1=val1
 
 Value of a environment variable env2 with message and size parameters:
@@ -53,7 +53,7 @@ Value of a environment variable env2 with message and size parameters:
 
     => askenv env2 Please type-in a value for env2: 10
     Please type-in a value for env2: 1234567890123
-    => printenv env2
+    => env print env2
     env2=1234567890
 
 Value of a environment variable env3 with size parameter only:
@@ -62,7 +62,7 @@ Value of a environment variable env3 with size parameter only:
 
     => askenv env3 10
     Please enter 'env3': val3
-    => printenv env3
+    => env print env3
     env3=val3
 
 Configuration
diff --git a/doc/usage/cmd/memsize.rst b/doc/usage/cmd/memsize.rst
index 6e99d7c1d33..9ebeefc58fa 100644
--- a/doc/usage/cmd/memsize.rst
+++ b/doc/usage/cmd/memsize.rst
@@ -34,7 +34,7 @@ This second example shows assign ram size to environment variable:
 ::
 
   => memsize memsz
-  => printenv memsz
+  => env print memsz
   memsz=8192
 
 Return value
-- 
2.53.0

