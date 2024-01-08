Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E210EC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 12:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 130FC878F6;
	Mon,  8 Jan 2024 13:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rQ1dw6yM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF3A87A10; Mon,  8 Jan 2024 06:19:31 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD54187A07
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 06:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-kapoor@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4085JRfw018594
 for <u-boot@lists.denx.de>; Sun, 7 Jan 2024 23:19:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704691167;
 bh=+sQJnFpNEUPIM8mPT1V7av5QnmiPw+NGk3EoHIME9bk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rQ1dw6yMKGRRX8r+cyBBw1QMy0BGqI+HYzA64oICC+9WL7BNJQi4k4SOg3UPknvmp
 iGCWYKzgjauYlKM2DWZT3HNTRrnYIv3X9HfSNiXBEPexPL66vd1D4rud8Isg5umnzU
 A3PmCYTc+iFto/FomqheJ6ZdDZq505uFpIB9VT9I=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4085JRIB031727
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Sun, 7 Jan 2024 23:19:27 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 7
 Jan 2024 23:19:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 7 Jan 2024 23:19:27 -0600
Received: from localhost ([10.249.128.27])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4085JPKb054341;
 Sun, 7 Jan 2024 23:19:26 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <u-boot@lists.denx.de>
CC: <b-kapoor@ti.com>, <jm@ti.com>, <m-chawdhry@ti.com>, <reidt@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 1/2] arm: dts: k3-j7200-main: Add Itap Delay Value For DDR52
 speed mode
Date: Mon, 8 Jan 2024 10:49:21 +0530
Message-ID: <20240108051922.29044-2-b-kapoor@ti.com>
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

DDR52 speed mode is enabled for eMMC in J7200 but its Itap Delay Value
is not present in the device tree. Thus, add Itap Delay Value for eMMC
High Speed DDR which is DDR52 speed mode for J7200 SoC according to
datasheet for J7200 [1].

[1] Refer to : section 7.9.5.16.1 MMCSD0 - eMMC Interface,  in
	J7200 datasheet
- https://www.ti.com/lit/ds/symlink/dra821u-q1.pdf

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm/dts/k3-j7200-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/k3-j7200-main.dtsi b/arch/arm/dts/k3-j7200-main.dtsi
index cdb1d6b2a9..18531ba803 100644
--- a/arch/arm/dts/k3-j7200-main.dtsi
+++ b/arch/arm/dts/k3-j7200-main.dtsi
@@ -647,6 +647,7 @@
 		ti,otap-del-sel-hs400 = <0x5>;
 		ti,itap-del-sel-legacy = <0x10>;
 		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,itap-del-sel-ddr52 = <0x3>;
 		ti,strobe-sel = <0x77>;
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
-- 
2.40.1

