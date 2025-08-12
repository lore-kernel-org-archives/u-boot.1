Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF789CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13968339C;
	Tue, 12 Aug 2025 14:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="psFdtKrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28C68341A; Tue, 12 Aug 2025 14:43:47 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF1083335
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CChixG1447427;
 Tue, 12 Aug 2025 07:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755002624;
 bh=KURJRHengpol5qAR1myi4ySipWWI/XKhVDzK3Ih0itc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=psFdtKrc6bQmjfR5qoEXGlkMkYTrM48PM/OoySxwhPsoER4l9X6syTw62XwZ59S0i
 url2pXrNFX9qKyemHBq2t8c50/MQ9qhVtsIK1vDzrFdKUROEKgWn3TgJFXjtA0ODth
 YX4Ui2l+0yNYGRo5tMl6Q4wNno04i37OvvsWWa5M=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CChiRU300961
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 12 Aug 2025 07:43:44 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 07:43:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 07:43:43 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CChPlE653236;
 Tue, 12 Aug 2025 07:43:41 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 5/9] ram: k3-ddrss: Add CONFIG_K3_MULTI_DDR
Date: Tue, 12 Aug 2025 18:13:20 +0530
Message-ID: <20250812124324.124306-6-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812124324.124306-1-n-francis@ti.com>
References: <20250812124324.124306-1-n-francis@ti.com>
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

As we increase the functionalities that the K3 DDRSS sub-system support,
it is becoming more evident that the same logic cannot apply to both
single as well as multiple DDR controller devices. Add
CONFIG_K3_MULTI_DDR to be used to differentiate between the two.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
No change since v2

 drivers/ram/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index edb8e254d5b..5fc107e61b2 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -128,6 +128,16 @@ config K3_INLINE_ECC
 	  need to be primed with a predefined value prior to enabling ECC
 	  check.
 
+config K3_MULTI_DDR
+	bool "Enable support for multiple K3 DDRSS controllers"
+	depends on K3_DDRSS
+	help
+	  Enabling this option adds support for configuring multiple DDR memory
+	  controllers for K3 devices. The external memory interleave layer
+	  present in the MSMC (Multicore Shared Memory Controller) is
+	  responsible for interleaving between the controllers.
+	default y if SOC_K3_J721S2 || SOC_K3_J784S4
+
 source "drivers/ram/aspeed/Kconfig"
 source "drivers/ram/cadence/Kconfig"
 source "drivers/ram/octeon/Kconfig"
-- 
2.34.1

