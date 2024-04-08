Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EE4C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE8A882D6;
	Tue,  9 Apr 2024 00:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BSVvANlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AFA188188; Mon,  8 Apr 2024 23:34:21 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5188888151
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438LYCnG097858;
 Mon, 8 Apr 2024 16:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712612052;
 bh=aprhg+lgkteGCayXVDsVQiyuJ7mwGFATR0GLhSsik5U=;
 h=From:To:CC:Subject:Date;
 b=BSVvANlQ653Urr45G9FbAzgGfmCrkGaH8/dFN2JJEnQfxgpFaGjaNhaSGo+nuMlVl
 0uvtPd0AGxqj+nYo2WZNYeUqs+c6GPUe0fS32ozW+8VmsiBBIJAR3btkOK+dGpvkhs
 poqLp5p0u4CnLBBwSlhx5HlDgtJS7wgA4lh4BrwA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438LYC57029442
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 16:34:12 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 16:34:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 16:34:11 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438LYBxi106499;
 Mon, 8 Apr 2024 16:34:11 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Simon Glass <sjg@chromium.org>, Neha Malcom Francis <n-francis@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>, Nikhil M Jain
 <n-jain1@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 00/13] EFI: capsule: ti: enable authenticated capsules
Date: Mon, 8 Apr 2024 16:33:36 -0500
Message-ID: <20240408213349.96610-1-j-humphreys@ti.com>
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

Create an EFI signature list (.esl) file based on the TI dummy key.
Enable capsule authentication for several TI SoC based platforms: AM64, AM62,
AM62p, BeaglePlay, J7, and BeagleboneAI.

Jonathan Humphreys (13):
  ti:keys Add EFI signature list
  configs: am64x: Set capsule update signature list file
  configs: am64x: Enable capsule authentication
  configs: j721e: Set capsule update signature list file
  configs: j721e: Enable capsule authentication
  configs: beagleplay: Set capsule update signature list file
  configs: beagleplay: Enable capsule authentication
  configs: am62px: Set capsule update signature list file
  configs: am62px: Enable capsule authentication
  configs: am62x: Set capsule update signature list file
  configs: am62x: Enable capsule authentication
  configs: beagleboneai64: Set capsule update signature list file
  configs: beagleboneai64: Enable capsule authentication

 arch/arm/mach-k3/keys/custMpk.esl          | Bin 0 -> 1523 bytes
 configs/am62px_evm_a53_defconfig           |   2 ++
 configs/am62x_beagleplay_a53_defconfig     |   2 ++
 configs/am62x_evm_a53_defconfig            |   2 ++
 configs/am64x_evm_a53_defconfig            |   2 ++
 configs/j721e_beagleboneai64_a72_defconfig |   2 ++
 configs/j721e_evm_a72_defconfig            |   2 ++
 7 files changed, 12 insertions(+)
 create mode 100644 arch/arm/mach-k3/keys/custMpk.esl

-- 
2.34.1

