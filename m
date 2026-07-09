Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66451C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B950484AA5;
	Fri, 10 Jul 2026 14:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JogvgWza";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0U4rmPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE2A84BF0; Thu,  9 Jul 2026 19:56:21 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECAA84BF2
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 19:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rahul.pathak@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HWq412563408
 for <u-boot@lists.denx.de>; Thu, 9 Jul 2026 17:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V57r07z8i+5qFuVSPsZaG+fIlWRC/QgD1xIji1aCse4=; b=JogvgWzaQrGVrBFX
 dEj1Ux3he7xSTaDlKbCUfCBsETuSoQw70vWLTcMSfah5sc0JSOgdJP2pwJPVP2Yk
 nyhLHSzhQL0BSzNSzEX1yhYmMLrZ7vUPhcQPnauXW43/pJyG2L8H00GOzTIIhkYl
 LMex/8IsVJPu+VAahnSEXBa4LbcYyeiXoYeAbqlknNp8lhDhB6xPcWftY1cS5g1o
 IP9H4plaZdputR1G5va0ksy06vpByXFVFEz49u0TthtE1xz1qlWPWnk9nH0GHDyp
 FCtMZmPCL+iDMX9GLP40H9ePMHzTWIdQVCjLoC8T9FzgNYaIcgpb7OZ8YbZBSger
 FT4kzg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3gqn7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 17:56:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88ab059052so85120a12.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783619777; x=1784224577; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V57r07z8i+5qFuVSPsZaG+fIlWRC/QgD1xIji1aCse4=;
 b=g0U4rmPBZjmoJ4hOKnk2rzMAQpPnsVdC0Zy2RNKa4ZLy4ZoqM/jLcjw7v4xObg5wS2
 ru4FEeQFvuf1FbenxtSdluR7PNV8c4Tsp3kVw4peeRNFJjhfXnHSH2UOHDttc/c9Azw6
 3ro2x8Snw691OU9WFK7dWscxTXkHn7EmBXasI419BHWE8rb6l8RI2RX3YwKVOjz6PLDN
 Y6EGHWzFleod56e5G3GtX/oafmO6g38xl21OC59AqkUcuuPPZ62E9V8yBozxOkzgIwwa
 czmskyfXFJ5327qjQ/mw7pMwwTnL5myVxSMmsvJyYjwi9aJbtn8S3QkwVUmQYDmW6j6W
 dylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783619777; x=1784224577;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V57r07z8i+5qFuVSPsZaG+fIlWRC/QgD1xIji1aCse4=;
 b=fIqdHbxrkSqWgTIK3c6wCfPD52osZfXiTCbQmAkM2/E0wsQHUKftdpK2hTq0nUKp/7
 xbRnNMq5OMC8cn5lgtUTMw3+puQwycKzRKi+4PUTVPbYM/JpmxYjsqJ9OfRmS4A2wpZT
 ucFEmUcOJqrIoguzOzHIrSjogbjINn07lStRgU7PYLUJkMe/MZ0jWztiaOwYRkIw4Oqb
 sHlua1aqhdoAxLvBRSms1nOjbcaim6zog/q44hXNv0graaRXDcrIgswOJqhWo1QWZwms
 spAa/Bpo/7SzNIRsWNikayfqgUIlfpngqwyPp7Zn8bIV5v+NNXZIxzx+CrkSLTPptBof
 EX/w==
X-Gm-Message-State: AOJu0YxZT4cz1cQ/qUDBDvmH0X6Kd1urwEoSYHNiDGWrCu9Fy11f+9Gk
 ikp6x3GY4ICT1bxxdGsjzCzZj3ig03+w87V8luZMiVk3Mc2JuQX8MJ+dM9zwrwrhslwjkNwZpyF
 RCATcCzfbhBsLuKzCX3dosNjrqPkBpF7VnFcucIC4061hibqfVMQU6c52UHlioadu
