Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC06606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l0AKE8JJ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dn6ge5et
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2972B606FA;
	Mon, 16 Nov 2026 08:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RrpSkUHpAQ-t; Mon, 16 Nov 2026 08:30:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 992E1606AE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794817824;
	b=eY49w7GpnVjneOr7VvEMxRaIwvLN+dibSYQPIifGvJFSqz7qzE2oLDhomzAFXvgM8AEx
	 GQuVnWScqrmZGBGe42u2y62W+CRe0KuhfMsdOwmlyeGoNej7QIdmDAYDsMQkdUsGVLguG
	 uEZCYOFSUsSl2g3pjgp06xBPL5lJoVJD21qA24UMTw/Ir80inrk5ucVMxnaMce/6mksfX
	 3qU4z2PvDLlZ6TOZSmmxGWF+7fcpWXOQ5rNEeTVj+VIjJZnt5TRDsmGlHMi91T9BgdfTU
	 9/Cm7VL6mjtHHljKMzgTTc2RreASRXHsXK34A/m+z6Dg/zLMvCmdRdYtiEhd6Zv1AHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794817824;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ONFl16ky6H9FV+E95bGyJBUieffZ+VueRuZDYCUxRwQ=;
	b=OGjJ/+76dVN8AOU/q2iS7FrP1df6JdsBdPmPuuNQxjicFwMsP3/giPzV2ooulcgT7mgl
	 8Hmj0w8Uc2WAMTJFyX9uscEo4OyD4EcmdXpDibzYk/CDQ1HgH/omKC+ffTkExLGDYZRxQ
	 v0nbRDCMABkri8rgKaSyr+eD8LG/y5lSdMX/yMptrEm5KFXRWKH1VKQXDDvSFCsetPAHx
	 w2MbTBv4xHokCE5PLizqyQjnY2YV3IcomnVBdVvlX5ME5oAMq1/DrllN7alpKHAQjxCYx
	 5clgZ5g7EQHFeYUdTH3dO/svGCjMVgPkJjOFmLCX2+gxrrzqiOQJvaKC/ce3oNlgy+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794817824;
	bh=ONFl16ky6H9FV+E95bGyJBUieffZ+VueRuZDYCUxRwQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l0AKE8JJKPiB3WRJD+DB0YoxJ05satC4hamCiQG7iDNzLRfrWH0MtSLgeXgANJq76
	 vEoJCOYQJr/wK7S+tUIN38IzlaAm8XVIcwIRDkgkPoaYxfSuKoFAjk55LdoZOcbXjp
	 KB8zfcDtJCcvDdzVtouyGfuryeFQfFipUp3htg+vB2CRsu6I56OVEGYXehqFVM6u/9
	 ZfrlRINvyOyinw2OEse/QEa8Tygno85ZUoN+y5G8kCbSEk9UlkN5aGfWIrAPmwkDGO
	 uYln+0tn0nN6lXFThAroSdKBPhnjRZhWSbS/pyVLPDkMaVUunPiyarKmBCQLFTAqcY
	 4csZz5nO/Oo8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 992E1606AE;
	Mon, 16 Nov 2026 08:30:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D326176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 436154009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:30:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwtxV8kssAlA for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 08:30:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 92D7B40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=dn6ge5et
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92D7B40012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:30:20 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso1254305f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 00:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794817819; x=1795422619;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ONFl16ky6H9FV+E95bGyJBUieffZ+VueRuZDYCUxRwQ=;
 b=dn6ge5et+aA8V2bF6KHWD9Jge/al3eZOimLyETDO+xY1089w7PbKk+9qDDOuyYDOvr
 vlpffQYk6AK/Z4MYsMBpZ6KQjltp+XlDBzma9M+1VhDCoWQrnhMST9glxz+d0WBYR8Iy
 hIgSy9FreaptZqVNWpgOP5iXtPBsmZz7mBnh12HhjzNuD6xTo4eq6icRqcdLG5JVYmLt
 gFx8kQSZ/C1cFP9CNIgSP9xLEQKehtJMrgMK49kpu8nhZhYV84ol8gar9wvxrwfnCYDU
 7LMJJuXMEYMsUkz1N6Zir9AKQWfO6Z2s87cJ/xdnn/pSx17yGeKN+m/N8I0aNsvKCumZ
 ogiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794817819; x=1795422619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ONFl16ky6H9FV+E95bGyJBUieffZ+VueRuZDYCUxRwQ=;
 b=DnRgXguxgJC5SdXpC2cNys7rj6Yi49eOJ5diNFotCQEzs7/8ECD1EeqU+ezOmsPv3k
 7hhDskAIwwGBpUwtbW15zapW2hqpbn//0PXI0RdjEqRsc9KRslEtlDPJU6r1Tfs8Ihs/
 yZTrVA3Ygk3nHCm04OyShXJVM2AqWZinG+Q7NNi+5y7UsdYLvh7lSOkk9AA9hDnhcf10
 4yuByOd77HrPQT+dG96UTK8FbdSSQXZ4BW+ud9hTbj36fjTW+LqNtEO3ofHOYdNvBnZq
 iGoNyXK2KtHgQ3ZUmnxPXwF+Ce4lvkJtJ8LfYDzZnWIhzPHkvEbQDfUu5CCg4ObUr3LW
 1TXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFeL/Tmpa4DIUOxw9XA0NFmi2o9njOxKJmPwaAUKc35NOF6fdWvZG7Ro91sOIVgKzcyO6z4xtw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/na0QmEtc/A/KE6onSRP2RnHdB8y7q/p6tXRHKVtmi1ETKo/dm
 88doRx3YmdPXosDXxCBoPNF8YzkkppJIAQfsMc7Pqi8qVDv2bnXKUnLoZ99QIlM3
