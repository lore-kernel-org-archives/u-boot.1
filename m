Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89409D5A6DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 06:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088C589C0F;
	Tue, 26 Nov 2024 07:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E1cLm13J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B21789C1A; Tue, 26 Nov 2024 07:35:53 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC91D89BFC
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ6Zmdk786931
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2024 00:35:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732602948;
 bh=1YgqgxmOe14icPYt30+eUj9zUyP+ddr0Gf4KEB+EQfg=;
 h=From:To:CC:Subject:Date;
 b=E1cLm13J+ecOAfuh9hRM+N4NxSAuKM304M8IGZQek3Zo2XZlyUg7PZvNhtSbDUg+i
 ws3SBDJ45uaFEzuUz+QcXK7W02egRYJmln98i1xvFi+ZlB859Z2xvo+oN3JiJmwg7J
 PzJJTlFlTSn9w4wgrFFHuLpnj8EWjSyXEW0t7rko=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ6ZmuQ026279
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Nov 2024 00:35:48 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 00:35:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 00:35:47 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ6ZikM051095;
 Tue, 26 Nov 2024 00:35:45 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
CC: <n-francis@ti.com>, <afd@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
 <reidt@ti.com>, <u-kumar1@ti.com>
Subject: [RFC PATCH 0/3] Enable ESMs and related PMIC
Date: Tue, 26 Nov 2024 12:05:40 +0530
Message-ID: <20241126063543.2678052-1-u-kumar1@ti.com>
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

This enables the ESMs and the associated PMIC.
Programming these bits is a requirement to make the watchdog actually reset the board.

Patch 3/3 is already available in upstream kernel.
While above sync is done, sending this series as RFC.

Logs
https://gist.github.com/uditkumarti/5dca3fcb2ebe2535f9c9c719ee625513
For reset https://gist.github.com/uditkumarti/5dca3fcb2ebe2535f9c9c719ee625513#file-gistfile1-txt-L2475

Gowtham Tammana (1):
  arm: dts: k3-j7200: Add ESM PMIC support for tps659413

Neha Malcom Francis (1):
  configs: j7200_evm_r5: Add ESM related configs for J7200

Udit Kumar (1):
  arm: dts: k3-j7200: Add bootph for esm and pmic nodes

 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 15 +++++++++++++++
 configs/j7200_evm_r5_defconfig                 |  2 ++
 2 files changed, 17 insertions(+)

-- 
2.34.1

