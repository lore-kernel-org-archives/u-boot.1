Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A4606A330
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZiMxMAgh;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=vgy1QSn3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE828608B6;
	Fri, 13 Nov 2026 19:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-jyr7tpnDio; Fri, 13 Nov 2026 19:43:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8828360DC9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794599021;
	b=FJzjIVKJyz8vmOvU2H5cu8e6cNC4KbSaZEsUJgNHrg8ZD0oYN7qZ98PO2TNGGnq6KyYI
	 KNAdU+e/ElixMPU2i6+6mLUB42P8NYU5sSoBDBptpmmQUsIUxDsXlnoe91KVKuFAe5bTd
	 5qUNWtOhReDwuyJiiRqvqWezcb8dR75JlbKgj50Fkf53fyTqqonJI3qHwDLhu+Z/wGr2Y
	 aDFp2bn0Ebia9awPiD8Ut2Bv9Qq2lgDzvLf02QapsZOZxD9n0/i2f8UpajDV/O3gzEzUR
	 wYWBw96TDanMHbCqgsgtL+UIT1w3Nc0A+LJDjEh43RHDDVOMZu3cBvR601Rc6gt5nXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2dY/rXkTHcD68S3wQEF8Zcd6fs1RfpKjoGTpUOk/qc8=;
	b=PXq9uL+xGzkoOysNEJFeCwP06xAp/SF82k9GogMd8XwJpS7P7f03qheaU/AH497pyKfu
	 XKWaVJHL3Eve+HwTGUahfDPzR/jssg0FRkRgZITe3odWr8cvvDmxm/e6Ec6bnWa+k1dtw
	 93iHjB6vpSs7gn3ZySsv+fNTchakvUqqNH4s8mjBO68XEoXMEDvDpx52nL2V9kTS/PJqy
	 Jxk2aOjdMDlty/JTwk2qLVu56R2qWiInQV/o37AxqmdM3BfxVoGPVpghPKRVsnzvFvJp4
	 5DRKLTknJWVLX1y6xhpt2iglAYOjCgblSueo494azOJGtRplGDs9lEJT/RuhvJuUxhg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=vgy1QSn3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794599021;
	bh=2dY/rXkTHcD68S3wQEF8Zcd6fs1RfpKjoGTpUOk/qc8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZiMxMAghQtToZVJK7yS9i7/4LcJ7vV9n/kjsoiGgbr7OC6lhTofDwdlqGl7Pv0W1f
	 wLinV++es7icMD9Bh8bPu4CDv6RcGfL5Kim/ZhdSA9oWsedpJiAI3yncW0dYQLqYpj
	 hWWXi4zNjGCG3G8Rp59cl4Gu7b3Tb4iT9mR3gDcAIgaRiNKJpMfCqhEYrYlXYQDMNB
	 Gat31YGRsdty/SjRQnm7Tt4Cp048dbB1v66YceAEvJJfw7/Y1WJ/W6DR+5GtayGtpo
	 GyZVuZpXfF2QZYTXmRn/pkjm3fOkKXFUL304qPMImo7HepqvsVcANlrWceBiwqb+tc
	 6/ErGXeOrATQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8828360DC9;
	Fri, 13 Nov 2026 19:43:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0609F260
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBD2C60DE6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FLzyFGRku6rP for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 19:43:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B7CD60D91
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=vgy1QSn3
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B7CD60D91
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794599022; x=1826135022;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=9BJTEYRzh0/Qx+VoeDzoRH7gNLcgoTb/POVIdKWssVc=;
 b=vgy1QSn3p4SFqWtDzpF1q2YveRygEFJyXeUvrgaQcLKnD1jRGA0nonWs
 RnBy9u4JfakkVzVZ0HO4VZ2QHZ/Ulzvdtq8Y9SQVoEoL3OUycHmaQN1B/
 cAqcxm8FGdKaMoee+s0cNpO5o7EkWeUb4pmj5Wf2XGQQab8XiKhFxzmD3
 sdwXyFC9SIbgOTLRTK0d2gCnzkJI6TMkxIdlV1jXtN4bShRo3pQJ12ryk
 19gBKFqQVtoZ55uuerxPvgmSP11EG2SEONzu0WyJmk9DjJMLWYnXHNWch
 1VFRre5lXd+6b9SyX/JBikreCCQfhQwtVAVMdQGsXUsPQ7sDOSw+I6xg1 g==;
