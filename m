Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA900606A330
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lY7GoyI8;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=wSsQkLSI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95BB5817EB;
	Fri, 13 Nov 2026 19:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MC4IvKRpaO6W; Fri, 13 Nov 2026 19:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B415481801
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794599005;
	b=L0+taATFoZd/SKQgZQRKt+36w8A4qFR1zncMKk6poJXuwIDtsYSr7o6BEJvU+ZD41c+H
	 wMk3DdXaJIhluR2Aq/pak71XoNFQcUiLbm8Bg4T0Kxi23kZbre5ZJ6ZxxLFOlKmyMciok
	 gfLg0YyYqpW6pCqZPHIjaDIeroh8fN19FXiP03OClkZObbiG+0GvFgaPTmSgSED10EMlD
	 5xTSr939RZqNayHVu2RiTgtKu28luTZbeaZ+wbFNLnn1A4gUBCMGeMhwS2V34DXfN6OTS
	 /lqiCKU9Or4PPt90aSzzfTajbm4OLilKWkBSFWQxea7jCM0Y9JZg3rgzqS6r82JevcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UPOtEeG+yXMX0M0uQ4ak37guwwphqR0PL8k7+bMDrno=;
	b=pJFsA9F65M4q28fFpjcvubxbvyqX7cAWUAsbx+h4yJRUcUXPYF3QjYdMz3oG7eX0diiu
	 gIXv2Vu3PPh34+4kmAjZxVw4Xy4DZvMOkykER8MPwcMaxp+YwQCfD8JiiNjTHZyOxMwvS
	 LD2Gd9zdIN03sT9gjhMSEzFGrP/aE01HoPeFOOYy5kW4SGluK/pCWca3tAyAR2pm6+wxd
	 wHAOU1kLxmrNfoWOcOmBE2HwCwEwOcqu/xsz03ErabSsU/NXh2Fe/XDVRBXpABmZ1hp6B
	 mP3VxbKsRAkJqOiq98p5J0TZMijpJYpNhoUBgJJItaHG0wn6sxp5vChDbUDyCsq3EMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=wSsQkLSI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794599005;
	bh=UPOtEeG+yXMX0M0uQ4ak37guwwphqR0PL8k7+bMDrno=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lY7GoyI8ABTEvgkW9Ue6P/DN1Fj7jG47cFqebhSYcsEEruPnhUnjkYSBnoQYrvXkg
	 lMD39aODa+Q1eHxc8L1KojgUZqn9y0ISiQk/MyjleRtKbWIoxoVV5CYxoG6xUJ+j0S
	 J97dqe0PblZmt5dTlfBZxE3rvYxwDBj49fczFAnupFf/JPXpdDL9hQR2C92Ww1e4HJ
	 aRzqqvUBo1Fv9bLjT3p2L7mZAA9JyQ3YPU7xNuXfxNs9kQX0gDSM6xQ+AvGMEDQ6gT
	 U6CAYX5E43OLavSnR1tI8YL4eYO9nyv62kH/TqjV8/XnPBGI7wqyDO5Ct+z6uRJyHn
	 gwHnhRtcc9cFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B415481801;
	Fri, 13 Nov 2026 19:43:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C6EF2150
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B947A81771
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoHy5fdAuPUB for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 19:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D58D81429
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=wSsQkLSI
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D58D81429
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794599008; x=1826135008;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=JvPqcjHGJVPPSseffFcty5vFsEBACYtTXnRUInN6/Es=;
 b=wSsQkLSI6OKBQFizH0e1tQKs349ocsnQRKX5WVBaSbpR9JgPE0n+lTDl
 1vNcVji/DSYX8HdID+eqAgnsIoz1EXhQsg/F3i+tc56smtbWC4VPduNtf
 /9/BspRL1xj8h6fRdvlhjxiSl1gC1aeMUk04V/7BJrnrEsXgcdRj2aeY8
 2rvJsWWWwD9p3iL6ppassodCNWtIzA500K8Izq3oGqRlqp7B3+UcEQ9IM
 v47RwlW7LO3E+Bs1v9vpFWSmYIBXGs8jpndgEXKhAVODR+C1xjGcUzoAU
 oj6gYI1ndL4z3swA0H6+4vpfJ52uJXv/xMGRxVyYIYvYwhUPJVYqVLw/g w==;
X-CSE-ConnectionGUID: 7i+ZqHN/TkWEOYiS0qqoEg==
X-CSE-MsgGUID: unmok7fTSs2wWsip4N4rdg==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="233536280"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2026 12:43:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 12:43:18 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 12:43:16 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 13 Nov 2026 14:42:55 -0500
Subject: [PATCH v5 1/8] firmware: add support for RPMI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-rpmi_v4-v5-1-6787318ad186@microchip.com>
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
Changes in v5: None
Changes in v4: None
Changes in v3: None

Changes in v2: (from Yao Zi review)
 - Reorder headers
 - Improve error messages in rpmi_check_versions()
---
 MAINTAINERS                         |   6 ++
 drivers/firmware/Kconfig            |   1 +
 drivers/firmware/Makefile           |   1 +
 drivers/firmware/rpmi/Kconfig       |   9 ++
 drivers/firmware/rpmi/Makefile      |   1 +
 drivers/firmware/rpmi/rpmi-uclass.c | 144 ++++++++++++++++++++++++++++++++
 include/dm/uclass-id.h              |   1 +
 include/rpmi-uclass.h               |  79 ++++++++++++++++++
 include/rpmi.h                      | 159 ++++++++++++++++++++++++++++++++++++
 include/rpmi_proto.h                |  63 ++++++++++++++
 10 files changed, 464 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b38ffee2886..765131030370 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1567,6 +1567,12 @@ F:	drivers/usb/gadget/f_rockusb.c
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
index f524f741e548..65aff995758f 100644
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
index 000000000000..a18d5912a63d
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-uclass.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_RPMI
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <log.h>
+#include <rpmi-uclass.h>
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
+		dev_err(chan->dev,
+			"protocol version too old, found 0x%x, expected min 0x%x\n",
+			proto_version, min_proto_version);
+		return -EINVAL;
+	}
+
+	ret = rpmi_get_attr(chan, RPMI_ATTR_SERVICEGROUP_ID, &servicegroup_id);
+	if (ret)
+		return ret;
+
+	if (servicegroup_id != servicegroup_id_expect) {
+		dev_err(chan->dev,
+			"service group match fail, found 0x%x, expected 0x%x\n",
+			servicegroup_id, servicegroup_id_expect);
+		return -EINVAL;
+	}
+
+	ret = rpmi_get_attr(chan, RPMI_ATTR_SERVICEGROUP_VERSION,
+			    &servicegroup_version);
+	if (ret)
+		return ret;
+
+	if (servicegroup_version < min_servicegroup_version) {
+		dev_err(chan->dev,
+			"service group version too old, found 0x%x, expected min 0x%x\n",
+			servicegroup_version, min_servicegroup_version);
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
index d4822177764f..f6f1c378c2e7 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -130,6 +130,7 @@ enum uclass_id {
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
2.53.0

