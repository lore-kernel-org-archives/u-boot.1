Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90654CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59B8C606C7;
	Wed, 14 Oct 2026 14:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6_Hx5de8cvs; Wed, 14 Oct 2026 14:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D800C607B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987461;
	b=P92O0FdMKq6phHuQfQyyhMi4Gd67Yzuga1giIw0ZkwEg0eO2EPt3j/4CZxZpcJW5jF50
	 WTtBJ+E/g3iddpi4phKbSQPD28a2rk+kY4mLNBy6D2Y+D43CzsBdgMxRapIGv6OCcl7Lj
	 y+4BkaXKFPziMaPoi2OVa8jrSUH01UGfg2d4KZ8CPc5c+Lag/OJMHhenkCdCTVsqfHu7W
	 sZb5u5g5CEHhFZn8WkYDxGfbF6olXl8z47v3UU1Fz3/2BdkQS6Q9lyRHMe9bn8KwODkqS
	 ZX3/8xKZ/bhbUeX0P4lWCFwo5g1AdpS50NK4MXXyvnQaQ8zFwvJXXpW8NQ3MFCu94ZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GlXYYzJj4rNtzrVuBMvltVt22KLn66vT9UpU9sfKoqs=;
	b=PNXxPWLQjCHI+Lnm3eA0stDHjFVGZ6V6q5d8YZ5bVDTjlbVlVaMHsalDttIa+2ydRTCA
	 bA4o0o3Otpx20HAxlTjdlFAueLG92/4p1N4ndHEj6aXFoX30H2sIGyGDgWiXYrV/6JITH
	 PgBEd9uOXD4w63CPikvRrmmC0tsM0aiI6BWp6dNlH2jPiBmmSti9tLxqa3p9vbqEBNyT9
	 BM1+q3+mew3l62faMdf1GIxUAsYm3JCYbypXPiMDd0+29wA40aUc4GlOKmOrybXJaKMnV
	 GCPVYncMvrUOLJnT9EvYJVrQPLI/Zj1Fg3tmOD5UVaXVqEmH+fv56MhrJ8GPd99Ipaw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=dUe5olxg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987461;
	bh=GlXYYzJj4rNtzrVuBMvltVt22KLn66vT9UpU9sfKoqs=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zqtnndb8ENcsIczmHjXL/vHE8ZErtknukpfioK9W8+T8gFkAxGs24nx+UMx8jOTV0
	 DuZWK6F0mY6hXLBF6IbPRp8QMnltOPvVJzLmYPQgtMGADR4wp/d/1IMbYR62UVlDpy
	 ekRNCcY8DjYmPAg0KWw2uHGagepY7a8orPml/m+haqjkcLt+n6rlpJpoI1umE4RPDt
	 c7XHYi9CcOKKeB1TSQ8FoJRHIEciz7icl3cOvRSEQqT5Z91P6ZUqkDtc8hCL7XxQO5
	 omxjQrlgyRW7qOgowjK88Gk2a1YFUo5bW3V9yyIo7UHHVkLfEWae4YVk8QD48A7ytf
	 GZTmrdHT2ZmkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D800C607B6;
	Wed, 14 Oct 2026 14:17:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D0E54255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6E46606C7
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vAlfSuxt9sCW for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D8C3607C3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791987458;
 b=LJl1ocDiiRN2xytvN2KTcFOkStWIFWFqRdk0lyEWPXiMBKQsXLTLUlbMOtyj9IksXhGT
 yqwruJei6uLDZeydHrCu/LEXBw2i3WpEJfCf395SGvSmifXPnQSlv1KskzCzqTpVTzVos
 M0DCPHmEDuI/sr3UIYE9Mn3mSQb+a/a5dHQkRPzxKy2hYmn9CYrgP9awf7ZQCi9Q3Wnzq
 cQyV/yYzi7S47arD9SzQMiUDBvs+8x26FpeOofDKqh3nVxLFzVJxvUiyflD7Hn6QNkShO
 ArwSF+tseXY2c1iLSk7dBtkKsd9KtqIfmTMES7JQzNBPvo37+5lASdRr8ITwAhtEKXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987458;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
 bh=GlXYYzJj4rNtzrVuBMvltVt22KLn66vT9UpU9sfKoqs=;
 b=avjGlvDk1QoKEIdtWjvykJmcmvcVtnf3Ww3P/BuruY68pQjzQDWLJeVkbzADd1+Uka1w
 enLLiH5KV/zJOj3jLruqGVhhd0qPbUqXtywHb0Ts9sI8Rs0QNnPPY9jh5nEQiNlSOCwzt
 fjjVhKKa/o1cYEzGoenIdnQPZk1bE5olEIKpEK3GHLMtGu0fUVIITtmDxhOKhwvN3mkz0
 4aoQkDinothV9XwFgGxEEi93AiU0SLUq7AYPJIqN5e8rwc4DjF7RA0C8msablvstF4zy7
 9c8xcx6yziMJPzlNvNJFzDKa57wF+JAYKskqUx7vRAjxWkvvWLVCb2uuxndEiL8hnOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=dUe5olxg; 
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=dUe5olxg
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D8C3607C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791987458; x=1823523458;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=RrEaxc85gHryyl/qaFeJWGMy/sEEjmIHH6t/G3SQog0=;
 b=dUe5olxgybTLEau1gCWVJc9a8ezhIORlwWFBg92Jj/Eu3vtDo/73HnfU
 l6840I6KraLdopC5Eh+0xeOrujaKcJtosvfcJClyTpUrFQuJjHD8QWTnY
 cNtFSiSVP09jhvJMGXQxS/WFHNlI1ZGn113FMonE481o/Jo5iwNfwUk0h
 /OU54WY9s/18wIyzyRWw2L+UrSfXmom2fGcgOCLU2yK98curb0R8kAD3k
 rHbiYQCPRSwZbbwLimT89sqjFR0POoH0rOWPFRZTwBR/CwhiQgf8uvUmL
 u6O17usZqrFkv2U3FINp8u/Nc39Ak3Zn5vln5a7haL0NuJJtQYK9NgVLC w==;
X-CSE-ConnectionGUID: JpO8xqARQFq/v9weWGmUhw==
X-CSE-MsgGUID: Dv0oeEG1SseMxjl24mFQ2A==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; d="scan'208";a="64088546"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Oct 2026 07:17:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 14 Oct 2026 07:17:25 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:17:23 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Wed, 14 Oct 2026 10:17:06 -0400
Subject: [PATCH v4 2/8] firmware: rpmi: add support for the SBI MPXY transport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-rpmi_v4-v4-2-d53d34a49780@microchip.com>
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

This adds an RPMI transport driver for the Supervisor Binary Interface
(SBI) message proxy (MPXY) extension [1].

This is for S-Mode U-Boot where some supervisor software (such as
OpenSBI) runs in M-Mode and handles the low level communication with the
PuC.

[1]: https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
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
 drivers/firmware/rpmi/Makefile        |   1 +
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 410 ++++++++++++++++++++++++++++++++++
 4 files changed, 477 insertions(+)

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
2.53.0

