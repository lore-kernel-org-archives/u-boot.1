Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EA4CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B597846C7;
	Sun, 17 May 2026 21:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="GdlejNuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B39884688; Sun, 17 May 2026 21:25:06 +0200 (CEST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net
 [178.154.239.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8AC8465A
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id 57C49805FB;
 Sun, 17 May 2026 22:25:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-uVnQ5lmH; 
 Sun, 17 May 2026 22:25:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045901; bh=MniuOkd43mbnfeI1gt/jq7cEHFLmcxW4lHPKCysu998=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=GdlejNuog6AOWtSDLle3cVTyQqlLl1L0xWNeWQKv+fx1ZPflEQ2KzYEgnhGrMdLx7
 +thnnwnYj3rZZOc7PE40xHUxem0ImLzo1cm3EzP97fcJAIs1NvdCV17LAfQk2256YP
 imkwoCdnNCXY9Sw1iVhj1Tgx+kh3S3OD1qhSwJkg=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:34 +0300
Subject: [PATCH RFC 08/18] ram: rockchip: Add rk3568 ddr loader params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-8-a24e16302a13@ya.ru>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
In-Reply-To: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>, 
 Pavel Golikov <paullo612@ya.ru>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 17 May 2026 21:26:22 +0200
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

Add DDR loader parameters for Rockchip RK3568 SoC.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 .../ram/rockchip/sdram-rk3568-loader_params.inc    | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/ram/rockchip/sdram-rk3568-loader_params.inc b/drivers/ram/rockchip/sdram-rk3568-loader_params.inc
new file mode 100644
index 00000000000..d9beea3519a
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-loader_params.inc
@@ -0,0 +1,109 @@
+0x12345678,
+2, /* version */
+(0  << 0) | (1  << 8) | (9  << 16) | (8 << 24), /* cpu_gen,global index */
+(0  << 0) | (0  << 8) | (0  << 16) | (0 << 24), /* d2,d3 index */
+(17 << 0) | (9  << 8) | (0  << 16) | (0 << 24), /* d4,d5 index */
+(0  << 0) | (0  << 8) | (0  << 16) | (0 << 24), /* lp2,lp3 index */
+(26 << 0) | (13 << 8) | (0  << 16) | (0 << 24), /* lp4,lp5 index */
+(0  << 0) | (0  << 8) | (39 << 16) | (8 << 24), /* skew index, dq_map index */
+(0  << 0) | (0  << 8) | (0  << 16) | (0 << 24), /*lp4x index*/
+/* global info */
+0,
+(93 << 16) | 13,/* sr_idle << 16 | pd_idle */
+0,/* channel info */
+(1 << 26) | 1, /* derate, 2t info */
+0, /* reserved */
+(0 << 3), /* pageclose */
+0, 0, /* reserved */
+
+/* ddr4 */
+(1560 << DDR_FREQ_F0_SHIFT) | (324 << DDR_FREQ_F1_SHIFT),
+(528 << DDR_FREQ_F2_SHIFT) | (780 << DDR_FREQ_F3_SHIFT),
+(0 << DDR_FREQ_F4_SHIFT) | (0 << DDR_FREQ_F5_SHIFT),
+/* drv when odt on */
+(37 << PHY_DQ_DRV_SHIFT) | (37 << PHY_CA_DRV_SHIFT) |
+	(37 << PHY_CLK_DRV_SHIFT) | (34 << DRAM_DQ_DRV_SHIFT),
+/* drv when odt off */
+(37 << PHY_DQ_DRV_SHIFT) | (37 << PHY_CA_DRV_SHIFT) |
+	(37 << PHY_CLK_DRV_SHIFT) | (34 << DRAM_DQ_DRV_SHIFT),
+/* odt info */
+(120 << DRAM_ODT_SHIFT) | (139 << PHY_ODT_SHIFT) |
+	(1 << PHY_ODT_PUUP_EN_SHIFT) | (1 << PHY_ODT_PUDN_EN_SHIFT),
+/* odt enable freq */
+(625 << DRAM_ODT_EN_FREQ_SHIFT) | (625 << PHY_ODT_EN_FREQ_SHIFT),
+/* slew rate when odt enable */
+(0x0 << PHY_DQ_SR_SHIFT) | (0x1 << PHY_CA_SR_SHIFT) |
+	(0x1 << PHY_CLK_SR_SHIFT),
+/* slew  ratee when odt disable */
+(0x0 << PHY_DQ_SR_SHIFT) | (0x1 << PHY_CA_SR_SHIFT) |
+	(0x1 << PHY_CLK_SR_SHIFT),
+
+/* lpddr4 */
+(1560 << DDR_FREQ_F0_SHIFT) | (324 << DDR_FREQ_F1_SHIFT),
+(528 << DDR_FREQ_F2_SHIFT) | (780 << DDR_FREQ_F3_SHIFT),
+(0 << DDR_FREQ_F4_SHIFT) | (0 << DDR_FREQ_F5_SHIFT),
+
+/* drv when odt on */
+(30 << PHY_DQ_DRV_SHIFT) | (38 << PHY_CA_DRV_SHIFT) |
+	(38 << PHY_CLK_DRV_SHIFT) | (40 << DRAM_DQ_DRV_SHIFT),
+/* drv when odt off */
+(30 << PHY_DQ_DRV_SHIFT) | (38 << PHY_CA_DRV_SHIFT) |
+	(38 << PHY_CLK_DRV_SHIFT) | (40 << DRAM_DQ_DRV_SHIFT),
+/* odt info and PU-cal info */
+(80 << DRAM_ODT_SHIFT) | (60 << PHY_ODT_SHIFT) |
+	(120 << LP4_CA_ODT_SHIFT) |
+	(LPDDR4_VDDQ_3 << LP4_DRV_PU_CAL_ODTEN_SHIFT) |
+	(LPDDR4_VDDQ_3 << LP4_DRV_PU_CAL_ODTOFF_SHIFT) |
+	(0 << PHY_LP4_DRV_PULLDOWN_EN_ODTEN_SHIFT) |
+	(0 << PHY_LP4_DRV_PULLDOWN_EN_ODTOFF_SHIFT),
+/* odt enable freq */
+(800 << PHY_LP4_ODT_EN_FREQ_SHIFT) | (800 << LP4_DQ_ODT_EN_FREQ_SHIFT),
+/* slew rate when odt enable */
+(0 << PHY_DQ_SR_SHIFT) | (0 << PHY_CA_SR_SHIFT) |
+	(0 << PHY_CLK_SR_SHIFT),
+/* slew  rate when odt disable */
+(0 << PHY_DQ_SR_SHIFT) | (0 << PHY_CA_SR_SHIFT) |
+	(0 << PHY_CLK_SR_SHIFT),
+/* ca odt en freq */
+(800 << LP4_CA_ODT_EN_FREQ_SHIFT),
+/* cs drv info and ca odt info */
+(0 << PHY_LP4_CS_DRV_ODTEN_SHIFT) |
+	(0 << PHY_LP4_CS_DRV_ODTOFF_SHIFT) |
+	(1 << LP4_ODTE_CK_SHIFT) | (1 << LP4_ODTE_CS_EN_SHIFT) |
+	(0 << LP4_ODTD_CA_EN_SHIFT),
+/* vref info when odt enable */
+(166 << PHY_LP4_DQ_VREF_SHIFT) | (300 << LP4_DQ_VREF_SHIFT) |
+	(380 << LP4_CA_VREF_SHIFT),
+/* vref info when odt disable */
+(420 << PHY_LP4_DQ_VREF_SHIFT) | (420 << LP4_DQ_VREF_SHIFT) |
+	(420 << LP4_CA_VREF_SHIFT),
+
+/* ddr4 map << 0 | ddr3 map << 24 */
+((0x3 << 6) | (0x2 << 4) | (0x1 << 2) | (0x0 << 0)) | (0 << 8) | (0 << 16),
+/* lp3 map << 16 | lp4 map << 24 */
+((0x3 << 6) | (0x2 << 4) | (0x1 << 2) | (0x0 << 0)) << 24,
+/* lp3 dq0-7 map */
+0,
+/* lp2 dq0-7 map */
+0,
+/* ddr4 dq map */
+/* cs0 dq0-15 */
+	((0 << 0 | 2 << 2 | 0 << 4 | 2 << 6) << 0) |
+	((3 << 0 | 1 << 2 | 3 << 4 | 1 << 6) << 8) |
+	((3 << 0 | 1 << 2 | 3 << 4 | 1 << 6) << 16) |
+	((2 << 0 | 0 << 2 | 2 << 4 | 0 << 6) << 24),
+/* cs0 dq16-31 */
+	((3 << 0 | 1 << 2 | 3 << 4 | 1 << 6) << 0) |
+	((0 << 0 | 2 << 2 | 0 << 4 | 2 << 6) << 8) |
+	((0 << 0 | 2 << 2 | 0 << 4 | 2 << 6) << 16) |
+	((1 << 0 | 3 << 2 | 3 << 4 | 1 << 6) << 24),
+/* cs1 dq0-15 */
+	((0 << 0 | 2 << 2 | 0 << 4 | 2 << 6) << 0) |
+	((3 << 0 | 1 << 2 | 3 << 4 | 1 << 6) << 8) |
+	((3 << 0 | 1 << 2 | 3 << 4 | 1 << 6) << 16) |
+	((2 << 0 | 0 << 2 | 2 << 4 | 0 << 6) << 24),
+/* cs1 dq16-31 */
+	((3 << 0 | 1 << 2 | 3 << 4 | 1 << 6) << 0) |
+	((0 << 0 | 2 << 2 | 0 << 4 | 2 << 6) << 8) |
+	((0 << 0 | 2 << 2 | 0 << 4 | 2 << 6) << 16) |
+	((1 << 0 | 3 << 2 | 3 << 4 | 1 << 6) << 24),

-- 
2.25.1

