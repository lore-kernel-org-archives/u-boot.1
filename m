Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB0606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KiReLnvP;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Ua9Ki/ZV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A8A9405D1;
	Sun,  1 Nov 2026 20:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dG1k8857iood; Sun,  1 Nov 2026 20:12:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DEA31405C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793563950;
	b=qQjzYqaQN4cynXmNNzDorJbwQ1RSvfXdHL8bBOSjrTWcH5nIDEmmJO4Ia4H2P0HO18DK
	 hx7cVMi3Jlyz18JODjpwylx/q5fMcP8xltqZ9O8y1Wo5Neuly7hh6uQRfqb2uSTgHYqsk
	 tbzdiCOxlAIZOzI20kRtT205i/sl4TLOz8ojwzv5RftU03rMwzlOX4rC8AmRAirddWOhb
	 TPJzCc6tH+Q1x530ulRu8LmJgc9LM1D5kO7f5UyflkXtC3DNRREq9KV2WhqWlCQiF1Cp6
	 C7+X3EkqW7Ar31oPUHqa/2CxagCh4bAuBXWUMAajALu7jKgV925jDrOBuw9qArGmC3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793563950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hd2iUl/nE+lCDGuFe7fGuGqOMUYQkmPPsLP5Lp23Gz8=;
	b=nJaNOSqWNQ2X+n23yxZCiIAt5l2aY0NZqys4LXWIW+XK+GxkBktol9okS4B+yIk1T2Yw
	 Ql5nY/aqSKn8qMIwEAhBZ8mIsgYZjUd2svFXrElFqSeC3rDr0F1XV7DN2hMA/zduXBXHZ
	 17ckDDygGH2sHp0bCQU6RXLnbGEhbqp66gTjpj903ddlnx1fQFvhrhwJd7NI/+07eA5Om
	 Hmr2O2Ah4LxrxgoeYfmB3XwNn7FNnRqh7HGWFbWIox4OrMFfeAg2qt7H4axIHeKVX6kW8
	 v8nrb8TZqsyqwRfkKhFW3JgF41Q97N/8IP90u36HbcDqqqkya/HZ4szBNeHSYtgTE+w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793563950;
	bh=hd2iUl/nE+lCDGuFe7fGuGqOMUYQkmPPsLP5Lp23Gz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KiReLnvP/S20cevX645nCwqz+mVohIfIlRtrzDhdKhq/mt8xfUa3K2vi2noorWRVq
	 hbYEJk6mZKssOrnTO/whksEDcJdcoElHWj0XSkrkoDPR1oy0sClP0KAxhFKCw98kPI
	 1lPdas67FZlhs4EnEOPEmA+gF9xghG/wYQOipqGZHFT6vPHQqEsoxT45phVGz2Gnss
	 lXJIUmmESssFcPCSdNcuRG5FDUAJz9VH05UX8cm2R3ybmNuPHItauoz/mIK5ryQQRy
	 ClPa0mATG8KLTpdsdoMlezU370wvL+Rdk4MRu3Ur4zmLhS/2oN4hN654xO4Yamjcad
	 mvMuIUXvXXsqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEA31405C9;
	Sun,  1 Nov 2026 20:12:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C1BB34D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 20:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08A696060D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 20:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7mWO7NsuUi4g for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 20:12:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8879C605E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793563946;
 b=IpfwnCp3SBuYgJ6b8cz5yf/OneE8047xnI49LCf8/L+pGan7sUiokTfPLeeQkQW7ozcK
 npdD42ecAOShoF4bf+7hkGOagGDdwb7tR7sh+HdmVbgm/5WYxmYCCtWONijqX/fYIKLu0
 /YrHCkBWATqXqycq+7tGh01a5QaJDT3CyGOpmoGidTRXRGrjXTXq+GElabjTbyKLWPK3x
 vk3Z+1m5qJ1MvXApt/YTFIDK4+x3/+o14zyr7NegW0K+1q2B2Yoz5E2EC52GU44XLET4+
 n2w954eZgW9gS7LxisOOQpsqjsyOYSTpnDjrHDnEZPAwjAr3ASUIsNPPmIwqqFBbw2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793563946;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=hd2iUl/nE+lCDGuFe7fGuGqOMUYQkmPPsLP5Lp23Gz8=;
 b=JEK33NVIB+cK4eGWiHjTrkH2hPzXHlpjZgRwzGRTQR2ZGmryFagmh7+k9xZr/lqjyqEB
 A01jLjCcfTUYFn1k/F1P4NoW+RtzKEPR/7xnLlCHF6bWh1w5NVrWWUHnkId6EBD6lJfJD
 rq/iaLC8aWIvuPxACwzTCFFDABafts+M08kkBh/pd9/3n7v3DXlNGc3OyLVe4ZB/ZgMnV
 5stF5YbfioFMZZKSJcSEJJlrYFhZOtqfVD8Z1Gt+6hYMlDpSFK9zenXW/0PU/XqTbr+iw
 S4Fg7WI62d9ykCu3MZsstXrDQI/TgKr5wYPZCo7Pyu+qg15be8ppsyqB2czfGw5h8zA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="Ua9Ki/ZV"; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=Ua9Ki/ZV
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8879C605E4
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 20:12:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id DA9FDB0054C;
 Sun,  1 Nov 2026 21:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793563943;
 bh=s60RYUio0H/5H6o3rOEij7OwVQ5TZHNWhWulGDDlao0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ua9Ki/ZVq/rvuLrOFiBMAYb4YJmpwDBhX1rbw0L2TzRzh3ac1P9t94V0OcD3G8Jme
 ShhtXC+sFKT4PQx01wuPPNHTxAhYRK04Xh9gA6yNvbyl0okUqBDg27JChUoScJv63d
 Q2GAIFYjZuXi6iw/Qt97omoGk/o6FaUx7NtFGIHr/kvI6VY50VQQN7KtFdmiSEr28a
 fdx5tTftJjMkd+qz7iAjvMvY3YhrUtnIRYmOlp39vtWSoDIe71u1wXin93c0w8O/yM
 PUHowH9AvPYpuhE7t9d846PgIXM4HKKbMiGAMuImbfTG5oQKCF5psu3aZlif9uaNkv
 8hk0k/8J0Mipw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 1/2] doc: board: nxp: convert README.fsl-hwconfig to RST
