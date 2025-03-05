Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8805EC282D9
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 06:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 186DE80BAA;
	Wed,  5 Mar 2025 07:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q1Z9Clj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9533810ED; Wed,  5 Mar 2025 07:14:04 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144BF80F9E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 07:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5256DwTP3205208
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Mar 2025 00:13:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741155238;
 bh=jxUUBQ6sZXNd83M8CN4jZ2t51srtgr6OM1UgM2OVUPU=;
 h=From:To:CC:Subject:Date;
 b=Q1Z9Clj5d1mZGecaFEQO0ZQYlVoLpiYAxuu5tKBPzOsgF+OTY6KKG7cppj4Jg7L4u
 jidKWu1BtCV7C1L7lxGNZsFvwQ0va/NRAzP7OY9Fh7d/0o3axXaKuNWneI0oQttwgg
 clOelKzQ+cBJ/GWyFV1TDcY1DpBDqf/+l4wkx1JI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5256DvVv016540
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Mar 2025 00:13:57 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 00:13:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 00:13:57 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5256DrTM010040;
 Wed, 5 Mar 2025 00:13:54 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <j-humphreys@ti.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <afd@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <b-padhi@ti.com>, <sjg@chromium.org>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH v2] configs: j784s4-am69: Enable UFS
Date: Wed, 5 Mar 2025 11:43:51 +0530
Message-ID: <20250305061351.1102484-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

J784S4 EVM board has UFS flash, So enable UFS configs

Cc: Neha Francis <n-francis@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Changelog:
Changes in v2:
- Rebased with next sha id: 986ab810fa2
- link to v1  https://lore.kernel.org/all/20250217081712.1866257-1-u-kumar1@ti.com/

Bootlogs
https://gist.github.com/uditkumarti/2c45f69a14d2f1fd5ec70920f0df382a

 configs/am69_sk_a72_defconfig    | 5 +++++
 configs/j784s4_evm_a72_defconfig | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/configs/am69_sk_a72_defconfig b/configs/am69_sk_a72_defconfig
index 452de887258..bd8aaf7f201 100644
--- a/configs/am69_sk_a72_defconfig
+++ b/configs/am69_sk_a72_defconfig
@@ -5,5 +5,10 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J784S4=y
 CONFIG_TARGET_J784S4_A72_EVM=y
 
+CONFIG_CMD_UFS=n
+CONFIG_UFS=n
+CONFIG_CADENCE_UFS=n
+CONFIG_TI_J721E_UFS=n
+
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am69-sk"
 CONFIG_OF_LIST="ti/k3-am69-sk"
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 1ba2bfed2cf..1280194c7a7 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -170,5 +170,9 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6168
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
+CONFIG_CMD_UFS=y
+CONFIG_UFS=y
+CONFIG_CADENCE_UFS=y
+CONFIG_TI_J721E_UFS=y
 
 #include <configs/k3_efi_capsule.config>
-- 
2.34.1

