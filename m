Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A5CC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 21:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B963584704;
	Fri, 26 Jun 2026 23:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="huhwCG0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A61E8460E; Fri, 26 Jun 2026 22:17:04 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82A4083FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 22:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6300e006a=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782505020; x=1814041020;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JEfz2apHs7XWdTiCNE9lb0IXcipS4pkQ8AvCxKn8+s0=;
 b=huhwCG0ir81DBlkV6OlsMRTouVE1w52Vt05RAfzBECREBPnSrJCeEjFY
 x7wsV9pgy2CQmsBzQQc1yJ/5khUOE7yHlrHSstYMq21r8WnAvKTySKNTO
 cfM7VPg2fR+B3gM6I+g5tLaupKIBeuQybZIXCBcqlcwOEqqpvfYywJJl0
 +n/SEdskhucnyvmfDEfZTgc0Oa4AKDctdKM+3+f7zS5aKjDiUgk2ENSQ2
 hIMLYD2wp9ufUO2uThchPFhJF6ZaFK19Lt3B4r8IjgTfz68w6T+VvvXI1
 TFfa8xEgVYR3a4zgGhruxDNJ+18Ok2+jJaOQDStyNFEon3zoCyICXaXCc w==;
X-CSE-ConnectionGUID: LrxW2k/dRv+mh++ai5OLSQ==
X-CSE-MsgGUID: lQOGDrWmTYi1JoEFN3iUwQ==
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; d="scan'208";a="58909020"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 13:16:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Fri, 26 Jun 2026 13:16:58 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 26 Jun 2026 13:16:57 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Charles Perry <charles.perry@microchip.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese
 <stefan.roese@mailbox.org>, Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, "Dinesh
 Maniyam" <dinesh.maniyam@altera.com>
Subject: [PATCH 1/7] firmware: add support for RPMI
Date: Fri, 26 Jun 2026 13:15:42 -0700
Message-ID: <20260626201613.1035208-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626201613.1035208-1-charles.perry@microchip.com>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 26 Jun 2026 23:20:19 +0200
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

RISC-V Platform Management Interface (RPMI) defines an OS-agnostic
protocol for communication between an Application Processor (AP) and a
platform microcontroller (PuC) [1]

Add UCLASS_RPMI to abstract the implementation details of an RPMI
transport layer. A transport driver should implement the struct
rpmi_transport_ops callback interface while an RPMI client driver should
use struct rpmi_chan and the rpmi_* API:

  * rpmi_get_by_index()
  * rpmi_open()
  * rpmi_close()
  * rpmi_get_attr()
  * rpmi_send_with_resp()
  * rpmi_send_posted()

The most important part of the API is rpmi_send_with_resp() and
rpmi_send_posted() which is used to send a message and possibly receive
a response from the firmware.

rpmi_get_attr() can be used to retrieve attributes of the channel like
the implementation ID or the maximum message size.  This is to retrieve
information that lives outside of the service group of the rpmi_chan,
either in the "base service group" or in the transport layer itself.

rpmi_get_by_index() can be used to initialize a struct rpmi_chan using
info from the device tree.

rpmi_open() and rpmi_close() must be called once at initialization and
deinitialization by clients to let the transport layer do some stateful
things if needed.

A helper function is also added: rpmi_check_versions() which is just a
wrapper around rpmi_get_attr() to do some basic version checking that
all clients should perform.