X-Gm-Gg: AZFdTZcMQ2ko0iskrRpLAVPex+xtmCT+t1xPzORP8z9ZjxftoLWxZnhDtE7qz/dg7XI
 mMH13nnJl129itUIYtK42FwlF6va/r/QgvSviwf1hVElLkelbH1WwypNF7Wdti57Vu07tRKpkZ7
 /JQOGiZVcId60V5I6UOUvVWAEzUz3KnctIYnLBphviMpheS5wE52ZyBdTeQf1V7+eN4fI9j77qi
 cHrMdpeJMKPeBZDLhusy/utZQqo/di5hVxmJybc3sj7ET+qD85Vrj9M58p5ffMcqjgsxPCi8+ez
 pCYNddeiJG+X4NSx74IceBn4jbgXgAuUPzupcgpxAezCr9lTmu/2+isd7A4BkqVeI66pEDDZ9EX
 yNgG16ziSXjQgzbba4exK57JDoGlDawoqq7q75YGcCwLzkA8/OXUaAfgpkkahXcMnZV922BvuDy
 aQ3z1+OpyelcymrxBpa946BFJi1/BQGt0L1XtDFkIN0hiRMLT3bioDzU7xKxvediGDdmp5IAwT9
 8DRM5snLHRYvel0D5sdssyt8k5dhtWnWtVa7qENht2ABxOowH1LBX4XFUT8yMzj/9PxI6sGXIIt
 ardVM/XVZqo1LA19GLAuvZlpz4q4//ypOII=
X-Received: by 2002:a05:6000:3c5:b0:48e:3fc:e393 with SMTP id
 ffacd0b85a97d-49c6fc9e60emr20875691f8f.6.1794817818637; 
 Mon, 16 Nov 2026 00:30:18 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49d7150529dsm15463335f8f.51.2026.11.16.00.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:30:18 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Stefan Agner <stefan@agner.ch>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH v2] colibri_vf: configure the DDR controller from the DCD
Date: Mon, 16 Nov 2026 09:30:17 +0100
Message-ID: <20261116083017.1200219-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The ROM copies the whole image into the on-chip graphics RAM and runs
it there. On the VF61 the L2 data array takes the upper half of that
RAM, so the image has to stay under 480 KB, and the board sits a few
KB below the limit. The i.MX6 boards without SPL let the ROM bring the
DDR up from the Device Configuration Data in the image header and load
U-Boot straight into DDR. The Vybrid ROM reads the same DCD (VFxxxRM
rev. 8, 7.5.6.2); this board brought the DDR up in C instead, from the
RAM the ROM had copied it to.

