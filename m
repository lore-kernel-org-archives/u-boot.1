Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82949C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 02:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5140880F8;
	Fri, 22 Mar 2024 03:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dN2MBySx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162C387EEF; Fri, 22 Mar 2024 03:19:03 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60673880F8
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 03:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-60a046c5262so15538337b3.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711073938; x=1711678738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pTW7M4XX5P1GZISe67sF6EPSk9hS40JVVdeOK2Rz+eE=;
 b=dN2MBySxADTa8sq7Far2JqET4sLRWiDuOlnMyG9PZYikkNlCw9yy4lENzPxQ4uvdLW
 3odYTDJKqDpO+8V7EDEKxlDuoStL2nnQpNDrp4tDhWwDiHX0z8jg68anHFeVjfCyaWIL
 J/BBW01SwM0C7YrQLD8wHUGcKRCH/M78uzdDPj9L9cjOduJFO3RFmZxcS8YUxMNB9ntF
 rd5VwIqBrGHfVnBzbYISz+EKMjdxv5peT6HP2SytUYaqNcKwt6pfH0+QyIMkuEhUEDfN
 KAMczjAPh40rYU6mQDPxfCKXPpuhfkUlzuhwyd5p1r2c6JciOs5e18gNUCYzCVpNmNM5
 8g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711073938; x=1711678738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pTW7M4XX5P1GZISe67sF6EPSk9hS40JVVdeOK2Rz+eE=;
 b=GmwqNOK+H0kT+EKE3msNrWT2Lt1jrCz2KXB8QVT8mssjWG/+YH/JEEUnknMPGBI6Ad
 4/Ff6hcqHGuZVNgK3B0heG+OwE/KrGJmgRieAA818Qy/Fr0OUutLRjlvU9BzgY9DEqFs
 Onq4TjgkXR5eTclYeRP6M341MPIgILAgKexfSIxZTc6xXMZIOxN+RKnORUVk0YUchuCJ
 ItyBz/axJWvSp3P0/xpRdB9+Cr8IQFfnVFPkY43Q0vGADvSxzYL6iYyNPifk0QSMlDu/
 Wi4qQiFDcfLGEVjrJqHcG6RiFtf/AsVPnsCRSTmqsHO0y6IvJZ9tmMV+wvqkrYqij6CT
 5Qgg==
X-Gm-Message-State: AOJu0YwfR7wvd9S7OHJaNZYId4nvwc5xtnU/HxLM4ITBD1/JLV/zVvPO
 4VXZPnXfIs4gm5zMgpKP9Vauq/abAMDloDE36re7YPK2dgUJShIVYjmUVLKo
X-Google-Smtp-Source: AGHT+IHsnTq42AV+YvS/FDSNwJmyhwZVrlWF7VS7suQ9TE3kXn6iTQKr+ECNw0T9R2aTFVQxf7ywnQ==
X-Received: by 2002:a81:4788:0:b0:609:18e2:91b2 with SMTP id
 u130-20020a814788000000b0060918e291b2mr1091782ywa.32.1711073936841; 
 Thu, 21 Mar 2024 19:18:56 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a81bf53000000b00610e012961bsm208087ywk.3.2024.03.21.19.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 19:18:56 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Michael Walle <michael@walle.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Dave Purdy <david.c.purdy@gmail.com>,
 Evgeni Dobrev <evgeni@studio-punkt.com>, Luka Perkov <luka@openwrt.org>,
 Siddarth Gore <gores@marvell.com>,
 Simon Guinot <simon.guinot@sequanux.org>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Walter Schweizer <swwa@users.sourceforge.net>
Subject: [PATCH] arm: dts: kirkwood: Enable upstream DT on Kirkwood boards
Date: Thu, 21 Mar 2024 19:17:47 -0700
Message-Id: <20240322021747.14873-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
DEFAULT_DEVICE_TREE for Kirkwood boards. And so we can directly build
DTBs from dts/upstream/src/arm/marvell, and including *-u-boot.dtsi
files from arch/arm/dts/ directory.

Background:

Hi Stefan,
Hi Michael,

