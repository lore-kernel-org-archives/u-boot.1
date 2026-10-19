Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7670FCCF2D3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 05:41:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7E7B605F7;
	Mon, 19 Oct 2026 05:41:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zpBzQ79_NJ18; Mon, 19 Oct 2026 05:41:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 669E560606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792388463;
	b=nD/Q64BdudGxuzpTaTOxx5Vcp1+kJ6/+3UD3vlYd2dXvDGOsQugFgK7b2uV1nlRsKfGv
	 +ourOFMmGig+Pb7wLk/YM/x13kqVS5gllDV4Or3Lne0LgwiEvhDujuTB4VOoT5Llw5RTp
	 CNL9y/4yOelId6GEqnePCyqwgQqqcdveLPhcDt8HmOgWAqkL/W+eghQILAhCBeyi58Ar7
	 0NKN4J5zsDChHs+fB68oTex7E/ihPxtwZLsf111NSsaCL/ui6OVqsgkOToJ6nKDUJWssV
	 r2s2moLH+yhUaqLoHTkNwyksGbnfIA+ikfiVQRh5JWFnaeqQMnO3Kh/7oKQQd2tXV5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792388463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xtcuTUcaDRVV2CRw2tj/eaNPKITU/HYwKsNl3qBmyzQ=;
	b=gh3H8l2cPZ4j8t+Zdy2DXIZdqQn4Kl49UXHTVjF20XNs+T54nMYm3jkc1k5Wt5XFabS0
	 T3fOJ338XlKWsBalMttymT5ygJNaYoAyWjFLPhYEIFMyhreGCy8wYZuTPf+MHIxlgWQMH
	 VGN/CJNOUNxfHboyG+a2rsV7TLDRXesH0bqVc9DUfKBahZYFfKq3qd4s4c/2OWMziCDUg
	 2ul5AEsfDEsj9ziCD+Yis8pT6hnyVs8oH98QrlNQnKqv6NdoUlM0DGkommbZiO5A4Rcjr
	 pHxSAxT4J2wfx5lWljCyTbwj65/Oz3N7gv+8+t/VjGptuGuRU1ohwsWsLuCHkNOGobg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=aspeedtech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792388463;
	bh=xtcuTUcaDRVV2CRw2tj/eaNPKITU/HYwKsNl3qBmyzQ=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GhqPVK/xudDJho4saGbYyrdZWokHZtJZkyHg+WHXbq2NfdCfnBkxMQEu6oQgzvNsC
	 1/BYEDOpxiDb8qv5TkOJ3G8oT7KtDPws51lr4h7WKYXjlxU5htQBMq/cJFdIFqLX0Z
	 lwAmmiXOq/TEZnca4rZbyRCdRelFVRTCFbTBPiSo3kQf+kJ//+fOWHCw6ptBI2b2a9
	 oZpo7VHC3h1hqJFWDOnjjKgFvZkMfMUkielOOiiPYPGXLNIWwk6iywbFpT3Y5ACOog
	 IjPsr6S38Ti61stEwkpk1SJDUGEvGfU6bIEegCq2zWr52wAxn3JPF/TZNixX2qHPan
	 nE5ht42ReMAfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 669E560606;
	Mon, 19 Oct 2026 05:41:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E34271AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9E6860606
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3N9tCmQmw1uB for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 05:41:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D032605F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792388460;
 b=dfHMjAwzuVBy8lWh2HKzbcsrNockskuJ+WxuEooFVnVjjXYES7jFzpTzFVcsgtcCeWzh
 I+qug3Z/hQuV8tUzYShAHR3a63o+1f7XE6jWEktBFVNx7BycnIfnCSxBy30a1wxylKFwG
 7CwCz2CmRBd4068ZRnIWkowPg8LzJ9WPfcXPwf9y91hgeaoRbwtcw3H2eF4MhCtV0ZdxZ
 Mnn8tJcO+OFguq6eo1jxn50oIzETqj/lLZ8h3SiSbATRUoUbdB7Fx7Owy4UetQb21yts6
 24862NqPXV7PNBHOQQrtiPutXE5D2S2yXW02DvPoW1++hPLrkR6xmttJZ/KZZBrrNjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792388460;
 h=Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
 X-Change-ID:To:CC:X-Mailer;
 bh=xtcuTUcaDRVV2CRw2tj/eaNPKITU/HYwKsNl3qBmyzQ=;
 b=S4AhzjDAIOwMxPwaCSqAvjBjOn23ZfiKKyJIzjHALZzMmTxMvlHx7BxnK5GDCMDvvOkf
 jXBd+6FiCh38h7hstjIXPSlhaeqWqUZBppfAzGHtKQ23tLj9m3rv3lm4wO6X1Sn06M6QV
 bOdc7sdBME1OhvsqUkPZYK5B/ztE/CEd2vbEylk2ks6WzURFv8ndBasAxmlmrRS0+YUIJ
 jcgdNxXw1B60Y+0uvvJEBA7VjofUBJa9QiVu+hQ3sNWqGBSCsaUWKPVWr0EgDHvDgQhdB
 JO4HCPVjOvmyW2gp72cMyGD3YQYlxW6jBT+Nb0t+XTTAtZbDw9WdUnpNTuxRZJoKuqw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=cooper_huang@aspeedtech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D032605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:40:56 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 19 Oct
 2026 13:40:53 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 19 Oct 2026 13:40:53 +0800