Date: Sun,  1 Nov 2026 21:11:19 +0100
Message-ID: <20261101201126.426751-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101201126.426751-1-vjardin@free.fr>
References: <20261101201126.426751-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert doc/README.fsl-hwconfig to RST
doc/board/nxp/hwconfig.rst

The text is not modified.

Suggested-by: Tom Rini <trini@konsulko.com>
Link: https://lore.kernel.org/u-boot/20260928191412.GN858934@bill-the-cat/
Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 MAINTAINERS                                   |   1 +
 .../cpu/armv8/fsl-layerscape/doc/README.soc   |   2 +-
 doc/README.fsl-hwconfig                       | 116 ---------------
 doc/board/nxp/hwconfig.rst                    | 133 ++++++++++++++++++
 doc/board/nxp/index.rst                       |   1 +
 5 files changed, 136 insertions(+), 117 deletions(-)
 delete mode 100644 doc/README.fsl-hwconfig
 create mode 100644 doc/board/nxp/hwconfig.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index af3ca0f1bf2..7774562a3d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1080,6 +1080,7 @@ FREESCALE QORIQ
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git
+F:	doc/board/nxp/hwconfig.rst
 F:	drivers/watchdog/sp805_wdt.c
 F:	drivers/watchdog/sbsa_gwdt.c
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
index a641e4978aa..e226cc22467 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
+++ b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
@@ -335,7 +335,7 @@ SerDes 1 lane grouping
   SRDS_PRTCL_S1 is latched at reset. U-Boot can still configure SD1 before
   the MC starts:
   1x100GE + 4x25G, 2x40GE, 1x40GE + 4x10G or 1x100GE + 4x10G.
-  See 'serdes1' in doc/README.fsl-hwconfig, and the 'lx2160_serdes status'
+  See 'serdes1' in doc/board/nxp/hwconfig.rst, and the 'lx2160_serdes status'
   command.
 
 
