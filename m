Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E771EC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E85AF88165;
	Tue,  9 Apr 2024 00:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NElryqob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B0088179; Mon,  8 Apr 2024 23:12:20 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1383587EB4
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438LCDqa094168;
 Mon, 8 Apr 2024 16:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712610733;
 bh=9W0+l4l62NJVAbXaSqfNqMrwakrEVeTqcaj3CX6FRXI=;
 h=From:To:CC:Subject:Date;
 b=NElryqobLq5ru3qp3KHaJChFN45ouqfssZW0XDTG8HhMulzg7HVt1b1bGOAfqJjLh
 5jGfLSfKYJrIZCO8DSuXZAwU7hdAeMNbW9IFCCp9rdZ8/gDFQUTZ0VvMuPoE4m8+vp
 NyVMJ4wzngokQNWnMJW/VG1CA/972Lr/Y9D6k9fk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438LCD2c052298
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 16:12:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 16:12:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 16:12:12 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438LCCnx014533;
 Mon, 8 Apr 2024 16:12:12 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Simon Glass <sjg@chromium.org>, Neha Malcom Francis <n-francis@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Andrew Davis <afd@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 00/15] configs: ti: Enable basic settings for SystemReady ACS
Date: Mon, 8 Apr 2024 16:10:45 -0500
Message-ID: <20240408211100.93936-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 00:46:15 +0200
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

Set basic settings needed for System Ready IR ACS testing, for several TI SoC
based platforms: AM64, AM62, AM62p, BeaglePlay, J7, and BeagleboneAI.

For AM64, AM62, and AM62p, also includes some config cleanup.  Should be no
functional change.

Jonathan Humphreys (15):
  configs: am64x: cosmetic config cleanup
  configs: am64x: Enable basic EFI CMD support
  configs: am64x: Enable RTC emulation
  configs: j721e: Enable basic EFI CMD support
  configs: j721e: Enable RTC emulation
  configs: beagleplay: Enable basic EFI CMD support
  configs: beagleplay: Enable RTC emulation
  configs: am62px: cosmetic config cleanup
  configs: am62px: Enable basic EFI CMD support
  configs: am62px: Enable RTC emulation
  configs: am62x: cosmetic config cleanup
  configs: am62x: Enable basic EFI CMD support
  configs: am62x: Enable RTC emulation
  configs: beagleboneai64: Enable basic EFI CMD support
  configs: beagleboneai64: Enable RTC emulation

 configs/am62px_evm_a53_defconfig           | 21 +++++++++++----------
 configs/am62x_beagleplay_a53_defconfig     |  6 ++++++
 configs/am62x_evm_a53_defconfig            | 14 ++++++++++----
 configs/am64x_evm_a53_defconfig            | 16 +++++++++++-----
 configs/j721e_beagleboneai64_a72_defconfig |  6 ++++++
 configs/j721e_evm_a72_defconfig            |  6 ++++++
 6 files changed, 50 insertions(+), 19 deletions(-)

-- 
2.34.1