Move the DDR controller setup into the DCD: the clock gates, PLL2 with
its PFD2 as the DDR clock, the DDR pads, the DDRMC and PHY registers in
the order the board code wrote them, the controller start and its
completion. The entries are a trace of the register writes the C
sequence made, so the values are the ones Toradex validated. The DDR
clock comes from PLL2 PFD2 on both modules; the VF50 took it from the
system clock before, at the same 396 MHz. U-Boot links at 0x87800000,
inside the 128 MB of the VF50, and the size limit goes away.

The limit is what stops CMD_NANDBCB, which writes the boot control
block the ROM needs, and the USB Ethernet and CDC ACM gadgets for
flashing and a console over the USB cable: colibri_vf_defconfig with
these three is 499536 bytes on main, 7.8 KB over.

Tested on three Colibri VF50 and two Colibri VF61 modules from -28 C to
+85 C ambient, each first with the current U-Boot and then with this
patch: power cycles and reboots taking turns, each followed by a
memtester run, 669 boots with the current U-Boot and 670 with the
patch, and memtester in a loop while the temperature ramps over the
whole range after 45 minutes powered off at each end. No boot and no
memtester run failed, with or without the DCD.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---

Notes:
    Changes in v2:
    - the commit message names the features the size limit stops and the
      temperature tests (Francesco)
    - Acked-by from Francesco
    - rebased on main
    
    The DCD entries come from a trace of the register writes the C
    sequence made on the VF61 (every writel in ddrmc_ctrl_init_ddr3, the
    DDR pads the pinctrl driver set and the clock bits the DDR needs), so
    no value was typed by hand. The VF50 trace differs only in the clock
    selection, which the DCD makes the same on both.
    
    Read back after the DCD boot: CCM_CCSR 0x0003ff24 (VF50) and
    0x0001ff24 (VF61), DDRC_CLK_SEL 0 on both; ANADIG_PLL2_CTRL 0x80002001
    (locked); DDRMC CR80 0x11000000; relocation offset 0x00783000 (VF50)
    and 0x08783000 (VF61) from 0x87800000.
    
    A 1.06 MB build of the same tree (EFI with secure boot, bootstd, more
    file systems and compressors), larger than the whole on-chip RAM of
    the VF50, boots from NAND the same way and reaches Linux.
    
    The generator that turns such a trace into the cfg lines is not part
    of the patch; the cfg is the result.

 board/toradex/colibri_vf/colibri_vf.c | 131 ++-------------------
 board/toradex/colibri_vf/imximage.cfg | 158 ++++++++++++++++++++++++++
 configs/colibri_vf_defconfig          |   4 +-
 3 files changed, 166 insertions(+), 127 deletions(-)

diff --git a/board/toradex/colibri_vf/colibri_vf.c b/board/toradex/colibri_vf/colibri_vf.c
index 87f82396d63..adf755707f9 100644
--- a/board/toradex/colibri_vf/colibri_vf.c
+++ b/board/toradex/colibri_vf/colibri_vf.c
@@ -11,7 +11,6 @@
 
 #include <asm/arch/clock.h>
 #include <asm/arch/crm_regs.h>
-#include <asm/arch/ddrmc-vf610.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/iomux-vf610.h>
 #include <asm/gpio.h>
@@ -29,120 +28,8 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define PTC0_GPIO_45		45
 
