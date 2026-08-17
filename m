Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B60C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26929407F6;
	Mon, 17 Aug 2026 15:33:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y9o1Jh-mXgQq; Mon, 17 Aug 2026 15:32:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AD2F40715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980779;
	bh=KuPCir/XCCzxhJWyAOY7lcOnxW0M4btlkZhjuAXOZ5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EjYFggDkCOdhWYwzBLcdHJJDvW6HaQKwj0xVFeElzr0bhdPmcOrtUouJOKUG+6rRH
	 HFrdFm4j22RUed1Mda/LSqh9LvjWQx3q+mrCgZ/CNyfBBnEy/zl3h01fWZmb34yr5e
	 S2/RZRW5R1Sk7zv9TIs+po4L4rj2w5L2YqcI+n1BACIjl1iFe1PVBP9yeZT3p0q/1A
	 siuYKz2CMB+PAFmlPHfpV+wIZqxD1+gU+ueVKEakCZksj5ivi6t9v41A1RPWPqGoOq
	 mQqszQGJeZGaF6qLzVRhpwSMIqwdgwl+tPLqInjvftGE6OgR7TX2sD5EDUaK3MYG3Z
	 ifZA549Ej3bsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AD2F40715;
	Mon, 17 Aug 2026 15:32:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23E77337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1278080EAB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yyr227zFtNm7 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:32:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0803A80EAA
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0803A80EAA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=pHsV4kw7
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0803A80EAA
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D5036B00571;
 Mon, 17 Aug 2026 17:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980774;
 bh=0S2rdLX2k0dGihbSZzHrMzuWQXkVwLKZtCwzwAM4HTg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pHsV4kw7l2BnUE/AoTFxBG3fWGXCEeUVv1gXRk5k6ZSgtc6m5DhMW72HkPlebnpLH
 PYnaKMpJ/x4nrrCWHF4LkK+YmTSEu+E770jPTvN6Z4Uj0qVo57HUi9iMrzHhp4zRL1
 MTinvhs+3nhwak1WPl4n1ddi+uvJMEWfGVdp69X0qEzFaJHkVWlh1lLZbmBfUC0Etd
 2JJrpG85V0W5Q+6kuZb9L4bPh8c+Ytvh8z0PDvk4rCVujOPGinF30zBQdPtWkdMOru
 ImJIgWxEAZo81mIAo0GA8wKcuKvhE1jK4YUh5tbV5snNew+O03XmObZnaGFYn+73yC
 Ksp6FfPHANOxw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 03/23] board: nbxv3: enable RTL8211FD PHY for 1G DPAA2
Date: Mon, 17 Aug 2026 17:31:21 +0200
Message-ID: <20260817153144.1951036-4-vjardin@free.fr>
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

The on module 1G management port uses a Realtek RTL8211FD-CG.

With the DTS, enable the management complex/DPAA2 stack and describe
the on module management port: DPMAC17 wired through RGMII1 to the
RTL8211FD-CG.

The MC firmware itself is started by ${mcinitcmd}, which comes with
the boot environment: until then mc_env_boot() is a no-op.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 26 ++++++++++++++++++++++++++
 configs/nbxv3_tfa_defconfig        |  5 ++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index 32f0c207a59..8caea051bed 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -14,3 +14,29 @@
 	model = "Free Mobile Nodebox v3 CPU Module (LX2160A)";
 	compatible = "freemobile,nbxv3", "fsl,lx2160a";
 };
+
+/*
+ * E-MDIO buses.
+ * SMI1 (&emdio1) carries the on module RTL8211FD-CG,
+ * SMI2 (&emdio2) is wired to the carrier.
+ */
+&emdio1 {
+	status = "okay";
+
+	rtl8211fd: ethernet-phy@6 {
+		compatible = "ethernet-phy-id001c.c916",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <6>;
+	};
+};
+
+&emdio2 {
+	status = "okay";
+};
+
+&dpmac17 { /* DPMAC17 to RGMII1 to RTL8211FD-CG. */
+	status = "okay";
+	phy-handle = <&rtl8211fd>;
+	phy-connection-type = "rgmii-id";
+	u-boot,nickname = "lanconsole0";
+};
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 86b5b44ec09..cb6043f3278 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -22,6 +22,7 @@ CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_PBSIZE=532
 # CONFIG_ID_EEPROM is not set
+CONFIG_RESET_PHY_R=y
 CONFIG_CMDLINE_PS_SUPPORT=y
 CONFIG_CMD_HISTORY=y
 CONFIG_CMD_LOG=y
@@ -31,7 +32,9 @@ CONFIG_DDR_ECC=y
 CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
 CONFIG_SYS_FSL_DDR_INTLV_256B=y
 CONFIG_DM_I2C=y
-# CONFIG_FSL_MC_ENET is not set
+CONFIG_PHYLIB=y
+CONFIG_PHY_REALTEK=y
+CONFIG_SYS_MEMAC_LITTLE_ENDIAN=y
 CONFIG_DM_SERIAL=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_WDT=y
-- 
2.43.0

