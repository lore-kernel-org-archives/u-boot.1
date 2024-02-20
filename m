Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2600BC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA1B88027;
	Tue, 20 Feb 2024 19:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eIbjMTxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967EB87FEE; Tue, 20 Feb 2024 19:40:07 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C6387FF4
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KIdrdl107908;
 Tue, 20 Feb 2024 12:39:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708454393;
 bh=qBFaV0MwO5Mb+KBu4idQ/GgBB0KHzeeAZZnGlPYcin8=;
 h=From:To:CC:Subject:Date;
 b=eIbjMTxw+LMjksfiFvrjxLUiS6FMhfSA5skCOLFwDbcTFJl3vaGKbMF8TF/t20viY
 hibth6eHhz7bnNvX74Ognn/dAlpAme8gYi3bBPJQ+R4FPNbMw1HCGOcLv9KGmBPk//
 XmGh9WzGVs+WXIWlBDd2gtcMQR+DkvSsYHwGC0nk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KIdrkh017470
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Feb 2024 12:39:53 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 12:39:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 12:39:53 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KIdrnx006240;
 Tue, 20 Feb 2024 12:39:53 -0600
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/5] board: beagle: Enable 32k and debounce configuration
 and fixups
Date: Tue, 20 Feb 2024 12:39:47 -0600
Message-ID: <20240220183952.3614252-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
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

Hi,

Rev 2 of the series.

This is a follow up from [1] - Without the 32k crystal configuration,
wlan doesn't work. Debounce is needed for HDMI Hot plug detect(hpd)
gpio interrupt not storming.

At least the 32k configuration has been done for toradex and phytec
boards, follow similar model of programming.

Series is now based off master branch.

Bootlog: https://gist.github.com/nmenon/75df38bee907785d1d78d1ec4abd7304

Changes from V2:
- Removed depedency on [2] - depending on which way
  the merge sequence goes, one of the series will need a rebase.
- Added a patch for a bug that Jan noticed
- Fixup for the fat finger missing 0x in 0x4080 :(

V1: https://lore.kernel.org/all/20240212155332.541949-1-nm@ti.com/

Nishanth Menon :
  board: beagle: beagleplay: Enable 32k crystal
  configs: am62x_beagleplay_r5_defconfig: Enable SPL_BOARD_INIT
  arm: mach-k3: am62: Add Debounce configuration register definitions
  board: beagle: beagleplay: Configure debounce registers
  board: beagle: beagleplay: env: Drop usb and pxe as boot targets

 arch/arm/mach-k3/include/mach/am62_hardware.h |  3 +
 board/beagle/beagleplay/beagleplay.c          | 61 +++++++++++++++++++
 board/beagle/beagleplay/beagleplay.env        |  2 +-
 configs/am62x_beagleplay_r5_defconfig         |  1 +
 4 files changed, 66 insertions(+), 1 deletion(-)

base-commit: 3e6f2a94bfc25f1782ce2d45db27f47ec781feb1

[1] https://lore.kernel.org/u-boot/20230725185253.2123433-4-nm@ti.com/
[2] https://lore.kernel.org/u-boot/20240212194726.1093771-1-nm@ti.com/
-- 
2.43.0
