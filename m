Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D1CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80D96813CA;
	Fri,  2 Oct 2026 21:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4mWAJbxJJfYd; Fri,  2 Oct 2026 21:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ADF6A813A1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976717;
	b=KAJSatvUBZzk8kb8TMcVUMd61j2hnCIpgE8fY7gxjGo5LU0QhwgdepObgB6xbtiZtDWj
	 ZnC6Q8JB+GkYLbN2D4klHVhxkX4vAKqGz1hRVUIx3mVogWwcWFPWsyIl892uEneTxgMPY
	 GgSx/0SYKRw5LBj8ULebHe9YdXxsCv50JzXR/+AxGaiu2Eb8+FjgQOzRizPt58UiDBEDs
	 5CJhoDUGTNIwbXG++ferFc2kbXNZh5uBbw8qXuS16TFiABibOz8mis6q1pWT08ZcieVuW
	 GDIfTIbFJQYjDYF35fuW2qDShDeVbHTm/su1O781KSwVhpjzNziYc6r07ZZj2+/adnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bO7Txv/GEwXbPkMe8CnR5tUM5miu8wcnmaVseDYD1ng=;
	b=nvrkUf5zHcStTB2QjZ47U258B5DhK8srpgBvN9WcB5EeWIXrhJdXDihw467QZqxEj4BD
	 BnjMWntBhd35W8eBgWa9VdgbVN0kAnnrmjPm1uzsMkW7GrWeQZlTZltELobgD0DsXZwlz
	 f27G7wllqzr1W6qmpvWQjFdgEwP5qVCYACdeuslqdewWpfJnf/R2s7C022x62H/ALvmXi
	 oACgZ5R0zZNM5tQIUxFKIygNBjCygwPBkgXp7Uz2L7mjhtgvx+GFR68ZOFo+gy/k0fZ1z
	 bZ5TveU2uyJ53vdWBvrhMHBQHz47mv0TT2o13mb9HPzXu4vpxXT60iJC6YyFhJl1USg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976717;
	bh=bO7Txv/GEwXbPkMe8CnR5tUM5miu8wcnmaVseDYD1ng=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I9ItYcgA5SV4JEuqHU2R1aCGmAihyeahwH2kccrDoH3x/Gho+OonMq7R+d+nBWUKx
	 3HTMmOFwOG+R8DylRHvZvqvQIJsVRY0W5E+RcZP7Mm+7odms08urXj6k8JFWiJLep5
	 O0Xu4yMsl2+ufVrQwh0/I6bItCsrJ6GMRFB70n5EheuNmnKj0Qjcc4KAfyjE9YV5qf
	 EwqHlvJMSFiZKbvFdzs0634yr9M520HI+rQqt/dxYSruYb69+zeHTeVubBRaVgW3X5
	 yeFfDUXY4PTrgqE7r0VyqAKY80snNR7oWe6Yx93sfaI/qNSzqDYOl4YZQXyTkE6H/S
	 QTWQH539L/V4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADF6A813A1;
	Fri,  2 Oct 2026 21:31:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7643234D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 739D940590
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5LgT5Uzc_aTc for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:31:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A648D40585
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.9.206.169
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976679;
 b=Kcek+7/GCY4xNMQpvQXkpQFjkjtA9S+2k2LIkcWN+uytq5on7DgPZFivTCCo7Hc581VM
 vJddhm6VoXN/dSjb+Jgk8HY9ZVZGzyNDLIgYBFp2P2xa3clXTmgDC9sb/lNJQnKeFsRnQ
 ny9Ss2y3MWxfiDXqg43OdSqWJu/n9wWdzuwaV3WgSNAFG3kpYAwJgEjf4a/jc0F0h4sif
 5bY2uk7VQp+ImYiZYiExVNteo2k7N/y6ZeWUWuW8wZfuo1EsU2iIDZCvdqDF2gaOIsgNS
 aCBmJ2DjZx5fh2vXnVe9bVoUXO5eXODlIOppUv1JOo1eB9ujmq87ALFuUN2KPAn2w3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976679;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=bO7Txv/GEwXbPkMe8CnR5tUM5miu8wcnmaVseDYD1ng=;
 b=aTT9ZoqyS/f2d/N+O0YRyIDZpv0hrHbuaip8Y8QxDCrpSbWLxK1/6HHmceeaG7qBKi8k
 gfNVTEUAS9oHVLIEuMdTANWOhcLMCiLBoMj8hNdK6WetZmbF8sjBdzx1n7H9X3seo0hjP
 pERPCDq4FNCP23yKFsBc5nHanpOT61kmsPGyGLNtatH+JXHhZ2ML0QAbTLnhVbnFAmUHu
 rmXBM2KGEKoWyJvaPhZXob7C4yr/oSbmaittIEpoudw2lZbFYfu+cI/KXhENUJj3xy0yi
 NiHjGla/rT8TXnzt/Qmxt+BMZBnkXgFKvemZjxupKOUkU4EtXwT0BWFqXCvq3VcvtkQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b="PeaE3/wu"; 
 arc=none smtp.remote-ip=85.9.206.169