I did a survey and we currently have 28 Kirkwood boards. Using some
commands and filters, here are the finding.

git grep -li arch_kirkwood configs | xargs grep DEVICE_TREE | cut -d '"' -f2 | xargs -n1 sh -c 'diff -qs  arch/arm/dts/$1.dts dts/upstream/src/arm/marvell/$1.dts' sh | grep differ

diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifkw.dts: No such file or directory
diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifxcat.dts: No such file or directory

Files arch/arm/dts/kirkwood-dockstar.dts and dts/upstream/src/arm/marvell/kirkwood-dockstar.dts differ
Files arch/arm/dts/kirkwood-dreamplug.dts and dts/upstream/src/arm/marvell/kirkwood-dreamplug.dts differ
Files arch/arm/dts/kirkwood-goflexnet.dts and dts/upstream/src/arm/marvell/kirkwood-goflexnet.dts differ
Files arch/arm/dts/kirkwood-guruplug-server-plus.dts and dts/upstream/src/arm/marvell/kirkwood-guruplug-server-plus.dts differ
Files arch/arm/dts/kirkwood-iconnect.dts and dts/upstream/src/arm/marvell/kirkwood-iconnect.dts differ
Files arch/arm/dts/kirkwood-net2big.dts and dts/upstream/src/arm/marvell/kirkwood-net2big.dts differ
Files arch/arm/dts/kirkwood-ns2max.dts and dts/upstream/src/arm/marvell/kirkwood-ns2max.dts differ
Files arch/arm/dts/kirkwood-ns2mini.dts and dts/upstream/src/arm/marvell/kirkwood-ns2mini.dts differ
Files arch/arm/dts/kirkwood-nsa310s.dts and dts/upstream/src/arm/marvell/kirkwood-nsa310s.dts differ
Files arch/arm/dts/kirkwood-nsa325.dts and dts/upstream/src/arm/marvell/kirkwood-nsa325.dts differ
Files arch/arm/dts/kirkwood-openrd-client.dts and dts/upstream/src/arm/marvell/kirkwood-openrd-client.dts differ

diff -qrbu arch/arm/dts/ dts/upstream/src/arm/marvell/ | grep kirkwood | grep ".dtsi "

Files arch/arm/dts/kirkwood-6192.dtsi and dts/upstream/src/arm/marvell/kirkwood-6192.dtsi differ
Files arch/arm/dts/kirkwood-6281.dtsi and dts/upstream/src/arm/marvell/kirkwood-6281.dtsi differ
Files arch/arm/dts/kirkwood-98dx4122.dtsi and dts/upstream/src/arm/marvell/kirkwood-98dx4122.dtsi differ
Files arch/arm/dts/kirkwood-dnskw.dtsi and dts/upstream/src/arm/marvell/kirkwood-dnskw.dtsi differ
Files arch/arm/dts/kirkwood.dtsi and dts/upstream/src/arm/marvell/kirkwood.dtsi differ
Files arch/arm/dts/kirkwood-lsxl.dtsi and dts/upstream/src/arm/marvell/kirkwood-lsxl.dtsi differ
Files arch/arm/dts/kirkwood-nsa3x0-common.dtsi and dts/upstream/src/arm/marvell/kirkwood-nsa3x0-common.dtsi differ
Files arch/arm/dts/kirkwood-synology.dtsi and dts/upstream/src/arm/marvell/kirkwood-synology.dtsi differ

And after reviewing these differences, the following are my observation.

OF_LIST is not used in these Kirkwood boards.

1. Boards that have only u-boot DTS that should be opt-out for now with "#CONFIG_OF_UPSTREAM is not set"

diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifkw.dts: No such file or directory
diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifxcat.dts: No such file or directory

2. DTS and DTSI files that have only cosmetic, style, or binding changes (safe to take)

