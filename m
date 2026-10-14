Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75175C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4856080BF7;
	Wed, 14 Oct 2026 20:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zawKRnE_953c; Wed, 14 Oct 2026 20:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 14C2780FB1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008019;
	b=ndbK/Qz78VKuBCOYyl2c4pVDDFSjlPJtyHe4+bMpVVJSAW//ha/oXlHR2sx0amyJF3Gt
	 ukp66ft8OMjpwsP7w092I7oNsc2Xu4faLKO2d+M+knNfjktNWu9mMDwGAJba523EeDslg
	 tXqlFHVhI0UQyc0kZBrtrjBY6kpenUaBEZhJRIG7oDPpHTW3ytW8crU1Qj4cQjDRkhTRv
	 ZKTaCGx9/wLUDyHEs46yPSTNHDQ8FQW+B0R3RwDuNbsUVvz8ZLVmv+mD0q/rSDEH9YWm0
	 K3dzvN3wmdjIMsGxT3djuWPcrkuzDRNBjXc7Z6MoQokWGCl5achUCW5OmOHXANDtHhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9I3f1xig/r+XCnTiUiiz5x29JktkQCjQo8is9TAiC7g=;
	b=qFqPMQCuFOlKcWM3PJApOXt9IJFwLXXFCjdKjo5/0oyLa9rmmCkTJg89bmzCFu7KM59y
	 BFHkKpsDIKw6canDQqXoq5g9wOiK8R47xMom2UW3yH4d58RTJo626+XVUKBBX3l3yalhZ
	 sNl2Ch3zXYZNoiIHn4bM4ILnuevs5SqZTKEKDM662stPvf2FXVJ8VLnQTGgC5OvYJMI3A
	 xoLC7H+LM4mIcSn4NT/L41U1oXkkJW6dkI6lB63KA2PXE9uBEnJ+a5zHdTufQa5iboEmW
	 hdDoa8Mynmh79bJUSvsJnKkmGlLTpNiSKLDJ1WfGTw5Lkvg1vVUZQfFghF3Lg5K/XMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008019;
	bh=9I3f1xig/r+XCnTiUiiz5x29JktkQCjQo8is9TAiC7g=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dncaQ2eTPT210X2ueQAO+Dbpb8UqFXD78gOqMJRV/mh3YjDVQs8xgi5Av3u6/Invz
	 jy9cS1OTbkUZhbJ0uq+NKIE7RRMiMZqEdaB6GvzjYo6NEfkBerhMKsONiogbZsmHSa
	 lgtwuGtscuA6ZmuN2oIqJoJnHSNuFP295+2ixc1mkwZW4yx3iDKgUzw5GxdN/dECyw
	 vwz/gexOdldtr2V1ceZahDBfZN2kYzwcVrnKzJymzSrzPOsASluT+xV377LPrQA3GH
	 tX9cNbdmFKM/rzYdIOr9L30iiTsHRCdT1TWSruXX6ghBhiKcTWTWmT9Wguwk/tUkf2
	 gnBD/UQ/DOQ5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14C2780FB1;
	Wed, 14 Oct 2026 20:00:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 134AB2E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED5954081F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CCs4ANIY1PWd for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 20:00:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9004A4080F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792008015;
 b=qmVtWxE17CFDK1dl3vBlQy/WueP3uUfAoAA5QoFXplO6ag0ronB+tzcLfELsyxk12/Mb
 /+nB1T/HsHzzxN39LjUOCdbhF6CZkVXLbWmlHqbwkVCrK/foGXS+l/osqSSJ2RtmAwR0h
 T3vnGLoUMXKXZr0Y+qpxkYqj6ZPtSmhlzm+QrPYPmr8gdjaMEwveha5wk8/ILPFg4RFzW
 4E/Q6RqZ1OnATEgMkN8SKrYsNcprOoZQFFruHhM4cf4lNxClgDS0Q//Mak5rp/CCIpRKy
 Cilge6wuy+wbr1yr6MSpSryUmUND2CyXA+6MxYzzramIBRQxg17OzJPlOG0uwTKeBSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792008015;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=9I3f1xig/r+XCnTiUiiz5x29JktkQCjQo8is9TAiC7g=;
 b=S+Q25x4+pNOsQcnMI6AvfVzqzY/l3nVaeADlHix8udvwgKajqiMRlPWeIXeQb+a30Akg
 a6otxU1NenVmtMaDh8th0urMRD0c2mMo6FEopfHyxR/UzHm2z0G4QsQawmlZ6Lvdpo516
 QPzuNeQcnEtD4zHopS5FhqxbQIuSeXltg9nViUySYAOP7shDoUNsbmh09RlHxMA4a8Xuu
 9tkUE0z3wWcXeI/JyBPIurs3CQqCCL38yoFsrxeeymkXLLRNz5PjIh7GAxUOKqoL3wlWu
 KrshZu4QbPNuuzimXNrpir/Ug91eAaCuJEdMXYEWXKjW7R45o4BYVyLgC3VYCzU4rSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=protonmail.com;
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b="n/6zY0gi"; 
 arc=none smtp.remote-ip=79.135.106.118
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.118;
 helo=mail-106118.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=n/6zY0gi
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9004A4080F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792008012; x=1792267212;
 bh=9I3f1xig/r+XCnTiUiiz5x29JktkQCjQo8is9TAiC7g=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=n/6zY0giRSQ+FYZVn5Oy0KvpXhI7EEhANSo3LhlbybOA21432dOWmPST7cnUb4A77
 R8NR4KiEaodId2lDImPEmswIGCcDqHrUKE4SrG+PWWqEC5f5ig4Kjjxz/xrD+us2xI
 LakhQVd94SFNqkaKHrjVRj/b3DzBU+3FtDEuP/6TNy/QzQ+qozqg83InOnMcaLaY+W
 jpkEPdDqDL01ogWHISS5t56/k+zlpW6VaxoX1nevyog1Ye6EFklYDthvVLytqmIilO
 RW0EFVmlwWFgDhWt70c3INdgg89tY8Dc3GKmMwp/FQgyPG8QHwZAdSwI/2kxXMHYgu
 vV/X+3Edg/wSQ==
