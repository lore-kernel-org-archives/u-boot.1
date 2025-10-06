Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649FDCCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 10:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D73BC8361E;
	Mon,  6 Oct 2025 12:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RO/m/De7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DEE8361E; Mon,  6 Oct 2025 12:11:08 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD31282E34
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 12:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596AB1sY3977139;
 Mon, 6 Oct 2025 05:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759745461;
 bh=GSdgNLs4WiKyW/9blI9OHa4wMeFK8CcqcruCr4zwiok=;
 h=From:To:CC:Subject:Date;
 b=RO/m/De7APSBzwT6De8EDTzup675XpjABUSEEJ63Ko0mnoWepdtXKI5yCFBw/55ai
 vJutVHs/n/WyhjIQ1XQV1ITFJQFXr/hrebm60pMJ7mxUWwgdTeKjOwtdbbm5uqsKq3
 e3PMS334PA9lrD7zc7zXctPlHsXMTRUpkOxY0DD0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596AB1WE4044589
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 6 Oct 2025 05:11:01 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 6
 Oct 2025 05:11:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 05:11:00 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596AAx9T3268452;
 Mon, 6 Oct 2025 05:11:00 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH -next v3 0/7] Add support for secure falcon mode: disable
 fallback
Date: Mon, 6 Oct 2025 15:40:48 +0530
Message-ID: <20251006101057.4172248-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
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

Hi all,

Continuing from the last series[1], this patch series addresses the requirement
of allowing no fallbacks in secure falcon mode.

To do this in a clean way, all the falcon mode logic for each boot media was
refactored to a corresponding *_load_image_os function whereas the regular
boot is implemented in *_load_image, this allows us to easily return early in
case the *_load_image_os function fails with secure mode enabled.

The series also introduces the new SPL_OS_BOOT_SECURE config symbol which
enables secure falcon boot flow.

The generic flow after the patch series looks as follows:

	static int spl_<bootmedia>_load_image(...) {
		if (CONFIG_IS_ENABLED(OS_BOOT)) {

			ret = spl_<bootmedia>_load_image_os(...);

			puts("Failcon mode failed\n");
			if (CONFIG_IS_ENABLED(OS_BOOT_SECURE)) {
				puts("no fallback allowed!\n");
				return ret;
			}

			puts("Falling back to U-Boot\n");
		}

		/* Regular boot flow */
	}

Regards,
Anshul

[1]: https://lore.kernel.org/u-boot/20250923124639.667718-1-anshuld@ti.com/
Depends-on: https://lore.kernel.org/u-boot/20250923124639.667718-1-anshuld@ti.com/
---
Changes in v3:
 - Remove the patch enabling SPL_OS_BOOT for TI_SECURE_DEVICE
v2: https://lore.kernel.org/u-boot/20250923130901.705124-1-anshuld@ti.com/

Changes in v2:
 - Remove extra printf to address SPL size concerns
v1: https://lore.kernel.org/u-boot/20250916105857.163951-1-anshuld@ti.com/
---

Anshul Dalal (7):
  spl: Kconfig: add SPL_OS_BOOT_SECURE config symbol
  spl: mmc: split spl_mmc_do_fs_boot into regular/os_boot
  spl: ubi: refactor spl_ubi_load_image for falcon mode
  spl: spi: refactor spl_spi_load_image for falcon mode
  spl: nor: refactor spl_nor_load_image for falcon mode
  spl: nand: refactor spl_nand_load_image for falcon mode
  spl: falcon: disable fallback to U-Boot on failure

 common/spl/Kconfig    |   8 ++++
 common/spl/spl_mmc.c  |  84 ++++++++++++++++++++++------------
 common/spl/spl_nand.c |  95 +++++++++++++++++++++-----------------
 common/spl/spl_nor.c  | 104 ++++++++++++++++++++++++------------------
 common/spl/spl_spi.c  |  33 +++++++++++---
 common/spl/spl_ubi.c  |  46 ++++++++++++++-----
 6 files changed, 234 insertions(+), 136 deletions(-)

-- 
2.51.0