From: Cooper Huang <cooper_huang@aspeedtech.com>
Date: Mon, 19 Oct 2026 13:40:38 +0800
Subject: [PATCH] spi: aspeed: Add read timing calibration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261019-spi-aspeed-calibration-v1-1-800d80c9939f@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAFWt1WoC/x2M0QqCUBAFf0X2uQXXMKlfiR5WPeZC3i53LQLx3
 9t6HJiZjRzF4HSpNip4m9szBcihomHWdAfbGExN3ZykljN7NlbPwMiDPqwvukbCR2k7kXbqAKG
 Ic8Fkn//4egvu1cEhp2H+7V7Z1wJdeFFLtO9f/xJl+YgAAAA=
X-Change-ID: 20261019-spi-aspeed-calibration-3157115f7ee1
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.u-boot-project.org>
CC: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, "Tom
 Rini" <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Tan Siewert
 <tan.siewert@9elements.com>, Vince Chang <vince_chang@aspeedtech.com>,
 "Cooper Huang" <cooper_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
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

At high SPI clock frequencies, the controller must delay the sampling
of the read data, and the right delay depends on the board. Port the
read timing calibration from the Linux driver: golden data is read at
HCLK/16, then the timing settings of each HCLK divider, from the
fastest one allowed down to HCLK/5, are scanned until the reads match.

Until the calibration is done, the flash is accessed at HCLK/16, as in
Linux, since faster settings may not work without the timing
compensation.

Compared to Linux:
- each setting is checked by reading 1KB twice, instead of 16KB ten
  times, to keep the boot time short.
- the AST2600 setting picked in the passing window is mapped back to
  the input delay that was tested. Linux writes the column index as
  the delay, which is one step off.

