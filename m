Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C8FCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0849280E34;
	Wed, 14 Oct 2026 14:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7tQ5LTP9T-w; Wed, 14 Oct 2026 14:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 46AC980E0C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987467;
	b=QNOw8UDnYJvfqKbH3hrERCYbhVOzLxE6MZPGmsXRzJwrbxZWWtAyKPj9TWvP4kggbIow
	 4PJhdb2X36T2lQZKB8KOgDbcVuVp11k6w/5IINUpxXuvrlosTLgjAXstPxnBQX0F1z7o/
	 1g3XYjBUrRJZzzX8eIeXIIA5nsnx4h1IHHUWujQurmW8c8cuOm+vKk77BLcEF+DXEQWaY
	 UzABejYxGDd1v1b2VJ3iwaNpnDydzOD98i+/7fDVc7Bw+utRNCsFvTg7FZM/slFZjyCWp
	 YppInHvYW9QEzR9fzH9OixWJ3bdCZCL73pFglM45kTdIUmoqNLXcly4InGyw882Kdkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Sy/JKsZbQRME8Opna7IDOX2EvoJdglHJ0cyi6X64GoA=;
	b=oA04dA1KusT/oozgq7xkbtyaPdayoQQbAS60TMpfGd/s5S+W1EDLiAF11Yenj2baQwC4
	 X+LYHJtNeB6AUNJhc6FH7UIOlnkD59RsYXhOoo25kUMiUJgC2IQwSoPxJweCnmbL36YDg
	 xx6zuLQaaJnuflQJNS1lhMZyZLcr8trdxxOASzfJLshfblwbU894UCFhj+vHvxRnszjS3
	 4+nDcFz7AZxdh1V/r+FLbTtDntU0GMb5JpJyBoDIWrI1TPEg5NRNbk97JlMxYLPRqoHWT
	 HZRdDd104OSVPMz9rqq74ukMhXxNpZOalIwS0f1HawoHzlgja56xRUR0FMDQL8arujw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987467;
	bh=Sy/JKsZbQRME8Opna7IDOX2EvoJdglHJ0cyi6X64GoA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MBIHzkANIGBrHlTvhK3t98JDJ8UyG2vKUhSCCekW//nDkDU+TxNHydYXwqNyVf2SA
	 2MGqAS3rd2MBkG8hlOu8+yHrH1gqUyjvnmjfvZmyTtujzLMsh7aieti4YBOEZm8AFr
	 DIKeAJvrL2V4CjvGcxXJHT+asvjWPthOtaGzIsMl6gyVg4MRvpPzEYa/TVBP/67K2M
	 2hNfWRvL5X1RQQFEWDI1f+Z1NKZygb8tktcqgDipP56YJMnH0JAQ/+oQoSErgJc21J
	 WFrSx7dLL++hhzPTo33TKU6FsjhMHZ0eVg4jGeoRPyG/Xzc7g/F0Ky/STJn4KNVpSE
	 e8Ah1A/8TPEVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46AC980E0C;
	Wed, 14 Oct 2026 14:17:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74DC52A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71C8A60818
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJ9tcEZAV5v6 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 110A4607B6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791987463;
 b=pN+K49dmDkoUPp2AUz6iIWYntmT0sDKe9f4XwyrunYzNMruqLOYl4Wp0x9QsrAMlSAtX
 ZiboDd9Ak+e2phs6Jsky0lyRmwwtErUR7mf58jAICgq0H4Y63upwqTzhTXGaLRfVtA2gF
 /NsNKB8tiva496IAwBMOAo9azSCt9mGgwdlX57CQYBBelil0IYAbxYrL3jzF/ti9t+oNG
 paQdc9Jtr5JlOWuREhmXaRjtXkwihEt+h+yc7nNCIPxvVVYiwkuQ+xowPS945JFXAe/QB
 B4duhu1oM/Qm5OISaCO+zb/vY3R2goSCBGfHcbTS5O2G3LYSeksLLuM35XXIR3VCtlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987463;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
 bh=Sy/JKsZbQRME8Opna7IDOX2EvoJdglHJ0cyi6X64GoA=;
 b=lGUZEHdRazTo29Xy+uDPfQEAmZb1jxD7ppiPA9XNFlaeQCW1v+7vx9NoKz9HQi18x+YQ
 M83NfOhR2VC6JJYNphuNZd3x13lhjdrwF5CcofUVfhFVZlYEBxpdYT40Nc2qr/Bq3zlIr
 XLVd1Rj6XGRc/ybVcqvOW5ik1L/2VLCgwCEzEAvQRnwfKkRASaOfSfRg4MBetwIv4JqE4
 hV3Vd0RBtXdff5/jJbCDD/0Wstv7Q5KZj0hmxMysS59NmkxuMFcabET9n8c5Suq48h0A/
 bVrXLBOopBMz22S50S/mPE+NHP99FMmG/2qIKZxlXEbO/Xfg7riVVJqe7O7M9Ibz1Uw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=ucQngEtj; 
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=ucQngEtj
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 110A4607B6
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791987469; x=1823523469;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=7eCbSjbhUpd5xPGdBac369GLEb1boKlfq9l8WpF2PNQ=;
 b=ucQngEtjm51dzRQOk3j3dKy0/cfQu37KulofKYh4DY59UrpWC29qvtmB
 IgJhZ4Nap24Zs6HO50MEndD8gk1OtfrGRaCOZ0HOQJGdN4L3dPZpsNrkO
 8rpTUa/0jfJg0/MFp3JjhwOzrEwdmjS/T5ruXNdwS8MroBQFyVmiipDY6
 KYgSWLmFtPYJBTJ5T2FV9CJsiN6QXHRFC9Q5oU7EOEhNbqdquu/jGzHug
 ziA949UryutF62KO7hXrMsm0JIEDrPX+Rvu+xSxumUl7Suk1jHzG0Lh83
 wAn7U/xdONSrvoKBp1/eTRgejW2W0ErhuEawh86kRZmchbp7EVKYczM0/ A==;