Date: Wed, 14 Oct 2026 20:00:06 +0000
To: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Eric Chung <eric.chung@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: [PATCH v3 1/3] phy: spacemit: add K1 USB 2.0 PHY driver
Message-ID: <3a9b0f29ecd437916716b8d93d93c04133e215bd.1792007916.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1792007916.git.DaveWK225@protonmail.com>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <cover.1792007916.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 837f2749c0d28b7e2f17a48593ff47e3e0308e42
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

The UTMI PHY at c0a30000 ("spacemit,k1-usb2-phy") feeds the K1's DWC3
USB 3 controller. Port the Linux driver: enable the PHY clock, program
the PLL divider for the 24 MHz reference, wait for the PLL, then release
the PHY's resets and enable its clocks, the HS TX clock and the
automatic host-disconnect clear.

As in Linux, the divider is written before waiting for PLL_RDY, because
the PLL does not lock until the divider is programmed.

The K3 has the same PHY ("spacemit,k3-usb2-phy"). Linux handles the two
differently only in its disconnect callback, which U-Boot does not use,
so match the K3 compatible as well.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---

Notes:
    Changes in v3:
    - Drop the read-back of the clock enable bits after releasing the
      resets. SpacemiT confirmed the bits do not reflect the clock state
      (Yixun Lan).
    - Drop the HS DAC current setting (+15 %). It came from the vendor
      driver by way of the FreeBSD port, I have no evidence that it fixes
      anything, and the Linux driver does not set it.
    - Match "spacemit,k3-usb2-phy"; Yixun Lan reports it works on K3.
    - Drop the FreeBSD copyright and history from the header and commit
      message, as none of the FreeBSD-specific code remains.

 MAINTAINERS                        |   1 +
 drivers/phy/spacemit/Kconfig       |  10 ++
 drivers/phy/spacemit/Makefile      |   1 +
 drivers/phy/spacemit/phy-k1-usb2.c | 153 +++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 drivers/phy/spacemit/phy-k1-usb2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c3..1e05da13cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1528,6 +1528,7 @@ M:=09Yixun Lan <dlan@kernel.org>
 S:=09Maintained
 T:=09git https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit.=
git
 F:=09arch/riscv/dts/k1-*-u-boot.dtsi
+F:=09drivers/phy/spacemit/phy-k1-usb2.c
 N:=09spacemit
 K:=09spacemit
