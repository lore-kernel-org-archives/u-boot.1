Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD51FCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 10:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF8F835B0;
	Wed, 22 Oct 2025 12:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jNCNpT7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FAFF836C1; Wed, 22 Oct 2025 12:26:27 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F03835A2
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 12:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MAQNOH1381932;
 Wed, 22 Oct 2025 05:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761128783;
 bh=Sk1cygEvi0xi5xgM6Li2ljwu2YCuGC0TIDgxBbnuhgg=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=jNCNpT7oRIAnn8gPHOoY6RRf46af25ylMukxTSxyJFU/ksNgwkS8j+7v2rhKIAZAl
 e7/hcxH4y8QIOldVf3glWV7Goh3wOTbq1gd+1jb3JZEW45dVBv0sf3N3TVgvIDRiOS
 S76LGU8MvLxO25MU0D0A4uXegKSQPt6jbadYBYFk=
Received: from DFLE203.ent.ti.com (dfle203.ent.ti.com [10.64.6.61])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MAQN5I2281674
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Oct 2025 05:26:23 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:26:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 05:26:22 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MAQLkO1048668;
 Wed, 22 Oct 2025 05:26:22 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 22 Oct 2025 15:55:42 +0530
Subject: [PATCH 6/8] configs: add defconfigs for am6254atl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251022-62sip_support-v1-6-eed08d15e76d@ti.com>
References: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
In-Reply-To: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761128770; l=2585;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=qAIBojmNZlQPr0BOFOqygtTkwdNqigMzuJXBoh9q8kU=;
 b=3MVev8Iw3xpD358Tv/p0HleJ6hJJzYdyM7gyC/l11VnTOq1TvOCWjui+4rVYv9xoFTAxK/sSZ
 hKL/MPmAaSfBJffQtBO/Lp1NPfvZ9S6mmxVE/+9hPOjroB0x6A7jscT
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
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

OP-TEE for current K3 devices resides from 0x9e800000 to 0xa0000000
which needs to be moved to 0x80080000 to free up space at end of DDR in
systems with 512MiB of memory. This is required to allow U-Boot to
relocate to end of DDR before booting to the kernel.

Therefore defconfigs for AM6254atl include the respective existing AM62x
configs with updated dt for r5 and modified memory map for a53 SPL to
account for the new OP-TEE address.

Also make Bryan Brattlof and Tom Rini the maintainers for AM6254atl SIP.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/am62x/MAINTAINERS          |  2 ++
 configs/am6254atl_evm_a53_defconfig | 15 +++++++++++++++
 configs/am6254atl_evm_r5_defconfig  |  9 +++++++++
 3 files changed, 26 insertions(+)

diff --git a/board/ti/am62x/MAINTAINERS b/board/ti/am62x/MAINTAINERS
index d7dfefffe751b5f3a1292ef8cc9e2926f09c77ae..ca269fae880357eb9f62232a3a32bbafa8b3d29d 100644
--- a/board/ti/am62x/MAINTAINERS
+++ b/board/ti/am62x/MAINTAINERS
@@ -10,3 +10,5 @@ F:	configs/am62x_evm_r5_ethboot_defconfig
 F:	configs/am62x_evm_a53_ethboot_defconfig
 F:	configs/am62x_lpsk_r5_defconfig
 F:	configs/am62x_lpsk_a53_defconfig
+F:	configs/am6254atl_evm_r5_defconfig
+F:	configs/am6254atl_evm_a53_defconfig
diff --git a/configs/am6254atl_evm_a53_defconfig b/configs/am6254atl_evm_a53_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..fdf6be7068e7b2fe4e48f1f322703f6838729497
--- /dev/null
+++ b/configs/am6254atl_evm_a53_defconfig
@@ -0,0 +1,15 @@
+#include <configs/am62x_evm_a53_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_A53_EVM=y
+CONFIG_TEXT_BASE=0x82f80000
+CONFIG_BLOBLIST_ADDR=0x82c80000
+CONFIG_SPL_TEXT_BASE=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0x83f80000
+CONFIG_K3_OPTEE_LOAD_ADDR=0x80080000
+CONFIG_SPL_BSS_START_ADDR=0x82c00000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82f80000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b00000
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am6254atl-sk"
diff --git a/configs/am6254atl_evm_r5_defconfig b/configs/am6254atl_evm_r5_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..852c3cfd144166dd2d4db4098c8e204358ac1536
--- /dev/null
+++ b/configs/am6254atl_evm_r5_defconfig
@@ -0,0 +1,9 @@
+#include <configs/am62x_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_R5_EVM=y
+CONFIG_K3_OPTEE_LOAD_ADDR=0x80080000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+CONFIG_DEFAULT_DEVICE_TREE="k3-am6254atl-r5-sk"

-- 
2.51.0

