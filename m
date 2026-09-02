Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1850C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B74280FC1;
	Wed,  2 Sep 2026 14:18:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GbWcVQih9aUm; Wed,  2 Sep 2026 14:18:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358702;
	bh=PfQnF1VIW80nKDctOdIiUTJYH846KP0bZC146VpRsQQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HkiOdoatIzEYp7SDxI4qey5cP04wB9UbykKdYSpTqyotkq5tnw1wc1ijNv+iHaeeF
	 WGBAEi72HheMf2v3eEUnE2evkFDYR/wRTnnegsritUHkvNfh2CF80DL+2aNyWNjKey
	 aDzsNSddIQ8bLISQYDJYXye0qOoVvWq7/68yuFaXn6bYSxo5D+6R+kABNjBfd5JocM
	 iK6keT/djmJxqmMB64urgIXaDgHrRphCluXdw4N4sWdTNr6Rit6R4wSqInDTXc++Ud
	 VF/cC5CUHx7r7DY+iHKo2zcWrvikGUideB8DKcNuscoU+z3luN81bJYKYhD0c7cafP
	 YoTDqkkO6hFyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DA5E80EF2;
	Wed,  2 Sep 2026 14:18:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B30E230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01410406EB
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLANPxfkE0-y for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:18:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=prvs=698db811e=charles.perry@microchip.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=microchip.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=SmaPNTKO
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AD974068A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:18:18 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ECC78424C; Wed,  2 Sep 2026 16:18:16 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC0D983EEF
 for <u-boot@lists.denx.de>; Wed,  2 Sep 2026 16:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=698db811e=Charles.Perry@microchip.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.b="SmaPNTKO"; dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1788358692; x=1819894692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FXO2O/p9jTk/4JBXMEbj9smHkzlMxtYMFMPg6MMrV7I=;
 b=SmaPNTKO/gUQt78PH8zcWQQcpj27qt4NGuhPGr0RN3nnz1hhQQ/DcdeT
 JwfrWKYg4oGPgMcNvHItrNobGLWydcw84ye7deqSD6Se+7B+3IBvErFH9
 3NSirQ6ybjgRX3JqhXhFkKMwnLlIv07vFK4TpeVslxeNzrKLbgJGqvBWt
 /zGzhLGQZ5uN9eSvCC/JmfX2MKg5C10Xj3M1cc2sH0iKacqum3pntj74a
 oSGmHEoOWzCCRL3AxPtQwIYBOz/7KO+RefloDSS6lSmGMR2cEiQr/oBeb
 kZGZ4baHLdvfvNHChYxaxt0tjcoeMvb4dpUNnwOWXfNfYq6LK6XFnxKe6 g==;
X-CSE-ConnectionGUID: p05peqVfQ8278h5nBRfEgQ==
X-CSE-MsgGUID: jbSRzx2RQDS0eCfoXjeESQ==
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="72937347"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 07:18:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 2 Sep 2026 07:18:09 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 2 Sep 2026 07:18:08 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: <charles.perry@microchip.com>, Tim Ouyang <tim609@andestech.com>, "Leo
 Liang" <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, Tom Rini
 <trini@konsulko.com>, Rahul Pathak <rahul.pathak@oss.qualcomm.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v3 1/5] firmware: rpmi: add support for the SBI MPXY transport
Date: Wed, 2 Sep 2026 07:17:27 -0700
Message-ID: <20260902141744.2422566-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902141744.2422566-1-charles.perry@microchip.com>
References: <20260902141744.2422566-1-charles.perry@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

This adds an RPMI transport driver for the Supervisor Binary Interface
(SBI) message proxy (MPXY) extension [1].

This is for S-Mode U-Boot where some supervisor software (such as
OpenSBI) runs in M-Mode and handles the low level communication with the
PuC.

[1]: https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v3: None

Changes in v2: (from Yao Zi review)
 - Reorder headers
 - Remove struct sbi_mpxy_rpmi_channel_attrs and struct
   sbi_mpxy_channel_attrs for simpler u32 arrays
 - Don't null check pointers before free()
