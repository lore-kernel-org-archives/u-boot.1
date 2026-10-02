Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A35CA5FE7
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 274F9813CC;
	Fri,  2 Oct 2026 21:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6mcdhsHTg1G; Fri,  2 Oct 2026 21:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 366738139F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976672;
	b=TXae0/20wOvd5q6Vs0WYHBee1vO8AUrFFlc5zeAcHxUmtAzIYnGETSEx0LNfH7d/FlDO
	 vO2BkNMCz8Zyn20WC/AGTDQH7gSvuDb6io6YI56ZSyGdniye75NSTYTMkeOWmepTDP35o
	 ADPgXv1XwmkF5DhwZdQyg02qoHhlTIt75db0KZqIWVQbrQ+nmKTMjQO4kgqCdCYlP0XlE
	 bVmvCnA5XpeH+u9gc+5e0D1U7v43/jXQxeF9XozBCaSXzER0+voPacN/oWl7o5Y+dCt6d
	 oG1WiRczEm467gjjGVj6MkHXNSeXRkQpn2EfUuytEmkv9zuN37gB6DqQg8yVc00Zmkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dRnJH+Fu34E+8kRVK6G49RflAR/3kzGrdt0UCRgBTUI=;
	b=IhwWGTJcnuiJ3g6vHXwbffe3tvAUUOHadX0P+xDkJUd4eaEvF5ychIjL0pC1ADYnER/7
	 15d7mfjMfmnOUDfHZ8nXUXxW8vIB/W1RfF3Ac1eckV0LQSpmAOQSjxqwFwsecWe6EliDa
	 TfPianbi85/yoRNFp0kNTWOpTC594wRYqhQCSiVU9BQo+arn/cvnQ8HVqtvptBHdpCxFn
	 OLT4wD3Ouoj3TVQzX6P7Ai19mXmpzWilyl1bXAiBNo7DQ/mqlJPpyCjA6Ml7Pu+JG+0g+
	 MCDAdUC1mZsVKaWxy2WNDTrruM6aKBTcVWcnkYdVZn0B/67hKbztWGYkpYm7/WG6qYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=awkvA+n1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976672;
	bh=dRnJH+Fu34E+8kRVK6G49RflAR/3kzGrdt0UCRgBTUI=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mjTzGYRchzWnR8nOSAadBK0iMgTmXG7m8txyFOz/sql6g+iOsANK40pEIalpxLRTs
	 W+NfU8lOkyvtvfWurrOsW7nwey2iuZDLjOxskOb4ZweyJo7BdH0QbGiP2H6PBEwUZk
	 SKoe0qp5gHdyBi7rgrJLAPoPDz52xuH1Bto98uzmf61o+3YK8DdSuNFHW8aRSCczyk
	 85oCo0cr3K8bdcnRk1scS7ePYFiB1nvqUXFePPLteaeixoJsr6b/h5+blmtM84IhkC
	 /Wwn3935Zsxlc+jt7sXuAoU5Vm3HG066kueWfycp7bXfaVPEwvYxqVx87WvRnAIpmp
	 +myk5PyKRzKbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 366738139F;
	Fri,  2 Oct 2026 21:31:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A0F77179
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8726F81365
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoY3YOWuujUt for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B3CCA81323
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=37.187.220.204
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976640;
 b=W49W0ivMhHFqnyW0VU9Goyjt6PKI48YME12MFd2WqUBFoQ5vdrvE/1O/OdhS2Wx1YILd
 ejOS2QdQD8X+u9WU7TwHDyYIBogqtvpHaNrr4WlwF6LMUORj8jfJZTAZ2IZFBSzzDqfsv
 1UcVWtUGPxpf77CpFahe784/L4XmKFdC9aEozcB/dqkDaQ+FJ3qx7qtrfDIPJ7J8oivmv
 qcP5nkQDjrNyQNQQNRa5g+03csck+znVKiDSCq7BcnZweN7i+BJtkyP7D057YU87Pwwl0
 gctf0lAcUExCPN6EE0t6FbW/usmMI+EyawurY1UE9iFdzNzYfgZNL85LYKpTuD3sQoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976640;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=dRnJH+Fu34E+8kRVK6G49RflAR/3kzGrdt0UCRgBTUI=;
 b=EPELKe7tkdYmHX/3SPg8+ioJ7ddXvHce7p4AISWuZHqGfXXRWcvSVl98ThARtRE3au6y
 L4c/4ezIyK02R085Fy/nG2oKxHHJEOv+R0Vjac4hm7w7VEXzZB3rNUeiDbpTG+db5wvRk
 sTLaj2rGDANRbPBqHvS3ZchQ7egFCfH6yDJSZEM0fWkHcQYlKwl/P4TUxZliyzl7JH33m
 WZG4Z9KFcGneUeobBfyKl0lRPuTPJIqXlZyOG6m1TP9DS1Vf/2zn1nIhiWmCUJv9xgl7H
 QCfPmzS38LK7QDRr6JoL/1t8tN4v+ggj9215AVM1D0Z2tFQKnA8DOYVecrIAFO9dkTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=awkvA+n1; 
 arc=none smtp.remote-ip=37.187.220.204
