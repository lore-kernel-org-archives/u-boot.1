Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C584B606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M3mo4Nmw;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=aX3KO6O5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B16B60DE2;
	Fri, 13 Nov 2026 19:43:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3snuQeTbWxqf; Fri, 13 Nov 2026 19:43:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A21860DD7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794599012;
	b=MGra2yorfW7JqHusVG87SAd+fusKSpGnvl9EMzvRu2bs7z1ceas7Bh/rM40NvnQmbWC7
	 AnEhtSjQreMNxWOHG/243SeZT1eKUOzQpxzgVitiMguQRzuIwl5D6fvBf2JgNr1cw8gUe
	 vvlaE1Vi/C+AAG3bhsV3EctSsVcl8QHYeBQNdvE07cmD0o/Ag+Zv5iCPEeWSwZYdYlM8C
	 MwFplxc77kxcrhQvUFevd14GlkpkiGTvJivoQ5hF4v2ooTnC1zW16NecHyEiYRtEznLWL
	 WTWGF/rn9k9Nqh5LH1y/Yo4jVrqvdLRaP6ypbRplNKFh4Ly3U7Zis7CxkaIP7RS4q6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NWVnIAD9RLf81Qe030vBrx13eWXmaLCAIQLrmbDGxII=;
	b=qhUgOq/3RWAbNEbmdmeJ8zNTPS0X7CUBxkijB/ZJkA8rL6GoECCb3VqyiuB3Gb/LHjgc
	 6pJ/JqkcVmdUEvMEhT/veMLKTwZ2U8ciXsrTkhpioI0DO3BJMFRQq4cnK8LAGLnlYn8M5
	 y68yja3q7tvXATYYuuN0IPCIn+rWm7WtmQYcMCjeXwVGBsCl6/izTM2nedgzpW/dccJv7
	 rO+99VEBIW6i7VIGIZdozlXyr/k6d5lMCNUdBv95EKbV8ib8RfXu0v4yUYJmMLdLuuPqq
	 +6sJjdtcuktyrweZfZ5T3gJPEUsOXzdfBP2UhB0hDOcO35G/UGWwt2PuKOKAU3Pn/HA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794599012;
	bh=NWVnIAD9RLf81Qe030vBrx13eWXmaLCAIQLrmbDGxII=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3mo4Nmw428TCn91P2ZbIjsv+OVVrNG68UfZa5f8xEQqMENeo6i+835ug6myZMX7H
	 3AguNQPULghhmUMPcB1+ui8896DxzGkIYGfgxAb8LdvAyMysUf22TID6Iug9B0BUT9
	 YiiHn9X1//jK+TBnpFmK402Xzm4AfPaArhJFfqn0OKhYe9VKn0BRY9XJlBgB7Zvh6i
	 6tX7lv4kOyjp06JYyTG7dd0L5bCnVDeebwS/howwoDt9y2Y13pGY/+dhnFzFG8uy27
	 mFve0iz37+Gj2mG9HM0/zvSXC/QH2NFBxxpNMjIvgBlF4dGCw9/xu2wQ8DN7bWMiOw
	 JFiVX0oE0DR1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A21860DD7;
	Fri, 13 Nov 2026 19:43:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3DB2286
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A4CE40E0E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DyXHyaMjNniA for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 19:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB94E40E0A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=aX3KO6O5
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB94E40E0A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794599007; x=1826135007;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=X8PVtROsbrNTW0LS1BPKkQS2KaxlTYlCiFCbrgxhdMk=;
 b=aX3KO6O5cPgjskpiy/0Ae/O6KgFZEafvUM+3VkOQuRACDaOzdVCXK7ii
 +yFS0RlOz0MwyRRozg++ftp+EaBybOpuJnJMFKUy9LBEErfcVNDdVQwBi
 c3ITucoXG6L0emxqLHnUyhWfFKiQ/UME2zdSQi8jmPFNJjEjCf/H1lV3n
 mJcP5mNZnJP9V8WrvRer/1o8ZA3akDx6ALw9oObZI3Y9RR8ohE22vU13M
 xaYT4kqT8yKKShzkSlSLE4jtJU7xzS2Ow6rROHKFlZdKNETp9LzsN36+k
 XSYYfyN6t9CgZuflc0xwuVWIV9vE8WGgrit9yKyfzL1B0cFsRm0UBKakW w==;
