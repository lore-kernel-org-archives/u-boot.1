Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7E4CA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06A9360BCF;
	Fri,  2 Oct 2026 16:47:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rtdtWlpjfyr4; Fri,  2 Oct 2026 16:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C6AB60D87
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959658;
	b=VIXWw7vdfmJRtagfmUXsY4dnvxgQgE3qfXjn8Z8GP3ezScePT+HNGL6CPZcogqM1mxxo
	 pgZ+LlfrXLUiLkqGZb9xSUsq3X3m26kWUL4Pq/otprRKe4qoIewCThCqM3uqZTLsPB+79
	 M5bj7q12C7S9bu6SYC5Jp332vLe4YfAPkYsJvdSuWoTWyP/apF7s5eItRn5yWQuCQPfsC
	 BrUGro+OnFqV4iXXR7njAUvkqgBeo072LlrNoxItZqQRnYs9NdLv+TMKLtfN/yx194Ebi
	 MAzHodK2op+9iYB/OmHrsBE0UWI5RjkdzWUEYIDe/jvE6iDaqD4BWcPVEOugn7Ax+kQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5cCRVsQaXGftXjzo909Hqh/K3ir75g+KWW423zhHPsw=;
	b=TK115zCxaAoRPgoL8TlWO3IM7ShNXucGDAIf21Vwgf8j0HTiuMqwaz+zgnAL6jcjB+H7
	 iUcNc9f/v7BMk7YvcE9m2VgUlGNhZ2LNkvVGFM6JA9jA612QXEzCxA1eWD0MHF5sGIxfg
	 pDaUWEL8mPwnFUM7bc1rK/dX2WS7OH23vf9BqL4lBsQ/Lxn7L1bJK1RSMP20ruM5/6P4S
	 dq47ve0hVTtQJU+1iVc8J037nrAoLgt7Z6EbWPbx0vlGKcvv6pvBxaGOURecODs6K0HGe
	 YhMbZWogW/xrQnU2HirQe5XQGbhRpOmLfSP6ngx9Ogp5DXTKnS+E+q2MVb2FPIfDyqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959658;
	bh=5cCRVsQaXGftXjzo909Hqh/K3ir75g+KWW423zhHPsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1PPcn8f9oZrtKaa5Dw0IYpzdiU9Q0OdZR9lblNLdsJDOyyg/SSw1+Mjkz8VFS6a1L
	 kf9JVDpLOv533Ey7teKYf/yM3cvrgJrov201/ig0q4s/IO7WvRCvdCo9wxa8wMhqiR
	 5WsYud/V+ycMlyKwpVkeSoGkhj0VHIjUG5vcr3E4NoKaxOeOwwb1ZsL2IKMgP1/gzx
	 vFR+FsEqTXCC9bhi1eYg4Yz6+XWQ4D5+BhlLAZJxNsiAI4xf5YQXgU6AHIL7w3F/TK
	 UIwb1YhCmFC+XVcH+rbv/pHN7MQkkkazIcPhv8XLmvqt4xw71CGsFRnw2f96pbjjbW
	 nRybiYnSid1Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C6AB60D87;
	Fri,  2 Oct 2026 16:47:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5023D32F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42372812AB
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OC-ndySI6eom for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AF2AE81291
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946875;
 b=O7epQjAUudXX2RxRVQzwmUqcy596gC0odUOSU7/NgD1qw8vx9R9VslkQ4n14z5l6E4HY
 PI5G/7FYR+LiLypARk8ldEL3JuVseXeQWqxd9BrtsiSwJ2n6MBd+kt6j+KIBh7j8BSqDR
 A+3f1+dJ5SP9lPAlTXS/XcZAsZgIRqEgIlqxjiBilv++Cj3bICvoGxLeEVCP2SZBnYk3g
 alu8bJ/Zj+OW/13ISKjnwMqIrQdbq1liezRH8euVceAh0D8RqvTo8/iCol5YdBjAXQbyp
 TroYkX/gQ2Kt4wEVUgBB01Y91VfSTE9YvTw9R7nu5H9jOFqBKkhmNXffRJ+nRCBdDxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946875;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=5cCRVsQaXGftXjzo909Hqh/K3ir75g+KWW423zhHPsw=;
 b=mkcdAl2ZbwsPT75Oub2ZznknR71/DNb1HXM2ne+d/5j+ZvqdPfm34i0VXBuhyaUcoBEf
 5Yg2iUZfDCbcBFUuoa6ruPu+6aKhC4bT9PP31/E/TQVptqg0UMcNW4Knv4QYVz/IFXkKd
 ON3SDU7gelwNbpfB1UTWWCoJ1FE+RJdwm/gMdBCbKilnnBLbQ1Pc8v9qa0IjWKWyKTcoG
 6/Rza5xrFd0AzaovSI/axXIoYNjfi89vSjfqwT4lOzSZYbpjMSpE91DyAk45QozHhxvnq
 jLgdHwQ9h1TX+cOZfZEHgrzmrq6xOInbE4Eh0xqJicSeFnaDLrK/ZTytaoy2DP1KY0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=yPvwAhNv; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=yPvwAhNv
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF2AE81291
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7DB7C1A10E3;
 Fri,  2 Oct 2026 13:14:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 50889603DC;
 Fri,  2 Oct 2026 13:14:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 312CE1032820F; 
 Fri,  2 Oct 2026 15:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946869; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5cCRVsQaXGftXjzo909Hqh/K3ir75g+KWW423zhHPsw=;
 b=yPvwAhNvHAUGl5LGzZtP0JBgZ+Q74acbR+g/u0BXCM3u416SqJG7VCZU/pdIxZ7McbvDG0
 RKBy8RGsPggUcU4Uilu1ZBLp7cx1D+WGy9fcgbPfNN3B3a9EHghRm1UqS6Ur3fMZ4tCdqe
 Y/hAqK/Z2Q2wY41J1yud1LFYsQTazwzS1sv6WozRx6ZNAQaHHnvFRJjw5HTrmjV/L6ZzsH
 ZA1plogeYoLVQ2OoaYLdow7+4w1+ajIqPKMp9nUVdhs44e17F9BI4M14wFtKRgvab+H4G5
 rtdSiF0OMDcM6BuuNxGvp5/SBpwsWJQJ5z2xDSZ0ntLgROR4UKvGZtN5TURDUA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:25 +0200
