Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2E606A32D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qt74P6+A;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=dWnNPHqY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D385260687;
	Fri, 13 Nov 2026 19:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rv4KvtP0FSep; Fri, 13 Nov 2026 19:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 660A66068F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794599008;
	b=k2wDRqEGvz+4XsV62JF0F95KydAUPfkruiRDbsfwhGQYS4wQ1CfEOA8Qjt7f6dxKqa1X
	 HvbyexNjUzG8ihwAXBrxXyyZ3zXF6rfmU3ho7V+YMCC7PG8COt4pwgrThYN1ja3IUOtZV
	 dc+c0Y6dJU2h+dgq8oaLdy15w30MUZ7uXc86lh+1VfG6bZpkiNBoz+LI4oSpgmef9kki/
	 5OX/N9g/Hqu635othvXWcLO0jZzpnFSdNmMNWVhic/Gzebrvw3M3+mtAPUjgj9jntzQRZ
	 aohPY8ESr09tsCMRnwSRRQMNFYBAOA1KTE9hVuuP7prfy3StVUdKta5dkicfrG13VXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kb3hSg1jcfxkIL/R7icWetC02lH6wC2pEXOtIrILOmc=;
	b=cpie+IcRv4CXCPuCQuOxNYcY/4cjZaVJEePgdVN9nQToFQ27VPyqpi0R4ZcIbfTMConw
	 JfDxieboYsJmLkp55Dhn2YVa3WhsXURgoNwSvFVYwWO1/s2Q2Rknbs4yvKVRMZ6UdlYgt
	 by53vmTxR79PsX8pAG+bxfbc/+vZcZEL4M40H+i6k6LWX80mtnqYAaUV18vqgMvGwpAtw
	 T9EhWXniPxc9P9eTjzyxrAGX/ILGQP+4nAA9cp1ane1/NQ4SzSfpLc/Lit7xDdC/gI+A6
	 RPLBXPJwdV9fRzkGEs9ah8MJ6yRtuyJp3KLJe7DbTNWeoY+/skNx24+udzw8CUMrK0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=dWnNPHqY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794599008;
	bh=kb3hSg1jcfxkIL/R7icWetC02lH6wC2pEXOtIrILOmc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qt74P6+Ag2F81BIzIvLEKjIlbKS4hY1sf2w2ZCX8Y4W7t1/qyaJPwXVbLiBhPbL2n
	 DeBw6Qu0esP0MnurVQBMZ9vo/mTXiJzTK9CEand5TvDmWMn7T54p6jYDorUgdAGuWK
	 zowQaS6Tw2uUVLf5mWW6gxlCpJjqBiVizgyFcVs/IlZlmHjNIv+alkYnqWgtCELiBD
	 1P++536O0Udro2qruOPb0DuDZbq8vzMhNnD2L1hrAIwUanoK5uC0eobluPs3VQ/Cxi
	 HUoUdutiqVKGNGwkFmPFjaQhdxvQDOrtq66vvocG9GdBL6bE9eYwSGIQvgXRxSCqU4
	 pi6TMeHVPOWjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 660A66068F;
	Fri, 13 Nov 2026 19:43:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 789B7260
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EB2A6068F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QBOl4si2hypk for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 19:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1E5E60687
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=dWnNPHqY
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1E5E60687
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794599004; x=1826135004;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=31nFUXlwJmpiBbuhekbLYMWglyORCiVodAJaAa2Pd6A=;
 b=dWnNPHqYw78FY7l5J1EHcMu2Dw/fQM6LZZeeunw3rPNrtz19GW4Ntwkx
 0SivU0zFV3orgI1GC8CgSmmZzxVIyFPtZalGTqvZiLq1ZpXf+Va8mLbxR
 wcT7tDMN6mylLdF9TdvgUs8rGUF3qLHfCJJd6z2Qeu5Kz5MVtAAJPazqX
 gIwGovN82oTHApu3+jJx5lteMg1DZ8yBZS+Xlfus3XVduvfasGlGfwSQs
 odr0cqEvGb6wy+iGZgGdewou9kjv4T5yQ8G3sfIFrkEl7Wp3Uoalxtn0N
 9tlkY87RwiWh9z+kVTIuD13qVCOmZAopiq8clAikI993kIFjuUSbfjj4x Q==;