-static struct ddrmc_cr_setting colibri_vf_cr_settings[] = {
-	{ DDRMC_CR79_CTLUPD_AREF(1), 79 },
-	/* sets manual values for read lvl. (gate) delay of data slice 0/1 */
-	{ DDRMC_CR105_RDLVL_DL_0(28), 105 },
-	{ DDRMC_CR106_RDLVL_GTDL_0(24), 106 },
-	{ DDRMC_CR110_RDLVL_DL_1(28) | DDRMC_CR110_RDLVL_GTDL_1(24), 110 },
-	{ DDRMC_CR102_RDLVL_GT_REGEN | DDRMC_CR102_RDLVL_REG_EN, 102 },
-
-	/* AXI */
-	{ DDRMC_CR117_AXI0_W_PRI(0) | DDRMC_CR117_AXI0_R_PRI(0), 117 },
-	{ DDRMC_CR118_AXI1_W_PRI(1) | DDRMC_CR118_AXI1_R_PRI(1), 118 },
-	{ DDRMC_CR120_AXI0_PRI1_RPRI(2) |
-		   DDRMC_CR120_AXI0_PRI0_RPRI(2), 120 },
-	{ DDRMC_CR121_AXI0_PRI3_RPRI(2) |
-		   DDRMC_CR121_AXI0_PRI2_RPRI(2), 121 },
-	{ DDRMC_CR122_AXI1_PRI1_RPRI(1) | DDRMC_CR122_AXI1_PRI0_RPRI(1) |
-		   DDRMC_CR122_AXI0_PRIRLX(100), 122 },
-	{ DDRMC_CR123_AXI1_P_ODR_EN | DDRMC_CR123_AXI1_PRI3_RPRI(1) |
-		   DDRMC_CR123_AXI1_PRI2_RPRI(1), 123 },
-	{ DDRMC_CR124_AXI1_PRIRLX(100), 124 },
-	{ DDRMC_CR126_PHY_RDLAT(8), 126 },
-	{ DDRMC_CR132_WRLAT_ADJ(5) |
-		   DDRMC_CR132_RDLAT_ADJ(6), 132 },
-	{ DDRMC_CR137_PHYCTL_DL(2), 137 },
-	{ DDRMC_CR138_PHY_WRLV_MXDL(256) |
-		   DDRMC_CR138_PHYDRAM_CK_EN(1), 138 },
-	{ DDRMC_CR139_PHY_WRLV_RESPLAT(4) | DDRMC_CR139_PHY_WRLV_LOAD(7) |
-		   DDRMC_CR139_PHY_WRLV_DLL(3) |
-		   DDRMC_CR139_PHY_WRLV_EN(3), 139 },
-	{ DDRMC_CR140_PHY_WRLV_WW(64), 140 },
-	{ DDRMC_CR143_RDLV_GAT_MXDL(1536) |
-		   DDRMC_CR143_RDLV_MXDL(128), 143 },
-	{ DDRMC_CR144_PHY_RDLVL_RES(4) | DDRMC_CR144_PHY_RDLV_LOAD(7) |
-		   DDRMC_CR144_PHY_RDLV_DLL(3) |
-		   DDRMC_CR144_PHY_RDLV_EN(3), 144 },
-	{ DDRMC_CR145_PHY_RDLV_RR(64), 145 },
-	{ DDRMC_CR146_PHY_RDLVL_RESP(64), 146 },
-	{ DDRMC_CR147_RDLV_RESP_MASK(983040), 147 },
-	{ DDRMC_CR148_RDLV_GATE_RESP_MASK(983040), 148 },
-	{ DDRMC_CR151_RDLV_GAT_DQ_ZERO_CNT(1) |
-		   DDRMC_CR151_RDLVL_DQ_ZERO_CNT(1), 151 },
-
-	{ DDRMC_CR154_PAD_ZQ_EARLY_CMP_EN_TIMER(13) |
-		   DDRMC_CR154_PAD_ZQ_MODE(1) |
-		   DDRMC_CR154_DDR_SEL_PAD_CONTR(3) |
-		   DDRMC_CR154_PAD_ZQ_HW_FOR(1), 154 },
-	{ DDRMC_CR155_PAD_ODT_BYTE1(2) | DDRMC_CR155_PAD_ODT_BYTE0(2), 155 },
-	{ DDRMC_CR158_TWR(6), 158 },
-	{ DDRMC_CR161_ODT_EN(1) | DDRMC_CR161_TODTH_RD(2) |
-		   DDRMC_CR161_TODTH_WR(2), 161 },
-	/* end marker */
-	{ 0, -1 }
-};
-
 int dram_init(void)
 {
-	static const struct ddr3_jedec_timings timings = {
-		.tinit             = 5,
-		.trst_pwron        = 80000,
-		.cke_inactive      = 200000,
-		.wrlat             = 5,
-		.caslat_lin        = 12,
-		.trc               = 21,
-		.trrd              = 4,
-		.tccd              = 4,
-		.tbst_int_interval = 0,
-		.tfaw              = 20,
-		.trp               = 6,
-		.twtr              = 4,
-		.tras_min          = 15,
-		.tmrd              = 4,
-		.trtp              = 4,
-		.tras_max          = 28080,
-		.tmod              = 12,
-		.tckesr            = 4,
-		.tcke              = 3,
-		.trcd_int          = 6,
-		.tras_lockout      = 0,
-		.tdal              = 12,
-		.bstlen            = 3,
-		.tdll              = 512, /* not applicable since freq. scaling
-					   * is not used
-					   */
-		.trp_ab            = 6,
-		.tref              = 3120,
-		.trfc              = 64,
-		.tref_int          = 0,
-		.tpdex             = 3,
-		.txpdll            = 10,
-		.txsnr             = 68,  /* changed to conform to JEDEC
-					   * specifications
-					   */
-		.txsr              = 506, /* changed to conform to JEDEC
-					   * specifications
-					   */
-		.cksrx             = 5,
-		.cksre             = 5,
-		.freq_chg_en       = 0,
-		.zqcl              = 256,
-		.zqinit            = 512,
-		.zqcs              = 64,
-		.ref_per_zq        = 64,
-		.zqcs_rotate       = 0,
-		.aprebit           = 10,
-		.cmd_age_cnt       = 64,
-		.age_cnt           = 64,
-		.q_fullness        = 7,
-		.odt_rd_mapcs0     = 0,
-		.odt_wr_mapcs0     = 1,
-		.wlmrd             = 40,
-		.wldqsen           = 25,
-	};
-
-	ddrmc_ctrl_init_ddr3(&timings, colibri_vf_cr_settings, NULL, 1, 2);
 	gd->ram_size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE);
 
 	return 0;
