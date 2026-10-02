Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410FECA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DF3F8139F;
	Fri,  2 Oct 2026 21:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PGqD88HvPd01; Fri,  2 Oct 2026 21:31:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F104E813D7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976674;
	b=oKSRvniNO+7ltTW5j6909VqrOKWMwEm3EUMDngGtRobQvSsVoFEfRax8DRtvwaARrm0g
	 E5j0b2Mz6OV/0JVp+8WvFKJaPncChaHolsw9AAoggdkgnnuf54iIE9wjIpdeEFG6YHCoG
	 nCSd3wzVjoClAb7n52C3fwU/Yv0aEiXjM3FPhFzFjsj0KDZCSnumdPF0DLut4pvgLBJVp
	 dXFbvSf1bjsd5y/4l6ui6c4eJcUSe2YGXWi2WQ3KJ221NwgzVjLeCh4NHsAOTOn/zC/m4
	 tBpEgJuPuLXHK62w2SUN8YGLsa7q7IGHJiPSvdD0b8sPxvidd6N2ORO1ELdHbam7vjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976674;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CQUEx/1JEwOfb4HVxxn7LuhZT6XFJjy/UPqCGkKgtgs=;
	b=etctWQYNGHP0+ijDVYwHX64DFAtut62Viz8d109y/zTWzRPK/9vzZZ4krufB/dIhQ3r9
	 HeqKr3JK9QRMi8LgnYPWq+uOjYpPyNvDhoLc6oIRZiNZlc81F6F1db8GkRyPsXC2bg5Fd
	 wTxuh689/214p/97xzmkMvQlBq9YvpAz5ftytOV4n44SapJzTsepUDSfSvlkhd3Pe//Sl
	 O8XdMrhS2ipR6Vw221nwi7xBTRoDYSNVOwerSu+C3dyRkEKA92gdyF4q1zIw9gerBJRrL
	 4Z143JPAjp5jt0Fb1rbOiBBqNOOrTqizf9a0oVy+6z8gCRMpQFBF7hgKqHFujkK2idg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976674;
	bh=CQUEx/1JEwOfb4HVxxn7LuhZT6XFJjy/UPqCGkKgtgs=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cPyRil7Cgf5YCTqG3QwP3ka5WitWTRxekI2goYf+lMYYFHXzFlBXmC2WVZoXKLPPu
	 sT88wykGJEKFYcmaKvEjRSGurU6K11VYrMIaZ2mfbWJHU3JvPm/w5Fh/57riIXSW8u
	 +UNc9VtjKYinKd1dYS9KUro5rXCKVt04rpH5o5we/zNtLEwgjKs1evhOLkWBiijGpS
	 4kTQMeBa9pJ4I8FO/j30gYTzWRREWlkDribf9wNulj0s4bbU2FxcfHQxkPGlYnEqfq
	 keR36p/k+ghBOG/dkRY0JfcnHFaLjnvPw7XcTy0iwTg97hiT1VYiz8kGFxbxW0qo5q
	 WzqwdJRW2QDFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F104E813D7;
	Fri,  2 Oct 2026 21:31:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 67489282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58FC860D93
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JszSrDWJc_SN for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:30:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5446460D70
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976642;
 b=US4K389uXIfbB2oSdYWSRPE2UKpqKdAwhT9s3FIEAFG1pEN08x0ANrNbgVnU+HPZmRO3
 3Rg+D6lFc0+ocRuNb7++a7bmoznbf2SlrhXRtAb057jsKv6GlJ+CiS+bzmPx1Xj35deEq
 BbvdRYj24lj5uONKWrsS4ZI7PLLDzPAByn+Y2a0Wr6K+3t2DNGG/WOSsNMZOEQWp5EYrM
 En8NagR8MBY1J8uEFj8q7BvLFIVCspCn3Z67qy7IwZftZ3WEIMxzy1J88a0CQ6siPkRe4
 s8OBU0kT0auGGmra689ZYQNwaEHtVvyRSU6R7VKyi+GswVLmlrGyDnSmOYsXbzysi4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976642;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=CQUEx/1JEwOfb4HVxxn7LuhZT6XFJjy/UPqCGkKgtgs=;
 b=CYxiUZEhrDcm0MEFQYDpUWhZzwoHQhnKzNW/EmaezdOL0vGt3+wVP/i7Y3OfU5xPZ2Sw
 jPKvWzQ/0U17v7DCwARoLJmGGz37TUuL3r0qwvEuLC9F9zOlsPg8HFxt85s0Cng7QVCBf
 PuBX0LX4PL3iSMbGUqev9GIfNo6yJj170zntNPPwaf8R/XbS5r580/zivhTjAkDYdJDhb
 XMLcO8ffwjDBe0qnMnVxQbTPzvdFhzdxGoWR7A9+LB02+j1t/id2ED7YNiUfQGwVGNRry
 C5g3aPoq1oO3N1x19BquGw1jRvEmzhBvzoWlp2/UGxVTj74sSbG05mlpn5ESf6McP5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=X7e+USp8; 
 arc=none smtp.remote-ip=109.224.244.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.123;
 helo=mail-244123.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=X7e+USp8
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch
 [109.224.244.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5446460D70
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976639; x=1791235839;
 bh=CQUEx/1JEwOfb4HVxxn7LuhZT6XFJjy/UPqCGkKgtgs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=X7e+USp8Q+Sr+Y7zWu1GGfZ/DG8NGgWw+F+meE6IdtVE+LyX+DB1kNBzwrRxvBH8J
 Thp4BWI4ZwsSJXBiUVJgS4SShz/96OanBDmAkYrpTNcU619+W7ppM78IqNy3Hfp/VC
 /Yf7J8CBxQ1+CXFC3yg/N1f4+K5W/eKczp+10AuM01Ixewk/DWIyjpvtxWdtIUYB/B
 vnL/SkPDzDsrgWJRQST8pmfA3D3Z1xSLZtfaET2zV59rxhPs4lbgvaLAXF6Jyu5YPQ
 t9L40J0vB97qZqEJYxMVtXxg1yhcS0mbAA1H5us/zavPTwPav/m/bRICvcBMfQurLF
 deKR/ffqi8YAQ==
Date: Fri, 02 Oct 2026 21:30:37 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 1/9] pci: spacemit: power the slot from vpcie3v3-supply
Message-ID: <4220c9da3d3a427fcee593c333b856263d9d625c.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: bcc2eaf12abea1abdda93776a9354745003a35cb
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

