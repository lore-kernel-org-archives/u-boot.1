Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F015ED7B91
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 09:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99C78419C;
	Tue, 14 Apr 2026 11:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="HV3zCNKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EEF9841D5; Tue, 14 Apr 2026 11:15:16 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF72384181
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 11:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1wCZrS-0007lT-Uk; Tue, 14 Apr 2026 05:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=vmuhiWU3GJC5V+H2xGHcBblO2Ri2WfsNdbqKl9f5hAQ=; b=HV3zCNKHNCSn4i
 7aHixPeV+qxT/f2h2orJUTLXPhbEXh7bEcTvX50oNsaVBJ+tNaa65UsnyPr4qwyxeY7Hh9qV6rAZk
 znqPdRfNgpXsLgiqat4GHoPfY9kbbymfmMNun+MiwFS1jmUVnxPnR971MzYMDQ9dXn2w4PBrx/scI
 8i4jAG211kujmmNzpOK8S+hQevNSzSOeyzrSTXeUM35qKgdE0UzotLR39SaGG2h63mP/lPzMCc5h7
 qMjbqxJWpQSS3iyYCqz1kUrio7VV1DNTYWOi7i8OUZ73tmiIN6Sj/FXHomkJJxigkwNLKRDGdUqsk
 bdacyGsmsqIwaHSg5QPw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Mathieu Othacehe <othacehe@gnu.org>,
	u-boot@lists.denx.de
Subject: [PATCH] misc: Add RZG2L OTP support
Date: Tue, 14 Apr 2026 11:14:21 +0200
Message-ID: <20260414091422.16952-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.52.0
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

Add OTP support through the fuse command. Fusing is directly performed by
U-Boot, which means that the trusted-firmware must allow the non-secure
world to perform fusing operations.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 drivers/misc/Kconfig     |   7 ++
 drivers/misc/Makefile    |   1 +
 drivers/misc/rzg2l_otp.c | 222 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/misc/rzg2l_otp.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ea785793d18..16cb800a393 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -132,6 +132,13 @@ config SPL_ROCKCHIP_IODOMAIN
 	  for the IO-domain setting of the SoC to match the voltage supplied
 	  by the regulators.
 
+config RZG2L_OTP
+	bool "Renesas RZ/G2L OTP support"
+	depends on MISC
+	help
+	  Enable support for the OTP controller on
+	  Renesas RZ/G2L SoCs.
+
 config SIFIVE_OTP
 	bool "SiFive eMemory OTP driver"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..64b2701b672 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
+obj-$(CONFIG_RZG2L_OTP) += rzg2l_otp.o
 obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
 obj-$(CONFIG_SIFIVE_OTP) += sifive-otp.o
 obj-$(CONFIG_SMSC_LPC47M) += smsc_lpc47m.o
