Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C909C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 21:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5090A8498C;
	Fri, 26 Jun 2026 23:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="ymZLiWhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D439284105; Fri, 26 Jun 2026 22:17:17 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BF683FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 22:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6300e006a=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782505034; x=1814041034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AgDKWqt1eWYT2I9SJWYfD22ruR4hyfv/p4ebhetVX88=;
 b=ymZLiWhuXSs0Kvpnl75DQOOGaVdWuIVBAlvrkDYNdb+iB4sBtYJmdPnw
 NEcdwB1/018I68qRaQi+tIuSngI/QVDa5z1BJZjlOvi3lptLY4x/yWZ34
 A+z/f/7ivqK7Xjrh8pg0gRtgJKVsSNgR0SQ/nEKqfor3zb7Dgz7P50EMb
 IqT2w5xuXkHTv/39d96JLVb/4OIwzNAQEBAO5DAUZ8t8EdmUZ4VSQRWqj
 nEoRK0XQCf4FhAp4bzIVNU3oXHiDKy1VfY5zSQ+y54C7uihxliMkSw4Py
 uEy7MOo9UKMEK8zLgHnWg2ZFYIlMSNeO+ebPo60VU2O+Z+lsMwMMnIId+ w==;
X-CSE-ConnectionGUID: TAQErXAHQ6KPkHqoY0G1tQ==
X-CSE-MsgGUID: Ut+XOdyoTqC9pqnZ1P8iiw==
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; d="scan'208";a="59747549"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 13:17:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Fri, 26 Jun 2026 13:17:11 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 26 Jun 2026 13:17:11 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Charles Perry <charles.perry@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/7] firmware: rpmi: add support for shared memory transport
Date: Fri, 26 Jun 2026 13:15:44 -0700
Message-ID: <20260626201613.1035208-4-charles.perry@microchip.com>
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

Add support for transport of RPMI messages over shared memory as
described in the RPMI spec [1]. This uses two or four ring buffers
composed of a fixed number of "slots" to pass messages between the AP
and the PuC. U-Boot is the Application processor (AP) and sends messages
through the a2p-req queue and receives response though the p2a-ack
queue. There is no support for platform microcontroller (PuC) initiated
requests nor notifications.

This transport can be used in M or S mode U-Boot, but in the S-mode
case, one must make sure that the supervisor software isn't already
using the AP side of the shared memory.

[1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 2)

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/firmware/rpmi/Kconfig      |   8 +
 drivers/firmware/rpmi/Makefile     |   1 +
 drivers/firmware/rpmi/rpmi-shmem.c | 474 +++++++++++++++++++++++++++++
 include/rpmi_proto.h               |  23 ++
 4 files changed, 506 insertions(+)
 create mode 100644 drivers/firmware/rpmi/rpmi-shmem.c

diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfig
index 708d931263ff..421a1fa9deba 100644
--- a/drivers/firmware/rpmi/Kconfig
+++ b/drivers/firmware/rpmi/Kconfig
@@ -16,3 +16,11 @@ config RPMI_SBI_MPXY
 	  (MPXY) extension of the supervisor binary interface (SBI). The
 	  specification for the MPXY extension is available at:
 	  https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
+
+config RPMI_SHMEM
+	bool "RPMI over shared memory transport"
+	depends on RPMI_FIRMWARE
+	help
+	  Enable support for transport of RPMI messages over shared memory as
+	  described in chapter 2 of the RPMI specification, available at:
+	  https://github.com/riscv-non-isa/riscv-rpmi
diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makefile
index 71c4aeaed910..4f4bcb929db4 100644
--- a/drivers/firmware/rpmi/Makefile
+++ b/drivers/firmware/rpmi/Makefile
@@ -1,2 +1,3 @@
 obj-y	+= rpmi-uclass.o
 obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
