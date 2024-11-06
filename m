Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BEDD29F9D
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 06:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC2A891D4;
	Wed,  6 Nov 2024 07:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vD40tK9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 911AD891D2; Wed,  6 Nov 2024 07:39:41 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF148919A
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 07:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A66daa1074686;
 Wed, 6 Nov 2024 00:39:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730875176;
 bh=X0OB9oNGQI/Kx1vshP6e1U4NTKFHrhD+gF6lqBLmD2w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vD40tK9W0dZZmi9xjMY3uSO9iE5YYGKvrX1ff8ph3rtVyDXFbKobIaKtTj1G41bTw
 QH8l2GRKwDxR+telNzUJo9bGxa8VPNTWGkc6DC1fLzPghANw0L6az0qK7NHsVIPOza
 ZvLsLY1iKHugGpOcc3hBPGRkTR8NElYweGVuD1bw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A66daL0008237
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Nov 2024 00:39:36 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 00:39:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 00:39:35 -0600
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.68.218])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A66dZVa129219;
 Wed, 6 Nov 2024 00:39:35 -0600
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <bb@ti.com>
CC: <vaishnav.a@ti.com>, <afd@ti.com>, <n-francis@ti.com>, <seanga2@gmail.com>,
 <francesco.dolcini@toradex.com>, <sjg@chromium.org>,
 <w.egorov@phytec.de>, <devarsht@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH 3/4] configs: j722s_evm_r5_defconfig: Enable CONFIG_K3_QOS
Date: Wed, 6 Nov 2024 12:09:29 +0530
Message-ID: <20241106063930.59870-4-j-choudhary@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106063930.59870-1-j-choudhary@ti.com>
References: <20241106063930.59870-1-j-choudhary@ti.com>
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

Enable CONFIG_K3_QOS to set QoS registers in R5 boot stage.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 configs/j722s_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index e574be9e19..d119e46ff1 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -91,6 +91,7 @@ CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
+CONFIG_K3_QOS=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
-- 
2.34.1

