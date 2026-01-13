Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55942D29DC2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 04:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657EA839AC;
	Tue, 13 Jan 2026 05:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51169839B1; Tue, 13 Jan 2026 05:03:09 +0100 (CET)
Received: from smtp.gentoo.org (mail.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1EC83981
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 05:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 492703415D9;
 Tue, 13 Jan 2026 04:03:03 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 13 Jan 2026 12:02:02 +0800
Subject: [PATCH v3 8/9] sunxi: mmc: enable support for A733
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-01-a733-soc-support-v3-8-f19dcd098f60@gentoo.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
In-Reply-To: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=aGAs16rTNFSV2vDDe3NjxY83UXrzKy1GteqtbgSSs78=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpZcPXasiiNgOKZMdw06RcW5N1c7xXdE54rekzu
 Tyjz2XBe5WJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaWXD1xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+21VxAAhjwSex2Zq0236we9xLACuOEYYOXZ9yLWJ8eYHb4w+cFIjrgSqfg+F
 elUf5+fCgfB7IJn1x/eiyreQMvbDIbvAVQQdVq+lQpQZtXuXI/5vczEUqgvPOBngcZqeVKsgE/Q
 2DleRynO3w3Ga8fSfEcJY3IfM02iGXIJpzhXgqVyImUHtY+lUsm23tGt1K0OVNmJb3QhfA1e7FD
 Q4IshrzIwdQLZkay5KBZRANCDJBcPgoR3UCJfhCdVK6q9cjigABKKuMl6QsXsy+YUmV7MKAHjqf
 02jZGweVJACHgREcnCPPFyIKHo2siWrOxbVvUgEgl27tf483q8L6BwWFI9Nvdcm4ZNWuPUZbcKF
 kUN2b6sBbAXgCceICb8PXUZm+QmP0Q3HFw/Rz8fT+EKq5CifJnshDLfQgifceU45ZQ2e7E8PLHa
 M33xzbGjq5Ciw69OQI7xYUWjl7hzzrHgtP0VtAlEdiHgHaSQ0jeNObTBE4QJZstMUuvwmfZ74jD
 Ts6nSgOlK8CixeOPmyWUrKErVo2fBF2GtINcbZ8XjPU3qsAs4ZewSYkohofGoz/2MWkwqr3XGaQ
 tbNYA8Fi7498/JS8uC0/XNhrzXeRBcHa9vQQcvHmR2mxapm9lxtFMxD2rHlW+fafaBQ+G8mv6gX
 1g8p80thlPxMrfX0CXizjDwscdqv9k=
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
 drivers/mmc/sunxi_mmc.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index e28c81afffe..d7dbe1c27ed 100644
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
+	    IS_ENABLED(CONFIG_MACH_SUN60I_A733))
 		n = (1U << n) - 1;
 
 	writel(CCM_MMC_CTRL_ENABLE| pll | CCM_MMC_CTRL_N(n) |
@@ -661,15 +665,25 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
 	.get_cd		= sunxi_mmc_getcd,
 };
 
-static unsigned get_mclk_offset(void)
+static unsigned int get_mclk_offset(int mmc_no)
 {
+	unsigned int size, offset;
+
 	if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
-		return 0x410;
+		offset = 0x410;
+	else if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		offset = 0xd00;
+	else if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
+		offset = 0x830;
+	else
+		offset = 0x88;
 
-	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
-		return 0x830;
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		size = 0x10;
+	else
+		size = 0x4;
 
-	return 0x88;
+	return offset + size * mmc_no;
 };
 
 static int sunxi_mmc_probe(struct udevice *dev)
@@ -707,7 +721,7 @@ static int sunxi_mmc_probe(struct udevice *dev)
 	ccu_reg = (u32 *)(uintptr_t)ofnode_get_addr(args.node);
 
 	priv->mmc_no = ((uintptr_t)priv->reg - SUNXI_MMC0_BASE) / 0x1000;
-	priv->mclkreg = (void *)ccu_reg + get_mclk_offset() + priv->mmc_no * 4;
+	priv->mclkreg = (void *)ccu_reg + get_mclk_offset(priv->mmc_no);
 
 	ret = clk_get_by_name(dev, "ahb", &gate_clk);
 	if (!ret)

-- 
2.52.0

