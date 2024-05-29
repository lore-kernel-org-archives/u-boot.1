Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111B7C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 13:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8557988611;
	Wed, 29 May 2024 15:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lCHVKqtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 006EA8860F; Wed, 29 May 2024 15:25:09 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E748861D
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 15:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44TDP1Yf102680;
 Wed, 29 May 2024 08:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716989101;
 bh=z45PJnsm48jwQhyKDxp46mGSekI4JjqTgMG0oAlvPzY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lCHVKqtW2+2Rb4whFb6lg0vPg4OtoFVYjoMWiuprdJWYYZlCRVm3w5KkVrDZxeedU
 BPSLhVrpmxuRyReL5Qv2Q12WeAU8giktsDJOQmmOcE2fM+jiehLG9jykQLDh62QhSA
 2+vLlcTb/m5CDv5IT6T35qfhWg7o3DmMODSF67Wo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44TDP1uv019957
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 08:25:01 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 08:25:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 08:25:01 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.102])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44TDP0ju002363;
 Wed, 29 May 2024 08:25:01 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <sumit.garg@linaro.org>,
 <afd@ti.com>, <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
Subject: [PATCH 08/14] ram: k3-ddrss: Enable the am62ax's DDR controller for
 J722S
Date: Wed, 29 May 2024 18:54:42 +0530
Message-ID: <20240529132448.459330-9-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529132448.459330-1-j-choudhary@ti.com>
References: <20240529132448.459330-1-j-choudhary@ti.com>
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

The J722S family of SoCs uses the same DDR controller as found on the
AM62A family. Enable this option when building for the J722S family.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/ram/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 9838a2798f..a64d2dff68 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -65,7 +65,7 @@ choice
 	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
 	default K3_AM64_DDRSS if SOC_K3_AM642
 	default K3_AM64_DDRSS if SOC_K3_AM625
-	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5
+	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S
 
 config K3_J721E_DDRSS
 	bool "Enable J721E DDRSS support"
-- 
2.25.1

