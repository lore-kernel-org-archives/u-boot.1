Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68335CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B536260DDC;
	Fri,  2 Oct 2026 21:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TA9yqHTMkDjN; Fri,  2 Oct 2026 21:38:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 11F6E60DAA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790977129;
	b=UeK78RMxvMEBOJwiYj7RJJusZRKfpqU5pxo7Z0ECcaQ7cYdvsE7PbiGEFcV7brYObrYz
	 U0Wcm6RuFwse9MycQ29aATx6+9wRnNDF5Na6oROqLkC9X2H1FPgksx7vdiJncuVHkqb5/
	 xmBH5KqN7BV7YSJ34k9c6Hcshys0nkDwXIbaKbyCUObX22hfyW0mYcIjTyESaCUKEYz88
	 S3db9GyldvpZQF7ZmA56R3DfTY5R8j2xxX4Sox5uv2WKBNH51MDNO08j0TIFQQWgCuTQ+
	 ANQ2/P2OEwnnHVy0R50SZCp3jUxJWjKtXPacXupSZer27RPf2+aDrT+tY8ssdW1kctg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790977129;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EYYxARd6lKPZp5jVOamNBU4o9do+1j8JtT8KCSGYMrg=;
	b=PhgeFf01ut22oojYTpCg+r5N/bBPAA7l7UMIRBeBuauEt6vuZe1/81FEbLm82wjNU6PC
	 xVADAw1d2wgAHiLH3AcbB1qYmyluODBrSjRcsrRkciBQ05iKTGr4zG7Fj00Va0rHFTfyf
	 teSN42/JhA0mO8ax6FusiA0ARaLLMIl23XykhtuPT91IO8jhoalFfyKXrTNbyonlwhVmg
	 EQuDLxlDyFYSvbrx/ISVUekrR6loCcANA7hsL5zbF7i+ITbaFg6iy5iNbD7WJKQJ/yu2H
	 eFOJxyG2Nz2noKjgh3EIQMEJ2iW8I3QNkZxiWRNB/zp5ejZ9oZwAyXoVGw9hnvFvabA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790977129;
	bh=EYYxARd6lKPZp5jVOamNBU4o9do+1j8JtT8KCSGYMrg=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DPqtWCuNQ2g75XX84/wJ2uXFjq+1GvD/4Wy+eoz90Vjdl67AyRba3xERsXNqR6KsL
	 WYhhSiy3Rha6kKutPhs4YvSoGyttsE3jfb3c4Av0FSQU8iCJH9rQ+tYyRYH6m9Cco/
	 y30Ff+1ay1nLkX37fozO6WtL5FG26I63O3y+EEg+W58fQ2dzYrvkY0vtnxRihTA8Fd
	 /2lRTtCbiFza68htxXPxvunBDtAmfaJ4Zk4AgL+WQDxwac0suJ507AE564hhARxtJu
	 XGjFGwUJluQ+ibPwhmReFcIwXQrBnc5iWEZEE0y2HvGT3vE4TLNoHhdy5aFS5WhMk4
	 QPHWQFCsX+dzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11F6E60DAA;
	Fri,  2 Oct 2026 21:38:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A3CC1D2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6034B40590
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:37:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ukCcI_CVteL for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:37:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7962E40585
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.104
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790977077;
 b=XY5ui8wDI+jdlhkkd+1EtCKxHy5JLNFziu9Qy6NaK+aeK99ZnvelrYB46yyQLv6x1+uK
 8bHKiMCgDm9+2aIcSIZcV/+uUpt9B6bcPPdEWHwEyNH6rzViy7ZBFUze86pw6lrcgz6mm
 i40xuNrmyWySqexf7PB99pFNeE+WPnwTa0l44AlAN2bqqD0npFFqOUFZdNvetn70tYrXt
 gBLdtD0jvrBmJ1gEYQvjtfid3aihbOo78hZEoJHXYtY1/pYfqWFUvTOQ4J3r43luCS7DS
 NkKcP/0jIWbsTeBrT9FNEsPwM4Y4CblU55PWB79Hxk6xsg3q08JCWnaYluWGiYzf5VQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790977077;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=EYYxARd6lKPZp5jVOamNBU4o9do+1j8JtT8KCSGYMrg=;
 b=mroxnfnE4DyujoSzb8RNPbq79xm3HvxTwKs26Ozug69hwr0vxfJM/duyqn2SC9Zs0gJX
 Vnk+3XgHIaNx8JigsRiCsd8b98UdX2a3yUQxXOZwhxFfGOqxI6MulZ8thgjqbk5nmESEE
 2KUY5LviNSex5cwgQsxkhzPVC5MMBPw8Z94DrZi9kgnVLpt1STaHw3ELTmNhslI6XOp+8
 RCMjzU25Ej7/lF9q94/ypIrnvYUaOzyXvwhsKWVusotzeUzKKSmvpM79mYAgDkcj/xEnT
 mnb6AxBOyO+fJBdwwYf3u4m2MnPdR/EjMYtFRHarL+IcoFrrBgjsGyx159w2r4IfVkg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=ighfzj3d; 
 arc=none smtp.remote-ip=109.224.244.104
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.104;
 helo=mail-244104.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=ighfzj3d
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch
 [109.224.244.104])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7962E40585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976602; x=1791235802;
 bh=EYYxARd6lKPZp5jVOamNBU4o9do+1j8JtT8KCSGYMrg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ighfzj3dvvXWCgR1Y+kJp8sd7e/MpsWqbAZZyu9IVxBAmYxn+/f5BDTPOwpn41sZf
 8m4CeHQl/jmu72C094Sp/DepQyj8b5QKnh8gz7muTKPhpos6bvmGFNeuDi4V86YMBt
 ZM28OU89fxGPs4JwQfH4mBY5qaiAM12MRdDkq6mtsLNoQu8w0GJ09ISS1wkTPI1XnW
 zjBl0neR7ddRMLkYcV0j19G3Pa+Yy2aAk40w4qMWapppmjZK1wacPrTdZtwH+/Koue
 RsvWWp8JOjsYQQog4BYdPd9GEjVz3PBZAE7NA6VYa1DXL8Hi/wVmZ9gWC8FS7VTtRl
 77RJnJfD8R+aA==
