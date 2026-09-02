Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02B6C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E7E380FAC;
	Wed,  2 Sep 2026 14:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4q3ZR3m1Kdg7; Wed,  2 Sep 2026 14:18:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358733;
	bh=b7hC81Cbh1E3W7XAE0HD1BHnR/J1DJJLlDvdrBp/c0U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wT9A3Q9dMpgh9Q1C2TLh4D6sbxmNyL1CHWpyby881KHvoHsgJ0n0GZ5DBZVI6JiNk
	 zHVe64rpMnbFD3PK0x/ShH9R4+TdjlgSMnVqOjvAODKpyxO90NjCBOILCdslQDiWth
	 gLSomPONdBzmkvPphkNDgYF/0EYfIHmLWDphER7nT4MxtqMHmk4Du3TWf7+EogMM01
	 3heDKEac/ri5gKy2li3svvAx6cmw2An7Onm7pM1r2ma2AsjKoyLZ7HqeeSiPGfNyQu
	 sOCc+oU7pocOFcCday+/KNwac7N+GbC/4gsjVMmVrFsId/yqaVCvscsvzTClwfkKBt
	 bMhQp4ZQuDfzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3799380FAE;
	Wed,  2 Sep 2026 14:18:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1783363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7DD6400A6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaCE-p5jUY5L for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:18:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=prvs=698db811e=charles.perry@microchip.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=microchip.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=2FXxQ9iQ
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 161EB4006F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:18:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779158424C; Wed,  2 Sep 2026 16:18:48 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A6383EEF
 for <u-boot@lists.denx.de>; Wed,  2 Sep 2026 16:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=698db811e=Charles.Perry@microchip.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.b="2FXxQ9iQ"; dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1788358725; x=1819894725;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ahuxu1ye6+Z4l5ywK7ic4Z4Luprt0D9kQnaeT+5QLnw=;
 b=2FXxQ9iQe13mFLl6sVxln9knBjk4iX2ExIkA1925unsMRqGwcAQAXvTh
 yksPM/WigfJOlh83LBKElLBKTYpW90fUkODKqcDd6xdyB1Byhny7jipuA
 kSu3CtLtmMJ8CXSOdH8KgkurKiDc7GXzJ4LaUTcWWJho1w5A22Y8rcOlz
 DdcrxUzpuT5NKdkiZPphOmv0MwMCv0sNEEFe/HlRUnGReCsWtaZgSACxy
 XUgPDdXBNcBCOKNNILUVi6tVXQN5cqK+TGE77NKp3AhSEJodowe/LWmou
 im+PSnyq9Gbh4WOyynUSjoOiECJul5QZY1RHWLgL0VI5tBGNFBqsIoCUW A==;
X-CSE-ConnectionGUID: 2MjAL5VYTByuuPbssGv9hg==
X-CSE-MsgGUID: g1tRBYhgQyyZcyvMuanciQ==
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="63050737"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 07:18:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 2 Sep 2026 07:18:36 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 2 Sep 2026 07:18:36 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: <charles.perry@microchip.com>, Rahul Pathak
 <rahul.pathak@oss.qualcomm.com>, Tim Ouyang <tim609@andestech.com>, Leo Liang
 <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v3 5/5] drivers: firmware: rpmi: Add the mpxy command
Date: Wed, 2 Sep 2026 07:17:31 -0700
Message-ID: <20260902141744.2422566-6-charles.perry@microchip.com>
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

From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>

Add the mpxy command which allows listing MPXY channels, reading/writing
arbitrary channel attributes and sending raw messages.

The mpxy command is useful for interacting with custom RPMI service groups
that have no associated driver. It can also be useful for debugging and
testing SBI proxy drivers as well as the PuC firmware.

Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v3:
 - Add this patch
---
 cmd/riscv/Makefile                    |   1 +
 drivers/firmware/rpmi/Kconfig         |   7 +
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 392 +++++++++++++++++++++++++-
 3 files changed, 396 insertions(+), 4 deletions(-)

diff --git a/cmd/riscv/Makefile b/cmd/riscv/Makefile
index 1e6ac364e341..40caf68d0df7 100644
--- a/cmd/riscv/Makefile
+++ b/cmd/riscv/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
 obj-$(CONFIG_CMD_SBI) += sbi.o