X-Greylist: delayed 62 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 02 Oct 2026 21:30:39 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=awkvA+n1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=37.187.220.204;
 helo=mail-07.mail-europe.com; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com
 [37.187.220.204])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3CCA81323
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976630; x=1791235830;
 bh=dRnJH+Fu34E+8kRVK6G49RflAR/3kzGrdt0UCRgBTUI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=awkvA+n1ktBgXFbw6eZrUOUvwXBDhZH0djIPgGHYEx0+lFoWWFOqAHe3GXCx9UNxr
 YY0LAjBz/Wj8SrpLtpiC9+FrgATBmWQor5hxhwd0tI8P5ld7vOi2FaWHIrrezIpff5
 blca1PZ8MrDEyKc2SyqxzsLoTfhK/c5YziAjSbSPjg0HIWnhWfp4HNXvKo5y8IUpz2
 5qFJtdbxHUlCbXQY0hkYp5eCpLxnzVKkt6kASTfM7FbDhv6H6l98gk7/p3HXcD26vP
 FblvTbXITPaLpJHW0KmRKEXCXz274uboG9PrLyD9z1xmTOn+tvzUvW2/wxj7BWGDhg
 L3bXRbZbsOBJA==
Date: Fri, 02 Oct 2026 21:30:27 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 7/7] phy: spacemit: k1: power on the combo PHY in USB 3 mode
Message-ID: <e80f6161ee95cee2c84e6bb1d98ddee1070e7a13.1790975597.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975597.git.DaveWK225@protonmail.com>
References: <cover.1790975597.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 1fbd958f78259c3c71624ca6ca5a63b895e0cfc6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:30:59 +0000
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

In USB 3 mode the combo PHY's init only sets COMBO_PHY_SEL. Nothing
programs or starts the PHY PLL, so the DWC3 controller gets no PIPE
clock and its xHCI reset (USBCMD.HCRST) never completes.

Linux's k1_pcie_phy_init_usb() selects USB 3 mode and zeroes
USB3_TEST_CTRL, its combo PHY probe leaves APP_HOLD_PHY_RST clear,
and its PLL prepare for USB sets CFG_INTERNAL_TIMER_ADJ to the USB
value, selects 5000 ppm spread spectrum and the 24 MHz reference
without the 100 MHz SSC input, sets CFG_SW_PHY_INIT_DONE and waits
for PLL_READY. Do the same, and also clear CFG_FORCE_RCV_RETRY, which
is for PCIe only and may have been left set by an earlier stage.
Return -ETIMEDOUT if the PLL does not lock.

Do it at power-on rather than at init: the DWC3 glue initializes
its USB 3 PHY before it enables the controller's clock and releases
its resets, and powers it on afterwards, while Linux starts this PLL
with the controller already running. PCIe mode is unchanged.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/phy/spacemit/phy-k1-pcie.c | 84 ++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/spacemit/phy-k1-pcie.c b/drivers/phy/spacemit/phy-=
k1-pcie.c
index c3d29d6a2a..6ba8575ef6 100644
--- a/drivers/phy/spacemit/phy-k1-pcie.c
+++ b/drivers/phy/spacemit/phy-k1-pcie.c
@@ -39,6 +39,7 @@
 #define PCIE_PU_ADDR_CLK_CFG=09=090x0008
 #define PLL_READY=09=09=09BIT(0)
 #define CFG_INTERNAL_TIMER_ADJ=09=09GENMASK(10, 7)
+#define TIMER_ADJ_USB=09=09=090x2
 #define TIMER_ADJ_PCIE=09=09=090x6
 #define CFG_SW_PHY_INIT_DONE=09=09BIT(11)
=20
@@ -58,6 +59,7 @@
 #define FREF_24M=09=09=090x1
 #define SSC_DEP_SEL=09=09=09GENMASK(19, 16)
 #define SSC_DEP_NONE=09=09=090x0
+#define SSC_DEP_5000PPM=09=09=090xa
=20
 /* PCIe PHY configuration */
 #define PCIE_PU_PLL_2=09=09=090x004c
@@ -80,6 +82,9 @@
 #define TX_RTERM_REG=09=09=09GENMASK(15, 12)
 #define TX_RTERM_SEL=09=09=09BIT(25)
=20
+/* Zeroed for the combo PHY operating in USB 3 mode */
+#define USB3_TEST_CTRL=09=09=090x0068
+
 /* PHY calibration values */
 #define PCIE_RCAL_RESULT=09=090x0084
 #define RTERM_VALUE_RX=09=09=09GENMASK(3, 0)
@@ -216,11 +221,9 @@ static int k1_pcie_phy_init(struct phy *phy)
 =09u32 val;
 =09int i, lane;
