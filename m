Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02609C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 21:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA2584975;
	Fri, 26 Jun 2026 23:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="FkQ1pzMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F86483FEE; Fri, 26 Jun 2026 22:17:09 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD4A84105
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 22:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6300e006a=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782505026; x=1814041026;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gIahYWxPGKY0VLfl+uRuicY1fWRxJwSP+6C4eTzhfY8=;
 b=FkQ1pzMZ91L+fbPt5/fPFDfZhIQX8QwHdWoPiNoobRnBvR8ih/td4Kw8
 JjLJapDLVadrv158WNC3vPr1TJZYq9ERIBusG10so4RCd45T6MLIUbZou
 QjIkiUm41E4p6MnU0DOM8nYPkUEkBjQQeU0waiP21b4+muSnO3y+oonKk
 4oQ99CXfN/xqLf170QfGotUqd8MMPsAtdkWXIOwZD3j8mfMX2/HxA18fb
 SygYEJJuoY92zaJZ6BiaW0RvezAhInCOG7wJdoivvRnvKHTbFtPAajdQs
 r+FlFYZz/zCJqoPSZ0y3jF3c6Q+i93HpHZ9jNCdF0bB/06hBg79nDwLWY g==;
X-CSE-ConnectionGUID: +2HgIXWFSA6cuo0XXcu5gQ==
X-CSE-MsgGUID: yJ0tfE9oSlaNHwX6dvvkVw==
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; d="scan'208";a="59747538"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 13:17:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Fri, 26 Jun 2026 13:17:03 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 26 Jun 2026 13:17:03 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Charles Perry <charles.perry@microchip.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/7] firmware: rpmi: add support for the SBI MPXY transport
Date: Fri, 26 Jun 2026 13:15:43 -0700
Message-ID: <20260626201613.1035208-3-charles.perry@microchip.com>
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

This adds an RPMI transport driver for the Supervisor Binary Interface
(SBI) message proxy (MPXY) extension [1].

This is for S-Mode U-Boot where some supervisor software (such as
OpenSBI) runs in M-Mode and handles the low level communication with the
PuC.

[1]: https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 arch/riscv/include/asm/sbi.h          |  57 ++++
 drivers/firmware/rpmi/Kconfig         |   9 +
 drivers/firmware/rpmi/Makefile        |   1 +
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 449 ++++++++++++++++++++++++++
 4 files changed, 516 insertions(+)
 create mode 100644 drivers/firmware/rpmi/rpmi-sbi-mpxy.c

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 47124dbaac84..10e03257d8e6 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -10,6 +10,7 @@
 #define _ASM_RISCV_SBI_H
 
 #include <linux/types.h>
+#include <linux/errno.h>
 
 enum sbi_ext_id {
 	SBI_EXT_0_1_SET_TIMER = 0x0,
@@ -104,6 +105,17 @@ enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE,
 };
 
+enum sbi_ext_mpxy_fid {
+	SBI_EXT_MPXY_GET_SHMEM_SIZE = 0,
+	SBI_EXT_MPXY_SET_SHMEM,
+	SBI_EXT_MPXY_GET_CHANNEL_IDS,
+	SBI_EXT_MPXY_READ_ATTRS,
+	SBI_EXT_MPXY_WRITE_ATTRS,
+	SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
+	SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
+	SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS,
+};
+
 #ifdef CONFIG_SBI_V01
 #define SBI_EXT_SET_TIMER		SBI_EXT_0_1_SET_TIMER
 #define SBI_FID_SET_TIMER		0
@@ -132,6 +144,14 @@ enum sbi_ext_dbcn_fid {
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
 #define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
 
+static inline unsigned long sbi_mk_version(unsigned long major,
+					   unsigned long minor)
+{
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK)
+		<< SBI_SPEC_VERSION_MAJOR_SHIFT) |
+	       (minor & SBI_SPEC_VERSION_MINOR_MASK);
+}
+
 /* SBI return error codes */
 #define SBI_SUCCESS			0
 #define SBI_ERR_FAILURE			-1
