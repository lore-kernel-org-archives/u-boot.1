Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04672C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4EAE4074C;
	Mon, 17 Aug 2026 15:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iHO0pbfL8jHq; Mon, 17 Aug 2026 15:38:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94E7940720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981130;
	bh=Lup5TsRzXtzcHMB+eMjNSGd2dcff0C5qMNDvrpnJAEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=okFcpoh6RGkRVfdiXG2h0lcSBRJ88LktBeW2mDrfMXnj62DICzkhMn4vrpX4zCAtW
	 na3NSFtnCQVZ2PTqscP9Pk5N1/kXdyxPvrYQxEDXWpUN4IVibJ3EcAZIbV9ZjOubpu
	 bRYupXfFr5/NC153HSRX21ot3CzT7EphnR7gE2RX9IOOZwl+E9yg/CXdUOxk0pbhLM
	 DzY41+NPi9/FEOOJ1LUGPGT96HgDNh7wRB7quBc1fVIeyzMny799tlarrlYR1wAzQV
	 UmI2og37jfaGfyTpRq4tdmyIe+9wfQpxQuZKeyTfLtL/3qPb5cnwwZwP7LxRplof34
	 3RwjpkhZyyKbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94E7940720;
	Mon, 17 Aug 2026 15:38:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AA860282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D388401E3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id htR83tvYlnR9 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:38:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8697F401DF
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8697F401DF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=dTYihCWC
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8697F401DF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id C1BEFB0053D;
 Mon, 17 Aug 2026 17:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786981125;
 bh=wTE+Ug07RhihhiGwfxOgPjpgV0+l+rSIqIGgMXuAWF8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dTYihCWC6Cp3eBQqYPJ9kA3HNnWxLi9j6A8LxFStg9/n376BEGcrwg55Sn2xfQEtz
 ZylQuyI0fRYyMuSWJ3KzeXJIyapOytK0w2dd27LHlltifMspxZAp1g7Yawxuxy7ylv
 rAInxbhsBiTfEhJ00WdpKGL7Rm76qA2O6bBYD9/lNdL8vl8sDdymIwcbWFusGzf0sy
 oNEvlRyCZU8nHyCf0CHHkAgjSinINdL9owNeua3Q/Dwz3fkGrTlEy6nL3EC7TEyZ9x
 ZS88q5SxZ6yJpWXGCJTTpmE9MERYRH35OUqLV6CEKFed4cCAFLJPWpXbtBpmqsxo6g
 Fef+Bh6NFV9EA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 23/23] board: nbxv3: add the boot environment (FIT over MC,
 MC memory, PS1)
Date: Mon, 17 Aug 2026 17:31:41 +0200
Message-ID: <20260817153144.1951036-24-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add the production boot environment in CFG_EXTRA_ENV_SETTINGS. The
kernel FIT at NOR offset 0x1000000 carries the kernel,
DTB, optional ramdisk and the LX2160A management complex artefacts
(mc, dpc-<carrier>, dpl-<carrier>) as sub-images.

The usage of those variables is described in doc/board/nxp/nbxv3.rst.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 configs/nbxv3_tfa_defconfig |  8 ++++++++
 include/configs/nbxv3.h     | 40 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index a4c8419f0c3..bc90bb0594c 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -25,8 +25,12 @@ CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyAMA0,115200 earlycon=pl011,mmio32,0x21c0000 nokaslr"
+CONFIG_USE_PREBOOT=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_LAST_STAGE_INIT=y
 # CONFIG_ID_EEPROM is not set
@@ -52,8 +56,12 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=3
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="lanconsole0"
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_FSL_CAAM=y
 CONFIG_DYNAMIC_DDR_CLK_FREQ=y
 CONFIG_DDR_ECC=y
diff --git a/include/configs/nbxv3.h b/include/configs/nbxv3.h
index 287f4110a7c..c266e0f9fe2 100644
--- a/include/configs/nbxv3.h
+++ b/include/configs/nbxv3.h
@@ -14,6 +14,44 @@
 	"pci_iommu_extra=pci@0x3600000,1.0.0,hp,"			\
 		"pci@0x3700000,1.0.0,hp,"				\
 		"pci@0x3800000,1.0.0,hp,"				\
-		"pci@0x3900000,1.0.0,hp\0"
+		"pci@0x3900000,1.0.0,hp\0"				\
+	"kernel_addr_r=0xc0000000\0"					\
+	"fit_nor_offset=0x1000000\0"					\
+	"fit_nor_size=0x1000000\0"					\
+	"mcmemsize=0x70000000\0"					\
+	"mcinitcmd="							\
+		"sf probe 3:0 && "					\
+		"sf read ${kernel_addr_r} ${fit_nor_offset} ${fit_nor_size} && "\
+		"imxtract ${kernel_addr_r} mc 0xa8000000 && "		\
+		"imxtract ${kernel_addr_r} dpc-${carrier} 0xa9000000 && "\
+		"imxtract ${kernel_addr_r} dpl-${carrier} 0xaa000000 && "\
+		"fsl_mc start mc 0xa8000000 0xa9000000 && "		\
+		"fsl_mc lazyapply dpl 0xaa000000\0"			\
+	"mc_init=bootm ${kernel_addr_r}#conf-${carrier}\0"		\
+	"linux_boot_fit="						\
+		"sf probe 3:0 && "					\
+		"sf read ${kernel_addr_r} ${fit_nor_offset} ${fit_nor_size} && "\
+		"bootm ${kernel_addr_r}#conf-${carrier}\0"		\
+	"host_boot="							\
+		"load semihosting - ${kernel_addr_r} fit.itb && "	\
+		"bootm ${kernel_addr_r}#conf-${carrier}\0"		\
+	"provision_openocd_fit="					\
+		"load semihosting - ${kernel_addr_r} fit.itb && "	\
+		"sf probe 3:0 && "					\
+		"sf erase ${fit_nor_offset} ${fit_nor_size} && "	\
+		"sf write ${kernel_addr_r} ${fit_nor_offset} ${filesize} && "\
+		"reset\0"						\
+	"xspi_bootcmd="							\
+		"cp.b 0x21000000 ${kernel_addr_r} ${fit_nor_size} && "	\
+		"bootm ${kernel_addr_r}#conf-${carrier}\0"		\
+	"fsl_bootcmd_mcinitcmd_set=y\0"					\
+	"bootcmd=run mc_init || run provision_openocd_fit\0"		\
+	"mdio_list="							\
+		"echo === Nbxv3 probed PHYs === && "			\
+		"mdio list\0"						\
+	"PS1=nbxv3> \0"							\
+	"ps_refresh="							\
+		"setenv PS1 \"nbxv3 ${ethact} ${ipaddr}> \"\0"		\
+	"preboot=run mdio_list ; run ps_refresh\0"
 
 #endif /* __NBXV3_H */
-- 
2.43.0