The driver takes the slot power switch from a "k1x,pwr_on" GPIO and a
"power-on-status" polarity flag. Those are vendor properties: neither
the spacemit,k1-pcie binding nor any upstream device tree has them. The
binding describes the 3.3 V slot supply as a regulator, vpcie3v3-supply,
on the root port node, and that is ignored. On boards whose M.2 slot
sits behind a GPIO-switched regulator, such as the OrangePi RV2
(GPIO 116), the slot is never powered and the link cannot train.

Look up vpcie3v3-supply on the root port, falling back to the host
bridge node where some board device trees also put it and where Linux's
pcie-spacemit-k1 driver reads it, and enable it in place of the GPIO.
PERST# is still held for 100 ms after the supply is turned on. Drop the
vendor GPIO properties.

Unlike Linux, only warn when the supply is described but cannot be
found: the Banana Pi F3 and MUSE Pi Pro describe always-on fixed
supplies, and spacemit_k1_defconfig does not build the fixed regulator
driver, so failing the probe would break ports that work today.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/pci/pcie_dw_spacemit.c | 72 +++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.=
c
index 09c56d8a4c..7ca5a5ad1a 100644
--- a/drivers/pci/pcie_dw_spacemit.c
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -8,7 +8,6 @@
  */
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <asm-generic/gpio.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
@@ -21,6 +20,7 @@
 #include <log.h>
 #include <pci.h>
 #include <power-domain.h>
+#include <power/regulator.h>
 #include <reset.h>
=20
 #include "pcie_dw_common.h"
@@ -39,8 +39,7 @@ struct pcie_dw_spacemit {
 =09/* reset, clock resources */
 =09struct clk_bulk=09=09clks;
 =09struct reset_ctl_bulk=09rsts;
-=09struct gpio_desc=09=09pwr_on_gpio;
-=09int=09=09=09power_on_status;
+=09struct udevice=09=09*vpcie3v3;=09/* slot supply, if described */
 };
=20
 static inline u32 spacemit_pcie_readl(struct pcie_dw_spacemit *pcie, u32 o=
ffset)
@@ -185,30 +184,26 @@ static int pcie_dw_init_id(struct pcie_dw_spacemit *p=
ci)
 =09return 0;
 }
