Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73460CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 13:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C706D869A3;
	Tue, 12 Sep 2023 15:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eqqtiQD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A71486983; Tue, 12 Sep 2023 15:07:33 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C4B86A40
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 15:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CD7PWs053015;
 Tue, 12 Sep 2023 08:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694524045;
 bh=TuoTBikrjIoMsn6lzbGA+q1ThIDm/EiEu8K8ELnt/PM=;
 h=From:To:CC:Subject:Date;
 b=eqqtiQD2FIa3mNU0bMR670lbmKT72t0hV96GGpGbfXhb71c2uKAyCUWRk7CKxSNDN
 LO9/+wQyvFGqypwvLH67vxAI32ljgzVtXzT4YXMu8YmYj9ExswrrgsutQS4ibBPrco
 sYmP2799RUIHUzPIZ4Co9vdXo3DYxBIKwhzmFm8s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CD7Ohx039972
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 08:07:24 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 08:07:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 08:07:24 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CD7L8E084808;
 Tue, 12 Sep 2023 08:07:21 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>, 
 <seanga2@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-nandan@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH v2 0/3] enable power and clock Kconfig conditionally
Date: Tue, 12 Sep 2023 18:36:42 +0530
Message-ID: <20230912130645.1202325-1-u-kumar1@ti.com>
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

This series, updates enabling mutually exclusive power and clock configs
for TI SOCs.


Sorry to push clock and power changes in one series,
managed by two maintainers. But In my quick grep,
I am not able to active PR raise from both trees.
So copying maintainers of clock and power for review.

Change log
Changes in v2:
- Patch 1 and 2) Added conditional support to enable Kconfig
- Patch 3 No change
link to v1:
https://lore.kernel.org/all/20230911111946.749270-1-u-kumar1@ti.com/


Udit Kumar (3):
  power: domain: ti: Enable single config for power domain
  clk: ti: Add support to enable configs conditionally
  config: j7200: remove not needed power config

 configs/j7200_evm_r5_defconfig | 1 -
 drivers/clk/ti/Kconfig         | 8 ++++----
 drivers/power/domain/Kconfig   | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.34.1

