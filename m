Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69341E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B95980137;
	Mon,  6 Jan 2025 10:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dUFSfwCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 000B880570; Mon,  6 Jan 2025 10:35:56 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B663680137
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5069Znli2468171
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jan 2025 03:35:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736156149;
 bh=Z5UOCTpHgttohUe0iiwKh3sMvTUfZVCIxww697Cn9Lc=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=dUFSfwCmL1Qz8nwBhoBfZBZLmsj+Jlehg8KfPcw2+IupIs2q+N14AwmZn5P8G7ryg
 rAzFMIWHFwdX/t3Ba9TC9NCow4p5bPbt9aMzkUhF/JUNmHjO0E38zK9uyRbHQtriFa
 dNdLBBgl/tNyWFsMOcDXIAG2M5x94kU5PtAnPpE0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5069Zn0M003866
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Jan 2025 03:35:49 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 03:35:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 03:35:48 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.160])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5069ZJF4028930;
 Mon, 6 Jan 2025 03:35:45 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 6 Jan 2025 15:05:02 +0530
Subject: [PATCH RFC v2 6/8] board: ti: Introduce basic board files for the
 J742S2 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250106-b4-upstream-j742s2-v2-6-42d6129ce333@ti.com>
References: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
In-Reply-To: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736156119; l=3119;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=UHYM/TLFoxjHQsePWo97k99sD9KSvs3cl/GHamtiQAg=;
 b=G5SyHS3h+8aN1dUHCZN4IOL8KGJ6UmrSlG8KsNDG6GPsecFkR9QnU45YvmLgeD9Aawfr3Ugb5
 ezxWsv0LhIxDVMfofl9AbXWFDmX6cseduZO2IFwa2HT1AFC9kYGt7Ys
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

