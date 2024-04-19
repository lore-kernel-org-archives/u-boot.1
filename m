Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F126C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 20:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0ABB88746;
	Fri, 19 Apr 2024 22:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DJuBXslU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6023A88553; Fri, 19 Apr 2024 22:58:02 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E658862B
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 22:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvkVP120839;
 Fri, 19 Apr 2024 15:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713560266;
 bh=gwgwBopHqMT3bGO56n7NZwarJ/nLtUNf0mXdDo94aJ4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=DJuBXslUdj4wEKwMVqHprq8lwhFl27xsTG5qHmCu6NKgKjLcaCccsZGwz76WzjajR
 vv7gBfeLDevE/FMD41WoHvpOrofZwu84tRLDU5BdXE7YxMn0XO5hvEbK2mReroiPVO
 Qux/j9Z+C0/H6YrurG8x54I+c9LZNbABX8zOJSUw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JKvjOB093699
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 15:57:45 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 15:57:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 15:57:45 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvjHj091800;
 Fri, 19 Apr 2024 15:57:45 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v3 17/19] doc: board: ti: am62x: document OSPI layout
Date: Fri, 19 Apr 2024 15:56:59 -0500
Message-ID: <20240419205701.163821-18-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419205701.163821-1-j-humphreys@ti.com>
References: <20240419205701.163821-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 doc/board/ti/am62x_sk.rst | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index b12dc85f06b..bf7ea754e32 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -150,6 +150,54 @@ Image formats:
 .. image:: img/dm_tispl.bin.svg
   :alt: tispl.bin image format
 
+OSPI:
+-----
+ROM supports booting from OSPI from offset 0x0.
+
+Flashing images to OSPI:
+
+Below commands can be used to download tiboot3.bin, tispl.bin, and u-boot.img,
+over tftp and then flash those to OSPI at their respective addresses.
+
+.. prompt:: bash =>
+
+  sf probe
+  tftp ${loadaddr} tiboot3.bin
+  sf update $loadaddr 0x0 $filesize
+  tftp ${loadaddr} tispl.bin
+  sf update $loadaddr 0x80000 $filesize
+  tftp ${loadaddr} u-boot.img
+  sf update $loadaddr 0x280000 $filesize
+
+Flash layout for OSPI:
+
+    .. code-block:: console
+
+             0x0 +----------------------------+
+                 |     ospi.tiboot3(512k)     |
+                 |                            |
+         0x80000 +----------------------------+
+                 |     ospi.tispl(2m)         |
+                 |                            |
+        0x280000 +----------------------------+
+                 |     ospi.u-boot(4m)        |
+                 |                            |
+        0x680000 +----------------------------+
+                 |     ospi.env(128k)         |
+                 |                            |
+        0x6c0000 +----------------------------+
+                 |   ospi.env.backup(128k)    |
+                 |                            |
+        0x740000 +----------------------------+
+                 |      padding (768k)        |
+        0x800000 +----------------------------+
+                 |     ospi.rootfs(ubifs)     |
+                 |                            |
+       0x3fc0000 +----------------------------+
+                 |   ospi.phypattern (256k)   |
+                 |                            |
+                 +----------------------------+
+
 A53 SPL DDR Memory Layout
 -------------------------
 
-- 
2.34.1

