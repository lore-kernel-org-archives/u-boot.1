Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732CFC52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 21:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C348A88C30;
	Fri,  9 Aug 2024 23:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hpn1i/Q2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE9888C42; Fri,  9 Aug 2024 23:17:34 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD02B8875C
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 23:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 479LHT9t116131;
 Fri, 9 Aug 2024 16:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723238249;
 bh=O3lxv81naABKxJEzpxON5DayuXLgP2HgFRE9F+acPIc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Hpn1i/Q2t93uVpGqCGC9Civdz6B06uIhWiMN04VJ4WIdFTkIelSff5u4lE2raMThu
 uVo4GMlLdr6PuTt5GqFowxajsOWSykY/Z7ZAB6swfDpW2rVOStuMI6qZvgdnhmAHy4
 16U+lLd93KVPEVanXZkFzqfkq+vw9w2uT/K7uSU8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 479LHTGH055282
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Aug 2024 16:17:29 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 16:17:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 16:17:28 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 479LHSsB045087;
 Fri, 9 Aug 2024 16:17:28 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Nishanth Menon <nm@ti.com>, Reid Tonking <reidt@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>, <afd@ti.com>, <eballetb@redhat.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 3/5] arch: arm: dts: k3-j7200-r5-evm: Add missing fss range
Date: Fri, 9 Aug 2024 16:17:15 -0500
Message-ID: <20240809211717.3887859-4-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809211717.3887859-1-j-humphreys@ti.com>
References: <20240809211717.3887859-1-j-humphreys@ti.com>
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
f00e626085 (arm64: dts: ti: k3-j7200: Use exact ranges for FSS node)

Fixes: 5024a96db8e (Subtree merge tag 'v6.10-dts' of devicetree-rebasing
repo [1] into dts/upstream)

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index fb7e2e50239..2061adbcea3 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -89,6 +89,12 @@
           <0x0 0x50000000 0x0 0x8000000>;
 };
 
+&fss {
+	/* enable ranges missing from the fss node */
+	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
+	         <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
+};
+
 &mcu_ringacc {
     ti,sci = <&dm_tifs>;
 };
-- 
2.34.1

