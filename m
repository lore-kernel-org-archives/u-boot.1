Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1897C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 07:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A36E8825A;
	Wed, 22 May 2024 09:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RJQWWzpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E1CC88208; Wed, 22 May 2024 09:55:16 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B01287EED
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716364513; x=1718956513;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n2GxtGBVxQsxwuIyuPYM0v7CeEhmdLEuMU1p35XESuk=;
 b=RJQWWzpRpx8R3jaJ+xagFoN/sEtQ7dOymnfjkKDLiRU22D3zTMlg/RPRt2zyIU6J
 QtEtQ6MX9XWFkAvKH4oR2+qmfaby85tF/4chgB70yRrAcEAW48J3wf5b7EOy4jyp
 hflsSrU239X3HnVedQGHc0cVGirdt9ILQUFckQZ2YNw=;
X-AuditID: ac14000a-03e52700000021bc-ad-664da4e12a16
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D3.F0.08636.1E4AD466;
 Wed, 22 May 2024 09:55:13 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 09:55:13 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <nm@ti.com>, <trini@konsulko.com>, <clamor95@gmail.com>,
 <d.schultz@phytec.de>, <bb@ti.com>, <jma@phytec.com>,
 <mkorpershoek@baylibre.com>, <d-gole@ti.com>, <m-chawdhry@ti.com>,
 <n-jain1@ti.com>, <afd@ti.com>, <joao.goncalves@toradex.com>,
 <michael@amarulasolutions.com>, <festevam@gmail.com>, <sjg@chromium.org>
Subject: [PATCH v2 0/5] *** phyCORE-AM62x: DDR detection / Inject DDR timing
 deltas ***
Date: Wed, 22 May 2024 09:55:00 +0200
Message-ID: <20240522075505.3339347-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42JZI8nAo/twiW+awYYrOhbvT01kt5j75gCr
 xYH+XkaLlrUeFg+v+ls862xitrh8/yarxaUHqRanGltZLF4cm8tu0f//OZPFmx9nmSy+bdnG
 aDF10mZ2i7d7O9ktut+pOwh4rP14n9Xj/Y1Wdo/ZDRdZPHbOusvu8erAKnaPs3d2MHr0d7ew
 evy5+I7V4/iN7Uwem155BHBFcdmkpOZklqUW6dslcGWcnbGSsWANb8WZXQfZGhhXc3UxcnJI
 CJhIbD9/jxHEFhJYwiRx73xiFyMXkP2YUeL5jdNsIAk2AXWJOxu+sYLYIgJmEovWnmcDKWIW
 OMIk8fjUPrBuYYFwiY4n3exdjBwcLAKqEifa+EHCvAKWEi+On2OHWCYvMfPSd3aIuKDEyZlP
 WEBsZqB489bZzBC2hMTBFy+YIQ6Sl3hxaTkLTO+0c6+ZIexQia1ftjNNYBSYhWTULCSjZiEZ
 tYCReRWjUG5mcnZqUWa2XkFGZUlqsl5K6iZGUIyJMHDtYOyb43GIkYmD8RCjBAezkgjvpi2e
 aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRoYZ3wpc27+
 95glNTVqWfIflbZ1bzd/uvb9bOU2l9UPJjJu38AQnvdxdYdYU8du5pSW0HN2E/4Wrzqvdf3t
 JEXJyV+Eyz98uDcrdTvfSbdFrQuD9b3tC654LMtum3pSZLd0gXr5Fak3Pl2FYo3PT5TO37jd
 p+LmsiVmEYlNDtrqVe+vtVvM3+pYrcRSnJFoqMVcVJwIAMMwZymfAgAA
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

Changes in v2:
  - Reabse to current next
  - Add Tested-by: John Ma <jma@phytec.com>
  - Add Kconfig option to select RAM size statically
  - Make board/phytec/common/k3 always compile for CONFIG_ARCH_K3

v1: https://lists.denx.de/pipermail/u-boot/2024-May/553057.html

Wadim Egorov (5):
  board: phytec: Make AM6 SoM detection depend on I2C
  board: phytec: Fix function definitions in AM6x SOM detection
  arm: mach-k3: am625: Call do_board_detect() before DDR probing
  board: phytec: common: Introduce a method to inject DDR timings deltas
  board: phytec: am62x: Add support for 1 & 4 GB RAM variants

 arch/arm/mach-k3/am62x/am625_init.c           |   2 +
 board/phytec/common/Kconfig                   |   2 +
 board/phytec/common/Makefile                  |   4 +-
 board/phytec/common/am6_som_detection.c       |  18 +-
 board/phytec/common/am6_som_detection.h       |   8 +
 board/phytec/common/k3/Makefile               |   1 +
 board/phytec/common/k3/k3_ddrss_patch.c       |  68 ++++++
 board/phytec/common/k3/k3_ddrss_patch.h       |  28 +++
 board/phytec/phycore_am62x/Kconfig            |  30 +++
 board/phytec/phycore_am62x/MAINTAINERS        |   1 +
 board/phytec/phycore_am62x/phycore-am62x.c    | 152 ++++++++++++-
 board/phytec/phycore_am62x/phycore-ddr-data.h | 206 ++++++++++++++++++
 configs/phycore_am62x_a53_defconfig           |   4 +
 configs/phycore_am62x_r5_defconfig            |   4 +
 14 files changed, 514 insertions(+), 14 deletions(-)
 create mode 100644 board/phytec/common/k3/k3_ddrss_patch.c
 create mode 100644 board/phytec/common/k3/k3_ddrss_patch.h
 create mode 100644 board/phytec/phycore_am62x/phycore-ddr-data.h

-- 
2.34.1

