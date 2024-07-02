Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6DAC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 05:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502128871B;
	Tue,  2 Jul 2024 07:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EDpEPRjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3CB588722; Tue,  2 Jul 2024 07:20:45 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2954883D9
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 07:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4625KdID014154;
 Tue, 2 Jul 2024 00:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719897639;
 bh=vxyIi/V7idddJtGKiz7/Pe4RJcUhZAQ1tUJsuf9OieU=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=EDpEPRjODDIejhlrAwFfxLArLWiaas7T69hc2cjJBgVSoDoImEw96FQrkFE5bujJ1
 QYEsuasHXswB+84KwGTQF9GgiA47F7EjkgIcXsVc3IUqN58t2Ai8C/RscY486UuecM
 0R0llz0smq1xRWotQZVP96lbfRCiHlB4y/3d1k5s=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4625KdXw025442
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Jul 2024 00:20:39 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 00:20:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 00:20:39 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4625KKsN070700;
 Tue, 2 Jul 2024 00:20:36 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 2 Jul 2024 10:50:04 +0530
Subject: [PATCH v3 4/4] include: env: ti_common: Remove findfdt from
 bootcmd_ti_mmc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-b4-upstream-streamline-platform-v3-4-0ebd7bbd31d5@ti.com>
References: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
In-Reply-To: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719897620; l=1217;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=zDfMtQgQmGG+J0WfRYpLIHrViWmVtt6cC4q3EWJ0kME=;
 b=/Wz4ATJMQKKKTMwUPqzfkAemc35HIPr0YmutQTDoPwYlLKLWr21MJj0Vi2xONsPwFk9hzLLmr
 zNgxCp09Rx7BgqYjufJhnie0QOYKLdJqPGyR4zCVAOlSRMx4UFM8MPi
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

From: Dhruva Gole <d-gole@ti.com>

findfdt is used by bootcmd_ti_mmc by default which used to help populate
the fdtfile. The users of findfdt from bootcmd_ti_mmc have migrated to
ti_set_fdt_env for populating fdtfile; Hence, findfdt can be removed from
bootcmd_ti_mmc having no-impact for any platform.

Remove findfdt to not print out the warning that gets set after calling
ti_set_fdt_env. viz.
"echo WARN: fdtfile already set. Stop using findfdt in script"

Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 include/env/ti/ti_common.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index c5c36421770c..7029d12bf203 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -25,7 +25,7 @@ get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
 do_main_cpsw0_qsgmii_phyinit=0
 bootcmd_ti_mmc=
-	run findfdt; run init_${boot};
+	run init_${boot};
 #if CONFIG_CMD_REMOTEPROC
 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
 		then run main_cpsw0_qsgmii_phyinit;

-- 
2.45.1

