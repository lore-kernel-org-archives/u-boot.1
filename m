Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECCACD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E8C8846EB;
	Mon, 25 May 2026 04:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="N/TPjRfh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E418583EF9; Mon, 25 May 2026 03:29:10 +0200 (CEST)
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B1D58039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672548; x=1779931748;
 bh=br9CuZE4qcoUn2nBWrnBhBB65Kl26obac4bA7Yp33QQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=N/TPjRfh70y3+dQmXc4ieI9wbd5IFInQK2b09sWQlmxpoT/+e/jWnIh6vM2KVhOqN
 S1cJrBtkPPCPdbgDV6VUMdhTXvwfTq+wV4DaNJ0cAZuhB47mEJ7A/hh17IWY29egIz
 jAeENcAZaAjz9FmyDcTbWWrMwM3BKu+VtiAyTxyphpothHP78a6i4ea1X2r1IUyfS5
 cizfvkO3M9llLOhR9WqgrH6E2cJn81Tgl4M8+UmN+CvuHZG4S/xD9g6S2kYlqVcZV9
 CxBtmYDjpu8EQzR0YRLrsdXby7RW1lSt3/AWu7aaG8F87FaZCz9MUwp2vQOApnmKBl
 aURPDBaun/ehw==
Date: Mon, 25 May 2026 01:28:59 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 03/14] clk: rockchip: rk3576: use CONFIG_XPL_BUILD
 instead of CONFIG_SPL_BUILD
Message-ID: <20260525012824.121-4-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 28d02f1842a41aa5ab2cb2f48a70af087145856a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

CONFIG_SPL_BUILD is only defined in SPL builds; TPL builds define
CONFIG_XPL_BUILD (which covers both SPL and TPL) but not
CONFIG_SPL_BUILD.  The existing guards therefore do not exclude
heavyweight clock functions (VOP, GMAC, UART frac) from TPL builds,
inflating TPL size unnecessarily.

Replace all six CONFIG_SPL_BUILD guards with CONFIG_XPL_BUILD.
This matches the pattern used in clk_px30.c and clk_rk3288.c.

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 drivers/clk/rockchip/clk_rk3576.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_r=
k3576.c
index 8f99a440a3e..3d9a1df4f2f 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -67,14 +67,14 @@ static struct rockchip_pll_clock rk3576_pll_clks[] =3D =
{
 =09=09     RK3576_MODE_CON0, 10, 15, 0, rk3576_24m_pll_rates),
 };
=20
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifndef BITS_WITH_WMASK
 #define BITS_WITH_WMASK(bits, msk, shift) \
 =09((bits) << (shift)) | ((msk) << ((shift) + 16))
 #endif
 #endif
=20
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  *
  * rational_best_approximation(31415, 10000,
@@ -925,7 +925,7 @@ static ulong rk3576_mmc_set_clk(struct rk3576_clk_priv =
*priv,
 =09return rk3576_mmc_get_clk(priv, clk_id);
 }
=20
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
=20
 static ulong rk3576_aclk_vop_get_clk(struct rk3576_clk_priv *priv, ulong c=
lk_id)
 {
@@ -1998,7 +1998,7 @@ static ulong rk3576_clk_get_rate(struct clk *clk)
 =09case TCLK_WDT0:
 =09=09rate =3D OSC_HZ;
 =09=09break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 =09case ACLK_VOP_ROOT:
 =09case ACLK_VOP:
 =09case ACLK_VO0_ROOT:
@@ -2177,7 +2177,7 @@ static ulong rk3576_clk_set_rate(struct clk *clk, ulo=
ng rate)
 =09case CLK_REF_PCIE1_PHY:
 =09=09ret =3D 0;
 =09=09break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 =09case ACLK_VOP_ROOT:
 =09case ACLK_VOP:
 =09case ACLK_VO0_ROOT:
@@ -2400,7 +2400,7 @@ static int rk3576_clk_probe(struct udevice *dev)
=20
 =09priv->sync_kernel =3D false;
=20
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 =09/* relase presetn_bigcore_biu/cru/grf */
 =09writel(0x1c001c00, 0x26010010);
 =09/* set spll to normal mode */
--=20
2.45.1.windows.1