Based on the following Linux commits:
- eeaec1ea05c0 ("spi: aspeed: Calibrate read timings")
- 31dcc7e1f8a9 ("spi: aspeed: Update clock selection strategy")
- efb79de36e94 ("spi: aspeed: Improve timing calibration algorithm
  for AST2600 platform")

Link: https://git.kernel.org/torvalds/c/eeaec1ea05c0
Link: https://git.kernel.org/torvalds/c/31dcc7e1f8a9
Link: https://git.kernel.org/torvalds/c/efb79de36e94
Signed-off-by: Cooper Huang <cooper_huang@aspeedtech.com>
---
Tested on:
- AST2700 EVB (HCLK 200MHz): 50MHz selects HCLK/4; 100MHz fails at
  HCLK/2 and selects HCLK/3.
- AST2600 EVB (HCLK 200MHz): 50MHz selects HCLK/4; 100MHz selects
  HCLK/2.
- AST2500 EVB (HCLK 198MHz): 50MHz selects HCLK/4; 100MHz selects
  HCLK/2.
In all cases the flash content was verified with crc32 and Linux boots.
---
 drivers/spi/spi-aspeed-smc.c | 268 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 267 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index e60bd77387a..57156122e85 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -36,6 +36,15 @@
 #define CTRL_IO_MODE_CMD_WRITE  BIT(1)
 #define CTRL_STOP_ACTIVE        BIT(2)
 
+#define CALIBRATE_BUF_SIZE      SZ_1K
+#define CALIBRATE_REPEAT_COUNT  2
+#define CALIBRATE_MAX_HDIV      5
+
+#define TIMING_DELAY_DI         BIT(3)
+#define TIMING_DELAY_HCYCLE_MAX 5
+#define TIMING_DELAY_INPUT_MAX  16
+#define TIMING_MIN_PASS_WINDOW  5
+
 struct aspeed_spi_regs {
 	u32 conf;                       /* 0x00 CE Type Setting */
 	u32 ctrl;                       /* 0x04 CE Control */
@@ -85,12 +94,15 @@ struct aspeed_spi_info {
 	u32 max_bus_width;
 	u32 min_decoded_sz;
 	u32 clk_ctrl_mask;
+	u32 min_hdiv;
 	void (*set_4byte)(struct udevice *bus, u32 cs);
 	uintptr_t (*segment_start)(struct udevice *bus, u32 reg);
 	uintptr_t (*segment_end)(struct udevice *bus, u32 reg);
 	u32 (*segment_reg)(uintptr_t start, uintptr_t end);
 	int (*adjust_decoded_sz)(struct udevice *bus);
 	u32 (*get_clk_setting)(struct udevice *dev, uint hz);
+	int (*calibrate)(struct udevice *dev, u32 hdiv,
+			 const u8 *golden_buf, u8 *test_buf);
 };
 
 struct aspeed_spi_decoded_range {
@@ -724,6 +736,239 @@ static int aspeed_spi_exec_op_user_mode(struct spi_slave *slave,
 	return 0;
 }
 
+/* Read timing calibration, ported from the Linux driver */
+static bool aspeed_spi_check_reads(struct aspeed_spi_flash *flash,
+				   const u8 *golden_buf, u8 *test_buf)
+{
+	int i;
+
+	for (i = 0; i < CALIBRATE_REPEAT_COUNT; i++) {
+		memcpy_fromio(test_buf, (void __iomem *)flash->ahb_base,
+			      CALIBRATE_BUF_SIZE);
+		if (memcmp(test_buf, golden_buf, CALIBRATE_BUF_SIZE))
+			return false;
+	}
+
+	return true;
+}
+
+/* Check that enough words are neither all 0's nor all 1's */
+static bool aspeed_spi_check_calib_data(const u8 *buf, size_t len)
+{
+	const u32 *buf32 = (const u32 *)buf;
+	u32 cnt = 0;
+	size_t i;
+
+	for (i = 0; i < len / sizeof(u32); i++) {
+		if (buf32[i] != 0 && buf32[i] != 0xffffffff)
+			cnt++;
+	}
+
+	return cnt >= 64;
+}
+
+static u32 ast2400_fread_tpass(int i)
+{
+	return (i / 2) | ((i & 1) ? 0 : TIMING_DELAY_DI);
+}
+
+/* The timing register is shared by all CS, only CE0 is calibrated. */
+static int ast2400_spi_calibrate(struct udevice *dev, u32 hdiv,
+				 const u8 *golden_buf, u8 *test_buf)
+{
+	struct aspeed_spi_priv *priv = dev_get_priv(dev->parent);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	u32 cs = slave_plat->cs[0];
+	struct aspeed_spi_flash *flash = &priv->flashes[cs];
+	uintptr_t timing_reg = (uintptr_t)&priv->regs->timings[0];
+	u32 shift = (hdiv - 1) * 4;
+	u32 timing_base;
+	u32 timing_val;
+	int pass_cnt = 0;
+	int i;
+
+	/* Other CS reuse the CE0 timing, require three passes as well. */
+	if (cs != 0) {
+		for (i = 0; i < 3; i++) {
+			if (!aspeed_spi_check_reads(flash, golden_buf,
+						    test_buf))
+				return -EIO;
+		}
+
+		return 0;
+	}
+
+	/* The AST2400 SPI controller has its timing register at 0x14. */
+	if (priv->info == &ast2400_spi_info)
+		timing_reg = (uintptr_t)priv->regs + 0x14;
+
+	timing_base = readl(timing_reg) & ~(0xfu << shift);
+
+	for (i = 0; i < (TIMING_DELAY_HCYCLE_MAX + 1) * 2; i++) {
+		timing_val = ast2400_fread_tpass(i);
+		writel(timing_base | (timing_val << shift), timing_reg);
+
+		if (!aspeed_spi_check_reads(flash, golden_buf, test_buf)) {
+			pass_cnt = 0;
+			continue;
+		}
+
+		/* Use the middle one of three consecutive passing settings. */
+		if (++pass_cnt == 3) {
+			timing_val = ast2400_fread_tpass(i - 1);
+			writel(timing_base | (timing_val << shift), timing_reg);
+			return 0;
+		}
+	}
+
+	return -EIO;
+}
+
+/* Column 0 is without input delay, columns 1 to 16 are input delays 0 to 15 */
+static u32 ast2600_timing_val(int hcycle, int col)
+{
+	if (!col)
+		return hcycle;
+
+	return TIMING_DELAY_DI | hcycle | ((col - 1) << 4);
+}
+
+/*
+ * Each CS has its own timing register. Use the center of the longest
+ * passing window of input delays within a single HCLK cycle delay.
+ */
+static int ast2600_spi_calibrate(struct udevice *dev, u32 hdiv,
+				 const u8 *golden_buf, u8 *test_buf)
+{
+	struct aspeed_spi_priv *priv = dev_get_priv(dev->parent);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	u32 cs = slave_plat->cs[0];
+	struct aspeed_spi_flash *flash = &priv->flashes[cs];
+	u32 *timing_reg = &priv->regs->timings[cs];
+	u32 shift = (hdiv - 2) * 8;
+	u32 timing_base;
+	u32 timing_val;
+	int best_hcycle = 0;
+	int best_col = 0;
+	int best_len = 0;
+	int hcycle;
+	int start;
+	int col;
+
+	timing_base = readl(timing_reg) & ~(0xffu << shift);
+
+	for (hcycle = 0; hcycle <= TIMING_DELAY_HCYCLE_MAX; hcycle++) {
+		start = 0;
+
+		for (col = 0; col <= TIMING_DELAY_INPUT_MAX; col++) {
+			timing_val = ast2600_timing_val(hcycle, col);
+			writel(timing_base | (timing_val << shift), timing_reg);
+
+			if (!aspeed_spi_check_reads(flash, golden_buf,
+						    test_buf)) {
+				start = col + 1;
+				continue;
+			}
+
+			if (col - start + 1 > best_len) {
+				best_len = col - start + 1;
+				best_hcycle = hcycle;
+				best_col = start + best_len / 2;
+			}
+		}
+	}
+
+	if (best_len < TIMING_MIN_PASS_WINDOW)
+		return -EIO;
+
+	timing_val = ast2600_timing_val(best_hcycle, best_col);
+	writel(timing_base | (timing_val << shift), timing_reg);
+
+	return 0;
+}
+
+static bool aspeed_spi_need_calibration(struct udevice *dev)
+{
+	struct aspeed_spi_plat *plat = dev_get_plat(dev->parent);
+	struct aspeed_spi_priv *priv = dev_get_priv(dev->parent);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+
+	/* The calibration is done when the read direct mapping is created. */
+	return CONFIG_IS_ENABLED(SPI_DIRMAP) && priv->info->calibrate &&
+	       slave_plat->max_hz >= plat->hclk_rate / CALIBRATE_MAX_HDIV;
+}
+
+static int aspeed_spi_do_calibration(struct udevice *dev)
+{
+	struct udevice *bus = dev->parent;
+	struct aspeed_spi_plat *plat = dev_get_plat(bus);
+	struct aspeed_spi_priv *priv = dev_get_priv(bus);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	const struct aspeed_spi_info *info = priv->info;
+	u32 cs = slave_plat->cs[0];
+	struct aspeed_spi_flash *flash = &priv->flashes[cs];
+	uintptr_t ce_ctrl_reg = (uintptr_t)&priv->regs->ce_ctrl[cs];
+	u8 *golden_buf;
+	u8 *test_buf;
+	u32 clk_setting = 0;
+	u32 ctrl_val;
+	u32 hdiv;
+	int ret;
+
+	if (!aspeed_spi_need_calibration(dev))
+		return 0;
+
+	if (info == &ast2400_spi_info)
+		ce_ctrl_reg = (uintptr_t)&priv->regs->ctrl;
+
+	test_buf = malloc(CALIBRATE_BUF_SIZE * 2);
+	if (!test_buf)
+		return -ENOMEM;
+
+	golden_buf = test_buf + CALIBRATE_BUF_SIZE;
+
+	/* Read the golden data at HCLK/16. */
+	ctrl_val = flash->ce_ctrl_read & ~info->clk_ctrl_mask;
+	writel(ctrl_val, ce_ctrl_reg);
+	memcpy_fromio(golden_buf, (void __iomem *)flash->ahb_base,
+		      CALIBRATE_BUF_SIZE);
+
+	if (!aspeed_spi_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE)) {
+		dev_dbg(dev, "calibration area too uniform, skipped\n");
+		clk_setting = info->get_clk_setting(dev, slave_plat->max_hz);
+		goto out;
+	}
+
+	for (hdiv = info->min_hdiv; hdiv <= CALIBRATE_MAX_HDIV; hdiv++) {
+		u32 hdiv_freq = plat->hclk_rate / hdiv;
+
+		if (hdiv_freq > slave_plat->max_hz)
+			continue;
+
+		clk_setting = info->get_clk_setting(dev, hdiv_freq);
+		writel(ctrl_val | clk_setting, ce_ctrl_reg);
+
+		ret = info->calibrate(dev, hdiv, golden_buf, test_buf);
+		dev_dbg(dev, "HCLK/%u: %s\n", hdiv, ret ? "FAIL" : "PASS");
+		if (!ret)
+			break;
+	}
+
+	if (hdiv > CALIBRATE_MAX_HDIV) {
+		dev_warn(dev, "no good read timing found, using HCLK/16\n");
+		clk_setting = 0;
+	}
+
+out:
+	flash->ce_ctrl_user &= ~info->clk_ctrl_mask;
+	flash->ce_ctrl_user |= clk_setting;
+	flash->ce_ctrl_read = ctrl_val | clk_setting;
+	writel(flash->ce_ctrl_read, ce_ctrl_reg);
+	free(test_buf);
+
+	return 0;
+}
+
 static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	int ret = 0;
@@ -779,6 +1024,10 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 
 	writel(priv->flashes[cs].ce_ctrl_read, ce_ctrl_reg);
 
+	ret = aspeed_spi_do_calibration(dev);
+	if (ret)
+		return ret;
+
 	dev_dbg(dev, "read bus width: %d ce_ctrl_val: 0x%08x\n",
 		op_tmpl.data.buswidth, priv->flashes[cs].ce_ctrl_read);
 
@@ -1056,11 +1305,13 @@ static const struct aspeed_spi_info ast2400_fmc_info = {
 	.max_bus_width = 2,
 	.min_decoded_sz = 0x800000,
 	.clk_ctrl_mask = 0x00002f00,
+	.min_hdiv = 1,
 	.set_4byte = ast2400_fmc_chip_set_4byte,
 	.segment_start = ast2400_spi_segment_start,
 	.segment_end = ast2400_spi_segment_end,
 	.segment_reg = ast2400_spi_segment_reg,
 	.get_clk_setting = ast2400_get_clk_setting,
+	.calibrate = ast2400_spi_calibrate,
 };
 
 static const struct aspeed_spi_info ast2400_spi_info = {
@@ -1068,11 +1319,13 @@ static const struct aspeed_spi_info ast2400_spi_info = {
 	.max_bus_width = 2,
 	.min_decoded_sz = 0x800000,
 	.clk_ctrl_mask = 0x00000f00,
+	.min_hdiv = 1,
 	.set_4byte = ast2400_spi_chip_set_4byte,
 	.segment_start = ast2400_spi_segment_start,
 	.segment_end = ast2400_spi_segment_end,
 	.segment_reg = ast2400_spi_segment_reg,
 	.get_clk_setting = ast2400_get_clk_setting,
+	.calibrate = ast2400_spi_calibrate,
 };
 
 static const struct aspeed_spi_info ast2500_fmc_info = {
@@ -1080,12 +1333,14 @@ static const struct aspeed_spi_info ast2500_fmc_info = {
 	.max_bus_width = 2,
 	.min_decoded_sz = 0x800000,
 	.clk_ctrl_mask = 0x00002f00,
+	.min_hdiv = 1,
 	.set_4byte = ast2500_spi_chip_set_4byte,
 	.segment_start = ast2500_spi_segment_start,
 	.segment_end = ast2500_spi_segment_end,
 	.segment_reg = ast2500_spi_segment_reg,
 	.adjust_decoded_sz = ast2500_adjust_decoded_size,
 	.get_clk_setting = ast2500_get_clk_setting,
+	.calibrate = ast2400_spi_calibrate,
 };
 
 /*
@@ -1097,12 +1352,14 @@ static const struct aspeed_spi_info ast2500_spi_info = {
 	.max_bus_width = 2,
 	.min_decoded_sz = 0x800000,
 	.clk_ctrl_mask = 0x00002f00,
+	.min_hdiv = 1,
 	.set_4byte = ast2500_spi_chip_set_4byte,
 	.segment_start = ast2500_spi_segment_start,
 	.segment_end = ast2500_spi_segment_end,
 	.segment_reg = ast2500_spi_segment_reg,
 	.adjust_decoded_sz = ast2500_adjust_decoded_size,
 	.get_clk_setting = ast2500_get_clk_setting,
+	.calibrate = ast2400_spi_calibrate,
 };
 
 static const struct aspeed_spi_info ast2600_fmc_info = {
@@ -1110,12 +1367,14 @@ static const struct aspeed_spi_info ast2600_fmc_info = {
 	.max_bus_width = 4,
 	.min_decoded_sz = 0x200000,
 	.clk_ctrl_mask = 0x0f000f00,
+	.min_hdiv = 2,
 	.set_4byte = ast2600_spi_chip_set_4byte,
 	.segment_start = ast2600_spi_segment_start,
 	.segment_end = ast2600_spi_segment_end,
 	.segment_reg = ast2600_spi_segment_reg,
 	.adjust_decoded_sz = ast2600_adjust_decoded_size,
 	.get_clk_setting = ast2600_get_clk_setting,
+	.calibrate = ast2600_spi_calibrate,
 };
 
 static const struct aspeed_spi_info ast2600_spi_info = {
@@ -1123,12 +1382,14 @@ static const struct aspeed_spi_info ast2600_spi_info = {
 	.max_bus_width = 4,
 	.min_decoded_sz = 0x200000,
 	.clk_ctrl_mask = 0x0f000f00,
+	.min_hdiv = 2,
 	.set_4byte = ast2600_spi_chip_set_4byte,
 	.segment_start = ast2600_spi_segment_start,
 	.segment_end = ast2600_spi_segment_end,
 	.segment_reg = ast2600_spi_segment_reg,
 	.adjust_decoded_sz = ast2600_adjust_decoded_size,
 	.get_clk_setting = ast2600_get_clk_setting,
+	.calibrate = ast2600_spi_calibrate,
 };
 
 static const struct aspeed_spi_info ast2700_fmc_info = {
@@ -1136,12 +1397,14 @@ static const struct aspeed_spi_info ast2700_fmc_info = {
 	.max_bus_width = 4,
 	.min_decoded_sz = 0x10000,
 	.clk_ctrl_mask = 0x0f000f00,
+	.min_hdiv = 2,
 	.set_4byte = ast2700_spi_chip_set_4byte,
 	.segment_start = ast2700_spi_segment_start,
 	.segment_end = ast2700_spi_segment_end,
 	.segment_reg = ast2700_spi_segment_reg,
 	.adjust_decoded_sz = ast2700_adjust_decoded_size,
 	.get_clk_setting = ast2600_get_clk_setting,
+	.calibrate = ast2600_spi_calibrate,
 };
 
 static const struct aspeed_spi_info ast2700_spi_info = {
@@ -1149,12 +1412,14 @@ static const struct aspeed_spi_info ast2700_spi_info = {
 	.max_bus_width = 4,
 	.min_decoded_sz = 0x10000,
 	.clk_ctrl_mask = 0x0f000f00,
+	.min_hdiv = 2,
 	.set_4byte = ast2700_spi_chip_set_4byte,
 	.segment_start = ast2700_spi_segment_start,
 	.segment_end = ast2700_spi_segment_end,
 	.segment_reg = ast2700_spi_segment_reg,
 	.adjust_decoded_sz = ast2700_adjust_decoded_size,
 	.get_clk_setting = ast2600_get_clk_setting,
+	.calibrate = ast2600_spi_calibrate,
 };
 
 static int aspeed_spi_claim_bus(struct udevice *dev)
@@ -1167,7 +1432,8 @@ static int aspeed_spi_claim_bus(struct udevice *dev)
 
 	dev_dbg(bus, "%s: claim bus CS%u\n", bus->name, slave_plat->cs[0]);
 
-	if (flash->max_freq == 0) {
+	/* Stay at HCLK/16 until the read timing is calibrated. */
+	if (flash->max_freq == 0 && !aspeed_spi_need_calibration(dev)) {
 		clk_setting = priv->info->get_clk_setting(dev, slave_plat->max_hz);
 		flash->ce_ctrl_user &= ~(priv->info->clk_ctrl_mask);
 		flash->ce_ctrl_user |= clk_setting;

---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261019-spi-aspeed-calibration-3157115f7ee1

Best regards,
-- 
Cooper Huang <cooper_huang@aspeedtech.com>

