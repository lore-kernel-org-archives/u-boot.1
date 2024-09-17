Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA20C35FF0
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 08:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5BEF88B0A;
	Tue, 17 Sep 2024 10:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tnbRDbDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65FA088D54; Tue, 17 Sep 2024 10:14:00 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B642388ADC
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48H8DfTw124578;
 Tue, 17 Sep 2024 03:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726560821;
 bh=uR8g2YJI07x8cJmFzIZoz357EDF2OnQdfEqlnSPlMWE=;
 h=From:To:CC:Subject:Date;
 b=tnbRDbDd47sDj0gx28wWfQ6Ud2vdOoWl/1MJytY+SAmMCQXKN41gmE55AkS6cZ28l
 F2l87dBDKy3EwuMjjtUVRQnxa/MSIPhTQE/DB4iKmQ+210b3dZpRodMO7Tr2loHw50
 C/GdQqv4eLkPJHyyBCzRn7Cio46IxXWRCGkWKdXg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48H8DfwE115044
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Sep 2024 03:13:41 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Sep 2024 03:13:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Sep 2024 03:13:41 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48H8Dbs5093869;
 Tue, 17 Sep 2024 03:13:38 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <rogerq@kernel.org>, <afd@ti.com>, <bb@ti.com>, <j-humphreys@ti.com>,
 <sumit.garg@linaro.org>, Udit Kumar <u-kumar1@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>
Subject: [PATCH] dts: beagleboneai64: Add boothph in chipid node
Date: Tue, 17 Sep 2024 13:43:29 +0530
Message-ID: <20240917081329.370288-1-u-kumar1@ti.com>
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

beagleboneai64 boot was broken after OF_UPSTREAM support for
J721E SOC.
So add bootph in chipid node similar to other boards of
this SOC.

Fixes: 46bb1405b461 ("arm: dts: k3-j721e: Move to OF_UPSTREAM")
Reported-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Boot logs
https://gist.github.com/uditkumarti/32604960dec65401cde8979e51160ba7

 arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
index 884f44239e..27851b7d08 100644
--- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -64,6 +64,10 @@
 	bootph-all;
 };
 
+&chipid {
+	bootph-all;
+};
+
 &mcu_ringacc {
 	reg = <0x0 0x2b800000 0x0 0x400000>,
 		<0x0 0x2b000000 0x0 0x400000>,
-- 
2.34.1

