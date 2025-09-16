Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCDFCAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 10:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A989983287;
	Tue, 16 Sep 2025 12:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RPTQxpwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FDE8803CC; Tue, 16 Sep 2025 12:59:08 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDCDF80325
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 12:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GAx0hW1258823;
 Tue, 16 Sep 2025 05:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758020340;
 bh=UQC+pKLrtc18uDsfZDWj6bHc6SzBQqw1RTB0wGoG8cY=;
 h=From:To:CC:Subject:Date;
 b=RPTQxpwaiH5O/D0TmeuCxD9cvo6sBD2sud/xgR6a7eWDtMpemUka6Js6VJRVXJdtC
 hV2K2unk4ilvK2HtIPXsbi5E61q9aanW42uh4hSWpa9GGc8yDgkVMQYQmsIHexow5t
 tz8LGKmMRPIOtlfc8yitoC/6TO3lrXmOIi/4NQeI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GAx0NU4108244
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 05:59:00 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 05:58:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 05:58:59 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GAwvxk1202848;
 Tue, 16 Sep 2025 05:58:58 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v1 0/8] Add support for secure falcon mode: disable fallback
Date: Tue, 16 Sep 2025 16:28:48 +0530
Message-ID: <20250916105857.163951-1-anshuld@ti.com>
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

			if (CONFIG_IS_ENABLED(OS_BOOT_SECURE)) {
				printf("Falcon mode failed, no fallback allowed!\n");
				return ret;
			}

			printf("Falcon mode failed, falling back to default\n");
		}

		/* Regular boot flow */
	}

Regards,
Anshul

[1]: https://lore.kernel.org/u-boot/20250916103542.104773-1-anshuld@ti.com/
Depends-on: https://lore.kernel.org/u-boot/20250916103542.104773-1-anshuld@ti.com/

---
Anshul Dalal (8):
  spl: Kconfig: add SPL_OS_BOOT_SECURE config symbol
  spl: Kconfig: allow K3 devices to use falcon mode
  spl: mmc: split spl_mmc_do_fs_boot into regular/os_boot
  spl: ubi: refactor spl_ubi_load_image for falcon mode
  spl: spi: refactor spl_spi_load_image for falcon mode
  spl: nor: refactor spl_nor_load_image for falcon mode
  spl: nand: refactor spl_nand_load_image for falcon mode
  spl: falcon: disable fallback to U-Boot on failure

 common/spl/Kconfig    |  10 +++-
 common/spl/spl_mmc.c  |  84 ++++++++++++++++++++++------------
 common/spl/spl_nand.c |  95 +++++++++++++++++++++-----------------
 common/spl/spl_nor.c  | 104 ++++++++++++++++++++++++------------------
 common/spl/spl_spi.c  |  33 +++++++++++---
 common/spl/spl_ubi.c  |  46 ++++++++++++++-----
 6 files changed, 235 insertions(+), 137 deletions(-)

-- 
2.51.0