X-CSE-ConnectionGUID: +krOPsFNS9afYAXMe2iI/Q==
X-CSE-MsgGUID: fT4mM9RrR1OXuFjMeKfz+g==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="66724958"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:43:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 13 Nov 2026 12:43:21 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 12:43:19 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 13 Nov 2026 14:42:56 -0500
Subject: [PATCH v5 2/8] firmware: rpmi: add support for the SBI MPXY transport
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-rpmi_v4-v5-2-6787318ad186@microchip.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This adds an RPMI transport driver for the Supervisor Binary Interface
(SBI) message proxy (MPXY) extension [1].

This is for S-Mode U-Boot where some supervisor software (such as
OpenSBI) runs in M-Mode and handles the low level communication with the
PuC.

[1]: https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v5:
 - bound check the returned message length against max_xfer_len
   (from Subrahmanya review)
 - Makefile: compile MPXY only if CONFIG_RISCV_SMODE is true (from Leo
   review)
 - fix the case where sbi_get_spec_version() returns an error code (from
   LLM review)

Changes in v4: None
Changes in v3: None

Changes in v2: (from Yao Zi review)
 - Reorder headers
 - Remove struct sbi_mpxy_rpmi_channel_attrs and struct
   sbi_mpxy_channel_attrs for simpler u32 arrays
 - Don't null check pointers before free()
---
 arch/riscv/include/asm/sbi.h          |  57 +++++
 drivers/firmware/rpmi/Kconfig         |   9 +
 drivers/firmware/rpmi/Makefile        |   3 +
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 415 ++++++++++++++++++++++++++++++++++
 4 files changed, 484 insertions(+)

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
index d69c718d150e..4976176f07df 100644
--- a/drivers/firmware/rpmi/Makefile
+++ b/drivers/firmware/rpmi/Makefile
@@ -1 +1,4 @@
 obj-y	+= rpmi-uclass.o
+ifeq ($(CONFIG_$(PHASE_)RISCV_SMODE),y)
+obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
+endif
diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
new file mode 100644
index 000000000000..3398271f8567
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
@@ -0,0 +1,415 @@
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
+static int rpmi_sbi_mpxy_send_message(struct rpmi_sbi_mpxy *mpxy,
+				      struct sbi_mpxy_chan_desc *desc,
+				      u32 mpxy_fid, u32 msg_id, const void *tx,
+				      unsigned long tx_len, void *rx,
+				      unsigned long max_rx_len,
+				      unsigned long *rx_len)
+{
+	void *shmem = mpxy->shmem;
+	unsigned long rx_bytes;
+	struct sbiret sret;
+
+	if (tx)
+		memcpy(shmem, tx, tx_len);
+
+	sret = sbi_ecall(SBI_EXT_MPXY, mpxy_fid, desc->id, msg_id, tx_len, 0, 0,
+			 0);
+
+	if (rx && !sret.error) {
+		rx_bytes = sret.value;
+		if (rx_bytes > max_rx_len)
+			return -ENOSPC;
+		if (rx_bytes > desc->max_xfer_len)
+			return -EIO;
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
+	return rpmi_sbi_mpxy_send_message(mpxy, desc, mpxy_fid, service_id,
+					  request, request_len, response,
+					  max_response_len, out_response_len);
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
+	long sbi_version;
+	int i, ret;
+
+	mpxy->dev = dev;
+
+	/* Probe for SBI MPXY extension */
+	sbi_version = sbi_get_spec_version();
+	if (sbi_version < 0 || sbi_version < sbi_mk_version(1, 0) ||
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
2.53.0

