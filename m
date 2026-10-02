Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AE2CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09CB78137E;
	Fri,  2 Oct 2026 21:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vo0kRemXl3cK; Fri,  2 Oct 2026 21:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 46D39813DC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976920;
	b=ERd/MJDUB7rQOudnAsKOCcjABrACiukiOPKTk2myW4GSp95EWvv05nd7+QTHdg/VURjM
	 rhO9fnm9IkJB1TeaBU4HOluCpOn12G7mJlG/C8p68FeBSm2/o5FAVNiEqg7gH286Skfy4
	 iecFyPzZqinAWuKwgY7Lwzee76HJr72IeSqqLBaMzbN81A0jzBp74EJUWWEmYvF/mcOBa
	 /e7KAby5r1/4dtE7ux1zQZA7FoQ9V9UyV33dVWSDJMKtmAlLps1UgYRJoxDfCqtDR/j3a
	 EVf0NeK07P4zPAgBOQzscfY8NF+wMe3+985aUYzWGGsX7A3H/llndfylYdjp3y1+EiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976920;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=67aPbbVZk+LyKX7x/D+sTlToHbDGNF7Mx8c1X4emfKs=;
	b=fLJajXeHnpsoNmO1xYATKhteQtVdCQB2bpcGV1Ai+MflpFt4KQf5jbKA52ztYLcBnXCv
	 Gf4HZpE1lbm44Hu7G9qa1i2XsssFzxRZUEnLdqrKoC3IeIZFybWzRK/RphhIdXNBKb/ir
	 o5SRFDnU55ZdIitHOoiLbITp1sM2RnImUVu5zNGiOzjvfwsH+rV7UH9ezcuxKhCMfEXnE
	 yY5ulai89TrIT9GN0ACUhnX3ENpArwsup+AaXVGfBZrRqHcBXkOZfEJIbr4UgALMLYGG3
	 XuDHDXjPdrSPwn6k+Uav7E4fvgdmk0sHs+UwbuSE91z5cok+KzhvegEbrvt6H6EhA2Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976920;
	bh=67aPbbVZk+LyKX7x/D+sTlToHbDGNF7Mx8c1X4emfKs=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NkbP0UnlLAvKPkkk5IEWzLQBUrqivZBJrveTYwTWFtSq+7Gjk+HlsNWo7gjQmTHsQ
	 MFPKFheJd2vrHUupiJaJw6RBA8B+qkGNDP3+ojlfGd+tiTExWW96lV8NM8LsTQSX+u
	 NH7E8QRnOkI08VOsReIWDbcjlFTLY992TOEQdB7EnuT4wSzt0hjgmLiN5/mNqvu2Mu
	 1yUBai0gmSwdhJiWkH/JyE6sbXKrr6PRXw1I1YKCdNks8rId2JBhQqfCCZqfYm7WjZ
	 QTq6XN55HcmmjfaEo9mIW+xnFilBgFlL9adeyr0UNr+x816S2nNAiSedEYAli9Nk3x
	 u6M2YNpRZLUfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46D39813DC;
	Fri,  2 Oct 2026 21:35:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36B9334D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C74D6065F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5hDXgrJIirI for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:33:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 45FBB60D58
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.70.43.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976835;
 b=fLiYx8QQ3xvfu6n7UgoNnQbEOEjlMh57SnIiVLYDV0fGHx3OxposRSTejJ5VC4zN4EJx
 J3qbxDliF4K3b4fXVoxR+Jh7O9fku895DO1GmhaEaTdxMcgglgdyTZkwPORbBq9/zldRM
 Xeo3qEKkUu7TeEBSYddTGnqLxPQ0QawGZ2caf10yAnpb44jJkLtlW4ifvA/2f7d+97gc2
 J+ZPru9Zux8AcTem1phrVqWe4c/e3ML7E13R0aByVXQgTaQz2iDO1c1OITNhGp4CGW55R
 x7ssX7TQ1hec1qOokAW0RTly7u2F7auZHNzKh9w0kx0bPzeoVz65Wsr9eVpGTyeQ9Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976835;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=67aPbbVZk+LyKX7x/D+sTlToHbDGNF7Mx8c1X4emfKs=;
 b=tdXMufzCs1gdiCUu/ZOBRQ2btjLNc25PWtbvuVcVgTlNyctpmWoKKfF0o5xy/sZugdiR
 co4vX/qD27iI6Xk1b+tsi2mt24TfEbQo639u4tpRuWs4xN/LgGqr7Ev8OSJBSFhcjj+xl
 ApReye/aO8NtAGO4b4oBaMIxdHr4gj4548wx6LOsUfH3eW7OxEEkla/qFbB3Vt60HtMV6
 qhs1OIsubZ2DdOVTvjob3vFbx+PjLo61N/UBuVYZS+yT7EhWMTcQEATyhumyhFDB0AEO7
 8+NY3glEkOsHEAROKdTkk7+OK2vOQOqJiOMAcZXObbqWN6AZZSjP5nm8Egz5seeAJsw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=gpnmJnYx; 
 arc=none smtp.remote-ip=185.70.43.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.21;
 helo=mail-4321.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=gpnmJnYx
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45FBB60D58
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976611; x=1791235811;
 bh=67aPbbVZk+LyKX7x/D+sTlToHbDGNF7Mx8c1X4emfKs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=gpnmJnYxxeLCCJ0ZdvarDV30kZ2dU9IZ1Pinbxkx5u3xybNKxOBb74o3G1sI0S/GA
 YS1Um4xbL8M2BAXSXWJkioX2eH4+phXkbsEjLDK9uNihgKakoMtRazbrhkF8mUjiSv
 ni1djLNf53tBfR0IusX5OHEPE2RG6gNNr2Q2RpqBOkFvNaYLQpk35zsqgPSIUzn6vd
 gWwquOa2xQrJbM/eIOgCldemOMgp9YRKdDHeJpvhd4TH018PzEDEhSFT0ToxnA8yqt
 87E1kXIgbfLE/x851Dz9HNZipFjNxJXU/JG6U4fH52uajmFRhqJ3ZzAQs3eXSCAus2
 bkdMfRlUFlZRA==
