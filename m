Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C53C54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C03088075;
	Wed, 28 Feb 2024 12:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G+jrHEeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E60D588075; Wed, 28 Feb 2024 12:21:00 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D493987F95
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SBKqC5005783;
 Wed, 28 Feb 2024 05:20:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709119252;
 bh=SeY0Zj5ISzgB4d0xhARij2SxErZHx+8q2p74Ng8f0MM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=G+jrHEeEzGgRRXVhmXqQltuPq99IVlVBmAj4vbpDoJQLejPn3D8yg/5TJuLkYPnio
 jY/sJVFQ1vp+JWy/87ytV8WtUEC61scShJcMdag/SZXKg6/HoJAgCI1BLgBCQ7CZ1F
 ouwWL1OXIhKVUZcIYeLk8rU3D5fOETH+f//xLf7s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SBKqim112488
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 05:20:52 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 05:20:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 05:20:52 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SBKgNg027918;
 Wed, 28 Feb 2024 05:20:47 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [RFC PATCH 1/4] configs: j721e_sk: Move to separate defconfig for
 J721E SK board
Date: Wed, 28 Feb 2024 16:50:39 +0530
Message-ID: <20240228112042.3437691-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228112042.3437691-1-n-francis@ti.com>
References: <20240228112042.3437691-1-n-francis@ti.com>
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
 board/ti/j721e/MAINTAINERS      | 2 ++
 configs/j721e_evm_a72_defconfig | 2 +-
 configs/j721e_evm_r5_defconfig  | 2 +-
 configs/j721e_sk_a72_defconfig  | 4 ++++
 configs/j721e_sk_r5_defconfig   | 5 +++++
 5 files changed, 13 insertions(+), 2 deletions(-)
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
index 74af5bebb51..21081a2a684 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -86,7 +86,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="k3-j721e-common-proc-board k3-j721e-sk"
+CONFIG_OF_LIST="k3-j721e-common-proc-board"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index bc4f35cce11..ce2b7df58cf 100644
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
index 00000000000..c47ad4a7616
--- /dev/null
+++ b/configs/j721e_sk_a72_defconfig
@@ -0,0 +1,4 @@
+#include <configs/j721e_evm_a72_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-sk"
+CONFIG_OF_LIST="k3-j721e-sk"
diff --git a/configs/j721e_sk_r5_defconfig b/configs/j721e_sk_r5_defconfig
new file mode 100644
index 00000000000..077e8606d57
--- /dev/null
+++ b/configs/j721e_sk_r5_defconfig
@@ -0,0 +1,5 @@
+#include <configs/j721e_evm_r5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-r5-sk"
+CONFIG_SPL_OF_LIST="k3-j721e-r5-sk"
+CONFIG_OF_LIST="k3-j721e-r5-sk"
-- 
2.34.1

