Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF35CCFA0A
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 11:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF2A869A4;
	Fri,  8 Sep 2023 13:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="frUMznCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F2986993; Fri,  8 Sep 2023 13:56:22 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D2C869F6
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388BuHZ3010017;
 Fri, 8 Sep 2023 06:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694174177;
 bh=iAL6qZwrrdrnM/2lTkWMJNjCxlYsaGab3hVx6uh7bl8=;
 h=From:To:CC:Subject:Date;
 b=frUMznCnH6sSQO/dFFTnrAsDmF8PW/JYZs+sYbncD99Xy7ZJngEzGARtZd9CSyUmV
 dn2FogG5Gwm6DNiufiEIBmkhVqlaL3j/Y0glF2iRnXKLv7Vo68LoTTnvgzM8zSwiZ3
 Rery2PNy0KPQE6OCu5DOmbBTh2rATVQQdcaCDf/s=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388BuHlr119684
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:56:17 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:56:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:56:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388BuGkB031639;
 Fri, 8 Sep 2023 06:56:16 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <devarsht@ti.com>, <nsekhar@ti.com>,
 <jan.kiszka@siemens.com>, <chao.zeng@siemens.com>
Subject: [PATCH] configs: am65x_evm: Use envboot before distro_bootcmd
Date: Fri, 8 Sep 2023 17:26:15 +0530
Message-ID: <20230908115615.3829854-1-devarsht@ti.com>
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

Use envboot cmd before issuring distro_bootcmd as otherwise
environment variables from uEnv.txt are not getting imported.

The commands after distro_bootcmd have no impact since board starts
booting after distro_bootcmd, so it need to run last after all
environment variables are configured correctly.

Fixes: bde6ac54905 ("configs: am65x_evm: Switch envboot out for
distro_bootcmd")

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Boot logs (with display overlay) :
https://gist.github.com/devarsht/2bac56933847d3e954d6ee275d711e27
---
 configs/am65x_evm_a53_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index 4301553af8..4f1ef10e69 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -34,7 +34,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run init_${boot}; run boot_rprocs; run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern"
+CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
 CONFIG_LOGLEVEL=7
 CONFIG_CONSOLE_MUX=y
 CONFIG_SPL_MAX_SIZE=0x58000
-- 
2.34.1

