Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D286AC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 07:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD4987669;
	Tue, 28 Nov 2023 08:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VUb3+GQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA8C86F68; Tue, 28 Nov 2023 08:20:28 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C9B87657
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS7KMZX028216;
 Tue, 28 Nov 2023 01:20:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701156022;
 bh=Ni7MPIc41eEBhR9BttXMAQtHdpyE3nMq/oVN+Qn6M9c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VUb3+GQ+QUI3thhj7Gq2xf/pGKzz0/XOgg+dAtE/O1IahCvJqzoX/eh9bF+4W52pF
 Kc6M8xia6+Q2lLvKE+xGUr7Iu001sjbcKcd0coLERLHI8lccwLBt5hKwxY+p02g6JC
 0J2GXCK7PXGeEke4Jqft3NRJWK8yi6PAw0Qi8fCE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS7KMfM023970
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Nov 2023 01:20:22 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 01:20:21 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 01:20:21 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS7KEsG002840;
 Tue, 28 Nov 2023 01:20:19 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <rogerq@kernel.org>, <n-francis@ti.com>,
 <u-kumar1@ti.com>
Subject: [PATCH 2/2] configs: j721e_evm_a72_defconfig: Switch to bootstd
Date: Tue, 28 Nov 2023 12:50:13 +0530
Message-ID: <20231128072013.440465-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128072013.440465-1-n-francis@ti.com>
References: <20231128072013.440465-1-n-francis@ti.com>
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

Switch to using bootstd. Note that with this change, we will stop using
distro_bootcmd and instead depend entirely on bootflow method of
starting the system up.

Also config_distro_bootcmd.h header file that is no longer needed in
j721s2_evm.h.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 configs/j721s2_evm_a72_defconfig | 5 +++--
 include/configs/j721s2_evm.h     | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index a7adb9282b..04bc6a4449 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -29,9 +29,10 @@ CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_LOGLEVEL=7
 CONFIG_SPL_MAX_SIZE=0xc0000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/include/configs/j721s2_evm.h b/include/configs/j721s2_evm.h
index 692c6bb5e4..02673ae798 100644
--- a/include/configs/j721s2_evm.h
+++ b/include/configs/j721s2_evm.h
@@ -10,7 +10,6 @@
 #define __CONFIG_J721S2_EVM_H
 
 #include <linux/sizes.h>
-#include <config_distro_bootcmd.h>
 
 /* DDR Configuration */
 #define CFG_SYS_SDRAM_BASE1		0x880000000
-- 
2.34.1

