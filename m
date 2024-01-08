Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74565C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 08:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A9B87A38;
	Mon,  8 Jan 2024 09:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SQWP+a/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB0A187A32; Mon,  8 Jan 2024 09:19:03 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 539E387A21
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 09:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4088IvYw105262;
 Mon, 8 Jan 2024 02:18:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704701937;
 bh=Ey39qEgqH76ToiGWjJSYJoWw0mxUW9PiIZPXU04qY4s=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=SQWP+a/tO92cctUXgg/au3XCXwbgexxBUaCI7HuH4cz4ThyS9007InkNW0Sn3LwYw
 df2VGXYtSE8jkPTwXV3xPb1lL9n+r6rE+e4CxrSPkqTHJbZVauKTLEVBgQQSV6QFZ2
 vVwk13EG+QOhBqMyld8A6KJDpcwEUpK5HwZXNFEo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4088Ivv8062321
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 02:18:57 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 02:18:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 02:18:57 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4088IpIh030312;
 Mon, 8 Jan 2024 02:18:55 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 8 Jan 2024 13:48:49 +0530
Subject: [PATCH 2/2] include: env: ti: add default for
 do_main_cpsw0_qsgmii_phyinit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240108-b4-upstream-fix-semicolon-v1-2-9437b3dc90ea@ti.com>
References: <20240108-b4-upstream-fix-semicolon-v1-0-9437b3dc90ea@ti.com>
In-Reply-To: <20240108-b4-upstream-fix-semicolon-v1-0-9437b3dc90ea@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704701931; l=976;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=jG67l4Q8Tt4WoO1NZEneAUYq/mN3HRuBm+/g1zDHLGg=;
 b=aM5vLqDpJNsh8wT4t28Cgty3FZpxUbpTeinTPjlBFPA6NM7+Xp4MHiidtzSnTbSHh+CiMMQSB
 MrcpoVQIDrTBGXcVSLzGVQfMfgJMNVoBTzrn8XZ+MfOj5U4EMgKG21R
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

By default this variable is unset and this causes the test condition to
fail on devices that don't have this defined. Set a default value for
this.

   => boot
   ## Error: "main_cpsw0_qsgmii_phyinit" not defined
   [...]

Fixes: 0d72b0f2f83b ("include: env: ti: ti_common: Run main_cpsw0_qsgmii_phyinit conditionally")

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 include/env/ti/ti_common.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index 5473f633aa7d..02b410c3adc4 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -22,6 +22,7 @@ get_fit_overlaystring=
 	done;
 get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
+do_main_cpsw0_qsgmii_phyinit=0
 bootcmd_ti_mmc=
 	run findfdt; run init_${boot};
 #if CONFIG_CMD_REMOTEPROC

-- 
2.43.0

