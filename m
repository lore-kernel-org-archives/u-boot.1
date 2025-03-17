Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CD5C28B30
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 04:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FD580F4C;
	Mon, 17 Mar 2025 05:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c+5Q+meN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2354881100; Mon, 17 Mar 2025 05:55:19 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D566E8003E
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 05:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52H4t4AL2175032
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Mar 2025 23:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742187304;
 bh=Z5UOCTpHgttohUe0iiwKh3sMvTUfZVCIxww697Cn9Lc=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=c+5Q+meNuaXtsX8NaNzauoPXG+xarZZMM1c66tmUIh9NYJNf9QCaHMv5LsPGMr3UI
 4hQvxPJWG1HhrkoeHdDj4J89YvwNeb+hYHsJC8VRujOF7JLFlGmnkEqxKNppbm8pOC
 Oy76Ia7oy5CwlJFL3pYGnOZkI/OwYCjySRXLG008=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52H4t3V3007750
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 16 Mar 2025 23:55:03 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 16
 Mar 2025 23:55:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 16 Mar 2025 23:55:03 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H4sXBh058287;
 Sun, 16 Mar 2025 23:54:59 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 17 Mar 2025 10:24:25 +0530
Subject: [PATCH v4 6/8] board: ti: Introduce basic board files for the
 J742S2 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250317-b4-upstream-j742s2-v4-6-4ba88bfd357a@ti.com>
References: <20250317-b4-upstream-j742s2-v4-0-4ba88bfd357a@ti.com>
In-Reply-To: <20250317-b4-upstream-j742s2-v4-0-4ba88bfd357a@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742187273; l=3119;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=UHYM/TLFoxjHQsePWo97k99sD9KSvs3cl/GHamtiQAg=;
 b=Y5vTXIJj69k6g5dMwJLcfZEUtfo0YL8FAL/zr7i8T2l66NVgd/wa8vSQvd1wZNHZyEKFsGu9D
 5QYnj/7nuJ4CIPUWIg/MkSQrkSF+xoD7K0iNwnINmZhoxhCXraG3yH3
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Introduce the basic files needed to support the TI J742S2 family of SoCs.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/mach-k3/j784s4/Kconfig | 18 ++++++++++++++++++
 board/ti/j784s4/Kconfig         | 33 +++++++++++++++++++++++++++++++++
 board/ti/j784s4/j784s4.env      |  4 ++++
 3 files changed, 55 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/Kconfig b/arch/arm/mach-k3/j784s4/Kconfig
index 1eadfb346a3d9fa3b0f02221e2b053b25ace38fd..84194f6efa8d512e660ead75fd42da71b1825f84 100644
--- a/arch/arm/mach-k3/j784s4/Kconfig
+++ b/arch/arm/mach-k3/j784s4/Kconfig
@@ -27,6 +27,24 @@ config TARGET_J784S4_R5_EVM
 	select BINMAN
 	imply SYS_K3_SPL_ATF
 
+config TARGET_J742S2_A72_EVM
+	bool "TI K3 based J742S2 EVM running on A72"
+	select ARM64
+	select BOARD_LATE_INIT
+	select SYS_DISABLE_DCACHE_OPS
+	select BINMAN
+
+config TARGET_J742S2_R5_EVM
+	bool "TI K3 based J742S2 EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+
 endchoice
 
 source "board/ti/j784s4/Kconfig"
diff --git a/board/ti/j784s4/Kconfig b/board/ti/j784s4/Kconfig
index 490c7be66b3ac71204a8ea431743a685fb00735d..de95ac575d799a7e547df6569f24f009d6205f53 100644
--- a/board/ti/j784s4/Kconfig
+++ b/board/ti/j784s4/Kconfig
@@ -35,3 +35,36 @@ config SPL_LDSCRIPT
 source "board/ti/common/Kconfig"
 
 endif
+
+if TARGET_J742S2_A72_EVM
+
+config SYS_BOARD
+       default "j784s4"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "j784s4_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_J742S2_R5_EVM
+
+config SYS_BOARD
+       default "j784s4"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "j784s4_evm"
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
index f5b72c7505e237f56d22d9065b21908f005b6c9f..9e1741be42474cca360b1e719e5b41b0a3ba3e88 100644
--- a/board/ti/j784s4/j784s4.env
+++ b/board/ti/j784s4/j784s4.env
@@ -20,4 +20,8 @@ bootpart=1:2
 bootdir=/boot
 rd_spec=-
 
+#if CONFIG_TARGET_J784S4_A72_EVM
 rproc_fw_binaries= 2 /lib/firmware/j784s4-main-r5f0_0-fw 3 /lib/firmware/j784s4-main-r5f0_1-fw 4 /lib/firmware/j784s4-main-r5f1_0-fw 5 /lib/firmware/j784s4-main-r5f1_1-fw 6 /lib/firmware/j784s4-main-r5f2_0-fw 7 /lib/firmware/j784s4-main-r5f2_1-fw 8 /lib/firmware/j784s4-c71_0-fw 9 /lib/firmware/j784s4-c71_1-fw 10 /lib/firmware/j784s4-c71_2-fw 11 /lib/firmware/j784s4-c71_3-fw
+#elif CONFIG_TARGET_J742S2_A72_EVM
+rproc_fw_binaries= 2 /lib/firmware/j742s2-main-r5f0_0-fw 3 /lib/firmware/j742s2-main-r5f0_1-fw 4 /lib/firmware/j742s2-main-r5f1_0-fw 5 /lib/firmware/j742s2-main-r5f1_1-fw 6 /lib/firmware/j742s2-main-r5f2_0-fw 7 /lib/firmware/j742s2-main-r5f2_1-fw 8 /lib/firmware/j742s2-c71_0-fw 9 /lib/firmware/j742s2-c71_1-fw 10 /lib/firmware/j742s2-c71_2-fw
+#endif

-- 
2.34.1