[1]: https://github.com/riscv-non-isa/riscv-rpmi

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 MAINTAINERS                         |   6 ++
 drivers/firmware/Kconfig            |   1 +
 drivers/firmware/Makefile           |   1 +
 drivers/firmware/rpmi/Kconfig       |   9 ++
 drivers/firmware/rpmi/Makefile      |   1 +
 drivers/firmware/rpmi/rpmi-uclass.c | 138 ++++++++++++++++++++++++
 include/dm/uclass-id.h              |   1 +
 include/rpmi-uclass.h               |  79 ++++++++++++++
 include/rpmi.h                      | 159 ++++++++++++++++++++++++++++
 include/rpmi_proto.h                |  63 +++++++++++
 10 files changed, 458 insertions(+)
 create mode 100644 drivers/firmware/rpmi/Kconfig
 create mode 100644 drivers/firmware/rpmi/Makefile
 create mode 100644 drivers/firmware/rpmi/rpmi-uclass.c
 create mode 100644 include/rpmi-uclass.h
 create mode 100644 include/rpmi.h
 create mode 100644 include/rpmi_proto.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af1964654..8b8ae8e6cc9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1689,6 +1689,12 @@ F:	drivers/usb/gadget/f_rockusb.c
 F:	cmd/rockusb.c
 F:	doc/README.rockusb
 
+RPMI
+M:	Charles Perry <charles.perry@microchip.com>
+S:	Maintained
+F:	drivers/firmware/rpmi/
+F:	include/rpmi*
+
 SANDBOX
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 220de7319506..d1c3c2f666ee 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -49,3 +49,4 @@ config ARM_SMCCC_FEATURES
 
 source "drivers/firmware/arm-ffa/Kconfig"
 source "drivers/firmware/scmi/Kconfig"
+source "drivers/firmware/rpmi/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 9e7b118b074f..7d7b09a5d392 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_SANDBOX)		+= firmware-sandbox.o
 obj-$(CONFIG_ZYNQMP_FIRMWARE)	+= firmware-zynqmp.o
 obj-$(CONFIG_SCMI_FIRMWARE)	+= scmi/