---
 arch/riscv/include/asm/sbi.h          |  57 ++++
 drivers/firmware/rpmi/Kconfig         |   9 +
 drivers/firmware/rpmi/Makefile        |   1 +
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 410 ++++++++++++++++++++++++++
 4 files changed, 477 insertions(+)
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
index 000000000000..9ccca0eb59b2
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_RPMI
+
+#include <asm/io.h>
+#include <asm/sbi.h>
+#include <asm/types.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <log.h>
+#include <malloc.h>
+#include <rpmi-uclass.h>
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
+/* SBI_MPXY_ATTR_CHANNEL_CAPABILITY bits */
+#define SBI_MPXY_CHAN_CAP_MSI BIT(0)
+#define SBI_MPXY_CHAN_CAP_SSE BIT(1)
+#define SBI_MPXY_CHAN_CAP_EVENTS_STATE BIT(2)
+#define SBI_MPXY_CHAN_CAP_SEND_WITH_RESP BIT(3)
+#define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP BIT(4)
+#define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS BIT(5)
+
+/* RPMI message protocol specific MPXY attributes */
+enum sbi_mpxy_rpmi_attribute_id {
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID,
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
+	SBI_MPXY_RPMI_ATTR_IMPL_ID,
+	SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
+	SBI_MPXY_RPMI_ATTR_MAX_ID
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
+	u32 attrs[SBI_MPXY_ATTR_STD_ATTR_MAX_IDX];
+	u32 rpmi_attrs[SBI_MPXY_RPMI_ATTR_MAX_ID];
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
+		*data = desc->attrs[SBI_MPXY_ATTR_MSG_PROT_VER];
+		break;
+	case RPMI_ATTR_MAX_MSG_DATA_SIZE:
+		*data = desc->max_xfer_len;
+		break;
+	case RPMI_ATTR_SERVICEGROUP_ID:
+		*data = desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID];
+		break;
+	case RPMI_ATTR_SERVICEGROUP_VERSION:
+		*data = desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION];
+		break;
+	case RPMI_ATTR_IMPL_ID:
+		*data = desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_IMPL_ID];
+		break;
+	case RPMI_ATTR_IMPL_VERSION:
+		*data = desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_IMPL_VERSION];
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
+	u32 caps = desc->attrs[SBI_MPXY_ATTR_CHANNEL_CAPABILITY];
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
+		if (!(caps & SBI_MPXY_CHAN_CAP_SEND_WITH_RESP))
+			return -EIO;
+
+		mpxy_fid = SBI_EXT_MPXY_SEND_MSG_WITH_RESP;
+	} else {
+		if (!(caps & SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP))
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
+		    mpxy->channel_descs[i].attrs[SBI_MPXY_ATTR_MSG_PROT_ID] ==
+			    proto) {
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
+
+		ret = rpmi_sbi_mpxy_read_attrs(mpxy, channel_id,
+					       SBI_MPXY_ATTR_MSG_PROT_ID,
+					       SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
+					       mpxy->channel_descs[i].attrs);
+		if (ret)
+			return ret;
+
+		if (mpxy->channel_descs[i].attrs[SBI_MPXY_ATTR_MSG_PROT_ID] ==
+		    SBI_MPXY_MSGPROTO_RPMI_ID) {
+			ret = rpmi_sbi_mpxy_read_attrs(
+				mpxy, channel_id,
+				SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
+				SBI_MPXY_RPMI_ATTR_MAX_ID,
+				mpxy->channel_descs[i].rpmi_attrs);
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
+			min((u32)mpxy->shmem_size,
+			    desc->attrs[SBI_MPXY_ATTR_MSG_MAX_LEN]);
+	}
+
+	return 0;
+
+err:
+	free(mpxy->channel_descs);
+	free(mpxy->shmem);
+
+	return ret;
+}
+
+static int rpmi_sbi_mpxy_remove(struct udevice *dev)
+{
+	struct rpmi_sbi_mpxy *mpxy = dev_get_priv(dev);
+
+	free(mpxy->channel_descs);
+	free(mpxy->shmem);
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
2.52.0