=20
-=09/* If combo PHY is configured for USB 3 mode */
-=09if (k1_phy->is_combo && phy->id =3D=3D PHY_TYPE_USB3) {
-=09=09k1_combo_phy_sel(k1_phy, true);
+=09/* USB 3 mode is set up at power-on, see k1_pcie_phy_power_on() */
+=09if (k1_phy->is_combo && phy->id =3D=3D PHY_TYPE_USB3)
 =09=09return 0;
-=09}
=20
 =09/* For combo PHY, ensure it's in PCIe mode */
 =09if (k1_phy->is_combo)
@@ -364,6 +367,78 @@ static int k1_pcie_phy_init(struct phy *phy)
 =09return 0;
 }
=20
+/* Only called for the combo PHY */
+static int k1_combo_phy_usb3_power_on(struct phy *phy)
+{
+=09struct k1_pcie_phy *k1_phy =3D dev_get_priv(phy->dev);
+=09void __iomem *apmu =3D k1_phy->apmu_base;
+=09void __iomem *regs =3D k1_phy->regs;
+=09int ret;
+=09u32 val;
+
+=09/*
+=09 * Point the lane at the USB 3 controller.  Left in PCIe mode, the
+=09 * PHY PLL does not lock, the controller gets no PIPE clock and the
+=09 * xHCI reset never completes.
+=09 */
+=09k1_combo_phy_sel(k1_phy, true);
+
+=09/* Make sure the PHY is not held in reset by the PCIe port A logic */
+=09val =3D readl(apmu + PCIE_CLK_RES_CTRL);
+=09val &=3D ~PCIE_APP_HOLD_PHY_RST;
+=09writel(val, apmu + PCIE_CLK_RES_CTRL);
+
+=09/* We're not doing any testing */
+=09writel(0, regs + USB3_TEST_CTRL);
+
+=09/* Configure the PLL for USB 3 */
+=09val =3D readl(regs + PCIE_PU_ADDR_CLK_CFG);
+=09val &=3D ~CFG_INTERNAL_TIMER_ADJ;
+=09val |=3D FIELD_PREP(CFG_INTERNAL_TIMER_ADJ, TIMER_ADJ_USB);
+=09writel(val, regs + PCIE_PU_ADDR_CLK_CFG);
+
+=09/* 5000 ppm spread spectrum, 24 MHz reference, no 100 MHz input */
+=09val =3D readl(regs + PCIE_PU_PLL_1);
+=09val &=3D ~(SSC_DEP_SEL | REF_100_WSSC | FREF_SEL);
+=09val |=3D FIELD_PREP(SSC_DEP_SEL, SSC_DEP_5000PPM);
+=09val |=3D FIELD_PREP(FREF_SEL, FREF_24M);
+=09writel(val, regs + PCIE_PU_PLL_1);
+
+=09/* Forcing receiver retry is for PCIe only */
+=09val =3D readl(regs + PCIE_RC_DONE_STATUS);
+=09val &=3D ~CFG_FORCE_RCV_RETRY;
+=09writel(val, regs + PCIE_RC_DONE_STATUS);
+
+=09/* PLL configuration is done; start the PLL */
+=09val =3D readl(regs + PCIE_PU_ADDR_CLK_CFG);
+=09val |=3D CFG_SW_PHY_INIT_DONE;
+=09writel(val, regs + PCIE_PU_ADDR_CLK_CFG);
+
+=09ret =3D readl_poll_timeout(regs + PCIE_PU_ADDR_CLK_CFG, val,
+=09=09=09=09 val & PLL_READY, PLL_TIMEOUT_US);
+=09if (ret)
+=09=09dev_err(phy->dev, "USB 3 PLL lock timeout, reg[0x08]=3D0x%08x\n",
+=09=09=09val);
+
+=09return ret;
+}
+
+/*
+ * The DWC3 glue initializes its USB 3 PHY before it enables the
+ * controller's clock and releases its resets, and powers the PHY on
+ * afterwards.  Linux starts the PHY PLL with the controller already
+ * running, so for USB 3 the PHY is set up here rather than at init.
+ */
+static int k1_pcie_phy_power_on(struct phy *phy)
+{
+=09struct k1_pcie_phy *k1_phy =3D dev_get_priv(phy->dev);
+
+=09if (k1_phy->is_combo && phy->id =3D=3D PHY_TYPE_USB3)
+=09=09return k1_combo_phy_usb3_power_on(phy);
+
+=09return 0;
+}
+
 static int k1_pcie_phy_exit(struct phy *phy)
 {
 =09return 0;
@@ -393,6 +468,7 @@ static int k1_pcie_phy_of_xlate(struct phy *phy,
 static const struct phy_ops k1_pcie_phy_ops =3D {
 =09.of_xlate=09=3D k1_pcie_phy_of_xlate,
 =09.init=09=09=3D k1_pcie_phy_init,
+=09.power_on=09=3D k1_pcie_phy_power_on,
 =09.exit=09=09=3D k1_pcie_phy_exit,
 };
=20
--=20
2.55.0