Subject: [PATCH 07/10] ram: metanoia: Add driver for MT2824 DDR controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-7-bc44cf0e0289@bootlin.com>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
In-Reply-To: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
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

Add a DDR controller driver for the Metanoia MT2824 SoC, supporting
initialization and training of the DDR subsystem in SPL, and implementing
the driver-model for the RAM uclass.

The driver relies on a firmware to configure the DDR controller, and
expects the firmware to be found via a device tree reg entry named "fw".

The driver expects the DDR firmware to be packaged inside a FIT image,
as the firmware node of the default configuration, and it supports signed
FIT image.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/ram/Kconfig      |   7 +
 drivers/ram/Makefile     |   2 +
 drivers/ram/mt2824-ddr.c | 706 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 715 insertions(+)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index acd6d9cfd6a..feb1754e40e 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -139,6 +139,13 @@ config K3_MULTI_DDR
 	  responsible for interleaving between the controllers.
 	default y if SOC_K3_J721S2 || SOC_K3_J784S4
 
+config SPL_METANOIA_MT2824_DDR
+	bool "Metanoia MT2824 DDR driver in SPL"
+	depends on SPL_RAM
+	help
+	   Enable support for the internal DDR Memory Controller
+	   of the Metanoia MT2824 SoC in the SPL.
+
 source "drivers/ram/aspeed/Kconfig"
 source "drivers/ram/cadence/Kconfig"
 source "drivers/ram/octeon/Kconfig"
diff --git a/drivers/ram/Makefile b/drivers/ram/Makefile
index 82afd5fcbcc..6e1b86127ce 100644
--- a/drivers/ram/Makefile
+++ b/drivers/ram/Makefile
@@ -19,6 +19,8 @@ obj-$(CONFIG_K3_DDRSS) += k3-ddrss/
 
 obj-$(CONFIG_IMXRT_SDRAM) += imxrt_sdram.o
 
