Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38851EE0217
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 08:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A277891ED;
	Wed, 11 Sep 2024 10:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lX28Tlow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C15B89211; Wed, 11 Sep 2024 10:37:36 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D69589149
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 10:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48B8bVH1035221;
 Wed, 11 Sep 2024 03:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726043851;
 bh=DbmSwUpJ6sMRVtCE7J+pE9MDOWZlfh5+Y8EMsylx/gM=;
 h=From:To:CC:Subject:Date;
 b=lX28TlowvqGvGeUVACDA79hMSJCmRXAFdRmjIWlL21Ifsrm2JzHf/xewJeY2ESX1I
 iIkOKErOlRc7EZ+yMm+w05O8OA9C5KYg2JWRcc9Xd1njdO9MPeWWUMvNAYkND5L+ai
 xfdOK4M4Xs3tjJAGM81uP4NKKrWe3HHtOpjiCHt0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48B8bVu8004840
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 11 Sep 2024 03:37:31 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Sep 2024 03:37:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Sep 2024 03:37:31 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B8bSut038394;
 Wed, 11 Sep 2024 03:37:29 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-limaye@ti.com>,
 <reidt@ti.com>, <j-humphreys@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] arch: arm: dts: k3-j7200-r5-evm: Enable AVS feature
Date: Wed, 11 Sep 2024 14:07:22 +0530
Message-ID: <20240911083722.1285509-1-u-kumar1@ti.com>
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

During DT sync with kernel 6.6, AVS feature was removed by mistake.
So adding back AVS feature.

Fixes: df73e791ce09("arm: dts: j7200: dts sync with Linux 6.6-rc1")

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Test logs with this patch
Added print in avs driver to see, voltage being set.

U-Boot SPL 2024.10-rc4-00436-ga252ef4f0842-dirty (Sep 11 2024 - 13:57:26 +0530)
SYSFW ABI: 4.0 (firmware rev 0x000a '10.0.8--v10.00.08 (Fiery Fox)')
avs init
volt 800000
Trying to boot from MMC2


 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index 94760c78dd..fac108ce14 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -102,3 +102,8 @@
 &mcu_udmap {
     ti,sci = <&dm_tifs>;
 };
+
+&wkup_vtm0 {
+	vdd-supply-2 = <&buckb1>;
+	bootph-pre-ram;
+};
-- 
2.34.1

