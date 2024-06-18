Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA09C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8228824C;
	Tue, 18 Jun 2024 20:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F7EqRdGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1294A88365; Tue, 18 Jun 2024 20:46:51 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB6986EB5
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IIkkm1062994;
 Tue, 18 Jun 2024 13:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718736406;
 bh=GQ97QSiQDkLBYu+unnKaxXdAxx2wvB8gPoHMHX6hzfw=;
 h=From:To:CC:Subject:Date;
 b=F7EqRdGQ1jgUfSPd8QTAgRWzuFcyndhQchSwX1d+YcpTdevrdqb+rqFGP61xBEKoT
 t8qzfsx5FEbwC1AlofEswlhYmkmmlSa/AsbjX2gulj0YiwSZNc+sDMfKUaCFQi/nJ+
 LJsAAYcfYCsvjghc6Xuyoa0J13VZMqAnIAhv2UV0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IIkkSZ091761
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Jun 2024 13:46:46 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 13:46:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 13:46:45 -0500
Received: from localhost ([10.249.48.175])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IIkjU0069960;
 Tue, 18 Jun 2024 13:46:45 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <devarsht@ti.com>, <afd@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [PATCH 0/3] Add M4 remoteproc driver for TI K3 SoCs
Date: Tue, 18 Jun 2024 13:46:33 -0500
Message-ID: <20240618184636.30642-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This series adds support for M4 remoteproc driver for K3 devices.

Logs: https://paste.sr.ht/~hnagalla/62811c4003c27ada83bc1c94500f7714ab30092a

Hari Nagalla (3):
  remoteproc: k3-m4: Introduce K3 remote proc driver for M4 subsystem
  configs: am62x_evm_a53_defconfig: Enable M4 remote proc driver
  board: ti: am62x: Add remote proc env variables

 board/ti/am62x/am62x.env            |   4 +
 configs/am62x_evm_a53_defconfig     |   2 +
 drivers/remoteproc/Kconfig          |  10 +
 drivers/remoteproc/Makefile         |   1 +
 drivers/remoteproc/ti_k3_m4_rproc.c | 421 ++++++++++++++++++++++++++++
 5 files changed, 438 insertions(+)
 create mode 100644 drivers/remoteproc/ti_k3_m4_rproc.c

-- 
2.34.1