Date: Fri, 02 Oct 2026 21:30:06 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 3/7] phy: spacemit: k1: restore port A state after calibration
Message-ID: <2ac21998330f5e0eafcae48e212d2180eadab815.1790975597.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975597.git.DaveWK225@protonmail.com>
References: <cover.1790975597.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: a2935bfcb610d2b08f6f21ec14f1a2914234cba3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:35:19 +0000
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

To calibrate, the combo PHY sets DEVICE_TYPE_RC and the port A clock
gates and reset bits (0x3f) in PCIE_CLK_RES_CTRL and selects PCIe in
PMUA_USB_PHY_CTRL0, and leaves them so. Port A then stays configured
as a PCIe root complex with its application clocks running, and a
board that had selected USB 3 finds the lane switched to PCIe.

Linux enables the port A application clocks and deasserts its
resets only around the wait for R_TUNE_DONE, then asserts and
disables them again. Remember what PCIE_CLK_RES_CTRL and COMBO_PHY_SEL
held before calibrating and restore those bits afterwards, whether
or not calibration succeeded. Restoring the previous value rather
than clearing the bits keeps them set if the port A PCIe controller
had already enabled them. APP_HOLD_PHY_RST stays clear, as in Linux.

Also, as Linux does, skip the wait if R_TUNE_DONE is already set
and use the result found in the register.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/phy/spacemit/phy-k1-pcie.c | 39 ++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/spacemit/phy-k1-pcie.c b/drivers/phy/spacemit/phy-=
k1-pcie.c
index 734d1f9b4f..308f7dec79 100644
--- a/drivers/phy/spacemit/phy-k1-pcie.c
+++ b/drivers/phy/spacemit/phy-k1-pcie.c
@@ -145,23 +145,37 @@ static void k1_combo_phy_sel(struct k1_pcie_phy *k1_p=
hy, bool usb)
=20
 int k1_pcie_combo_phy_calibrate(struct udevice *dev, struct k1_pcie_phy *k=
1_phy)
 {
+=09void __iomem *apmu =3D k1_phy->apmu_base;
 =09void __iomem *regs =3D k1_phy->regs;
+=09u32 ctrl, sel;
 =09int ret =3D 0;
 =09u32 val;
=20
 =09if (k1_phy_rterm_valid())
 =09=09return 0;
=20
+=09/*
+=09 * Remember the port A settings changed below, so they can be
+=09 * put back once calibration is done.
+=09 */
+=09ctrl =3D readl(apmu + PCIE_CLK_RES_CTRL);
+=09sel =3D readl(apmu + PMUA_USB_PHY_CTRL0) & COMBO_PHY_SEL;
+
 =09/*
 =09 * Initialize the APMU control register: set RC mode, enable
 =09 * clock gates (bits 0-5), then release the PHY hold.  The PHY
-=09 * (global) reset was deasserted at probe.
+=09 * (global) reset was deasserted at probe.  The hold is left
+=09 * released, as Linux does.
 =09 */
-=09val =3D readl(k1_phy->apmu_base + PCIE_CLK_RES_CTRL);
-=09val |=3D DEVICE_TYPE_RC | PCIE_APP_HOLD_PHY_RST | APMU_CLK_GATE_MASK;
-=09writel(val, k1_phy->apmu_base + PCIE_CLK_RES_CTRL);
+=09val =3D ctrl | DEVICE_TYPE_RC | PCIE_APP_HOLD_PHY_RST | APMU_CLK_GATE_M=
ASK;
+=09writel(val, apmu + PCIE_CLK_RES_CTRL);
 =09val &=3D ~PCIE_APP_HOLD_PHY_RST;
-=09writel(val, k1_phy->apmu_base + PCIE_CLK_RES_CTRL);
+=09writel(val, apmu + PCIE_CLK_RES_CTRL);
+
+=09/* Calibration may already have been done, e.g. by an earlier stage */
+=09val =3D readl(regs + PCIE_RCAL_RESULT);
+=09if (val & R_TUNE_DONE)
+=09=09goto out;
=20
 =09/* Put the combo PHY into PCIe mode for calibration */
 =09k1_combo_phy_sel(k1_phy, false);
@@ -173,9 +187,24 @@ int k1_pcie_combo_phy_calibrate(struct udevice *dev, s=
truct k1_pcie_phy *k1_phy)
 =09if (ret)
 =09=09dev_err(dev, "PHY calib timeout, RCAL=3D0x%08x\n", val);
=20
+out:
 =09if (!ret)
 =09=09k1_phy_rterm_set(val);
=20
+=09/*
+=09 * Put back the RC mode, the port A clock gates and resets and the
+=09 * PCIe/USB 3 mode select as they were found, so that calibrating
+=09 * leaves port A as it was (Linux disables the clocks and asserts
+=09 * the resets again).  If the PCIe port A controller had already
+=09 * set them up, they stay set up.
+=09 */
+=09val =3D readl(apmu + PCIE_CLK_RES_CTRL);
+=09val &=3D ~(DEVICE_TYPE_RC | APMU_CLK_GATE_MASK);
+=09val |=3D ctrl & (DEVICE_TYPE_RC | APMU_CLK_GATE_MASK);
+=09writel(val, apmu + PCIE_CLK_RES_CTRL);
+
+=09k1_combo_phy_sel(k1_phy, sel);
+
 =09return ret;
 }
=20
--=20
2.55.0


