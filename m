Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9686C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 06:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3496388456;
	Wed, 22 May 2024 08:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kHxpzcIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EACE8845C; Wed, 22 May 2024 08:37:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E963A88412
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M6auhX017591;
 Wed, 22 May 2024 01:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716359816;
 bh=EIvBnMAM7uggH7hH+kTseVgOFMQwpg4UsIGWmju+9x8=;
 h=From:To:CC:Subject:Date;
 b=kHxpzcICON1aye/VSwS4h/OoGsKp6bPoYrKSxeBOWnaGqqctaLkpjBQDeOPKyW00n
 6x20ptIAHaAm7NnwLDxMqsN1Qgf7zn7WbgJKPiu674MAUV4JQ7xU9erQSm5d/0lmvD
 zpPceddIUM2lwSHrlq0OBtQS+3HqGlskDRbOvqTo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M6auQT002030
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 01:36:56 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 01:36:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 01:36:55 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M6atgq108024;
 Wed, 22 May 2024 01:36:55 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44M6atff009963;
 Wed, 22 May 2024 01:36:55 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Judith Mendez <jm@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nikhil M
 Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Simon Glass <sjg@chromium.org>, Neha
 Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Subject: [PATCH 0/3] Enable ICSSG Driver for AM64x
Date: Wed, 22 May 2024 12:06:49 +0530
Message-ID: <20240522063652.3759497-1-danishanwar@ti.com>
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

This series adds device-tree changes (specific to u-boot only), config
changes and env changes to enable ICSSG Ethernet Driver on AM64x.

Patch 1/3 adds remoteproc-name property to the pru cores in
k3-am642-evm-u-boot.dtsi file. This property is not needed in Linux thus
it's not part of the PRU nodes in k3-am64x-main.dtsi. Adding this in 
*u-boot.dtsi as it is only needed for u-boot. Without this different PRU
nodes can have same remoteproc-name which results into probe failure.
For example the node "pru0_0: pru@34000" and "pru1_0: pru@34000" both will
have remoteproc-name as "pru@34000" without this patch, resulting in probe
failure because of non-unique name (_rproc_name_is_unique() API) of PRU
core.

Patch 2/3 Enables necessary configs for AM64x to enable ICSSG driver
Patch 3/3 Sets env variables needed for ICSSG driver

Thanks and Regards,
MD Danish Anwar 

MD Danish Anwar (3):
  arm: dts: k3-am642-evm-u-boot: Add remoteproc-name for PRU cores
  configs: am64x_evm_a53: Enable ICSSG Driver
  board: ti: am64x: Set storage_interface and fw_dev_part ENVs

 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 44 +++++++++++++++++++++++++++
 board/ti/am64x/am64x.env              |  5 +++
 configs/am64x_evm_a53_defconfig       |  5 +++
 3 files changed, 54 insertions(+)


base-commit: 7d24c3e06fa9a3b53cea593d4579886ef0eb4fe8
-- 
2.34.1