=20
diff --git a/drivers/phy/spacemit/Kconfig b/drivers/phy/spacemit/Kconfig
index 3c47601c1f..16e9ece073 100644
--- a/drivers/phy/spacemit/Kconfig
+++ b/drivers/phy/spacemit/Kconfig
@@ -9,3 +9,13 @@ config PHY_SPACEMIT_K1_PCIE
 =09  ports B and C.  The combo PHY must be enabled even if port A
 =09  is not used for PCIe, because it provides calibration values
 =09  required by the other ports.
+
+config PHY_SPACEMIT_K1_USB2
+=09bool "SpacemiT K1 USB 2.0 PHY driver"
+=09depends on PHY && CLK
+=09help
+=09  Enable this to support the USB 2.0 (UTMI) PHY of the SpacemiT K1
+=09  and K3 SoCs, used by their DWC3 USB 3 controllers. The driver
+=09  configures the PLL for the 24 MHz reference clock, releases the
+=09  internal resets and enables the PHY clocks before the controller
+=09  is started.
diff --git a/drivers/phy/spacemit/Makefile b/drivers/phy/spacemit/Makefile
index 3496c099cd..cad47d11bf 100644
--- a/drivers/phy/spacemit/Makefile
+++ b/drivers/phy/spacemit/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_PHY_SPACEMIT_K1_PCIE) +=3D phy-k1-pcie.o
+obj-$(CONFIG_PHY_SPACEMIT_K1_USB2) +=3D phy-k1-usb2.o
diff --git a/drivers/phy/spacemit/phy-k1-usb2.c b/drivers/phy/spacemit/phy-=
k1-usb2.c
new file mode 100644
index 0000000000..cff72506fc
--- /dev/null
+++ b/drivers/phy/spacemit/phy-k1-usb2.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SpacemiT K1/K3 USB 2.0 (UTMI) PHY driver
+ *
+ * Ported from the Linux SpacemiT K1 USB 2.0 PHY driver:
+ * Copyright (C) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (C) 2025 Ze Huang <huang.ze@linux.dev>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <generic-phy.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#define PHY_RST_MODE_CTRL=09=090x04
+#define  PHY_PLL_RDY=09=09=09BIT(0)
+#define  PHY_CLK_CDR_EN=09=09=09BIT(1)
+#define  PHY_CLK_PLL_EN=09=09=09BIT(2)
+#define  PHY_CLK_MAC_EN=09=09=09BIT(3)
+#define  PHY_MAC_RSTN=09=09=09BIT(5)
+#define  PHY_CDR_RSTN=09=09=09BIT(6)
+#define  PHY_PLL_RSTN=09=09=09BIT(7)
+#define  PHY_HS_LINE_TX_MODE=09=09BIT(13)
+#define  PHY_FS_LINE_TX_MODE=09=09BIT(14)
+
+#define  PHY_INIT_MODE_BITS=09=09(PHY_FS_LINE_TX_MODE | PHY_HS_LINE_TX_MOD=
E)
+#define  PHY_CLK_ENABLE_BITS=09=09(PHY_CLK_PLL_EN | PHY_CLK_CDR_EN | \
+=09=09=09=09=09 PHY_CLK_MAC_EN)
+#define  PHY_DEASSERT_RST_BITS=09=09(PHY_PLL_RSTN | PHY_CDR_RSTN | \
+=09=09=09=09=09 PHY_MAC_RSTN)
+
+#define PHY_TX_HOST_CTRL=09=090x10
+#define  PHY_HST_DISC_AUTO_CLR=09=09BIT(2)
+
+#define PHY_HSTXP_HW_CTRL=09=090x34
+#define  PHY_HSTXP_RSTN=09=09=09BIT(2)
+#define  PHY_CLK_HSTXP_EN=09=09BIT(3)
+#define  PHY_HSTXP_MODE=09=09=09BIT(4)
+
+#define PHY_PLL_DIV_CFG=09=09=090x98
+#define  PHY_FDIV_FRACT_8_15=09=09GENMASK(7, 0)
+#define  PHY_FDIV_FRACT_16_19=09=09GENMASK(11, 8)
+#define  PHY_FDIV_FRACT_20_21=09=09BIT(12)
+#define  PHY_FDIV_FRACT_0_1=09=09GENMASK(14, 13)
+#define  PHY_DIV_LOCAL_EN=09=09BIT(15)
+
+#define  PHY_SEL_FREQ_24MHZ=09=090x01
+#define  FDIV_REG_MASK=09=09=09(PHY_FDIV_FRACT_20_21 | PHY_FDIV_FRACT_16_1=
9 | \
+=09=09=09=09=09 PHY_FDIV_FRACT_8_15)
+#define  FDIV_REG_VAL=09=09=090x1ec4
+
+#define K1_USB2PHY_PLL_TIMEOUT_US=0950000
+
+struct spacemit_usb2phy {
+=09void __iomem *base;
+=09struct clk clk;
+};
+
+static int spacemit_usb2phy_init(struct phy *phy)
+{
+=09struct spacemit_usb2phy *sphy =3D dev_get_priv(phy->dev);
+=09void __iomem *base =3D sphy->base;
+=09u32 val;
+=09int ret;
+
+=09ret =3D clk_enable(&sphy->clk);
+=09if (ret) {
+=09=09dev_err(phy->dev, "failed to enable clock: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09/* Let any controller reset settle before touching the PHY */
+=09udelay(200);
+
+=09/*
+=09 * Program the PLL divider for the 24 MHz reference before waiting
+=09 * for the PLL: it does not lock until the divider is written.
+=09 */
+=09val =3D FIELD_PREP(FDIV_REG_MASK, FDIV_REG_VAL) |
+=09      FIELD_PREP(PHY_FDIV_FRACT_0_1, PHY_SEL_FREQ_24MHZ) |
+=09      PHY_DIV_LOCAL_EN;
+=09writel(val, base + PHY_PLL_DIV_CFG);
+
+=09ret =3D readl_poll_timeout(base + PHY_RST_MODE_CTRL, val,
+=09=09=09=09 val & PHY_PLL_RDY, K1_USB2PHY_PLL_TIMEOUT_US);
+=09if (ret) {
+=09=09dev_err(phy->dev, "PLL lock timeout\n");
+=09=09clk_disable(&sphy->clk);
+=09=09return ret;
+=09}
+
+=09/* Release the PHY's internal resets and enable its clocks */
+=09writel(PHY_INIT_MODE_BITS | PHY_CLK_ENABLE_BITS | PHY_DEASSERT_RST_BITS=
,
+=09       base + PHY_RST_MODE_CTRL);
+
+=09writel(PHY_HSTXP_RSTN | PHY_CLK_HSTXP_EN | PHY_HSTXP_MODE,
+=09       base + PHY_HSTXP_HW_CTRL);
+
+=09/* Auto-clear the HS host disconnect state on reconnect */
+=09setbits_le32(base + PHY_TX_HOST_CTRL, PHY_HST_DISC_AUTO_CLR);
+
+=09return 0;
+}
+
+static int spacemit_usb2phy_exit(struct phy *phy)
+{
+=09struct spacemit_usb2phy *sphy =3D dev_get_priv(phy->dev);
+
+=09return clk_disable(&sphy->clk);
+}
+
+static const struct phy_ops spacemit_usb2phy_ops =3D {
+=09.init =3D spacemit_usb2phy_init,
+=09.exit =3D spacemit_usb2phy_exit,
+};
+
+static int spacemit_usb2phy_probe(struct udevice *dev)
+{
+=09struct spacemit_usb2phy *sphy =3D dev_get_priv(dev);
+=09int ret;
+
+=09sphy->base =3D dev_read_addr_ptr(dev);
+=09if (!sphy->base)
+=09=09return -EINVAL;
+
+=09ret =3D clk_get_by_index(dev, 0, &sphy->clk);
+=09if (ret) {
+=09=09dev_err(dev, "failed to get clock: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09return 0;
+}
+
+static const struct udevice_id spacemit_usb2phy_ids[] =3D {
+=09{ .compatible =3D "spacemit,k1-usb2-phy" },
+=09{ .compatible =3D "spacemit,k3-usb2-phy" },
+=09{ }
+};
+
+U_BOOT_DRIVER(spacemit_k1_usb2_phy) =3D {
+=09.name=09=09=3D "spacemit_k1_usb2_phy",
+=09.id=09=09=3D UCLASS_PHY,
+=09.of_match=09=3D spacemit_usb2phy_ids,
+=09.probe=09=09=3D spacemit_usb2phy_probe,
+=09.ops=09=09=3D &spacemit_usb2phy_ops,
+=09.priv_auto=09=3D sizeof(struct spacemit_usb2phy),
+};

