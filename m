Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79218C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2078122F;
	Fri,  7 Mar 2025 16:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 931DE81276; Fri,  7 Mar 2025 16:16:09 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 29A9A80540
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 16:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: tmG8GKxpTkWhBBC8aYOf7Q==
X-CSE-MsgGUID: c7w/jFtcQimV37BHyJFN6g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 08 Mar 2025 00:15:59 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.94.91])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id A3F074006A99;
 Sat,  8 Mar 2025 00:15:57 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH] cmd: Kconfig: Fix submenu for network commands
Date: Fri,  7 Mar 2025 15:15:29 +0000
Message-ID: <20250307151531.12092-1-paul.barker.ct@bp.renesas.com>
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

The Kconfig parser seems to get confused by the current if conditions
following CMD_NET and displays all network command options directly in
the "Command line interface" menu instead of in a "Network commands"
submenu.

To help out Kconfig we can simplify the if conditions, so that the
definition of CMD_NET is followed immediately by an if/endif block that
contains all network command options. We can also remove nested checks
for CMD_NET or (NET || NET_LWIP).

Fixes: 98ad145db61a ("net: lwip: add DHCP support and dhcp commmand")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 cmd/Kconfig | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8dd42571abce..f4c1a084330d 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1834,12 +1834,10 @@ menuconfig CMD_NET
 	bool "Network commands"
 	default y
 
-endif
+if CMD_NET
 
 if NET
 
-if CMD_NET
-
 config CMD_BOOTP
 	bool "bootp"
 	default y
@@ -2080,7 +2078,6 @@ config IPV6_ROUTER_DISCOVERY
 	help
 	  Will automatically perform router solicitation on first IPv6
 	  network operation
-endif  # if CMD_NET
 
 config CMD_ETHSW
 	bool "ethsw"
@@ -2097,10 +2094,6 @@ config CMD_WOL
 
 endif  # if NET
 
-if NET || NET_LWIP
-
-if CMD_NET
-
 config CMD_DHCP
 	bool "dhcp"
 	select PROT_DHCP_LWIP if NET_LWIP
@@ -2177,8 +2170,6 @@ config WGET_HTTPS
 	help
 	  Enable TLS over http for wget.
 
-endif  # if CMD_NET
-
 config CMD_PXE
 	bool "pxe"
 	select PXE_UTILS
@@ -2186,7 +2177,9 @@ config CMD_PXE
 	help
 	  Boot image via network using PXE protocol
 
-endif  # if NET || NET_LWIP
+endif  # if CMD_NET
+
+endif # NET || NET_LWIP
 
 menu "Misc commands"
 
-- 
2.43.0

