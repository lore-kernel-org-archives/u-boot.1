Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E916C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA8088256;
	Thu, 27 Jun 2024 11:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cLrKabJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C509884DD; Thu, 27 Jun 2024 11:50:18 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E171A87FC8
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45R9nwxi057955;
 Thu, 27 Jun 2024 04:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719481798;
 bh=A+F+uvgXydg1LhOJqUSn/CdxcQYqw6U6gzf5hvc7HZ0=;
 h=From:To:CC:Subject:Date;
 b=cLrKabJVCAV59WMno83mCbQzML3nane5AST8pFHqWr449msHd6hv6VJZgcIbEDvSV
 MeaxrkcRtX9HHmW3Qp6Uq5oTKFBG+G+lSRyHdQvkrTvw8ZKClgwZRYVhW3BEId3dUt
 R+mTZe/KkqccED4qFM8qeiVrJBA/+FmJd7hJI/WY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45R9nwta011278
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Jun 2024 04:49:58 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 04:49:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 04:49:58 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45R9nqpo117534; 
 Thu, 27 Jun 2024 04:49:53 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <joe.hershberger@ni.com>, <nm@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <n-jain1@ti.com>,
 <rogerq@kernel.org>, <vigneshr@ti.com>, <sjg@chromium.org>,
 <mkorpershoek@baylibre.com>, <andriy.shevchenko@linux.intel.com>,
 <bmeng.cn@gmail.com>, <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] board/include: ti/env: j721e.env/ti_common: Fix
 cpsw0_qsgmii_phyinit
Date: Thu, 27 Jun 2024 15:19:52 +0530
Message-ID: <20240627094952.2074528-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
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

The command "main_cpsw0_qsgmii_phyinit" has to be run depending on
whether or not the "do_main_cpsw0_qsgmii_phyinit" variable is set.
However, there is no support for the cases where the environment variable
"do_main_cpsw0_qsgmii_phyinit" is updated at runtime. On J721E, the value
of "do_main_cpsw0_qsgmii_phyinit" is updated at runtime.

Fix the existing implementation in order to handle the case where the
value of "do_main_cpsw0_qsgmii_phyinit" is updated at runtime. Do so by
introducing the environment variable "update_do_main_cpsw0_qsgmii_phyinit"
which defaults to setting "do_main_cpsw0_qsgmii_phyinit" to zero, but at
the same time, it allows the board to update the value at runtime.

Fixes: 0d72b0f2f83b ("include: env: ti: ti_common: Run main_cpsw0_qsgmii_phyinit conditionally")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
899b088674 Merge patch series "pxe: Add debugging for booting"
of U-Boot's next branch.

Regards,
Siddharth.

 board/ti/j721e/j721e.env     | 9 +++++----
 include/env/ti/ti_common.env | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
index 38bfd7d496..03d7e81aa8 100644
--- a/board/ti/j721e/j721e.env
+++ b/board/ti/j721e/j721e.env
@@ -29,7 +29,7 @@ bootdir=/boot
 rd_spec=-
 
 #if CONFIG_TARGET_J7200_A72_EVM
-do_main_cpsw0_qsgmii_phyinit=1
+update_do_main_cpsw0_qsgmii_phyinit=setenv do_main_cpsw0_qsgmii_phyinit 1;
 init_main_cpsw0_qsgmii_phy=gpio set gpio@22_17;
 	gpio clear gpio@22_16
 main_cpsw0_qsgmii_phyinit=
@@ -39,10 +39,11 @@ main_cpsw0_qsgmii_phyinit=
 #elif CONFIG_TARGET_J721E_A72_EVM
 init_main_cpsw0_qsgmii_phy=gpio set gpio@22_17;
 	gpio clear gpio@22_16
-main_cpsw0_qsgmii_phyinit=
+update_do_main_cpsw0_qsgmii_phyinit=
 	if test $board_name = J721EX-PM1-SOM || test $board_name = J721EX-PM2-SOM || test $board_name = j721e; then
-		do_main_cpsw0_qsgmii_phyinit=1; else
-		do_main_cpsw0_qsgmii_phyinit=0; fi;
+		setenv do_main_cpsw0_qsgmii_phyinit 1; else
+		setenv do_main_cpsw0_qsgmii_phyinit 0; fi;
+main_cpsw0_qsgmii_phyinit=
 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1 && test ${dorprocboot} -eq 1 && test ${boot} = mmc; then
 		run init_main_cpsw0_qsgmii_phy;			\
 	fi;
diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index c5c3642177..d0b3d698a0 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -23,9 +23,10 @@ get_fit_overlaystring=
 	done;
 get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
-do_main_cpsw0_qsgmii_phyinit=0
+update_do_main_cpsw0_qsgmii_phyinit=setenv do_main_cpsw0_qsgmii_phyinit 0;
 bootcmd_ti_mmc=
 	run findfdt; run init_${boot};
+	run update_do_main_cpsw0_qsgmii_phyinit;
 #if CONFIG_CMD_REMOTEPROC
 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
 		then run main_cpsw0_qsgmii_phyinit;
-- 
2.40.1