@@ -139,6 +159,43 @@ enum sbi_ext_dbcn_fid {
 #define SBI_ERR_INVALID_PARAM		-3
 #define SBI_ERR_DENIED			-4
 #define SBI_ERR_INVALID_ADDRESS		-5
+#define SBI_ERR_ALREADY_AVAILABLE	-6
+#define SBI_ERR_ALREADY_STARTED		-7
+#define SBI_ERR_ALREADY_STOPPED		-8
+#define SBI_ERR_NO_SHMEM		-9
+#define SBI_ERR_INVALID_STATE		-10
+#define SBI_ERR_BAD_RANGE		-11
+#define SBI_ERR_TIMEOUT			-12
+#define SBI_ERR_IO			-13
+#define SBI_ERR_DENIED_LOCKED		-14
+
+static inline int sbi_to_linux_error(int err)
+{
+	switch (err) {
+	case SBI_SUCCESS:
+		return 0;
+	case SBI_ERR_DENIED:
+	case SBI_ERR_DENIED_LOCKED:
+		return -EPERM;
+	case SBI_ERR_INVALID_PARAM:
+	case SBI_ERR_INVALID_STATE:
+		return -EINVAL;
+	case SBI_ERR_BAD_RANGE:
+		return -ERANGE;
+	case SBI_ERR_INVALID_ADDRESS:
+		return -EFAULT;
+	case SBI_ERR_NO_SHMEM:
+		return -ENOMEM;
+	case SBI_ERR_TIMEOUT:
+		return -ETIMEDOUT;
+	case SBI_ERR_IO:
+		return -EIO;
+	case SBI_ERR_NOT_SUPPORTED:
+	case SBI_ERR_FAILURE:
+	default:
+		return -EOPNOTSUPP;
+	};
+}
 
 struct sbiret {
 	long error;
diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfig
index 54fd77ad8f48..708d931263ff 100644
--- a/drivers/firmware/rpmi/Kconfig
+++ b/drivers/firmware/rpmi/Kconfig
@@ -7,3 +7,12 @@ config RPMI_FIRMWARE
 	  protocol for communication between an Application Processor (AP) and a
 	  platform microcontroller (PuC). The RPMI specification is available
 	  at: https://github.com/riscv-non-isa/riscv-rpmi
+
+config RPMI_SBI_MPXY
+	bool "RPMI over SBI MPXY transport"
+	depends on RPMI_FIRMWARE && SBI
+	help
+	  Enable support for transport of RPMI messages over the message proxy
+	  (MPXY) extension of the supervisor binary interface (SBI). The
+	  specification for the MPXY extension is available at:
+	  https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makefile
index d69c718d150e..71c4aeaed910 100644
--- a/drivers/firmware/rpmi/Makefile
+++ b/drivers/firmware/rpmi/Makefile
@@ -1 +1,2 @@
 obj-y	+= rpmi-uclass.o
+obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
new file mode 100644
index 000000000000..84af4787187a
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
@@ -0,0 +1,449 @@
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
+#include <malloc.h>
+#include <asm/io.h>
+#include <asm/sbi.h>
+#include <asm/types.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <string.h>
+
+/* SBI MPXY channel IDs data in shared memory */
+struct sbi_mpxy_channel_ids_data {
+	/* Remaining number of channel ids */
+	__le32 remaining;
+	/* Returned channel ids in current function call */
+	__le32 returned;
+	/* Returned channel id array */
+	__le32 channel_array[];
+};
+
+enum sbi_mpxy_attribute_id {
+	/* Standard channel attributes managed by MPXY framework */
+	SBI_MPXY_ATTR_MSG_PROT_ID = 0x00000000,
+	SBI_MPXY_ATTR_MSG_PROT_VER = 0x00000001,
+	SBI_MPXY_ATTR_MSG_MAX_LEN = 0x00000002,
+	SBI_MPXY_ATTR_MSG_SEND_TIMEOUT = 0x00000003,
+	SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT = 0x00000004,
+	SBI_MPXY_ATTR_CHANNEL_CAPABILITY = 0x00000005,
+	SBI_MPXY_ATTR_SSE_EVENT_ID = 0x00000006,
+	SBI_MPXY_ATTR_MSI_CONTROL = 0x00000007,
+	SBI_MPXY_ATTR_MSI_ADDR_LO = 0x00000008,
+	SBI_MPXY_ATTR_MSI_ADDR_HI = 0x00000009,
+	SBI_MPXY_ATTR_MSI_DATA = 0x0000000A,
+	SBI_MPXY_ATTR_EVENTS_STATE_CONTROL = 0x0000000B,
+	SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
+	/*
+	 * Message protocol specific attributes, managed by
+	 * the message protocol specification.
+	 */
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_START = 0x80000000,
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_END = 0xffffffff
+};
+
+/*
+ * SBI MPXY standard channel attributes.
+ */
+struct sbi_mpxy_channel_attrs {
+	/* Message protocol ID */
+	u32 msg_proto_id;
+	/* Message protocol version */
+	u32 msg_proto_version;
+	/* Message protocol maximum message length */
+	u32 msg_max_len;
+	/* Message protocol message send timeout in microseconds */
+	u32 msg_send_timeout;
+	/* Message protocol message completion timeout in microseconds */
+	u32 msg_completion_timeout;
+	/* Bit array for channel capabilities */
+#define SBI_MPXY_CHAN_CAP_MSI BIT(0)
+#define SBI_MPXY_CHAN_CAP_SSE BIT(1)
+#define SBI_MPXY_CHAN_CAP_EVENTS_STATE BIT(2)
+#define SBI_MPXY_CHAN_CAP_SEND_WITH_RESP BIT(3)
+#define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP BIT(4)
+#define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS BIT(5)
+	u32 capability;
+};
+
+/* RPMI message protocol specific MPXY attributes */
+enum sbi_mpxy_rpmi_attribute_id {
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID = SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
+	SBI_MPXY_RPMI_ATTR_IMPL_ID,
+	SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
+	SBI_MPXY_RPMI_ATTR_MAX_ID
+};
+
+/*
+ * RPMI specific SBI MPXY channel attributes.
+ */
+struct sbi_mpxy_rpmi_channel_attrs {
+	/* RPMI service group ID */
+	u32 servicegroup_id;
+	/* RPMI service group version */
+	u32 servicegroup_version;
+	/* RPMI implementation ID */
+	u32 impl_id;
+	/* RPMI implementation version */
+	u32 impl_version;
+};
+
+/* Possible values of MSG_PROT_ID attribute as-per SBI v3.0 (or higher) */
+enum sbi_mpxy_msgproto_id {
+	SBI_MPXY_MSGPROTO_RPMI_ID = 0x0,
+};
+
+struct sbi_mpxy_chan_desc {
+	u32 id;
+	u32 max_xfer_len;
+	struct sbi_mpxy_channel_attrs attrs;
+	struct sbi_mpxy_rpmi_channel_attrs rpmi_attrs;
+};
+
+struct rpmi_sbi_mpxy {
+	struct udevice *dev;
+	void *shmem;
+	unsigned long shmem_size;
+	u32 channel_count;
+	struct sbi_mpxy_chan_desc *channel_descs;
+};
+
+static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
+				    u32 base_attrid, u32 attr_count,
+				    u32 *attrs_buf)
+{
+	struct sbiret sret;
+	int i;
+
+	sret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS, channel_id,
+			 base_attrid, attr_count, 0, 0, 0);
+	if (sret.error)
+		return sbi_to_linux_error(sret.error);
+
+	for (i = 0; i < attr_count; i++)
+		attrs_buf[i] = le32_to_cpu(((__le32 *)mpxy->shmem)[i]);
+
+	return 0;
+}
+
+static int rpmi_sbi_mpxy_send_message(void *shmem, u32 mpxy_fid, u32 channel_id,
+				      u32 msg_id, const void *tx,
+				      unsigned long tx_len, void *rx,
+				      unsigned long max_rx_len,
+				      unsigned long *rx_len)
+{
+	unsigned long rx_bytes;
+	struct sbiret sret;
+
+	if (tx)
+		memcpy(shmem, tx, tx_len);
+
+	sret = sbi_ecall(SBI_EXT_MPXY, mpxy_fid, channel_id, msg_id, tx_len, 0,
+			 0, 0);
+
+	if (rx && !sret.error) {
+		rx_bytes = sret.value;
+		if (rx_bytes > max_rx_len)
+			return -ENOSPC;
+
+		memcpy(rx, shmem, rx_bytes);
+		if (rx_len)
+			*rx_len = rx_bytes;
+	}
+
+	return sbi_to_linux_error(sret.error);
+}
+
+static int rpmi_sbi_mpxy_get_attr(struct rpmi_chan *chan,
+				  enum rpmi_attribute_id id, u32 *data)
+{
+	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(chan->dev);
+	struct sbi_mpxy_chan_desc *desc = &mpxy->channel_descs[chan->id];
+
+	switch (id) {
+	case RPMI_ATTR_SPEC_VERSION:
+		*data = desc->attrs.msg_proto_version;
+		break;
+	case RPMI_ATTR_MAX_MSG_DATA_SIZE:
+		*data = desc->max_xfer_len;
+		break;
+	case RPMI_ATTR_SERVICEGROUP_ID:
+		*data = desc->rpmi_attrs.servicegroup_id;
+		break;
+	case RPMI_ATTR_SERVICEGROUP_VERSION:
+		*data = desc->rpmi_attrs.servicegroup_version;
+		break;
+	case RPMI_ATTR_IMPL_ID:
+		*data = desc->rpmi_attrs.impl_id;
+		break;
+	case RPMI_ATTR_IMPL_VERSION:
+		*data = desc->rpmi_attrs.impl_version;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int rpmi_sbi_mpxy_request(struct rpmi_chan *chan, u32 service_id,
+				 const void *request, unsigned long request_len,
+				 void *response, unsigned long max_response_len,
+				 unsigned long *out_response_len)
+{
+	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(chan->dev);
+	struct sbi_mpxy_chan_desc *desc = &mpxy->channel_descs[chan->id];
+	u32 mpxy_fid;
+
+	if (!request && request_len)
+		return -EINVAL;
+
+	if (request_len > desc->max_xfer_len)
+		return -EINVAL;
+
+	if (!response && max_response_len)
+		return -EINVAL;
+
+	if (response) {
+		if (!(desc->attrs.capability &
+		      SBI_MPXY_CHAN_CAP_SEND_WITH_RESP))
+			return -EIO;
+
+		mpxy_fid = SBI_EXT_MPXY_SEND_MSG_WITH_RESP;
+	} else {
+		if (!(desc->attrs.capability &
+		      SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP))
+			return -EIO;
+
+		mpxy_fid = SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP;
+	}
+
+	return rpmi_sbi_mpxy_send_message(mpxy->shmem, mpxy_fid, desc->id,
+					  service_id, request, request_len,
+					  response, max_response_len,
+					  out_response_len);
+}
+
+static int rpmi_sbi_mpxy_of_xlate(struct rpmi_chan *chan,
+				  struct ofnode_phandle_args *args)
+{
+	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(chan->dev);
+	u32 channel_id, proto;
+	int i;
+
+	if (args->args_count != 2)
+		return -EINVAL;
+
+	channel_id = args->args[0];
+	proto = args->args[1];
+
+	for (i = 0; i < mpxy->channel_count; i++) {
+		if (mpxy->channel_descs[i].id == channel_id &&
+		    mpxy->channel_descs[i].attrs.msg_proto_id == proto) {
+			chan->id = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int rpmi_sbi_mpxy_get_shmem_size(unsigned long *shmem_size)
+{
+	struct sbiret sret;
+
+	sret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_GET_SHMEM_SIZE, 0, 0, 0, 0,
+			 0, 0);
+	if (sret.error)
+		return sbi_to_linux_error(sret.error);
+
+	/* The shared memory size MUST be at least 4096 bytes */
+	if (sret.value < PAGE_SIZE)
+		return -ENODEV;
+
+	/* The shared memory size MUST be multiple of 4096 bytes */
+	if (sret.value & (PAGE_SIZE - 1))
+		return -ENODEV;
+
+	if (shmem_size)
+		*shmem_size = sret.value;
+
+	return 0;
+}
+
+static int rpmi_sbi_mpxy_get_channel_ids(struct rpmi_sbi_mpxy *mpxy)
+{
+	struct sbi_mpxy_channel_ids_data *sdata = mpxy->shmem;
+	struct sbi_mpxy_rpmi_channel_attrs *rpmi_attrs;
+	struct sbi_mpxy_channel_attrs *attrs;
+	u32 remaining, returned, channel_id, start_index = 0;
+	struct sbiret sret;
+	int i, ret;
+
+	do {
+		sret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_GET_CHANNEL_IDS,
+				 start_index, 0, 0, 0, 0, 0);
+		if (sret.error)
+			return sbi_to_linux_error(sret.error);
+
+		remaining = le32_to_cpu(sdata->remaining);
+		returned = le32_to_cpu(sdata->returned);
+
+		// Allocate memory on the first call.
+		if (!mpxy->channel_descs) {
+			mpxy->channel_count = returned + remaining;
+			if (mpxy->channel_count == 0)
+				return -ENODEV;
+
+			mpxy->channel_descs =
+				calloc(mpxy->channel_count,
+				       sizeof(struct sbi_mpxy_chan_desc));
+			if (!mpxy->channel_descs)
+				return -ENOMEM;
+
+			dev_dbg(mpxy->dev, "channel count = %i\n",
+				mpxy->channel_count);
+		}
+
+		if (remaining && !returned)
+			return -EPROTO;
+
+		if (start_index + returned > mpxy->channel_count)
+			return -EPROTO;
+
+		for (i = 0; i < returned; i++) {
+			mpxy->channel_descs[start_index + i].id =
+				le32_to_cpu(sdata->channel_array[i]);
+		}
+		start_index += returned;
+	} while (remaining);
+
+	for (i = 0; i < mpxy->channel_count; i++) {
+		channel_id = mpxy->channel_descs[i].id;
+		attrs = &mpxy->channel_descs[i].attrs;
+
+		ret = rpmi_sbi_mpxy_read_attrs(
+			mpxy, channel_id, SBI_MPXY_ATTR_MSG_PROT_ID,
+			sizeof(struct sbi_mpxy_channel_attrs) / sizeof(u32),
+			(u32 *)attrs);
+		if (ret)
+			return ret;
+
+		if (attrs->msg_proto_id == SBI_MPXY_MSGPROTO_RPMI_ID) {
+			rpmi_attrs = &mpxy->channel_descs[i].rpmi_attrs;
+			ret = rpmi_sbi_mpxy_read_attrs(
+				mpxy, channel_id,
+				SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
+				sizeof(struct sbi_mpxy_rpmi_channel_attrs) /
+					sizeof(u32),
+				(u32 *)rpmi_attrs);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int rpmi_sbi_mpxy_probe(struct udevice *dev)
+{
+	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(dev);
+	struct sbi_mpxy_chan_desc *desc;
+	unsigned long flags;
+	struct sbiret sret;
+	int i, ret;
+
+	mpxy->dev = dev;
+
+	/* Probe for SBI MPXY extension */
+	if (sbi_get_spec_version() < sbi_mk_version(1, 0) ||
+	    sbi_probe_extension(SBI_EXT_MPXY) <= 0) {
+		dev_info(dev, "SBI MPXY extension not available\n");
+		return -ENODEV;
+	}
+
+	/* Find-out shared memory size */
+	ret = rpmi_sbi_mpxy_get_shmem_size(&mpxy->shmem_size);
+	if (ret) {
+		dev_err(dev, "failed to get MPXY shared memory size\n");
+		return -ENODEV;
+	}
+
+	mpxy->shmem = memalign(PAGE_SIZE, mpxy->shmem_size);
+	if (!mpxy->shmem)
+		return -ENOMEM;
+
+	/* Setup shmem in OVERWRITE mode. (flags[1:0] = 00b) */
+	flags = 0;
+	sret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_SET_SHMEM,
+			 virt_to_phys(mpxy->shmem), 0, flags, 0, 0, 0);
+	if (sret.error) {
+		ret = sbi_to_linux_error(sret.error);
+		goto err;
+	}
+
+	ret = rpmi_sbi_mpxy_get_channel_ids(mpxy);
+	if (ret)
+		goto err;
+
+	for (i = 0; i < mpxy->channel_count; i++) {
+		desc = &mpxy->channel_descs[i];
+		desc->max_xfer_len =
+			min((u32)mpxy->shmem_size, desc->attrs.msg_max_len);
+	}
+
+	return 0;
+
+err:
+	if (mpxy->channel_descs)
+		free(mpxy->channel_descs);
+
+	if (mpxy->shmem)
+		free(mpxy->shmem);
+
+	return ret;
+}
+
+static int rpmi_sbi_mpxy_remove(struct udevice *dev)
+{
+	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(dev);
+
+	if (mpxy->channel_descs)
+		free(mpxy->channel_descs);
+
+	if (mpxy->shmem)
+		free(mpxy->shmem);
+
+	return 0;
+}
+
+static const struct udevice_id rpmi_sbi_mpxy_ids[] = {
+	{ .compatible = "riscv,sbi-mpxy-mbox" },
+	{}
+};
+
+static const struct rpmi_transport_ops rpmi_sbi_mpxy_ops = {
+	.of_xlate = rpmi_sbi_mpxy_of_xlate,
+	.get_attr = rpmi_sbi_mpxy_get_attr,
+	.request = rpmi_sbi_mpxy_request,
+};
+
+U_BOOT_DRIVER(rpmi_sbi_mpxy) = {
+	.name = "rpmi-sbi-mpxy",
+	.id = UCLASS_RPMI,
+	.of_match = rpmi_sbi_mpxy_ids,
+	.probe = rpmi_sbi_mpxy_probe,
+	.remove = rpmi_sbi_mpxy_remove,
+	.priv_auto = sizeof(struct rpmi_sbi_mpxy),
+	.ops = &rpmi_sbi_mpxy_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.47.3