Date: Fri, 02 Oct 2026 21:29:59 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 2/7] phy: spacemit: k1: don't start the combo PHY PLL to
 calibrate
Message-ID: <deb50f9c50b034bfa5a02489990be8721732105b.1790975597.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975597.git.DaveWK225@protonmail.com>
References: <cover.1790975597.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 3d953d36a8b0750b900f9aa358611b6f1e36a41e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:38:45 +0000
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

To measure the termination values, the combo PHY calibration also
programs the PHY as for PCIe: refclk driver mode, the 24 MHz
reference, the 100 MHz output and no spread spectrum, then writes
0xb78 over the whole of PCIE_PU_ADDR_CLK_CFG and CFG_FORCE_RCV_RETRY
over the whole of PCIE_RC_DONE_STATUS. 0xb78 includes
CFG_SW_PHY_INIT_DONE, so the port A PHY PLL is started in PCIe mode
and left running, whatever the combo PHY is used for afterwards. On a
board that uses it for USB 3, the PLL is then already running with
the PCIe timer and spread-spectrum settings when the USB 3 settings
are written.

Linux does none of this. k1_pcie_combo_phy_calibrate() deasserts the
PHY reset, clears APP_HOLD_PHY_RST, selects PCIe mode, enables the
port A application clocks and resets and waits for R_TUNE_DONE; the
PLL is programmed and started only when the PHY is initialised for
the mode it is used in. Do the same and drop the PHY register writes
from the calibration.

Doing so also removes the two whole-register writes, which cleared
every other field of those registers.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/phy/spacemit/phy-k1-pcie.c | 34 ------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/phy/spacemit/phy-k1-pcie.c b/drivers/phy/spacemit/phy-=
k1-pcie.c
index b445ee9d01..734d1f9b4f 100644
--- a/drivers/phy/spacemit/phy-k1-pcie.c
+++ b/drivers/phy/spacemit/phy-k1-pcie.c
@@ -166,40 +166,6 @@ int k1_pcie_combo_phy_calibrate(struct udevice *dev, s=
truct k1_pcie_phy *k1_phy)
 =09/* Put the combo PHY into PCIe mode for calibration */
 =09k1_combo_phy_sel(k1_phy, false);
=20
-=09/* Set refclk override + clear CFG_REFCLK_MODE */
-=09val =3D readl(regs + PCIE_LTSSM_DIS_ENTRY);
-=09val |=3D OVRD_REFCLK_MODE;
-=09writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
-
-=09val =3D readl(regs + PCIE_LTSSM_DIS_ENTRY);
-=09val &=3D ~CFG_REFCLK_MODE;
-=09writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
-
-=09val =3D readl(regs + PCIE_LTSSM_DIS_ENTRY);
-=09val |=3D FIELD_PREP(CFG_REFCLK_MODE, RFCLK_MODE_DRIVER);
-=09writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
-
-=09/* Configure PLL: select 24MHz reference, enable 100MHz output */
-=09val =3D readl(regs + PCIE_PU_PLL_1);
-=09val &=3D ~(FREF_SEL | REF_100_WSSC);
-=09writel(val, regs + PCIE_PU_PLL_1);
-
-=09val =3D readl(regs + PCIE_PU_PLL_1);
-=09val |=3D FIELD_PREP(FREF_SEL, FREF_24M);
-=09writel(val, regs + PCIE_PU_PLL_1);
-
-=09val =3D readl(regs + PCIE_PU_PLL_2);
-=09val |=3D GEN_REF100;
-=09writel(val, regs + PCIE_PU_PLL_2);
-
-=09val =3D readl(regs + PCIE_PU_PLL_1);
-=09val &=3D ~SSC_DEP_SEL;
-=09writel(val, regs + PCIE_PU_PLL_1);
-
-=09/* Start PHY init + force receiver */
-=09writel(0x00000B78, regs + PCIE_PU_ADDR_CLK_CFG);
-=09writel(CFG_FORCE_RCV_RETRY, regs + PCIE_RC_DONE_STATUS);
-
 =09/* Wait for calibration to complete */
 =09ret =3D readl_poll_sleep_timeout(regs + PCIE_RCAL_RESULT,
 =09=09=09=09       val, val & R_TUNE_DONE,
--=20
2.55.0