Files arch/arm/dts/kirkwood-dockstar.dts and dts/upstream/src/arm/marvell/kirkwood-dockstar.dts differ
Files arch/arm/dts/kirkwood-goflexnet.dts and dts/upstream/src/arm/marvell/kirkwood-goflexnet.dts differ
Files arch/arm/dts/kirkwood-guruplug-server-plus.dts and dts/upstream/src/arm/marvell/kirkwood-guruplug-server-plus.dts differ
Files arch/arm/dts/kirkwood-iconnect.dts and dts/upstream/src/arm/marvell/kirkwood-iconnect.dts differ
Files arch/arm/dts/kirkwood-net2big.dts and dts/upstream/src/arm/marvell/kirkwood-net2big.dts differ
Files arch/arm/dts/kirkwood-ns2max.dts and dts/upstream/src/arm/marvell/kirkwood-ns2max.dts differ
Files arch/arm/dts/kirkwood-ns2mini.dts and dts/upstream/src/arm/marvell/kirkwood-ns2mini.dts differ
Files arch/arm/dts/kirkwood-nsa325.dts and dts/upstream/src/arm/marvell/kirkwood-nsa325.dts differ
Files arch/arm/dts/kirkwood-openrd-client.dts and dts/upstream/src/arm/marvell/kirkwood-openrd-client.dts differ

Files arch/arm/dts/kirkwood-dnskw.dtsi and dts/upstream/src/arm/marvell/kirkwood-dnskw.dtsi differ
Files arch/arm/dts/kirkwood.dtsi and dts/upstream/src/arm/marvell/kirkwood.dtsi differ
Files arch/arm/dts/kirkwood-synology.dtsi and dts/upstream/src/arm/marvell/kirkwood-synology.dtsi differ

3. DTS files that are newer in upstream (safe to take with regression test)

Files arch/arm/dts/kirkwood-nsa310s.dts and dts/upstream/src/arm/marvell/kirkwood-nsa310s.dts differ

4. DTSI files that have additional PCI-related bindings in upstream (safe to take with regression test)

Files arch/arm/dts/kirkwood-6192.dtsi and dts/upstream/src/arm/marvell/kirkwood-6192.dtsi differ
Files arch/arm/dts/kirkwood-6281.dtsi and dts/upstream/src/arm/marvell/kirkwood-6281.dtsi differ
Files arch/arm/dts/kirkwood-98dx4122.dtsi and dts/upstream/src/arm/marvell/kirkwood-98dx4122.dtsi differ

5. DTSI files that will need new or modified -u-boot.dtsi

Files arch/arm/dts/kirkwood-dreamplug.dts and dts/upstream/src/arm/marvell/kirkwood-dreamplug.dts differ
Files arch/arm/dts/kirkwood-lsxl.dtsi and dts/upstream/src/arm/marvell/kirkwood-lsxl.dtsi differ
Files arch/arm/dts/kirkwood-nsa3x0-common.dtsi and dts/upstream/src/arm/marvell/kirkwood-nsa3x0-common.dtsi differ

So these u-boot.dtsi files need to be created/modified so we can use upstream DTS/DTSI:

	modified:   arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
	modified:   arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi

	new file:   arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
	new file:   arch/arm/dts/kirkwood-nsa325-u-boot.dtsi