X-Greylist: delayed 111 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 02 Oct 2026 21:31:19 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=PeaE3/wu
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.206.169;
 helo=mail-05.mail-europe.com; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A648D40585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976673; x=1791235873;
 bh=bO7Txv/GEwXbPkMe8CnR5tUM5miu8wcnmaVseDYD1ng=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=PeaE3/wuyTrYKsl3rmO+YZRDMq3imtEKBg2YeJrOIeQrGC/Lg7T5U1Z4QXj5YNHYm
 vnSAy52wa1ZQqZTnv7EwgX/eAvjuCVoUAkveIt9RnJe1EmSJkbZiQJU8MPDCaB1fs1
 bwshr6ksxhIoa1oomz0fd1PijgetpHvvVp9AbMqttLOENKZ0+MCdqgQ/hI/b7X15wt
 y0bBcnAxHlGSTHnwjdc+OF/C9ISfATRKrmUc1k5oLCEV6BuHTQieB160riiYlwW7YK
 P1gP0UmiSqX4agyD/1dvWHyYCf4XywkPQ5EDKx16HCGCOH+kt9kDqHk0YvI7s/yzcR
 xBvbeP/99TPtA==
Date: Fri, 02 Oct 2026 21:31:07 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 6/9] pci: spacemit: do not force the link to 2.5 GT/s
Message-ID: <bbfa4cbc6c21effbb507644cfa94cfbad4ab6d82.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 2ac0041eb064ef38e678b77cece78d0b98e84f59
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:31:56 +0000
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

The driver writes Gen1 into the Supported Link Speeds field of the root
port's Link Capabilities and into the Target Link Speed of Link
Control 2, so the K1's 5 GT/s capable ports never train above 2.5 GT/s,
and an operating system that keeps the root port as found cannot
retrain them faster either. It also writes them at the fixed offsets
0x7c and 0xa0 instead of through the PCI Express capability.

Linux's DesignWare core leaves both fields alone unless the device tree
limits the speed with "max-link-speed", and then writes that value to
both. Do the same, finding the registers through the capability list,
and drop the driver's copies of the speed definitions that
pcie_dw_common.h already provides.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/pci/pcie_dw_spacemit.c | 48 ++++++++++++++++++++++++----------
 drivers/pci/pcie_dw_spacemit.h |  7 -----
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.=
c
index 3394ddbd18..6ac1d6bea4 100644
--- a/drivers/pci/pcie_dw_spacemit.c
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -40,6 +40,7 @@ struct pcie_dw_spacemit {
 =09struct clk_bulk=09=09clks;
 =09struct reset_ctl_bulk=09rsts;
 =09struct udevice=09=09*vpcie3v3;=09/* slot supply, if described */
+=09u32=09=09=09max_link_speed;=09/* 0: hardware default */
 };
=20
 static inline u32 spacemit_pcie_readl(struct pcie_dw_spacemit *pcie, u32 o=
ffset)
@@ -58,21 +59,33 @@ static inline u32 spacemit_pcie_phy_ahb_readl(struct pc=
ie_dw_spacemit *pcie, u32
 =09return readl(pcie->phy_ahb + offset);
 }
