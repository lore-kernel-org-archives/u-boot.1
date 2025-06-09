Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C316BC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3335B811AC;
	Mon,  9 Jun 2025 10:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="USjB4pNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41F582C03; Mon,  9 Jun 2025 10:14:44 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4467A8007D
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598EdaE1947689;
 Mon, 9 Jun 2025 03:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456879;
 bh=T6xY0Bd3c10tGC+b0W6ppbsedRL3eeGkMggN3ywbXdc=;
 h=From:To:CC:Subject:Date;
 b=USjB4pNUq5uDeC6jw58ZGl0EEQMiEKTj3vV6h1wyQP8Sc8GYCMzo0Z65ZhbHCdw0e
 82Q0NsnNSz2sEqqIOYHSwg0wN9xmnLUfh618tTECOe5YZfye7PZC7zUA/KGXKpPJw6
 1Qp3Rqu3q5ox2mour7d3zYqVd+WLzWJunOZW9oT0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5598EdtY4125651
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:14:39 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:14:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:14:38 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5598EYqn1101163;
 Mon, 9 Jun 2025 03:14:35 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH v2 0/6] Print version of the DM firmware 
Date: Mon, 9 Jun 2025 13:44:28 +0530
Message-ID: <20250609081434.1000377-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
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

This patch series adds the functionality to print the DM firmware
version being used. Before requesting TISCI for the DM version we
first check if the DM split mode capability exists, if yes, we proceed
onto making the call to TISCI for retrieving the version information.

DM split mode capability[0] indicates that the DM is a separate binary
altogether and has its own versioning information similar to TIFS. 

Boot Logs: https://gist.github.com/Jamm02/37864f605445944a0c0caf426e0aba50

[0]https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps

Changes since v1: 
- Rebased against master
- Fixed alignment issues in the comments
- Changed ordering of the definitions
- Carried R/B from Neha and Dhruva

Moteen Shah (6):
  ti_sci_*: Add utility to access tisci firmware and SOC capability
  ti_sci_* : Add capability to access DM firmware's metadata
  firmware: ti_sci.c: Add a function to query DM firmware's capability
  firmware: ti_sci.c: Add a function to request DM metadata using
    ti_sci* calls
  arm: mach-k3: Add a function for printing DM version
  arm: mach-k3: Print version of DM firmware during boot process

 arch/arm/mach-k3/am62ax/am62a7_init.c  |  4 ++
 arch/arm/mach-k3/am62px/am62p5_init.c  |  4 ++
 arch/arm/mach-k3/common.c              | 29 ++++++++
 arch/arm/mach-k3/common.h              |  1 +
 arch/arm/mach-k3/j721e/j721e_init.c    |  4 ++
 arch/arm/mach-k3/j721s2/j721s2_init.c  |  4 ++
 arch/arm/mach-k3/j722s/j722s_init.c    |  4 ++
 arch/arm/mach-k3/j784s4/j784s4_init.c  |  4 ++
 drivers/firmware/ti_sci.c              | 99 ++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              | 42 +++++++++++
 include/linux/soc/ti/ti_sci_protocol.h | 39 ++++++++++
 11 files changed, 234 insertions(+)

-- 
2.34.1

