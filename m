Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D8CCA5FF0
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 12:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B56C80CD4;
	Tue,  6 Oct 2026 12:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id icjOMR53Kzto; Tue,  6 Oct 2026 12:33:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4567780C6C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791290029;
	b=mdnMUUD+ABNcQZI85gXn7LSS2ehJQttriqQhawEgMkAMZ5CImyoVXmPdCP1xmkmjLHOI
	 x2GCpsOFtBcd9QHuFk8o802zF5mYJWbwGuAe4z5sWx996JwMvcpPdCGrCqCof+mN1uhVe
	 o3W2mkniSEeuvivrhfmvNkffv/xXoKJyWqQOcnvDyNTMb+7PY2ZNE7ORr3MbBGBwkdRZr
	 Wc3qI/hQJlOhkGE+9I/9PGizvOTZ4glje/3B2pBLWjPqNWwIsx4JLf5OU+phHF76DqTQy
	 8RE7IKhcsbCMIU1SUvND/oeqtoa/LuVDqPoRzIM3G9rdBfbGytnMUXO2WL8lp7Y11Yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791290029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oC5To7tPDKyYXwZ7STXU7IJ4YEuiAvfstFLQ43LygoE=;
	b=YqwzKNJ1Y680EF0bQqG1+5pzmY/7Lx+vmYBSAKULGDduSxA1qsHMX1siI5qqoRgSUYfW
	 XaKJYh4D8fDyOZcnaJhhOHmAY5RLddkTxS40rQGfC1Fq1bJ8gU2R0riW/Rh6IWTO3im9s
	 V6YuYOx+hHHre+AxGF2fcXZRxZl8Vy16E6t8cfjMqs6kebslYMI3JXkoJwIsobpUdsiIZ
	 C6YLhFH+19n+Ij56Zg+1oKE4WCUdaoMJSXRHTja6P3BJJFHzDAwrmrUCbrrmLpEE+V3GT
	 J9BrtuQzx70mLgOwyIlXrDotOGZmRF4mqLjiA4MQhu7xg2v5BCJsR00oBOCk7eJEI5g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=nml6Zzrc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791290029;
	bh=oC5To7tPDKyYXwZ7STXU7IJ4YEuiAvfstFLQ43LygoE=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fuPcgn7MPQQ4nj4+j/irI5PJOxKLALfYGpkOVHSjohkL7Iqftix8zdAdS8AtLg/mY
	 B+moWNe45hDFQkCEYRWQlbGHaDiR9RPGGLGJyw6pDQkEdd1Jbt3CWgM4YOmYzlQkdS
	 L2Ne+e0ZCKz4QgBAktT598anGdsP70ZrWF8rQvItjnfvPrDJg4+qtKRivMf8ZtHFyx
	 oB/gYwg1m2YJAjtnDIRFfUC4U/3RQ4MeatuWeahWwGbWWf8mRqB2rrjkW9+9dG9eBW
	 kQ8GhB2fScTq0QsG/XZT9tbR1tZ2cGaEyuOKnJ8+PKmB5vBd8+SR4mA2C+VLfY24BA
	 +LUV/2aRkNEKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4567780C6C;
	Tue,  6 Oct 2026 12:33:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F0FCD22B
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 12:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1FD1805E4
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 12:32:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OLra0dpejKld for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 12:32:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1C58180BB7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791289933;
 b=bkGASS6OhbSsUJ7i71Mq2jYtaUASFG7cH3cdB2Mvh2rX+DK9oLLploNZf3nD5CUyXudY
 gvU0hkGjuVARk1z48PvTUE0RyX8R0llwesAnKRkEWuXFS1OeEtZh1bztQLTeVwiXfrbbi
 VN9CkBkUEbh+Wa0EvBIeM64TSWtgCDd5Kv6U2S3pAKgi7gFrU5mx7ZSkAq32U2fk2rbei
 H4Zys7KSK57OFH6l5KbdbG7Yrw33N65exQ79v6d+NJSj/O0BqEIzkLuE0LklLp5Ea3+UJ
 QMb1uYsA7JI5O4wgT8YBMyat9UoOzwCmNgK+z/+K0Llttdvja1MPf0/aDi9NNWuWiiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791289933;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=oC5To7tPDKyYXwZ7STXU7IJ4YEuiAvfstFLQ43LygoE=;
 b=W6sqOZb4Ln0MS2MczwfUz4IhW3TftU4IANQfwHwwOpODF5+jC5ihj/dxecOsU16ci3XA
 mKOLcwgIfQTg3nYhFR+OzGZds2r7pCPOmXGl9GWOc4dbxXReIGVHpI0Lx+sdvmtWlC75y
 hbDnO4vvtcAIlRr90Y34U2rE9BPLOgkSu56Mpc6fQ0Qy2eaU9pKFRKGMlVCaCGTj1Lqk2
 trGyu4dzvxYwGXqf/4j4MvENMwuvNYV/RCQkx4F8qGKzrrwdE30eN1CP1dcg8KLEqczPS
 yC6LJ4ld0NOciBCoNBAWfqs7qLJ85BSA4U7+iRz1MbDugQxqSh0JLBKzDEDsdNUrUmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=nml6Zzrc; 
 arc=none smtp.remote-ip=109.224.244.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.122;
 helo=mail-244122.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=nml6Zzrc
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch
 [109.224.244.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C58180BB7
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791289929; x=1791549129;
 bh=oC5To7tPDKyYXwZ7STXU7IJ4YEuiAvfstFLQ43LygoE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=nml6Zzrcuk+8sN09JBgpNupabcNe4rlPNWIFRHQdgRLpa1pZjhF/jCgXSF0snxk/v
 VPmROBKsCAxHEixHlwXJYcS9AAQ79xT0W/Sujxfs0cZMKRKJURvU6+4bOusy3VYD6b
 uQKASfMSTVXb7RnBazvZZ1pU+0MjX9J9lKXilPkzJ/h3ZmnoS7P3TjksPbNoADQ24K
 spft53+esAajhJ/mvRhh6AzGtN6R97wpTiIF/UPTbPEKcsuPqyLXokbL8W2bAjoi4L
 e//sXE5tsDSaUEtdCfRerwS86laV+o0GjyaS9TXdvjrTBI2FDe4xQYdDHcP9ErW5q6
 6udN79OiBCUIg==
Date: Tue, 06 Oct 2026 12:32:05 +0000
To: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH v2 1/2] phy: spacemit: add K1 USB 2.0 PHY driver
Message-ID: <20261006T020608-0400.uboot-k1-usb-v2-0001.DaveWK225@protonmail.com>
In-Reply-To: <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 2502ca9a7a7ca5ebf4a49974c9ec410d4f3d74fc
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

