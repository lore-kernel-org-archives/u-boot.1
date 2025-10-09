Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8ACCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 11:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F03684497;
	Thu,  9 Oct 2025 13:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O/GStfls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B40E844D2; Thu,  9 Oct 2025 13:58:57 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93FAC84459
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 13:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 599BwoH0527505;
 Thu, 9 Oct 2025 06:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760011130;
 bh=vCE4eMCn30KZVXdKbIrHaygNaSSpgmwAizb7lIulYoo=;
 h=From:To:CC:Subject:Date;
 b=O/GStflsYn0jKNa9E293WWFkMTaVoZcBWRodAGDW7X1yDBH05LCAahw+ll38Xcbzm
 HrceRR+C1SrLISfMgWabFQKK3pPZpW5/nxflzcpURScQ0hpgwj7cLfAaN5lygvgsq8
 TaypQuFdX8+LUaGmPFyLA1fobUpT0KSbW4KGS9zI=
Received: from DFLE204.ent.ti.com (dfle204.ent.ti.com [10.64.6.62])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 599BwoMv281684
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 Oct 2025 06:58:50 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Oct
 2025 06:58:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 06:58:50 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 599BwmRS4171921;
 Thu, 9 Oct 2025 06:58:49 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 0/3] Add support for secure falcon mode: disable args file
Date: Thu, 9 Oct 2025 17:28:42 +0530
Message-ID: <20251009115846.897186-1-anshuld@ti.com>
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
to disable the args file in falcon mode.

The args file is used in falcon mode for loading the device-tree for the kernel.
However in secure falcon mode, the expected payload is a FIT containing a signed
device-tree and kernel image. Thus removing the need to load the extra args
file in the first place. Also, loading the extra file without any authentication
mechanism exposes an attack vector and should therefore be disabled to keep the
boot secure.

This patch set builds on the last few to first optionally allow for loading the
args file in non-secure falcon boot flow [1/3] and then disable them altogether
in the next patch [2/3] for secure falcon mode.

[1]: https://lore.kernel.org/u-boot/20251006101057.4172248-1-anshuld@ti.com/
Depends on: https://lore.kernel.org/u-boot/20251006101057.4172248-1-anshuld@ti.com/

Regards,
Anshul
---
Changes in v2:
 - Address Tom's comments on [1/3]: https://lore.kernel.org/u-boot/20251008163820.GC298503@bill-the-cat/
 - Add call to spl_fixup_fdt with OS_BOOT_ARGS unset in [1/3]
 - Pick R-by tags on [2/3]
 - Add patch [3/3] to the series to fix the args being unset in falcon mode on
   certain boot modes

v1: https://lore.kernel.org/u-boot/20251008113605.1055826-1-anshuld@ti.com/
---
Anshul Dalal (3):
  spl: make args file optional in falcon mode
  spl: prevent loading args file in secure falcon mode
  spl: set fdt address as spl_image arg in falcon mode

 common/spl/Kconfig         | 22 +++++++++++++++-------
 common/spl/spl.c           |  9 +++++++--
 common/spl/spl_ext.c       |  4 ++++
 common/spl/spl_fat.c       |  5 +++++
 common/spl/spl_nand.c      |  5 ++++-
 common/spl/spl_nor.c       |  4 ----
 common/spl/spl_spi.c       |  5 +++++
 common/spl/spl_ubi.c       |  4 ++++
 common/spl/spl_xip.c       |  1 -
 include/system-constants.h |  2 +-
 10 files changed, 45 insertions(+), 16 deletions(-)

-- 
2.51.0

