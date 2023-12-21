Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4255C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FAC687956;
	Thu, 21 Dec 2023 18:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ue+7fCz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 373B487886; Thu, 21 Dec 2023 18:44:34 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16C2878EB
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEl7027113;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=wtY1NnIV3TxuAUShkcF3d+7DfOoirjNNZ94yP7rKJ20=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ue+7fCz+vO0fyfcr+4vNqxYXKLTySYBOpH8vbkux7MuWi9TuyshKgarNVsyJfxzOH
 L4tqjjEIHRh+EammbhyUvqYwpAXegcHERegaFbAXhCNdCwX6/8JZet+/etip94TTO8
 PyvsG6uUCy1zv/PvMY4MJgLP8NxEmIH5IwwiLdrc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiEpl032080
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:13 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiD2v069230;
 Thu, 21 Dec 2023 11:44:13 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 01/26] configs: am65x_evm_r5: enable driver for fixed
 regulators
Date: Thu, 21 Dec 2023 11:43:47 -0600
Message-ID: <20231221174412.210807-2-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=739; i=bb@ti.com;
 h=from:subject; bh=IGRM62/usQtj8uIoHplnF76+wdG27KFkIYf9GAvzbMg=;
 b=owNCWmg5MUFZJlNZsu4G6wAAZv////9/v2e+bXLf3Lu2V/x7j87/R35Xuf7dTn8fvtLn9uawA
 RtqI7UGmgDQaA00NANBhA0GhkAAGQ000AA0GmmjQMQNBoDI00aMCaNNNP1Rk8UyHJoA00NNBkaA
 bUaBp6mIZDT1GgMgAaAB6hppk00DTQ0ZDTRoAYQ9I9RhAAaND0OTT0QYmhpgTIGjEaYmTEyMgGj
 IMgDJgRiDQDBAAAANME0AaAAAGAAeIeu5g18BIh5I0xwbkrGa6qxWHf+bFDpMFTj+gHjBulfM26
 Ti7wZnIuu5BTCsyEf6YwHgx/4ICXdX+d+htkIp2MNNLMBKqSaInakagFARW/OlXYb2tmEez30Ln
 4srMfdnRybNwFrbbaOBGyFFyApHPgSzhp5uvZ9sejGg51Spm6JgPlobBrCiF2pthLDV6Qu4S4co
 vVkEANaSnK3HDKeroy5/AJEuCxZhDk20/awvI1DZGi9QRvQN4MT2nAZQhlQrqujym57zWJDDFbP
 hmyhJSmYLkYQCRYNkkXfPjBJXMdsFyLcRFxkS7JivTltNh+vw53QC/Sn1ZIIhwffNRIGETmx32l
 CWmDxVxtdRyFEKhAQuncS8/CYyWWNQzisIe9eIIw6+Fk9IUZvb+5cEGZlgfFFfKCD3Qi9doEMCW
 TqkeuufC7kinChIWXcDdYA=
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

