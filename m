Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAA3CA9EBE
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 832E581509;
	Fri,  9 Oct 2026 22:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BXbNpG21dQap; Fri,  9 Oct 2026 22:12:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F3C4814F1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583949;
	b=gAbWg1R03lwnnET9RWveYcE63079yzOQF9AKEmlwRb+jCcvv3zhrqv8lDYBKv34+2U/h
	 MmuJo7wPRWGkzjvDznkj0ipPg1dLQbsuae4EtSa56QbBg+2sKbjrrJ3pkzMAS5mIPXWVD
	 PMOEN7OTcEMks2xla4brKG9jX/jl9gsknH4AlB5Sc0brBalyDg6Y+d1so5w8b+/eYxavf
	 sfcGxJZS6ObJOFEkz/8ZQ1huwsCTNpKW2LbCoZ9g4a2vzD4bk7XYPABE8IBmoGMHnZCsU
	 M62tCQ9gtNVhFkPHvaByXJiByhuQ62wkMZNc0REtws3zpUSyxLapDsnr0NxYqOBn2FQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x4pSKiEL9mcRkUmMZ/MjOD5x2Vp8D0XZPvMEkUiF7qY=;
	b=Q6upXl47fbJur6Some0nPf6azK/nPXpvAvXW+xnFtV19AksY14P2viHMHAwDiJXuHtge
	 2hYEMBl9z5wyJHEMV6BwQca5wLqb/g7inluImlUoUaLlCiNEuBAXBk/MmWPUw+Vn6/AG7
	 1IDr6WiLNZ4rHnaB7yAbgmI4RM/RN0kStIYuHm7itHyTHzV7l9NqT9t4rp4cuE+H6CvkN
	 a7pD7rsxJKVs9ygFywi1QihjtF+VzTqMj9WT/SDs6OX8wUatLHhMD94Id/9j+4SQA53DX
	 0y+m8ndtwek76X5hvFyuHZT9G7W3W2Q0GK/av0/SVvn8XuR0+43xAekcZQrQi4F9VEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583949;
	bh=x4pSKiEL9mcRkUmMZ/MjOD5x2Vp8D0XZPvMEkUiF7qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xgFWpkdjKbDgRvamPXQ/ZRTynvTZKw5yJLpPuyNUx+C4nZygxMCvtftkDrHlghj0s
	 VuxRW66lBfxFcsT/YmFlfOvhcazw+7QJFOPoaGcuukACKldsjCa4orTDq9Jx+TlqDG
	 M37ZcQBSytI9uPP+/DcZtwXnt5wFe97397ZemuaWULGpfSAlHBxBlWmczptGNDEkKx
	 vYk9fcE9/qlDmysbJW26pUhM418wO0yVQllPxf9uYakN6WNRK2DaBnXs8uA+85vId2
	 AXhjOBKLn/t0jNpr6pBWZyRkrwvSeQ7Cs1Cm/q2vAsI/i46g6XGfvJjobBGF6iHd+7
	 nzSOnEMUZYXaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F3C4814F1;
	Fri,  9 Oct 2026 22:12:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id DB1A0317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id C0CE660844
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id OSspaoLnHrSJ for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E05460672
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583830;
 b=eU9Fsu1YfxxRztxCV+o1KDc/pbnhuJhPGZF20gYBeRAZlo0CBApAMxDcJbRLDOjCzDYX
 AQJPsXzfbVGjuS1S9REr1213LhCGbkC1Jt41u2lVRLJQsqaSfduliIWTzgvR3BFW78vWC
 ZZdxlUaJSIpqMP3ZmrMOm8gJHUjb110PyDvIZGt8fbF6lObwXvmN6fkzXvOsSSbqe/4gt
 WKLTqs1wTxaILpRsksnt7+m7KP4e00/WHv32BzgxakYJaa2H77rAPNHcNTm6NLaCYRtF8
 X5ANL4IycjKLmbjTkvHp+zLOfZ+3clFc4oRLSj5GeaPc+1vz6jtFMYbpiblZ2JUq7ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583830;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=x4pSKiEL9mcRkUmMZ/MjOD5x2Vp8D0XZPvMEkUiF7qY=;
 b=qyXrlfoNSos8pVDlydzbXKsaHjUA+A13qih0DNsGc1CApXAeXd7G2ty/+tza7+RN7AP8
 /gcOpGsoihyT5Oaltj3EE99jWBre2HBVWT9WI7XSNIy+k2PQyE+1Ik/7UXPC6p/tNpPKL
 LQtGPYn9wJWFYzfgy4FNlqrJl/aTWZsslY2HTzQj2QPblcvk7LzSfJpq8UV9r2NQHoa1G
 O3/rhQKNIrRnkAKZSbIo3DT6K3rnHvtkrmUNt4kr9wlDtSEjzPKKzDZwleggOvaIWLoyu
 r8/QSB55/fZnqSvHM4eTKC9gJz6hkmq1zht2QLQnFXzxTH0m1u9NyklAVIIkthdCwQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=aqJaUQjI; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b="FK/HCq85"; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=aqJaUQjI; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=FK/HCq85
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 5E05460672
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583826; bh=x4pSKiEL9mcRkUmMZ/MjOD5
 x2Vp8D0XZPvMEkUiF7qY=; b=aqJaUQjIOcE3gLUif2chxiWHuOkGn8OwyKibSDI6Vdt2cbyUa+
 hRQtzxFcrWBJYYQWfGxAA1mmOBe7m6rUwcBOzTzznPPMER2TOX2ef3SlP+pPycw8IRXj123iQC5
 3GzaBkbyfIAsgA3nKVPKwNwDC/2MZbBj+amBVVEATkeW5N2CkFxz60M9XgNxIvGQ0CGrvd8jFcD
 0l6k8CxBdyEouaXwOjOH5sPL5YRm+XZ3dVttXngfXapWX6qpmghkDCa0+OsuQXt6Uufes1KesRo
 Mbjj7piSSQrQ7OU9FdQtqjd8R+GrHC79koyNx311Uv/BgXerTRo9fXPTY1L+2XKeGEw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583826; bh=x4pSKiEL9mcRkUmMZ/MjOD5
 x2Vp8D0XZPvMEkUiF7qY=; b=FK/HCq85n+tDbGAUfF8/TBT7SuRi3B4lg/54FI6zc62Iprz+hG
 JRbZ8dfPwt0nkzjCRUMkNI0nwZ//esmDKWBw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v2 21/26] powerpc: mpc83xx: Remove MPC834x support
Date: Fri,  9 Oct 2026 22:10:11 +0000
Message-ID: <20261009221017.20385-22-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009221017.20385-1-brads@mainlining.org>
References: <20261009221017.20385-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 22:11:54 +0000
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

No board selects ARCH_MPC834X, and the family has no active community
maintenance or testing. None of its clock, register or CPU ID paths has
a consumer.

Remove the family code.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc83xx/Kconfig              |   4 -
 arch/powerpc/cpu/mpc83xx/cpu.c                |   7 +-
 arch/powerpc/cpu/mpc83xx/cpu_init.c           |  12 --
 arch/powerpc/cpu/mpc83xx/fdt.c                |   5 +-
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr |   4 +-
 arch/powerpc/cpu/mpc83xx/pci.c                |   2 -
 arch/powerpc/cpu/mpc83xx/spd_sdram.c          |   2 +-
 arch/powerpc/cpu/mpc83xx/speed.c              |  58 +-----
 arch/powerpc/cpu/mpc83xx/traps.c              |   1 -
 arch/powerpc/include/asm/arch-mpc83xx/gpio.h  |   2 -
 arch/powerpc/include/asm/arch-mpc83xx/soc.h   |   4 +-
 arch/powerpc/include/asm/fsl_lbc.h            |  10 +-
 arch/powerpc/include/asm/global_data.h        |   6 +-
 arch/powerpc/include/asm/immap_83xx.h         |  43 +----
 arch/powerpc/include/asm/mpc8349_pci.h        | 165 ------------------
 arch/powerpc/include/asm/mpc8xxx_spi.h        |   3 +-
 doc/README.mpc83xxads                         |  97 ----------
 .../clock/fsl,mpc83xx-clk.txt                 |   1 -
 doc/device-tree-bindings/cpu/fsl,mpc83xx.txt  |   1 -
 drivers/clk/mpc83xx_clk.c                     |   3 -
 drivers/clk/mpc83xx_clk.h                     |  13 +-
 drivers/cpu/mpc83xx_cpu.c                     |  28 +--
 drivers/cpu/mpc83xx_cpu.h                     |  16 --
 drivers/pci/pci_auto.c                        |  14 --
 include/dt-bindings/clk/mpc83xx-clk.h         |   1 -
 include/mpc83xx.h                             | 136 +--------------
 26 files changed, 28 insertions(+), 610 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/mpc8349_pci.h
 delete mode 100644 doc/README.mpc83xxads

