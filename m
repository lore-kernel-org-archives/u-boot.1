Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C38C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E6F587F10;
	Mon, 26 Feb 2024 22:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="gc/KZaW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359E387DF9; Mon, 26 Feb 2024 18:48:48 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B1887EE8
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1ref5k-0000bf-Rq; Mon, 26 Feb 2024 12:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=q+zC4gFj34XyykrwDfq1J2WmDXgqa2VGVEOhN6yi3Hc=; b=gc/KZaW2pTVfKQ
 iulC3VHDF3U5ERX6ffTXr+msjLb+us970jpJatCtIFg1HeCbNk+qbuUnvyQewEdkQI3HPG/PdzSpR
 IJl6Tj6Un0y+UhnONubEKyrvH4KFl7dGlfO/hgi76Uei9zpD8v9IStfL9iMuRjm2yV3By8cs8bIGF
 SOj5Cvgpvuoyf82xpUo82gnaXS0O75hJ/iGSYt5dmTwnnyNF6xrpnMtMLINnWtc6EO8VBSsrh1kmc
 6ocNR23vzlm7UKcsBT7lbmERq7+Kdv1VlBY++BgCvhorFzNcFBFQxxYiBChtfywpOuWV7JOvRjn0K
 9+MnX74TkmCyOzzlxWSw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH] imx9: Update to mx93 A1 chip revision.
Date: Mon, 26 Feb 2024 18:48:34 +0100
Message-ID: <20240226174834.29661-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Feb 2024 22:46:51 +0100
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

Use the latest, mx93a1-ahab-container.img that is compatible with the
i.MX93 A1 revision.

Using mx93a1-ahab-container.img on an A0 chip and conversely causes a boot
failure without any traces on the UART.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm/mach-imx/imx9/imximage.cfg       | 2 +-
 doc/board/nxp/imx93_11x11_evk.rst         | 8 ++++----
 doc/board/phytec/imx93-phyboard-segin.rst | 8 ++++----
 doc/board/variscite/imx93_var_som.rst     | 8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/imximage.cfg b/arch/arm/mach-imx/imx9/imximage.cfg
index 3e440465b23..d327d6a6ef4 100644
--- a/arch/arm/mach-imx/imx9/imximage.cfg
+++ b/arch/arm/mach-imx/imx9/imximage.cfg
@@ -5,6 +5,6 @@
 
 BOOT_FROM SD 0x400
 SOC_TYPE IMX9
-APPEND mx93a0-ahab-container.img
+APPEND mx93a1-ahab-container.img
 CONTAINER
 IMAGE A55 u-boot-spl-ddr.bin 0x2049A000
\ No newline at end of file
diff --git a/doc/board/nxp/imx93_11x11_evk.rst b/doc/board/nxp/imx93_11x11_evk.rst
index fb0ecf8af58..171645ad06c 100644
--- a/doc/board/nxp/imx93_11x11_evk.rst
+++ b/doc/board/nxp/imx93_11x11_evk.rst
@@ -42,10 +42,10 @@ Get ahab-container.img
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.10.bin
-   $ chmod +x firmware-sentinel-0.10.bin
-   $ ./firmware-sentinel-0.10.bin
-   $ cp firmware-sentinel-0.10/mx93a0-ahab-container.img $(srctree)
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.11.bin
+   $ chmod +x firmware-sentinel-0.11.bin
+   $ ./firmware-sentinel-0.11.bin
+   $ cp firmware-sentinel-0.11/mx93a1-ahab-container.img $(srctree)
 
 Build U-Boot
 ------------
diff --git a/doc/board/phytec/imx93-phyboard-segin.rst b/doc/board/phytec/imx93-phyboard-segin.rst
index da8772ecd5c..ce17fbec78d 100644
--- a/doc/board/phytec/imx93-phyboard-segin.rst
+++ b/doc/board/phytec/imx93-phyboard-segin.rst
@@ -41,10 +41,10 @@ Get ahab-container.img
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.10.bin
-   $ chmod +x firmware-sentinel-0.10.bin
-   $ ./firmware-sentinel-0.10.bin
-   $ cp firmware-sentinel-0.10/mx93a0-ahab-container.img $(srctree)
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.11.bin
+   $ chmod +x firmware-sentinel-0.11.bin
+   $ ./firmware-sentinel-0.11.bin
+   $ cp firmware-sentinel-0.11/mx93a1-ahab-container.img $(srctree)
 
 Build U-Boot
 ------------
diff --git a/doc/board/variscite/imx93_var_som.rst b/doc/board/variscite/imx93_var_som.rst
index 4951afd2dad..02309f2ad87 100644
--- a/doc/board/variscite/imx93_var_som.rst
+++ b/doc/board/variscite/imx93_var_som.rst
@@ -42,10 +42,10 @@ Get ahab-container.img
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.10.bin
-   $ chmod +x firmware-sentinel-0.10.bin
-   $ ./firmware-sentinel-0.10.bin
-   $ cp firmware-sentinel-0.10/mx93a0-ahab-container.img $(srctree)
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.11.bin
+   $ chmod +x firmware-sentinel-0.11.bin
+   $ ./firmware-sentinel-0.11.bin
+   $ cp firmware-sentinel-0.11/mx93a1-ahab-container.img $(srctree)
 
 Build U-Boot
 ------------
-- 
2.41.0

