Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906FCC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 10:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9636C8875E;
	Tue, 21 May 2024 12:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yoiMqojm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD5F18875D; Tue, 21 May 2024 12:57:30 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8508876C
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 12:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LAvHa1011524;
 Tue, 21 May 2024 05:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716289037;
 bh=YkpiQ7+dcyG6OT6bbG38+Wwox2fOaZR8VwDVgr3wPuk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yoiMqojmL4ir5xcWP0N7Rg0MhWpP7ATKDl2Ol9PQ8b+6Wv2llw+jp4a0fvvRuIkYB
 GM0MeVk/VcyH3/HsmmOW59rbBysO/xxU1Y0HLEqXOMkzsQtCpoTVgqEFH2Kd3+h4z7
 67h3uIhlqVYgh7Pdlx1wNuB4m1fY4dldf9I6kMG8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LAvHQe032043
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 May 2024 05:57:17 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 05:57:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 05:57:17 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LAurAi047424;
 Tue, 21 May 2024 05:57:11 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <trini@konsulko.com>
CC: <joe.hershberger@ni.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <emanuele.ghidoli@toradex.com>,
 <matthias.schiffer@ew.tq-group.com>, <a-bhatia1@ti.com>,
 <vitor.soares@toradex.com>, <danishanwar@ti.com>,
 <andriy.shevchenko@linux.intel.com>, <bmeng.cn@gmail.com>,
 <mkorpershoek@baylibre.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>, <joao.goncalves@toradex.com>,
 <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 3/4] include: env: ti: Add support for secure firmwares
Date: Tue, 21 May 2024 16:26:47 +0530
Message-ID: <20240521105648.3780072-4-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521105648.3780072-1-u-kumar1@ti.com>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
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

Secure firmwares must be loaded if SOC is secure,
currently rproc framework chooses non-secure firmware always.

So adding support to load secure firmware, when SOC is secure

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 include/env/ti/k3_rproc.env  | 6 +++++-
 include/env/ti/ti_common.env | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/env/ti/k3_rproc.env b/include/env/ti/k3_rproc.env
index 87d9d76eba..d4f0f1708c 100644
--- a/include/env/ti/k3_rproc.env
+++ b/include/env/ti/k3_rproc.env
@@ -13,11 +13,15 @@ rproc_load_and_boot_one=
 boot_rprocs_mmc=
 	env set rproc_id;
 	env set rproc_fw;
+	env set secure_suffix;
+	if test ${secure_rprocs} -eq 1; then
+		env set secure_suffix -sec;
+	fi;
 	for i in ${rproc_fw_binaries} ; do
 		if test -z "${rproc_id}" ; then
 			env set rproc_id $i;
 		else
-			env set rproc_fw $i;
+			env set rproc_fw $i${secure_suffix};
 			run rproc_load_and_boot_one;
 			env set rproc_id;
 			env set rproc_fw;
diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index 02b410c3ad..c5c3642177 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -12,6 +12,7 @@ bootm_size=0x10000000
 boot_fdt=try
 
 boot_fit=0
+secure_rprocs=0
 addr_fit=0x90000000
 name_fit=fitImage
 update_to_fit=setenv loadaddr ${addr_fit}; setenv bootfile ${name_fit}
-- 
2.34.1