diff --git a/arch/powerpc/cpu/mpc83xx/Kconfig b/arch/powerpc/cpu/mpc83xx/Kconfig
index 06d84c2d945..4b8e2181757 100644
--- a/arch/powerpc/cpu/mpc83xx/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/Kconfig
@@ -131,10 +131,6 @@ config ARCH_MPC832X
 	select MPC83XX_PCI_SUPPORT
 	select SYS_CACHE_SHIFT_5
 
-config ARCH_MPC834X
-	bool
-	select SYS_CACHE_SHIFT_5
-
 config ARCH_MPC8360
 	bool
 	select MPC83XX_QUICC_ENGINE
diff --git a/arch/powerpc/cpu/mpc83xx/cpu.c b/arch/powerpc/cpu/mpc83xx/cpu.c
index e1f70f40fec..7583121eb12 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu.c
@@ -50,10 +50,6 @@ int checkcpu(void)
 		CPU_TYPE_ENTRY(8309),
 		CPU_TYPE_ENTRY(8321),
 		CPU_TYPE_ENTRY(8323),
-		CPU_TYPE_ENTRY(8343),
-		CPU_TYPE_ENTRY(8347_TBGA_),
-		CPU_TYPE_ENTRY(8347_PBGA_),
-		CPU_TYPE_ENTRY(8349),
 		CPU_TYPE_ENTRY(8358_TBGA_),
 		CPU_TYPE_ENTRY(8358_PBGA_),
 		CPU_TYPE_ENTRY(8360),
@@ -96,8 +92,7 @@ int checkcpu(void)
 			puts(cpu_type_list[i].name);
 			if (IS_E_PROCESSOR(spridr))
 				puts("E");