I've regression tested this patch with the Zyxel NSA325 (Kirkwood 88F6282)
and Zyxel NSA310S (Kirkwood 88F6281). The Zyxel NSA325 board has a
USB 3.0 controller attached to the PCIe bus. And the Zyxel NSA310S
has an extensive overhaul in bindings and styles in upstream DTS version.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi | 7 +++++++
 arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi   | 6 ++++--
 arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi     | 6 ++++--
 arch/arm/dts/kirkwood-nsa325-u-boot.dtsi    | 7 +++++++
 arch/arm/mach-kirkwood/Kconfig              | 4 ++++
 configs/SBx81LIFKW_defconfig                | 1 +
 configs/SBx81LIFXCAT_defconfig              | 1 +
 configs/d2net_v2_defconfig                  | 2 +-
 configs/dns325_defconfig                    | 2 +-
 configs/dockstar_defconfig                  | 2 +-
 configs/dreamplug_defconfig                 | 2 +-
 configs/ds109_defconfig                     | 2 +-
 configs/goflexhome_defconfig                | 2 +-
 configs/guruplug_defconfig                  | 2 +-
 configs/ib62x0_defconfig                    | 2 +-
 configs/iconnect_defconfig                  | 2 +-
 configs/inetspace_v2_defconfig              | 2 +-
 configs/lschlv2_defconfig                   | 2 +-
 configs/lsxhl_defconfig                     | 2 +-
 configs/nas220_defconfig                    | 2 +-
 configs/net2big_v2_defconfig                | 2 +-
 configs/netspace_lite_v2_defconfig          | 2 +-
 configs/netspace_max_v2_defconfig           | 2 +-
 configs/netspace_mini_v2_defconfig          | 2 +-
 configs/netspace_v2_defconfig               | 2 +-
 configs/nsa310s_defconfig                   | 2 +-
 configs/nsa325_defconfig                    | 2 +-
 configs/openrd_base_defconfig               | 2 +-
 configs/openrd_client_defconfig             | 2 +-
 configs/openrd_ultimate_defconfig           | 2 +-
 configs/pogo_e02_defconfig                  | 2 +-
 configs/pogo_v4_defconfig                   | 2 +-
 configs/sheevaplug_defconfig                | 2 +-
 33 files changed, 54 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
 create mode 100644 arch/arm/dts/kirkwood-nsa325-u-boot.dtsi

