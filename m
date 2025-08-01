Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFDAC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9752883B4E;
	Fri,  1 Aug 2025 22:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="h3l0E+pH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781B583B4F; Fri,  1 Aug 2025 22:34:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DCAF83A92
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754080435; bh=/oQKvX1PIVOdGWIiDQ4DHiTL12lwA9avqoLog0ZyTpI=;
 b=h3l0E+pHUHXoZUUWE3eNBFpJN9TNn0cWVklR6dBGlLwESxkt0xw1ukSVRFNNscDp6ynzmWcw6
 jqnlG/h54jAVhHa73/ryZjJo6NvXXC2B0c1/naYQZUksxh0VkqNh38wBuISgBkw+c9eEY7Vj52D
 coVvNEyBWHgcoQ4IR3m6cGS034iDBEPjjKo3ACb6/QsX/bFF9VHh0hmCIgAscRm4vBxJyOUxHll
 r24LjCQhodkNi7qxja0dHqIen9ntw9Dd+SpX/pNnWDiFdo9X/boLeGs/t3wCYaAie23ZZAXCuI1
 6E/jIaZK3I+nizK/RyBkQ8BAnN8AUTj11kh/AewtWkYg==
X-Forward-Email-ID: 688d249703c11ad401760993
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v3 8/8] phy: rockchip: usbdp: Add support for RK3576
Date: Fri,  1 Aug 2025 20:32:44 +0000
Message-ID: <20250801203255.2590535-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801203255.2590535-1-jonas@kwiboo.se>
References: <20250801203255.2590535-1-jonas@kwiboo.se>
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

From: Frank Wang <frank.wang@rock-chips.com>

Add support for the USB3.0+DP PHY used in the RK3576 SoC.

Config values are taken from vendor U-Boot linux-6.1-stan-rkr5 tag.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 6cfbef02b4ac..cca67dd3611d 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -762,6 +762,28 @@ static const char * const rk3588_udphy_rst_l[] = {
 	"init", "cmn", "lane", "pcs_apb", "pma_apb"
 };
 
+static const struct rockchip_udphy_cfg rk3576_udphy_cfgs = {
+	.num_phys = 1,
+	.phy_ids = {
+		0x2b010000,
+	},
+	.num_rsts = ARRAY_SIZE(rk3588_udphy_rst_l),
+	.rst_list = rk3588_udphy_rst_l,
+	.grfcfg	= {
+		/* u2phy-grf */
+		.bvalid_phy_con		= { 0x0010, 1, 0, 0x2, 0x3 },
+		.bvalid_grf_con		= { 0x0000, 15, 14, 0x1, 0x3 },
+
+		/* usb-grf */
+		.usb3otg0_cfg		= { 0x0030, 15, 0, 0x1100, 0x0188 },
+
+		/* usbdpphy-grf */
+		.low_pwrn		= { 0x0004, 13, 13, 0, 1 },
+		.rx_lfps		= { 0x0004, 14, 14, 0, 1 },
+	},
+	.combophy_init = rk3588_udphy_init,
+};
+
 static const struct rockchip_udphy_cfg rk3588_udphy_cfgs = {
 	.num_phys = 2,
 	.phy_ids = {
@@ -787,6 +809,10 @@ static const struct rockchip_udphy_cfg rk3588_udphy_cfgs = {
 };
 
 static const struct udevice_id rockchip_udphy_dt_match[] = {
+	{
+		.compatible = "rockchip,rk3576-usbdp-phy",
+		.data = (ulong)&rk3576_udphy_cfgs
+	},
 	{
 		.compatible = "rockchip,rk3588-usbdp-phy",
 		.data = (ulong)&rk3588_udphy_cfgs
-- 
2.50.1

