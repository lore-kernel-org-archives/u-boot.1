Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1F5C021B6
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 11:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF5F80FF9;
	Tue, 25 Feb 2025 12:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KUwDZvVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B23080FDD; Tue, 25 Feb 2025 12:49:27 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EABA6807B1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51PBnCa01221240
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 05:49:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740484152;
 bh=KpF5eoi1G67NYQVxodF1wrg3Ax2ijggoEIrhfjy0uZw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KUwDZvVnRDJDyAdOFil3bLe/GwNphAa3S3bYWPapZ1sGdxa30KMJLotw9tRvfAKwE
 korAk1aMiA0jMKyInAUefQp4F32zggoYcWsh/CBAQ9eZcmA5nekPAMwY43bb4GVY78
 X5Tuv4XyxkJmN1d3y7lyvxGo23Ri/wvwczAubwPM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51PBnC7b026182
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 25 Feb 2025 05:49:12 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Feb 2025 05:49:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Feb 2025 05:49:11 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51PBnBVo026537;
 Tue, 25 Feb 2025 05:49:11 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Michael Walle <mwalle@kernel.org>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Andrew Davis <afd@ti.com>,
 "Alexander Sverdlin" <alexander.sverdlin@siemens.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Chintan Vankar" <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Jayesh Choudhary" <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, "Bryan Brattlof" <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <s-vadapalli@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 04/15] arm: mach-k3: j721s2_spl: Alias Ethernet boot to
 CPGMAC
Date: Tue, 25 Feb 2025 17:18:52 +0530
Message-ID: <20250225114903.2080616-5-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225114903.2080616-1-c-vankar@ti.com>
References: <20250225114903.2080616-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This is required to enable spl_net boot on AM68-SK.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/r/20250219104831.2315464-6-c-vankar@ti.com/

Changes from v2 to v3:
- No changes.

 arch/arm/mach-k3/include/mach/j721s2_spl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/include/mach/j721s2_spl.h b/arch/arm/mach-k3/include/mach/j721s2_spl.h
index d8fae2c8b45..47a61281d94 100644
--- a/arch/arm/mach-k3/include/mach/j721s2_spl.h
+++ b/arch/arm/mach-k3/include/mach/j721s2_spl.h
@@ -12,6 +12,7 @@
 #define BOOT_DEVICE_OSPI		0x01
 #define BOOT_DEVICE_QSPI		0x02
 #define BOOT_DEVICE_SPI			0x03
+#define BOOT_DEVICE_CPGMAC		0x04
 #define BOOT_DEVICE_ETHERNET		0x04
 #define BOOT_DEVICE_I2C			0x06
 #define BOOT_DEVICE_UART		0x07
-- 
2.34.1