X-Gm-Gg: AfdE7clT0tf1C5ZUCsJbUlDd1O/NT479SxpLMMhUCFZ34bZGxBqilK7DHkLspEeGQIL
 XQdjUsMhyEIYSXuY3TlzOKhoycXXD8t0IQ/6fJHrCb6hzBoSwPkfFMyTKMlzLp6sppewEJyNzsU
 4Z3opPpYvqW1+YSQok0Pbqm+dXYK5VcxiU9xBdIbPdz3JvymS/qdqvfQ9nnzRhlFfz58tMUhjkG
 A1AH2Fm88XSBKCcyGjD2azfjQYt+4chqxj0WV4PoPiocZ7x3iK8z5Qexhk+NB57zHMa3kWk71aY
 yO9Jtells+Ai11VT1vsmRgJMn2/8ByOCL9AzjX0EVCTm8wftK9RWwXrIRL9c2xbvGrTAhfV+rZb
 lFpyuQ7v3bFFoi9fhaCy0kptijq9O+NAOkMlcb2ipgl80ODfH3tIRqrnJLlM/vxm7kaYA16qwKy
 ZJIzyZl9zykd+hdyxKeT3+hMW2oTJpXHk=
X-Received: by 2002:a05:6a21:4516:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c0f085a7fcmr352563637.5.1783619776556; 
 Thu, 09 Jul 2026 10:56:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:4516:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c0f085a7fcmr352524637.5.1783619775913; 
 Thu, 09 Jul 2026 10:56:15 -0700 (PDT)
Received: from hu-rahupath-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accae5sm51523828eec.29.2026.07.09.10.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:56:15 -0700 (PDT)
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: rahul.pathak@oss.qualcomm.com, anup.patel@oss.qualcomm.com
Subject: [PATCH 2/3] cmd: Add mpxy command and add RISC-V RPMI driver
Date: Thu,  9 Jul 2026 23:26:03 +0530
Message-ID: <20260709175605.1070755-3-rahul.pathak@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfX2v3LG3KLz9Sn
 fay2UCle4hIE3ttCqlJvy31iFwNVQAnmZO8Dn4doyAETkgRo4dqpT1Z+nDYdLCnbS6CWd5dqAyA
 EVBSaOCHOYH7cbBD3ZzI07rmyl6B67BKep8IywWwYzEV5PpkF1yKxHPtmX5ObqJldS1FKjbs/pG
 RC9Z1UZIvzAGKNhYBa7kb+APLHjJqLiJisr1RIZLbtcdw7owmnwtPJMDWg7OIMaYc1NCd5Cy3Rr
 CUOCvKoJaX6U6esk0TAKN1FYb5JVKAKQMZy1ZImwfXMWw6SNzq6L4bwJEoeC06uPAqt1qgqGjFf
 HruCb0tfW0WdkRs1oAe6T6WXzCioKfKipnwTV3zxN3ipG6jCfdBbsKAiJoMbCmJGoM/EJdw1QTZ
 mP8fDfdr9UQePcNfIZxqbaD615BBLcBEv/lGXEM9AwbZkgR55fBjqRK7eGHImifUwRq9C7hVi9N
 VpfMUEtbUrYD3cTKB7w==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a4fe0c1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=BZGUSyp084qRzyFpFk4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfX1TUcrHu38V52
 YgqZUcSTN/B9Igb4GLrj5Q+58SmMbMxpBjPWw1xBU5Tph0FCaMqnfdgCyTBVR1Z95ecsnKzSpYs
 qotV717w6oucFV/Rxmk99PJXg1RbpwQ=
X-Proofpoint-GUID: C1UR-zDS8HC37hi3WUpw1dUdupdqpYDn
X-Proofpoint-ORIG-GUID: C1UR-zDS8HC37hi3WUpw1dUdupdqpYDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090175
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

The mpxy command is an interactive command which uses
SBI MPXY interface to interact with supported message
protocol through available MPXY channels.

The command helps if there is a custom RPMI service
group or any other such message protocol implementation
and that can be tested in some manner without requiring
the S-Mode OS driver support.

Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
---
 cmd/Kconfig              |   8 +
 cmd/riscv/Makefile       |   1 +
 cmd/riscv/sbi_mpxy_cmd.c | 482 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 491 insertions(+)
 create mode 100644 cmd/riscv/sbi_mpxy_cmd.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5b9c13d85e7..413f7787343 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -264,6 +264,14 @@ config CMD_SBI
 	help
 	  Display information about the SBI implementation.
 
