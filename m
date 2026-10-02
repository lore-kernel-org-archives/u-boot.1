Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E97CA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E86340B39;
	Fri,  2 Oct 2026 16:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4NLANCruEpuD; Fri,  2 Oct 2026 16:47:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C523540B48
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959650;
	b=L8//K5R5GMHN1IzPJyVhsf0u7esNsPYdrCp4QessIcfh67IZ0FfBONQ4co7vRH6D4GC/
	 iifwzXm+U8wFGkY4GYBeKAadGAQ7kxrMlZat7U1Io1X3CpCoROJMyS149yzsXQliRt2Ub
	 Opiuwo5UbJq0ih5ZTgEkxInJHJAXvAksk/ZE1FO+g9vremGF5vqCQcIhmTSas992bm+Ci
	 FXlyEqMc54I+jaP1AhotfIm9MAvi5++tiNqzWyPLrI6DVeDfB77lLxm0Smao/j9B4xneu
	 YJWaHZrRFmWyzjdy93bHmEoN98qn9PPXg9gTnqxFYVvsXDs1F0RiNVBX/4z5e7QdAgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rmsIEuJb3cYkce4WE5JnnUV99Lh6xpzAjJQ8sK4EZss=;
	b=UUqVsQIzFoskGSy5acq39B4oYkO0RYWIYo5fdYoWwb9HsERkmsvtKKRqrfqBZm/1sCoa
	 Og/pM7SDRMQtKwKrkK1M8dGEPz2VpjzfEJjK4XHb1d6jeDXOr+MJRwWpXSp4RLL9HHrzu
	 tEoP/FqtzEpEyFKiNRO4aJSbr819kZePpXkYqrTcqC7Y5VWCk72Npe4ok/DwFMJbg8wWA
	 rvxEUaDcLK9nn7mR4FOBkhe+Q2wI5JhplFOLeyIOUo9RJ7N5sifn8SZc+jqG6EG1Ymkmc
	 rCitbcf1dy91wq6tj9jC71ENXiwosjxpJJrYbCbVm8ejaclr543CyqxbILlz8GhxY+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959649;
	bh=rmsIEuJb3cYkce4WE5JnnUV99Lh6xpzAjJQ8sK4EZss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGFsXMB/Tu0xjI58zB0vxn5Px4oNQLjXhlPged1B9CPxitNbYG79dFhm3iwaBZQd7
	 UPVJpuXHitd4M50VdDfesf17glfbDuzPWAPcBflH9UTYSxrUjwfgAUOeyjkM20WwEg
	 G/2NROa/xOaerbzZ0fVzJ7JQHjPdDtHex+oSgyCC1rmP35jZkWDNz9iGub3/MHzCZu
	 WRmwmRlAZ6sqNHNRM91sZiMdpR5bfgoESxUTYUsQkscu9ankRgIhJEP/y1o4bSEBVh
	 3kv8aDZ/T3rlQ7mq5A2bQK2x6NsXJk6LVoXATDeORzqbYS9h0b8Iw4RdTSasveGfSI
	 KtNbrOvYf+3zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C523540B48;
	Fri,  2 Oct 2026 16:47:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2591B435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C1FF60BBC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pFXH5DRgNqc0 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:13:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1209B60BBB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946835;
 b=OqEiZuX4RvcPA6w23UnAcTVpgIE3F5M66QqBRMrBIrmKPUzLNYSHdjdI1D7CGgDaLbkS
 NqNywRcApoEwPcREfExPQzCL2NpHynC4bCry3T57/RcfJV/0OaO+GuLjo9uREqtrVZTW+
 x+lBK4z29VxZYEjXh0XVaXFPQYsDD77Xqq06oKwm5VuPNX31/qEtkxkRP2ADR4CPcd8Wn
 ZkqDuN/BWAH1tyCPo8hPEaNst7TdqkLPcye1XKVOo1M5b7IX4DJ2nHev8A8e7ZVrd5/3d
 viu/D3F+WC0lisC40T/RolzhsNGfHI2j1Y5lIbCbn5bCBwYTwQv5TKU6zAi5KXJrdUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946835;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=rmsIEuJb3cYkce4WE5JnnUV99Lh6xpzAjJQ8sK4EZss=;
 b=gpVy1FK+xD+pPCmTZXQ0QcxCe8l5BaywsgML1vc0D7mrqy5AoefT4x3L/qwfgwyb7dqT
 kGr3UDSoGmtqOMM63GyEKqWMSzv7fxOuLWg86IukGrPuWe/LsAqLS7fCE2VkkQ1zXODgl
 +KLaEpAtUsgH5IBNk3csxiOXdksPHqkLvSTpcEppAJ+DelkXnxF0QuVRadeNSZ87xipn3
 LLn6F7x0ztesI0qpuJXZ0EVifqIxamRhhAvmDslBUMnhkiZ+/jjxc9T4/3XCF1x1VNB8H
 4basW/gt+AETWl+hCIhMRppqlmWFivE6GnGMBmRKUFj/w7CgeMSURa0T1GdxC9+zPBg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=kGS3Lo15; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=kGS3Lo15
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1209B60BBB
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:13:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B4B3D4E41111;
 Fri,  2 Oct 2026 13:13:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8826E603DC;
 Fri,  2 Oct 2026 13:13:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E585910328262; 
 Fri,  2 Oct 2026 15:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rmsIEuJb3cYkce4WE5JnnUV99Lh6xpzAjJQ8sK4EZss=;
 b=kGS3Lo15TGFjYnKesQFsKqQmsYLzgODb1nMXxy+Sg5nn6YwdY/dbiM2YCEGrzgHyjAE4EK
 Jo9TkhahlVFnaDbQu/eL64MOmeGzW/v2yd9XDf7Cx5fMibygJnotM8Y5l880T0XRN4WdUt
 II+Mrqc1ZpAHpY4WTVKZmU8WgL02rRmZ6fvJlHIfXiQHEcyLlNKOA014Uh3a99GTncNyon
 ZRSbMUV4EnKFhXNKnupbC5yeX3TgBYr/hxL7yqBMWK7SalCsAihrOJ/LV8Bn7Cvmd3rdim
 U4I2PBJON4hgkZfQdVYpEAAgpUQdSju8bovsL1mx4lc3ZF2ncGOszQkxdSz5ZQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:20 +0200
