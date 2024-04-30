Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263FBC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 10:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96906881C6;
	Tue, 30 Apr 2024 12:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HH4v6t6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FCB8889BB; Tue, 30 Apr 2024 12:46:47 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3BA18897D
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 12:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UAkbpO002536;
 Tue, 30 Apr 2024 05:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714473997;
 bh=7uH/uj/1roLFh9hisuPVGWycfJsEoJ8UZRFPemEeOuU=;
 h=From:To:CC:Subject:Date;
 b=HH4v6t6XwUt1LyamIntWe6Uk/HCn3RTYwnUMiTuYefjoNk8Lfz+pSmq9AW0jNxOc1
 mXUSd30l8BB18NNM4Dv54mxXfEFzjdb2oIWwki/DCbdld9e7+oUEeNHkICev/N/t3Y
 wkyJqC3HsLwjdnV08XSGC9Kqfb+3zfgjDgOZBv7E=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UAkbM6029536
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Apr 2024 05:46:37 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 05:46:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 05:46:37 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UAkbJY046795;
 Tue, 30 Apr 2024 05:46:37 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43UAkaSc010439;
 Tue, 30 Apr 2024 05:46:36 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Nishanth Menon <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] Add AM64x Support to PRUSS and PRU_RPROC driver
Date: Tue, 30 Apr 2024 16:16:31 +0530
Message-ID: <20240430104633.1445311-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This series adds AM64x related compatibles to PRUSS and PRU_RPROC drivers.
This series is a prerequisite for ICSSG Ethernet driver.

Once Support for AM64x is added to PRUSS and PRU_RPROC driver, I'll send
another series to enable ICSSG Ethernet driver for AM64x as well.

MD Danish Anwar (2):
  remoteproc: pru: Add support for AM64x PRU / RTU cores
  soc: ti: pruss: Add support for AM64x

 drivers/remoteproc/pru_rproc.c | 9 +++++++--
 drivers/soc/ti/pruss.c         | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)


base-commit: ff0de1f0557ed7d2dab47ba976a37347a1fdc432
-- 
2.34.1

