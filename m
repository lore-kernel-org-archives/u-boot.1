Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1FCC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E61A8887B0;
	Fri, 31 May 2024 15:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nPcwkxlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47ED887B9; Fri, 31 May 2024 15:12:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5ED887A1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VDBw6F107334;
 Fri, 31 May 2024 08:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717161118;
 bh=IhpDtH+fGPLVc9kHCVmbCiffzb7AfELXNSD3ARHw2UY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nPcwkxlYvabE8fcwwSnJoxewiVu99TFXf11lWDqzhI64wbSz3++C3bWAJkWBMnFlu
 0flxo6ng74ZgZ8viTeYttUL7hoHy1LmYYee8myaeqO1vixDV/1IcgcQ0v5jqbO7DF1
 D2bvZxFfYaWP0Wrn9aNUrV4QUCCDoa3kdP6EVPls=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VDBwdT054008
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 08:11:58 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 08:11:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 08:11:58 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VDBm6r063605;
 Fri, 31 May 2024 08:11:56 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Gowtham Tammana <g-tammana@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 3/6] arm: dts: k3-j7200-r5-common: Hook buckb1 to vtm supply
Date: Fri, 31 May 2024 18:38:20 +0530
Message-ID: <20240531130823.646311-4-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531130823.646311-1-a-limaye@ti.com>
References: <20240531130823.646311-1-a-limaye@ti.com>
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

From: Gowtham Tammana <g-tammana@ti.com>

Hook buckb1 to vtm avs supply.

Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index c7086791ef8..176cc0a0fbb 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -81,6 +81,7 @@
 };
 
 &wkup_vtm0 {
+	vdd-supply-2 = <&buckb1>;
 	bootph-pre-ram;
 };
 
-- 
2.34.1