=20
-static void pcie_dw_configure(struct pcie_dw_spacemit *pci, u32 cap_speed)
+static void pcie_dw_configure(struct pcie_dw_spacemit *pci)
 {
-=09u32 val;
+=09void __iomem *cap;
+=09u32 speed =3D pci->max_link_speed;
+=09u16 lnkctl2;
+=09u32 lnkcap;
=20
-=09dw_pcie_dbi_write_enable(&pci->dw, true);
+=09cap =3D pci->dw.dbi_base + pcie_dw_find_capability(&pci->dw,
+=09=09=09=09=09=09=09 PCI_CAP_ID_EXP);
=20
-=09val =3D readl(pci->dw.dbi_base + PCIE_LINK_CAPABILITY);
-=09val &=3D ~TARGET_LINK_SPEED_MASK;
-=09val |=3D cap_speed;
-=09writel(val, pci->dw.dbi_base + PCIE_LINK_CAPABILITY);
+=09dw_pcie_dbi_write_enable(&pci->dw, true);
=20
-=09val =3D readl(pci->dw.dbi_base + PCIE_LINK_CTL_2);
-=09val &=3D ~TARGET_LINK_SPEED_MASK;
-=09val |=3D cap_speed;
-=09writel(val, pci->dw.dbi_base + PCIE_LINK_CTL_2);
+=09/*
+=09 * Keep the hardware's supported speeds unless the device tree limits
+=09 * them with "max-link-speed", as Linux's DesignWare core does.
+=09 */
+=09if (speed) {
+=09=09lnkcap =3D readl(cap + PCI_EXP_LNKCAP);
+=09=09lnkcap &=3D ~PCI_EXP_LNKCAP_SLS;
+=09=09lnkcap |=3D speed;
+=09=09writel(lnkcap, cap + PCI_EXP_LNKCAP);
+
+=09=09lnkctl2 =3D readw(cap + PCI_EXP_LNKCTL2);
+=09=09lnkctl2 &=3D ~PCI_EXP_LNKCTL2_TLS;
+=09=09lnkctl2 |=3D speed;
+=09=09writew(lnkctl2, cap + PCI_EXP_LNKCTL2);
+=09}
=20
 =09dw_pcie_dbi_write_enable(&pci->dw, false);
 }
@@ -105,12 +118,12 @@ static int wait_link_up(struct pcie_dw_spacemit *pci)
 =09return 1;
 }
=20
-static int pcie_dw_spacemit_pcie_link_up(struct pcie_dw_spacemit *pci, u32=
 cap_speed)
+static int pcie_dw_spacemit_pcie_link_up(struct pcie_dw_spacemit *pci)
 {
 =09u32 reg;
=20
 =09/* DW pre link configurations */
-=09pcie_dw_configure(pci, cap_speed);
+=09pcie_dw_configure(pci);
=20
 =09/* Initiate link training */
 =09reg =3D spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
@@ -315,7 +328,7 @@ static int pcie_dw_spacemit_probe(struct udevice *dev)
 =09pcie_dw_setup_host(&pci->dw);
 =09pcie_dw_init_id(pci);
=20
-=09if (!pcie_dw_spacemit_pcie_link_up(pci, LINK_SPEED_GEN_1)) {
+=09if (!pcie_dw_spacemit_pcie_link_up(pci)) {
 =09=09printf("PCIE-%d: Link down\n", dev_seq(dev));
 =09=09return -ENODEV;
 =09}
@@ -380,6 +393,13 @@ static int pcie_dw_spacemit_of_to_plat(struct udevice =
*dev)
 =09=09return -EINVAL;
 =09pcie->apmu_offset =3D args.args[0];
=20
+=09pcie->max_link_speed =3D dev_read_u32_default(dev, "max-link-speed", 0)=
;
+=09if (pcie->max_link_speed > LINK_SPEED_GEN_4) {
+=09=09dev_warn(dev, "invalid max-link-speed %u, ignored\n",
+=09=09=09 pcie->max_link_speed);
+=09=09pcie->max_link_speed =3D 0;
+=09}
+
 =09/* Derive port ID from DBI base address */
 =09pcie->port_id =3D (dbi_addr - SPACEMIT_PCIE_DBI_BASE) / SPACEMIT_PCIE_D=
BI_STRIDE;
=20
diff --git a/drivers/pci/pcie_dw_spacemit.h b/drivers/pci/pcie_dw_spacemit.=
h
index 6f198f7d58..21686de246 100644
--- a/drivers/pci/pcie_dw_spacemit.h
+++ b/drivers/pci/pcie_dw_spacemit.h
@@ -12,13 +12,6 @@
 #include <linux/bitops.h>
=20
 /* PCIe DW common registers */
-#define PCIE_LINK_CAPABILITY=09=090x7c
-#define PCIE_LINK_CTL_2=09=09=090xa0
-#define TARGET_LINK_SPEED_MASK=09=090xf
-#define LINK_SPEED_GEN_1=09=090x1
-#define LINK_SPEED_GEN_2=09=090x2
-#define LINK_SPEED_GEN_3=09=090x3
-
 #define PCIE_MISC_CONTROL_1_OFF=090x8bc
 #define PCIE_DBI_RO_WR_EN=09=09BIT(0)
=20
--=20
2.55.0


