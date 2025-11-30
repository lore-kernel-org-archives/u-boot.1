Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD78D111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 21:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DB9839A8;
	Sun, 30 Nov 2025 22:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25DD38312A; Sun, 30 Nov 2025 22:46:40 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77FA3839D7
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 22:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 966BC340FC2;
 Sun, 30 Nov 2025 21:46:33 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 30 Nov 2025 21:45:19 +0000
Subject: [PATCH v2 10/10] sunxi: mmc: enable support for A733
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251130-01-a733-soc-support-v2-10-18bdd4376fad@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
In-Reply-To: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=CFG2W3JtISCVhPCvMYQmLmzdHb0+M97uNT8O8uYdCUE=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpLLsV3e4TOAio2hkGQhGNfVTWxMKLkA+S3lxNs
 WnBLz0DYWuJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaSy7FV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277TpkD/9MBrLhkmfp4lRgrK
 /cWR6/XWZvZUOQa7/l1yo29Z2dxesKysW4lFsQQFnYspNaxpdUUut2r7zT1nR+G5Tx9EuH9pag7
 NVJf2MQc06wpiYGLgd3tG8Yi2u421Jauc5rjONVuF/ETVYOPeB8JUkUkNb2w7sjbai2prrDmnv1
 OOeDpAqCHdmBXgRvPcEPWsFIFB8Ahh54n3XR5HRQVqTQwpy6fohBZqh3UEGXml7gG3dnFwVjBUt
 UUBsVg6NMVzYiTVHaMs0xjOfFnZzvlnAVfR680zHu6la2J2lmv4ibUsfjlK9EG0nzAazhrXTtfp
 3hndRHofIHf4RwSaB1w/9JKiNOLzmkySCLTOcRw0owZxQEFhzc8tF65oqwCmF6292B5rZ+y8u86
 fV//BC39tlRADQHmiyb4PVy2BbXFjc/cQv2CYsjThQYf0gMcJ1rftoAlmPU6HX+CKJeUjs3CTv5
 zPd2RC5Po9RBFP2Iq99QP0oTNuqmIEbYGLxyD0tH/tY9lf7yrhMp2aRzJuFqOMeW91j/wsCpasj
 ufq/sDqNMoJpZXIjYmyzfOZtauhFQRJgp/tqSYySxPx4TpPSLesvs1udmqcGzBNe/nnZR6bCXdD
 zZtjIErltHiJHvRvIOnyXIOdBfsYrmP6zdCUdchjM7wgd6IWK1vQHQiTzGAY4oEP93ZA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Minor clock adjustment for new A733 MMC controller, the SMHC0_CLK_REG
start at offset 0x400, and with step size of 0x10.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/mmc/sunxi_mmc.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index e28c81afffe..689bec6693c 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -112,6 +112,9 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 			if (priv->mmc_no == 2)
 				pll_hz *= 2;
 		}
+
+		if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+			pll_hz /= 3;
 	}
 
 	div = pll_hz / hz;
@@ -167,7 +170,8 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 	}
 
 	/* The A523 has a second divider, not a shift. */
-	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
+	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523) ||
+		IS_ENABLED(CONFIG_MACH_SUN60I_A733))
 		n = (1U << n) - 1;
 
 	writel(CCM_MMC_CTRL_ENABLE| pll | CCM_MMC_CTRL_N(n) |
@@ -661,17 +665,28 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
 	.get_cd		= sunxi_mmc_getcd,
 };
 
-static unsigned get_mclk_offset(void)
+static unsigned int get_mclk_offset(void)
 {
 	if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
 		return 0x410;
 
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		return 0xd00;
+
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
 		return 0x830;
 
 	return 0x88;
 };
 
+static unsigned int get_mclk_size(void)
+{
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		return 0x10;
+
+	return 0x4;
+};
+
 static int sunxi_mmc_probe(struct udevice *dev)
 {
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
@@ -707,7 +722,7 @@ static int sunxi_mmc_probe(struct udevice *dev)
 	ccu_reg = (u32 *)(uintptr_t)ofnode_get_addr(args.node);
 
 	priv->mmc_no = ((uintptr_t)priv->reg - SUNXI_MMC0_BASE) / 0x1000;
-	priv->mclkreg = (void *)ccu_reg + get_mclk_offset() + priv->mmc_no * 4;
+	priv->mclkreg = (void *)ccu_reg + get_mclk_offset() + priv->mmc_no * get_mclk_size();
 
 	ret = clk_get_by_name(dev, "ahb", &gate_clk);
 	if (!ret)

-- 
2.51.2