X-CSE-ConnectionGUID: YhT63AqxQY2ZnHAHbZy3uw==
X-CSE-MsgGUID: MQHQVwZNQMqiFspYNOtU4Q==
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; d="scan'208";a="65310677"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 07:17:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 07:17:39 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:17:37 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Wed, 14 Oct 2026 10:17:10 -0400
Subject: [PATCH v4 6/8] drivers: firmware: rpmi: Add the mpxy command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-rpmi_v4-v4-6-d53d34a49780@microchip.com>
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
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rahul Pathak <rahul.pathak@oss.qualcomm.com>
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

From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>

Add the mpxy command which allows listing MPXY channels, reading/writing
arbitrary channel attributes and sending raw messages.

The mpxy command is useful for interacting with custom RPMI service groups
that have no associated driver. It can also be useful for debugging and
testing SBI proxy drivers as well as the PuC firmware.

Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v4:
 - Force a device_probe() of all UCLASS_RPMI devices if g_mpxy is NULL
 - Remove the unnecessary edit to "cmd/riscv/Makefile"
 - Fix a printf placeholder for 32 bits %ld -> %zu

Changes in v3:
 - Add this patch
---
 drivers/firmware/rpmi/Kconfig         |   7 +
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 404 +++++++++++++++++++++++++++++++++-
 2 files changed, 407 insertions(+), 4 deletions(-)

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
index 9ccca0eb59b2..5f01a6303323 100644
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
 
@@ -87,6 +89,24 @@ struct rpmi_sbi_mpxy {
 	struct sbi_mpxy_chan_desc *channel_descs;
 };
 
+static struct rpmi_sbi_mpxy *g_mpxy;
+
+static __maybe_unused struct rpmi_sbi_mpxy *mpxy_get_global(void)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+
+	if (!g_mpxy) {
+		uclass_get(UCLASS_RPMI, &uc);
+		uclass_foreach_dev(dev, uc)
+		{
+			device_probe(dev);
+		}
+	}
+
+	return g_mpxy;
+}
+
 static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
 				    u32 base_attrid, u32 attr_count,
 				    u32 *attrs_buf)
@@ -105,6 +125,24 @@ static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
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
@@ -368,6 +406,8 @@ static int rpmi_sbi_mpxy_probe(struct udevice *dev)
 			    desc->attrs[SBI_MPXY_ATTR_MSG_MAX_LEN]);
 	}
 
+	g_mpxy = mpxy;
+
 	return 0;
 
 err:
@@ -408,3 +448,359 @@ U_BOOT_DRIVER(rpmi_sbi_mpxy) = {
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
+		printf("Too many words (max %zu)\n", ARRAY_SIZE(tx));
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
2.53.0