diff --git a/drivers/misc/rzg2l_otp.c b/drivers/misc/rzg2l_otp.c
new file mode 100644
index 00000000000..3aa3880e679
--- /dev/null
+++ b/drivers/misc/rzg2l_otp.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 Mathieu Othacehe <m.othacehe@gmail.com>
+ */
+#include <fuse.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+
+/*
+ * XXX: To enable direct fusing through U-Boot, the trusted-firmware must
+ * allow the non-secure world to perform fusing operations. This is controlled
+ * by the SYS_SLVACCCTL7 register.
+ */
+#define RZG2L_OTP_BASE      0x11860000
+#define RZG2L_SYSC_BASE     0x11020000
+
+#define RZ_SYS_BASE_DEVID   (RZG2L_SYSC_BASE + 0x0A04)
+#define RZ_OTP_BASE_DEVID   (RZG2L_OTP_BASE + 0x1178)
+#define RZ_OTP_BASE_CHIPID  (RZG2L_OTP_BASE + 0x1140)
+
+#define RZ_OTP_PWR          (RZG2L_OTP_BASE + 0x0000)
+#define RZ_OTP_STR          (RZG2L_OTP_BASE + 0x0004)
+#define RZ_OTP_STAWR        (RZG2L_OTP_BASE + 0x0008)
+#define RZ_OTP_ADRWR        (RZG2L_OTP_BASE + 0x000c)
+#define RZ_OTP_DATAWR       (RZG2L_OTP_BASE + 0x0010)
+
+#define RZ_OTP_ADRRD        (RZG2L_OTP_BASE + 0x0014)
+#define RZ_OTP_DATARD       (RZG2L_OTP_BASE + 0x0018)
+
+#define RZ_OTP_FLAG         (RZG2L_OTP_BASE + 0x001c)
+
+#define OTP_PWR		    BIT(0)
+#define ERR_WR_1	    BIT(1)
+#define ERR_WR_2	    BIT(2)
+#define ERR_WP		    BIT(3)
+#define OTP_ACCL	    BIT(4)
+#define ERR_RDY_WR	    BIT(8)
+#define OTP_DUMMY_READ	    (0x400 >> 2)
+
+static int rzg2l_otp_open(void)
+{
+	int i = 0;
+
+	if (readl(RZ_OTP_PWR) & 1) {
+		debug("OTP already powered up\n");
+		return 0;
+	}
+
+	while ((readl(RZ_OTP_STR) & 1) ||
+	       ((readl(RZ_OTP_FLAG) & 1) == 0)) {
+		if (i++ > 1000) {
+			printf("OTP power-up timeout\n");
+			return -ETIMEDOUT;
+		}
+
+		mdelay(1);
+	}
+
+	writel(readl(RZ_OTP_PWR) | OTP_PWR | OTP_ACCL, RZ_OTP_PWR);
+
+	return 0;
+}
+
+static int rzg2l_otp_dummy_read(void)
+{
+	int i = 0;
+
+	while ((readl(RZ_OTP_STR) & 1) == 0) {
+		if (i++ > 1000) {
+			printf("Timeout polling ready for OTP read\n");
+			return -ETIMEDOUT;
+		}
+		mdelay(1);
+	}
+
+	writel(RZG2L_OTP_BASE + OTP_DUMMY_READ, RZ_OTP_ADRRD);
+	readl(RZ_OTP_DATARD);
+
+	return 0;
+}
+
+static int rzg2l_otp_close(void)
+{
+	int i = 0;
+	u32 val;
+
+	rzg2l_otp_dummy_read();
+
+	val = readl(RZ_OTP_PWR);
+	val = val & OTP_PWR & OTP_ACCL;
+	writel(val, RZ_OTP_PWR);
+
+	while (readl(RZ_OTP_STR) & 1) {
+		if (i++ > 1000) {
+			printf("Timeout leaving OTP ready state\n");
+			return -ETIMEDOUT;
+		}
+		mdelay(1);
+	}
+
+	return 0;
+}
+
+static int rzg2l_otp_read_word(u32 addr, u32 *val)
+{
+	int i = 0;
+	int ret;
+
+	ret = rzg2l_otp_open();
+	if (ret < 0)
+		return ret;
+
+	while ((readl(RZ_OTP_STR) & 1) == 0) {
+		if (i++ > 1000) {
+			printf("Timeout polling ready for OTP read\n");
+			rzg2l_otp_close();
+			return -ETIMEDOUT;
+		}
+		mdelay(1);
+	}
+
+	writel(addr, RZ_OTP_ADRRD);
+	*val = readl(RZ_OTP_DATARD);
+
+	ret = rzg2l_otp_close();
+
+	return ret;
+}
+
+static int rzg2l_otp_program_word(u32 addr, u32 val)
+{
+	int i = 0;
+	int ret;
+	u32 otpval;
+
+	ret = rzg2l_otp_open();
+	if (ret < 0)
+		return ret;
+
+	while ((readl(RZ_OTP_STR) & 1) == 0) {
+		if (i++ > 1000) {
+			printf("Timeout polling ready for OTP write\n");
+			goto close;
+		}
+		mdelay(1);
+	}
+
+	writel(addr, RZ_OTP_ADRWR);
+	writel(val, RZ_OTP_DATAWR);
+
+	writel(1, RZ_OTP_STAWR);
+
+	if (readl(RZ_OTP_STR) & ERR_RDY_WR) {
+		printf("OTP not ready for write\n");
+		writel(readl(RZ_OTP_STR) & ERR_RDY_WR, RZ_OTP_STR);
+		goto close;
+	}
+
+	i = 0;
+	while ((readl(RZ_OTP_STR) & 1) == 0 ||
+	       (readl(RZ_OTP_STAWR) & 1)) {
+		if (i++ > 1000) {
+			printf("Timeout polling OTP write finished\n");
+			goto close;
+		}
+
+		mdelay(1);
+	}
+
+	if ((readl(RZ_OTP_STR) & ERR_WP) ||
+	    (readl(RZ_OTP_STR) & ERR_WR_1) ||
+	    (readl(RZ_OTP_STR) & ERR_WR_2)) {
+		printf("OTP write error (protected or invalid)\n");
+		goto close;
+	}
+
+	writel(addr, RZ_OTP_ADRRD);
+	otpval = readl(RZ_OTP_DATARD);
+
+	if (otpval != val) {
+		printf("OTP verify failed: wrote 0x%08x read 0x%08x\n",
+		       val, otpval);
+		goto close;
+	}
+
+close:
+	ret = rzg2l_otp_close();
+	return ret;
+}
+
+/* ---------------------------------------------------------------- */
+/* U-Boot fuse API */
+
+int fuse_read(u32 bank, u32 word, u32 *val)
+{
+	u32 addr;
+
+	addr = RZG2L_OTP_BASE + (word >> 2);
+
+	return rzg2l_otp_read_word(addr, val);
+}
+
+int fuse_prog(u32 bank, u32 word, u32 val)
+{
+	u32 addr;
+
+	addr = RZG2L_OTP_BASE + (word >> 2);
+
+	return rzg2l_otp_program_word(addr, val);
+}
+
+int fuse_sense(u32 bank, u32 word, u32 *val)
+{
+	/* not supported */
+	return -ENOSYS;
+}
+
+int fuse_override(u32 bank, u32 word, u32 val)
+{
+	/* not supported */
+	return -ENOSYS;
+}
-- 
2.52.0

