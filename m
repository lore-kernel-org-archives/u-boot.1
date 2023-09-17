Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B09CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 201EC869F5;
	Sun, 17 Sep 2023 16:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UEcplTkk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ufcPBm6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F320C867EA; Sun, 17 Sep 2023 16:09:19 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E3FD8692F
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVCy0wvHz9sWt
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0mPyTCfUvXAYyzTrEbGr89+DmtLrx7Txzs2iBrEIWI=;
 b=UEcplTkkoJIpGXLAg/W0wxtKkVz3C6zSWA2EuXvQoud9329aQSnmnxOH2smqhNCQiFNYHJ
 W+ufGop5yfqfiz3cb2v8deaEkljzKKo99mdXdr3RqG+Jlf+nITSfz6E/R4Q3PcLu9l39lS
 GKjNDtf1bqhUWjU6L0H+WeC7s1lye4gW4aWgsx/KA515exFmUyrF6eo5dUhW4PNnQPyqaY
 4w5C78nHrQMel25f6jmg27Dc3x5hxZfl61wcZuc8ouKLIz839WabC/kdZLX/dc/OfBTQx0
 QORMPl1c2LwYYYU3p2IivNUwmQR/uW51P5FPIcwSmFGtd/sO3YfvwbTMv1HQyQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0mPyTCfUvXAYyzTrEbGr89+DmtLrx7Txzs2iBrEIWI=;
 b=ufcPBm6cJv8y2+92lqQ751yuhLnLvPEWjlfqeWK5lqKDlvx84QYZ0YoVM33++/ZDSOXCBk
 Wz+qVEMGEZbvjugCjMCITiv10y2sh9NhVaKB3FKFmM4+1yHPVMDm4Sh9WmJ/yVe6RC4nUe
 mMokV/mBbwcJT+tFpvKRswvQk+gBijjL9JVdyt0bLRBZNfMGET5WKiExJA6vmBtNlHevvI
 IbYRg4QT3INEUDKL91sdGo9wMmKfP4aJOaskftDgrAZXmm+koSL95McSSPVZdcsJUe760+
 jMUc6GdsP3AVezBdPnKJp3nnrgujjqfORRD+AOrBSkhZYBU+Qep+OPMz/+2kSA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 17/18] pinctrl: renesas: Synchronize R8A779F0 S4 PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:48 +0200
Message-Id: <20230917140849.379711-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c65857aa7f32896be14
X-MBO-RS-META: 8z1ozctybu9zcs7rffbdgibnuuuoemsz
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

Synchronize R-Car R8A779F0 S4 PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a779f0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779f0.c b/drivers/pinctrl/renesas/pfc-r8a779f0.c
index e2ac9d1efde..5123e26e0ac 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779f0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779f0.c
@@ -1216,7 +1216,7 @@ static const unsigned int tsn1_avtp_pps_pins[] = {
 	RCAR_GP_PIN(3, 13),
 };
 static const unsigned int tsn1_avtp_pps_mux[] = {
-	TSN0_AVTP_PPS_MARK,
+	TSN1_AVTP_PPS_MARK,
 };
 static const unsigned int tsn1_avtp_capture_a_pins[] = {
 	/* TSN1_AVTP_CAPTURE_A */
@@ -1787,7 +1787,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL1_3_2
 		MOD_SEL1_1_0))
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static const struct pinmux_drive_reg pinmux_drive_regs[] = {
@@ -1899,7 +1899,7 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(3, 17),  4, 3 },	/* TSN0_AVTP_MATCH_B */
 		{ RCAR_GP_PIN(3, 16),  0, 3 },	/* TSN0_AVTP_PPS */
 	} },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 enum ioctrl_regs {
@@ -1914,7 +1914,7 @@ static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POC1] = { 0xe60508a0, },
 	[POC3] = { 0xe60518a0, },
 	[TD0SEL1] = { 0xe6050920, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int r8a779f0_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
@@ -2073,7 +2073,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[30] = SH_PFC_PIN_NONE,
 		[31] = SH_PFC_PIN_NONE,
 	} },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static const struct sh_pfc_soc_operations r8a779f0_pfc_ops = {
-- 
2.40.1

