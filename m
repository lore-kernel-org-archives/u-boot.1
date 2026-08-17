Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089C8C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6F78407CD;
	Mon, 17 Aug 2026 15:35:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQ-idrw8Aj52; Mon, 17 Aug 2026 15:35:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BD8B40866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980954;
	bh=lIQAxkn3mGiPPnrDjCQ6sicmQZg5DRYwx3zmM768oaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fQrTaEkEdNYOJwwDRsZA4dJOzIgS8bBfMfSrtUmaBiXsJdWExzikmej2lq0wnbVC4
	 08wvxs1PmK6/IbYIPyl0Fv/1Da4WACFnNp1U0aTLCCRrmZ4avAaniC/5kwsesO3BIb
	 KBD7MsbonEBzGnMovjTBy5x2rPw6Vw6/MY8BPW5GkksL18c+upzCM/hoRNUQkymEQU
	 ITcrBod+flCb2aU/ekqMQ65Ub2tEzuX6tKKmtkOVMSnjCo8z2HFV15rL+Ur5vvNCYG
	 2UoJBFPvk4PNic92tgbDhvyD9OVKYDonseijptWa+1ErJgg9xUKfbF2FnNzq70CNfY
	 aCMyzQs38CdYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BD8B40866;
	Mon, 17 Aug 2026 15:35:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58067337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E2B0607C5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wfCRPBAF9Wtm for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:35:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2AB37607A8
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AB37607A8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=m7fLWRD5
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AB37607A8
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 9411BB00539;
 Mon, 17 Aug 2026 17:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980950;
 bh=MZJIdm25ZHfosPDzkT2y/10er+cHdPUWmUz8MR0kVGM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m7fLWRD5B67/S4j5wf9ziv5RUFLWSCaSLSm3N5X0fLANrvJe3TuZVVLKtL0i2E/nH
 767DNQmWdJyikNg20aQ1s4MBwb+n8qT1T0P26YNa/3ekOMDBMrtHN+8fR3WdhRSKWy
 D0k2m0SFZsp5yU45BhvNvoDZosDN424ISp0DRMexjoIZTM1QUPpDoA0BH6Y6i28OzJ
 TLBcCkRdxPfanrapMVHkEtvmVdQBD01Q8GCXsjhMd8Zyh9smcwfBqHpl6Lh6Efjrnb
 H2khQqKs8x4HmGaQ9H5/jNzmOnLxb49v3xF2pcLUbr643YJEx1FJebvHXxc1AE016Y
 rxXuxL93rTzvQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 13/23] board: nbxv3: enable eMMC on eSDHC2
Date: Mon, 17 Aug 2026 17:31:31 +0200
Message-ID: <20260817153144.1951036-14-vjardin@free.fr>
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

Attach the eMMC to the second eSDHC controller of
the LX2160A.

defconfig:

 - CONFIG_FSL_ESDHC=y for the controller driver.
 - CONFIG_CMD_MMC=y to expose the mmc command at the prompt.
 - CONFIG_MMC_HS400_SUPPORT=y for the high speed.
 - CONFIG_SUPPORT_EMMC_RPMB=y to access the chip's replay
   protected memory block partition for secure storage.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 8 ++++++++
 configs/nbxv3_tfa_defconfig        | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index fad6e3c292a..a7e9628d948 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -108,3 +108,11 @@
 &dspi2 {
 	status = "okay";
 };
+
+&esdhc1 {
+	status = "okay";
+	bus-width = <8>;
+	non-removable;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+};
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 6684fecf3a4..626f4181812 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -31,6 +31,7 @@ CONFIG_SYS_PBSIZE=532
 CONFIG_RESET_PHY_R=y
 CONFIG_CMDLINE_PS_SUPPORT=y
 CONFIG_CMD_HISTORY=y
+CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_CONTROL=y
@@ -41,6 +42,9 @@ CONFIG_DDR_ECC=y
 CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
 CONFIG_SYS_FSL_DDR_INTLV_256B=y
 CONFIG_DM_I2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_ESDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
-- 
2.43.0

