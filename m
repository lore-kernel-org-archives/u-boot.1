Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F0BCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F5C86EDD;
	Fri, 13 Oct 2023 01:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oYE61Wso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8E986915; Fri, 13 Oct 2023 01:08:20 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B1F86E65
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6JxD067506;
 Thu, 12 Oct 2023 18:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697151979;
 bh=d7SIQ6eTpRhXLSfX9GBpiiPEAUt9wgOBl2aXt/wRtB8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=oYE61Wso5wlZ+/xi/V+G2vOuaa5+8LISHc9R334zTv7hkrSqYXusjZMJ1GMZgy/ka
 n0m/al/2xt/db6hub5delprAyGseTTeVThomJ6fF17iHdcnh/zHQW/meqZzj0O31e6
 iwkJdtI8cxXGFPBOrDi/i9RD+ZHzMEA3h73A1exs=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39CN6J8S062783
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 18:06:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 18:06:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 18:06:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6IYa038860;
 Thu, 12 Oct 2023 18:06:18 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 04/11] arm: mach-k3: invert logic for split DM firmware config
Date: Thu, 12 Oct 2023 18:06:21 -0500
Message-ID: <20231012230616.2101992-17-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012230616.2101992-13-bb@ti.com>
References: <20231012230616.2101992-13-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=bb@ti.com;
 h=from:subject; bh=wvZJqh9osbjbURL9MKflB/OSftuIrwqhhc47PwEAB/4=;
 b=owNCWmg5MUFZJlNZQgWPlgAAa/////fbezPvreW/LL9t/l6GWf1v/r/37N8Jcf9vvf7e6PawA
 REB2kAMg0AGgaaADQDQPUDTQZDRo0aaGQ0ANNBppkA0DEMgAD0amj1HqPSaGMkMpoNNBkNHqeUB
 oGgeoaaZGQ0GgAAA0aaDQD0h6CDajTTI0NB6jQAaHqBkaA0aGiANNGgZNMjTQZADIaMCAGmQ0GT
 QNA0GQaYQ0GTBGg0wjEAyMTTBNBoMmge3D5yQNclL1j8nByy0LoUZcyKEPvHixMrAIbz7l2DqMO
 hgmnkA55kgCFAkbLcPyAi/yeEwNne2wdeMImCbHSF6JOc6FUiublM9TKECgNG6NrU0tgkbap511
 jEfWOkSwxmrnwH0YI0ycYlALOG4fvYbt+PgNEPPlKswljxGw+7ZZ6ynhHXImsabWtRkRpnea2+W
 XMB2IkKhMnDlYkcRnGWXohC+OuWLYMl2sZ+JC6pCVVM1D90Ggt/5KudtogMFzLDagP2tYtgmYie
 mJzKgjBz2x1H537VRI1H0eTnkLgrReJ5pdOcJv6sgFb+ToIhXXAxYYfsGUQZfoGYGPiiCgqUaO9
 VlNQG7l3SbRFJHxSmydAdrUooDslqnR2QI6/Mbrh0186Ah0/EN+GCD6qOev7ONjOgiKEVKsI7Hj
 wB48UwKSq/xdyRThQkEIFj5YA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Currently for the K3 generation of SoCs there are more SoCs that utilize
the split firmware approach than the combined DMSC firmware. Invert the
logic to avoid adding more and more SoCs to this list.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 9168bf842dcaf..9a211871e04ef 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -172,7 +172,7 @@ config K3_ATF_LOAD_ADDR
 
 config K3_DM_FW
 	bool "Separate DM firmware image"
-	depends on SPL && CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
+	depends on SPL && CPU_V7R && !(SOC_K3_AM642S || SOC_K3_AM654) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
 	default y
 	help
 	  Enabling this will indicate that the system has separate DM
-- 
2.42.0

