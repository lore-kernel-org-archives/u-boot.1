Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A85C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 21:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8256B88B99;
	Thu,  8 Aug 2024 23:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RQMWdFtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D69588AF6; Thu,  8 Aug 2024 23:30:18 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06AF88B09
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 23:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478LTpL6096280;
 Thu, 8 Aug 2024 16:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723152591;
 bh=8+iE+ZyL6EvBJE2AV5ia7iX7ArV79Z6+Rkul+6ujWaE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RQMWdFttrz02BHzzywV4pVavhUghUuNkbPEaJtH4DzU67DtiPhxxKBfTTWnIXE7FP
 rvkWGHp0kglKikxQPsyF5/meepP5iFS2rlhdE60rOIEQzCPKrhK0J99letzVZ6r+xp
 autB+eZcWNfK3CfHy1Lfi3S/UAhpqRFFG6/twFWw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478LTpRf027957
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 8 Aug 2024 16:29:51 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 16:29:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 16:29:51 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478LTpQE122952;
 Thu, 8 Aug 2024 16:29:51 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Nishanth Menon <nm@ti.com>, Reid Tonking <reidt@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>, <afd@ti.com>, <eballetb@redhat.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 1/5] arch: arm: dts: k3-j784s4-r5-evm: Add missing fss range
Date: Thu, 8 Aug 2024 16:29:22 -0500
Message-ID: <20240808212926.3790223-2-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808212926.3790223-1-j-humphreys@ti.com>
References: <20240808212926.3790223-1-j-humphreys@ti.com>
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

Upstream DTS added explicit ranges to the fss node.  It did not include the
32 bit memory space needed by the R5 to access OSPI.  With the upstream DTS
sync, OSPI boot no longer works.

Adding the missing range here. It is also being added in the upstream DTS,
so after the next upstream DTS sync, this patch can be removed. See
f062a015f4 (arm64: dts: ti: k3-j784s4: Use exact ranges for FSS node)

Fixes: 5024a96db8e (Subtree merge tag 'v6.10-dts' of devicetree-rebasing
repo [1] into dts/upstream)

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-j784s4-r5-evm.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5-evm.dts
index bef4573d3d2..26af72d73f4 100644
--- a/arch/arm/dts/k3-j784s4-r5-evm.dts
+++ b/arch/arm/dts/k3-j784s4-r5-evm.dts
@@ -97,6 +97,12 @@
 	      <0x0 0x58000000 0x0 0x8000000>;
 };
 
+&fss {
+	/* enable ranges missing from the fss node */
+	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
+					 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
+};
+
 &mcu_ringacc {
 	ti,sci = <&dm_tifs>;
 };
-- 
2.34.1

