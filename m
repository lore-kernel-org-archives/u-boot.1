Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72998C369D3
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3CF082A25;
	Fri, 25 Apr 2025 19:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oc2jZOqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7AB82958; Fri, 25 Apr 2025 19:31:33 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A56A5829C7
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PHVNIv2214117
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 12:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745602283;
 bh=pSBGUHObFshtpJkha9qWVKHqYPeEBltw69H3+XEox78=;
 h=From:To:CC:Subject:Date;
 b=oc2jZOqMFpu4Z9kKN66JiLP7XeNMpJiP9wSSdryBU3kPz0Bk9z9oyjq8zhFZ/KMkO
 lAeyRvbcoeVtTJbYGtjjhHU1Gi/2xraHGqow1JmFrvQlsm/4CwPu/u3Ml7IcUUAbZr
 LnL/TzBxFOwt6lEg4C3qIpdevRS43L5hLW69qr14=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PHVNXr079499
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 12:31:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 12:31:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 12:31:23 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PHVNRU120209;
 Fri, 25 Apr 2025 12:31:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/9] board: beagle: beagley-ai: Cleanups and stdboot
Date: Fri, 25 Apr 2025 12:31:10 -0500
Message-ID: <20250425173120.141503-1-nm@ti.com>
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

Spin 3 of the series.
Just happened to get a BeagleY-AI at desk and happened to test master
branch (7dd49a9264a6 drivers: scsi: Add 'erase' support), noticed a few
issues which were rather easy to solve.. so, here we go:

Current series is based off:
master 9d3f1ebaf875 ("tools/make_pip: Use venv when invoking pip")

BootLog: https://gist.github.com/nmenon/d5d761371515ce0e9cc77021533c34d7
  (nothing interesting changed, so same bootlog)

Changes since v2:
- Dropped override of dfu_alt_info.

V2: https://lore.kernel.org/all/20250418193943.953952-1-nm@ti.com/
V1: https://lore.kernel.org/all/20250411225717.3117370-1-nm@ti.com/

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
 board/beagle/beagley-ai/beagley-ai.env       |   6 +-
 configs/am67a_beagley_ai_a53_defconfig       | 165 ++++++++++---
 configs/am67a_beagley_ai_r5_defconfig        | 109 ++++++++-
 doc/board/beagle/am67a_beagley_ai.rst        | 244 +++++++++++++++++++
 doc/board/beagle/index.rst                   |   1 +
 doc/board/ti/k3.rst                          |   1 +
 8 files changed, 493 insertions(+), 41 deletions(-)
 create mode 100644 doc/board/beagle/am67a_beagley_ai.rst

-- 
2.47.0

