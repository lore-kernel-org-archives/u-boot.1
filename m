Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1261CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D631B846D3;
	Mon, 25 May 2026 04:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Y0Aqejck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 442CD8039B; Mon, 25 May 2026 03:29:01 +0200 (CEST)
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch
 [109.224.244.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C540C83EF9
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672538; x=1779931738;
 bh=4Xy0nOMEwwVrlHgpHM8qvgVwr/J9zZcging1r8xcEOQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Y0Aqejck40eNKT2dYgwSlTjNZAW/b1XMIxZO+lc0qyR9Z3sNBNKC9wJg9JLIz9yVs
 pacTj3vl4AxI81n5kn9LhuEI01LJjUK5WRRuuO0Z3GL4RidH4rI3EvMWhNHv+AzcYN
 OqGhrjW2Tj622Ouv4dfcn7nOJFs2me3vcR0tpuh9yFfHoDklaWAuIOCWilT2V4wYQd
 IPfNgQfVure0KxSbnUl8R5Q81HFXnkEe9r2x/rhAoyWHDG3Akl30okMGi3SwPODgqS
 MVbV49YC5XWuPLr2qLiiWic0ap76fuKSr3DzYNsdP/mDEIpU481wTd3xvJjROROTBK
 dJgJfaOnpaRug==
Date: Mon, 25 May 2026 01:28:53 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 02/14] clk: rockchip: rk3576: add OF_PLATDATA support
 for TPL
Message-ID: <20260525012824.121-3-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 32e4cb2f595b4c56c20d8d8875912fe417d46bc5
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

TPL uses CONFIG_OF_PLATDATA (dtoc), which requires a driver-specific
platdata struct and a .plat_auto size in U_BOOT_DRIVER.  Without
this the driver fails to probe in TPL context because dtoc generates
struct dtd_rockchip_rk3576_cru but the driver does not declare it.

Add:
  - #include <dt-structs.h> for the dtd_rockchip_rk3576_cru type
  - struct rk3576_clk_plat wrapping dtd_rockchip_rk3576_cru
  - .plat_auto =3D sizeof(struct rk3576_clk_plat) in U_BOOT_DRIVER

Guard clk_set_defaults() with !CONFIG_IS_ENABLED(OF_PLATDATA): it
reads the DT at runtime which is unavailable in OF_PLATDATA builds,
and the assigned-clock properties are handled by dtoc at build time.

Pattern mirrors clk_rk3568.c from the RK3568 RFC series.

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 drivers/clk/rockchip/clk_rk3576.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_r=
k3576.c
index 1026af27ca1..8f99a440a3e 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -7,6 +7,7 @@
 #include <bitfield.h>
 #include <clk-uclass.h>
 #include <dm.h>
+#include <dt-structs.h>
 #include <errno.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/cru_rk3576.h>
@@ -17,6 +18,12 @@
 #include <dt-bindings/clock/rockchip,rk3576-cru.h>
 #include <linux/delay.h>
=20
+#if CONFIG_IS_ENABLED(OF_PLATDATA)
+struct rk3576_clk_plat {
+=09struct dtd_rockchip_rk3576_cru dtd;
+};
+#endif
+
 #define DIV_TO_RATE(input_rate, div)=09((input_rate) / ((div) + 1))
=20
 static struct rockchip_pll_rate_table rk3576_24m_pll_rates[] =3D {
@@ -2447,12 +2454,14 @@ static int rk3576_clk_probe(struct udevice *dev)
=20
 =09rk3576_clk_init(priv);
=20
+#if !CONFIG_IS_ENABLED(OF_PLATDATA)
 =09/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
 =09ret =3D clk_set_defaults(dev, 1);
 =09if (ret)
 =09=09debug("%s clk_set_defaults failed %d\n", __func__, ret);
 =09else
 =09=09priv->sync_kernel =3D true;
+#endif
=20
 =09return 0;
 }
@@ -2506,6 +2515,9 @@ U_BOOT_DRIVER(rockchip_rk3576_cru) =3D {
 =09.id=09=09=3D UCLASS_CLK,
 =09.of_match=09=3D rk3576_clk_ids,
 =09.priv_auto=09=3D sizeof(struct rk3576_clk_priv),
+#if CONFIG_IS_ENABLED(OF_PLATDATA)
+=09.plat_auto=09=3D sizeof(struct rk3576_clk_plat),
+#endif
 =09.of_to_plat=09=3D rk3576_clk_ofdata_to_platdata,
 =09.ops=09=09=3D &rk3576_clk_ops,
 =09.bind=09=09=3D rk3576_clk_bind,
--=20
2.45.1.windows.1