The divider has to be written before the PLL is polled. On the OrangePi
R2S under FreeBSD, a driver that polled first and never wrote it left
the PLL stopped: the clock enables did not latch (0x60ef read back as
0x60e9), the PHY gave the controller no UTMI clock and the xHCI reset
(USBCMD.HCRST) never completed. Warn if the enables do not latch.

Also apply the vendor's HS DAC current setting (+15 %), which the
FreeBSD driver that runs the R2S port does.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 MAINTAINERS                        |   1 +
 drivers/phy/spacemit/Kconfig       |   9 ++
 drivers/phy/spacemit/Makefile      |   1 +
 drivers/phy/spacemit/phy-k1-usb2.c | 173 +++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 drivers/phy/spacemit/phy-k1-usb2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e09f9506c..0af42acfbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1517,6 +1517,7 @@ M:=09Yixun Lan <dlan@kernel.org>
 S:=09Maintained
 T:=09git https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit.=
git
 F:=09arch/riscv/dts/k1-*-u-boot.dtsi
+F:=09drivers/phy/spacemit/phy-k1-usb2.c
 N:=09spacemit
 K:=09spacemit
=20
diff --git a/drivers/phy/spacemit/Kconfig b/drivers/phy/spacemit/Kconfig
index 3c47601c1f..7146965d92 100644
--- a/drivers/phy/spacemit/Kconfig
+++ b/drivers/phy/spacemit/Kconfig
@@ -9,3 +9,12 @@ config PHY_SPACEMIT_K1_PCIE
 =09  ports B and C.  The combo PHY must be enabled even if port A
 =09  is not used for PCIe, because it provides calibration values
 =09  required by the other ports.
+
+config PHY_SPACEMIT_K1_USB2
+=09bool "SpacemiT K1 USB 2.0 PHY driver"
+=09depends on PHY && CLK
+=09help
+=09  Enable this to support the USB 2.0 (UTMI) PHY of the SpacemiT K1
+=09  SoC, used by its DWC3 USB 3 controller. The driver configures the
+=09  PLL for the 24 MHz reference clock, releases the internal resets
+=09  and enables the PHY clocks before the controller is started.
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
index 0000000000..c4b438219b
--- /dev/null
+++ b/drivers/phy/spacemit/phy-k1-usb2.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SpacemiT K1 USB 2.0 (UTMI) PHY driver
+ *
+ * Ported from the Linux SpacemiT K1 USB 2.0 PHY driver:
+ * Copyright (C) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (C) 2025 Ze Huang <huang.ze@linux.dev>
+ *
+ * The HS DAC current setting and the clock-enable check follow the FreeBS=
D
+ * spacemit_usb2phy driver (BSD-2-Clause), which brought USB up on the
+ * OrangePi R2S:
+ * Copyright (c) 2026 Daniel Shue <dgshue@gmail.com>
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
+/* Vendor HS DAC current setting: +15 % drive, current regulator on */
+#define PHY_ANALOG_REG14_13=09=090xa4
+#define  PHY_HSDAC_ISEL=09=09=09GENMASK(3, 0)
+#define  PHY_HSDAC_ISEL_15_INC=09=090xc
+#define  PHY_HSDAC_IREG_EN=09=09BIT(4)
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
+=09 * Program the PLL divider for the 24 MHz reference first. Until it is
+=09 * written the PLL does not run, the clock enables below do not latch
+=09 * and the PHY gives the DWC3 no UTMI clock, so the xHCI reset
+=09 * (USBCMD.HCRST) never completes. Found on the OrangePi R2S under
+=09 * FreeBSD, whose earlier driver polled for the PLL before this write.
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
+=09val =3D readl(base + PHY_RST_MODE_CTRL);
+=09if ((val & PHY_CLK_ENABLE_BITS) !=3D PHY_CLK_ENABLE_BITS)
+=09=09dev_warn(phy->dev, "clock enables did not latch (%#x)\n", val);
+
+=09writel(PHY_HSTXP_RSTN | PHY_CLK_HSTXP_EN | PHY_HSTXP_MODE,
+=09       base + PHY_HSTXP_HW_CTRL);
+
+=09clrsetbits_le32(base + PHY_ANALOG_REG14_13, PHY_HSDAC_ISEL,
+=09=09=09FIELD_PREP(PHY_HSDAC_ISEL, PHY_HSDAC_ISEL_15_INC) |
+=09=09=09PHY_HSDAC_IREG_EN);
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

