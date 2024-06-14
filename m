Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86474C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFAB88A42;
	Fri, 14 Jun 2024 18:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MYRsEgy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F2D88A63; Fri, 14 Jun 2024 18:36:12 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5243C88A2E
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EGZsRF008061;
 Fri, 14 Jun 2024 11:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718382954;
 bh=AJ/v3mo8Ib2p384cyn6Sz579i3xfhZCakcL2ZT+j8T4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=MYRsEgy135ogD0gKzrwNRQ6KVlCOQVy0t5InXT/yoJ9Gl85x8PGpVQGQRXd9RyNpg
 EHtJUt/QQ/ceEkPJNScjR1B6GxafGdk2aXyXdI2I2cTcyuHp9z2NGmUEZWhjRUZsxE
 L0a4df2oFkBkoqFumZxgzlF5VlIQrZ3SY7Z2dfVM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EGZsEf076555
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 11:35:54 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 11:35:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 11:35:53 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EGZr3V124090;
 Fri, 14 Jun 2024 11:35:53 -0500
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
Subject: [PATCH v7 02/24] doc: ti: k3: Correct spelling mistakes and improve
 clarity
Date: Fri, 14 Jun 2024 11:35:29 -0500
Message-ID: <20240614163551.2610212-3-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614163551.2610212-1-j-humphreys@ti.com>
References: <20240614163551.2610212-1-j-humphreys@ti.com>
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

Few cosmetic fixes for clarity and spelling mistakes.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 doc/board/ti/k3.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index a1c01d1cf02..927f3976d34 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -51,14 +51,14 @@ For all K3 SoCs the first core started will be inside the Security
 Management Subsystem (SMS) which will secure the device and start a core
 in the wakeup domain to run the ROM code. ROM will then initialize the
 boot media needed to load the binaries packaged inside `tiboot3.bin`,
-including a 32bit U-Boot SPL, (called the wakup SPL) that ROM will jump
+including a 32bit U-Boot SPL, (called the wakeup SPL) that ROM will jump
 to after it has finished loading everything into internal SRAM.
 
 .. image:: img/boot_flow_01.svg
   :alt: Boot flow up to wakeup domain SPL
 
 The wakeup SPL, running on a wakeup domain core, will initialize DDR and
-any peripherals needed load the larger binaries inside the `tispl.bin`
+any peripherals needed to load the larger binaries inside the `tispl.bin`
 into DDR.  Once loaded the wakeup SPL will start one of the 'big'
 application cores inside the main domain to initialize the main domain,
 starting with Trusted Firmware-A (TF-A), before moving on to start
@@ -94,7 +94,7 @@ essentially 4 unique but very similar flows:
 * Combined binary with a split firmware: (eg: AM62)
 
 For devices that utilize the split binary approach, ROM is not capable
-of loading the firmware into the SoC requiring the wakeup domain's
+of loading the firmware into the SoC, requiring the wakeup domain's
 U-Boot SPL to load the firmware.
 
 Devices with a split firmware will have two firmwares loaded into the
@@ -114,8 +114,8 @@ K3 HS-SE (High Security - Security Enforced) devices enforce an
 authenticated boot flow for secure boot. HS-FS (High Security - Field
 Securable) is the state of a K3 device before it has been eFused with
 customer security keys.  In the HS-FS state the authentication still can
-function as in HS-SE but as there are no customer keys to verify the
-signatures against the authentication will pass for certificates signed
+function as in HS-SE, but as there are no customer keys to verify the
+signatures against, the authentication will pass for certificates signed
 with any key.
 
 Chain of trust
-- 
2.34.1