diff --git a/doc/README.fsl-hwconfig b/doc/README.fsl-hwconfig
deleted file mode 100644
index 6b628f30317..00000000000
--- a/doc/README.fsl-hwconfig
+++ /dev/null
@@ -1,116 +0,0 @@
-Freescale-specific 'hwconfig' options.
-
-This file documents Freescale-specific key:value pairs for the 'hwconfig'
-option.  See README.hwconfig for general information about 'hwconfig'.
-
-audclk
-	Specific to the P1022DS reference board.
-
-	This option specifies which of the two oscillator frequencies should be
-	routed to the Wolfson WM8776 codec.  The ngPIXIS can be programmed to
-	route either a 11.2896MHz or a 12.288MHz clock.  The default is
-	12.288MHz.  This option has two effects.  First, the MUX on the board
-	will be programmed accordingly.  Second, the clock-frequency property
-	in the codec node in the device tree will be updated to the correct
-	value.
-
-	'audclk:11'
-		Select the 11.2896MHz clock
-
-	'audclk:12'
-		Select the 12.288MHz clock
-
-usb
-	Specific to boards have USB controller
-
-	This option specifies the following for a USB controller:
-
-		- which controller mode to use
-		- which USB PHY to use
-
-	This is used by generic USB device-tree fixup function to update
-	modified values of phy type and controller mode.
-
-	Also used for configuring multiple USB controllers such that
-	'usbN' (where N is 1, 2, etc. refers to controller no.)
-
-	'phy_type'
-		Select USB phy type: 'utmi' OR 'ulpi'
-
-	'dr_mode'
-		Select USB controller mode: 'host', 'peripheral' OR 'otg'
-
-	Examples:
-		usb1:dr_mode=host;usb2:dr_mode=peripheral'
-
-		usb1:dr_mode=host,phy_type=utmi;usb2:dr_mode=host'
-
-serdes1
-	Specific to the LX2160A boards whose reset_phy() calls
-	lx2160a_serdes_apply_hwconfig() before mc_env_boot().
-
-	SRDS_PRTCL_S1 is latched at reset, but the eight SD1 (SerDes) lanes
-	can still be configured before the DPAA2 management complex (MC) starts.
-	This option alters the Ethernet MAC-to-lane grouping after the fact
-	(RCWSR29 keeps reporting the initial protocol).
-
-	'serdes1:2x100g'
-		2x 100GE (CAUI-4), what protocol 13 builds: nothing to do
-
-	'serdes1:100g4x25g'
-		1x 100GE + 4x 25G
-
-	'serdes1:2x40g'
-		2x 40GE (XLAUI-4), what protocol 20 builds
-
-	'serdes1:40g4x10g'
-		1x 40GE + 4x 10G (XFI)
-
-	'serdes1:100g4x10g'
-		1x 100GE + 4x 10G (XFI)
-
-	Each mode starts from the one in the 'from' column, which is
-	entered first when SD1 is not in it yet, and so on down to what
-	SRDS_PRTCL_S1 built:
-
-		mode        from      SRDS_PRTCL_S1   lanes run on
-		2x100g      -         13              PLLF
-		100g4x25g   2x100g    13              PLLF
-		2x40g       2x100g    13 or 20        PLLS
-		40g4x10g    2x40g     13 or 20        PLLS
-		100g4x10g   2x100g    13              PLLF and PLLS
-
-	Active DPMACs for each mode:
-
-		mode        dpmac.1   dpmac.2   dpmac.3 ... dpmac.6
-		2x100g      100GE     100GE     -
-		100g4x25g   -         100GE     4x 25G
-		2x40g       40GE      40GE      -
-		40g4x10g    -         40GE      4x XFI
-		100g4x10g   -         100GE     4x XFI
-
-	A mode name lists its ports from lane A to lane H: in 100g4x25g,
-	dpmac.2 is 100GE on lanes A-D, and dpmac.3 to dpmac.6 are 25G on
-	lanes E-H. The SRDS_PRTCL_S1 table of the reference manual lists
-	the lanes from H to A, so its rows read right to left against the
-	mode names.
-
-	Initial conditions:
-
-	- PLLS needs a 161.1328125 MHz reference clock, for which 2x40g,
-	  40g4x10g and 100g4x10g program it. It can come from the SD1
-	  PLLS reference clock input, or from the PLLF one with
-	  SRDS_INTRA_REF_CLK_S1=1. A 156.25 MHz PLLS reference clock is
-	  not supported. With protocol 13 PLLS is not in use, so nothing
-	  checks that clock before these modes start it.
-	- The MC DPC must set follow_hw_pssr in board_info/serdes, for the
-	  MC to read the lanes rather than look at protocol, and the DPL
-	  must use the dpmacs of the new grouping.
-
-	'lx2160_serdes status 1' shows the resulting lane grouping and
-	protocol converters.
-
-	Example:
-		setenv hwconfig serdes1:100g4x25g
-		saveenv
-		reset
diff --git a/doc/board/nxp/hwconfig.rst b/doc/board/nxp/hwconfig.rst
new file mode 100644
index 00000000000..4804f44d962
--- /dev/null
+++ b/doc/board/nxp/hwconfig.rst
@@ -0,0 +1,133 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Freescale-specific 'hwconfig' options.
+======================================
+
+This file documents Freescale-specific key:value pairs for the 'hwconfig'
+option.  See README.hwconfig for general information about 'hwconfig'.
+
+audclk
+------
+
+Specific to the P1022DS reference board.
+
+This option specifies which of the two oscillator frequencies should be
+routed to the Wolfson WM8776 codec.  The ngPIXIS can be programmed to
+route either a 11.2896MHz or a 12.288MHz clock.  The default is
+12.288MHz.  This option has two effects.  First, the MUX on the board
+will be programmed accordingly.  Second, the clock-frequency property
+in the codec node in the device tree will be updated to the correct
+value.
+
+'audclk:11'
+    Select the 11.2896MHz clock
+
+'audclk:12'
+    Select the 12.288MHz clock
+
+usb
+---
+
+Specific to boards have USB controller
+
+This option specifies the following for a USB controller:
+
+- which controller mode to use
+- which USB PHY to use
+
+This is used by generic USB device-tree fixup function to update
+modified values of phy type and controller mode.
+
+Also used for configuring multiple USB controllers such that
+'usbN' (where N is 1, 2, etc. refers to controller no.)
+
+'phy_type'
+    Select USB phy type: 'utmi' OR 'ulpi'
+
+'dr_mode'
+    Select USB controller mode: 'host', 'peripheral' OR 'otg'
+
+Examples::
+
+    usb1:dr_mode=host;usb2:dr_mode=peripheral'
+
+    usb1:dr_mode=host,phy_type=utmi;usb2:dr_mode=host'
+
+serdes1
+-------
+
+Specific to the LX2160A boards whose reset_phy() calls
+lx2160a_serdes_apply_hwconfig() before mc_env_boot().
+
+SRDS_PRTCL_S1 is latched at reset, but the eight SD1 (SerDes) lanes
+can still be configured before the DPAA2 management complex (MC) starts.
+This option alters the Ethernet MAC-to-lane grouping after the fact
+(RCWSR29 keeps reporting the initial protocol).
+
+'serdes1:2x100g'
+    2x 100GE (CAUI-4), what protocol 13 builds: nothing to do
+
+'serdes1:100g4x25g'
+    1x 100GE + 4x 25G
+
+'serdes1:2x40g'
+    2x 40GE (XLAUI-4), what protocol 20 builds
+
+'serdes1:40g4x10g'
+    1x 40GE + 4x 10G (XFI)
+
+'serdes1:100g4x10g'
+    1x 100GE + 4x 10G (XFI)
+
+Each mode starts from the one in the 'from' column, which is
+entered first when SD1 is not in it yet, and so on down to what
+SRDS_PRTCL_S1 built:
+
+=========  ======  =============  =============
+mode       from    SRDS_PRTCL_S1  lanes run on
+=========  ======  =============  =============
+2x100g     \-      13             PLLF
+100g4x25g  2x100g  13             PLLF
+2x40g      2x100g  13 or 20       PLLS
+40g4x10g   2x40g   13 or 20       PLLS
+100g4x10g  2x100g  13             PLLF and PLLS
+=========  ======  =============  =============
+
+Active DPMACs for each mode:
+
+=========  =======  =======  ===================
+mode       dpmac.1  dpmac.2  dpmac.3 ... dpmac.6
+=========  =======  =======  ===================
+2x100g     100GE    100GE    \-
+100g4x25g  \-       100GE    4x 25G
+2x40g      40GE     40GE     \-
+40g4x10g   \-       40GE     4x XFI
+100g4x10g  \-       100GE    4x XFI
+=========  =======  =======  ===================
+
+A mode name lists its ports from lane A to lane H: in 100g4x25g,
+dpmac.2 is 100GE on lanes A-D, and dpmac.3 to dpmac.6 are 25G on
+lanes E-H. The SRDS_PRTCL_S1 table of the reference manual lists
+the lanes from H to A, so its rows read right to left against the
+mode names.
+
+Initial conditions:
+
+- PLLS needs a 161.1328125 MHz reference clock, for which 2x40g,
+  40g4x10g and 100g4x10g program it. It can come from the SD1
+  PLLS reference clock input, or from the PLLF one with
+  SRDS_INTRA_REF_CLK_S1=1. A 156.25 MHz PLLS reference clock is
+  not supported. With protocol 13 PLLS is not in use, so nothing
+  checks that clock before these modes start it.
+- The MC DPC must set follow_hw_pssr in board_info/serdes, for the
+  MC to read the lanes rather than look at protocol, and the DPL
+  must use the dpmacs of the new grouping.
+
+'lx2160_serdes status 1' shows the resulting lane grouping and
+protocol converters.
+
+Example::
+
+    setenv hwconfig serdes1:100g4x25g
+    saveenv
+    reset
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index cf97d0089d6..4458ee0fd87 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -6,6 +6,7 @@ NXP Semiconductors
 .. toctree::
    :maxdepth: 2
 
+   hwconfig
    imx8mm_evk
    imx8mn_evk
    imx8mp_evk
-- 
2.43.0