Subject: [PATCH 02/10] reset: Add a driver for simple controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-2-bc44cf0e0289@bootlin.com>
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

Add a driver for simple reset controllers, where each reset line is
controlled by a single bit in a memory-mapped register range.

The implementation is derived from the Linux reset-simple driver. The
controller logic itself is generic; the driver currently matches the
Metanoia MT2824 instance and further controllers can be supported by
adding their compatible to the match table.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 MAINTAINERS                  |   5 ++
 drivers/reset/Kconfig        |   8 +++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-simple.c | 115 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb4209bdea6..aed0dcc515a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1570,6 +1570,11 @@ S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-nand-flash.git
 F:	drivers/mtd/nand/raw/
 
+RESET SIMPLE DRIVER
+M:	Benoît Monin <benoit.monin@bootlin.com>
+S:	Maintained
+F:	drivers/reset/reset-simple.c
+
 RISC-V
 M:	Tim Ouyang <tim609@andestech.com>
 M:	Leo Liang <leo.liang@sifive.com>
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index db764ed5ace..be178125be6 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -149,6 +149,14 @@ config RESET_MESON
 	help
 	  Support for reset controller on Amlogic Meson SoC.
 
+config RESET_SIMPLE
+	bool "Generic driver for simple reset controller"
+	depends on DM_RESET
+	help
+	  This enables the reset driver for simple controllers where
+	  each reset line is controlled by a single bit in a memory
+	  mapped region.
+
 config RESET_SOCFPGA
 	bool "Reset controller driver for SoCFPGA"
 	depends on DM_RESET && ARCH_SOCFPGA
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 384f4336331..553260a71e8 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
 obj-$(CONFIG_RESET_AST2700) += reset-ast2700.o
 obj-$(CONFIG_$(PHASE_)RESET_ROCKCHIP) += reset-rockchip.o rst-rk3506.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
+obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_MEDIATEK) += reset-mediatek.o
 obj-$(CONFIG_RESET_MTMIPS) += reset-mtmips.o
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
new file mode 100644
index 00000000000..5df16a341d4
--- /dev/null
+++ b/drivers/reset/reset-simple.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Simple Reset Controller Driver
+ *
+ * Based on Linux reset-simple driver
+ */
+
+#include <dm.h>
+#include <reset-uclass.h>
+#include <linux/io.h>
+
+struct reset_simple_priv {
+	void __iomem *membase;
+	int nr_resets;
+};
+
+static int reset_simple_update(struct reset_ctl *rst, bool assert)
+{
+	struct reset_simple_priv *priv = dev_get_priv(rst->dev);
+	int reg_width = sizeof(u32);
+	int bank, offset;
+	u32 reg;
+
+	if (rst->id >= priv->nr_resets)
+		return -EINVAL;
+
+	bank = rst->id / (reg_width * BITS_PER_BYTE);
+	offset = rst->id % (reg_width * BITS_PER_BYTE);
+
+	reg = readl(priv->membase + (bank * reg_width));
+	if (assert)
+		writel(reg | BIT(offset), priv->membase + (bank * reg_width));
+	else
+		writel(reg & ~BIT(offset), priv->membase + (bank * reg_width));
+
+	return 0;
+}
+
+static int reset_simple_request(struct reset_ctl *rst)
+{
+	struct reset_simple_priv *priv = dev_get_priv(rst->dev);
+
+	if (rst->id >= priv->nr_resets)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int reset_simple_assert(struct reset_ctl *rst)
+{
+	return reset_simple_update(rst, true);
+}
+
+static int reset_simple_deassert(struct reset_ctl *rst)
+{
+	return reset_simple_update(rst, false);
+}
+
+static int reset_simple_status(struct reset_ctl *rst)
+{
+	struct reset_simple_priv *priv = dev_get_priv(rst->dev);
+	int reg_width = sizeof(u32);
+	int bank, offset;
+	u32 reg;
+
+	if (rst->id >= priv->nr_resets)
+		return -EINVAL;
+
+	bank = rst->id / (reg_width * BITS_PER_BYTE);
+	offset = rst->id % (reg_width * BITS_PER_BYTE);
+
+	reg = readl(priv->membase + (bank * reg_width));
+
+	return !!(reg & BIT(offset));
+}
+
+static const struct reset_ops reset_simple_ops = {
+	.request = reset_simple_request,
+	.rst_assert = reset_simple_assert,
+	.rst_deassert = reset_simple_deassert,
+	.rst_status = reset_simple_status,
+};
+
+static const struct udevice_id reset_simple_ids[] = {
+	{ .compatible = "metanoia,mt2824-reset" },
+	{ }
+};
+
+static int reset_simple_probe(struct udevice *dev)
+{
+	struct reset_simple_priv *priv = dev_get_priv(dev);
+	fdt_addr_t addr;
+	fdt_size_t size;
+
+	addr = dev_read_addr_size_index(dev, 0, &size);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->nr_resets = size * BITS_PER_BYTE;
+
+	priv->membase = devm_ioremap(dev, addr, size);
+	if (!priv->membase)
+		return -EFAULT;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(reset_simple) = {
+	.name = "simple-reset",
+	.id = UCLASS_RESET,
+	.of_match = reset_simple_ids,
+	.ops = &reset_simple_ops,
+	.probe = reset_simple_probe,
+	.priv_auto = sizeof(struct reset_simple_priv),
+};

-- 
2.55.0

