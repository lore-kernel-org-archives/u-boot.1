Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82784C6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14F486AFF;
	Fri, 25 Aug 2023 20:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Jui9k1QI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9062F86AF5; Fri, 25 Aug 2023 20:03:18 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1C386AB7
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36iM117342;
 Fri, 25 Aug 2023 13:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986586;
 bh=U/U+YRMjpTDI+bQfMgRdv/3MBfJzg3Xx8YGfuaoqVLc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Jui9k1QIOtrv1E/bcK/2JRkmWt1atDtoLBCQs6SHUVqCNOSf7V+8dOPBWRAdRKhf7
 O/mxgaKgKz2Ea6q5XfCBe17i+46cG2wxEYoyIhpHwdqke84IeSEqMbl1pnmEE3i5pk
 QRTDoBzlOEcVKPFGbw43stVEuBfqSdYN8FD6H5ZY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI36Nb018444
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:06 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36ZI026930;
 Fri, 25 Aug 2023 13:03:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 02/20] include: env: ti: mmc: envboot: Only attempt
 boot.scr if BOOTSTD is not enabled
Date: Fri, 25 Aug 2023 13:02:47 -0500
Message-ID: <20230825180305.69515-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230825180305.69515-1-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
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

'script' bootmethod that should be used with CONFIG_BOOTSTD.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Since Simon educated me to realize that the published documentation can
be stale and bootmeths=script does indeed work for some time despite
what the docs say..

 include/env/ti/mmc.env | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
index b8eb51ca1744..0256a2d2aaca 100644
--- a/include/env/ti/mmc.env
+++ b/include/env/ti/mmc.env
@@ -5,7 +5,9 @@ args_mmc=run finduuid;setenv bootargs console=${console}
 	${optargs}
 	root=PARTUUID=${uuid} rw
 	rootfstype=${mmcrootfstype}
+#ifndef CONFIG_BOOTSTD
 loadbootscript=load mmc ${mmcdev} ${loadaddr} boot.scr
+#endif
 bootscript=echo Running bootscript from mmc${mmcdev} ...;
 	source ${loadaddr}
 bootenvfile=uEnv.txt
@@ -18,7 +20,7 @@ get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${name_fdt}
 envboot=if mmc dev ${mmcdev}; then
 	if mmc rescan; then
 		echo SD/MMC found on device ${mmcdev};
-		if run loadbootscript; then
+		if test -n "${loadbootscript}" && run loadbootscript; then
 			run bootscript;
 		else
 			if run loadbootenv; then
-- 
2.40.0

