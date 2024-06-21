Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B99C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2838B88405;
	Fri, 21 Jun 2024 22:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oUyVEkwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024C3884FF; Fri, 21 Jun 2024 22:17:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 453CA87B4D
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LKH9It007891;
 Fri, 21 Jun 2024 15:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719001029;
 bh=aehJBBAn51WV6piGK9PyRkVCGpKkYbLdyqwoBWMxKbA=;
 h=From:To:CC:Subject:Date;
 b=oUyVEkwV0DqGbUgKUCFAttIE9I4M1PUY/Bof7GIalBtamu3iqkPnUN7PenymMbZ/A
 nhWcoomzWEXMktRJmzarRMEbTaD535/xP+14ckP55gVNh/jzBtbKqdUhwN+4pLJo5M
 EoJn8GCOTPPxW571xprw8743jv/w4kOMp/rt9gZY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LKH9pJ022259
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Jun 2024 15:17:09 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 15:17:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 15:17:09 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LKH9XM130346;
 Fri, 21 Jun 2024 15:17:09 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH] doc: board: ti: Add capsule documentation for TI K3 devices
Date: Fri, 21 Jun 2024 15:17:06 -0500
Message-ID: <20240621201706.3797019-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
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

Added introductory documentation about capsule support for TI devices,
including links to more detailed information.

Also added a note in the build secction that points to the host package
dependency docs.

This patch is followup from a request in the series introducing capsule
update for TI boards.
https://lore.kernel.org/r/20240618145058.552eapp5iiz772ej@hardcore

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 doc/board/ti/k3.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 76375473185..67b066a07d3 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -204,6 +204,11 @@ online
 Build Procedure
 ---------------
 
+.. note ::
+
+   Make sure you have installed all necessary host package dependencies
+   before proceeding. See :ref:`build/gcc:Building with GCC`.
+
 Depending on the specifics of your device, you will need three or more
 binaries to boot your SoC.
 
@@ -388,6 +393,30 @@ wakeup and main domain and to boot to the U-Boot prompt
    | `tispl.bin` for HS devices or `tispl.bin_unsigned` for GP devices
    | `u-boot.img` for HS devices or `u-boot.img_unsigned` for GP devices
 
+Capsules
+--------
+
+Most K3 boards have support for UEFI capsule update via capsule-on-disk
+functionality. Check the ``CONFIG_EFI_CAPSULE_ON_DISK`` config option for
+the board under question to verify. If configured, capsules for each of the
+binaries above are automatically generated as part of the binary's build.
+They are named `<binary>-capsule.bin`. For example, the capsule for
+`u-boot.img` would be called `uboot-capsule.bin`.
+
+See :ref:`uefi_capsule_update_ref` for more information on U-Boot's support
+for capsule update and how they are applied.
+
+Each board defines the capsules generated, including where those capsules
+are applied. See the ``update_info`` definition for a board, typically
+found at `board/ti/<board>/evm.c`. For example, `board/ti/am62x/evm.c`.
+Usually, if the board has OSPI flash, the capsules will be applied there,
+else the boot partition of the eMMC device.
+
+Once applied, the board will have U-Boot binaries in on-board non-volatile
+storage. To start booting from that storage, set the bootmode pins
+accordingly. Future updates can be performed by using the capsules
+generated from the corresponding U-Boot builds.
+
 FIT signature signing
 ---------------------
 
-- 
2.34.1

