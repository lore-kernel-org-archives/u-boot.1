Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38BDC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FAEE87BAF;
	Fri, 29 Dec 2023 18:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zODFjuwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2173087BD2; Fri, 29 Dec 2023 18:47:13 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C241E87B6B
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1LN032438;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=5JtXg/3o50SPxyZeOPeGQdl5xBtNLAJOfOmUv1VmFbE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=zODFjuwBdlvSUJhIT+9ZWU8YWlQeSIIdIOKet8N7QEp30qWrCQpCzg/WGll3fA2gP
 K/wyii/dCyNNYjmFxioZw7DLnZ5SWzbPL3Pr8mwgTx/IGE7NAtr+uPLpjYx6UZIZiM
 rYGfC1nCIfXlpCKNULZrpb7KKTJNRfo6WRL2KbvQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1P9063447
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:00 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl0X9122668;
 Fri, 29 Dec 2023 11:47:00 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 01/26] configs: am65x_evm_r5: enable driver for fixed
 regulators
Date: Fri, 29 Dec 2023 11:46:58 -0600
Message-ID: <20231229174656.634065-29-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=781; i=bb@ti.com;
 h=from:subject; bh=Vxv1Vi+jpwRzSoPEZjSu/UEpPZue0vZ9Zei8dmW3r9Q=;
 b=owNCWmg5MUFZJlNZb3NjsQAAaf///79//rP+/rn3K//zkpt3ff9v3JTT3e5/0Z7e5v/X0v+wA
 RmYHagAAAABkAAAeo00aAAGgNAAAAAHqAGgDQAek0eppoxM1HqPUD1PU8FEA2kMmg0aaaMg0000
 A0AyMgDJkA0AaBkBoaGQNGj0mhhBoNNDQB6mg0B6gwjTQZQep6ho2o0MQDT1BkNGmgDJtRoA0GQ
 BkBkNBkAAYQGjTI0GIAZAZGgyDQABB1xmjWBYIvSEOvA4GX7VeSA4nJEYKlgw9WEggFoofH0ALR
 zsnslbrSWBOJE7+50/FEA9mZPIljAVaI4hn7UqjOdCnTojI4SX3Fq9L9kHS06AF3PU5aUy8ARr7
 RyTU7sDCj60IBfjY7jv+2Ds03yFv02fgAm1DKTIdlxA70DosGs3irXj+ZhrPCqe525knJm7MKqU
 dwLEoN/uW4L+6JCQKBc5FkILXS7ScXyXwO2zVXolfKhcI50GL5cUwsVKT3mnmgVcgIxMDF+iVmy
 abDpcr02SFXx2lPWWV0pUY5k4Atn7rH7r2wuwRy1YaQYa2r2C+PSHokiUz5I37FTEN8U0iWW7sD
 ND2cpFNDFJ/YQAwEQBYtC2y/klRC1fD9coATWpQln0ajaSrj6DoiOc0z+wcYkrmXFBoAEJYRsHi
 jsacg5ecad/i7kinChIN7mx2IA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Some of the regulators we need to successfully boot are fixed
regulators. Enable the driver to properly probe them.

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 configs/am65x_evm_r5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index b2f1e721b36d0..b892f2eb8c5f9 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -118,6 +118,8 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS62360=y
-- 
2.43.0