+obj-$(CONFIG_SPL_METANOIA_MT2824_DDR) += mt2824-ddr.o
+
 obj-$(CONFIG_RAM_SIFIVE) += sifive/
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_STARFIVE_DDR) += starfive/
diff --git a/drivers/ram/mt2824-ddr.c b/drivers/ram/mt2824-ddr.c
new file mode 100644
index 00000000000..c01c30089ca
--- /dev/null
+++ b/drivers/ram/mt2824-ddr.c
@@ -0,0 +1,706 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <image.h>
+#include <ram.h>
+#include <reset.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <u-boot/crc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* controller registers */
+#define CTRL_STAT				0x00000004
+#define CTRL_PWRCTL				0x00000030
+#define CTRL_RFSHCTL3				0x00000060
+#define CTRL_INIT7				0x000000ec
+#define CTRL_DFITMG0				0x00000190
+#define CTRL_DFITMG1				0x00000194
+#define CTRL_DFIMISC				0x000001b0
+#define CTRL_DFISTAT				0x000001bc
+#define CTRL_SWCTL				0x00000320
+#define CTRL_SWSTAT				0x00000324
+
+#define CTRL_STAT_MODE				GENMASK(2, 0)
+#define CTRL_STAT_NORMAL			1
+
+#define CTRL_PWRCTL_SELFREF			BIT(5)
+#define CTRL_PWRCTL_CLKDIS			BIT(3)
+#define CTRL_PWRCTL_PWRDN			BIT(1)
+
+#define CTRL_RFSHCTL3_DIS_AUTO			BIT(0)
+
+#define CTRL_INIT7_MR22				GENMASK(31, 16)
+#define CTRL_INIT7_MR14				GENMASK(15, 0)
+
+#define CTRL_DFITMG0_CTRL_DELAY			GENMASK(28, 24)
+#define CTRL_DFITMG0_RDDATA_USE_DFI_PHY_CLK	BIT(23)
+#define CTRL_DFITMG0_RDDATA_EN			GENMASK(22, 16)
+#define CTRL_DFITMG0_WRDATA_USE_DFI_PHY_CLK	BIT(15)
+#define CTRL_DFITMG0_TPHY_WRDATA		GENMASK(13, 8)
+#define CTRL_DFITMG0_TPHY_WRLAT			GENMASK(5, 0)
+
+#define CTRL_DFITMG1_WRDATA_DELAY		GENMASK(20, 16)
+#define CTRL_DFITMG1_CLK_DIS			GENMASK(12, 8)
+#define CTRL_DFITMG1_CLK_EN			GENMASK(4, 0)
+
+#define CTRL_DFIMISC_START			BIT(5)
+#define CTRL_DFIMISC_COMPLETE			BIT(0)
+
+#define CTRL_DFISTAT_COMPLETE			BIT(0)
+
+#define CTRL_SWCTL_DONE				BIT(0)
+#define CTRL_SWSTAT_DONE			BIT(0)
+
+/* PHY registers */
+#define PHY_DQS_DELAY_GRP0			0x000201a0
+#define PHY_RDPTR_INITVAL			0x0004005c
+#define PHY_ICCM_BASE				0x000a0000
+#define PHY_DCCM_BASE				0x000a8000
+#define PHY_DCCM_V26				0x000a804c
+#define PHY_DCCM_V27				0x000a804e
+#define PHY_DCCM_V40				0x000a8080
+#define PHY_PMU_MUX_SEL				0x001a0000
+#define PHY_UCTSHADOWREGS			0x001a0008
+#define PHY_DCTWRITEPROT			0x001a0062
+#define PHY_UCTWRITEONLYSHADOW			0x001a0064
+#define PHY_UCTDATWRITEONLYSHADOW		0x001a0068
+#define PHY_UC_CTRL				0x001a0132
+
+#define PHY_DQS_DELAY_COARSE			GENMASK(9, 6)
+#define PHY_DQS_DELAY_FINE			GENMASK(4, 0)
+
+#define PHY_ICCM_SIZE				0x00008000
+#define PHY_DCCM_SIZE				0x00002000
+
+#define PHY_PMU_MUX_SEL_UC			BIT(0)
+
+#define PHY_UC_CTRL_RESET			BIT(3)
+#define PHY_UC_CTRL_STALL			BIT(0)
+
+/* DDR parameters */
+#define PARAM_BL				16
+#define PARAM_CLK_DIS				2
+#define PARAM_CLK_EN				2
+#define PARAM_MISC				0
+#define PARAM_MR22				5
+#define PARAM_RD				0
+#define PARAM_RL				28
+#define PARAM_TDQSS				1
+#define PARAM_WL				14
+#define PARAM_WR				0
+#define PARAM_WRDATA				2
+
+#define TRAINING_STAGES				2
+
+#define POLL_TIMEOUT				1000000
+
+#define MSG_TRAINING_DONE			0x07
+#define MSG_TRAINING_FAIL			0xff
+
+#define FW_MAGIC				0x44445246 /* "DDRF" */
+#define FW_VERSION				0x01000000
+
+/* Base address used in the firmware for the controller */
+#define CTRL_FW_BASE				0x10060000
+
+enum {
+	FW_COMP_CTRL_CFG = 0,
+	FW_COMP_PHY_CFG,
+	FW_COMP_PMU_1D_IMEM,
+	FW_COMP_PMU_1D_DMEM,
+	FW_COMP_PMU_2D_IMEM,
+	FW_COMP_PMU_2D_DMEM,
+	FW_COMP_PIE_IMAGE,
+	FW_COMP_MAX
+};
+
+struct fw_comp {
+	u32 offset;
+	u32 size;
+	u32 crc32;
+	u32 reserved;
+};
+
+struct fw_header {
+	u32 magic;
+	u32 version;
+	u32 header_size;
+	u32 total_size;
+	u32 flags;
+	u32 timestamp;
+	u32 reserved1;
+	u32 reserved2;
+	struct fw_comp comps[FW_COMP_MAX];
+	u32 header_crc32;
+	u32 reserved[27]; /* Padding to 256 bytes */
+};
+
+struct fw_reg {
+	u32 addr;
+	u32 value;
+};
+
+struct mt2824_ddr_priv {
+	void __iomem *ctrl;
+	resource_size_t ctrl_size;
+	void __iomem *phy;
+	resource_size_t phy_size;
+	void *fw;
+	resource_size_t fw_size;
+	struct reset_ctl rst;
+	const void *fw_img;
+};
+
+static int get_fw_img_from_fit(const void *fit, size_t fit_size,
+			       const void **fw_img, size_t *fw_size)
+{
+	int conf_noffset;
+	const char *img_name;
+	int img_noffset;
+
+	if (fit_check_format(fit, fit_size))
+		return -EINVAL;
+
+	conf_noffset = fit_conf_get_node(fit, NULL);
+	if (conf_noffset < 0)
+		return -EINVAL;
+
+	printf("## Checking hash(es) for config %s ... ",
+	       fit_get_name(fit, conf_noffset, NULL));
+	if (fit_config_verify(fit, conf_noffset))
+		return -EPERM;
+	puts("OK\n");
+
+	img_name = fdt_getprop(fit, conf_noffset, FIT_FIRMWARE_PROP, NULL);
+	if (!img_name)
+		return -EINVAL;
+
+	img_noffset = fit_image_get_node(fit, img_name);
+	if (img_noffset < 0)
+		return -EINVAL;
+
+	if (fit_image_get_emb_data(fit, img_noffset, fw_img, fw_size))
+		return -EINVAL;
+
+	printf("## Checking hash(es) for image %s ... ", img_name);
+	if (!fit_image_verify_with_data(fit, img_noffset, gd_fdt_blob(), *fw_img, *fw_size))
+		return -EPERM;
+	puts("OK\n");
+
+	return 0;
+}
+
+static int check_firmware(struct udevice *dev)
+{
+	struct mt2824_ddr_priv *priv = dev_get_priv(dev);
+	const struct fw_header *header;
+	u32 calculated_crc;
+	int ret = 0;
+	size_t fw_size;
+
+	ret = get_fw_img_from_fit(priv->fw, priv->fw_size, &priv->fw_img, &fw_size);
+	if (ret)
+		return ret;
+
+	header = priv->fw_img;
+
+	if (header->magic != FW_MAGIC) {
+		dev_err(dev, "Invalid firmware magic: 0x%08x (expected 0x%08x)\n",
+			header->magic, FW_MAGIC);
+		return -EINVAL;
+	}
+
+	if (header->version != FW_VERSION) {
+		dev_err(dev, "Invalid firmware version %u\n", header->version);
+		return -EINVAL;
+	}
+
+	if (header->header_size != sizeof(struct fw_header)) {
+		dev_err(dev, "Invalid firmware header size %u\n", header->header_size);
+		return -EINVAL;
+	}
+
+	if (header->total_size > fw_size) {
+		dev_err(dev, "firmware too big\n");
+		return -EINVAL;
+	}
+
+	calculated_crc = crc32(0, priv->fw_img, offsetof(struct fw_header, header_crc32));
+	if (calculated_crc != header->header_crc32) {
+		dev_err(dev, "Header CRC mismatch: calculated=0x%08x, expected=0x%08x\n",
+			calculated_crc, header->header_crc32);
+		return -EINVAL;
+	}
+
+	for (int i = 0; i < FW_COMP_MAX; i++) {
+		u32 offset = header->comps[i].offset;
+		u32 size = header->comps[i].size;
+		u32 expected_crc = header->comps[i].crc32;
+
+		if (size == 0) {
+			dev_err(dev, "Component #%d is empty\n", i);
+			ret = -EINVAL;
+			continue;
+		}
+
+		if ((resource_size_t)offset + size > fw_size) {
+			dev_err(dev, "Component #%d out of range\n", i);
+			ret = -EINVAL;
+			continue;
+		}
+
+		calculated_crc = crc32(0, priv->fw_img + offset, size);
+		if (calculated_crc != expected_crc) {
+			dev_err(dev, "Component #%d CRC verification failed\n", i);
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static int ddr_ctrl_load_config(struct mt2824_ddr_priv *priv)
+{
+	const struct fw_header *header = priv->fw_img;
+	const struct fw_reg *reg;
+	unsigned int nb_regs;
+	u32 addr;
+
+	/* address + value per register */
+	nb_regs = header->comps[FW_COMP_CTRL_CFG].size / sizeof(struct fw_reg);
+	reg = priv->fw_img + header->comps[FW_COMP_CTRL_CFG].offset;
+
+	/* Apply each register configuration */
+	for (unsigned int i = 0; i < nb_regs; i++, reg++) {
+		addr = reg->addr;
+
+		/*
+		 * Some firmware version use an absolute address,
+		 * convert to a relative offset
+		 */
+		if (addr >= CTRL_FW_BASE)
+			addr -= CTRL_FW_BASE;
+
+		if (addr >= priv->ctrl_size)
+			return -EINVAL;
+
+		writel(reg->value, priv->ctrl + addr);
+	}
+
+	return 0;
+}
+
+static int ddr_ctrl_init(struct mt2824_ddr_priv *priv)
+{
+	u32 val;
+
+	setbits_le32(priv->ctrl + CTRL_RFSHCTL3, CTRL_RFSHCTL3_DIS_AUTO);
+	clrbits_le32(priv->ctrl + CTRL_PWRCTL, CTRL_PWRCTL_PWRDN | CTRL_PWRCTL_CLKDIS);
+	writel(0, priv->ctrl + CTRL_SWCTL);
+	clrbits_le32(priv->ctrl + CTRL_DFIMISC, CTRL_DFIMISC_COMPLETE);
+	setbits_le32(priv->ctrl + CTRL_SWCTL, CTRL_SWCTL_DONE);
+
+	return readl_poll_timeout(priv->ctrl + CTRL_SWSTAT, val,
+				  val == CTRL_SWSTAT_DONE, POLL_TIMEOUT);
+}
+
+static int ddr_phy_load_comp(struct mt2824_ddr_priv *priv, unsigned int comp)
+{
+	const struct fw_header *header = priv->fw_img;
+	const struct fw_reg *reg;
+	unsigned int nb_regs;
+
+	/* address + value per register */
+	nb_regs = header->comps[comp].size / sizeof(struct fw_reg);
+	reg = priv->fw_img + header->comps[comp].offset;
+
+	/* Apply each register configuration */
+	for (unsigned int i = 0; i < nb_regs; i++, reg++) {
+		if (reg->addr >= priv->phy_size / 2)
+			return -EINVAL;
+		writew((u16)(reg->value & 0xFFFF), priv->phy + reg->addr * 2);
+	}
+
+	return 0;
+}
+
+static int phy_load_training_data(struct mt2824_ddr_priv *priv, unsigned int comp,
+				  void __iomem *base, resource_size_t size)
+{
+	const struct fw_header *header = priv->fw_img;
+	unsigned int nb_vals;
+	const u16 *val;
+
+	if (header->comps[comp].size > size)
+		return -EINVAL;
+
+	nb_vals = header->comps[comp].size / sizeof(u16);
+	val = priv->fw_img + header->comps[comp].offset;
+
+	for (unsigned int i = 0; i < nb_vals; i++) {
+		writew(*val, base + i * 2);
+		val++;
+	}
+
+	return 0;
+}
+
+static u32 get_mail(struct mt2824_ddr_priv *priv, int mode)
+{
+	u32 mail;
+	u16 val;
+
+	readw_poll_sleep_timeout(priv->phy + PHY_UCTSHADOWREGS, val,
+				 !(val & BIT(0)), mode ? 0 : 100, 0);
+
+	mail = readw(priv->phy + PHY_UCTWRITEONLYSHADOW);
+	if (mode == 1)
+		mail |= (readw(priv->phy + PHY_UCTDATWRITEONLYSHADOW) << 16);
+
+	writew(0, priv->phy + PHY_DCTWRITEPROT);
+	readw_poll_timeout(priv->phy + PHY_UCTSHADOWREGS, val, val, 0);
+	writew(1, priv->phy + PHY_DCTWRITEPROT);
+
+	return mail;
+}
+
+static void decode_streaming_message(struct mt2824_ddr_priv *priv)
+{
+	u32 msg_len = get_mail(priv, 1) & 0xffff;
+
+	for (unsigned int i = 0; i < msg_len; i++)
+		get_mail(priv, 1);
+}
+
+static void decode_major_message(struct mt2824_ddr_priv *priv, u32 mail)
+{
+	switch (mail) {
+	case MSG_TRAINING_DONE:
+		debug("DDRPHY: Training has run successfully\n");
+		break;
+	case MSG_TRAINING_FAIL:
+		debug("DDRPHY: Training has failed\n");
+		break;
+	case 0x00:
+		debug("DDRPHY: End of initialization\n");
+		break;
+	case 0x01:
+		debug("DDRPHY: End of fine write leveling\n");
+		break;
+	case 0x02:
+		debug("DDRPHY: End of read enable training\n");
+		break;
+	case 0x03:
+		debug("DDRPHY: End of read delay center optimization\n");
+		break;
+	case 0x04:
+		debug("DDRPHY: End of write delay center optimization\n");
+		break;
+	case 0x05:
+		debug("DDRPHY: End of 2D read delay/voltage center optimization\n");
+		break;
+	case 0x06:
+		debug("DDRPHY: End of 2D write delay/voltage center optimization\n");
+		break;
+	case 0x09:
+		debug("DDRPHY: End of max read latency training\n");
+		break;
+	case 0x0a:
+		debug("DDRPHY: End of read dq deskew training\n");
+		break;
+	case 0x0b:
+		debug("DDRPHY: Reserved\n");
+		break;
+	case 0x0c:
+		debug("DDRPHY: End of all DB training (MREP/DWL/MRD/MWD complete)\n");
+		break;
+	case 0x0d:
+		debug("DDRPHY: End of CA training\n");
+		break;
+	case 0xfd:
+		debug("DDRPHY: End of MPR read delay center optimization\n");
+		break;
+	case 0xfe:
+		debug("DDRPHY: End of Write leveling coarse delay\n");
+		break;
+	case 0x08:
+		debug("DDRPHY: Start streaming message mode\n");
+		decode_streaming_message(priv);
+		break;
+	default:
+		debug("DDRPHY: Error, unknown major_message %x\n", mail);
+	}
+}
+
+static int ddr_phy_wait_training_done(struct mt2824_ddr_priv *priv)
+{
+	u32 mail = 0;
+
+	do {
+		mail = get_mail(priv, 0);
+		decode_major_message(priv, mail);
+	} while (mail != MSG_TRAINING_DONE && mail != MSG_TRAINING_FAIL);
+
+	return (mail == MSG_TRAINING_DONE) ? 0 : -EIO;
+}
+
+static void write_mr14_to_register(struct mt2824_ddr_priv *priv)
+{
+	u16 v26 = readw(priv->phy + PHY_DCCM_V26);
+	u16 v27 = readw(priv->phy + PHY_DCCM_V27);
+	u16 v40 = readw(priv->phy + PHY_DCCM_V40);
+
+	u8 b0 = (v26 >> 8) & 0xff;
+	u8 b1 = v27 & 0xff;
+	u8 b2 = v40 & 0xff;
+	u8 b3 = (v40 >> 8) & 0xff;
+
+	u32 sum = (u32)b0 + b1 + b2 + b3;
+	u8 avg = (sum + 2) / 4;
+
+	writel(FIELD_PREP(CTRL_INIT7_MR22, PARAM_MR22) | FIELD_PREP(CTRL_INIT7_MR14, avg),
+	       priv->ctrl + CTRL_INIT7);
+}
+
+static int ddr_phy_training(struct mt2824_ddr_priv *priv)
+{
+	struct {
+		unsigned int imem_comp;
+		unsigned int dmem_comp;
+	} fw_info[TRAINING_STAGES] = {
+		{FW_COMP_PMU_1D_IMEM, FW_COMP_PMU_1D_DMEM},
+		{FW_COMP_PMU_2D_IMEM, FW_COMP_PMU_2D_DMEM}
+	};
+	int ret;
+
+	for (unsigned int stage = 0; stage < TRAINING_STAGES; stage++) {
+		ret = phy_load_training_data(priv, fw_info[stage].imem_comp,
+					     priv->phy + PHY_ICCM_BASE, PHY_ICCM_SIZE);
+		if (ret)
+			return ret;
+
+		writew(PHY_PMU_MUX_SEL_UC, priv->phy + PHY_PMU_MUX_SEL);
+		writew(0, priv->phy + PHY_PMU_MUX_SEL);
+
+		ret = phy_load_training_data(priv, fw_info[stage].dmem_comp,
+					     priv->phy + PHY_DCCM_BASE, PHY_DCCM_SIZE);
+		if (ret)
+			return ret;
+
+		/*
+		 * MicroContMuxSel=1, written twice to match the PhyInit
+		 * sequence (end of DMEM load and start of the firmware).
+		 */
+		writew(PHY_PMU_MUX_SEL_UC, priv->phy + PHY_PMU_MUX_SEL);
+		writew(PHY_PMU_MUX_SEL_UC, priv->phy + PHY_PMU_MUX_SEL);
+
+		writew(PHY_UC_CTRL_RESET | PHY_UC_CTRL_STALL, priv->phy + PHY_UC_CTRL);
+		writew(PHY_UC_CTRL_STALL, priv->phy + PHY_UC_CTRL);
+		writew(0, priv->phy + PHY_UC_CTRL);
+
+		ret = ddr_phy_wait_training_done(priv);
+		if (ret)
+			return ret;
+
+		writew(PHY_UC_CTRL_STALL, priv->phy + PHY_UC_CTRL);
+		writew(0, priv->phy + PHY_PMU_MUX_SEL);
+
+		if (stage == 1)
+			write_mr14_to_register(priv);
+
+		writew(PHY_PMU_MUX_SEL_UC, priv->phy + PHY_PMU_MUX_SEL);
+		writew(0, priv->phy + PHY_PMU_MUX_SEL);
+	}
+
+	return 0;
+}
+
+static int ddr_ctrl_configure(struct mt2824_ddr_priv *priv)
+{
+	u8 trddata_en = PARAM_RL - 5 + 2 * (PARAM_MISC - PARAM_RD);
+	u8 tphy_wrlat = PARAM_WL - 5 + 2 * (PARAM_MISC - PARAM_WR) + PARAM_TDQSS;
+	u8 twrdata_delay;
+	u8 tctrl_delay;
+	u8 ardptrinitval;
+	u16 dqs_dly;
+	u8 trained_txdqsdly;
+	u32 val;
+	int ret;
+
+	clrbits_le32(priv->ctrl + CTRL_SWCTL, CTRL_SWCTL_DONE);
+	setbits_le32(priv->ctrl + CTRL_DFIMISC, CTRL_DFIMISC_START);
+	setbits_le32(priv->ctrl + CTRL_SWCTL, CTRL_SWCTL_DONE);
+
+	ret = readl_poll_timeout(priv->ctrl + CTRL_SWSTAT, val,
+				 val == CTRL_SWSTAT_DONE, POLL_TIMEOUT);
+	if (ret)
+		return ret;
+
+	ret = readl_poll_timeout(priv->ctrl + CTRL_DFISTAT, val,
+				 FIELD_GET(CTRL_DFISTAT_COMPLETE, val), POLL_TIMEOUT);
+	if (ret)
+		return ret;
+
+	clrbits_le32(priv->ctrl + CTRL_SWCTL, CTRL_SWCTL_DONE);
+	clrbits_le32(priv->ctrl + CTRL_DFIMISC, CTRL_DFIMISC_START);
+	setbits_le32(priv->ctrl + CTRL_DFIMISC, CTRL_DFIMISC_COMPLETE);
+	clrbits_le32(priv->ctrl + CTRL_PWRCTL, CTRL_PWRCTL_SELFREF);
+
+	writew(0, priv->phy + PHY_PMU_MUX_SEL);
+
+	/* read the trained DQS delay and round it up */
+	dqs_dly = readw(priv->phy + PHY_DQS_DELAY_GRP0);
+	trained_txdqsdly = FIELD_GET(PHY_DQS_DELAY_COARSE, dqs_dly) +
+			   (FIELD_GET(PHY_DQS_DELAY_FINE, dqs_dly) +
+			    FIELD_MAX(PHY_DQS_DELAY_FINE)) /
+			   (FIELD_MAX(PHY_DQS_DELAY_FINE) + 1);
+
+	ardptrinitval = readw(priv->phy + PHY_RDPTR_INITVAL);
+	tctrl_delay = ((ardptrinitval / 2) + (PARAM_MISC * 2) * 1 + 3);
+	twrdata_delay = tctrl_delay + (6 + PARAM_BL / 2) + trained_txdqsdly;
+
+	writew(PHY_PMU_MUX_SEL_UC, priv->phy + PHY_PMU_MUX_SEL);
+
+	writel(FIELD_PREP(CTRL_DFITMG0_CTRL_DELAY, tctrl_delay) |
+	       CTRL_DFITMG0_RDDATA_USE_DFI_PHY_CLK |
+	       FIELD_PREP(CTRL_DFITMG0_RDDATA_EN, trddata_en) |
+	       CTRL_DFITMG0_WRDATA_USE_DFI_PHY_CLK |
+	       FIELD_PREP(CTRL_DFITMG0_TPHY_WRDATA, PARAM_WRDATA) |
+	       FIELD_PREP(CTRL_DFITMG0_TPHY_WRLAT, tphy_wrlat),
+	       priv->ctrl + CTRL_DFITMG0);
+
+	writel(FIELD_PREP(CTRL_DFITMG1_WRDATA_DELAY, twrdata_delay) |
+	       FIELD_PREP(CTRL_DFITMG1_CLK_DIS, PARAM_CLK_DIS) |
+	       FIELD_PREP(CTRL_DFITMG1_CLK_EN, PARAM_CLK_EN),
+	       priv->ctrl + CTRL_DFITMG1);
+
+	setbits_le32(priv->ctrl + CTRL_DFIMISC, CTRL_DFIMISC_COMPLETE);
+
+	clrbits_le32(priv->ctrl + CTRL_PWRCTL, CTRL_PWRCTL_SELFREF);
+
+	setbits_le32(priv->ctrl + CTRL_SWCTL, CTRL_SWCTL_DONE);
+	ret = readl_poll_timeout(priv->ctrl + CTRL_SWSTAT, val,
+				 val == CTRL_SWSTAT_DONE, POLL_TIMEOUT);
+	if (ret)
+		return ret;
+
+	ret = readl_poll_timeout(priv->ctrl + CTRL_STAT, val,
+				 FIELD_GET(CTRL_STAT_MODE, val) == CTRL_STAT_NORMAL,
+				 POLL_TIMEOUT);
+	if (ret)
+		return ret;
+
+	clrbits_le32(priv->ctrl + CTRL_RFSHCTL3, CTRL_RFSHCTL3_DIS_AUTO);
+
+	return 0;
+}
+
+static int mt2824_ddr_init(struct udevice *dev)
+{
+	struct mt2824_ddr_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = check_firmware(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_assert(&priv->rst);
+	if (ret)
+		return ret;
+
+	ret = ddr_ctrl_load_config(priv);
+	if (ret)
+		return ret;
+
+	ret = reset_deassert(&priv->rst);
+	if (ret)
+		return ret;
+
+	ret = ddr_ctrl_init(priv);
+	if (ret)
+		return ret;
+
+	ret = ddr_phy_load_comp(priv, FW_COMP_PHY_CFG);
+	if (ret)
+		return ret;
+
+	ret = ddr_phy_training(priv);
+	if (ret)
+		return ret;
+
+	ret = ddr_phy_load_comp(priv, FW_COMP_PIE_IMAGE);
+	if (ret)
+		return ret;
+
+	ret = ddr_ctrl_configure(priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mt2824_ddr_probe(struct udevice *dev)
+{
+	struct mt2824_ddr_priv *priv = dev_get_priv(dev);
+	struct resource res;
+	int ret;
+
+	ret = dev_read_resource_byname(dev, "ctrl", &res);
+	if (ret)
+		return ret;
+
+	priv->ctrl_size = resource_size(&res);
+	priv->ctrl = devm_ioremap(dev, res.start, priv->ctrl_size);
+
+	ret = dev_read_resource_byname(dev, "phy", &res);
+	if (ret)
+		return ret;
+
+	priv->phy_size = resource_size(&res);
+	priv->phy = devm_ioremap(dev, res.start, priv->phy_size);
+
+	ret = dev_read_resource_byname(dev, "fw", &res);
+	if (ret)
+		return ret;
+
+	priv->fw_size = resource_size(&res);
+	priv->fw = devm_ioremap(dev, res.start, priv->fw_size);
+
+	ret = reset_get_by_index(dev, 0, &priv->rst);
+	if (ret)
+		return ret;
+
+	return mt2824_ddr_init(dev);
+}
+
+static int mt2824_ddr_get_info(struct udevice *dev, struct ram_info *info)
+{
+	info->base = gd->ram_base;
+	info->size = gd->ram_size;
+
+	return 0;
+}
+
+static const struct ram_ops mt2824_ddr_ops = {
+	.get_info = mt2824_ddr_get_info,
+};
+
+static const struct udevice_id mt2824_ddr_ids[] = {
+	{ .compatible = "metanoia,mt2824-ddrc" },
+	{ }
+};
+
+U_BOOT_DRIVER(mt2824_ddr) = {
+	.name = "mt2824_ddr",
+	.id = UCLASS_RAM,
+	.ops = &mt2824_ddr_ops,
+	.of_match = mt2824_ddr_ids,
+	.probe = mt2824_ddr_probe,
+	.priv_auto = sizeof(struct mt2824_ddr_priv),
+};

-- 
2.55.0