@@ -263,12 +150,10 @@ static void clock_init(void)
 			ANADIG_PLL5_CTRL_POWERDOWN, ANADIG_PLL5_CTRL_ENABLE |
 			ANADIG_PLL5_CTRL_DIV_SELECT);
 
-	if (is_colibri_vf61()) {
-		clrsetbits_le32(&anadig->pll2_ctrl, ANADIG_PLL5_CTRL_BYPASS |
-				ANADIG_PLL2_CTRL_POWERDOWN,
-				ANADIG_PLL2_CTRL_ENABLE |
-				ANADIG_PLL2_CTRL_DIV_SELECT);
-	}
+	clrsetbits_le32(&anadig->pll2_ctrl, ANADIG_PLL5_CTRL_BYPASS |
+			ANADIG_PLL2_CTRL_POWERDOWN,
+			ANADIG_PLL2_CTRL_ENABLE |
+			ANADIG_PLL2_CTRL_DIV_SELECT);
 
 	clrsetbits_le32(&anadig->pll1_ctrl, ANADIG_PLL1_CTRL_POWERDOWN,
 			ANADIG_PLL1_CTRL_ENABLE | ANADIG_PLL1_CTRL_DIV_SELECT);
@@ -277,13 +162,11 @@ static void clock_init(void)
 			CCM_CCR_FIRC_EN | CCM_CCR_OSCNT(5));
 
 	/* See "Typical PLL Configuration" */