X-CSE-ConnectionGUID: GIs0LhiESDe39cWvDoVWUw==
X-CSE-MsgGUID: IwpNKcUhRCqjPo17WDPfbg==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="297899951"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:43:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 13 Nov 2026 12:43:24 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 12:43:22 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 13 Nov 2026 14:42:57 -0500
Subject: [PATCH v5 3/8] firmware: rpmi: add support for shared memory transport
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-rpmi_v4-v5-3-6787318ad186@microchip.com>
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
In-Reply-To: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Yao Zi
 <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>, Subrahmanya Lingappa
 <subrahmanya.lingappa@oss.qualcomm.com>, Charles Perry
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changes in v5: (from Subrahmanya review)
 - Access the head and tail via readl/writel and data slots with
   memcpy_[to/from]io. The memory region used for the shared queues might
   not be normal memory and should be read/write to using IO accessor.
 - Match the service_id and servicegroup_id in addition to the token in
   rpmi_smq_rx()
 - Reject responses with -EIO if the size exceeds the slot_size length
 - Make sure the slot-size is a power of two

Changes in v4:
 - Fix the default value of the doorbell from 0 to 1

Changes in v3: None

Changes in v2: (from Yao Zi review)
 - Reorder headers
 - Don't null check pointers before free()
---
 drivers/firmware/rpmi/Kconfig      |   8 +
 drivers/firmware/rpmi/Makefile     |   1 +
 drivers/firmware/rpmi/rpmi-shmem.c | 496 +++++++++++++++++++++++++++++++++++++
 include/rpmi_proto.h               |  23 ++
 4 files changed, 528 insertions(+)

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
index 4976176f07df..87ef3623a93a 100644
--- a/drivers/firmware/rpmi/Makefile
+++ b/drivers/firmware/rpmi/Makefile
@@ -2,3 +2,4 @@ obj-y	+= rpmi-uclass.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_SMODE),y)
 obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
 endif
+obj-$(CONFIG_RPMI_SHMEM) += rpmi-shmem.o
diff --git a/drivers/firmware/rpmi/rpmi-shmem.c b/drivers/firmware/rpmi/rpmi-shmem.c
new file mode 100644
index 000000000000..f07912a56846
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-shmem.c
@@ -0,0 +1,496 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_RPMI
+
+#include <asm/io.h>
+#include <asm/types.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/log2.h>
+#include <log.h>
+#include <malloc.h>
+#include <rpmi-uclass.h>
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
+static u32 rpmi_read_head(struct shmem_queue *qctx)
+{
+	return le32_to_cpu(readl(qctx->headptr));
+}
+
+static u32 rpmi_read_tail(struct shmem_queue *qctx)
+{
+	return le32_to_cpu(readl(qctx->tailptr));
+}
+
+static void rpmi_write_head(struct shmem_queue *qctx, u32 val)
+{
+	writel(cpu_to_le32(val), qctx->headptr);
+}
+
+static void rpmi_write_tail(struct shmem_queue *qctx, u32 val)
+{
+	writel(cpu_to_le32(val), qctx->tailptr);
+}
+
+static bool rpmi_smq_queue_full(struct shmem_queue *qctx)
+{
+	return ((rpmi_read_tail(qctx) + 1) % qctx->num_slot ==
+		rpmi_read_head(qctx));
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
+	headidx = rpmi_read_head(qctx);
+
+	/* Wait for the Rx message with matching token, discard any other
+	 * messages received in the mean time
+	 */
+	while (true) {
+		tailidx = rpmi_read_tail(qctx);
+
+		if (headidx != tailidx) {
+			msg = (void *)qctx->buffer +
+			      (headidx * priv->slot_size);
+			if ((le16_to_cpu(msg->token) == token) &&
+			    (le16_to_cpu(msg->servicegroup_id) ==
+			     service_group_id) &&
+			    (msg->service_id == service_id))
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
+		if (dlen > priv->slot_size - sizeof(struct rpmi_message_header))
+			return -EIO;
+		if (dlen > max_response_len)
+			dlen = max_response_len;
+		if (out_response_len)
+			*out_response_len = dlen;
+		src = (void *)msg + sizeof(struct rpmi_message_header);
+		memcpy_fromio(response, src, dlen);
+	}
+
+	/* Update the head index */
+	headidx = (headidx + 1) % qctx->num_slot;
+	rpmi_write_head(qctx, headidx);
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
+	tailidx = rpmi_read_tail(qctx);
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
+	memcpy_toio(dst, &header, sizeof(header));
+	dst += sizeof(header);
+
+	/* Write data into the slot */
+	if (request)
+		memcpy_toio(dst, request, request_len);
+
+	/* Update the tail/write index */
+	tailidx = (tailidx + 1) % qctx->num_slot;
+	rpmi_write_tail(qctx, tailidx);
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
+	free(chan->con_priv);
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
+	if (priv->slot_size < RPMI_SLOT_SIZE_MIN ||
+	    !is_power_of_2(priv->slot_size))
+		return -EINVAL;
+
+	priv->doorbell_value =
+		dev_read_u32_default(dev, "riscv,a2p-doorbell-value", 1);
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
2.53.0

