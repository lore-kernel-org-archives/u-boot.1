Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A24C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 07:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A95880D1C;
	Thu,  6 Aug 2026 07:50:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TauITsipoHw4; Thu,  6 Aug 2026 07:50:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06B2E80C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786002606;
	bh=5dDrTCluN6jGbr1insV2cN83ekf8s1NHqRpJobY84Yg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RngIEpXPjG4QHFTdI0lPCpifUYU9O0cMx8D2pdWxgH26uYuA+jzsBjHYDWwoLFloq
	 bOisBwN8PNiIYUzCv+99dYLpTRmxX08daFH9g6OjGNBtVhWlvJipcFILl5YSMQqKdh
	 L+sd9M0hJD1PgdoRr6EOpGRutc6htCoA2LN744dDmSIk3axQ4k69LiR7cLFtCcgnGI
	 i6B9l3CkbW9LEiPT+jEFVme8Qj9Nvhf1ZGTCTqUs6bSMVixcHhmTCel4zY/nxXEGGL
	 rcS9+boE9nMN6sNoHQ7fU9gNfgoiBC/O9GYc1AzQ/XLIKqqyUZCvGVnY/Rv7UGV5V1
	 dHtyZgkNaTG7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06B2E80C7C;
	Thu,  6 Aug 2026 07:50:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 98A78397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 07:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F205606A9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 07:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aBBOSYmEdNQ7 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 07:50:02 +0000 (UTC)
X-Greylist: delayed 93562 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 06 Aug 2026 07:49:59 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D1E76606C8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1E76606C8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.106;
 helo=mail-244106.protonmail.ch; envelope-from=sean@geanix.com;
 receiver=<UNKNOWN> 
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1E76606C8
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 07:49:59 +0000 (UTC)
X-Pm-Submission-Id: 4hFzvl4d7sz2Scmd
From: Sean Nyekjaer <sean@geanix.com>
To: u-boot@lists.u-boot-project.org
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [RFC PATCH 1/2] tcan4x5x: initial commit
Date: Thu,  6 Aug 2026 09:48:58 +0200
Message-ID: <20260806074917.418220-1-sean@geanix.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=geanix.com; 
 s=protonmail3; t=1786002597; x=1786261797;
 bh=5dDrTCluN6jGbr1insV2cN83ekf8s1NHqRpJobY84Yg=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=dEkyLtiwHQCNGjIOchMoM7Psulen4UP2N2M5uf7wBMYP5KMeA6L2nWhIBqJMqOZop
 444VmXUUf8N/AlCf8GcYxl5R7QCcgA1ejf3r5iS7PxivQWVcIdt+Ekt6cutHxaBJsm
 LatI/CCBPdo9TABQhesrXJa5Y+X0DL6Nl8Y6Enr72hlULDQ1zUCK1uaTiVazGegtsE
 jyXM+Vs+wiE2nMAnACK4W4UQswdv0FCk9N0o96liUXN6r9OSg0Wk2feEIqCnKi4N8T
 Kb1HSiNpE+k+HjzXR+CUFheYOOn74oqwX314FBn9ntVxTrfkypdJSqLs//IxJgTdVo
 WvCI5RIlTYwdw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=geanix.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256
 header.s=protonmail3 header.b=dEkyLtiw
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This driver will put the tcan4x5x device into sleep mode to reduce power
consumption.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Not many drivers use SPI. So leave this for others to see how it can be
done.
If this is appropriate for upstreaming, please comment :)

 drivers/misc/Kconfig    |   5 ++
 drivers/misc/Makefile   |   3 +
 drivers/misc/tcan4x5x.c | 135 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/misc/tcan4x5x.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index dde773ab6b1..2abfdb5575c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -170,6 +170,11 @@ config CMD_CROS_EC
 	  updating its flash, accessing a small saved context area
 	  and talking to the I2C bus behind the EC (if there is one).
 
+config TCAN4X5X
+	bool "Enable TCAN4X5X"
+	depends on MISC
+	depends on DM_GPIO
+
 config CROS_EC
 	bool "Enable Chrome OS EC"
 	help
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 1d950f7a0ab..57ebafff121 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -29,6 +29,9 @@ ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += spltest_sandbox.o
 endif
 endif
+ifndef CONFIG_SPL_BUILD
+obj-$(CONFIG_TCAN4X5X) += tcan4x5x.o
+endif
 obj-$(CONFIG_ALTERA_SYSID) += altera_sysid.o
 obj-$(CONFIG_ATSHA204A) += atsha204a-i2c.o
 obj-$(CONFIG_CBMEM_CONSOLE) += cbmem_console.o
