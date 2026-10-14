Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183CCCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD25F80E28;
	Wed, 14 Oct 2026 14:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y8hvN577j7lk; Wed, 14 Oct 2026 14:17:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 32C4D80E22
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987454;
	b=tcKHhUtfa9l5bVwXG1izhtR7v1SJHuuRA7JN7sDBzyQO46kgmnd4PdjAhDPC3nDc43Ur
	 voCjqMUlbn4rsQBGHYgHtC3+DBN2KvcwZ8e0vY+JBf2LQGzLGMvoJwQ2yBfHzue9G0fpm
	 /aeiSeS6kWC+gmaNSG98Rw80RqnDEmNh9WOIO4W+xLS8WCIfHu0oFT1OQoHirR2xnTX7/
	 /RLiIcl4hsdL5y3qfQDCP511r1sIp47BelmCdHj6hR1YDN8hXSlTMPbgijzvV4sEX7QyJ
	 9Igg0NhWswppK5IpnSms02dEWEAsxsXwSP+FbTnVX0sefK5uCvBLSOLTzllj/ke9U4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SLFp2Z3foFonA8+/7Ksov6H6a6+3OAnXLp7Zyj5d6po=;
	b=M+5QwHwZho49fMA7PCvUBKbPjBjEecgiqxAXngpC7IQzH8AN31f0yWfeCKagyUq4EVCN
	 PdeSiOYNLgFMwyKudwOINDEUb63ZX49+DlRRMeiXxD9jT44LnVJ8iygVGDf401gh53SKe
	 +7A73pfxLD0K4vFd55GWoDDcGIfIaLTuiu9NfC7JzEN37fju7KEZZKTQF9oQlRk7qTbd5
	 bG7pn7jUQSspYKXVoC0yMce0EI3PKYYSV4px6zO+ge5rzzTbumtV3W4hks0EfmonCR1JN
	 AmN8hE9aOIvS6QKBp2AvA+cG/0DTOhk1tD6zDA0hVlECd08duJsBLVc1VfXIIH2Eu0A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987454;
	bh=SLFp2Z3foFonA8+/7Ksov6H6a6+3OAnXLp7Zyj5d6po=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FJmTql90e0adHhGY61LpEqEwLd+KTYHW3LirkNoKImma2ff2VKprQoimmiobcGpts
	 q+EtxaSko6jZWZ9LB55GPUjQYUTt4Bna4gwaUTRzzsnxQauLzHyaKVdjIE1Zg2lYYZ
	 +iCbt+9pAj5PT4XYi4tggrxQbgRDojuSEuSQKJwWR5fESTO1ieIUe4YLOywgww4gYf
	 9L8k/YmgCgd/Ii+qs2F7xTomtS/2kDZQq0hWHFfU+IP+VAWXHKESmnS83xoK5EkMlR
	 EjILFbuDeAazhwurllcNlAbNukUjpPXrO9k3zYrgE/r6cOpeTCPvIJVtWCNxP6L3fS
	 zJy7i4owHbfJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32C4D80E22;
	Wed, 14 Oct 2026 14:17:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C7802A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E2BA60818
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7rLuRaqfNnbJ for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:17:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A003F607B6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791987450;
 b=sZdIGIoTEomSgu3hfSLjJ2uAovv4hiKKB/BL7WeNuL+a+6vM90KPwzGhVyRe9HXu/N+T
 ehLQc8TIlElvf5UAV+upQ/X0rnTcvd6B66BebLTbPk44cW5pHpCr653dHEdnMWNBJiIZD
 4gqM7Js4klEIu1O302XfC5u4mlPYjVScCEIWpxD1jwP7V5IKoPHYaq6PvlvFkQ9SMWth0
 C+UUGoP8Bu9kjNWnCc0KdbctjhL9p3b7Ig8ppyE8vOigUd+aUk1QgA4q2ABCJX/lj7m8R
 Uv5LJkbkBVFQQUUCf9gepCtn/haF3anWhYpj+VPjVNxg1ZmHwdbxby84I+jn/2/PnrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987450;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
 bh=SLFp2Z3foFonA8+/7Ksov6H6a6+3OAnXLp7Zyj5d6po=;
 b=ENh2edUe893pclZuDmWx6kLeyPXUZH4bZCwq0l+AWXqWeAcda4X0p9oyIBNtnB4SmyhJ
 kmkxrQwu+b6r0RxvpCopX9PjYx6MdkDiZAn4TBZ/9KRd2YFaZk7h3GeBH/ACB+kJO1K0p
 E9ZxxbYuln7zNokSwrCGOfPzI6d9XWGZqIUPttfwsJ7p1uyjBLSeuYfdAJEaL6DzT+SWP
 oZrNR8urg8gMgAiBfiDS0ELoyD1oWbw4fe7/yHKq4YH8rotkCmy6WJrTQhSo6CVNyrg7V
 PkhfsDqEaJjw7A5MqE6c1WZX2WpoMBzPlPR4Cm2q4QCx5lg+1tTbknhpTk6JXVCwKFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=IrcckJp1; 
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=IrcckJp1
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A003F607B6
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791987450; x=1823523450;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=MFfUmsaQD8hRikIiBDEpw42h7H4sb4z1Gikv1dH2JY0=;
 b=IrcckJp153cP7opDI1KTpO3Vz2zH+B/obApiRz1X5XxdcTkFLYMNEOP6
 30rwXy7kE2FebGcXca/CRX6i+Ox7aIF/DgdAGdM2WnKI8t1MY2CkJR3jX
 c7LK7WsP0FZTyKvmHTO8udAKamhrAPPYxTwje69M+x5YGiDSzszq6resS
 8oT54liZcnS1rNuWxqHQ02Beo6MtyQL+8UnXrEWVePxDNEaMern/8wTpd
 VnegAWPtLF9pYxKMxytCC1P80YUadlLkhbz6I0kmGvdcDgtOHf7D5Z5Rk
 BHZ3PSehyaLDfAxHK7idVK2sMiF7qSczhQe2msRabPQssv67L0LfsElw6 A==;
X-CSE-ConnectionGUID: fG7KpiKTSYuDTZOVeSg5Xw==
X-CSE-MsgGUID: 2Wgkxbr+SIqNhdG3WMAj6Q==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; d="scan'208";a="65036173"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 07:17:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 07:17:28 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:17:25 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Wed, 14 Oct 2026 10:17:07 -0400
Subject: [PATCH v4 3/8] firmware: rpmi: add support for shared memory transport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-rpmi_v4-v4-3-d53d34a49780@microchip.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
In-Reply-To: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
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
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
Changes in v4:
 - Fix the default value of the doorbell from 0 to 1

Changes in v3: None

Changes in v2: (from Yao Zi review)
 - Reorder headers
 - Don't null check pointers before free()
---
 drivers/firmware/rpmi/Kconfig      |   8 +
 drivers/firmware/rpmi/Makefile     |   1 +
 drivers/firmware/rpmi/rpmi-shmem.c | 473 +++++++++++++++++++++++++++++++++++++
 include/rpmi_proto.h               |  23 ++
 4 files changed, 505 insertions(+)

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
index 000000000000..db9949e39c7e
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-shmem.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_RPMI
+
+#include <asm/barrier.h>
+#include <asm/io.h>
+#include <asm/types.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
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
+	if (priv->slot_size < RPMI_SLOT_SIZE_MIN)
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

