Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1555C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 09:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234AC88418;
	Tue, 28 May 2024 11:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OcTK/eND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3276288422; Tue, 28 May 2024 11:50:04 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3EA0883D3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 11:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S9nxbK015156;
 Tue, 28 May 2024 04:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716889799;
 bh=IHYevKda4olQtqjsKgZaJKNJhdNNJmxL9RKGYdEEtK8=;
 h=From:To:CC:Subject:Date;
 b=OcTK/eNDXRliDUzbKViqRtbGXpMJ9qJy3VqSPbx1K5IyvJVwlsFprT8GCu0aV2CYU
 UDbgVsk8swQ/uzKyZ4YN7GZnYvOSCW/nvKLkfURDHVULAebANPbQumnRh1x84SN0SG
 Q0vCIg3f0AjF1zBvPz+HeTz7E4lRkIRuF871oi1I=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S9nxuP056538
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 04:49:59 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 04:49:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 04:49:58 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S9ntKm055095;
 Tue, 28 May 2024 04:49:56 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <m-chawdhry@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <afd@ti.com>, <sjg@chromium.org>, <nm@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH] arm: dts: k3-j721s2-r5: Change GTC clock parent
Date: Tue, 28 May 2024 15:19:54 +0530
Message-ID: <20240528094954.4135421-1-n-francis@ti.com>
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

MAIN_PLL0 has a flag set in DM (Device Manager) that removes its
capability to re-initialise clock frequencies. A72 CPU clock (GTC) and
RGMII has MAIN_PLL3 as their parent which does not have this flag. While
RGMII needs re-initialization to default frequency to be able to get
250MHz with its divider, GTC can not get its required 200MHz with its
dividers. Thus move GTC clock parent on J721S2 from MAIN_PLL3_HSDIV1 to
MAIN_PLL0_HSDIV6. This was already done on CPTS node in kernel which was
similarly affected (linked).

Link: https://lore.kernel.org/all/20230605110443.84568-1-n-francis@ti.com/
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Boot logs: https://gist.github.com/nehamalcom/70676857dc3816a415af9861c38c76eb

 arch/arm/dts/k3-j721s2-r5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index eb0df42583a..40272abfc7c 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -22,7 +22,7 @@
 		resets = <&k3_reset 202 0>;
 		clocks = <&k3_clks 61 1>;
 		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-parents = <&k3_clks 61 3>;
 		assigned-clock-rates = <200000000>, <2000000000>;
 		ti,sci = <&sms>;
 		ti,sci-proc-id = <32>;
-- 
2.34.1