+obj-$(CONFIG_CMD_MPXY) += sbi_mpxy_cmd.o
diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfig
index b462d3693987..c6a6b6fe61de 100644
--- a/drivers/firmware/rpmi/Kconfig
+++ b/drivers/firmware/rpmi/Kconfig
@@ -18,6 +18,13 @@ config RPMI_SBI_MPXY
 	  specification for the MPXY extension is available at:
 	  https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
 
+config CMD_MPXY
+	bool "mpxy command"
+	depends on RPMI_SBI_MPXY
+	help
+	  Enable the 'mpxy' U-Boot command for listing MPXY channels,
+	  reading/writing arbitrary channel attributes and sending raw messages.
+
 config RPMI_SHMEM
 	bool "RPMI over shared memory transport"
 	depends on RPMI_FIRMWARE
diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
index 9ccca0eb59b2..d83906f5539b 100644
--- a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
+++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
  */
 
 #define LOG_CATEGORY UCLASS_RPMI
@@ -60,10 +61,10 @@ enum sbi_mpxy_attribute_id {
 
 /* RPMI message protocol specific MPXY attributes */
 enum sbi_mpxy_rpmi_attribute_id {
-	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID,
-	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
-	SBI_MPXY_RPMI_ATTR_IMPL_ID,
-	SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID = 0x00,
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION = 0x01,
+	SBI_MPXY_RPMI_ATTR_IMPL_ID = 0x02,
+	SBI_MPXY_RPMI_ATTR_IMPL_VERSION = 0x03,
 	SBI_MPXY_RPMI_ATTR_MAX_ID
 };
 
@@ -87,6 +88,13 @@ struct rpmi_sbi_mpxy {
 	struct sbi_mpxy_chan_desc *channel_descs;
 };
 
+static struct rpmi_sbi_mpxy *g_mpxy;
+
+static __maybe_unused struct rpmi_sbi_mpxy *mpxy_get_global(void)
+{
+	return g_mpxy;
+}
+
 static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
 				    u32 base_attrid, u32 attr_count,
 				    u32 *attrs_buf)
@@ -105,6 +113,24 @@ static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
 	return 0;
 }
 
+static __maybe_unused int
+rpmi_sbi_mpxy_write_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
+			  u32 base_attrid, u32 attr_count, u32 *attrs_buf)
+{
+	struct sbiret sret;
+	int i;
+
+	for (i = 0; i < attr_count; i++)
+		((__le32 *)mpxy->shmem)[i] = cpu_to_le32(attrs_buf[i]);
+
+	sret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_WRITE_ATTRS, channel_id,
+			 base_attrid, attr_count, 0, 0, 0);
+	if (sret.error)
+		return sbi_to_linux_error(sret.error);
+
+	return 0;
+}
+
 static int rpmi_sbi_mpxy_send_message(void *shmem, u32 mpxy_fid, u32 channel_id,
 				      u32 msg_id, const void *tx,
 				      unsigned long tx_len, void *rx,
@@ -368,6 +394,8 @@ static int rpmi_sbi_mpxy_probe(struct udevice *dev)
 			    desc->attrs[SBI_MPXY_ATTR_MSG_MAX_LEN]);
 	}
 
+	g_mpxy = mpxy;
+
 	return 0;
 
 err:
