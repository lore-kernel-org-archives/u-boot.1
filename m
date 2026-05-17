Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FD9CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41A1846CE;
	Sun, 17 May 2026 21:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="X1cYGldD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F9348466F; Sun, 17 May 2026 21:25:07 +0200 (CEST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net
 [178.154.239.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7903845E3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id 35A8B8088C;
 Sun, 17 May 2026 22:25:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-dEVrJKJn; 
 Sun, 17 May 2026 22:24:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045899; bh=0CTJschrOB71yUJDmrfE4ceOTVr9K5XFVT+HUK5XuAU=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=X1cYGldDWFVVmAU6tXgFWDswfb9DY8Ta2IEmFywVlP5rYEKde2mjPTK74DzNIvACW
 YMaZfnkRgXxDI6RwCDu2z/ZzaXDXQ0d8+Z/krMv+bibDJXe/7KVYW07VPmlBFjQXz0
 xqW0W+bzeaBYHuYtxNbzYciZSs0Uietdd+tyrBmE=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:33 +0300
Subject: [PATCH RFC 07/18] ram: rockchip: Add rk3568 ddr4 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-7-a24e16302a13@ya.ru>
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

Add DDR4 detection timings for Rockchip RK3568 SoC.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 .../ram/rockchip/sdram-rk3568-ddr4-detect-1056.inc | 75 ++++++++++++++++++++++
 .../ram/rockchip/sdram-rk3568-ddr4-detect-1184.inc | 75 ++++++++++++++++++++++
 .../ram/rockchip/sdram-rk3568-ddr4-detect-1332.inc | 75 ++++++++++++++++++++++
 .../ram/rockchip/sdram-rk3568-ddr4-detect-1560.inc | 75 ++++++++++++++++++++++
 .../ram/rockchip/sdram-rk3568-ddr4-detect-324.inc  | 75 ++++++++++++++++++++++
 .../ram/rockchip/sdram-rk3568-ddr4-detect-396.inc  | 75 ++++++++++++++++++++++
 .../ram/rockchip/sdram-rk3568-ddr4-detect-528.inc  | 75 ++++++++++++++++++++++
 .../ram/rockchip/sdram-rk3568-ddr4-detect-630.inc  | 75 ++++++++++++++++++++++
 .../ram/rockchip/sdram-rk3568-ddr4-detect-780.inc  | 75 ++++++++++++++++++++++
 .../ram/rockchip/sdram-rk3568-ddr4-detect-920.inc  | 75 ++++++++++++++++++++++
 10 files changed, 750 insertions(+)

diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1056.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1056.inc
new file mode 100644
index 00000000000..55fb5d8e376
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1056.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x561d1219},
+			{0x0b020703},
+			{0x00000002},
+			{0x0000023a},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 1056,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f041010},	/* MSTR */
+			{0x00000064, 0x008000b9},	/* RFSHTMG */
+			{0x000000d0, 0x00020103},	/* INIT0 */
+			{0x000000d4, 0x00690000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x07340201},	/* INIT3 */
+			{0x000000e0, 0x00100000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000800},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x0f0c2312},	/* DRAMTMG0 */
+			{0x00000104, 0x0004041a},	/* DRAMTMG1 */
+			{0x00000108, 0x0608060c},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x08030309},	/* DRAMTMG4 */
+			{0x00000114, 0x06060403},	/* DRAMTMG5 */
+			{0x00000120, 0x07070d07},	/* DRAMTMG8 */
+			{0x00000124, 0x00020209},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07060004},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000614},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x10000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x0b000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1184.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1184.inc
new file mode 100644
index 00000000000..838475cb95f
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1184.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x5921141c},
+			{0x0c020704},
+			{0x00000002},
+			{0x0000023a},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 1184,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f041010},	/* MSTR */
+			{0x00000064, 0x009000d0},	/* RFSHTMG */
+			{0x000000d0, 0x00020123},	/* INIT0 */
+			{0x000000d4, 0x00750000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x09400201},	/* INIT3 */
+			{0x000000e0, 0x00180000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000800},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x110d2813},	/* DRAMTMG0 */
+			{0x00000104, 0x0004041c},	/* DRAMTMG1 */
+			{0x00000108, 0x0609060d},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x0903030a},	/* DRAMTMG4 */
+			{0x00000114, 0x06060403},	/* DRAMTMG5 */
+			{0x00000120, 0x08080d08},	/* DRAMTMG8 */
+			{0x00000124, 0x0002020a},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07070004},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000618},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x12000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x0c000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1332.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1332.inc
new file mode 100644
index 00000000000..4fb1ba95e82
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1332.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x5c25171f},
+			{0x0e020904},
+			{0x00000002},
+			{0x0000024a},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 1332,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f041010},	/* MSTR */
+			{0x00000064, 0x00a200ea},	/* RFSHTMG */
+			{0x000000d0, 0x00020147},	/* INIT0 */
+			{0x000000d4, 0x00840000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x0b440201},	/* INIT3 */
+			{0x000000e0, 0x00200000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000c00},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x130e2d16},	/* DRAMTMG0 */
+			{0x00000104, 0x00040520},	/* DRAMTMG1 */
+			{0x00000108, 0x070a060e},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x0a04040b},	/* DRAMTMG4 */
+			{0x00000114, 0x07070404},	/* DRAMTMG5 */
+			{0x00000120, 0x09091109},	/* DRAMTMG8 */
+			{0x00000124, 0x0002020b},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07080005},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000618},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x14000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x0e000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1560.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1560.inc
new file mode 100644
index 00000000000..8643e96f18f
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-1560.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x622c1c25},
+			{0x10020a05},
+			{0x00000002},
+			{0x00000252},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 1560,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f041010},	/* MSTR */
+			{0x00000064, 0x00be0111},	/* RFSHTMG */
+			{0x000000d0, 0x0002017e},	/* INIT0 */
+			{0x000000d4, 0x009a0000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x0d540201},	/* INIT3 */
+			{0x000000e0, 0x00280000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00001000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x16113419},	/* DRAMTMG0 */
+			{0x00000104, 0x00050625},	/* DRAMTMG1 */
+			{0x00000108, 0x080c0710},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x0c04040d},	/* DRAMTMG4 */
+			{0x00000114, 0x08080504},	/* DRAMTMG5 */
+			{0x00000120, 0x0a0a110a},	/* DRAMTMG8 */
+			{0x00000124, 0x0002020c},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x070a0006},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000620},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x18000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x10000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-324.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-324.inc
new file mode 100644
index 00000000000..eed2e1948b3
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-324.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x4d110a08},
+			{0x0a020501},
+			{0x00000002},
+			{0x0000022a},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 324,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f049010},	/* MSTR */
+			{0x00000064, 0x00270039},	/* RFSHTMG */
+			{0x000000d0, 0x00020051},	/* INIT0 */
+			{0x000000d4, 0x00210000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x00040000},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x090a0a06},	/* DRAMTMG0 */
+			{0x00000104, 0x00020209},	/* DRAMTMG1 */
+			{0x00000108, 0x05050409},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x05020206},	/* DRAMTMG4 */
+			{0x00000114, 0x03030202},	/* DRAMTMG5 */
+			{0x00000120, 0x03030b03},	/* DRAMTMG8 */
+			{0x00000124, 0x00020208},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07030003},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000604},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0a000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x09000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-396.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-396.inc
new file mode 100644
index 00000000000..f3090af646f
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-396.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x4d110a0a},
+			{0x0a020501},
+			{0x00000002},
+			{0x0000022a},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 396,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f049010},	/* MSTR */
+			{0x00000064, 0x00300046},	/* RFSHTMG */
+			{0x000000d0, 0x00020062},	/* INIT0 */
+			{0x000000d4, 0x00280000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x00040000},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x090a0d07},	/* DRAMTMG0 */
+			{0x00000104, 0x0002020a},	/* DRAMTMG1 */
+			{0x00000108, 0x05050409},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x05020206},	/* DRAMTMG4 */
+			{0x00000114, 0x03030202},	/* DRAMTMG5 */
+			{0x00000120, 0x04040b04},	/* DRAMTMG8 */
+			{0x00000124, 0x00020208},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07030003},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000604},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0a000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x09000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-528.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-528.inc
new file mode 100644
index 00000000000..2ddf374880f
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-528.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x4d120a0d},
+			{0x0a020501},
+			{0x00000002},
+			{0x0000022a},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 528,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f049010},	/* MSTR */
+			{0x00000064, 0x0040005d},	/* RFSHTMG */
+			{0x000000d0, 0x00020082},	/* INIT0 */
+			{0x000000d4, 0x00350000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x00040000},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x0a0a110a},	/* DRAMTMG0 */
+			{0x00000104, 0x0002020e},	/* DRAMTMG1 */
+			{0x00000108, 0x05050409},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x05020206},	/* DRAMTMG4 */
+			{0x00000114, 0x03030202},	/* DRAMTMG5 */
+			{0x00000120, 0x04040b04},	/* DRAMTMG8 */
+			{0x00000124, 0x00020208},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07030003},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000604},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0a000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x09000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-630.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-630.inc
new file mode 100644
index 00000000000..659e38ab74e
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-630.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x4d130a10},
+			{0x0a020501},
+			{0x00000002},
+			{0x0000022a},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 630,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f041010},	/* MSTR */
+			{0x00000064, 0x004c006f},	/* RFSHTMG */
+			{0x000000d0, 0x0002009b},	/* INIT0 */
+			{0x000000d4, 0x003f0000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x01040201},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000000},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x0b0a150c},	/* DRAMTMG0 */
+			{0x00000104, 0x00020210},	/* DRAMTMG1 */
+			{0x00000108, 0x05050409},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x05020206},	/* DRAMTMG4 */
+			{0x00000114, 0x04040302},	/* DRAMTMG5 */
+			{0x00000120, 0x05050b05},	/* DRAMTMG8 */
+			{0x00000124, 0x00020208},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07030003},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000604},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0a000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x09000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-780.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-780.inc
new file mode 100644
index 00000000000..e7c6d75c528
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-780.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x50160d13},
+			{0x0a020502},
+			{0x00000002},
+			{0x0000022a},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 780,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f041010},	/* MSTR */
+			{0x00000064, 0x005f0089},	/* RFSHTMG */
+			{0x000000d0, 0x000200c0},	/* INIT0 */
+			{0x000000d4, 0x004e0000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x03140201},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000400},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x0c0a1a0e},	/* DRAMTMG0 */
+			{0x00000104, 0x00030314},	/* DRAMTMG1 */
+			{0x00000108, 0x0506050a},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x06030307},	/* DRAMTMG4 */
+			{0x00000114, 0x04040302},	/* DRAMTMG5 */
+			{0x00000120, 0x06060b06},	/* DRAMTMG8 */
+			{0x00000124, 0x00020208},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07040003},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0600060c},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0c000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x09000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-920.inc b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-920.inc
new file mode 100644
index 00000000000..0deab38f720
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rk3568-ddr4-detect-920.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 1,
+			.col = 10,
+			.bk = 2,
+			.bw = 1,
+			.dbw = 0,
+			.row_3_4 = 0,
+			.cs0_row = 17,
+			.cs1_row = 0,
+			.cs0_high16bit_row = 17,
+			.cs1_high16bit_row = 0,
+			.ddrconfig = 0
+		},
+		{
+			{0x531a0f17},
+			{0x0b020603},
+			{0x00000002},
+			{0x00000232},
+			{0x00001111},
+			{0x0000000c},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 920,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x4f041010},	/* MSTR */
+			{0x00000064, 0x007000a1},	/* RFSHTMG */
+			{0x000000d0, 0x000200e2},	/* INIT0 */
+			{0x000000d4, 0x00580000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x05240201},	/* INIT3 */
+			{0x000000e0, 0x00080000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000400},	/* INIT7 */
+			{0x000000f4, 0x000f022f},	/* RANKCTL */
+			{0x00000100, 0x0e0b1f10},	/* DRAMTMG0 */
+			{0x00000104, 0x00030317},	/* DRAMTMG1 */
+			{0x00000108, 0x0507050b},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x07030308},	/* DRAMTMG4 */
+			{0x00000114, 0x05050303},	/* DRAMTMG5 */
+			{0x00000120, 0x07070b07},	/* DRAMTMG8 */
+			{0x00000124, 0x00020209},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07050003},	/* DFITMG0 */
+			{0x00000198, 0x0a000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000610},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000000, 0x00001fc7},	/* DDRPHY_REG0 */
+			{0x00000008, 0x00000000},	/* DDRPHY_REG2 */
+			{0x0000000c, 0x0e000000},	/* DDRPHY_REG3 */
+			{0x00000010, 0x0a000000},	/* DDRPHY_REG4 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},

-- 
2.25.1

