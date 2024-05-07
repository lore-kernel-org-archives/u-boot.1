Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9928EC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 15:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C21C688798;
	Tue,  7 May 2024 17:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="s0Qpi61K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FCD188798; Tue,  7 May 2024 17:18:09 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED19883AA
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 17:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1715095086; x=1717687086;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cbc9JCf27XzaF3Ur0zJRxL0l62XqBDdmlJqSApTM4h8=;
 b=s0Qpi61KtVfwPQXRwE+DmH5jlfuoX5ut6Ma+RB4OMrT8hKyb9vOCSShn42b01aGH
 VGj0qf39jBaYPVDfZJ3nZO3P4eeKq/QAeyl77nFl+FbtdfU86uOZNOuJF3DgTZfX
 QXynOBm4x5HqeCnmHqA+Mn8iECO7/R5VplZVjGsVe+E=;
X-AuditID: ac14000a-fbefe7000000290d-9c-663a462d295d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 56.49.10509.D264A366;
 Tue,  7 May 2024 17:18:05 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 7 May 2024
 17:18:05 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <nm@ti.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <t.remmet@phytec.de>, <d.schultz@phytec.de>, <festevam@gmail.com>,
 <mkorpershoek@baylibre.com>, <joao.goncalves@toradex.com>, <n-jain1@ti.com>,
 <michael@amarulasolutions.com>, <d-gole@ti.com>, <sjg@chromium.org>,
 <clamor95@gmail.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <jma@phytec.com>
Subject: [PATCH 0/5] *** phyCORE-AM62x: DDR detection / Inject DDR timing
 deltas ***
Date: Tue, 7 May 2024 17:17:52 +0200
Message-ID: <20240507151757.1202825-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42JZI8nAo6vrZpVmsOiAscX7UxPZLea+OcBq
 caC/l9GiZa2HxcOr/hbPOpuYLS7fv8lqcelBqsWpxlYWixfH5rJb9P9/zmTx5sdZJotvW7Yx
 WkydtJnd4u3eTnaL7nfqDgIeaz/eZ/V4f6OV3WN2w0UWj52z7rJ7vDqwit3j7J0djB793S2s
 Hn8uvmP1OH5jO5PHplceAVxRXDYpqTmZZalF+nYJXBm9tw4xFnznrVixZiNTA+N7ri5GTg4J
 AROJ9zefs4PYQgJLmCR2rArqYuQCsh8xShw6fowRJMEmoC5xZ8M3VhBbRMBMYtHa82wgRcwC
 75gk1h+eAuRwcAgLhEhc/asKUsMioCIxb/9MZhCbV8BSoqFzNyPEMnmJmZe+s0PEBSVOznzC
 AmIzA8Wbt85mhrAlJA6+eMEMcZC8xItLy1lgeqede80MYYdKHNm0mmkCo8AsJKNmIRk1C8mo
 BYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGCYkyEgWsHY98cj0OMTByMhxglOJiVRHiPtpun
 CfGmJFZWpRblxxeV5qQWH2KU5mBREudd3RGcKiSQnliSmp2aWpBaBJNl4uCUamCUfsZ5d5d0
 2BKBu70xa8uVOVtN5v25/sb95DSmHRHfp0p177FrV/WakHWt78jF6TKpBWHren999xET3fGG
 o2LSAbVLu21DGOd/TZO7ZbB0zeT4j5XTzONlnxpLu/WJ3S0tqzLboL86dCVnvnXIX+P09u3l
 CvOeBXwsipy6XFxoyWz1wz/Z4w8psRRnJBpqMRcVJwIAZTPaxZ8CAAA=
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

PHYTEC stores details about the hardware in an EEPROM on the SoM. We can
utilize this information and chose the proper DDR timings accordingly.

Due to the limited SRAM memory on the AM62x, the concept was to store
only the DDR timings deltas and not their full set, see Patch 4 & 5.

The last patch adds support for a 1 GB and 4 GB RAM variant of the
phyCORE-AM62x.

Patch 4 & 5 are based on
https://patchwork.ozlabs.org/project/uboot/list/?series=404273

Wadim Egorov (5):
  board: phytec: Make AM6 SoM detection depend on I2C
  board: phytec: Fix function definitions in AM6x SOM detection
  arm: mach-k3: am625: Call do_board_detect() before DDR probing
  board: phytec: common: Introduce a method to inject DDR timings deltas
  board: phytec: am62x: Add support for 1 & 4 GB RAM variants

 arch/arm/mach-k3/am625_init.c                 |   2 +
 board/phytec/common/Kconfig                   |   2 +
 board/phytec/common/am6_som_detection.c       |  18 +-
 board/phytec/common/am6_som_detection.h       |   8 +
 board/phytec/common/k3/Makefile               |   1 +
 board/phytec/common/k3/k3_ddrss_patch.c       |  68 ++++++
 board/phytec/common/k3/k3_ddrss_patch.h       |  28 +++
 board/phytec/phycore_am62x/MAINTAINERS        |   1 +
 board/phytec/phycore_am62x/phycore-am62x.c    | 152 ++++++++++++-
 board/phytec/phycore_am62x/phycore-ddr-data.h | 206 ++++++++++++++++++
 configs/phycore_am62x_a53_defconfig           |   4 +
 configs/phycore_am62x_r5_defconfig            |   4 +
 12 files changed, 483 insertions(+), 11 deletions(-)
 create mode 100644 board/phytec/common/k3/k3_ddrss_patch.c
 create mode 100644 board/phytec/common/k3/k3_ddrss_patch.h
 create mode 100644 board/phytec/phycore_am62x/phycore-ddr-data.h

-- 
2.34.1

