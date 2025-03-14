Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3D1C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 11:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C975819AA;
	Fri, 14 Mar 2025 12:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G87+Y/Jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C82A9808A2; Fri, 14 Mar 2025 12:04:20 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD5B808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52EB4FdF1662304
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 06:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741950255;
 bh=kWooKfse8/BnGi5eHLwwbChAMNhjNBtjxz6CMiJGTLY=;
 h=From:To:CC:Subject:Date;
 b=G87+Y/JwYKJxHKqqj9XVVhE4V4E9HpnKPX3Cx1UaACtpS4DnZsqH5aLQR1YdHS+Z0
 dby6BuvlX7lsroez2DsvXLUqiZaHoKh7vM7FDNTkFEqOYt1wCElg0fPmSxtHLVFTGI
 db4pk9wymTxaij6201nl+7MkL7jb43yUZfORgPSE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52EB4FCS104730
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Mar 2025 06:04:15 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 06:04:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 06:04:14 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EB4Bqg069672;
 Fri, 14 Mar 2025 06:04:12 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
CC: <n-francis@ti.com>, <afd@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
 <u-kumar1@ti.com>
Subject: [PATCH 0/2] Add WDT support for J7200 SOC
Date: Fri, 14 Mar 2025 16:34:09 +0530
Message-ID: <20250314110411.2781732-1-u-kumar1@ti.com>
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

After DT sync nodes bucka1 and main_esm has bootph property added in
pmic nodes.

RFC was sent
https://lore.kernel.org/all/20241126063543.2678052-1-u-kumar1@ti.com/

With current patch boot logs
https://gist.github.com/uditkumarti/adb647f86e6d166ea2d0ac98dceb7a9b

reset: https://gist.github.com/uditkumarti/adb647f86e6d166ea2d0ac98dceb7a9b#file-gistfile1-txt-L2344

Gowtham Tammana (1):
  arm: dts: k3-j7200: Add ESM PMIC support for tps659413

Neha Malcom Francis (1):
  configs: j7200_evm_r5: Add ESM related configs for J7200

 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 7 +++++++
 configs/j7200_evm_r5_defconfig                 | 2 ++
 2 files changed, 9 insertions(+)

-- 
2.34.1

