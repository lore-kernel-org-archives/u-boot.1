Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ACBC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 13:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487D4881BC;
	Fri, 22 Mar 2024 14:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c9bgjjkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBAC3881A9; Fri, 22 Mar 2024 14:10:33 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F022E881AC
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 14:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42MDALEJ004801;
 Fri, 22 Mar 2024 08:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711113021;
 bh=+3mXuYAy+wJ0QcKz4of1cS6ea5hZEiMrFv1LYTXIxmg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=c9bgjjkkC2Oj7SY3riu37uzn9PBUb8Kuup5mgUkQRNYbWYukJ7MsX6zZ6P3pVInwY
 XdW3rFOx3oVNF2NzvbOtkRIGt1tMs4EO28cN8OzeZniqf+FcYjFLVmfO14WjNziesa
 6Eghi9NpbpIYzBmaeVaakT5xHQzZih1sxpL2tN9w=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42MDALwK005551
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Mar 2024 08:10:21 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Mar 2024 08:10:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Mar 2024 08:10:21 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42MDABZ8026606;
 Fri, 22 Mar 2024 08:10:17 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 1/4] configs: j721e_sk: Move to separate defconfig for J721E
 SK board
Date: Fri, 22 Mar 2024 18:40:08 +0530
Message-ID: <20240322131011.1029620-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322131011.1029620-1-n-francis@ti.com>
References: <20240322131011.1029620-1-n-francis@ti.com>
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

Add defconfig for J721E SK R5 and A72 configuration.

This includes and modifies the J721E EVM defconfigs:
j721e_evm_r5_defconfig -> j721e_sk_r5_defconfig
j721e_evm_a72_defconfig -> j721e_sk_a72_defconfig

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 board/ti/j721e/MAINTAINERS      |  2 ++
 configs/j721e_evm_a72_defconfig |  2 +-
 configs/j721e_evm_r5_defconfig  |  2 +-
 configs/j721e_sk_a72_defconfig  |  9 +++++++++
 configs/j721e_sk_r5_defconfig   | 10 ++++++++++
 5 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 configs/j721e_sk_a72_defconfig
 create mode 100644 configs/j721e_sk_r5_defconfig

diff --git a/board/ti/j721e/MAINTAINERS b/board/ti/j721e/MAINTAINERS
index f5ca7d06a34..06aba53d9b0 100644
--- a/board/ti/j721e/MAINTAINERS
+++ b/board/ti/j721e/MAINTAINERS
@@ -5,5 +5,7 @@ F:	board/ti/j721e
 F:	include/configs/j721e_evm.h
 F:	configs/j721e_evm_r5_defconfig
 F:	configs/j721e_evm_a72_defconfig
+F:	configs/j721e_sk_r5_defconfig
+F:	configs/j721e_sk_a72_defconfig
 F:	configs/j7200_evm_r5_defconfig
 F:	configs/j7200_evm_a72_defconfig
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 019ddcca7e8..34f7eeebbd5 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -85,7 +85,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="k3-j721e-common-proc-board k3-j721e-sk"
+CONFIG_OF_LIST="k3-j721e-common-proc-board"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index 4d4b96dec6b..49da2550ead 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -81,7 +81,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
-CONFIG_SPL_OF_LIST="k3-j721e-r5-common-proc-board k3-j721e-r5-sk"
+CONFIG_SPL_OF_LIST="k3-j721e-r5-common-proc-board"
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/j721e_sk_a72_defconfig b/configs/j721e_sk_a72_defconfig
new file mode 100644
index 00000000000..8907b8ae58f
--- /dev/null
+++ b/configs/j721e_sk_a72_defconfig
@@ -0,0 +1,9 @@
+#include <configs/j721e_evm_a72_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J721E=y
+CONFIG_TARGET_J721E_A72_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-sk"
+CONFIG_OF_LIST="k3-j721e-sk"
diff --git a/configs/j721e_sk_r5_defconfig b/configs/j721e_sk_r5_defconfig
new file mode 100644
index 00000000000..b361c691747
--- /dev/null
+++ b/configs/j721e_sk_r5_defconfig
@@ -0,0 +1,10 @@
+#include <configs/j721e_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J721E=y
+CONFIG_TARGET_J721E_R5_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-r5-sk"
+CONFIG_SPL_OF_LIST="k3-j721e-r5-sk"
+CONFIG_OF_LIST="k3-j721e-r5-sk"
-- 
2.34.1