@@ -408,3 +436,359 @@ U_BOOT_DRIVER(rpmi_sbi_mpxy) = {
 	.ops = &rpmi_sbi_mpxy_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
+
+#if CONFIG_IS_ENABLED(CMD_MPXY) && !CONFIG_IS_ENABLED(XPL_BUILD)
+
+#include <command.h>
+#include <hexdump.h>
+
+static const char *mpxy_proto_to_str(u32 proto_id)
+{
+	switch (proto_id) {
+	case SBI_MPXY_MSGPROTO_RPMI_ID:
+		return "RPMI";
+	default:
+		return "Unknown";
+	}
+}
+
+/**
+ * mpxy list
+ *
+ * List the mpxy channels
+ */
+static int do_mpxy_list(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_global();
+	struct sbi_mpxy_chan_desc *chan;
+	u32 proto;
+	int i;
+
+	if (!mpxy)
+		return CMD_RET_FAILURE;
+
+	for (i = 0; i < mpxy->channel_count; i++) {
+		chan = &mpxy->channel_descs[i];
+		proto = chan->attrs[SBI_MPXY_ATTR_MSG_PROT_ID];
+		printf("Channel 0x%x: proto_id=0x%x (%s), ver=0x%x\n", chan->id,
+		       proto, mpxy_proto_to_str(proto),
+		       chan->attrs[SBI_MPXY_ATTR_MSG_PROT_VER]);
+	}
+
+	printf("sbi_mpxy: found %d channels\n", mpxy->channel_count);
+	return CMD_RET_SUCCESS;
+}
+
+static void mpxy_print_capability(u32 val)
+{
+	static const struct {
+		u32 bit;
+		const char *name;
+	} caps[] = {
+		{ SBI_MPXY_CHAN_CAP_MSI, "MSI" },
+		{ SBI_MPXY_CHAN_CAP_SSE, "SSE_EVENT" },
+		{ SBI_MPXY_CHAN_CAP_EVENTS_STATE, "EVENTS_STATE" },
+		{ SBI_MPXY_CHAN_CAP_SEND_WITH_RESP, "SEND_WITH_RESP" },
+		{ SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP, "SEND_WITHOUT_RESP" },
+		{ SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS, "GET_NOTIFICATIONS" },
+	};
+
+	bool any = false;
+	int i;
+
+	printf(" (");
+
+	if (!val) {
+		printf("none)\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(caps); i++) {
+		if (val & caps[i].bit) {
+			if (any)
+				printf("|");
+			printf("%s", caps[i].name);
+			any = true;
+		}
+	}
+	printf(")\n");
+}
+
+/* Decode well-known field values for selected standard attributes */
+static void mpxy_print_std_attr(u32 attr_id, u32 val)
+{
+	/* Standard MPXY attribute names, indexed by attr_id */
+	static const char *const mpxy_std_attr_names[] = {
+		[SBI_MPXY_ATTR_MSG_PROT_ID] = "MSG_PROT_ID",
+		[SBI_MPXY_ATTR_MSG_PROT_VER] = "MSG_PROT_VER",
+		[SBI_MPXY_ATTR_MSG_MAX_LEN] = "MSG_MAX_LEN",
+		[SBI_MPXY_ATTR_MSG_SEND_TIMEOUT] = "MSG_SEND_TIMEOUT",
+		[SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT] =
+			"MSG_COMPLETION_TIMEOUT",
+		[SBI_MPXY_ATTR_CHANNEL_CAPABILITY] = "CHANNEL_CAPABILITY",
+		[SBI_MPXY_ATTR_SSE_EVENT_ID] = "SSE_EVENT_ID",
+		[SBI_MPXY_ATTR_MSI_CONTROL] = "MSI_CONTROL",
+		[SBI_MPXY_ATTR_MSI_ADDR_LO] = "MSI_ADDR_LO",
+		[SBI_MPXY_ATTR_MSI_ADDR_HI] = "MSI_ADDR_HI",
+		[SBI_MPXY_ATTR_MSI_DATA] = "MSI_DATA",
+		[SBI_MPXY_ATTR_EVENTS_STATE_CONTROL] = "EVENTS_STATE_CONTROL",
+	};
+
+	printf("  [0x%02x] %-28s: 0x%08x", attr_id,
+	       mpxy_std_attr_names[attr_id], val);
+
+	switch (attr_id) {
+	case SBI_MPXY_ATTR_MSG_PROT_ID:
+		printf(" (%s)\n", mpxy_proto_to_str(val));
+		break;
+	case SBI_MPXY_ATTR_MSG_PROT_VER:
+		printf(" (v%u.%u)\n", (val >> 16) & 0xffff, val & 0xffff);
+		break;
+	case SBI_MPXY_ATTR_MSG_MAX_LEN:
+		printf(" (%u bytes)\n", val);
+		break;
+	case SBI_MPXY_ATTR_MSG_SEND_TIMEOUT:
+	case SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT:
+		printf(" (%u ms)\n", val);
+		break;
+	case SBI_MPXY_ATTR_CHANNEL_CAPABILITY:
+		mpxy_print_capability(val);
+		break;
+	default:
+		printf("\n");
+		break;
+	}
+}
+
+static const char *mpxy_rpmi_proto_attr_name(u32 attr_id)
+{
+	switch (attr_id) {
+	case SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID:
+		return "SERVICEGROUP_ID";
+	case SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION:
+		return "SERVICEGROUP_VERSION";
+	case SBI_MPXY_RPMI_ATTR_IMPL_ID:
+		return "IMPLEMENTATION_ID";
+	case SBI_MPXY_RPMI_ATTR_IMPL_VERSION:
+		return "IMPLEMENTATION_VER";
+	default:
+		return "UNKNOWN";
+	};
+}
+
+static void mpxy_print_proto_attr(u32 attr_id, u32 val, bool is_rpmi)
+{
+	u32 rpmi_attr_id = attr_id - SBI_MPXY_ATTR_MSGPROTO_ATTR_START;
+	const char *name = is_rpmi ? mpxy_rpmi_proto_attr_name(rpmi_attr_id) :
+				     "UNKNOWN";
+
+	printf("  [0x%08x] %-24s: 0x%08x", attr_id, name, val);
+
+	if (is_rpmi &&
+	    (rpmi_attr_id == SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION ||
+	     rpmi_attr_id == SBI_MPXY_RPMI_ATTR_IMPL_VERSION)) {
+		printf(" (v%u.%u)\n", (val >> 16) & 0xffff, val & 0xffff);
+	} else {
+		printf("\n");
+	}
+}
+
+/**
+ * mpxy readattr <channel_id> <attr_id>
+ *
+ * Read the attribute on a channel
+ */
+static int do_mpxy_readattr(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_global();
+	u32 chan_id, attr_id, attr_val;
+	int ret;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	if (!mpxy)
+		return CMD_RET_FAILURE;
+
+	chan_id = simple_strtoul(argv[1], NULL, 0);
+	attr_id = simple_strtoul(argv[2], NULL, 0);
+
+	ret = rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, attr_id, 1, &attr_val);
+	if (ret) {
+		printf("Read attr 0x%x on channel 0x%x failed (%d)\n", attr_id,
+		       chan_id, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Channel 0x%x: attr[0x%x] = 0x%x\n", chan_id, attr_id, attr_val);
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * mpxy readattrall <channel_id>
+ */
+static int do_mpxy_readattr_all(struct cmd_tbl *cmdtp, int flag, int argc,
+				char *const argv[])
+{
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_global();
+	u32 chan_id, attr_val[SBI_MPXY_ATTR_STD_ATTR_MAX_IDX];
+	bool is_rpmi;
+	int i, ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	if (!mpxy)
+		return CMD_RET_FAILURE;
+
+	chan_id = simple_strtoul(argv[1], NULL, 0);
+
+	ret = rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, SBI_MPXY_ATTR_MSG_PROT_ID,
+				       SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
+				       attr_val);
+	if (ret) {
+		printf("Read attr on channel 0x%x failed (%d)\n", chan_id, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	/* Standard attributes */
+	printf("Channel 0x%x standard attributes:\n", chan_id);
+	for (i = 0; i < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX; i++)
+		mpxy_print_std_attr(i, attr_val[i]);
+
+	/* Protocol-specific attributes */
+	printf("Channel 0x%x protocol attributes:\n", chan_id);
+
+	for (i = SBI_MPXY_ATTR_MSGPROTO_ATTR_START;
+	     i < SBI_MPXY_ATTR_MSGPROTO_ATTR_END; i++) {
+		ret = rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, i, 1,
+					       &attr_val[0]);
+		if (ret)
+			break;
+
+		is_rpmi = mpxy->channel_descs[chan_id]
+				  .attrs[SBI_MPXY_ATTR_MSG_PROT_ID] ==
+			  SBI_MPXY_MSGPROTO_RPMI_ID;
+		mpxy_print_proto_attr(i, attr_val[0], is_rpmi);
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * mpxy writeattr <channel_id> <attr_id> <value>
+ */
+static int do_mpxy_writeattr(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_global();
+	u32 chan_id, attr_id, attr_val;
+	int ret;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+
+	if (!mpxy)
+		return CMD_RET_FAILURE;
+
+	chan_id = simple_strtoul(argv[1], NULL, 0);
+	attr_id = simple_strtoul(argv[2], NULL, 0);
+	attr_val = simple_strtoul(argv[3], NULL, 0);
+
+	ret = rpmi_sbi_mpxy_write_attrs(mpxy, chan_id, attr_id, 1, &attr_val);
+	if (ret) {
+		printf("Write attr 0x%x on channel 0x%x failed (%d)\n", attr_id,
+		       chan_id, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Channel 0x%x: attr[0x%x] written 0x%x\n", chan_id, attr_id,
+	       attr_val);
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * mpxy send <channel_id> <msg_id> [payload_word ...]
+ *
+ * For RPMI, msg_id is the service_id. Payload words follow.
+ */
+static int do_mpxy_send(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_global();
+	u32 tx[64];
+	u32 rx[64];
+	unsigned long tx_words, rx_bytes;
+	u32 chan_id, service_id;
+	int i, ret;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	if (!mpxy)
+		return CMD_RET_FAILURE;
+
+	chan_id = simple_strtoul(argv[1], NULL, 0);
+	service_id = simple_strtoul(argv[2], NULL, 0);
+	tx_words = argc - 3;
+
+	if (tx_words > ARRAY_SIZE(tx)) {
+		printf("Too many words (max %ld)\n", ARRAY_SIZE(tx));
+		return CMD_RET_FAILURE;
+	}
+
+	for (i = 0; i < tx_words; i++)
+		tx[i] = simple_strtoul(argv[3 + i], NULL, 0);
+
+	ret = rpmi_sbi_mpxy_send_message(mpxy->shmem,
+					 SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
+					 chan_id, service_id, tx, tx_words * 4,
+					 rx, sizeof(rx), &rx_bytes);
+	if (ret) {
+		printf("Send on channel 0x%x failed (%d)\n", chan_id, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Response (%ld word(s)):\n", rx_bytes / 4);
+	print_hex_dump(" ", DUMP_PREFIX_OFFSET, 4, 4, rx, rx_bytes, true);
+
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * Subcommand table and top-level dispatch
+ */
+static struct cmd_tbl cmd_mpxy_sub[] = {
+	U_BOOT_CMD_MKENT(list, 1, 0, do_mpxy_list, "", ""),
+	U_BOOT_CMD_MKENT(readattr, 3, 0, do_mpxy_readattr, "", ""),
+	U_BOOT_CMD_MKENT(readattrall, 2, 0, do_mpxy_readattr_all, "", ""),
+	U_BOOT_CMD_MKENT(writeattr, 4, 0, do_mpxy_writeattr, "", ""),
+	U_BOOT_CMD_MKENT(send, CONFIG_SYS_MAXARGS, 0, do_mpxy_send, "", ""),
+};
+
+static int do_mpxy(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	struct cmd_tbl *c;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	c = find_cmd_tbl(argv[1], cmd_mpxy_sub, ARRAY_SIZE(cmd_mpxy_sub));
+	if (!c)
+		return CMD_RET_USAGE;
+
+	return c->cmd(cmdtp, flag, argc - 1, argv + 1);
+}
+
+U_BOOT_CMD(
+	mpxy, CONFIG_SYS_MAXARGS, 0, do_mpxy, "SBI MPXY channel debug commands",
+	"list                              - list discovered channels\n"
+	"mpxy readattr    <chan> <attr>         - read one attribute\n"
+	"mpxy readattrall <chan>                - read all attributes\n"
+	"mpxy writeattr   <chan> <attr> <val>   - write an attribute\n"
+	"mpxy send        <chan> <msg_id> [payload_word ...]  - send message\n");
+
+#endif // CONFIG_CMD_MPXY
-- 
2.52.0