+config CMD_MPXY
+	bool "mpxy command"
+	depends on SBI_MPXY
+	help
+	  Enable the 'mpxy' U-Boot command for listing MPXY channels,
+	  reading/writing channel attributes, and sending raw messages.
+	  Includes the built-in RPMI protocol driver.
+
 config CMD_SMBIOS
 	bool "smbios"
 	depends on SMBIOS
diff --git a/cmd/riscv/Makefile b/cmd/riscv/Makefile
index 1e6ac364e34..40caf68d0df 100644
--- a/cmd/riscv/Makefile
+++ b/cmd/riscv/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
 obj-$(CONFIG_CMD_SBI) += sbi.o
+obj-$(CONFIG_CMD_MPXY) += sbi_mpxy_cmd.o
diff --git a/cmd/riscv/sbi_mpxy_cmd.c b/cmd/riscv/sbi_mpxy_cmd.c
new file mode 100644
index 00000000000..20a9411677f
--- /dev/null
+++ b/cmd/riscv/sbi_mpxy_cmd.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SBI MPXY U-Boot Command + RPMI Protocol Driver
+ * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
+ */
+
+#include <command.h>
+#include <errno.h>
+#include <vsprintf.h>
+#include <asm/sbi.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+/**
+ * RPMI protocol driver
+ */
+
+/** RPMI Protocol ID assigned for MPXY */
+#define SBI_MPXY_MSGPROTO_RPMI_ID	0x0
+
+static int rpmi_readattr(struct mpxy_channel *chan, u32 attr_id, u32 *attr_val)
+{
+	struct sbiret ret;
+	__le32 *shmem;
+
+	shmem = (__le32 *)sbi_mpxy_shmem_ptr();
+	if (!shmem)
+		return -ENXIO;
+
+	ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS,
+			chan->channel_id, attr_id, 1, 0, 0, 0);
+	if (ret.error)
+		return -EINVAL;
+
+	*attr_val = le32_to_cpu(shmem[0]);
+	return 0;
+}
+
+static int rpmi_writeattr(struct mpxy_channel *chan, u32 attr_id, u32 attr_val)
+{
+	struct sbiret ret;
+	__le32 *shmem;
+
+	shmem = (__le32 *)sbi_mpxy_shmem_ptr();
+	if (!shmem)
+		return -ENXIO;
+
+	shmem[0] = cpu_to_le32(attr_val);
+
+	ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_WRITE_ATTRS,
+			chan->channel_id, attr_id, 1, 0, 0, 0);
+	if (ret.error)
+		return -EINVAL;
+
+	return 0;
+}
+
+
+static const struct mpxy_proto_ops rpmi_proto_ops = {
+	.proto_id	= SBI_MPXY_MSGPROTO_RPMI_ID,
+	.name		= "RPMI",
+	.readattr	= rpmi_readattr,
+	.writeattr	= rpmi_writeattr,
+};
+
+static int cmd_mpxy_probed(void)
+{
+	static bool proto_registered;
+	int ret;
+
+	if (!proto_registered) {
+		ret = sbi_mpxy_register_proto(&rpmi_proto_ops);
+		if (ret) {
+			printf("Failed to register RPMI protocol (%d)\n", ret);
+			return CMD_RET_FAILURE;
+		}
+		proto_registered = true;
+	}
+
+	ret = sbi_mpxy_probe();
+	if (ret) {
+		printf("MPXY not available (error %d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
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
+	int i, count;
+
+	if (cmd_mpxy_probed())
+		return CMD_RET_FAILURE;
+
+	count = sbi_mpxy_channel_count();
+	for (i = 0; i < count; i++) {
+		struct mpxy_channel *chan = sbi_mpxy_get_channel(i);
+
+		if (!chan)
+			continue;
+
+		printf("Channel 0x%x: %s (proto_id=0x%x, ver=0x%x)\n",
+			chan->channel_id,
+			chan->proto ? chan->proto->name : "Unknown protocol",
+			chan->std_attrs.msg_proto_id,
+			chan->std_attrs.msg_proto_version);
+	}
+
+	printf("sbi_mpxy: found %d channels\n", count);
+	return CMD_RET_SUCCESS;
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
+	struct mpxy_channel *chan;
+	u32 chan_id, attr_id, attr_val;
+	int ret;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	if (cmd_mpxy_probed())
+		return CMD_RET_FAILURE;
+
+	chan_id = simple_strtoul(argv[1], NULL, 0);
+	attr_id = simple_strtoul(argv[2], NULL, 0);
+
+	chan = sbi_mpxy_find_channel(chan_id);
+	if (!chan) {
+		printf("Channel 0x%x not found\n", chan_id);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = sbi_mpxy_read_attrs(chan, attr_id, 1, &attr_val);
+	if (ret) {
+		printf("Read attr 0x%x on channel 0x%x failed (%d)\n",
+		       attr_id, chan_id, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Channel 0x%x: attr[0x%x] = 0x%x\n", chan_id, attr_id, attr_val);
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * Attribute name tables
+ */
+
+/* Standard MPXY attribute names, indexed by attr_id */
+static const char * const mpxy_std_attr_names[] = {
+	[SBI_MPXY_ATTR_MSG_PROT_ID]		= "MSG_PROT_ID",
+	[SBI_MPXY_ATTR_MSG_PROT_VER]		= "MSG_PROT_VER",
+	[SBI_MPXY_ATTR_MSG_MAX_LEN]		= "MSG_MAX_LEN",
+	[SBI_MPXY_ATTR_MSG_SEND_TIMEOUT]	= "MSG_SEND_TIMEOUT",
+	[SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT]	= "MSG_COMPLETION_TIMEOUT",
+	[SBI_MPXY_ATTR_CHANNEL_CAPABILITY]	= "CHANNEL_CAPABILITY",
+	[SBI_MPXY_ATTR_SSE_EVENT_ID]		= "SSE_EVENT_ID",
+	[SBI_MPXY_ATTR_MSI_CONTROL]		= "MSI_CONTROL",
+	[SBI_MPXY_ATTR_MSI_ADDR_LO]		= "MSI_ADDR_LO",
+	[SBI_MPXY_ATTR_MSI_ADDR_HI]		= "MSI_ADDR_HI",
+	[SBI_MPXY_ATTR_MSI_DATA]		= "MSI_DATA",
+	[SBI_MPXY_ATTR_EVENTS_STATE_CONTROL]	= "EVENTS_STATE_CONTROL",
+};
+
+/* RPMI protocol-specific attribute names */
+struct mpxy_attr_name {
+	u32		 attr_id;
+	const char	*name;
+};
+
+static const struct mpxy_attr_name rpmi_proto_attr_names[] = {
+	{ 0x80000000, "SERVICEGROUP_ID"		},
+	{ 0x80000001, "SERVICEGROUP_VERSION"	},
+	{ 0x80000002, "IMPLEMENTATION_ID"	},
+	{ 0x80000003, "IMPLEMENTATION_VER"	},
+};
+
+static const char *rpmi_proto_attr_name(u32 attr_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rpmi_proto_attr_names); i++) {
+		if (rpmi_proto_attr_names[i].attr_id == attr_id)
+			return rpmi_proto_attr_names[i].name;
+	}
+
+	return "UNKNOWN";
+}
+
+/*
+ * CHANNEL_CAPABILITY bit definitions (SBI MPXY spec):
+ *	[0]	MSI support
+ *	[1]	SSE Event support
+ *	[2]	Events State support
+ *	[3]	Send Message with Response (FID #5) support
+ *	[4]	Send Message without Response (FID #6) support
+ *	[5]	Get Notifications (FID #7) support
+ *	[31:6]	Reserved, must be 0
+ */
+#define MPXY_CAP_MSI			BIT(0)
+#define MPXY_CAP_SSE_EVENT		BIT(1)
+#define MPXY_CAP_EVENTS_STATE		BIT(2)
+#define MPXY_CAP_SEND_WITH_RESP		BIT(3)
+#define MPXY_CAP_SEND_WITHOUT_RESP	BIT(4)
+#define MPXY_CAP_GET_NOTIFICATIONS	BIT(5)
+
+struct capability {
+	u32		 bit;
+	const char	*name;
+};
+
+static const struct capability caps[] = {
+	{ MPXY_CAP_MSI,			"MSI"			},
+	{ MPXY_CAP_SSE_EVENT,		"SSE_EVENT"		},
+	{ MPXY_CAP_EVENTS_STATE,	"EVENTS_STATE"		},
+	{ MPXY_CAP_SEND_WITH_RESP,	"SEND_WITH_RESP"	},
+	{ MPXY_CAP_SEND_WITHOUT_RESP,	"SEND_WITHOUT_RESP"	},
+	{ MPXY_CAP_GET_NOTIFICATIONS,	"GET_NOTIFICATIONS"	},
+};
+
+static void mpxy_print_capability(u32 val)
+{
+	bool any = false;
+	int i;
+
+	printf("  [0x%02x] %-28s: 0x%08x (", SBI_MPXY_ATTR_CHANNEL_CAPABILITY,
+	       mpxy_std_attr_names[SBI_MPXY_ATTR_CHANNEL_CAPABILITY], val);
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
+	switch (attr_id) {
+	case SBI_MPXY_ATTR_MSG_PROT_ID:
+		printf("  [0x%02x] %-28s: 0x%08x (%s)\n", attr_id,
+		       mpxy_std_attr_names[attr_id], val,
+		       val == SBI_MPXY_MSGPROTO_RPMI_ID ? "RPMI" : "Unknown");
+		break;
+	case SBI_MPXY_ATTR_MSG_PROT_VER:
+		printf("  [0x%02x] %-28s: 0x%08x (v%u.%u)\n", attr_id,
+		       mpxy_std_attr_names[attr_id], val,
+		       (val >> 16) & 0xffff, val & 0xffff);
+		break;
+	case SBI_MPXY_ATTR_MSG_MAX_LEN:
+		printf("  [0x%02x] %-28s: 0x%08x (%u bytes)\n", attr_id,
+		       mpxy_std_attr_names[attr_id], val, val);
+		break;
+	case SBI_MPXY_ATTR_MSG_SEND_TIMEOUT:
+	case SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT:
+		printf("  [0x%02x] %-28s: 0x%08x (%u ms)\n", attr_id,
+		       mpxy_std_attr_names[attr_id], val, val);
+		break;
+	case SBI_MPXY_ATTR_CHANNEL_CAPABILITY:
+		mpxy_print_capability(val);
+		break;
+	default:
+		printf("  [0x%02x] %-28s: 0x%08x\n", attr_id,
+		       mpxy_std_attr_names[attr_id], val);
+		break;
+	}
+}
+
+static void mpxy_print_rpmi_attr(u32 attr_id, u32 val)
+{
+	const char *name = rpmi_proto_attr_name(attr_id);
+
+	switch (attr_id) {
+	case 0x80000001: /* SERVICEGROUP_VERSION */
+	case 0x80000003: /* IMPLEMENTATION_VER */
+		printf("  [0x%08x] %-24s: 0x%08x (v%u.%u)\n", attr_id, name,
+		       val, (val >> 16) & 0xffff, val & 0xffff);
+		break;
+	default:
+		printf("  [0x%08x] %-24s: 0x%08x\n", attr_id, name, val);
+		break;
+	}
+}
+
+/**
+ * mpxy readattrall <channel_id>
+ */
+static int do_mpxy_readattr_all(struct cmd_tbl *cmdtp, int flag, int argc,
+				char *const argv[])
+{
+	struct mpxy_channel *chan;
+	u32 chan_id, attr_id, attr_val;
+	int j, ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	if (cmd_mpxy_probed())
+		return CMD_RET_FAILURE;
+
+	chan_id = simple_strtoul(argv[1], NULL, 0);
+
+	chan = sbi_mpxy_find_channel(chan_id);
+	if (!chan) {
+		printf("Channel 0x%x not found\n", chan_id);
+		return CMD_RET_FAILURE;
+	}
+
+	/* Standard attributes from cache */
+	printf("Channel 0x%x standard attributes:\n", chan_id);
+	for (j = 0; j < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX; j++) {
+		sbi_mpxy_read_attrs(chan, j, 1, &attr_val);
+		mpxy_print_std_attr(j, attr_val);
+	}
+
+	/* Protocol-specific attributes — stop on first error */
+	if (!chan->proto || !chan->proto->readattr)
+		return CMD_RET_SUCCESS;
+
+	printf("Channel 0x%x %s protocol attributes:\n",
+	       chan_id, chan->proto->name);
+
+	for (attr_id = SBI_MPXY_ATTR_MSGPROTO_ATTR_START;
+	     attr_id < SBI_MPXY_ATTR_MSGPROTO_ATTR_END; attr_id++) {
+		ret = sbi_mpxy_read_attrs(chan, attr_id, 1, &attr_val);
+		if (ret)
+			break;
+
+		if (chan->proto->proto_id == SBI_MPXY_MSGPROTO_RPMI_ID)
+			mpxy_print_rpmi_attr(attr_id, attr_val);
+		else
+			printf("  [0x%08x] %-24s: 0x%08x\n", attr_id,
+			       "UNKNOWN", attr_val);
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
+	struct mpxy_channel *chan;
+	u32 chan_id, attr_id, attr_val;
+	int ret;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+
+	if (cmd_mpxy_probed())
+		return CMD_RET_FAILURE;
+
+	chan_id  = simple_strtoul(argv[1], NULL, 0);
+	attr_id  = simple_strtoul(argv[2], NULL, 0);
+	attr_val = simple_strtoul(argv[3], NULL, 0);
+
+	chan = sbi_mpxy_find_channel(chan_id);
+	if (!chan) {
+		printf("Channel 0x%x not found\n", chan_id);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = sbi_mpxy_write_attrs(chan, attr_id, 1, &attr_val);
+	if (ret) {
+		printf("Write attr 0x%x on channel 0x%x failed (%d)\n",
+		       attr_id, chan_id, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Channel 0x%x: attr[0x%x] written 0x%x\n",
+	       chan_id, attr_id, attr_val);
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
+	struct mpxy_channel *chan;
+	u32 tx[SBI_MPXY_MAX_MSG_WORDS];
+	u32 rx[SBI_MPXY_MAX_MSG_WORDS];
+	int tx_words, rx_words = SBI_MPXY_MAX_MSG_WORDS;
+	u32 chan_id;
+	int i, ret;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	if (cmd_mpxy_probed())
+		return CMD_RET_FAILURE;
+
+	chan_id  = simple_strtoul(argv[1], NULL, 0);
+	tx_words = argc - 2;
+
+	if (tx_words > SBI_MPXY_MAX_MSG_WORDS) {
+		printf("Too many words (max %d)\n", SBI_MPXY_MAX_MSG_WORDS);
+		return CMD_RET_FAILURE;
+	}
+
+	for (i = 0; i < tx_words; i++)
+		tx[i] = simple_strtoul(argv[2 + i], NULL, 0);
+
+	chan = sbi_mpxy_find_channel(chan_id);
+	if (!chan) {
+		printf("Channel 0x%x not found\n", chan_id);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = sbi_mpxy_send(chan, tx, tx_words, rx, &rx_words);
+	if (ret) {
+		printf("Send on channel 0x%x failed (%d)\n", chan_id, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Response (%d word(s)):\n", rx_words);
+	for (i = 0; i < rx_words; i++)
+		printf("  [%2d] 0x%08x\n", i, rx[i]);
+
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * Subcommand table and top-level dispatch
+ */
+static struct cmd_tbl cmd_mpxy_sub[] = {
+	U_BOOT_CMD_MKENT(list,		1,		0,	do_mpxy_list,		"",	""),
+	U_BOOT_CMD_MKENT(readattr,	3,		0,	do_mpxy_readattr,	"",	""),
+	U_BOOT_CMD_MKENT(readattrall,	2,		0,	do_mpxy_readattr_all,	"",	""),
+	U_BOOT_CMD_MKENT(writeattr,	4,		0,	do_mpxy_writeattr,	"",	""),
+	U_BOOT_CMD_MKENT(send,	CONFIG_SYS_MAXARGS,	0,	do_mpxy_send,		"",	""),
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
+U_BOOT_CMD(mpxy, CONFIG_SYS_MAXARGS, 0, do_mpxy,
+	   "SBI MPXY channel debug commands",
+	   "list                              - list discovered channels\n"
+	   "mpxy readattr    <chan> <attr>         - read one attribute\n"
+	   "mpxy readattrall <chan>                - read all attributes\n"
+	   "mpxy writeattr   <chan> <attr> <val>   - write an attribute\n"
+	   "mpxy send        <chan> <msg_id> [payload_word ...]  - send message\n");
-- 
2.43.0

