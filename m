Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B785D6EC04
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD7E8922D;
	Fri, 29 Nov 2024 13:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yI7Dog0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F90893EB; Fri, 29 Nov 2024 12:32:03 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F6389392
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVgoa083508;
 Fri, 29 Nov 2024 05:31:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732879902;
 bh=d3VqzlFzIrgcjZTCQcA/BndwSfNUNMnKM1oZLLwyIyY=;
 h=From:To:CC:Subject:Date;
 b=yI7Dog0g6RHkICwyZaYyGnSHQSGTBhJfjXxH+EPv7KAsqlThZT9YkIDR4TZ9QH4um
 ouKoFiVW4NBRm4j3eCj21Lq1mnU+Z2k8S5jjDzakgAHW6rLKYceHmxgtdfTBhQYag0
 zrGzF5tUdoPftp0dmDWWrjjGZtd0hlBfvShXAHOU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATBVgaa030146
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Nov 2024 05:31:42 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 05:31:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 05:31:41 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVabN106135;
 Fri, 29 Nov 2024 05:31:37 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <a-dutta@ti.com>, <sjg@chromium.org>,
 <marex@denx.de>, <jonas@kwiboo.se>, <kever.yang@rock-chips.com>,
 <william.zhang@broadcom.com>, <a-limaye@ti.com>, <u-kumar1@ti.com>,
 <vaishnav.a@ti.com>, <sumit.garg@linaro.org>,
 <quentin.schulz@cherry.de>, <p-mantena@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <nm@ti.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 0/8] Hyperflash Boot fixes for J7200/J721E
Date: Fri, 29 Nov 2024 17:01:28 +0530
Message-ID: <20241129113136.383277-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 29 Nov 2024 13:45:54 +0100
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

Hi All,
In u-boot, hbmc is broken and has been removed from j7200
configs. This series re-enables the hbmc driver and introduces a series
of hyperflash boot fixes. At present, in u-boot, the parent device (fss)
gets registered as a syscon device. This is done because the MMIO
mux driver in u-boot did not support the mux functionality when the
parent device is not a syscon. In this series, we make relevant changes
in the hbmc driver as well as dts' so that we can use the reg-mux driver for
selecting the appropriate state of the mux.

Test logs:

1) j721e-idk-gw hyperflash boot test: https://gist.github.com/anuragdutta731/50aae6fec707a3ffad6d985de6757fe4
2) j7200-evm hyperflash boot test: https://gist.github.com/anuragdutta731/c3a4d60f8bfd9c425d6c44b36eb7322b 

Anurag Dutta (3):
  mux: Makefile: Add config for mux drivers
  mtd: HBMC-AM654: Changed syscon API to mux APIs
  mtd: Kconfig: Change HBMC driver's dependency to MULTIPLEXER and
    MUX_MMIO

Aswath Govindraju (1):
  include: configs: j721e_evm: Increase memory offset for tiboot3.bin in
    HyperFlash

Vaishnav Achath (4):
  arm: dts: k3-j7200-r5-common: Add HBMC overrides for R5 SPL
  arm: dts: k3-j721e-r5-common: Add HBMC overrides for R5 SPL
  configs: j721e_evm_*_defconfig: Add configs for Hyperflash boot
  configs: j7200_evm_*_defconfig: Add configs for Hyperflash boot

 arch/arm/dts/k3-j7200-r5-common-proc-board.dts |  7 +++++++
 arch/arm/dts/k3-j721e-r5-common-proc-board.dts |  7 +++++++
 configs/j7200_evm_a72_defconfig                |  4 +++-
 configs/j7200_evm_r5_defconfig                 |  4 ++++
 configs/j721e_evm_a72_defconfig                |  4 +++-
 configs/j721e_evm_r5_defconfig                 |  4 ++++
 drivers/Makefile                               |  1 +
 drivers/mtd/Kconfig                            |  2 +-
 drivers/mtd/hbmc-am654.c                       | 10 +++++++---
 include/configs/j721e_evm.h                    |  9 ++++++---
 10 files changed, 43 insertions(+), 9 deletions(-)

-- 
2.34.1

