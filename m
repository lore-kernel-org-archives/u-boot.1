Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D655EE8FDAC
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 19:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EFFF83AAD;
	Fri, 26 Dec 2025 20:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="dEZHqimv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C43A83AAE; Fri, 26 Dec 2025 20:34:43 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D52D83A8D
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 20:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1766777492;
 bh=8vwWv2sMtSR5AGae6hcomUZKVmYLHHMdmfBJ/5M5BTg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dEZHqimv+HNCMMaGlGFDWgso3t+MmKNzR1vAFgZcJX5iLShpfez+WttBlA91C/I7M
 Fvvr3iKLu/qe879huO9V3XODpJsqDQ3WkcaaU73UufivlsKYagX4YTKV2dkplDYlIO
 NwojcShe9YaFtnE3BcBpLgF8O02/Ki4HsPbK0T7MV5uQW3BEict6YqQrmf0/7YTxKb
 CIfY7Cm4Y+EWB8wVGBDxvOAwQUltZDgarKd1C05B9WaEr6kRCjtN861YJtGyN9ukYW
 j9qTScJvezDT5DU/3Kxy2v2yEQnMl0Fvt2Zjh+M3GELozFNvCyiXLpUv1DJ4zHP1uS
 AZPFZotVpkt6A==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BA2C4B22155F;
 Fri, 26 Dec 2025 20:31:30 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2 5/5] doc: board: starfive: Add Xunlong OrangePi RV
Date: Fri, 26 Dec 2025 11:30:06 -0800
Message-ID: <20251226193034.181659-6-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251226193034.181659-1-e@freeshell.de>
References: <20251226193034.181659-1-e@freeshell.de>
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

OrangePi RV is a board that uses the same EEPROM product serial identifier
as the StarFive VisionFive 2 1.3b.

In fact it is not completely compatible with the StarFive VisionFive 2
1.3b for use with Linux Kernel however it is good enough for use with
U-Boot SPL and U-Boot Main. Describe how to set the devicetree search path
and, for advanced users, suggest that it is possible to update the EEPROM
data with an invented "XOPIRV" identifier for automatic board detection.

Signed-off-by: E Shattow <e@freeshell.de>
---
 doc/board/starfive/index.rst       |  1 +
 doc/board/starfive/orangepi_rv.rst | 35 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 doc/board/starfive/orangepi_rv.rst

diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index f85d7376b44..0996e0a68aa 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -10,5 +10,6 @@ StarFive
    milk-v_mars
    milkv_marscm_emmc
    milkv_marscm_lite
+   orangepi_rv
    pine64_star64
    visionfive2
diff --git a/doc/board/starfive/orangepi_rv.rst b/doc/board/starfive/orangepi_rv.rst
new file mode 100644
index 00000000000..29cc58a1e2b
--- /dev/null
+++ b/doc/board/starfive/orangepi_rv.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Xunlong OrangePi RV
+===================
+
+U-Boot for the OrangePi RV uses the same U-Boot binaries as the VisionFive 2
+board. In U-Boot SPL the actual board is detected as a VisionFive2 1.3b due to
+a manufacturer problem and having the same EEPROM data as VisionFive2 1.3b.
+
+Device-tree selection
+---------------------
+
+U-Boot will set variable $fdtfile to starfive/jh7110-starfive-visionfive-2-v1.3b.dtb
+
+This is sufficient for U-Boot however fails to work correctly with the Linux Kernel.
+
+To overrule this selection the variable can be set manually and saved in the
+environment
+
+::
+
+    env set fdtfile starfive/jh7110-orangepi-rv.dtb
+    env save
+
+EEPROM modification
+-------------------
+
+For advanced users and developers an EEPROM identifier product serial number
+beginning with "XOPIRV" will match the OrangePi RV and automatically set the
+correct device-tree at U-Boot SPL phase. The procedure for writing EEPROM data
+is not detailed here however is similar to that of the Pine64 Star64 and Milk-V
+Mars CM. The write-protect disable pads on the Orange Pi RV circuit board
+bottom are labeled WP and GND near the M.2 connector.
+
+.. include:: jh7110_common.rst
-- 
2.50.0

