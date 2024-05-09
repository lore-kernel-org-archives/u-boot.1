Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D0CC25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 16:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF1E884A1;
	Thu,  9 May 2024 18:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q+QuhxV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB77882F3; Thu,  9 May 2024 18:41:50 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F4E8825A
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 18:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449GfZAi004867;
 Thu, 9 May 2024 11:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715272895;
 bh=GMXGGO2m23vqtCE8AoAx7sfO3Zlva1iGH7QS9bN3/Gk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Q+QuhxV1AyzIKeBBI2NkyMWzSCbO1GqN+Vjnx61wmMLdNJXE7NkytIGqFG+SBJfur
 ghDuJNBjRVgMB+3G81Hdyc8kgkBCPqJTGosYe5WOFtxysaHFLxpzoEMGzoh1SvqbNb
 cRIyE7nY7qtSueumRp9QjzbJXRXWzOKz6xrr0A30=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449GfZ7t020136
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 11:41:35 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 11:41:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 11:41:35 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449GfZC1063038;
 Thu, 9 May 2024 11:41:35 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v4 09/19] configs: beagleplay: Enable DFU for MMC
Date: Thu, 9 May 2024 11:41:13 -0500
Message-ID: <20240509164123.1753050-10-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509164123.1753050-1-j-humphreys@ti.com>
References: <20240509164123.1753050-1-j-humphreys@ti.com>
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

MMC DFU is required for capsule updates.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 configs/am62x_beagleplay_a53_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index 4f1be1df593..933baba9211 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -70,6 +70,9 @@ CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_CLK_TI_SCI=y
+CONFIG_DFU_MMC=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x180000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
-- 
2.34.1