+obj-$(CONFIG_RPMI_SHMEM) += rpmi-shmem.o
diff --git a/drivers/firmware/rpmi/rpmi-shmem.c b/drivers/firmware/rpmi/rpmi-shmem.c
new file mode 100644
index 000000000000..a3e529d4c685
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-shmem.c
@@ -0,0 +1,474 @@
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
+#include <dm/device_compat.h>
+#include <asm/types.h>
+#include <asm/barrier.h>
+#include <linux/delay.h>
+
+#define RPMI_SLOT_SIZE_MIN 64
+
+enum rpmi_queue_idx {
+	RPMI_QUEUE_IDX_A2P_REQ = 0,
+	RPMI_QUEUE_IDX_P2A_ACK = 1,
+	RPMI_QUEUE_IDX_P2A_REQ = 2,
+	RPMI_QUEUE_IDX_A2P_ACK = 3,
+	RPMI_QUEUE_IDX_MAX_COUNT = 4,
+	RPMI_A2P_DOORBELL = 5,
+};
+
+struct shmem_queue {
+	u32 num_slot;
+	__le32 *headptr;
+	__le32 *tailptr;
+	void *buffer;
+};
+
+struct rpmi_shmem {
+	struct udevice *dev;
+	struct shmem_queue a2p_req;
+	struct shmem_queue p2a_ack;
+	int slot_size;
+	int rx_timeout_ms;
+	u32 token;
+	void *doorbell;
+	u32 doorbell_value;
+	u32 spec_version;
+	u32 impl_version;
+	u32 impl_id;
+};
+
+struct rpmi_shmem_chan_priv {
+	struct rpmi_shmem *priv;
+	u32 servicegroup_id;
+	u32 servicegroup_version;
+};
+
+static int rpmi_shmem_queue_idx(const char *name)
+{
+	static const struct {
+		int id;
+		const char *name;
+	} id_names[] = {
+		{ RPMI_QUEUE_IDX_A2P_REQ, "a2p-req" },
+		{ RPMI_QUEUE_IDX_P2A_ACK, "p2a-ack" },
+		{ RPMI_QUEUE_IDX_P2A_REQ, "p2a-req" },
+		{ RPMI_QUEUE_IDX_A2P_ACK, "a2p-ack" },
+		{ RPMI_A2P_DOORBELL, "a2p-doorbell" },
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(id_names); i++) {
+		if (strcmp(name, id_names[i].name) == 0)
+			return id_names[i].id;
+	}
+
+	return -ENODEV;
+}
+
+static bool rpmi_smq_queue_full(struct shmem_queue *qctx)
+{
+	return ((le32_to_cpu(*qctx->tailptr) + 1) % qctx->num_slot ==
+		le32_to_cpu(*qctx->headptr));
+}
+
+/* 31                                            0
+ * +---------------------+-----------------------+
+ * | FLAGS | SERVICE_ID  |   SERVICEGROUP_ID     |
+ * +---------------------+-----------------------+
+ * |        TOKEN        |     DATA LENGTH       |
+ * +---------------------+-----------------------+
+ * |                 DATA/PAYLOAD                |
+ * +---------------------------------------------+
+ */
+struct rpmi_message_header {
+	__le16 servicegroup_id;
+	u8 service_id;
+	u8 flags;
+	__le16 datalen;
+	__le16 token;
+} __packed;
+
+static int rpmi_smq_rx(struct rpmi_shmem *priv, struct shmem_queue *qctx,
+		       u32 service_group_id, u32 service_id, u16 token,
+		       void *response, unsigned long max_response_len,
+		       unsigned long *out_response_len)
+{
+	struct rpmi_message_header *msg;
+	u32 dlen, headidx, tailidx;
+	int rxretry = 0;
+	void *src;
+
+	headidx = le32_to_cpu(*qctx->headptr);
+
+	/* Wait for the Rx message with matching token, discard any other
+	 * messages received in the mean time
+	 */
+	while (true) {
+		tailidx = le32_to_cpu(*qctx->tailptr);
+
+		if (headidx != tailidx) {
+			msg = (void *)qctx->buffer +
+			      (headidx * priv->slot_size);
+			if (le16_to_cpu(msg->token) == token)
+				break;
+
+			headidx = (headidx + 1) % qctx->num_slot;
+		}
+
+		mdelay(1);
+		rxretry += 1;
+		if (rxretry > priv->rx_timeout_ms)
+			return -ETIMEDOUT;
+	}
+
+	/* Extract data from the message */
+	if (response) {
+		dlen = le16_to_cpu(msg->datalen);
+		if (dlen > max_response_len)
+			dlen = max_response_len;
+		if (out_response_len)
+			*out_response_len = dlen;
+		src = (void *)msg + sizeof(struct rpmi_message_header);
+		memcpy(response, src, dlen);
+	}
+
+	/* Update the head index */
+	headidx = (headidx + 1) % qctx->num_slot;
+	*qctx->headptr = cpu_to_le32(headidx);
+
+	return 0;
+}
+
+static int rpmi_smq_tx(struct rpmi_shmem *priv, struct shmem_queue *qctx,
+		       u32 service_group_id, u32 service_id,
+		       enum rpmi_message_type type, u16 token,
+		       const void *request, unsigned long request_len)
+{
+	struct rpmi_message_header header = { 0 };
+	u32 tailidx;
+	void *dst;
+
+	/* Tx sanity checks */
+	if (request_len >
+	    (priv->slot_size - sizeof(struct rpmi_message_header)))
+		return -EINVAL;
+
+	if (rpmi_smq_queue_full(qctx))
+		return -ENOMEM;
+
+	tailidx = le32_to_cpu(*qctx->tailptr);
+
+	/* Prepare the header to be written into the slot */
+	header.servicegroup_id = cpu_to_le16(service_group_id);
+	header.service_id = service_id;
+	header.flags = type;
+	header.datalen = cpu_to_le16(request_len);
+	header.token = cpu_to_le16(token);
+
+	/* Write header into the slot */
+	dst = (char *)qctx->buffer + (tailidx * priv->slot_size);
+	memcpy(dst, &header, sizeof(header));
+	dst += sizeof(header);
+
+	/* Write data into the slot */
+	if (request)
+		memcpy(dst, request, request_len);
+
+	/* Make sure queue chanages are visible to PuC before updating tail */
+	wmb();
+
+	/* Update the tail/write index */
+	tailidx = (tailidx + 1) % qctx->num_slot;
+	*qctx->tailptr = cpu_to_le32(tailidx);
+
+	/* Ring the RPMI doorbell if present */
+	if (priv->doorbell)
+		writel(priv->doorbell_value, priv->doorbell);
+
+	return 0;
+}
+
+static int rpmi_shmem_request_priv(struct rpmi_shmem *priv, u32 servicegroup_id,
+				   u32 service_id, const void *request,
+				   unsigned long request_len, void *response,
+				   unsigned long max_response_len,
+				   unsigned long *out_response_len)
+{
+	enum rpmi_message_type type = response ? RPMI_MSG_NORMAL_REQUEST :
+						 RPMI_MSG_POSTED_REQUEST;
+	int err;
+
+	if (!request && request_len)
+		return -EINVAL;
+
+	err = rpmi_smq_tx(priv, &priv->a2p_req, servicegroup_id, service_id,
+			  type, priv->token, request, request_len);
+	if (err) {
+		dev_err(priv->dev, "tx failed %i\n", err);
+		goto out;
+	}
+
+	if (response) {
+		err = rpmi_smq_rx(priv, &priv->p2a_ack, servicegroup_id,
+				  service_id, priv->token, response,
+				  max_response_len, out_response_len);
+		if (err) {
+			dev_err(priv->dev, "rx failed %i\n", err);
+			goto out;
+		}
+	}
+
+out:
+	priv->token++;
+	return err;
+}
+
+static int rpmi_shmem_request(struct rpmi_chan *chan, u32 service_id,
+			      const void *request, unsigned long request_len,
+			      void *response, unsigned long max_response_len,
+			      unsigned long *out_response_len)
+{
+	struct rpmi_shmem *priv = dev_get_priv(chan->dev);
+	struct rpmi_shmem_chan_priv *chan_priv = chan->con_priv;
+
+	return rpmi_shmem_request_priv(priv, chan_priv->servicegroup_id,
+				       service_id, request, request_len,
+				       response, max_response_len,
+				       out_response_len);
+}
+
+static int rpmi_shmem_get_attr(struct rpmi_chan *chan,
+			       enum rpmi_attribute_id id, u32 *data)
+{
+	struct rpmi_shmem *priv = dev_get_priv(chan->dev);
+	struct rpmi_shmem_chan_priv *chan_priv = chan->con_priv;
+
+	switch (id) {
+	case RPMI_ATTR_SPEC_VERSION:
+		*data = priv->spec_version;
+		break;
+	case RPMI_ATTR_MAX_MSG_DATA_SIZE:
+		*data = priv->slot_size - sizeof(struct rpmi_message_header);
+		break;
+	case RPMI_ATTR_SERVICEGROUP_ID:
+		*data = chan_priv->servicegroup_id;
+		break;
+	case RPMI_ATTR_SERVICEGROUP_VERSION:
+		*data = chan_priv->servicegroup_version;
+		break;
+	case RPMI_ATTR_IMPL_ID:
+		*data = priv->impl_id;
+		break;
+	case RPMI_ATTR_IMPL_VERSION:
+		*data = priv->impl_version;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int rpmi_shmem_base_service_req(struct rpmi_shmem *priv, u32 service_id,
+				       const u32 *arg_in, u32 *arg_out)
+{
+	int len = 0;
+	u32 rx[2];
+	u32 tx[1];
+	int ret;
+
+	if (arg_in) {
+		tx[0] = cpu_to_le32(*arg_in);
+		len = sizeof(*arg_in);
+	}
+
+	ret = rpmi_shmem_request_priv(priv, RPMI_SRVGRP_BASE, service_id, tx,
+				      len, rx, sizeof(rx), NULL);
+	if (ret) {
+		dev_err(priv->dev, "BASE service %i failed (%i)\n", service_id,
+			ret);
+		return ret;
+	}
+
+	if (rx[0]) {
+		ret = rpmi_to_linux_error(le32_to_cpu(rx[0]));
+		dev_err(priv->dev, "BASE service %i returned code %i\n",
+			service_id, ret);
+		return ret;
+	}
+
+	if (arg_out)
+		*arg_out = le32_to_cpu(rx[1]);
+
+	return 0;
+}
+
+static int rpmi_shmem_of_xlate(struct rpmi_chan *chan,
+			       struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 1)
+		return -EINVAL;
+
+	// args[0] is the servicegroup id.
+	chan->id = args->args[0];
+
+	return 0;
+}
+
+static int rpmi_shmem_open(struct rpmi_chan *chan)
+{
+	struct rpmi_shmem *priv = dev_get_priv(chan->dev);
+	u32 servicegroup_id, servicegroup_version;
+	struct rpmi_shmem_chan_priv *chan_priv;
+	int ret;
+
+	servicegroup_id = chan->id;
+
+	ret = rpmi_shmem_base_service_req(priv,
+					  RPMI_BASE_SRV_PROBE_SERVICE_GROUP,
+					  &servicegroup_id,
+					  &servicegroup_version);
+	if (ret)
+		return ret;
+
+	chan_priv = malloc(sizeof(*chan_priv));
+	if (!chan_priv)
+		return -ENOMEM;
+
+	chan->con_priv = chan_priv;
+
+	chan_priv->priv = priv;
+	chan_priv->servicegroup_id = servicegroup_id;
+	chan_priv->servicegroup_version = servicegroup_version;
+
+	return 0;
+}
+
+static void rpmi_shmem_close(struct rpmi_chan *chan)
+{
+	if (chan->con_priv)
+		free(chan->con_priv);
+}
+
+static int rpmi_shmem_probe(struct udevice *dev)
+{
+	struct rpmi_shmem *priv = dev_get_priv(dev);
+	int i, ret, qidx, qcount, qslotcnt;
+	struct shmem_queue *queue;
+	u32 arg_in, arg_out;
+	const char *qname;
+	fdt_size_t qsize;
+	void *start;
+
+	priv->dev = dev;
+	priv->rx_timeout_ms = 20;
+
+	priv->slot_size = dev_read_u32_default(dev, "riscv,slot-size", 0);
+	if (priv->slot_size < RPMI_SLOT_SIZE_MIN)
+		return -EINVAL;
+
+	priv->doorbell_value =
+		dev_read_u32_default(dev, "riscv,a2p-doorbell-value", 0);
+
+	qcount = dev_read_string_count(dev, "reg-names");
+	if (qcount < 0 || qcount > 5)
+		return -EINVAL;
+
+	for (i = 0; i < qcount; i++) {
+		ret = dev_read_string_index(dev, "reg-names", i, &qname);
+		if (ret)
+			continue;
+
+		qidx = rpmi_shmem_queue_idx(qname);
+		if (qidx < 0)
+			continue;
+
+		start = dev_read_addr_size_index_ptr(dev, i, &qsize);
+		if (!start)
+			continue;
+
+		if (qidx == RPMI_A2P_DOORBELL) {
+			priv->doorbell = start;
+		} else {
+			qslotcnt = qsize / priv->slot_size;
+			if (qslotcnt < 4)
+				continue;
+
+			if (qidx == RPMI_QUEUE_IDX_A2P_REQ)
+				queue = &priv->a2p_req;
+			else if (qidx == RPMI_QUEUE_IDX_P2A_ACK)
+				queue = &priv->p2a_ack;
+			else
+				continue;
+
+			queue->headptr = start;
+			queue->tailptr = start + priv->slot_size;
+			queue->buffer = start + (2 * priv->slot_size);
+			queue->num_slot = qslotcnt - 2;
+		}
+	}
+
+	if (!priv->a2p_req.num_slot || !priv->p2a_ack.num_slot)
+		return -EINVAL;
+
+	arg_in = RPMI_SRVGRP_BASE;
+	ret = rpmi_shmem_base_service_req(
+		priv, RPMI_BASE_SRV_PROBE_SERVICE_GROUP, &arg_in, &arg_out);
+	if (ret)
+		return ret;
+
+	if (arg_out < RPMI_MKVER(1, 0))
+		return -EINVAL;
+
+	ret = rpmi_shmem_base_service_req(
+		priv, RPMI_BASE_SRV_GET_IMPLEMENTATION_VERSION, NULL, &arg_out);
+	if (ret)
+		return ret;
+	priv->impl_version = arg_out;
+
+	ret = rpmi_shmem_base_service_req(
+		priv, RPMI_BASE_SRV_GET_IMPLEMENTATION_IDN, NULL, &arg_out);
+	if (ret)
+		return ret;
+	priv->impl_id = arg_out;
+
+	ret = rpmi_shmem_base_service_req(priv, RPMI_BASE_SRV_GET_SPEC_VERSION,
+					  NULL, &arg_out);
+	if (ret)
+		return ret;
+	priv->spec_version = arg_out;
+
+	return 0;
+}
+
+static const struct udevice_id rpmi_shmem_ids[] = {
+	{ .compatible = "riscv,rpmi-shmem-mbox" },
+	{}
+};
+
+static const struct rpmi_transport_ops rpmi_shmem_ops = {
+	.of_xlate = rpmi_shmem_of_xlate,
+	.get_attr = rpmi_shmem_get_attr,
+	.request = rpmi_shmem_request,
+	.open = rpmi_shmem_open,
+	.close = rpmi_shmem_close,
+};
+
+U_BOOT_DRIVER(rpmi_shmem) = {
+	.name = "rpmi-shmem",
+	.id = UCLASS_RPMI,
+	.of_match = rpmi_shmem_ids,
+	.probe = rpmi_shmem_probe,
+	.priv_auto = sizeof(struct rpmi_shmem),
+	.ops = &rpmi_shmem_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/rpmi_proto.h b/include/rpmi_proto.h
index 012ae93d7317..4b557bfeedf5 100644
--- a/include/rpmi_proto.h
+++ b/include/rpmi_proto.h
@@ -60,4 +60,27 @@ enum rpmi_servicegroup_id {
 	RPMI_SRVGRP_VENDOR_END		= 0xFFFF,
 };
 
+/** RPMI Base ServiceGroup Service IDs */
+enum rpmi_base_service_id {
+	RPMI_BASE_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_BASE_SRV_GET_IMPLEMENTATION_VERSION = 0x02,
+	RPMI_BASE_SRV_GET_IMPLEMENTATION_IDN = 0x03,
+	RPMI_BASE_SRV_GET_SPEC_VERSION = 0x04,
+	RPMI_BASE_SRV_GET_PLATFORM_INFO = 0x05,
+	RPMI_BASE_SRV_PROBE_SERVICE_GROUP = 0x06,
+	RPMI_BASE_SRV_GET_ATTRIBUTES = 0x07,
+};
+
+/** RPMI Messages Types */
+enum rpmi_message_type {
+	/* Normal request backed with ack */
+	RPMI_MSG_NORMAL_REQUEST = 0x0,
+	/* Request without any ack */
+	RPMI_MSG_POSTED_REQUEST = 0x1,
+	/* Acknowledgment for normal request message */
+	RPMI_MSG_ACKNOWLDGEMENT = 0x2,
+	/* Notification message */
+	RPMI_MSG_NOTIFICATION = 0x3,
+};
+
 #endif
-- 
2.47.3

