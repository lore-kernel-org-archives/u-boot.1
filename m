Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76E9CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31307846B5;
	Sun, 17 May 2026 21:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="wv5H5erp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA2CF84659; Sun, 17 May 2026 21:25:02 +0200 (CEST)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net
 [178.154.239.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6888684687
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward102b.mail.yandex.net (Yandex) with ESMTPS id EAFEDC0021;
 Sun, 17 May 2026 22:24:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-5B5zLFe3; 
 Sun, 17 May 2026 22:24:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045898; bh=8q35EGZmst3AHvHf7ey+J80yse7h56gpPuH0xEa3UXU=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=wv5H5erpNDUwe9nLki31anyVwJlb4Gej33p7mrM/5HD6lFd0p5Jp7nKGZ6CjkwJPS
 w6+yOWlDEMZn3AdRUEMbSp8OwaHUqzUTLereGLmbPsU7PjygfbqflyhQd4DUabBusL
 dopc7D+c7ICYZp/v2J3LNdt8cC7bMSkNODgMRRxw=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:32 +0300
Subject: [PATCH RFC 06/18] ram: rockchip: Add rk3568 lpddr4 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-6-a24e16302a13@ya.ru>
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

Add LPDDR4 detection timings for Rockchip RK3568 SoC.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 .../rockchip/sdram-rk3568-lpddr4-detect-1056.inc   | 79 ++++++++++++++++++++++
 .../rockchip/sdram-rk3568-lpddr4-detect-1184.inc   | 79 ++++++++++++++++++++++
 .../rockchip/sdram-rk3568-lpddr4-detect-1332.inc   | 79 ++++++++++++++++++++++
 .../rockchip/sdram-rk3568-lpddr4-detect-1560.inc   | 79 ++++++++++++++++++++++
 .../rockchip/sdram-rk3568-lpddr4-detect-324.inc    | 79 ++++++++++++++++++++++
 .../rockchip/sdram-rk3568-lpddr4-detect-396.inc    | 79 ++++++++++++++++++++++
 .../rockchip/sdram-rk3568-lpddr4-detect-528.inc    | 79 ++++++++++++++++++++++
 .../rockchip/sdram-rk3568-lpddr4-detect-630.inc    | 79 ++++++++++++++++++++++
 .../rockchip/sdram-rk3568-lpddr4-detect-780.inc    | 79 ++++++++++++++++++++++
 .../rockchip/sdram-rk3568-lpddr4-detect-920.inc    | 79 ++++++++++++++++++++++
 10 files changed, 790 insertions(+)

diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1056.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1056.inc
new file mode 100644
index 00000000000..fe9b5d92d08
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1056.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x40231420},
+			{0x15050b07},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 1056,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x004000c9},	/* RFSHTMG */
+			{0x00000068, 0x00300000},	/* RFSHTMG1 */
+			{0x000000d0, 0x00030409},	/* INIT0 */
+			{0x000000d4, 0x00690000},	/* INIT1 */
+			{0x000000d8, 0x00000206},	/* INIT2 */
+			{0x000000dc, 0x0034001b},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00230000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x14161117},	/* DRAMTMG0 */
+			{0x00000104, 0x00040421},	/* DRAMTMG1 */
+			{0x00000108, 0x050a0e0f},	/* DRAMTMG2 */
+			{0x0000010c, 0x00808000},	/* DRAMTMG3 */
+			{0x00000110, 0x0a04060a},	/* DRAMTMG4 */
+			{0x00000114, 0x02040808},	/* DRAMTMG5 */
+			{0x00000118, 0x01010005},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000401},	/* DRAMTMG7 */
+			{0x00000120, 0x00000808},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x0a100002},	/* DRAMTMG13 */
+			{0x00000138, 0x000000cd},	/* DRAMTMG14 */
+			{0x00000180, 0x02100010},	/* ZQCTL0 */
+			{0x00000184, 0x01b00000},	/* ZQCTL1 */
+			{0x00000190, 0x07070001},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0b050d3c},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x14000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x0a000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1184.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1184.inc
new file mode 100644
index 00000000000..506871f27ce
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1184.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x44271724},
+			{0x18060c09},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 1184,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x004800e1},	/* RFSHTMG */
+			{0x00000068, 0x00360000},	/* RFSHTMG1 */
+			{0x000000d0, 0x00030486},	/* INIT0 */
+			{0x000000d4, 0x00750000},	/* INIT1 */
+			{0x000000d8, 0x00000206},	/* INIT2 */
+			{0x000000dc, 0x00440024},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00230000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x16181319},	/* DRAMTMG0 */
+			{0x00000104, 0x00050524},	/* DRAMTMG1 */
+			{0x00000108, 0x060c1011},	/* DRAMTMG2 */
+			{0x0000010c, 0x00909000},	/* DRAMTMG3 */
+			{0x00000110, 0x0b04060b},	/* DRAMTMG4 */
+			{0x00000114, 0x02050909},	/* DRAMTMG5 */
+			{0x00000118, 0x01010006},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000501},	/* DRAMTMG7 */
+			{0x00000120, 0x00000909},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x0b100002},	/* DRAMTMG13 */
+			{0x00000138, 0x000000e6},	/* DRAMTMG14 */
+			{0x00000180, 0x02500012},	/* ZQCTL0 */
+			{0x00000184, 0x01e00000},	/* ZQCTL1 */
+			{0x00000190, 0x07090002},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0c060f48},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x18000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x0c000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1332.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1332.inc
new file mode 100644
index 00000000000..1d2bc4c22f1
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1332.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x462a1928},
+			{0x1b070d09},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 1332,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x005100fe},	/* RFSHTMG */
+			{0x00000068, 0x003c0000},	/* RFSHTMG1 */
+			{0x000000d0, 0x00030516},	/* INIT0 */
+			{0x000000d4, 0x00840000},	/* INIT1 */
+			{0x000000d8, 0x00000207},	/* INIT2 */
+			{0x000000dc, 0x00440024},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00230000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x171b161c},	/* DRAMTMG0 */
+			{0x00000104, 0x00050528},	/* DRAMTMG1 */
+			{0x00000108, 0x060c1012},	/* DRAMTMG2 */
+			{0x0000010c, 0x00a0a000},	/* DRAMTMG3 */
+			{0x00000110, 0x0c04070c},	/* DRAMTMG4 */
+			{0x00000114, 0x02050a0a},	/* DRAMTMG5 */
+			{0x00000118, 0x01010006},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000501},	/* DRAMTMG7 */
+			{0x00000120, 0x00000a0a},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x0b100002},	/* DRAMTMG13 */
+			{0x00000138, 0x00000103},	/* DRAMTMG14 */
+			{0x00000180, 0x029a0014},	/* ZQCTL0 */
+			{0x00000184, 0x02200000},	/* ZQCTL1 */
+			{0x00000190, 0x07090002},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0c060f48},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x18000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x0c000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1560.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1560.inc
new file mode 100644
index 00000000000..1afaec6fe11
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-1560.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x4d321f2f},
+			{0x1f080f0a},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 1560,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x005f0129},	/* RFSHTMG */
+			{0x00000068, 0x00470000},	/* RFSHTMG1 */
+			{0x000000d0, 0x000305f5},	/* INIT0 */
+			{0x000000d4, 0x009a0000},	/* INIT1 */
+			{0x000000d8, 0x00000208},	/* INIT2 */
+			{0x000000dc, 0x0054002d},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00230000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x1a201a21},	/* DRAMTMG0 */
+			{0x00000104, 0x00060630},	/* DRAMTMG1 */
+			{0x00000108, 0x070e1114},	/* DRAMTMG2 */
+			{0x0000010c, 0x00b0b000},	/* DRAMTMG3 */
+			{0x00000110, 0x0f04080f},	/* DRAMTMG4 */
+			{0x00000114, 0x02060c0c},	/* DRAMTMG5 */
+			{0x00000118, 0x01010007},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000601},	/* DRAMTMG7 */
+			{0x00000120, 0x00000b0b},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x0c100002},	/* DRAMTMG13 */
+			{0x00000138, 0x0000012f},	/* DRAMTMG14 */
+			{0x00000180, 0x030c0018},	/* ZQCTL0 */
+			{0x00000184, 0x02700000},	/* ZQCTL1 */
+			{0x00000190, 0x070b0003},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0d071154},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x1c000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x0e000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-324.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-324.inc
new file mode 100644
index 00000000000..0b796f8a0ae
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-324.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x2f0d060a},
+			{0x06020804},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 324,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x0013003e},	/* RFSHTMG */
+			{0x00000068, 0x000f0000},	/* RFSHTMG1 */
+			{0x000000d0, 0x0002013e},	/* INIT0 */
+			{0x000000d4, 0x00210000},	/* INIT1 */
+			{0x000000d8, 0x00000202},	/* INIT2 */
+			{0x000000dc, 0x00240012},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00000000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x0c070507},	/* DRAMTMG0 */
+			{0x00000104, 0x0003040a},	/* DRAMTMG1 */
+			{0x00000108, 0x0407090d},	/* DRAMTMG2 */
+			{0x0000010c, 0x00505000},	/* DRAMTMG3 */
+			{0x00000110, 0x03040203},	/* DRAMTMG4 */
+			{0x00000114, 0x02030303},	/* DRAMTMG5 */
+			{0x00000118, 0x01010004},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000301},	/* DRAMTMG7 */
+			{0x00000120, 0x00000303},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x00100002},	/* DRAMTMG13 */
+			{0x00000138, 0x0000003f},	/* DRAMTMG14 */
+			{0x00000180, 0x00a20005},	/* ZQCTL0 */
+			{0x00000184, 0x00900000},	/* ZQCTL1 */
+			{0x00000190, 0x07040000},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0905092c},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0e000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x08000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-396.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-396.inc
new file mode 100644
index 00000000000..8f2a3191329
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-396.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x3110080c},
+			{0x80208004},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 396,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x0018004c},	/* RFSHTMG */
+			{0x00000068, 0x00120000},	/* RFSHTMG1 */
+			{0x000000d0, 0x00020184},	/* INIT0 */
+			{0x000000d4, 0x00280000},	/* INIT1 */
+			{0x000000d8, 0x00000202},	/* INIT2 */
+			{0x000000dc, 0x00240012},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00000000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x0d080609},	/* DRAMTMG0 */
+			{0x00000104, 0x0003040d},	/* DRAMTMG1 */
+			{0x00000108, 0x0407090d},	/* DRAMTMG2 */
+			{0x0000010c, 0x00505000},	/* DRAMTMG3 */
+			{0x00000110, 0x04040204},	/* DRAMTMG4 */
+			{0x00000114, 0x02030303},	/* DRAMTMG5 */
+			{0x00000118, 0x01010004},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000301},	/* DRAMTMG7 */
+			{0x00000120, 0x00000404},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x00100002},	/* DRAMTMG13 */
+			{0x00000138, 0x0000004d},	/* DRAMTMG14 */
+			{0x00000180, 0x00c60006},	/* ZQCTL0 */
+			{0x00000184, 0x00a00000},	/* ZQCTL1 */
+			{0x00000190, 0x07040000},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0905092c},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0e000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x08000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-528.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-528.inc
new file mode 100644
index 00000000000..51c786e0ada
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-528.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x33130a10},
+			{0x0b030804},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 528,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x00200065},	/* RFSHTMG */
+			{0x00000068, 0x00180000},	/* RFSHTMG1 */
+			{0x000000d0, 0x00020205},	/* INIT0 */
+			{0x000000d4, 0x00350000},	/* INIT1 */
+			{0x000000d8, 0x00000203},	/* INIT2 */
+			{0x000000dc, 0x00240012},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00000000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x0e0b080c},	/* DRAMTMG0 */
+			{0x00000104, 0x00030411},	/* DRAMTMG1 */
+			{0x00000108, 0x0407090d},	/* DRAMTMG2 */
+			{0x0000010c, 0x00505000},	/* DRAMTMG3 */
+			{0x00000110, 0x05040305},	/* DRAMTMG4 */
+			{0x00000114, 0x02030404},	/* DRAMTMG5 */
+			{0x00000118, 0x01010004},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000301},	/* DRAMTMG7 */
+			{0x00000120, 0x00000505},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x00100002},	/* DRAMTMG13 */
+			{0x00000138, 0x00000067},	/* DRAMTMG14 */
+			{0x00000180, 0x01080008},	/* ZQCTL0 */
+			{0x00000184, 0x00e00000},	/* ZQCTL1 */
+			{0x00000190, 0x07040000},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0905092c},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0e000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x08000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-630.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-630.inc
new file mode 100644
index 00000000000..70084613475
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-630.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x35160c13},
+			{0x0d030805},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 630,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x00260078},	/* RFSHTMG */
+			{0x00000068, 0x001d0000},	/* RFSHTMG1 */
+			{0x000000d0, 0x00020269},	/* INIT0 */
+			{0x000000d4, 0x003f0000},	/* INIT1 */
+			{0x000000d8, 0x00000204},	/* INIT2 */
+			{0x000000dc, 0x00240012},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00000000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x0f0d0a0e},	/* DRAMTMG0 */
+			{0x00000104, 0x00030414},	/* DRAMTMG1 */
+			{0x00000108, 0x04070b0d},	/* DRAMTMG2 */
+			{0x0000010c, 0x00505000},	/* DRAMTMG3 */
+			{0x00000110, 0x06040406},	/* DRAMTMG4 */
+			{0x00000114, 0x02030505},	/* DRAMTMG5 */
+			{0x00000118, 0x01010004},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000301},	/* DRAMTMG7 */
+			{0x00000120, 0x00000505},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x00100002},	/* DRAMTMG13 */
+			{0x00000138, 0x0000007b},	/* DRAMTMG14 */
+			{0x00000180, 0x013b000a},	/* ZQCTL0 */
+			{0x00000184, 0x01000000},	/* ZQCTL1 */
+			{0x00000190, 0x07040000},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0a040b28},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0e000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x08000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-780.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-780.inc
new file mode 100644
index 00000000000..2df058f06fa
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-780.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x381a0f18},
+			{0x10040805},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 780,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x002f0095},	/* RFSHTMG */
+			{0x00000068, 0x00240000},	/* RFSHTMG1 */
+			{0x000000d0, 0x000202fb},	/* INIT0 */
+			{0x000000d4, 0x004e0000},	/* INIT1 */
+			{0x000000d8, 0x00000204},	/* INIT2 */
+			{0x000000dc, 0x00240012},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00000000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x10100c11},	/* DRAMTMG0 */
+			{0x00000104, 0x00030418},	/* DRAMTMG1 */
+			{0x00000108, 0x04070a0d},	/* DRAMTMG2 */
+			{0x0000010c, 0x00606000},	/* DRAMTMG3 */
+			{0x00000110, 0x08040408},	/* DRAMTMG4 */
+			{0x00000114, 0x02030606},	/* DRAMTMG5 */
+			{0x00000118, 0x01010004},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000301},	/* DRAMTMG7 */
+			{0x00000120, 0x00000606},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x00100002},	/* DRAMTMG13 */
+			{0x00000138, 0x00000098},	/* DRAMTMG14 */
+			{0x00000180, 0x0186000c},	/* ZQCTL0 */
+			{0x00000184, 0x01400000},	/* ZQCTL1 */
+			{0x00000190, 0x07040000},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0a040b28},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0e000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x08000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-920.inc b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-920.inc
new file mode 100644
index 00000000000..f253e4ccf5b
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-lpddr4-detect-920.inc
@@ -0,0 +1,79 @@
+{
+	{
+		{
+			.rank = 2,
+			.col = 10,
+			.bk = 3,
+			.bw = 2,
+			.dbw = 1,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 17,
+			.cs0_high16bit_row = 0,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x3d1e111c},
+			{0x12050a07},
+			{0x00000c04},
+			{0x00000000},
+			{0x00001111},
+			{0x00000054},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 920,	/* clock rate(MHz) */
+		.dramtype = LPDDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x8f080020},	/* MSTR */
+			{0x00000064, 0x003800af},	/* RFSHTMG */
+			{0x00000068, 0x002a0000},	/* RFSHTMG1 */
+			{0x000000d0, 0x00020384},	/* INIT0 */
+			{0x000000d4, 0x005b0000},	/* INIT1 */
+			{0x000000d8, 0x00000205},	/* INIT2 */
+			{0x000000dc, 0x0034001b},	/* INIT3 */
+			{0x000000e0, 0x00310000},	/* INIT4 */
+			{0x000000e8, 0x00230000},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x12130f14},	/* DRAMTMG0 */
+			{0x00000104, 0x0004041c},	/* DRAMTMG1 */
+			{0x00000108, 0x050a0e0f},	/* DRAMTMG2 */
+			{0x0000010c, 0x00707000},	/* DRAMTMG3 */
+			{0x00000110, 0x09040509},	/* DRAMTMG4 */
+			{0x00000114, 0x02040707},	/* DRAMTMG5 */
+			{0x00000118, 0x01010005},	/* DRAMTMG6 */
+			{0x0000011c, 0x00000401},	/* DRAMTMG7 */
+			{0x00000120, 0x00000707},	/* DRAMTMG8 */
+			{0x00000130, 0x00020000},	/* DRAMTMG12 */
+			{0x00000134, 0x0a100002},	/* DRAMTMG13 */
+			{0x00000138, 0x000000b3},	/* DRAMTMG14 */
+			{0x00000180, 0x01cc000e},	/* ZQCTL0 */
+			{0x00000184, 0x01700000},	/* ZQCTL1 */
+			{0x00000190, 0x07070001},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0b050d3c},	/* ODTCFG */
+			{0x00000244, 0x00000101},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fd7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x14000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x0a000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},

-- 
2.25.1