diff --git a/arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi b/arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
new file mode 100644
index 0000000000..59f19a211f
--- /dev/null
+++ b/arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/ {
+	aliases {
+		spi0 = &spi0;
+	};
+};
diff --git a/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi b/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
index 7fc2d7d3b4..cf33ff822e 100644
--- a/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
+++ b/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-&eth0 {
-	status = "disabled";
+/ {
+	aliases {
+		spi0 = &spi0;
+	};
 };
 
 &hdd_power {
diff --git a/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi b/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
index 7fc2d7d3b4..cf33ff822e 100644
--- a/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
+++ b/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-&eth0 {
-	status = "disabled";
+/ {
+	aliases {
+		spi0 = &spi0;
+	};
 };
 
 &hdd_power {
diff --git a/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi b/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
new file mode 100644
index 0000000000..dec27b2a87
--- /dev/null
+++ b/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+&nand {
+	partition@0 {
+		/delete-property/ read-only;
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index c2fff84a68..39593c83d0 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -28,6 +28,10 @@ config CUSTOM_SYS_INIT_SP_ADDR
         depends on HAS_CUSTOM_SYS_INIT_SP_ADDR
         default 0x5ff000
 
+config OF_UPSTREAM
+	bool "Use upstream DTS for Kirkwood boards"
+	default y
+
 choice
 	prompt "Marvell Kirkwood board select"
 	optional
diff --git a/configs/SBx81LIFKW_defconfig b/configs/SBx81LIFKW_defconfig
index cc17a8b114..977daf9f09 100644
--- a/configs/SBx81LIFKW_defconfig
+++ b/configs/SBx81LIFKW_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_KIRKWOOD=y
 CONFIG_SYS_KWD_CONFIG="board/alliedtelesis/SBx81LIFKW/kwbimage.cfg"
 CONFIG_TEXT_BASE=0x00600000
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_TARGET_SBx81LIFKW=y
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
diff --git a/configs/SBx81LIFXCAT_defconfig b/configs/SBx81LIFXCAT_defconfig
index 0612723298..9bc8614030 100644
--- a/configs/SBx81LIFXCAT_defconfig
+++ b/configs/SBx81LIFXCAT_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_KIRKWOOD=y
 CONFIG_SYS_KWD_CONFIG="board/alliedtelesis/SBx81LIFXCAT/kwbimage.cfg"
 CONFIG_TEXT_BASE=0x00600000
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_TARGET_SBx81LIFXCAT=y
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
diff --git a/configs/d2net_v2_defconfig b/configs/d2net_v2_defconfig
index bb1bcb0aa3..69658a2ba7 100644
--- a/configs/d2net_v2_defconfig
+++ b/configs/d2net_v2_defconfig
@@ -11,7 +11,7 @@ CONFIG_TARGET_NET2BIG_V2=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x70000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-d2net"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-d2net"
 CONFIG_IDENT_STRING=" D2 v2"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0x70000
diff --git a/configs/dns325_defconfig b/configs/dns325_defconfig
index edfe92c5f3..b85f7cac8e 100644
--- a/configs/dns325_defconfig
+++ b/configs/dns325_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
 CONFIG_TARGET_DNS325=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xE0000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-dns325"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-dns325"
 CONFIG_IDENT_STRING="\nD-Link DNS-325"
 CONFIG_SYS_LOAD_ADDR=0x800000
 # CONFIG_SYS_MALLOC_F is not set
diff --git a/configs/dockstar_defconfig b/configs/dockstar_defconfig
index 719fa3979e..7b5f19433a 100644
--- a/configs/dockstar_defconfig
+++ b/configs/dockstar_defconfig
@@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_TARGET_DOCKSTAR=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x80000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-dockstar"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-dockstar"
 CONFIG_IDENT_STRING="\nSeagate FreeAgent DockStar"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_BOOTDELAY=3
diff --git a/configs/dreamplug_defconfig b/configs/dreamplug_defconfig
index 02a2635af8..8518eabcb2 100644
--- a/configs/dreamplug_defconfig
+++ b/configs/dreamplug_defconfig
@@ -13,7 +13,7 @@ CONFIG_TARGET_DREAMPLUG=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-dreamplug"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-dreamplug"
 CONFIG_IDENT_STRING="\nMarvell-DreamPlug"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0x100000
diff --git a/configs/ds109_defconfig b/configs/ds109_defconfig
index 304c098c99..ef805eca56 100644
--- a/configs/ds109_defconfig
+++ b/configs/ds109_defconfig
@@ -14,7 +14,7 @@ CONFIG_TARGET_DS109=y
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3D0000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ds109"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ds109"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0x3D0000
 # CONFIG_SYS_MALLOC_F is not set
diff --git a/configs/goflexhome_defconfig b/configs/goflexhome_defconfig
index d577d5807b..53b2ce97e8 100644
--- a/configs/goflexhome_defconfig
+++ b/configs/goflexhome_defconfig
@@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_TARGET_GOFLEXHOME=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xC0000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-goflexnet"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-goflexnet"
 CONFIG_IDENT_STRING="\nSeagate GoFlex Home"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_BOOTDELAY=3
diff --git a/configs/guruplug_defconfig b/configs/guruplug_defconfig
index 7cb649e29c..5371ee403b 100644
--- a/configs/guruplug_defconfig
+++ b/configs/guruplug_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
 CONFIG_TARGET_GURUPLUG=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xE0000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-guruplug-server-plus"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-guruplug-server-plus"
 CONFIG_IDENT_STRING="\nMarvell-GuruPlug"
 CONFIG_SYS_LOAD_ADDR=0x800000
 # CONFIG_SYS_MALLOC_F is not set
diff --git a/configs/ib62x0_defconfig b/configs/ib62x0_defconfig
index 074384e387..32b0e1c395 100644
--- a/configs/ib62x0_defconfig
+++ b/configs/ib62x0_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
 CONFIG_TARGET_IB62X0=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xE0000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ib62x0"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ib62x0"
 CONFIG_IDENT_STRING=" RaidSonic ICY BOX IB-NAS62x0"
 CONFIG_SYS_LOAD_ADDR=0x800000
 # CONFIG_SYS_MALLOC_F is not set
diff --git a/configs/iconnect_defconfig b/configs/iconnect_defconfig
index f7b74c4662..45ffbd92db 100644
--- a/configs/iconnect_defconfig
+++ b/configs/iconnect_defconfig
@@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_TARGET_ICONNECT=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x80000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-iconnect"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-iconnect"
 CONFIG_IDENT_STRING=" Iomega iConnect"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_PCI=y
diff --git a/configs/inetspace_v2_defconfig b/configs/inetspace_v2_defconfig
index 2e8e3f3928..3fa7790d77 100644
--- a/configs/inetspace_v2_defconfig
+++ b/configs/inetspace_v2_defconfig
@@ -11,7 +11,7 @@ CONFIG_TARGET_NETSPACE_V2=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x70000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-is2"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-is2"
 CONFIG_IDENT_STRING=" IS v2"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0x70000
diff --git a/configs/lschlv2_defconfig b/configs/lschlv2_defconfig
index 99bdbc1483..ad060079a7 100644
--- a/configs/lschlv2_defconfig
+++ b/configs/lschlv2_defconfig
@@ -15,7 +15,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x70000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-lschlv2"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-lschlv2"
 CONFIG_IDENT_STRING=" LS-CHLv2"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
diff --git a/configs/lsxhl_defconfig b/configs/lsxhl_defconfig
index bb0a5ddf50..b2d9f0c9d8 100644
--- a/configs/lsxhl_defconfig
+++ b/configs/lsxhl_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x70000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-lsxhl"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-lsxhl"
 CONFIG_IDENT_STRING=" LS-XHL"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
diff --git a/configs/nas220_defconfig b/configs/nas220_defconfig
index f01b26f2df..4ea342a043 100644
--- a/configs/nas220_defconfig
+++ b/configs/nas220_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
 CONFIG_TARGET_NAS220=y
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xA0000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-blackarmor-nas220"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-blackarmor-nas220"
 CONFIG_IDENT_STRING="\nNAS 220"
 CONFIG_SYS_LOAD_ADDR=0x800000
 # CONFIG_SYS_MALLOC_F is not set
diff --git a/configs/net2big_v2_defconfig b/configs/net2big_v2_defconfig
index dda627aac6..39cbc3384f 100644
--- a/configs/net2big_v2_defconfig
+++ b/configs/net2big_v2_defconfig
@@ -12,7 +12,7 @@ CONFIG_NET2BIG_V2=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x70000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-net2big"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-net2big"
 CONFIG_IDENT_STRING=" 2Big v2"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0x70000
diff --git a/configs/netspace_lite_v2_defconfig b/configs/netspace_lite_v2_defconfig
index 742e6205d8..cd416cb150 100644
--- a/configs/netspace_lite_v2_defconfig
+++ b/configs/netspace_lite_v2_defconfig
@@ -12,7 +12,7 @@ CONFIG_NETSPACE_LITE_V2=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x70000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ns2lite"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ns2lite"
 CONFIG_IDENT_STRING=" NS v2 Lite"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0x70000
diff --git a/configs/netspace_max_v2_defconfig b/configs/netspace_max_v2_defconfig
index 7779e6815e..6a3d9296ac 100644
--- a/configs/netspace_max_v2_defconfig
+++ b/configs/netspace_max_v2_defconfig
@@ -12,7 +12,7 @@ CONFIG_NETSPACE_MAX_V2=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x70000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ns2max"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ns2max"
 CONFIG_IDENT_STRING=" NS Max v2"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0x70000
diff --git a/configs/netspace_mini_v2_defconfig b/configs/netspace_mini_v2_defconfig
index 9e3614bb44..e25631b09f 100644
--- a/configs/netspace_mini_v2_defconfig
+++ b/configs/netspace_mini_v2_defconfig
@@ -12,7 +12,7 @@ CONFIG_NETSPACE_MINI_V2=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x70000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ns2mini"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ns2mini"
 CONFIG_IDENT_STRING=" NS v2 Mini"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0x70000
diff --git a/configs/netspace_v2_defconfig b/configs/netspace_v2_defconfig
index 1583a0adb3..b6ac2a8b19 100644
--- a/configs/netspace_v2_defconfig
+++ b/configs/netspace_v2_defconfig
@@ -12,7 +12,7 @@ CONFIG_NETSPACE_V2=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x70000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ns2"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ns2"
 CONFIG_IDENT_STRING=" NS v2"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0x70000
diff --git a/configs/nsa310s_defconfig b/configs/nsa310s_defconfig
index 89d8b18b16..e859a43ffa 100644
--- a/configs/nsa310s_defconfig
+++ b/configs/nsa310s_defconfig
@@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_TARGET_NSA310S=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xE0000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-nsa310s"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-nsa310s"
 CONFIG_DEBUG_UART_BASE=0xf1012000
 CONFIG_DEBUG_UART_CLOCK=166666667
 CONFIG_IDENT_STRING="\nZyXEL NSA310S/320S 1/2-Bay Power Media Server"
diff --git a/configs/nsa325_defconfig b/configs/nsa325_defconfig
index 5da4a002b4..88a890002e 100644
--- a/configs/nsa325_defconfig
+++ b/configs/nsa325_defconfig
@@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_TARGET_NSA325=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xC0000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-nsa325"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-nsa325"
 CONFIG_IDENT_STRING="\nZyXEL NSA325 2-Bay Power Media Server"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_PCI=y
diff --git a/configs/openrd_base_defconfig b/configs/openrd_base_defconfig
index 29a14e0927..057dd28dff 100644
--- a/configs/openrd_base_defconfig
+++ b/configs/openrd_base_defconfig
@@ -11,7 +11,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
 CONFIG_TARGET_OPENRD=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x80000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-openrd-base"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-base"
 CONFIG_IDENT_STRING="\nOpenRD-Base"
 CONFIG_SYS_LOAD_ADDR=0x800000
 # CONFIG_SYS_MALLOC_F is not set
diff --git a/configs/openrd_client_defconfig b/configs/openrd_client_defconfig
index a95a435bdf..05e4292764 100644
--- a/configs/openrd_client_defconfig
+++ b/configs/openrd_client_defconfig
@@ -12,7 +12,7 @@ CONFIG_TARGET_OPENRD=y
 CONFIG_BOARD_IS_OPENRD_CLIENT=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x80000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-openrd-client"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-client"
 CONFIG_IDENT_STRING="\nOpenRD-Client"
 CONFIG_SYS_LOAD_ADDR=0x800000
 # CONFIG_SYS_MALLOC_F is not set
diff --git a/configs/openrd_ultimate_defconfig b/configs/openrd_ultimate_defconfig
index e3f5294ff1..6e13c6eabd 100644
--- a/configs/openrd_ultimate_defconfig
+++ b/configs/openrd_ultimate_defconfig
@@ -12,7 +12,7 @@ CONFIG_TARGET_OPENRD=y
 CONFIG_BOARD_IS_OPENRD_ULTIMATE=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x80000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-openrd-ultimate"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-ultimate"
 CONFIG_IDENT_STRING="\nOpenRD-Ultimate"
 CONFIG_SYS_LOAD_ADDR=0x800000
 # CONFIG_SYS_MALLOC_F is not set
diff --git a/configs/pogo_e02_defconfig b/configs/pogo_e02_defconfig
index e53ccf34c7..880cb20b22 100644
--- a/configs/pogo_e02_defconfig
+++ b/configs/pogo_e02_defconfig
@@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_TARGET_POGO_E02=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xC0000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-pogo_e02"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-pogo_e02"
 CONFIG_IDENT_STRING="\nPogo E02"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_BOOTDELAY=3
diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
index 95e22b3fef..50046e83b7 100644
--- a/configs/pogo_v4_defconfig
+++ b/configs/pogo_v4_defconfig
@@ -12,7 +12,7 @@ CONFIG_TEXT_BASE=0x600000
 CONFIG_TARGET_POGO_V4=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xC0000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-pogoplug-series-4"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-pogoplug-series-4"
 CONFIG_IDENT_STRING="\nPogoplug V4"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_PCI=y
diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfig
index 0af87dc4fb..b673b3f6da 100644
--- a/configs/sheevaplug_defconfig
+++ b/configs/sheevaplug_defconfig
@@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_TARGET_SHEEVAPLUG=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x80000
-CONFIG_DEFAULT_DEVICE_TREE="kirkwood-sheevaplug"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-sheevaplug"
 CONFIG_IDENT_STRING="\nMarvell-Sheevaplug"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-- 
2.39.2

