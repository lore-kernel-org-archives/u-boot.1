Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BBECCD183
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 15:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29CFA838C8;
	Sun, 19 Oct 2025 17:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fjz+UEli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726D6800B6; Sun, 19 Oct 2025 17:48:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE83838AE
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 17:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1760888879; bh=LtcYNN8gTsSfFP86NFFuy0lkz5J8v5V8QfIH/NLOcy4=;
 b=fjz+UElirytkVwtzXpqbMecNVqfFv61okdCjV5MgJZXDVEZsaO7pnydg5+W5PnrEpjt4YGKV2
 Yr+Zf5k/EWPcMSGoQvVOVaE0VQCujKn/RfP6kvuMlpXrFUVJT2qCNW19ZMJa5aezeglbRcaguoW
 qM32daRb4cbdvr2VjyLKOs6RjDwhA05ztdNbei6sD+JjqPJSvtCIzm0YGqpUWCZyWvmU6PaYWl+
 6dqocv92ZYcdqTYINkuH41l9fsCyYETRXHbRg++/1X4F5AWPvNIUYEdQCfJbJ/c3v6p4amhhy5X
 b58anjyEf0SoAqjdyTt2YqHoVXMVdTQ/tav4IkPKRcRg==
X-Forward-Email-ID: 68f508295ea0c67427243167
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v4 1/5] spi: rockchip_sfc: Support sclk_x2 version
Date: Sun, 19 Oct 2025 15:47:15 +0000
Message-ID: <20251019154728.846096-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019154728.846096-1-jonas@kwiboo.se>
References: <20251019154728.846096-1-jonas@kwiboo.se>
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

From: Jon Lin <jon.lin@rock-chips.com>

SFC after version 8 supports dtr mode, so the IO is the binary output of
the controller clock.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v4: No change
v3: No change
v2: No change
---
 drivers/spi/rockchip_sfc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/rockchip_sfc.c b/drivers/spi/rockchip_sfc.c
index 73738ab26d33..60e74117057a 100644
--- a/drivers/spi/rockchip_sfc.c
+++ b/drivers/spi/rockchip_sfc.c
@@ -108,6 +108,7 @@
 #define  SFC_VER_3			0x3
 #define  SFC_VER_4			0x4
 #define  SFC_VER_5			0x5
+#define  SFC_VER_8			0x8
 
 /* Delay line controller resiter */
 #define SFC_DLL_CTRL0			0x3C
@@ -589,6 +590,16 @@ static int rockchip_sfc_adjust_op_size(struct spi_slave *mem, struct spi_mem_op
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(CLK)
+static int rockchip_sfc_clk_set_rate(struct rockchip_sfc *sfc, uint speed)
+{
+	if (sfc->version >= SFC_VER_8)
+		return clk_set_rate(&sfc->clk, speed * 2);
+	else
+		return clk_set_rate(&sfc->clk, speed);
+}
+#endif
+
 static int rockchip_sfc_set_speed(struct udevice *bus, uint speed)
 {
 	struct rockchip_sfc *sfc = dev_get_plat(bus);
@@ -600,7 +611,7 @@ static int rockchip_sfc_set_speed(struct udevice *bus, uint speed)
 		return 0;
 
 #if CONFIG_IS_ENABLED(CLK)
-	int ret = clk_set_rate(&sfc->clk, speed);
+	int ret = rockchip_sfc_clk_set_rate(sfc, speed);
 
 	if (ret < 0) {
 		dev_err(sfc->dev, "set_freq=%dHz fail, check if it's the cru support level\n",
-- 
2.51.0