X-CSE-ConnectionGUID: 4U6yjNsTTIKmrnHQsw1lYw==
X-CSE-MsgGUID: cOE3U+6YQweIM+jbA/e5+Q==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="233536294"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:43:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 13 Nov 2026 12:43:33 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 12:43:30 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 13 Nov 2026 14:43:00 -0500
Subject: [PATCH v5 6/8] drivers: firmware: rpmi: Add the mpxy command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-rpmi_v4-v5-6-6787318ad186@microchip.com>
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
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rahul Pathak <rahul.pathak@oss.qualcomm.com>
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

From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>

Add the mpxy command which allows listing MPXY channels, reading/writing
arbitrary channel attributes and sending raw messages.

The mpxy command is useful for interacting with custom RPMI service groups
that have no associated driver. It can also be useful for debugging and
testing SBI proxy drivers as well as the PuC firmware.

Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v5: (from Subrahmanya review)
 - fix a bad indexing into mpxy->channel_descs[]
 - Add mpxy_find_chandesc() to support the function signature change of
   rpmi_sbi_mpxy_send_message() needed to support the added bound checking
   in patch 2.
 - Remove the "g_mpxy" global variable and use
   uclass_get_device_by_driver() instead. (from LLM review)

Changes in v4:
 - Force a device_probe() of all UCLASS_RPMI devices if g_mpxy is NULL
 - Remove the unnecessary edit to "cmd/riscv/Makefile"
 - Fix a printf placeholder for 32 bits %ld -> %zu

Changes in v3:
 - Add this patch
---
 drivers/firmware/rpmi/Kconfig         |   7 +
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 413 +++++++++++++++++++++++++++++++++-
 2 files changed, 416 insertions(+), 4 deletions(-)

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
index 3398271f8567..d0a60070d17c 100644
--- a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
+++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
  */
 
 #define LOG_CATEGORY UCLASS_RPMI
@@ -16,6 +17,7 @@
 #include <malloc.h>
 #include <rpmi-uclass.h>
 #include <string.h>
+#include <dm/device-internal.h>
 
 /* SBI MPXY channel IDs data in shared memory */
 struct sbi_mpxy_channel_ids_data {
@@ -60,10 +62,10 @@ enum sbi_mpxy_attribute_id {
 
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
 
@@ -87,6 +89,17 @@ struct rpmi_sbi_mpxy {
 	struct sbi_mpxy_chan_desc *channel_descs;
 };
 
+static __maybe_unused struct rpmi_sbi_mpxy *mpxy_get_priv(void)
+{
+	struct udevice *dev;
+
+	if (uclass_get_device_by_driver(UCLASS_RPMI,
+					DM_DRIVER_GET(rpmi_sbi_mpxy), &dev))
+		return NULL;
+
+	return dev_get_priv(dev);
+}
+
 static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
 				    u32 base_attrid, u32 attr_count,
 				    u32 *attrs_buf)
@@ -105,6 +118,24 @@ static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
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
 static int rpmi_sbi_mpxy_send_message(struct rpmi_sbi_mpxy *mpxy,
 				      struct sbi_mpxy_chan_desc *desc,
 				      u32 mpxy_fid, u32 msg_id, const void *tx,
@@ -413,3 +444,377 @@ U_BOOT_DRIVER(rpmi_sbi_mpxy) = {
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
+static struct sbi_mpxy_chan_desc *mpxy_find_chandesc(struct rpmi_sbi_mpxy *mpxy,
+						     u32 chan_id)
+{
+	for (int i = 0; i < mpxy->channel_count; i++) {
+		if (mpxy->channel_descs[i].id == chan_id)
+			return &mpxy->channel_descs[i];
+	}
+
+	return NULL;
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
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_priv();
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
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_priv();
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
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_priv();
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
+	is_rpmi = attr_val[SBI_MPXY_ATTR_MSG_PROT_ID] ==
+		  SBI_MPXY_MSGPROTO_RPMI_ID;
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
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_priv();
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
+	struct rpmi_sbi_mpxy *mpxy = mpxy_get_priv();
+	struct sbi_mpxy_chan_desc *desc;
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
+		printf("Too many words (max %zu)\n", ARRAY_SIZE(tx));
+		return CMD_RET_FAILURE;
+	}
+
+	desc = mpxy_find_chandesc(mpxy, chan_id);
+	if (!desc) {
+		printf("Cannot find channel 0x%x\n", chan_id);
+		return CMD_RET_FAILURE;
+	}
+
+	for (i = 0; i < tx_words; i++)
+		tx[i] = simple_strtoul(argv[3 + i], NULL, 0);
+
+	ret = rpmi_sbi_mpxy_send_message(mpxy, desc,
+					 SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
+					 service_id, tx, tx_words * 4, rx,
+					 sizeof(rx), &rx_bytes);
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
2.53.0

