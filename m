Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF55DC27C79
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C4588A01;
	Fri, 14 Jun 2024 14:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CIGccL0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8602C889D8; Fri, 14 Jun 2024 14:45:02 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4CB889F3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ECiuBK070924;
 Fri, 14 Jun 2024 07:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718369096;
 bh=Q4Wx5tL3oQ6uBjAepoU046mCyHfoU1eLDVg7ZTN9HkM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CIGccL0qKNzZXIKBsNyAy41ahUI4OVybPcE7yl1Zgm3xSO0ugtPIbWw3m4lyZsiv0
 JgDeh9DP/ntepj/VlHmGFryNmw+5musm9ZZyfHGRnFz0hHylGPFeqoUWAyVhn8oulQ
 O9B8NMWaJMfmY6Ba0YqwWvBGS+/bXMQDeDENlWzU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ECiu4N032565
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 07:44:56 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 07:44:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 07:44:56 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.55])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ECit9V047391;
 Fri, 14 Jun 2024 07:44:55 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <a-bhatia1@ti.com>, <afd@ti.com>, <j-choudhary@ti.com>
CC: <n-francis@ti.com>, <nm@ti.com>, <joao.goncalves@toradex.com>,
 <j-humphreys@ti.com>, <d.haller@phytec.de>, <hnagalla@ti.com>,
 <bb@ti.com>, <seanga2@gmail.com>, <sjg@chromium.org>,
 <clamor95@gmail.com>, <martyn.welch@collabora.com>,
 <m-chawdhry@ti.com>, <a-limaye@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 8/8] configs: j784s4_evm_r5_defconfig: Enable CONFIG_K3_QOS
Date: Fri, 14 Jun 2024 18:14:42 +0530
Message-ID: <20240614124442.178280-9-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614124442.178280-1-j-choudhary@ti.com>
References: <20240614124442.178280-1-j-choudhary@ti.com>
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

Enable CONFIG_K3_QOS to set QoS registers in R5 boot stage.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 configs/j784s4_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index f5fe743220..d1bcf792d7 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -6,6 +6,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_SOC_K3_J784S4=y
 CONFIG_K3_EARLY_CONS=y
+CONFIG_K3_QOS=y
 CONFIG_TARGET_J784S4_R5_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41c76000
-- 
2.25.1

