Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB74DC83F15
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 13:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A9188C09;
	Thu, 29 Aug 2024 15:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kIgGVawB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A87788B0B; Thu, 29 Aug 2024 10:30:55 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B594889FF
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=coiaprant@gmail.com
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-201e52ca0caso2594735ad.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724920251; x=1725525051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaYmFLWlSAXMvw/4JyRF0sEo92YZIm+UJnVLARyAR8o=;
 b=kIgGVawBkeuBT5QgMjpTpRk6okub5Yihbwr/2tvfFoliQnBN47vSe0/kEfbzU/TzwX
 NVvA1jaJ/FhMou/Lf3aakQQ8qXj6vduLA0qKk8U52qwUK/X675YS5+ECpaovhwnZOMW2
 JZdSMhpV0Pd3S6NHBefn8wSpcLJllD2XR9BQ7kHz0tUMe6Ji9poQqPCO95K+KwPfILyb
 QiFA2iGigdRtLN0VEx+R0m62IHDNCMOhGf80+Pvj44wHG/kwbWljCAV7SkJ57QyJkeDC
 ech4KNeXvqXlXAIfuQOulL8TSX7P8o2yY3P5PSU1oXt0JOKlvWo/7q+tAaSBP+EY46DY
 2GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724920251; x=1725525051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaYmFLWlSAXMvw/4JyRF0sEo92YZIm+UJnVLARyAR8o=;
 b=CbuSE8FTj9zn9uStn96+XIVwEP5Nz28fYwiyWUgmDS0ZvI3ATVaQuZBn74x8vtRDXp
 H5nWBwUQcyE9LXGi4QvFeaj9nwLHCcsTkGVgf7G62xZF46lR/l4HftxnSeu2/LquDXxt
 kwuxExQPyGKJ84RPzZMfTyW8UgxzPwinx04v0NCUbkuNtypvc+SDEQKAFMzjSdj+m4pO
 IQPKmyXx8RZMI2bwNLFl/ObF2+2q1jTz+Tnyduix7FvDvHIdpRTP8TTQ3Vb6VWI08B9d
 8kBl8X+TZG9gDBNkwvxvSAAPymIHDJWS+KzscQoQvFFzgfxHNju/vObzJperIVW8XC4D
 DZyQ==
X-Gm-Message-State: AOJu0YyraoGQnxfAyBq2q6kxgf5fLhTEtBprv9uscbbD66IQ7+TDd5n/
 CB26ckNMvUmZJTuQIW2XfNqXwMSMiRR0kyKrlYNp0N6/2E85NQt+nHmmjO2IfCMYqA==
X-Google-Smtp-Source: AGHT+IG6LOyqm3WmcXx6j9wuxAe55x8WFGC4oSiF+eaYQ7WU/ZUwktCpCjjAtjSrno5qUhgA/RBSmg==
X-Received: by 2002:a17:903:238e:b0:201:d659:4c29 with SMTP id
 d9443c01a7336-2050c237657mr24313125ad.21.1724920251003; 
 Thu, 29 Aug 2024 01:30:51 -0700 (PDT)
