Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EAFC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6DA8309D;
	Tue,  8 Apr 2025 00:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kGHI+tvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F58831C8; Tue,  8 Apr 2025 00:49:28 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCCAF8309A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066164; bh=BHSOVy0nx061uumvjTMuok11g8WshLORBh+mU2vZICk=;
 b=kGHI+tvMcepU7Qh+imY9bccPVljJG6p+34ayQDduWe1/CT0HomDEUle6Q14TkAAwMfAkBmBSm
 H7ePMTAF4mYxVx/kIksZy66NGr0Hy7NBhrgtpAhXRhQT/F7WUltBWnG1/0ku5C4z0lJehD8lx4a
 o+LfF3c2jego6eNyx7oIwkv3Wc5adeTYYBtmoeBVyPy1WyKwO+tqZG3eVvHE60a0TC/ArwA58U5
 QGhA2oIYFooDbevPKApMrtEspS2V7TYYvqI9S+ZQluh7NCHfsTKY77W15rKnT8tE3GkvNbyrIRb
 PcIhJEpIHylhrcnA3H5Z6hIU+n1kBLdE6108rmq2OUwg==
X-Forward-Email-ID: 67f456729fd75b9b96512997
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Lin Jinhan <troy.lin@rock-chips.com>
Subject: [PATCH v2 25/30] rng: rockchip: Add support for rkrng variant
Date: Mon,  7 Apr 2025 22:46:58 +0000
Message-ID: <20250407224743.2423921-26-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Lin Jinhan <troy.lin@rock-chips.com>

Add support for rkrng variant, used by e.g. RK3528 and RK3576.

Imported from vendor U-Boot linux-6.1-stan-rkr5 tag with minor
adjustments for mainline.

Signed-off-by: Lin Jinhan <troy.lin@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Rebase on "rockchip: Update rng compatible for RK356x and RK3588"
---
 drivers/rng/rockchip_rng.c | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index 6e4e3abf08c8..d854ea900442 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -70,6 +70,27 @@
 #define TRNG_v1_VERSION_CODE			0x46BC
 /* end of TRNG V1 register define */
 
+/* start of RKRNG register define */
+#define RKRNG_CTRL				0x0010
+#define RKRNG_CTRL_INST_REQ			BIT(0)
+#define RKRNG_CTRL_RESEED_REQ			BIT(1)
+#define RKRNG_CTRL_TEST_REQ			BIT(2)
+#define RKRNG_CTRL_SW_DRNG_REQ			BIT(3)
+#define RKRNG_CTRL_SW_TRNG_REQ			BIT(4)
+
+#define RKRNG_STATE				0x0014
+#define RKRNG_STATE_INST_ACK			BIT(0)
+#define RKRNG_STATE_RESEED_ACK			BIT(1)
+#define RKRNG_STATE_TEST_ACK			BIT(2)
+#define RKRNG_STATE_SW_DRNG_ACK			BIT(3)
+#define RKRNG_STATE_SW_TRNG_ACK			BIT(4)
+
+/* DRNG_DATA_0 ~ DNG_DATA_7 */
+#define RKRNG_DRNG_DATA_0			0x0070
+#define RKRNG_DRNG_DATA_7			0x008C
+
+/* end of RKRNG register define */
+
 #define RK_RNG_TIME_OUT	50000  /* max 50ms */
 
 #define trng_write(pdata, pos, val)	writel(val, (pdata)->base + (pos))
@@ -228,6 +249,49 @@ exit:
 	return retval;
 }
 
+static int rkrng_init(struct udevice *dev)
+{
+	struct rk_rng_plat *pdata = dev_get_priv(dev);
+	u32 reg = 0;
+
+	rk_clrreg(pdata->base + RKRNG_CTRL, 0xffff);
+
+	reg = trng_read(pdata, RKRNG_STATE);
+	trng_write(pdata, RKRNG_STATE, reg);
+
+	return 0;
+}
+
+static int rkrng_rng_read(struct udevice *dev, void *data, size_t len)
+{
+	struct rk_rng_plat *pdata = dev_get_priv(dev);
+	u32 reg = 0;
+	int retval;
+
+	if (len > RK_HW_RNG_MAX)
+		return -EINVAL;
+
+	reg = RKRNG_CTRL_SW_DRNG_REQ;
+
+	rk_clrsetreg(pdata->base + RKRNG_CTRL, 0xffff, reg);
+
+	retval = readl_poll_timeout(pdata->base + RKRNG_STATE, reg,
+				    (reg & RKRNG_STATE_SW_DRNG_ACK),
+				    RK_RNG_TIME_OUT);
+	if (retval)
+		goto exit;
+
+	trng_write(pdata, RKRNG_STATE, reg);
+
+	rk_rng_read_regs(pdata->base + RKRNG_DRNG_DATA_0, data, len);
+
+exit:
+	/* close TRNG */
+	rk_clrreg(pdata->base + RKRNG_CTRL, 0xffff);
+
+	return retval;
+}
+
 static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
 {
 	unsigned char *buf = data;
@@ -295,6 +359,11 @@ static const struct rk_rng_soc_data rk_trngv1_soc_data = {
 	.rk_rng_read = rk_trngv1_rng_read,
 };
 
+static const struct rk_rng_soc_data rkrng_soc_data = {
+	.rk_rng_init = rkrng_init,
+	.rk_rng_read = rkrng_rng_read,
+};
+
 static const struct dm_rng_ops rockchip_rng_ops = {
 	.read = rockchip_rng_read,
 };
@@ -324,6 +393,10 @@ static const struct udevice_id rockchip_rng_match[] = {
 		.compatible = "rockchip,rk3588-rng",
 		.data = (ulong)&rk_trngv1_soc_data,
 	},
+	{
+		.compatible = "rockchip,rkrng",
+		.data = (ulong)&rkrng_soc_data,
+	},
 	{},
 };
 
-- 
2.49.0