diff --git a/drivers/misc/tcan4x5x.c b/drivers/misc/tcan4x5x.c
new file mode 100644
index 00000000000..a304f3db9df
--- /dev/null
+++ b/drivers/misc/tcan4x5x.c
@@ -0,0 +1,135 @@
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <asm-generic/gpio.h>
+#include <spi.h>
+#include <log.h>
+
+#define TCAN4X5X_SPI_INSTRUCTION_WRITE 0x61
+#define TCAN4X5X_SPI_INSTRUCTION_READ 0x41
+
+#define TCAN4X5X_CONFIG 0x800
+#define TCAN4X5X_MODE_BITS (BIT(7) | BIT(6))
+
+struct tcan4x5x_transfer {
+	u8 cmd;
+	__be16 reg;
+	u8 length;
+	__be32 val;
+} __packed;
+
+static int tcan4x5x_write_reg(struct udevice *dev, u16 reg, u32 val)
+{
+	struct tcan4x5x_transfer tx;
+	int ret;
+
+	tx.cmd = TCAN4X5X_SPI_INSTRUCTION_WRITE;
+	tx.reg = cpu_to_be16(reg);
+	tx.length = 1;
+	tx.val = cpu_to_be32(val);
+
+	ret = dm_spi_claim_bus(dev);
+	if (ret)
+		return ret;
+
+	ret = dm_spi_xfer(dev, 64, &tx, NULL, SPI_XFER_ONCE);
+
+	dm_spi_release_bus(dev);
+
+	return ret;
+}
+
+static int tcan4x5x_read_reg(struct udevice *dev, u16 reg, u32 *val)
+{
+	struct tcan4x5x_transfer rx;
+	int ret;
+
+	rx.cmd = TCAN4X5X_SPI_INSTRUCTION_READ;
+	rx.reg = cpu_to_be16(reg);
+	rx.length = 1;
+
+	ret = dm_spi_claim_bus(dev);
+	if (ret)
+		return ret;
+
+	ret = dm_spi_xfer(dev, 64, &rx, &rx, SPI_XFER_ONCE);
+	if (ret)
+		return ret;
+
+	dm_spi_release_bus(dev);
+	if (ret)
+		return ret;
+
+	*val = be32_to_cpu(rx.val);
+
+	return 0;
+}
+
+static int tcan4x5x_enable_sleep(struct udevice *dev)
+{
+	u32 val;
+	int ret;
+
+	ret = tcan4x5x_read_reg(dev, TCAN4X5X_CONFIG, &val);
+	if (ret) {
+		log_err("reg read failed (%d)\n", ret);
+		return ret;
+	}
+
+	log_debug("read %x\n", val);
+	val &= ~(TCAN4X5X_MODE_BITS);
+	log_debug("write %x\n", val);
+
+	ret = tcan4x5x_write_reg(dev, TCAN4X5X_CONFIG, val);
+	if (ret)
+		log_err("reg write failed (%d)\n", ret);
+
+	return ret;
+}
+
+static int tcan4x5x_probe(struct udevice *dev)
+{
+	struct gpio_desc rst;
+	int ret;
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &rst, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("could not find reset-gpios\n");
+		return ret;
+	}
+
+	ret = dm_gpio_set_value(&rst, 1);
+	if (ret) {
+		log_err("can't set_value for rst gpio");
+		return ret;
+	}
+
+	//tPULSE_WIDTH = 30us
+	udelay(100);
+
+	ret = dm_gpio_set_value(&rst, 0);
+	if (ret) {
+		log_err("can't set_value for rst gpio");
+		return -1;
+	}
+
+	/*
+	 * After a RST has taken place, a wait time of ≥ 700 µs should be used
+	 * before reading or writing to the TCAN4550-Q1
+	 */
+	udelay(1000);
+
+	return tcan4x5x_enable_sleep(dev);
+}
+
+static const struct udevice_id tcan4x5x_ids[] = {
+	{ .compatible = "ti,tcan4x5x" },
+	{ }
+};
+
+U_BOOT_DRIVER(tcan4x5x) = {
+	.name = "tcan4x5x",
+	.id = UCLASS_MISC,
+	.of_match = tcan4x5x_ids,
+	.probe = tcan4x5x_probe,
+};
-- 
2.55.0