Received: from server.lan ([103.213.4.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20515552b6dsm6582755ad.249.2024.08.29.01.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 01:30:50 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: u-boot@lists.denx.de
Cc: Coia Prant <coiaprant@gmail.com>
Subject: [PATCH 1/2] watchdog: Add a driver for the photonicat watchdog
Date: Thu, 29 Aug 2024 16:30:35 +0800
Message-Id: <20240829083035.227423-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829083035.227423-1-coiaprant@gmail.com>
References: <20240829083035.227423-1-coiaprant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Aug 2024 15:13:13 +0200
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

This driver supports the photonicat watchdog timers.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/watchdog/Kconfig    |   6 +
 drivers/watchdog/Makefile   |   1 +
 drivers/watchdog/pcat_wdt.c | 218 ++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 drivers/watchdog/pcat_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0c3e9913..f0a52ecf 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -421,4 +421,10 @@ config WDT_FTWDT010
 	help
 	  Faraday Technology ftwdt010 watchdog is an architecture independent
 	  watchdog. It is usually used in SoC chip design.
+
+config WDT_PCAT
+	bool "photonicat board watchdog support"
+	depends on WDT && SERIAL && DM
+	help
+	  Select this to enable watchdog timer on photonicat board.
 endmenu
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7b39adcf..829b5ed1 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -50,3 +50,4 @@ obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
 obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
 obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
 obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
+obj-$(CONFIG_WDT_PCAT) += pcat_wdt.o
\ No newline at end of file
diff --git a/drivers/watchdog/pcat_wdt.c b/drivers/watchdog/pcat_wdt.c
new file mode 100644
index 00000000..cac07fb6
--- /dev/null
+++ b/drivers/watchdog/pcat_wdt.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <wdt.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include <serial.h>
+#include <dm/device-internal.h>
+
+struct pcat_wdt_priv
+{
+	struct udevice *serial_dev;
+	struct dm_serial_ops *serial_ops;
+	uint16_t packet_count;
+};
+
+static uint16_t pcat_pmu_serial_compute_crc16(const uint8_t *data,
+											  size_t len)
+{
+	uint16_t crc = 0xFFFF;
+	size_t i;
+	unsigned int j;
+
+	for (i = 0; i < len; i++)
+	{
+		crc ^= data[i];
+		for (j = 0; j < 8; j++)
+		{
+			if (crc & 1)
+			{
+				crc = (crc >> 1) ^ 0xA001;
+			}
+			else
+			{
+				crc >>= 1;
+			}
+		}
+	}
+
+	return crc;
+}
+
+static int pcat_wdt_reset(struct udevice *dev)
+{
+	struct pcat_wdt_priv *priv = dev_get_priv(dev);
+	uint8_t packet[13] = "\xA5\x01\x81\x00\x00\x03\x00\x01\x00"
+						 "\x00\x00\x00\x5A";
+	uint16_t crc;
+	int err = 0;
+	unsigned int i;
+
+	packet[3] = priv->packet_count & 0xFF;
+	packet[4] = (priv->packet_count >> 8) & 0xFF;
+	priv->packet_count++;
+
+	crc = pcat_pmu_serial_compute_crc16(packet + 1, 9);
+	packet[10] = crc & 0xFF;
+	packet[11] = (crc >> 8) & 0xFF;
+
+	i = 0;
+	while (i < 13)
+	{
+		err = priv->serial_ops->putc(
+			priv->serial_dev, ((const char *)packet)[i]);
+		if (!err)
+		{
+			i++;
+		}
+		else if (err == -EAGAIN)
+		{
+			;
+		}
+		else
+		{
+			pr_err("%s: unable to send watchdog setup "
+				   "request: %d\n",
+				   __func__, err);
+			break;
+		}
+	}
+	return err;
+}
+
+static int pcat_wdt_setup(struct pcat_wdt_priv *priv, u64 timeout)
+{
+	uint8_t packet[16] = "\xA5\x01\x81\x00\x00\x06\x00\x13\x00"
+						 "\x3C\x3C\x00\x00\x00\x00\x5A";
+	uint16_t crc;
+	int err = 0;
+	unsigned int i;
+
+	if (timeout > 255)
+	{
+		pr_warn("%s: timeout cannot be more than 255s\n",
+				__func__);
+		timeout = 255;
+	}
+
+	packet[3] = priv->packet_count & 0xFF;
+	packet[4] = (priv->packet_count >> 8) & 0xFF;
+	priv->packet_count++;
+	packet[11] = timeout & 0xFF;
+
+	crc = pcat_pmu_serial_compute_crc16(packet + 1, 12);
+	packet[13] = crc & 0xFF;
+	packet[14] = (crc >> 8) & 0xFF;
+
+	i = 0;
+	while (i < 16)
+	{
+		err = priv->serial_ops->putc(
+			priv->serial_dev, ((const char *)packet)[i]);
+		if (!err)
+		{
+			i++;
+		}
+		else if (err == -EAGAIN)
+		{
+			;
+		}
+		else
+		{
+			pr_err("%s: unable to send watchdog setup "
+				   "request: %d\n",
+				   __func__, err);
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int pcat_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+	struct pcat_wdt_priv *priv = dev_get_priv(dev);
+
+	pcat_wdt_setup(priv, timeout);
+
+	return 0;
+}
+
+static int pcat_wdt_stop(struct udevice *dev)
+{
+	struct pcat_wdt_priv *priv = dev_get_priv(dev);
+
+	pcat_wdt_setup(priv, 0);
+
+	return 0;
+}
+
+static int dm_probe(struct udevice *dev)
+{
+	struct pcat_wdt_priv *priv = dev_get_priv(dev);
+	struct udevice *serial_dev = NULL;
+	struct dm_serial_ops *ops;
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_SERIAL, dev, "port",
+									   &serial_dev);
+	if (ret)
+	{
+		pr_err("%s: unable to find serial port device: %d\n",
+			   __func__, ret);
+		return ret;
+	}
+
+	ret = device_probe(serial_dev);
+	if (ret)
+	{
+		pr_err("%s: unable to probe serial port device: %d\n",
+			   __func__, ret);
+		return ret;
+	}
+
+	ops = serial_get_ops(serial_dev);
+	if (!ops)
+	{
+		printf("Cannot get ops for PMU serial port!\n");
+		return -EINVAL;
+	}
+
+	if (ops->setconfig)
+	{
+		ops->setconfig(serial_dev, SERIAL_DEFAULT_CONFIG);
+	}
+	if (ops->setbrg)
+	{
+		ops->setbrg(serial_dev, 115200);
+	}
+
+	priv->serial_dev = serial_dev;
+	priv->serial_ops = ops;
+	priv->packet_count = 0;
+
+	pcat_wdt_stop(dev);
+
+	return 0;
+}
+
+static const struct wdt_ops pcat_wdt_ops = {
+	.start = pcat_wdt_start,
+	.reset = pcat_wdt_reset,
+	.stop = pcat_wdt_stop,
+};
+
+static const struct udevice_id pcat_wdt_ids[] = {
+	{.compatible = "linux,wdt-pcat"},
+	{}};
+
+U_BOOT_DRIVER(wdt_pcat) = {
+	.name = "wdt_pcat",
+	.id = UCLASS_WDT,
+	.of_match = pcat_wdt_ids,
+	.ops = &pcat_wdt_ops,
+	.probe = dm_probe,
+	.priv_auto = sizeof(struct pcat_wdt_priv),
+};
\ No newline at end of file
-- 
2.39.2

