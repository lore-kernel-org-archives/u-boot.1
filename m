Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB3CC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 13:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D9B87DC5;
	Tue, 30 Jan 2024 14:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J6idoR2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 547AF87DAD; Tue, 30 Jan 2024 14:06:35 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF20787BEE
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 14:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6Lhs115501;
 Tue, 30 Jan 2024 07:06:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706619981;
 bh=Y+tqI4eQf+ZfmEvoxogu9bOVAxSNMhwIzdvCMuvtoDk=;
 h=From:To:CC:Subject:Date;
 b=J6idoR2ic2EOyJa1Ibnl8f6Fi28lGg7pOtmNi/QcS0yZinFyBxrq/11lRSGdnUmgj
 NaRcS//Aw2Cg8kCFjeCbQfwjvmMw6ystrmDi8BcvBLupDt5H2yKdlq8dSN7PueECYo
 bUvoBa1TwCFzAmXEZGpfeTqB6n2NFzxvS00ckEO8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UD6LgK023689
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 07:06:21 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 07:06:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 07:06:21 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6LTs121193;
 Tue, 30 Jan 2024 07:06:21 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 00/11] board/ti: k3 boards: Stop using findfdt
Date: Tue, 30 Jan 2024 07:06:04 -0600
Message-ID: <20240130130615.670783-1-nm@ti.com>
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

This is a wide cleanup to switch to setting fdtfile using env_set
instead of scripted magic. 'fdtfile' is expected to be set by default.
This allows the stdboot triggered efi loaders to find the correct OS
device tree file even if regular boot process is interrupted by user
intervention.

Updates from V2:
 * New patch #1 added for older omap platform build breakage (sorry about
   that)

Bootlogs (no change from V1): https://gist.github.com/nmenon/843e343cde645ec4aa57b60cece5256a

based on master 6faba41927bd Prepare v2024.04-rc1

NOTE: There are a couple of checkpatch WARN (around LATE_INIT) and
CHECK (fdt_ops #ifdeffery) that on closer inspection looks fine and
consistent with other similar usage.

V2: https://lore.kernel.org/all/20240109191506.3820908-1-nm@ti.com/
V1: https://lore.kernel.org/all/20240108173301.2692332-1-nm@ti.com/


Nishanth Menon (11):
  board: ti: Add missing common/Kconfig references
  board: ti: common: Introduce a common fdt ops library
  board: ti: am62ax: Set fdtfile from C code instead of findfdt script
  board: ti: am62x: Set fdtfile from C code instead of findfdt script
  board: ti: am64x: Set fdtfile from C code instead of findfdt script
  board: ti: am65x: Set fdtfile from C code instead of findfdt script
  board: ti: j721e: Set fdtfile from C code instead of findfdt script
  board: ti: j721s2: Set fdtfile from C code instead of findfdt script
  board: beagle: beagleboneai64: Set fdtfile from C code instead of
    findfdt script
  board: beagle: beagleplay: Set fdtfile from C code instead of findfdt
    script
  include: env: ti: Drop default_findfdt

 board/beagle/beagleboneai64/beagleboneai64.c  | 14 ++++
 .../beagle/beagleboneai64/beagleboneai64.env  |  1 -
 board/beagle/beagleplay/beagleplay.c          | 14 ++++
 board/beagle/beagleplay/beagleplay.env        |  1 -
 board/ti/am62ax/am62ax.env                    |  1 -
 board/ti/am62ax/evm.c                         | 10 +++
 board/ti/am62x/am62x.env                      |  1 -
 board/ti/am62x/evm.c                          |  8 +++
 board/ti/am64x/am64x.env                      |  9 ---
 board/ti/am64x/evm.c                          |  8 +++
 board/ti/am65x/am65x.env                      |  3 -
 board/ti/am65x/evm.c                          |  2 +
 board/ti/common/Kconfig                       | 12 ++++
 board/ti/common/Makefile                      |  1 +
 board/ti/common/fdt_ops.c                     | 64 +++++++++++++++++++
 board/ti/common/fdt_ops.h                     | 42 ++++++++++++
 board/ti/j721e/evm.c                          |  8 +++
 board/ti/j721e/j721e.env                      | 10 ---
 board/ti/j721s2/evm.c                         |  8 +++
 board/ti/j721s2/j721s2.env                    |  8 ---
 board/ti/omap3evm/Kconfig                     |  2 +
 board/ti/panda/Kconfig                        |  2 +
 board/ti/sdp4430/Kconfig                      |  2 +
 configs/am62ax_evm_a53_defconfig              |  1 +
 configs/am62x_beagleplay_a53_defconfig        |  3 +-
 configs/am62x_evm_a53_defconfig               |  1 +
 configs/j721e_beagleboneai64_a72_defconfig    |  3 +-
 include/env/ti/default_findfdt.env            | 12 ----
 28 files changed, 203 insertions(+), 48 deletions(-)
 create mode 100644 board/ti/common/fdt_ops.c
 create mode 100644 board/ti/common/fdt_ops.h
 delete mode 100644 include/env/ti/default_findfdt.env


base-commit: 6faba41927bdc8973b59678649ef83c564cc421e
-- 
2.43.0