=20
-static int k1x_power_on(struct pcie_dw_spacemit *pci, int on)
+/*
+ * The binding describes the 3.3 V slot supply on the root port node. Some
+ * board device trees also, or only, put it on the host bridge node, which
+ * is where Linux's driver looks for it.
+ */
+static int spacemit_pcie_get_vpcie3v3(struct udevice *dev, ofnode port,
+=09=09=09=09      struct udevice **supplyp)
 {
-=09struct pcie_dw *dwp =3D &pci->dw;
-=09int gpio_val =3D 0;
-
-=09if (on) {
-=09=09if (pci->power_on_status)
-=09=09=09gpio_val =3D 1;
-=09=09else
-=09=09=09gpio_val =3D 0;
-=09} else {
-=09=09if (pci->power_on_status)
-=09=09=09gpio_val =3D 0;
-=09=09else
-=09=09=09gpio_val =3D 1;
-=09}
-
-=09if (dm_gpio_is_valid(&pci->pwr_on_gpio)) {
-=09=09dev_info(dwp->dev, "PCIe interface power %s, set gpio %d to %d\n",
-=09=09=09 on ? "on" : "off", pci->pwr_on_gpio.offset, gpio_val);
-=09=09dm_gpio_set_value(&pci->pwr_on_gpio, gpio_val);
+=09ofnode supply;
+
+=09supply =3D ofnode_parse_phandle(port, "vpcie3v3-supply", 0);
+=09if (!ofnode_valid(supply))
+=09=09supply =3D ofnode_parse_phandle(dev_ofnode(dev),
+=09=09=09=09=09      "vpcie3v3-supply", 0);
+=09if (!ofnode_valid(supply)) {
+=09=09*supplyp =3D NULL;
+=09=09return 0;
 =09}
=20
-=09return 0;
+=09return uclass_get_device_by_ofnode(UCLASS_REGULATOR, supply, supplyp);
 }
=20
 static int pcie_dw_spacemit_probe(struct udevice *dev)
@@ -241,6 +236,13 @@ static int pcie_dw_spacemit_probe(struct udevice *dev)
 =09=09return -ENODEV;
 =09}
=20
+=09ret =3D spacemit_pcie_get_vpcie3v3(dev, port, &pci->vpcie3v3);
+=09if (ret) {
+=09=09/* e.g. an always-on fixed supply with no driver built in */
+=09=09dev_warn(dev, "vpcie3v3 supply not available: %d\n", ret);
+=09=09pci->vpcie3v3 =3D NULL;
+=09}
+
 =09ret =3D generic_phy_get_by_index_nodev(port, 0, &phy0);
 =09if (!ret) {
 =09=09reg =3D spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
@@ -271,8 +273,15 @@ static int pcie_dw_spacemit_probe(struct udevice *dev)
=20
 =09pcie_set_mode(pci, DW_PCIE_RC_TYPE);
=20
-=09/* power on the interface */
-=09k1x_power_on(pci, 1);
+=09/* Power the slot; PERST# stays asserted for 100 ms after this */
+=09if (pci->vpcie3v3) {
+=09=09ret =3D regulator_set_enable_if_allowed(pci->vpcie3v3, true);
+=09=09if (ret) {
+=09=09=09dev_err(dev, "failed to enable vpcie3v3 supply: %d\n",
+=09=09=09=09ret);
+=09=09=09return ret;
+=09=09}
+=09}
=20
 =09spacemit_pcie_host_init(pci);
 =09pcie_dw_setup_host(&pci->dw);
@@ -356,17 +365,6 @@ static int pcie_dw_spacemit_of_to_plat(struct udevice =
*dev)
 =09=09return ret;
 =09}
=20
-=09gpio_request_by_name(dev, "k1x,pwr_on", 0, &pcie->pwr_on_gpio,
-=09=09=09     GPIOD_IS_OUT);
-=09if (!dm_gpio_is_valid(&pcie->pwr_on_gpio))
-=09=09dev_info(dev, "has no power on gpio.\n");
-
-=09ret =3D dev_read_u32(dev, "power-on-status", &pcie->power_on_status);
-=09if (ret) {
-=09=09dev_info(dev, "has no power-on-status flag, use default.\n");
-=09=09pcie->power_on_status =3D 1;
-=09}
-
 =09return 0;
 }
=20
--=20
2.55.0