-			if ((SPR_FAMILY(spridr) == SPR_834X_FAMILY ||
-			     SPR_FAMILY(spridr) == SPR_836X_FAMILY) &&
+			if (SPR_FAMILY(spridr) == SPR_836X_FAMILY &&
 			    REVID_MAJOR(spridr) >= 2)
 				puts("A");
 			printf(", Rev: %d.%d", REVID_MAJOR(spridr),
diff --git a/arch/powerpc/cpu/mpc83xx/cpu_init.c b/arch/powerpc/cpu/mpc83xx/cpu_init.c
index 555dd502b36..6c34bdeac7b 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu_init.c
@@ -84,9 +84,6 @@ void cpu_init_f (volatile immap_t * im)
 #ifdef CFG_SYS_SCCR_TSEC2CM /* TSEC2 clock mode */
 		SCCR_TSEC2CM |
 #endif
-#ifdef CONFIG_SYS_SCCR_USBMPHCM /* USB MPH clock mode */
-		SCCR_USBMPHCM |
-#endif
 #ifdef CFG_SYS_SCCR_USBDRCM /* USB DR clock mode */
 		SCCR_USBDRCM |
 #endif
@@ -116,9 +113,6 @@ void cpu_init_f (volatile immap_t * im)
 #ifdef CFG_SYS_SCCR_TSEC2CM /* TSEC2 clock mode */
 		(CFG_SYS_SCCR_TSEC2CM << SCCR_TSEC2CM_SHIFT) |
 #endif
-#ifdef CONFIG_SYS_SCCR_USBMPHCM /* USB MPH clock mode */
-		(CONFIG_SYS_SCCR_USBMPHCM << SCCR_USBMPHCM_SHIFT) |
-#endif
 #ifdef CFG_SYS_SCCR_USBDRCM /* USB DR clock mode */
 		(CFG_SYS_SCCR_USBDRCM << SCCR_USBDRCM_SHIFT) |
 #endif
@@ -165,14 +159,8 @@ void cpu_init_f (volatile immap_t * im)
 
 	/* System General Purpose Register */
 #ifdef CFG_SYS_SICRH
-#if defined(CONFIG_ARCH_MPC834X)
-	/* regarding to MPC34x manual rev.1 bits 28..29 must be preserved */
-	__raw_writel((im->sysconf.sicrh & 0x0000000C) | CFG_SYS_SICRH,
-		     &im->sysconf.sicrh);
-#else
 	__raw_writel(CFG_SYS_SICRH, &im->sysconf.sicrh);
 #endif
-#endif
 #ifdef CFG_SYS_SICRL
 	__raw_writel(CFG_SYS_SICRL, &im->sysconf.sicrl);
 #endif
diff --git a/arch/powerpc/cpu/mpc83xx/fdt.c b/arch/powerpc/cpu/mpc83xx/fdt.c
index 08c3e783597..1eaff5e5aad 100644
--- a/arch/powerpc/cpu/mpc83xx/fdt.c
+++ b/arch/powerpc/cpu/mpc83xx/fdt.c
@@ -38,15 +38,14 @@ void ft_cpu_setup(void *blob, struct bd_info *bd)
 
 	/*
 	 * delete crypto node if not on an E-processor
-	 * initial revisions of the MPC834xE/6xE have the original SEC 2.0.
+	 * Initial revisions of the MPC836xE have the original SEC 2.0.
 	 * EA revisions got the SEC uprevved to 2.4 but since the default device
 	 * tree contains SEC 2.0 properties we uprev them here.
 	 */
 	if (!IS_E_PROCESSOR(spridr))
 		fdt_fixup_crypto_node(blob, 0);
 	else if (IS_E_PROCESSOR(spridr) &&
-		 (SPR_FAMILY(spridr) == SPR_834X_FAMILY ||
-		  SPR_FAMILY(spridr) == SPR_836X_FAMILY) &&
+		 SPR_FAMILY(spridr) == SPR_836X_FAMILY &&
 		 REVID_MAJOR(spridr) >= 2)
 		fdt_fixup_crypto_node(blob, 0x0204);
 
diff --git a/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr b/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr
index a85e698a867..f62bdd62bb2 100644
--- a/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr
+++ b/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr
@@ -18,7 +18,7 @@ endchoice
 
 endif
 
-if ARCH_MPC834X || ARCH_MPC8360
+if ARCH_MPC8360
 
 choice
 	prompt "Additional delay cycles for SDRAM control signals"
@@ -60,7 +60,7 @@ config LCRR_ECL_7
 
 endchoice
 
-endif # ARCH_MPC834X || ARCH_MPC8360
+endif # ARCH_MPC8360
 
 if !ARCH_MPC8308
 
diff --git a/arch/powerpc/cpu/mpc83xx/pci.c b/arch/powerpc/cpu/mpc83xx/pci.c
index aef1123a2b7..76023ae698b 100644
--- a/arch/powerpc/cpu/mpc83xx/pci.c
+++ b/arch/powerpc/cpu/mpc83xx/pci.c
@@ -17,8 +17,6 @@
 #include <fdt_support.h>
 #endif
 
-#include <asm/mpc8349_pci.h>
-
 #define MAX_BUSES 2
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/powerpc/cpu/mpc83xx/spd_sdram.c b/arch/powerpc/cpu/mpc83xx/spd_sdram.c
index 949efc8e828..6b3e59143fe 100644
--- a/arch/powerpc/cpu/mpc83xx/spd_sdram.c
+++ b/arch/powerpc/cpu/mpc83xx/spd_sdram.c
@@ -432,7 +432,7 @@ long int spd_sdram()
 
 	/*
 	 * Errata DDR6 work around: input enable 2 cycles earlier.
-	 * including MPC834X Rev1.0/1.1 and MPC8360 Rev1.1/1.2.
+	 * including MPC8360 Rev1.1/1.2.
 	 */
 	if(PVR_MAJ(pvr) <= 1 && spd.mem_type == SPD_MEMTYPE_DDR){
 		if (caslat == 2)
diff --git a/arch/powerpc/cpu/mpc83xx/speed.c b/arch/powerpc/cpu/mpc83xx/speed.c
index e2ed3caf022..c0eeff1e0a5 100644
--- a/arch/powerpc/cpu/mpc83xx/speed.c
+++ b/arch/powerpc/cpu/mpc83xx/speed.c
@@ -87,14 +87,10 @@ int get_clocks(void)
 	u32 lcrr;
 
 	u32 csb_clk;
-#if defined(CONFIG_ARCH_MPC8308) || \
-	defined(CONFIG_ARCH_MPC834X)
+#if defined(CONFIG_ARCH_MPC8308)
 	u32 tsec1_clk;
 	u32 tsec2_clk;
 	u32 usbdr_clk;
-#endif
-#ifdef CONFIG_ARCH_MPC834X
-	u32 usbmph_clk;
 #endif
 	u32 core_clk;
 	u32 i2c1_clk;
@@ -146,8 +142,7 @@ int get_clocks(void)
 
 	sccr = im->clk.sccr;
 
-#if defined(CONFIG_ARCH_MPC8308) || \
-	defined(CONFIG_ARCH_MPC834X)
+#if defined(CONFIG_ARCH_MPC8308)
 	switch ((sccr & SCCR_TSEC1CM) >> SCCR_TSEC1CM_SHIFT) {
 	case 0:
 		tsec1_clk = 0;
@@ -167,8 +162,7 @@ int get_clocks(void)
 	}
 #endif
 
-#if defined(CONFIG_ARCH_MPC830X) || \
-	defined(CONFIG_ARCH_MPC834X)
+#if defined(CONFIG_ARCH_MPC830X)
 	switch ((sccr & SCCR_USBDRCM) >> SCCR_USBDRCM_SHIFT) {
 	case 0:
 		usbdr_clk = 0;
@@ -188,7 +182,7 @@ int get_clocks(void)
 	}
 #endif
 
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC834X)
+#if defined(CONFIG_ARCH_MPC8308)
 	switch ((sccr & SCCR_TSEC2CM) >> SCCR_TSEC2CM_SHIFT) {
 	case 0:
 		tsec2_clk = 0;
@@ -208,33 +202,6 @@ int get_clocks(void)
 	}
 #endif
 
-#if defined(CONFIG_ARCH_MPC834X)
-	switch ((sccr & SCCR_USBMPHCM) >> SCCR_USBMPHCM_SHIFT) {
-	case 0:
-		usbmph_clk = 0;
-		break;
-	case 1:
-		usbmph_clk = csb_clk;
-		break;
-	case 2:
-		usbmph_clk = csb_clk / 2;
-		break;
-	case 3:
-		usbmph_clk = csb_clk / 3;
-		break;
-	default:
-		/* unknown SCCR_USBMPHCM value */
-		return -5;
-	}
-
-	if (usbmph_clk != 0 && usbdr_clk != 0 && usbmph_clk != usbdr_clk) {
-		/* if USB MPH clock is not disabled and
-		 * USB DR clock is not disabled then
-		 * USB MPH & USB DR must have the same rate
-		 */
-		return -6;
-	}
-#endif
 	switch ((sccr & SCCR_ENCCM) >> SCCR_ENCCM_SHIFT) {
 	case 0:
 		enc_clk = 0;
@@ -273,9 +240,7 @@ int get_clocks(void)
 	}
 #endif
 
-#if defined(CONFIG_ARCH_MPC834X)
-	i2c1_clk = tsec2_clk;
-#elif defined(CONFIG_ARCH_MPC8360)
+#if defined(CONFIG_ARCH_MPC8360)
 	i2c1_clk = csb_clk;
 #elif defined(CONFIG_ARCH_MPC832X)
 	i2c1_clk = enc_clk;
@@ -385,15 +350,11 @@ int get_clocks(void)
 #endif
 
 	gd->arch.csb_clk = csb_clk;
-#if defined(CONFIG_ARCH_MPC8308) || \
-	defined(CONFIG_ARCH_MPC834X)
+#if defined(CONFIG_ARCH_MPC8308)
 	gd->arch.tsec1_clk = tsec1_clk;
 	gd->arch.tsec2_clk = tsec2_clk;
 	gd->arch.usbdr_clk = usbdr_clk;
 #endif
-#if defined(CONFIG_ARCH_MPC834X)
-	gd->arch.usbmph_clk = usbmph_clk;
-#endif
 #if defined(CONFIG_FSL_ESDHC)
 	gd->arch.sdhc_clk = sdhc_clk;
 #endif
@@ -484,8 +445,7 @@ static int do_clocks(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("  SDHC:                %-4s MHz\n",
 	       strmhz(buf, gd->arch.sdhc_clk));
 #endif
-#if defined(CONFIG_ARCH_MPC8308) || \
-	defined(CONFIG_ARCH_MPC834X)
+#if defined(CONFIG_ARCH_MPC8308)
 	printf("  TSEC1:               %-4s MHz\n",
 	       strmhz(buf, gd->arch.tsec1_clk));
 	printf("  TSEC2:               %-4s MHz\n",
@@ -493,10 +453,6 @@ static int do_clocks(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("  USB DR:              %-4s MHz\n",
 	       strmhz(buf, gd->arch.usbdr_clk));
 #endif
-#if defined(CONFIG_ARCH_MPC834X)
-	printf("  USB MPH:             %-4s MHz\n",
-	       strmhz(buf, gd->arch.usbmph_clk));
-#endif
 #if defined(CONFIG_ARCH_MPC8308)
 	printf("  PCIEXP1:             %-4s MHz\n",
 	       strmhz(buf, gd->arch.pciexp1_clk));
diff --git a/arch/powerpc/cpu/mpc83xx/traps.c b/arch/powerpc/cpu/mpc83xx/traps.c
index d50499ceb7c..d68c0a23f18 100644
--- a/arch/powerpc/cpu/mpc83xx/traps.c
+++ b/arch/powerpc/cpu/mpc83xx/traps.c
@@ -16,7 +16,6 @@
 #include <command.h>
 #include <kgdb.h>
 #include <asm/processor.h>
-#include <asm/mpc8349_pci.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/powerpc/include/asm/arch-mpc83xx/gpio.h b/arch/powerpc/include/asm/arch-mpc83xx/gpio.h
index 6449fded125..7657471b99f 100644
--- a/arch/powerpc/include/asm/arch-mpc83xx/gpio.h
+++ b/arch/powerpc/include/asm/arch-mpc83xx/gpio.h
@@ -8,8 +8,6 @@
  */
 #if defined(CONFIG_ARCH_MPC8308)
 #define MPC83XX_GPIO_CTRLRS 1
-#elif defined(CONFIG_ARCH_MPC834X)
-#define MPC83XX_GPIO_CTRLRS 2
 #else
 #define MPC83XX_GPIO_CTRLRS 0
 #endif
diff --git a/arch/powerpc/include/asm/arch-mpc83xx/soc.h b/arch/powerpc/include/asm/arch-mpc83xx/soc.h
index 0eeaa23b190..0473389bc7d 100644
--- a/arch/powerpc/include/asm/arch-mpc83xx/soc.h
+++ b/arch/powerpc/include/asm/arch-mpc83xx/soc.h
@@ -11,7 +11,6 @@ enum soc_type {
 	SOC_MPC8308,
 	SOC_MPC8309,
 	SOC_MPC832X,
-	SOC_MPC8349,
 	SOC_MPC8360,
 };
 
@@ -23,8 +22,7 @@ static inline bool mpc83xx_has_sdhc(int type)
 
 static inline bool mpc83xx_has_tsec(int type)
 {
-	return (type == SOC_MPC8308) ||
-	       (type == SOC_MPC8349);
+	return type == SOC_MPC8308;
 }
 
 static inline bool mpc83xx_has_pcie1(int type)
diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index 9efb6ae6cd0..37da14c45f1 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -40,10 +40,10 @@ void lbc_sdram_init(void);
 #define BR_MSEL				0x000000E0
 #define BR_MSEL_SHIFT			5
 #define BR_MS_GPCM			0x00000000	/* GPCM */
-#if !defined(CONFIG_ARCH_MPC834X) && !defined(CONFIG_ARCH_MPC8360)
+#if !defined(CONFIG_ARCH_MPC8360)
 #define BR_MS_FCM			0x00000020	/* FCM */
 #endif
-#if defined(CONFIG_ARCH_MPC834X) || defined(CONFIG_ARCH_MPC8360)
+#if defined(CONFIG_ARCH_MPC8360)
 #define BR_MS_SDRAM			0x00000060	/* SDRAM */
 #elif defined(CONFIG_MPC85xx)
 #define BR_MS_SDRAM			0x00000000	/* SDRAM */
@@ -51,10 +51,8 @@ void lbc_sdram_init(void);
 #define BR_MS_UPMA			0x00000080	/* UPMA */
 #define BR_MS_UPMB			0x000000A0	/* UPMB */
 #define BR_MS_UPMC			0x000000C0	/* UPMC */
-#if !defined(CONFIG_ARCH_MPC834X)
 #define BR_ATOM				0x0000000C
 #define BR_ATOM_SHIFT			2
-#endif
 #define BR_V				0x00000001
 #define BR_V_SHIFT			0
 
@@ -64,11 +62,7 @@ void lbc_sdram_init(void);
 #define UPMB			1
 #define UPMC			2
 
-#if defined(CONFIG_ARCH_MPC834X)
-#define BR_RES				~(BR_BA | BR_PS | BR_DECC | BR_WP | BR_MSEL | BR_V)
-#else
 #define BR_RES				~(BR_BA | BR_PS | BR_DECC | BR_WP | BR_MSEL | BR_ATOM | BR_V)
-#endif
 
 /* Convert an address into the right format for the BR registers */
 #if defined(CONFIG_PHYS_64BIT) && !defined(CONFIG_FSL_ELBC)
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 168eb55b497..710d538dad9 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -26,15 +26,11 @@ struct arch_global_data {
 #else
 	/* There are other clocks in the MPC83XX */
 	u32 csb_clk;
-# if defined(CONFIG_ARCH_MPC8308) || \
-	defined(CONFIG_ARCH_MPC834X)
+# if defined(CONFIG_ARCH_MPC8308)
 	u32 tsec1_clk;
 	u32 tsec2_clk;
 	u32 usbdr_clk;
 # endif
-# if defined(CONFIG_ARCH_MPC834X)
-	u32 usbmph_clk;
-# endif /* CONFIG_ARCH_MPC834X */
 	u32 core_clk;
 	u32 enc_clk;
 	u32 lbiu_clk;
diff --git a/arch/powerpc/include/asm/immap_83xx.h b/arch/powerpc/include/asm/immap_83xx.h
index c7e7616529d..428839ad1a5 100644
--- a/arch/powerpc/include/asm/immap_83xx.h
+++ b/arch/powerpc/include/asm/immap_83xx.h
@@ -647,48 +647,7 @@ typedef struct tdmdmac83xx {
 } tdmdmac83xx_t;
 static_assert(sizeof(tdmdmac83xx_t) == 0x2000);
 
-#if defined(CONFIG_ARCH_MPC834X)
-typedef struct immap {
-	sysconf83xx_t		sysconf;	/* System configuration */
-	wdt83xx_t		wdt;		/* Watch Dog Timer (WDT) Registers */
-	rtclk83xx_t		rtc;		/* Real Time Clock Module Registers */
-	rtclk83xx_t		pit;		/* Periodic Interval Timer */
-	gtm83xx_t		gtm[2];		/* Global Timers Module */
-	ipic83xx_t		ipic;		/* Integrated Programmable Interrupt Controller */
-	arbiter83xx_t		arbiter;	/* System Arbiter Registers */
-	reset83xx_t		reset;		/* Reset Module */
-	clk83xx_t		clk;		/* System Clock Module */
-	pmc83xx_t		pmc;		/* Power Management Control Module */
-	gpio83xx_t		gpio[2];	/* General purpose I/O module */
-	u8			res0[0x200];
-	u8			dll_ddr[0x100];
-	u8			dll_lbc[0x100];
-	u8			res1[0xE00];
-#if defined(CONFIG_SYS_FSL_DDR2) || defined(CONFIG_SYS_FSL_DDR3)
-	struct ccsr_ddr		ddr;	/* DDR Memory Controller Memory */
-#else
-	ddr83xx_t		ddr;	/* DDR Memory Controller Memory */
-#endif
-	fsl_i2c_t		i2c[2];		/* I2C Controllers */
-	u8			res2[0x1300];
-	duart83xx_t		duart[2];	/* DUART */
-	u8			res3[0x900];
-	fsl_lbc_t		im_lbc;		/* Local Bus Controller Regs */
-	u8			res4[0x1000];
-	spi8xxx_t		spi;		/* Serial Peripheral Interface */
-	dma83xx_t		dma;		/* DMA */
-	pciconf83xx_t		pci_conf[2];	/* PCI Software Configuration Registers */
-	ios83xx_t		ios;		/* Sequencer */
-	pcictrl83xx_t		pci_ctrl[2];	/* PCI Controller Control and Status Registers */
-	u8			res5[0x19900];
-	usb83xx_t		usb[2];
-	tsec83xx_t		tsec[2];
-	u8			res6[0xA000];
-	security83xx_t		security;
-	u8			res7[0xC0000];
-} immap_t;
-
-#elif defined(CONFIG_ARCH_MPC8308)
+#if defined(CONFIG_ARCH_MPC8308)
 typedef struct immap {
 	sysconf83xx_t		sysconf;	/* System configuration */
 	wdt83xx_t		wdt;		/* Watch Dog Timer (WDT) Registers */
diff --git a/arch/powerpc/include/asm/mpc8349_pci.h b/arch/powerpc/include/asm/mpc8349_pci.h
deleted file mode 100644
index 3d920c25ade..00000000000
--- a/arch/powerpc/include/asm/mpc8349_pci.h
+++ /dev/null
@@ -1,165 +0,0 @@
-#ifndef _PPC_KERNEL_MPC8349_PCI_H
-#define _PPC_KERNEL_MPC8349_PCI_H
-
-#define M8265_PCIBR0	0x101ac
-#define M8265_PCIBR1	0x101b0
-#define M8265_PCIMSK0	0x101c4
-#define M8265_PCIMSK1	0x101c8
-
-/* Bit definitions for PCIBR registers */
-
-#define PCIBR_ENABLE        0x00000001
-
-/* Bit definitions for PCIMSK registers */
-
-#define PCIMSK_32KB         0xFFFF8000  /* Size of window, smallest */
-#define PCIMSK_64KB         0xFFFF0000
-#define PCIMSK_128KB        0xFFFE0000
-#define PCIMSK_256KB        0xFFFC0000
-#define PCIMSK_512KB        0xFFF80000
-#define PCIMSK_1MB          0xFFF00000
-#define PCIMSK_2MB          0xFFE00000
-#define PCIMSK_4MB          0xFFC00000
-#define PCIMSK_8MB          0xFF800000
-#define PCIMSK_16MB         0xFF000000
-#define PCIMSK_32MB         0xFE000000
-#define PCIMSK_64MB         0xFC000000
-#define PCIMSK_128MB        0xF8000000
-#define PCIMSK_256MB        0xF0000000
-#define PCIMSK_512MB        0xE0000000
-#define PCIMSK_1GB          0xC0000000  /* Size of window, largest */
-
-#define M826X_SCCR_PCI_MODE_EN 0x100
-
-/*
- * Outbound ATU registers (3 sets). These registers control how 60x bus
- * (local) addresses are translated to PCI addresses when the MPC826x is
- * a PCI bus master (initiator).
- */
-
-#define POTAR_REG0          0x10800     /* PCI Outbound Translation Addr registers */
-#define POTAR_REG1          0x10818
-#define POTAR_REG2          0x10830
-
-#define POBAR_REG0          0x10808     /* PCI Outbound Base Addr registers */
-#define POBAR_REG1          0x10820
-#define POBAR_REG2          0x10838
-
-#define POCMR_REG0          0x10810     /* PCI Outbound Comparison Mask registers */
-#define POCMR_REG1          0x10828
-#define POCMR_REG2          0x10840
-
-/* Bit definitions for POMCR registers */
-
-#define POCMR_MASK_4KB      0x000FFFFF
-#define POCMR_MASK_8KB      0x000FFFFE
-#define POCMR_MASK_16KB     0x000FFFFC
-#define POCMR_MASK_32KB     0x000FFFF8
-#define POCMR_MASK_64KB     0x000FFFF0
-#define POCMR_MASK_128KB    0x000FFFE0
-#define POCMR_MASK_256KB    0x000FFFC0
-#define POCMR_MASK_512KB    0x000FFF80
-#define POCMR_MASK_1MB      0x000FFF00
-#define POCMR_MASK_2MB      0x000FFE00
-#define POCMR_MASK_4MB      0x000FFC00
-#define POCMR_MASK_8MB      0x000FF800
-#define POCMR_MASK_16MB     0x000FF000
-#define POCMR_MASK_32MB     0x000FE000
-#define POCMR_MASK_64MB     0x000FC000
-#define POCMR_MASK_128MB    0x000F8000
-#define POCMR_MASK_256MB    0x000F0000
-#define POCMR_MASK_512MB    0x000E0000
-#define POCMR_MASK_1GB      0x000C0000
-
-#define POCMR_ENABLE        0x80000000
-#define POCMR_PCI_IO        0x40000000
-#define POCMR_PREFETCH_EN   0x20000000
-#define POCMR_PCI2          0x10000000
-
-/* Soft PCI reset */
-
-#define PCI_GCR_REG         0x10880
-
-/* Bit definitions for PCI_GCR registers */
-
-#define PCIGCR_PCI_BUS_EN   0x1
-
-/*
- * Inbound ATU registers (2 sets). These registers control how PCI
- * addresses are translated to 60x bus (local) addresses when the
- * MPC826x is a PCI bus target.
- */
-
-#define PITAR_REG1          0x108D0
-#define PIBAR_REG1          0x108D8
-#define PICMR_REG1          0x108E0
-#define PITAR_REG0          0x108E8
-#define PIBAR_REG0          0x108F0
-#define PICMR_REG0          0x108F8
-
-/* Bit definitions for PCI Inbound Comparison Mask registers */
-
-#define PICMR_MASK_4KB       0x000FFFFF
-#define PICMR_MASK_8KB       0x000FFFFE
-#define PICMR_MASK_16KB      0x000FFFFC
-#define PICMR_MASK_32KB      0x000FFFF8
-#define PICMR_MASK_64KB      0x000FFFF0
-#define PICMR_MASK_128KB     0x000FFFE0
-#define PICMR_MASK_256KB     0x000FFFC0
-#define PICMR_MASK_512KB     0x000FFF80
-#define PICMR_MASK_1MB       0x000FFF00
-#define PICMR_MASK_2MB       0x000FFE00
-#define PICMR_MASK_4MB       0x000FFC00
-#define PICMR_MASK_8MB       0x000FF800
-#define PICMR_MASK_16MB      0x000FF000
-#define PICMR_MASK_32MB      0x000FE000
-#define PICMR_MASK_64MB      0x000FC000
-#define PICMR_MASK_128MB     0x000F8000
-#define PICMR_MASK_256MB     0x000F0000
-#define PICMR_MASK_512MB     0x000E0000
-#define PICMR_MASK_1GB       0x000C0000
-
-#define PICMR_ENABLE         0x80000000
-#define PICMR_NO_SNOOP_EN    0x40000000
-#define PICMR_PREFETCH_EN    0x20000000
-
-/* PCI error Registers */
-
-#define	PCI_ERROR_STATUS_REG		0x10884
-#define	PCI_ERROR_MASK_REG		0x10888
-#define	PCI_ERROR_CONTROL_REG		0x1088C
-#define PCI_ERROR_ADRS_CAPTURE_REG      0x10890
-#define PCI_ERROR_DATA_CAPTURE_REG      0x10898
-#define PCI_ERROR_CTRL_CAPTURE_REG      0x108A0
-
-/* PCI error Register bit defines */
-
-#define	PCI_ERROR_PCI_ADDR_PAR			0x00000001
-#define	PCI_ERROR_PCI_DATA_PAR_WR		0x00000002
-#define	PCI_ERROR_PCI_DATA_PAR_RD		0x00000004
-#define	PCI_ERROR_PCI_NO_RSP			0x00000008
-#define	PCI_ERROR_PCI_TAR_ABT			0x00000010
-#define	PCI_ERROR_PCI_SERR			0x00000020
-#define	PCI_ERROR_PCI_PERR_RD			0x00000040
-#define	PCI_ERROR_PCI_PERR_WR			0x00000080
-#define	PCI_ERROR_I2O_OFQO			0x00000100
-#define	PCI_ERROR_I2O_IPQO			0x00000200
-#define	PCI_ERROR_IRA				0x00000400
-#define	PCI_ERROR_NMI				0x00000800
-#define	PCI_ERROR_I2O_DBMC			0x00001000
-
-/*
- * Register pair used to generate configuration cycles on the PCI bus
- * and access the MPC826x's own PCI configuration registers.
- */
-
-#define PCI_CFG_ADDR_REG     0x10900
-#define PCI_CFG_DATA_REG     0x10904
-
-/* Bus parking decides where the bus control sits when idle */
-/* If modifying memory controllers for PCI park on the core */
-
-#define PPC_ACR_BUS_PARK_CORE 0x6
-#define PPC_ACR_BUS_PARK_PCI  0x3
-
-#endif /* _PPC_KERNEL_M8260_PCI_H */
diff --git a/arch/powerpc/include/asm/mpc8xxx_spi.h b/arch/powerpc/include/asm/mpc8xxx_spi.h
index 5d8d7db2933..f057040dfbc 100644
--- a/arch/powerpc/include/asm/mpc8xxx_spi.h
+++ b/arch/powerpc/include/asm/mpc8xxx_spi.h
@@ -11,8 +11,7 @@
 #include <asm/types.h>
 
 #if defined(CONFIG_ARCH_MPC8308) || \
-	defined(CONFIG_ARCH_MPC832X) || \
-	defined(CONFIG_ARCH_MPC834X)
+	defined(CONFIG_ARCH_MPC832X)
 
 typedef struct spi8xxx {
 	u8 res0[0x20];	/* 0x0-0x01f reserved */
diff --git a/doc/README.mpc83xxads b/doc/README.mpc83xxads
deleted file mode 100644
index 372fdd9ce85..00000000000
--- a/doc/README.mpc83xxads
+++ /dev/null
@@ -1,97 +0,0 @@
-Freescale MPC83xx ADS Boards
------------------------------------------
-
-0. Toolchain / Building
-
-    $ PATH=$PATH:/usr/powerpc/bin
-    $ CROSS_COMPILE=powerpc-linux-
-    $ export PATH CROSS_COMPILE
-
-    $ powerpc-linux-gcc -v
-    Reading specs from /usr/powerpc/lib/gcc/powerpc-linux/3.4.3/specs
-    Configured with: ../configure --prefix=/usr/powerpc
-    --exec-prefix=/usr/powerpc --target=powerpc-linux --enable-shared
-    --disable-nls --disable-multilib --enable-languages=c,c++,ada,f77,objc
-    Thread model: posix
-    gcc version 3.4.3 (Debian)
-
-    $ powerpc-linux-as -v
-    GNU assembler version 2.15 (powerpc-linux) using BFD version 2.15
-
-
-    $ make MPC8349ADS_config
-    Configuring for MPC8349ADS board...
-
-    $ make
-
-
-1. Board Switches and Jumpers
-
-
-2. Memory Map
-
-2.1. The memory map should look pretty much like this:
-
-     0x0000_0000     0x7fff_ffff     DDR		     2G
-     0x8000_0000     0x9fff_ffff     PCI MEM		     512M
-     0xc000_0000     0xdfff_ffff     Rapid IO		     512M
-     0xe000_0000     0xe00f_ffff     CCSR		     1M
-     0xe200_0000     0xe2ff_ffff     PCI IO		     16M
-     0xf000_0000     0xf7ff_ffff     SDRAM		     128M
-     0xf800_0000     0xf80f_ffff     BCSR		     1M
-     0xfe00_0000     0xffff_ffff     FLASH (boot bank)	     16M
-
-
-3. Definitions
-
-3.1 Explanation of NEW definitions in:
-
-	include/configs/MPC8349ADS.h
-
-    CONFIG_MPC83xx	    MPC83xx family
-    CONFIG_MPC8349	    MPC8349 specific
-    CONFIG_TSEC_ENET	    Use on-chip 10/100/1000 ethernet
-
-
-4. Compilation
-
-    Assuming you're using BASH shell:
-
-	export CROSS_COMPILE=your-cross-compile-prefix
-	cd u-boot
-	make distclean
-	make MPC8349ADS_config
-	make
-
-5. Downloading and Flashing Images
-
-5.0 Download over serial line using Kermit:
-
-	loadb
-	[Drop to kermit:
-	    ^\c
-	    send <u-boot-bin-image>
-	    c
-	]
-
-
-    Or via tftp:
-
-	tftp 10000 u-boot.bin
-
-5.1 Reflash U-Boot Image using U-Boot
-
-    tftp 10000 u-boot.bin
-    protect off fe000000 fe09ffff
-    erase fe000000 fe09ffff
-
-    cp.b 10000 fe000000 xxxx
-or
-    cp.b 10000 fe000000 a0000
-
-You might have to supply the correct byte count for 'xxxx' from
-the TFTP.  Maybe a0000 will work too, that corresponds to the
-erased sectors.
-
-
-6. Notes
diff --git a/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt b/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
index baaacb62846..213123dbab4 100644
--- a/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
+++ b/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
@@ -7,7 +7,6 @@ Required properties:
 - compatible: must be one of "fsl,mpc8308-clk",
                              "fsl,mpc8309-clk",
                              "fsl,mpc832x-clk",
-                             "fsl,mpc8349-clk",
                              "fsl,mpc8360-clk"
   depending on which SoC is employed
 - #clock-cells: Must be 1
diff --git a/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt b/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
index 5bdbd309fbf..5acb2c403c9 100644
--- a/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
+++ b/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
@@ -7,7 +7,6 @@ Required properties:
                              "fsl,mpc8308",
                              "fsl,mpc8309",
                              "fsl,mpc832x",
-                             "fsl,mpc8349",
                              "fsl,mpc8360"
 - clocks: has to have two entries, which must be the core clock at index 0 and
   the CSB (Coherent System Bus) clock at index 1. Both are given by a suitable
diff --git a/drivers/clk/mpc83xx_clk.c b/drivers/clk/mpc83xx_clk.c
index bca09f17d5f..4b2f1705b64 100644
--- a/drivers/clk/mpc83xx_clk.c
+++ b/drivers/clk/mpc83xx_clk.c
@@ -59,8 +59,6 @@ static inline bool is_clk_valid(struct udevice *clk, int id)
 		return mpc83xx_has_tsec(type);
 	case MPC83XX_CLK_USBDR:
 		return type == SOC_MPC8360;
-	case MPC83XX_CLK_USBMPH:
-		return type == SOC_MPC8349;
 	case MPC83XX_CLK_PCIEXP1:
 		return mpc83xx_has_pcie1(type);
 	case MPC83XX_CLK_PCIEXP2:
@@ -322,7 +320,6 @@ static const struct udevice_id mpc83xx_clk_match[] = {
 	{ .compatible = "fsl,mpc8308-clk", .data = SOC_MPC8308 },
 	{ .compatible = "fsl,mpc8309-clk", .data = SOC_MPC8309 },
 	{ .compatible = "fsl,mpc832x-clk", .data = SOC_MPC832X },
-	{ .compatible = "fsl,mpc8349-clk", .data = SOC_MPC8349 },
 	{ .compatible = "fsl,mpc8360-clk", .data = SOC_MPC8360 },
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/mpc83xx_clk.h b/drivers/clk/mpc83xx_clk.h
index ce3683f3932..ba7ea9dd741 100644
--- a/drivers/clk/mpc83xx_clk.h
+++ b/drivers/clk/mpc83xx_clk.h
@@ -125,7 +125,6 @@ static const char * const names[] = {
 	[MPC83XX_CLK_TSEC1] = "TSEC1",
 	[MPC83XX_CLK_TSEC2] = "TSEC2",
 	[MPC83XX_CLK_USBDR] = "USB DR",
-	[MPC83XX_CLK_USBMPH] = "USB MPH",
 	[MPC83XX_CLK_PCIEXP1] = "PCIEXP1",
 	[MPC83XX_CLK_PCIEXP2] = "PCIEXP2",
 	[MPC83XX_CLK_SATA] = "SATA",
@@ -214,10 +213,8 @@ static int retrieve_mode(int clk, int soc_type, struct clk_mode *mode)
 		set_mode(mode, 6, 7, TYPE_SCCR_STANDARD);
 		break;
 	case MPC83XX_CLK_I2C1:
-		if (soc_type == SOC_MPC8349)
-			set_mode(mode, 2, 3, TYPE_SCCR_STANDARD);
-		else /* I2C and ENC are the same register */
-			set_mode(mode, 6, 7, TYPE_SCCR_STANDARD);
+		/* I2C and ENC use the same register */
+		set_mode(mode, 6, 7, TYPE_SCCR_STANDARD);
 		break;
 	case MPC83XX_CLK_PCIEXP1:
 		set_mode(mode, 10, 11, TYPE_SCCR_STANDARD);
@@ -226,12 +223,6 @@ static int retrieve_mode(int clk, int soc_type, struct clk_mode *mode)
 		set_mode(mode, 12, 13, TYPE_SCCR_STANDARD);
 		break;
 	case MPC83XX_CLK_USBDR:
-		if (soc_type == SOC_MPC8349)
-			set_mode(mode, 10, 11, TYPE_SCCR_STANDARD);
-		else
-			set_mode(mode, 8, 9, TYPE_SCCR_STANDARD);
-		break;
-	case MPC83XX_CLK_USBMPH:
 		set_mode(mode, 8, 9, TYPE_SCCR_STANDARD);
 		break;
 	case MPC83XX_CLK_PCI:
diff --git a/drivers/cpu/mpc83xx_cpu.c b/drivers/cpu/mpc83xx_cpu.c
index 01ac307c821..56b192ca153 100644
--- a/drivers/cpu/mpc83xx_cpu.c
+++ b/drivers/cpu/mpc83xx_cpu.c
@@ -73,9 +73,6 @@ static inline void determine_family(const struct udevice *dev)
 	case 0x806:
 		priv->family = FAMILY_832X;
 		break;
-	case 0x803:
-		priv->family = FAMILY_834X;
-		break;
 	case 0x804:
 		priv->family = FAMILY_836X;
 		break;
@@ -111,18 +108,6 @@ static inline void determine_type(const struct udevice *dev)
 	case 0x8062:
 		priv->type = TYPE_8323;
 		break;
-	case 0x8036:
-		priv->type = TYPE_8343;
-		break;
-	case 0x8032:
-		priv->type = TYPE_8347_TBGA;
-		break;
-	case 0x8034:
-		priv->type = TYPE_8347_PBGA;
-		break;
-	case 0x8030:
-		priv->type = TYPE_8349;
-		break;
 	case 0x804A:
 		priv->type = TYPE_8358_TBGA;
 		break;
@@ -177,13 +162,8 @@ static inline void determine_revid(const struct udevice *dev)
 	u32 REVID_MINOR_MASK;
 	u32 spridr = get_spridr();
 
-	if (priv->family == FAMILY_834X) {
-		REVID_MAJOR_MASK = 0x0000FF00;
-		REVID_MINOR_MASK = 0x000000FF;
-	} else {
-		REVID_MAJOR_MASK = 0x000000F0;
-		REVID_MINOR_MASK = 0x0000000F;
-	}
+	REVID_MAJOR_MASK = 0x000000F0;
+	REVID_MINOR_MASK = 0x0000000F;
 
 	priv->revid.major = bitfield_extract_by_mask(spridr, REVID_MAJOR_MASK);
 	priv->revid.minor = bitfield_extract_by_mask(spridr, REVID_MINOR_MASK);
@@ -204,8 +184,7 @@ static void determine_cpu_data(const struct udevice *dev)
 	determine_e300_type(dev);
 	determine_revid(dev);
 
-	if ((priv->family == FAMILY_834X ||
-	     priv->family == FAMILY_836X) && priv->revid.major >= 2)
+	if (priv->family == FAMILY_836X && priv->revid.major >= 2)
 		priv->is_a_variant = true;
 
 	priv->is_e_processor = !bitfield_extract_by_mask(spridr, E_FLAG_MASK);
@@ -307,7 +286,6 @@ static const struct udevice_id mpc83xx_cpu_ids[] = {
 	{ .compatible = "fsl,mpc8308", },
 	{ .compatible = "fsl,mpc8309", },
 	{ .compatible = "fsl,mpc832x", },
-	{ .compatible = "fsl,mpc8349", },
 	{ .compatible = "fsl,mpc8360", },
 	{ /* sentinel */ }
 };
diff --git a/drivers/cpu/mpc83xx_cpu.h b/drivers/cpu/mpc83xx_cpu.h
index d9773d893f1..f86b36114ab 100644
--- a/drivers/cpu/mpc83xx_cpu.h
+++ b/drivers/cpu/mpc83xx_cpu.h
@@ -36,14 +36,12 @@ static const char * const e300_names[] = {
  * enum mpc83xx_cpu_family - Identifiers for MPC83xx CPU families
  * @FAMILY_830X:    Identifier for the MPC830x CPU family
  * @FAMILY_832X:    Identifier for the MPC832x CPU family
- * @FAMILY_834X:    Identifier for the MPC834x CPU family
  * @FAMILY_836X:    Identifier for the MPC836x CPU family
  * @FAMILY_UNKNOWN: Identifier for an unknown MPC83xx CPU family
  */
 enum mpc83xx_cpu_family {
 	FAMILY_830X,
 	FAMILY_832X,
-	FAMILY_834X,
 	FAMILY_836X,
 	FAMILY_UNKNOWN,
 };
@@ -54,12 +52,6 @@ enum mpc83xx_cpu_family {
  * @TYPE_8309:      Identifier for the MPC8309 CPU type
  * @TYPE_8321:      Identifier for the MPC8321 CPU type
  * @TYPE_8323:      Identifier for the MPC8323 CPU type
- * @TYPE_8343:      Identifier for the MPC8343 CPU type
- * @TYPE_8347_TBGA: Identifier for the MPC8347 CPU type (Tape Ball Grid Array
- *		    version)
- * @TYPE_8347_PBGA: Identifier for the MPC8347 CPU type (Plastic Ball Grid Array
- *		    version)
- * @TYPE_8349:      Identifier for the MPC8349 CPU type
  * @TYPE_8358_TBGA: Identifier for the MPC8358 CPU type (Tape Ball Grid Array
  *		    version)
  * @TYPE_8358_PBGA: Identifier for the MPC8358 CPU type (Plastic Ball Grid Array
@@ -72,10 +64,6 @@ enum mpc83xx_cpu_type {
 	TYPE_8309,
 	TYPE_8321,
 	TYPE_8323,
-	TYPE_8343,
-	TYPE_8347_TBGA,
-	TYPE_8347_PBGA,
-	TYPE_8349,
 	TYPE_8358_TBGA,
 	TYPE_8358_PBGA,
 	TYPE_8360,
@@ -88,10 +76,6 @@ static const char * const cpu_type_names[] = {
 	[TYPE_8309] = "8309",
 	[TYPE_8321] = "8321",
 	[TYPE_8323] = "8323",
-	[TYPE_8343] = "8343",
-	[TYPE_8347_TBGA] = "8347_TBGA",
-	[TYPE_8347_PBGA] = "8347_PBGA",
-	[TYPE_8349] = "8349",
 	[TYPE_8358_TBGA] = "8358_TBGA",
 	[TYPE_8358_PBGA] = "8358_PBGA",
 	[TYPE_8360] = "8360",
diff --git a/drivers/pci/pci_auto.c b/drivers/pci/pci_auto.c
index 4a1c782be36..e1e1fb21e08 100644
--- a/drivers/pci/pci_auto.c
+++ b/drivers/pci/pci_auto.c
@@ -567,20 +567,6 @@ int dm_pciauto_config_device(struct udevice *dev)
 		      PCI_DEV(dm_pci_get_bdf(dev)));
 		break;
 #endif
-#if defined(CONFIG_ARCH_MPC834X)
-	case PCI_CLASS_BRIDGE_OTHER:
-		/*
-		 * The host/PCI bridge 1 seems broken in 8349 - it presents
-		 * itself as 'PCI_CLASS_BRIDGE_OTHER' and appears as an _agent_
-		 * device claiming resources io/mem/irq.. we only allow for
-		 * the PIMMR window to be allocated (BAR0 - 1MB size)
-		 */
-		debug("PCI Autoconfig: Broken bridge found, only minimal config\n");
-		dm_pciauto_setup_device(dev, 0, hose->pci_mem,
-					hose->pci_prefetch, hose->pci_io);
-		break;
-#endif
-
 	default:
 		dm_pciauto_setup_device(dev, pci_mem, pci_prefetch, pci_io);
 		break;
diff --git a/include/dt-bindings/clk/mpc83xx-clk.h b/include/dt-bindings/clk/mpc83xx-clk.h
index db4ea15cf42..86d7101ef1c 100644
--- a/include/dt-bindings/clk/mpc83xx-clk.h
+++ b/include/dt-bindings/clk/mpc83xx-clk.h
@@ -22,7 +22,6 @@
 #define MPC83XX_CLK_TSEC1	13
 #define MPC83XX_CLK_TSEC2	14
 #define MPC83XX_CLK_USBDR	15
-#define MPC83XX_CLK_USBMPH	16
 #define MPC83XX_CLK_PCIEXP1	17
 #define MPC83XX_CLK_PCIEXP2	18
 #define MPC83XX_CLK_SATA	19
diff --git a/include/mpc83xx.h b/include/mpc83xx.h
index 8a1a9e7a9b9..d570ba61b7f 100644
--- a/include/mpc83xx.h
+++ b/include/mpc83xx.h
@@ -44,13 +44,8 @@
 #define SPRIDR_PARTID			0xFFFF0000	/* Part Id */
 #define SPRIDR_REVID			0x0000FFFF	/* Revision Id */
 
-#if defined(CONFIG_ARCH_MPC834X)
-#define REVID_MAJOR(spridr)		((spridr & 0x0000FF00) >> 8)
-#define REVID_MINOR(spridr)		(spridr & 0x000000FF)
-#else
 #define REVID_MAJOR(spridr)		((spridr & 0x000000F0) >> 4)
 #define REVID_MINOR(spridr)		(spridr & 0x0000000F)
-#endif
 
 #define PARTID_NO_E(spridr)		((spridr & 0xFFFE0000) >> 16)
 #define SPR_FAMILY(spridr)		((spridr & 0xFFF00000) >> 20)
@@ -60,11 +55,6 @@
 #define SPR_832X_FAMILY			0x806
 #define SPR_8321			0x8066
 #define SPR_8323			0x8062
-#define SPR_834X_FAMILY			0x803
-#define SPR_8343			0x8036
-#define SPR_8347_TBGA_			0x8032
-#define SPR_8347_PBGA_			0x8034
-#define SPR_8349			0x8030
 #define SPR_836X_FAMILY			0x804
 #define SPR_8358_TBGA_			0x804A
 #define SPR_8358_PBGA_			0x804E
@@ -87,28 +77,7 @@
 #define SPCR_COREPR			0x00300000
 #define SPCR_COREPR_SHIFT		(31-11)
 
-#if defined(CONFIG_ARCH_MPC834X)
-/* SPCR bits - MPC8349 specific */
-/* TSEC1 data priority */
-#define SPCR_TSEC1DP			0x00003000
-#define SPCR_TSEC1DP_SHIFT		(31-19)
-/* TSEC1 buffer descriptor priority */
-#define SPCR_TSEC1BDP			0x00000C00
-#define SPCR_TSEC1BDP_SHIFT		(31-21)
-/* TSEC1 emergency priority */
-#define SPCR_TSEC1EP			0x00000300
-#define SPCR_TSEC1EP_SHIFT		(31-23)
-/* TSEC2 data priority */
-#define SPCR_TSEC2DP			0x00000030
-#define SPCR_TSEC2DP_SHIFT		(31-27)
-/* TSEC2 buffer descriptor priority */
-#define SPCR_TSEC2BDP			0x0000000C
-#define SPCR_TSEC2BDP_SHIFT		(31-29)
-/* TSEC2 emergency priority */
-#define SPCR_TSEC2EP			0x00000003
-#define SPCR_TSEC2EP_SHIFT		(31-31)
-
-#elif defined(CONFIG_ARCH_MPC8308)
+#if defined(CONFIG_ARCH_MPC8308)
 /* SPCR bits - MPC8308 specific */
 /* TSEC data priority */
 #define SPCR_TSECDP			0x00003000
@@ -123,53 +92,7 @@
 
 /* SICRL/H - System I/O Configuration Register Low/High
  */
-#if defined(CONFIG_ARCH_MPC834X)
-/* SICRL bits - MPC8349 specific */
-#define SICRL_LDP_A			0x80000000
-#define SICRL_USB1			0x40000000
-#define SICRL_USB0			0x20000000
-#define SICRL_UART			0x0C000000
-#define SICRL_GPIO1_A			0x02000000
-#define SICRL_GPIO1_B			0x01000000
-#define SICRL_GPIO1_C			0x00800000
-#define SICRL_GPIO1_D			0x00400000
-#define SICRL_GPIO1_E			0x00200000
-#define SICRL_GPIO1_F			0x00180000
-#define SICRL_GPIO1_G			0x00040000
-#define SICRL_GPIO1_H			0x00020000
-#define SICRL_GPIO1_I			0x00010000
-#define SICRL_GPIO1_J			0x00008000
-#define SICRL_GPIO1_K			0x00004000
-#define SICRL_GPIO1_L			0x00003000
-
-/* SICRH bits - MPC8349 specific */
-#define SICRH_DDR			0x80000000
-#define SICRH_TSEC1_A			0x10000000
-#define SICRH_TSEC1_B			0x08000000
-#define SICRH_TSEC1_C			0x04000000
-#define SICRH_TSEC1_D			0x02000000
-#define SICRH_TSEC1_E			0x01000000
-#define SICRH_TSEC1_F			0x00800000
-#define SICRH_TSEC2_A			0x00400000
-#define SICRH_TSEC2_B			0x00200000
-#define SICRH_TSEC2_C			0x00100000
-#define SICRH_TSEC2_D			0x00080000
-#define SICRH_TSEC2_E			0x00040000
-#define SICRH_TSEC2_F			0x00020000
-#define SICRH_TSEC2_G			0x00010000
-#define SICRH_TSEC2_H			0x00008000
-#define SICRH_GPIO2_A			0x00004000
-#define SICRH_GPIO2_B			0x00002000
-#define SICRH_GPIO2_C			0x00001000
-#define SICRH_GPIO2_D			0x00000800
-#define SICRH_GPIO2_E			0x00000400
-#define SICRH_GPIO2_F			0x00000200
-#define SICRH_GPIO2_G			0x00000180
-#define SICRH_GPIO2_H			0x00000060
-#define SICRH_TSOBI1			0x00000002
-#define SICRH_TSOBI2			0x00000001
-
-#elif defined(CONFIG_ARCH_MPC8360)
+#if defined(CONFIG_ARCH_MPC8360)
 /* SICRL bits - MPC8360 specific */
 #define SICRL_LDP_A			0xC0000000
 #define SICRL_LCLK_1			0x10000000
@@ -435,22 +358,13 @@
 #define HRCWH_PCI_HOST_SHIFT		31
 #define HRCWH_PCI_AGENT			0x00000000
 
-#if defined(CONFIG_ARCH_MPC834X)
-#define HRCWH_32_BIT_PCI		0x00000000
-#define HRCWH_64_BIT_PCI		0x40000000
-#endif
-
 #define HRCWH_PCI1_ARBITER_DISABLE	0x00000000
 #define HRCWH_PCI1_ARBITER_ENABLE	0x20000000
 
 #define HRCWH_PCI_ARBITER_DISABLE	0x00000000
 #define HRCWH_PCI_ARBITER_ENABLE	0x20000000
 
-#if defined(CONFIG_ARCH_MPC834X)
-#define HRCWH_PCI2_ARBITER_DISABLE	0x00000000
-#define HRCWH_PCI2_ARBITER_ENABLE	0x10000000
-
-#elif defined(CONFIG_ARCH_MPC8360)
+#if defined(CONFIG_ARCH_MPC8360)
 #define HRCWH_PCICKDRV_DISABLE		0x00000000
 #define HRCWH_PCICKDRV_ENABLE		0x10000000
 #endif
@@ -470,9 +384,6 @@
 
 #define HRCWH_ROM_LOC_DDR_SDRAM		0x00000000
 #define HRCWH_ROM_LOC_PCI1		0x00100000
-#if defined(CONFIG_ARCH_MPC834X)
-#define HRCWH_ROM_LOC_PCI2		0x00200000
-#endif
 #define HRCWH_ROM_LOC_LOCAL_8BIT	0x00500000
 #define HRCWH_ROM_LOC_LOCAL_16BIT	0x00600000
 #define HRCWH_ROM_LOC_LOCAL_32BIT	0x00700000
@@ -501,17 +412,6 @@
 #define HRCWH_TSEC2M_IN_SGMII		0x00001800
 #endif
 
-#if defined(CONFIG_ARCH_MPC834X)
-#define HRCWH_TSEC1M_IN_RGMII		0x00000000
-#define HRCWH_TSEC1M_IN_RTBI		0x00004000
-#define HRCWH_TSEC1M_IN_GMII		0x00008000
-#define HRCWH_TSEC1M_IN_TBI		0x0000C000
-#define HRCWH_TSEC2M_IN_RGMII		0x00000000
-#define HRCWH_TSEC2M_IN_RTBI		0x00001000
-#define HRCWH_TSEC2M_IN_GMII		0x00002000
-#define HRCWH_TSEC2M_IN_TBI		0x00003000
-#endif
-
 #if defined(CONFIG_ARCH_MPC8360)
 #define HRCWH_SECONDARY_DDR_DISABLE	0x00000000
 #define HRCWH_SECONDARY_DDR_ENABLE	0x00000010
@@ -647,35 +547,7 @@
 #define SCCR_PCICM			0x00010000
 #define SCCR_PCICM_SHIFT		16
 
-#if defined(CONFIG_ARCH_MPC834X)
-/* SCCR bits - MPC834X specific */
-#define SCCR_TSEC1CM			0xc0000000
-#define SCCR_TSEC1CM_SHIFT		30
-#define SCCR_TSEC1CM_0			0x00000000
-#define SCCR_TSEC1CM_1			0x40000000
-#define SCCR_TSEC1CM_2			0x80000000
-#define SCCR_TSEC1CM_3			0xC0000000
-
-#define SCCR_TSEC2CM			0x30000000
-#define SCCR_TSEC2CM_SHIFT		28
-#define SCCR_TSEC2CM_0			0x00000000
-#define SCCR_TSEC2CM_1			0x10000000
-#define SCCR_TSEC2CM_2			0x20000000
-#define SCCR_TSEC2CM_3			0x30000000
-
-/* The MPH must have the same clock ratio as DR, unless its clock disabled */
-#define SCCR_USBMPHCM			0x00c00000
-#define SCCR_USBMPHCM_SHIFT		22
-#define SCCR_USBDRCM			0x00300000
-#define SCCR_USBDRCM_SHIFT		20
-#define SCCR_USBCM			0x00f00000
-#define SCCR_USBCM_SHIFT		20
-#define SCCR_USBCM_0			0x00000000
-#define SCCR_USBCM_1			0x00500000
-#define SCCR_USBCM_2			0x00A00000
-#define SCCR_USBCM_3			0x00F00000
-
-#elif defined(CONFIG_ARCH_MPC8308)
+#if defined(CONFIG_ARCH_MPC8308)
 /* SCCR bits - MPC8308 specific */
 #define SCCR_TSEC1CM			0xc0000000
 #define SCCR_TSEC1CM_SHIFT		30
-- 
2.47.3

