Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D4FC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 12:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DF187A71;
	Mon,  8 Jan 2024 13:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iQxgq/C/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9191487A21; Mon,  8 Jan 2024 06:19:33 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB9B87A07
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 06:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-kapoor@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4085JTH9045031
 for <u-boot@lists.denx.de>; Sun, 7 Jan 2024 23:19:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704691169;
 bh=++ctgebM7hPP9VhE/hGWHO/6fGXF0+fxvFsQm2bH2Uc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iQxgq/C/Zr3HNbA3wtDQs7UdLwuvy6K9FaWwu0GVyg/mGSmIhFzmWc3BQwduKn4D4
 NTOWvRnmiTvECFTimHu05EZqdqTyMXPf3lIqtCuoO0lljfi/pvUXdU0T9Y5R91Y07C
 mtWrnkZ9V7QqgGu274EY8KeamXV1cNj96yATYsTA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4085JTV9031744
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Sun, 7 Jan 2024 23:19:29 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 7
 Jan 2024 23:19:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 7 Jan 2024 23:19:29 -0600
Received: from localhost ([10.249.128.27])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4085JSfp118194;
 Sun, 7 Jan 2024 23:19:28 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <u-boot@lists.denx.de>
CC: <b-kapoor@ti.com>, <jm@ti.com>, <m-chawdhry@ti.com>, <reidt@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 2/2] arm: dts: k3-j721s2-main: Add Itap Delay Value For DDR50
 speed mode
Date: Mon, 8 Jan 2024 10:49:22 +0530
Message-ID: <20240108051922.29044-3-b-kapoor@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108051922.29044-1-b-kapoor@ti.com>
References: <20240108051922.29044-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 08 Jan 2024 13:10:24 +0100
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

DDR50 speed mode is enabled for MMCSD in J721s2 but its Itap Delay
Value is not present in the device tree. Thus, add Itap Delay Value
for MMCSD Ultra High Speed DDR which is DDR50 speed mode for J721s2 SoC
according to datasheet for J721s2 [1].

[1] Refer to : section 7.10.5.17.2 MMC1/2 - SD/SDIO Interface,  in
	J721s2 datasheet
- https://www.ti.com/lit/ds/symlink/tda4vl-q1.pdf

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm/dts/k3-j721s2-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/k3-j721s2-main.dtsi b/arch/arm/dts/k3-j721s2-main.dtsi
index 084f8f5b66..8a86f6ce8e 100644
--- a/arch/arm/dts/k3-j721s2-main.dtsi
+++ b/arch/arm/dts/k3-j721s2-main.dtsi
@@ -766,6 +766,7 @@
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,itap-del-sel-ddr50 = <0x2>;
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
-- 
2.40.1

