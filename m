Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6458BC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA0DD880CC;
	Wed, 22 May 2024 16:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LJyYJVYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E1F8829E; Wed, 22 May 2024 06:53:51 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 656238846F
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 06:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M4rgmk120956;
 Tue, 21 May 2024 23:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716353622;
 bh=v0o9CivFk6/EN3E8ktpm4nJ7o1GNn0mQvf/nT02vEAc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LJyYJVYOCNLQZsIYLM2bG/NTTPrcz+hmQ+cSz2abpEmwiyE4C9EURcqR33flCq2Wm
 xphyGhy/p3zEh8EOr+X/Fq6UvXL1x2JhGXuEa7G5ObIh46YuZs8pMdneHt5plGzXpI
 DQQMOJWwfToeJZacAqGf2RDOxgtO5FXj2olYoHjI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M4rg4P063942
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 May 2024 23:53:42 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 23:53:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 23:53:41 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M4rWBO067123;
 Tue, 21 May 2024 23:53:37 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>
CC: <m-chawdhry@ti.com>, <n-jain1@ti.com>, <mkorpershoek@baylibre.com>,
 <rogerq@kernel.org>, <afd@ti.com>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <kamlesh@ti.com>, <clamor95@gmail.com>, <marcel.ziswiler@toradex.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 1/2] configs: j784s4_evm_a72_defconfig: Enable remoteproc
 drivers
Date: Wed, 22 May 2024 10:23:30 +0530
Message-ID: <20240522045331.503472-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522045331.503472-1-b-padhi@ti.com>
References: <20240522045331.503472-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 22 May 2024 16:50:33 +0200
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

The K3 J784S4 SoC has four dual-core R5F subsystems and four C71x DSP
subsystems. Set config values to enable the remoteproc functionality
with these R5F and DSP subsystems.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index bb9603bef0f..158d064c19c 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
@@ -134,6 +135,8 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
+CONFIG_REMOTEPROC_TI_K3_DSP=y
+CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
-- 
2.34.1

