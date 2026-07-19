Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393B8C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 02:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86BB84A29;
	Sun, 19 Jul 2026 04:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4590484A1A; Sun, 19 Jul 2026 04:02:46 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C63684A30
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 04:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGob-000000001qQ-22LQ; Sun, 19 Jul 2026 01:59:37 +0000
Date: Sun, 19 Jul 2026 02:59:34 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <lukma@denx.de>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dang Huynh <dang.huynh@mainlining.org>,
 Daniel Golle <daniel@makrotopia.org>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.denx.de
Subject: [PATCH 5/9] video: rockchip: vop2: fix NULL register base in rk3568
 probe
Message-ID: <e96a7d1ed33b5be368556ee0f9b3383df6e32efd.1784424101.git.daniel@makrotopia.org>
References: <cover.1784424101.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784424101.git.daniel@makrotopia.org>
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

rk3568_vop_probe() calls rkvop2_initialize() before rk_vop2_probe(),
but priv->regs (the VOP register base) was only resolved inside
rk_vop2_probe() via dev_read_addr_ptr(). rkvop2_initialize()
dereferences priv->regs (sysctrl = priv->regs + VOP2_SYSREG_OFFSET),
so on probe it faulted on a NULL base:

  Synchronous Abort, esr 0x96000010, far 0x50
  ... rk3568_vop_probe

Resolve the register base at the top of rk3568_vop_probe(), before
rkvop2_initialize() runs; rk_vop2_probe() then sets it again to the
same value.

Fixes: the in-review 'video: rockchip: Add VOP2 support' change.
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/video/rockchip/rk3568_vop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/rockchip/rk3568_vop.c b/drivers/video/rockchip/rk3568_vop.c
index 787060c1d80..ce182d1d51c 100644
--- a/drivers/video/rockchip/rk3568_vop.c
+++ b/drivers/video/rockchip/rk3568_vop.c
@@ -179,12 +179,22 @@ static int rk3568_vop_remove(struct udevice *dev)
 
 static int rk3568_vop_probe(struct udevice *dev)
 {
+	struct rk_vop2_priv *priv = dev_get_priv(dev);
 	int ret;
 
 	/* Before relocation we don't need to do anything */
 	if (!(gd->flags & GD_FLG_RELOC))
 		return 0;
 
+	/*
+	 * rkvop2_initialize() touches the VOP registers, so the register
+	 * base must be resolved before it runs; rk_vop2_probe() sets it
+	 * again to the same value.
+	 */
+	priv->regs = dev_read_addr_ptr(dev);
+	if (!priv->regs)
+		return -EINVAL;
+
 	ret = rkvop2_initialize(dev);
 	if (ret)
 		return ret;
-- 
2.55.0
