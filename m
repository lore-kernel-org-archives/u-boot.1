Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9CBC369AE
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 22:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16552841BC;
	Sat, 12 Apr 2025 00:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NPQD83Jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A1E882B18; Sat, 12 Apr 2025 00:57:28 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5C483F00
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 00:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BMvI4F2198845
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 17:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744412238;
 bh=7Z9U/hADS4RPPIYL1Y92aeYit0Lr744fKPjs9Ay9+Yw=;
 h=From:To:CC:Subject:Date;
 b=NPQD83JdR+LPCezvf9r/OWBUS0v+i8DeAA75l6H08R3EJjUBRwtoeUfSbRw1Bc8Q8
 AWiFjkeW2vaKnfFWP6CD1FEFmBPetjXQKq/E0mZI5nnoKpUoaz5a5SdvbhWYjILKdC
 hmGWN0aWrc6BlNgtnjBT7ksD1Ab7oXyE4qnEmNik=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BMvIZQ036275
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Apr 2025 17:57:18 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 17:57:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 17:57:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BMvH2K108006;
 Fri, 11 Apr 2025 17:57:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/9] board: beagle: beagley-ai: Cleanups and
Date: Fri, 11 Apr 2025 17:57:08 -0500
Message-ID: <20250411225717.3117370-1-nm@ti.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Just happened to get a BeagleY-AI at desk and happened to test master
branch (7dd49a9264a6 drivers: scsi: Add 'erase' support), noticed a few
issues which were rather easy to solve.. so, here we go:

Bootlog: https://gist.github.com/nmenon/a3a18825a783c0c3798cc72506cfead2

I tried to enable efi capsules, but I lost patience rather too soon. So
probably some other time or perhaps someone else would like to contribute.

Nishanth Menon (9):
  board: beagle: beagley-ai: Add pattern match for MAINTAINERS
  arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark main_gpio1 as
    bootph-all
  beagle: beagley-ai: env: Set up the boot devices and boot methods
  beagle: beagley-ai: env: Setup scripts for LED control
  beagle: beagley-ai: env: Enable DFU env options
  configs: am67a_beagley_ai*: Use saveddefconfig
  configs:am67a_beagley_ai*: Drop un-necessary config options
  configs: am67a_beagley_ai_a53: Enable additional features
  doc: beagle: Add BeagleY-AI documentation

 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi |   4 +
 board/beagle/beagley-ai/MAINTAINERS          |   4 +-
 board/beagle/beagley-ai/beagley-ai.env       |   7 +-
 configs/am67a_beagley_ai_a53_defconfig       | 165 +++++++++++---
 configs/am67a_beagley_ai_r5_defconfig        | 109 ++++++++-
 doc/board/beagle/am67a_beagley_ai.rst        | 228 +++++++++++++++++++
 doc/board/beagle/index.rst                   |   1 +
 doc/board/ti/k3.rst                          |   1 +
 8 files changed, 478 insertions(+), 41 deletions(-)
 create mode 100644 doc/board/beagle/am67a_beagley_ai.rst

-- 
2.47.0