+obj-$(CONFIG_RPMI_FIRMWARE)	+= rpmi/
diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfig
new file mode 100644
index 000000000000..54fd77ad8f48
--- /dev/null
+++ b/drivers/firmware/rpmi/Kconfig
@@ -0,0 +1,9 @@
+config RPMI_FIRMWARE
+	bool "Enable RPMI support"
+	depends on RISCV && DM && OF_CONTROL
+	select FIRMWARE
+	help
+	  RISC-V Platform Management Interface (RPMI) defines an OS-agnostic
+	  protocol for communication between an Application Processor (AP) and a
+	  platform microcontroller (PuC). The RPMI specification is available
+	  at: https://github.com/riscv-non-isa/riscv-rpmi
diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makefile
new file mode 100644
index 000000000000..d69c718d150e
--- /dev/null
+++ b/drivers/firmware/rpmi/Makefile
@@ -0,0 +1 @@
+obj-y	+= rpmi-uclass.o
diff --git a/drivers/firmware/rpmi/rpmi-uclass.c b/drivers/firmware/rpmi/rpmi-uclass.c
new file mode 100644
index 000000000000..b725f9e59441
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-uclass.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_RPMI
+
+#include <dm.h>
+#include <log.h>
+#include <rpmi-uclass.h>
+#include <dm/device_compat.h>
+
+static inline struct rpmi_transport_ops *rpmi_dev_ops(struct udevice *dev)
+{
+	return (struct rpmi_transport_ops *)dev->driver->ops;
+}
+
+int rpmi_get_by_index(struct udevice *dev, int index, struct rpmi_chan *chan)
+{
+	struct ofnode_phandle_args args;
+	struct rpmi_transport_ops *ops;
+	struct udevice *rpmi_dev;
+	int ret;
+
+	ret = dev_read_phandle_with_args(dev, "mboxes", "#mbox-cells", 0, index,
+					 &args);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_RPMI, args.node, &rpmi_dev);
+	if (ret)
+		return ret;
+
+	ops = rpmi_dev_ops(rpmi_dev);
+
+	if (!ops->of_xlate)
+		return -ENOSYS;
+
+	chan->dev = rpmi_dev;
+
+	ret = ops->of_xlate(chan, &args);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int rpmi_open(struct rpmi_chan *chan)
+{
+	struct rpmi_transport_ops *ops = rpmi_dev_ops(chan->dev);
+
+	if (ops->open)
+		return ops->open(chan);
+
+	return 0;
+}
+
+void rpmi_close(struct rpmi_chan *chan)
+{
+	struct rpmi_transport_ops *ops = rpmi_dev_ops(chan->dev);
+
+	if (ops->close)
+		ops->close(chan);
+}
+
+int rpmi_get_attr(struct rpmi_chan *chan, enum rpmi_attribute_id id, u32 *data)
+{
+	struct rpmi_transport_ops *ops = rpmi_dev_ops(chan->dev);
+
+	if (!ops->get_attr)
+		return -ENOSYS;
+
+	return ops->get_attr(chan, id, data);
+}
+
+int rpmi_send_with_resp(struct rpmi_chan *chan, u32 service_id,
+			const void *request, unsigned long request_len,
+			void *response, unsigned long max_response_len,
+			unsigned long *out_response_len)
+{
+	struct rpmi_transport_ops *ops = rpmi_dev_ops(chan->dev);
+
+	if (!ops->request)
+		return -ENOSYS;
+
+	return ops->request(chan, service_id, request, request_len, response,
+			    max_response_len, out_response_len);
+}
+
+int rpmi_send_posted(struct rpmi_chan *chan, u32 service_id,
+		     const void *request, unsigned long request_len)
+{
+	return rpmi_send_with_resp(chan, service_id, request, request_len, NULL,
+				   0, NULL);
+}
+
+int rpmi_check_versions(struct rpmi_chan *chan, u32 min_proto_version,
+			u32 servicegroup_id_expect,
+			u32 min_servicegroup_version)
+{
+	u32 proto_version, servicegroup_id, servicegroup_version;
+	int ret;
+
+	ret = rpmi_get_attr(chan, RPMI_ATTR_SPEC_VERSION, &proto_version);
+	if (ret)
+		return ret;
+
+	if (proto_version < min_proto_version) {
+		dev_err(chan->dev, "protocol version mismatch\n");
+		return -EINVAL;
+	}
+
+	ret = rpmi_get_attr(chan, RPMI_ATTR_SERVICEGROUP_ID, &servicegroup_id);
+	if (ret)
+		return ret;
+
+	if (servicegroup_id != servicegroup_id_expect) {
+		dev_err(chan->dev, "service group match fail\n");
+		return -EINVAL;
+	}
+
+	ret = rpmi_get_attr(chan, RPMI_ATTR_SERVICEGROUP_VERSION,
+			    &servicegroup_version);
+	if (ret)
+		return ret;
+
+	if (servicegroup_version < min_servicegroup_version) {
+		dev_err(chan->dev, "service group version mismatch\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+UCLASS_DRIVER(rpmi) = {
+	.id = UCLASS_RPMI,
+	.name = "rpmi",
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 36b5d87c304f..9e86780dcfb7 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -128,6 +128,7 @@ enum uclass_id {
 	UCLASS_RESET,		/* Reset controller device */
 	UCLASS_RKMTD,		/* Rockchip MTD device */
 	UCLASS_RNG,		/* Random Number Generator */
+	UCLASS_RPMI,		/* RPMI transport */
 	UCLASS_RTC,		/* Real time clock device */
 	UCLASS_SCMI_AGENT,	/* Interface with an SCMI server */
 	UCLASS_SCMI_BASE,	/* Interface for SCMI Base protocol */
diff --git a/include/rpmi-uclass.h b/include/rpmi-uclass.h
new file mode 100644
index 000000000000..1b41f9529a83
--- /dev/null
+++ b/include/rpmi-uclass.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#ifndef _RPMI_UCLASS_H
+#define _RPMI_UCLASS_H
+
+#include <rpmi.h>
+
+/**
+ * struct rpmi_transport_ops - The functions that an RPMI transport driver must implement.
+ */
+struct rpmi_transport_ops {
+	/**
+	 * of_xlate - Translate a client's device-tree (OF) mailbox specifier.
+	 *
+	 * Mandatory, cannot be null.
+	 *
+	 * @chan:	The channel to hold the translation result.
+	 * @args:	The mailbox specifier values from device tree.
+	 * @return 0 if OK, or a negative error code.
+	 */
+	int (*of_xlate)(struct rpmi_chan *chan,
+			struct ofnode_phandle_args *args);
+
+	/**
+	 * get_attr - Get an RPMI attribute
+	 *
+	 * Mandatory, cannot be null.
+	 *
+	 * @chan:	RPMI channel associated to the request.
+	 * @id:		ID of the attribute to get.
+	 * @data:	buffer to hold the parameter.
+	 * @return 0 if OK, or a negative error code.
+	 */
+	int (*get_attr)(struct rpmi_chan *chan, enum rpmi_attribute_id id,
+			u32 *data);
+
+	/**
+	 * request - send a request and possibly receive a response.
+	 *
+	 * Mandatory, cannot be null.
+	 *
+	 * @chan:		RPMI channel associated to the request.
+	 * @service_id:		RPMI service ID to call.
+	 * @request:		buffer to hold the request.
+	 * @request_len:	length of the request buffer.
+	 * @response:		buffer to hold the response. If NULL, this is a posted request.
+	 * @max_response_len:	size of the response buffer. If 0, this is a posted request.
+	 * @out_response_len:	size of the actual response. Out parameter.
+	 * @return 0 if OK, or a negative error code.
+	 */
+	int (*request)(struct rpmi_chan *chan, u32 service_id,
+		       const void *request, unsigned long request_len,
+		       void *response, unsigned long max_response_len,
+		       unsigned long *out_response_len);
+
+	/**
+	 * open - Perform channel initialization.
+	 *
+	 * Optional, can be null.
+	 *
+	 * @chan:	RPMI channel to initialize.
+	 * @return 0 if OK, or a negative error code.
+	 */
+	int (*open)(struct rpmi_chan *chan);
+
+	/**
+	 * close - Perform channel deinitialization.
+	 *
+	 * Optional, can be null.
+	 *
+	 * @chan:	RPMI channel to deinitialize.
+	 */
+	void (*close)(struct rpmi_chan *chan);
+};
+
+#endif
diff --git a/include/rpmi.h b/include/rpmi.h
new file mode 100644
index 000000000000..de802026b31a
--- /dev/null
+++ b/include/rpmi.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#ifndef _RPMI_H
+#define _RPMI_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <rpmi_proto.h>
+
+/* RPMI version encode/decode macros */
+#define RPMI_VER_MAJOR(__ver) upper_16_bits(__ver)
+#define RPMI_VER_MINOR(__ver) lower_16_bits(__ver)
+#define RPMI_MKVER(__maj, __min) (((u32)(__maj) << 16) | (u16)(__min))
+
+/* RPMI attribute IDs */
+enum rpmi_attribute_id {
+	RPMI_ATTR_SPEC_VERSION,
+	RPMI_ATTR_MAX_MSG_DATA_SIZE,
+	RPMI_ATTR_SERVICEGROUP_ID,
+	RPMI_ATTR_SERVICEGROUP_VERSION,
+	RPMI_ATTR_IMPL_ID,
+	RPMI_ATTR_IMPL_VERSION,
+	RPMI_ATTR_MAX_ID
+};
+
+static inline int rpmi_to_linux_error(int rpmi_error)
+{
+	switch (rpmi_error) {
+	case RPMI_SUCCESS:
+		return 0;
+	case RPMI_ERR_INVALID_PARAM:
+	case RPMI_ERR_BAD_RANGE:
+	case RPMI_ERR_INVALID_STATE:
+		return -EINVAL;
+	case RPMI_ERR_DENIED:
+		return -EPERM;
+	case RPMI_ERR_INVALID_ADDR:
+	case RPMI_ERR_HW_FAULT:
+		return -EFAULT;
+	case RPMI_ERR_ALREADY:
+		return -EALREADY;
+	case RPMI_ERR_BUSY:
+		return -EBUSY;
+	case RPMI_ERR_TIMEOUT:
+		return -ETIMEDOUT;
+	case RPMI_ERR_IO:
+		return -ECOMM;
+	case RPMI_ERR_FAILED:
+	case RPMI_ERR_NOTSUPP:
+	case RPMI_ERR_NO_DATA:
+	case RPMI_ERR_EXTENSION:
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+struct udevice;
+
+/**
+ * struct rpmi_chan - A handle to a single RPMI channel.
+ *
+ * One RPMI channel is associated to one service group.
+ */
+struct rpmi_chan {
+	struct udevice *dev;
+	/* Written by rpmi_get_by_index or rpmi_open */
+	unsigned long id;
+	void *con_priv;
+};
+
+/**
+ * rpmi_get_by_index - Get an RPMI channel by integer index.
+ *
+ * Initialize an RPMI channel using hardware information such as device tree
+ * data. No communication with the PuC occurs when calling this function.
+ *
+ * @dev:        The client device.
+ * @index:      The index of the RPMI channel to request.
+ * @chan:       A pointer to a channel object to initialize.
+ * @return: 0 if OK, or a negative error code.
+ */
+int rpmi_get_by_index(struct udevice *dev, int index, struct rpmi_chan *chan);
+
+/**
+ * rpmi_open - Initialize an RPMI channel.
+ *
+ * Initialize an RPMI channel. Communication with the PuC is performed. Must be
+ * called after rpmi_get_by_index.
+ *
+ * @chan:	The channel to initialize.
+ * @return: 0 if OK, or a negative error code.
+ */
+int rpmi_open(struct rpmi_chan *chan);
+
+/**
+ * rpmi_close - Deinitialize an RPMI channel.
+ *
+ * @chan:	The channel to deinitialize.
+ */
+void rpmi_close(struct rpmi_chan *chan);
+
+/**
+ * rpmi_get_attr - Get an RPMI channel attribute.
+ *
+ * @return: 0 if OK, or a negative error code.
+ */
+int rpmi_get_attr(struct rpmi_chan *chan, enum rpmi_attribute_id id, u32 *data);
+
+/**
+ * rpmi_send_with_resp - Send a request and receive a response.
+ *
+ * @chan:		RPMI channel associated to the request.
+ * @service_id:		RPMI service ID to call.
+ * @request:		buffer to hold the request. Can be NULL if request_len is zero.
+ * @request_len:	length of the request buffer.
+ * @response:		buffer to hold the response. Cannot be NULL.
+ * @max_response_len:	length of the response buffer.
+ * @out_response_len:	length of the actual response. Out parameter.
+ * @return: 0 if OK, or a negative error code.
+ */
+int rpmi_send_with_resp(struct rpmi_chan *chan, u32 service_id,
+			const void *request, unsigned long request_len,
+			void *response, unsigned long max_response_len,
+			unsigned long *out_response_len);
+
+/**
+ * rpmi_send_posted - Send a posted request.
+ *
+ * @chan:		RPMI channel associated to the request.
+ * @service_id:		RPMI service ID to call.
+ * @request:		buffer to hold the request. Can be NULL if request_len is zero.
+ * @request_len:	length of the request buffer.
+ * @return: 0 if OK, or a negative error code.
+ */
+int rpmi_send_posted(struct rpmi_chan *chan, u32 service_id,
+		     const void *request, unsigned long request_len);
+
+/**
+ * rpmi_check_versions - helper function to check version numbers of the
+ * implementation.
+ *
+ * @chan:                       RPMI channel associated to the request.
+ * @min_proto_version:          Minimum RPMI protocol version required. Caller
+ *                              should use the RPMI_MKVER() macro.
+ * @servicegroup_id_expect:     Service group ID expected.
+ * @min_servicegroup_version:   Minimum Service group implementation version
+ *                              required. Caller should use the RPMI_MKVER()
+ *                              macro.
+ * @return: 0 if OK, or a negative error code.
+ */
+int rpmi_check_versions(struct rpmi_chan *chan, u32 min_proto_version,
+			u32 servicegroup_id_expect,
+			u32 min_servicegroup_version);
+
+#endif
diff --git a/include/rpmi_proto.h b/include/rpmi_proto.h
new file mode 100644
index 000000000000..012ae93d7317
--- /dev/null
+++ b/include/rpmi_proto.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Values defined by the RPMI spec.
+ */
+
+#ifndef _RPMI_PROTO_H
+#define _RPMI_PROTO_H
+
+/* RPMI error codes */
+enum rpmi_error_codes {
+	RPMI_SUCCESS = 0,
+	RPMI_ERR_FAILED = -1,
+	RPMI_ERR_NOTSUPP = -2,
+	RPMI_ERR_INVALID_PARAM = -3,
+	RPMI_ERR_DENIED = -4,
+	RPMI_ERR_INVALID_ADDR = -5,
+	RPMI_ERR_ALREADY = -6,
+	RPMI_ERR_EXTENSION = -7,
+	RPMI_ERR_HW_FAULT = -8,
+	RPMI_ERR_BUSY = -9,
+	RPMI_ERR_INVALID_STATE = -10,
+	RPMI_ERR_BAD_RANGE = -11,
+	RPMI_ERR_TIMEOUT = -12,
+	RPMI_ERR_IO = -13,
+	RPMI_ERR_NO_DATA = -14,
+	RPMI_ERR_RESERVED_START = -15,
+	RPMI_ERR_RESERVED_END = -127,
+	RPMI_ERR_VENDOR_START = -128,
+};
+
+/** RPMI ServiceGroups IDs */
+enum rpmi_servicegroup_id {
+	RPMI_SRVGRP_ID_MIN		= 0,
+	RPMI_SRVGRP_BASE		= 0x0001,
+	RPMI_SRVGRP_SYSTEM_MSI		= 0x0002,
+	RPMI_SRVGRP_SYSTEM_RESET	= 0x0003,
+	RPMI_SRVGRP_SYSTEM_SUSPEND	= 0x0004,
+	RPMI_SRVGRP_HSM			= 0x0005,
+	RPMI_SRVGRP_CPPC		= 0x0006,
+	RPMI_SRVGRP_VOLTAGE		= 0x0007,
+	RPMI_SRVGRP_CLOCK		= 0x0008,
+	RPMI_SRVGRP_DEVICE_POWER	= 0x0009,
+	RPMI_SRVGRP_PERFORMANCE		= 0x000A,
+	RPMI_SRVGRP_MANAGEMENT_MODE	= 0x000B,
+	RPMI_SRVGRP_RAS_AGENT		= 0x000C,
+	RPMI_SRVGRP_REQUEST_FORWARD	= 0x000D,
+	RPMI_SRVGRP_LOGGING			= 0x000E,
+	RPMI_SRVGRP_ID_MAX_COUNT,
+
+	/* Reserved range for service groups */
+	RPMI_SRVGRP_RESERVE_START	= RPMI_SRVGRP_ID_MAX_COUNT,
+	RPMI_SRVGRP_RESERVE_END		= 0x7BFF,
+
+	/* Experimental service groups range */
+	RPMI_SRVGRP_EXPERIMENTAL_START	= 0x7C00,
+	RPMI_SRVGRP_EXPERIMENTAL_END	= 0x7FFF,
+
+	/* Vendor/Implementation-specific service groups range */
+	RPMI_SRVGRP_VENDOR_START	= 0x8000,
+	RPMI_SRVGRP_VENDOR_END		= 0xFFFF,
+};
+
+#endif
-- 
2.47.3