-	if (is_colibri_vf61()) {
+	if (is_colibri_vf61())
 		pfd_clk_sel = CCM_CCSR_PLL1_PFD_CLK_SEL(1);
-		ddr_clk_sel = CCM_CCSR_DDRC_CLK_SEL(0);
-	} else {
+	else
 		pfd_clk_sel = CCM_CCSR_PLL1_PFD_CLK_SEL(3);
-		ddr_clk_sel = CCM_CCSR_DDRC_CLK_SEL(1);
-	}
+	ddr_clk_sel = CCM_CCSR_DDRC_CLK_SEL(0);
 
 	clrsetbits_le32(&ccm->ccsr, CCM_REG_CTRL_MASK, pfd_clk_sel |
 			CCM_CCSR_PLL2_PFD4_EN | CCM_CCSR_PLL2_PFD3_EN |
diff --git a/board/toradex/colibri_vf/imximage.cfg b/board/toradex/colibri_vf/imximage.cfg
index 7e629d2f9e7..017fa8c3d13 100644
--- a/board/toradex/colibri_vf/imximage.cfg
+++ b/board/toradex/colibri_vf/imximage.cfg
@@ -14,3 +14,161 @@ IMAGE_VERSION	2
 
 /* Boot Offset 0x400, valid for both SD and NAND boot */
 BOOT_OFFSET	FLASH_OFFSET_STANDARD
+
+/*
+ * Device Configuration Data: the ROM runs the DDR controller up before it
+ * loads the image into DDR. Clock gates, PLL2 with its PFD2 as the DDR
+ * clock, the DDR pads, the DDRMC and PHY registers in the order the board
+ * code wrote them, then the controller start and its completion.
+ */
+SET_BIT 4 0x4006b048 0x00030000  /* IOMUXC clock */
+SET_BIT 4 0x4006b04c 0x00000003  /* ANADIG clock */
+SET_BIT 4 0x4006b058 0x30000000  /* DDRMC clock */
+CLR_BIT 4 0x40050030 0x00011000  /* PLL2: no bypass, no power down */
+SET_BIT 4 0x40050030 0x00002001  /* PLL2: enable, 528 MHz */
+CHECK_BITS_SET 4 0x40050030 0x80000000  /* PLL2 lock */
+SET_BIT 4 0x4006b008 0x00002000  /* PLL2 PFD2 enable */
+CLR_BIT 4 0x4006b008 0x00000040  /* DDRC clock from PLL2 PFD2 */
+DATA 4 0x40048220 0x00000180  /* DDR pad 0x220 */
+DATA 4 0x40048224 0x00000180  /* DDR pad 0x224 */
+DATA 4 0x40048228 0x00000180  /* DDR pad 0x228 */
+DATA 4 0x4004822c 0x00000180  /* DDR pad 0x22c */
+DATA 4 0x40048230 0x00000180  /* DDR pad 0x230 */
+DATA 4 0x40048234 0x00000180  /* DDR pad 0x234 */
+DATA 4 0x40048238 0x00000180  /* DDR pad 0x238 */
+DATA 4 0x4004823c 0x00000180  /* DDR pad 0x23c */
+DATA 4 0x40048240 0x00000180  /* DDR pad 0x240 */
+DATA 4 0x40048244 0x00000180  /* DDR pad 0x244 */
+DATA 4 0x40048248 0x00000180  /* DDR pad 0x248 */
+DATA 4 0x4004824c 0x00000180  /* DDR pad 0x24c */
+DATA 4 0x40048250 0x00000180  /* DDR pad 0x250 */
+DATA 4 0x40048254 0x00000180  /* DDR pad 0x254 */
+DATA 4 0x40048258 0x00000180  /* DDR pad 0x258 */
+DATA 4 0x4004825c 0x00000180  /* DDR pad 0x25c */
+DATA 4 0x40048260 0x00000180  /* DDR pad 0x260 */
+DATA 4 0x40048264 0x00000180  /* DDR pad 0x264 */
+DATA 4 0x40048268 0x00000180  /* DDR pad 0x268 */
+DATA 4 0x4004826c 0x00000180  /* DDR pad 0x26c */
+DATA 4 0x40048270 0x00000180  /* DDR pad 0x270 */
+DATA 4 0x40048274 0x00000180  /* DDR pad 0x274 */
+DATA 4 0x40048278 0x00000180  /* DDR pad 0x278 */
+DATA 4 0x4004827c 0x00010180  /* DDR pad 0x27c */
+DATA 4 0x40048280 0x00010180  /* DDR pad 0x280 */
+DATA 4 0x40048284 0x00010180  /* DDR pad 0x284 */
+DATA 4 0x40048288 0x00010180  /* DDR pad 0x288 */
+DATA 4 0x4004828c 0x00010180  /* DDR pad 0x28c */
+DATA 4 0x40048290 0x00010180  /* DDR pad 0x290 */
+DATA 4 0x40048294 0x00010180  /* DDR pad 0x294 */
+DATA 4 0x40048298 0x00010180  /* DDR pad 0x298 */
+DATA 4 0x4004829c 0x00010180  /* DDR pad 0x29c */
+DATA 4 0x400482a0 0x00010180  /* DDR pad 0x2a0 */
+DATA 4 0x400482a4 0x00010180  /* DDR pad 0x2a4 */
+DATA 4 0x400482a8 0x00010180  /* DDR pad 0x2a8 */
+DATA 4 0x400482ac 0x00010180  /* DDR pad 0x2ac */
+DATA 4 0x400482b0 0x00010180  /* DDR pad 0x2b0 */
+DATA 4 0x400482b4 0x00010180  /* DDR pad 0x2b4 */
+DATA 4 0x400482b8 0x00010180  /* DDR pad 0x2b8 */
+DATA 4 0x400482bc 0x00010180  /* DDR pad 0x2bc */
+DATA 4 0x400482c0 0x00010180  /* DDR pad 0x2c0 */
+DATA 4 0x400482c4 0x00010180  /* DDR pad 0x2c4 */
+DATA 4 0x400482c8 0x00010180  /* DDR pad 0x2c8 */
+DATA 4 0x400482cc 0x00000180  /* DDR pad 0x2cc */
+DATA 4 0x400482d0 0x00000180  /* DDR pad 0x2d0 */
+DATA 4 0x400482d4 0x00000180  /* DDR pad 0x2d4 */
+DATA 4 0x400482d8 0x00000180  /* DDR pad 0x2d8 */
+DATA 4 0x400482dc 0x00000180  /* DDR pad 0x2dc */
+DATA 4 0x400482e0 0x00000180  /* DDR pad 0x2e0 */
+DATA 4 0x4004821c 0x00000180  /* DDR pad 0x21c */
+DATA 4 0x400ae000 0x00000600  /* CR0 */
+DATA 4 0x400ae008 0x00000005  /* CR2 */
+DATA 4 0x400ae028 0x00013880  /* CR10 */
+DATA 4 0x400ae02c 0x00030d40  /* CR11 */
+DATA 4 0x400ae030 0x0000050c  /* CR12 */
+DATA 4 0x400ae034 0x15040400  /* CR13 */
+DATA 4 0x400ae038 0x1406040f  /* CR14 */
+DATA 4 0x400ae040 0x04040000  /* CR16 */
+DATA 4 0x400ae044 0x006db00c  /* CR17 */
+DATA 4 0x400ae048 0x00000403  /* CR18 */
+DATA 4 0x400ae050 0x01000000  /* CR20 */
+DATA 4 0x400ae054 0x00060001  /* CR21 */
+DATA 4 0x400ae058 0x000c0000  /* CR22 */
+DATA 4 0x400ae05c 0x03000200  /* CR23 */
+DATA 4 0x400ae060 0x00000006  /* CR24 */
+DATA 4 0x400ae064 0x00010000  /* CR25 */
+DATA 4 0x400ae068 0x0c300040  /* CR26 */
+DATA 4 0x400ae070 0x00000000  /* CR28 */
+DATA 4 0x400ae074 0x00000003  /* CR29 */
+DATA 4 0x400ae078 0x0000000a  /* CR30 */
+DATA 4 0x400ae07c 0x004401fa  /* CR31 */
+DATA 4 0x400ae084 0x00010000  /* CR33 */
+DATA 4 0x400ae088 0x00050500  /* CR34 */
+DATA 4 0x400ae098 0x00000000  /* CR38 */
+DATA 4 0x400ae09c 0x04001002  /* CR39 */
+DATA 4 0x400ae0a4 0x00000001  /* CR41 */
+DATA 4 0x400ae0c0 0x00460420  /* CR48 */
+DATA 4 0x400ae108 0x01000200  /* CR66 */
+DATA 4 0x400ae10c 0x00000040  /* CR67 */
+DATA 4 0x400ae114 0x00000200  /* CR69 */
+DATA 4 0x400ae118 0x00000040  /* CR70 */
+DATA 4 0x400ae120 0x00000000  /* CR72 */
+DATA 4 0x400ae124 0x0a010200  /* CR73 */
+DATA 4 0x400ae128 0x01014040  /* CR74 */
+DATA 4 0x400ae12c 0x01010101  /* CR75 */
+DATA 4 0x400ae130 0x03030100  /* CR76 */
+DATA 4 0x400ae134 0x01000101  /* CR77 */
+DATA 4 0x400ae138 0x0700000c  /* CR78 */
+DATA 4 0x400ae148 0x10000000  /* CR82 */
+DATA 4 0x400ae15c 0x01000000  /* CR87 */
+DATA 4 0x400ae160 0x00040000  /* CR88 */
+DATA 4 0x400ae164 0x00000002  /* CR89 */
+DATA 4 0x400ae16c 0x00020000  /* CR91 */
+DATA 4 0x400ae180 0x00002819  /* CR96 */
+DATA 4 0x400ae13c 0x01000000  /* CR79 */
+DATA 4 0x400ae1a4 0x00001c00  /* CR105 */
+DATA 4 0x400ae1a8 0x00000018  /* CR106 */
+DATA 4 0x400ae1b8 0x0018001c  /* CR110 */
+DATA 4 0x400ae198 0x00010100  /* CR102 */
+DATA 4 0x400ae1d4 0x00000000  /* CR117 */
+DATA 4 0x400ae1d8 0x01010000  /* CR118 */
+DATA 4 0x400ae1e0 0x02020000  /* CR120 */
+DATA 4 0x400ae1e4 0x00000202  /* CR121 */
+DATA 4 0x400ae1e8 0x01010064  /* CR122 */
+DATA 4 0x400ae1ec 0x00010101  /* CR123 */
+DATA 4 0x400ae1f0 0x00000064  /* CR124 */
+DATA 4 0x400ae1f8 0x00000800  /* CR126 */
+DATA 4 0x400ae210 0x00000506  /* CR132 */
+DATA 4 0x400ae224 0x00020000  /* CR137 */
+DATA 4 0x400ae228 0x01000100  /* CR138 */
+DATA 4 0x400ae22c 0x04070303  /* CR139 */
+DATA 4 0x400ae230 0x00000040  /* CR140 */
+DATA 4 0x400ae23c 0x06000080  /* CR143 */
+DATA 4 0x400ae240 0x04070303  /* CR144 */
+DATA 4 0x400ae244 0x00000040  /* CR145 */
+DATA 4 0x400ae248 0x00000040  /* CR146 */
+DATA 4 0x400ae24c 0x000f0000  /* CR147 */
+DATA 4 0x400ae250 0x000f0000  /* CR148 */
+DATA 4 0x400ae25c 0x00000101  /* CR151 */
+DATA 4 0x400ae268 0x682c4000  /* CR154 */
+DATA 4 0x400ae26c 0x00000012  /* CR155 */
+DATA 4 0x400ae278 0x00000006  /* CR158 */
+DATA 4 0x400ae284 0x00010202  /* CR161 */
+DATA 4 0x400ae400 0x00002613  /* PHY0 */
+DATA 4 0x400ae440 0x00002613  /* PHY16 */
+DATA 4 0x400ae480 0x00002613  /* PHY32 */
+DATA 4 0x400ae404 0x00002615  /* PHY1 */
+DATA 4 0x400ae444 0x00002615  /* PHY17 */
+DATA 4 0x400ae408 0x00210000  /* PHY2 */
+DATA 4 0x400ae448 0x00210000  /* PHY18 */
+DATA 4 0x400ae488 0x00210000  /* PHY34 */
+DATA 4 0x400ae40c 0x0001012a  /* PHY3 */
+DATA 4 0x400ae44c 0x0001012a  /* PHY19 */
+DATA 4 0x400ae48c 0x0001012a  /* PHY35 */
+DATA 4 0x400ae410 0x00002000  /* PHY4 */
+DATA 4 0x400ae450 0x00002000  /* PHY20 */
+DATA 4 0x400ae490 0x00002000  /* PHY36 */
+DATA 4 0x400ae4c4 0x00000000  /* PHY49 */
+DATA 4 0x400ae4c8 0x00001100  /* PHY50 */
+DATA 4 0x400ae4d0 0x00010101  /* PHY52 */
+DATA 4 0x400ae000 0x00000601  /* CR0 */
+CHECK_BITS_SET 4 0x400ae140 0x00000100  /* CR80 init complete */
+DATA 4 0x400ae144 0x00000100  /* CR81 */
diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index beb64189d5c..fcff654e4e1 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_VF610=y
-CONFIG_TEXT_BASE=0x3f408000
+CONFIG_TEXT_BASE=0x87800000
 CONFIG_SYS_MALLOC_LEN=0x0220000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x20000
@@ -15,8 +15,6 @@ CONFIG_TARGET_COLIBRI_VF=y
 CONFIG_SYS_MEMTEST_START=0x80010000
 CONFIG_SYS_MEMTEST_END=0x87c00000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=491520
 # CONFIG_EFI_LOADER is not set
 CONFIG_BOOTDELAY=1
 CONFIG_FDT_FIXUP_PARTITIONS=y

base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
-- 
2.56.0

