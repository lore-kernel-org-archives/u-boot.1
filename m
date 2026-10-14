Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E13CC6B2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C3A380E0D;
	Wed, 14 Oct 2026 14:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZg6Bb_8FI5M; Wed, 14 Oct 2026 14:17:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 876BF80DD6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987447;
	b=kMsJC6YNM0lbGXjeit2c7GyqV2SShutfX0RVa8PodI/tIo2Df39+GG2DaaKgdr3TA5Sv
	 4n9feyI4WLTNj76CHaUBlP0RGFL6HE7U4U/yWU3987LPowp4V+LjTY7IzN3JGRd3qfkMf
	 R79sChWzAku2h2sc0Un7rbZ9pfeP0MIXNkkCOiU5/dMk2OGteWqYS1lf+kJGWk4c6PPSC
	 Wq10AjtlRvBaTofuCEHEfqDvxc97w6F0Cmx60IiTTWqSTp1X9iH3DQ2SUWHYpV4XX1mcA
	 oKcDIhFqKx0gLbcRMUzLkNwZkInGfh8ur9YLEMUkRQB6SArMUu+4FEctlmEestzB9Ow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987447;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U2jViU1x0Wk7n7D5EyX3P5Wp4MvCfEINBy7vKd88kHw=;
	b=OnI0dp5+49jB7za87P4wnnJDTry+b1E3LMwRqinrXRtQ1/T1lJ+vNI6ez+/14qKV7/kh
	 jj1IFCDBr6ihsDWdAhy+JvOpTJyMc8R9rgVOBAr5/ssp70hsdMvGcwIKMk7MQPqGOGnOK
	 iR57CMEmwDaR/sM+P4cp4R9cfuSkF5dFqDbhAkRsSrhwm7Ip4dDiIagM3/9eBC362qFF9
	 3LDylCxWsVP5NjK2jD/hEAirYjelHw1Ox92lQghju8i4E8rP6jum+K0MmdK2LgEqIz+5O
	 40trwYMva97z4/xDtbKf17ig4nBbH44AhIwiMTLuOVpg3sDJXdednPNIlzm7HGtn0vw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987447;
	bh=U2jViU1x0Wk7n7D5EyX3P5Wp4MvCfEINBy7vKd88kHw=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pVRkoIoI85I2RcFyohyuqVifOOlLGlzhDEN8d4d+DhhedIDXuKXpbutT7+rB+2EWD
	 ew6AFt9955ltHfxW2PPXGTaAOZZtZd9CQvtL/CuTTIPW+d2G0uULxFWrgQ+tuFuepY
	 HpMW0r1YBvdi2c7TkZs3X8061uEmbz7aPDnQlGN1VdO1uVCupaZ7Lr5G27B6ezFjIc
	 gZDOTtceMkMPy5cOHwuqZWV/MIELdQ50c2GKvkciSMV3PCjzYdMg0xgKSkB2ivPNe1
	 iVPR3j72goBLxvVxad+dBilsk9Q0+UDjaQWxqIbVvqLKDFtm6ywewUFgVlu6G/C7kv
	 YtSX9qBLCY6PA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 876BF80DD6;
	Wed, 14 Oct 2026 14:17:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA0432E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C1E33606C7
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5Oqk4AKZkSb for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:17:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E128C606B3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791987445;
 b=VAGzfeue6E9VIdB2SL46mZdxrtWeK4WdjpErhU34fQrGpcj3ewcjQHrf3elLpJag7y3h
 1WUjoW4uGKZ/hD9yZKLjl6IGw5rz3MuNDID6A/PGyyyamLDosyZbRqtVv2Vf2fuSvXiAp
 ZxYp2p4XZ+AyV/C6LwDnr9OwRbdOmxQRxmZvHvS91tzQqVOa5W1xUaBhm3qUOOIqf6Vc+
 CxvJKBqdAuBHnAINbG8B8p1fF/fWO48gdgLBBH3YpOZlZzmb2FLqIY+h8NOB2lFhfh1dn
 dJfM8Y1FQvLGcxSnlSjbwF5XJbSxom1iFCPNErCdHYl7YFbTwPALuGwwWNWDFKQQlIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987445;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
 bh=U2jViU1x0Wk7n7D5EyX3P5Wp4MvCfEINBy7vKd88kHw=;
 b=JPxCthEq3iEc85tIOvOe5W+3EvNLdEhALmjxvsxlgkTTi7Z/o7Hny/N66ZNjtC7AjxNI
 8HeYXZSnQguOfXBm5DPMpyAg8v+9fx6RrlrOD+hah/E8BNkzdBh917kspcVAtmFUE9lvh
 qPEb2Uii9wjt7grvlYjly/pbGZLaHn8IOVXRRltIE1ZjZKXsUwcDdfzpIdhn0j/WPBeas
 2PEqItamY5h/B96XqGTN97+LpKwxlGjP4ZSad/vyhSOZlXZo4yLs9sAzyLhp0r34V0DH4
 XMxCWUEmhp1X+LRLioO88aXoAcLZzZrpUyJuYVDQeGnIxrGhN7dg+5O+ZLiPWiKW/AQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=Vctk3NHj; 
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=Vctk3NHj
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E128C606B3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791987444; x=1823523444;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=JEs3B7KMozv2JhDqVvpYrUXkF2361S4T8HoD1uHCa28=;
 b=Vctk3NHjqV++SilndVyW7g18+GQj/jCUto1MKGaiQCZdNrOER8aRP52q
 PpDMf/NDat2cnnGwXxRoRKgvWvFejtv3sMleGdGLNzJ0rpwEbYcZGx/Vw
 KzVWARMZ4F+vzjCYUcLETXLDo1QjaoQRN/qqQ2yIriOtsp8xni1f8YwT1
 HInbnm9JoEpHW/z7MMd40faJ7DdrQVpkK9bWwpdprzpeuod3aYpiyEZ+l
 SrDbGYXZRQ7RiDDEBjW590zGlxDOJxGd09Q3q85oHVyHzZOCheMWDQa96
 mtF0ULWeZ7t/LnT3HDZELoUwusrgJe56vNvoe/gfgqpL5xrXhFa22G3UT g==;
X-CSE-ConnectionGUID: DHHuGIFHQu+8GOrhn1WXbQ==
X-CSE-MsgGUID: G6O3o+jORvaUpjDNlq4pFw==
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; d="scan'208";a="232123101"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 07:17:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 07:17:22 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:17:19 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Wed, 14 Oct 2026 10:17:05 -0400
Subject: [PATCH v4 1/8] firmware: add support for RPMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-rpmi_v4-v4-1-d53d34a49780@microchip.com>
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
index d1f51d9197d9..1b3c2376bb93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1558,6 +1558,12 @@ F:	drivers/usb/gadget/f_rockusb.c
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
index f0e1a02d6245..f0a90d058b26 100644
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

