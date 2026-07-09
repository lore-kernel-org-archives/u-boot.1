Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DE7C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A2084AA1;
	Fri, 10 Jul 2026 14:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hggdGUz/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MCCOcb1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07FC084BF4; Thu,  9 Jul 2026 19:56:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD2F84BF0
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 19:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rahul.pathak@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HX3ZW2563618
 for <u-boot@lists.denx.de>; Thu, 9 Jul 2026 17:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=34F2ePOLHsu
 TfzKIRgclAgR1WQWom7n926blqBZ436w=; b=hggdGUz/uvaJtd8OQzxNNNkYH6z
 afbdw+fYVwBYLqb3FSJ+KKrpz3nA7pQIn0B2klNrZAwUjDXoz9Jq/8WB0apBHLMv
 kGjtgLHw2pR+WKvSdDuJ2xB5xtZiY4Sdl6SWGRT4jjPiNNZ8NdUvPXqC4UcE2RkN
 qYhhSwTR3X4xDLq4fMYUtKbOEvH0n6nwfGKC6TvOvoHeJXiN5YlCibWdMpTwCFtn
 pa8XZCnKqLDmYb9uvTYi+TosJqqZru35zAiJsI4jFSgiL1jlsglpLEJAvrE0k9qo
 +uvmWq5XY5mHnXItp4qRVn4Q0PPnFab7CX/frOqqM6fNCq4PNqbFf8mjlKw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3gqn2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 17:56:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cca3673560so586565ad.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783619775; x=1784224575; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=34F2ePOLHsuTfzKIRgclAgR1WQWom7n926blqBZ436w=;
 b=MCCOcb1KZA6omMcoXntdmpgni/oC7fwL0afDHfVwchwf+1bZ3wXz0CfJQkNYDhBI78
 nncK1b/+e2/Tj1xd5EwMMZiGYriYXaTNp3GcC5OMHjz9UMkOgroUqIMMb5+VH1eDOIqP
 UotIAI41rmTKQ+WYBQO1l3eQLw89Jx2VsvdeR0JzMUuSA3PXl364yKHGR3g2frcElwkf
 F/wiYLd6lVdZf/F3AqyYc5T1uanh8qzzbRTLz8gtlBCIm+uo7+NFUX4GKQBROYG6QVRt
 aEu1e7VUOJIZCypzymst6zNDHVQr0jmVzJPCZAMlPts7zMcMbh6pna/aY/R0vSfOAMDf
 2ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783619775; x=1784224575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=34F2ePOLHsuTfzKIRgclAgR1WQWom7n926blqBZ436w=;
 b=dciW5SGsFrP5iTXXb4sL12SEcgOBTj1X6SsFoJJbKulQ17/Bsa/uszzy0Coz1XpfbL
 QuaOupBSWfb9G753x9hoeRVLopW7dcSOWDfOyOIF6ungxTVH09sw8urXz7HLn7mZNf47
 cDmMP+q/AOtnC1Bmdv3g2v/gu/FJuQxuifZv4VLZugoSwuT8KTHZInLclct3AXxPTVXq
 77jEWbK0bxjOEXGWHptl/dZOITeQwPVkbaeQTk1YEbwdxKSxEtXomm4QHjOXaqFSXeDQ
 SrMUTM0IkXaBvplcsMuiddDd2PwinnxmbKxVl4zruzlMFqPR6B71YXIx48QtFo8EETpr
 Ig/A==
X-Gm-Message-State: AOJu0YyDOc0GJIufat/EX0+5e4XDyhaEM3uLTUcGaabk98fzzOtRAPsw
 VflzSIc2EMgsit4ghl+Vx1c0gMMq6ZpLGC3QW9Jw83BJID/7zn4EdkOclbj65eVMnp4cNXuPzZe
 QOBJnmirQhh1LVh4v/KYrG17nr4DDacf6nqhL0uCRponBwfrR04KL7oFoI8Ennflt
X-Gm-Gg: AfdE7cnUmQUJlz0Rn5WkhzkOFQK4YML3EdbfpcKle5a4SDiAkXw3Oh97icqYPL/G6w/
 Xy6qKB7ujUEuO/rENh3+eO9ENWWcBxc9aueh8mri/4DpQBU0Bs3jvPaR2MzwwvsNK3Sn1cIbZHK
 hTAu67IMhqGJA8UkAgkpVdEQ0rDEUOIHVXXfmo1GDEX1K5h22A6ax/KFF+4hutP0gyNdmfsrexX
 I6DoWyf75BwaYKPgjkbDHEo3ttoxqXyt19cghL+6RIAaNRY6Um6UqK7525j6aS6s/iXUKkY/0ge
 hSDBgCNurS3rRr2WnmFBj6pbQcLHHWu+dQx32frFnUCc1YIx5VX2ilEkvbkNuPEmvUq5pplK7Jj
 bb7zHEwDK17uvAmYETdwUlV0EqoZyoYMcm16VhBjtv2y8iOJkbMNSuwRJLapXF190WYdrTb0Wdt
 WqZOO3EsBZq9AgBY6sjcONSQsStuVx6Kk=
X-Received: by 2002:a05:6a20:12cf:b0:3bf:d0c8:2aa4 with SMTP id
 adf61e73a8af0-3c0bcbe7876mr9460027637.8.1783619774364; 
 Thu, 09 Jul 2026 10:56:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:12cf:b0:3bf:d0c8:2aa4 with SMTP id
 adf61e73a8af0-3c0bcbe7876mr9459992637.8.1783619773678; 
 Thu, 09 Jul 2026 10:56:13 -0700 (PDT)
Received: from hu-rahupath-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accae5sm51523828eec.29.2026.07.09.10.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:56:13 -0700 (PDT)
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: rahul.pathak@oss.qualcomm.com, anup.patel@oss.qualcomm.com
Subject: [PATCH 1/3] riscv: Add SBI MPXY generic interface
Date: Thu,  9 Jul 2026 23:26:02 +0530
Message-ID: <20260709175605.1070755-2-rahul.pathak@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfXzGeIvF18EfaI
 gYvBKZdZDJR+3lsuy5dtNHZbW0r1YcuNd1PrkCBNKA/mkWFiD/g8Ek/Wc+QGSwjZpypH1TM65JR
 fV9tDOpTU8uwsWG0z0YWAfzhGhWfTyC8sCWvU4kkpsy2A+gIfE2BAREerEOCAD+IYQHMZtu4C/p
 tl6+Kyem82ezuZnSo72ZqB/j7X7MPl0ToMKMEfK+iPIqP4eBbrC2mv554sVH01xRmsJ8mxaCCzG
 Wg16t6jvOHfaTNUx4EWilMMmPzk+fmP8kFCjll2GgpdGLOWFVKrSc4yg1sfkpZsMe1G22HFuXjz
 zoXRL933GYNODdn8intU0OxCu3b0Wzm1maW9GNKV5STBQLXFSCoAz5Anshgv6+Eg2BvzVe33aW6
 DwDc/NNh/hCnJ4gXxpq0T56Cnx1fcr3e0UTRQw+RhHsjLzWGPDzjBN5enir0vl4tDUfNqJ3IJHe
 k24CPi8bhGZ+e0XVtYg==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a4fe0bf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=0X_WYvsZOT2rkgR8w3EA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfX3CKA7zKwG5vX
 HG/ZSlSW5kTJ6KAE1p/F0sXVgW/ISKmPhcl/QEaICdQgGOzLbyHdZgg3+KWO56gW+mtcD56XO4v
 CJOebRw5S/ZIxy0OoCLhbFIfunsXX+s=
X-Proofpoint-GUID: uWKyQCcv5VQLwjTh9jNZYcaBzjZrWU2C
X-Proofpoint-ORIG-GUID: uWKyQCcv5VQLwjTh9jNZYcaBzjZrWU2C
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

SBI MPXY interface implements the SBI MPXY
extension to interact with supported message
protocols for platform management and control

Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
---
 arch/riscv/Kconfig           |   9 +
 arch/riscv/include/asm/sbi.h | 268 ++++++++++++++++++
 arch/riscv/lib/Makefile      |   1 +
 arch/riscv/lib/sbi_mpxy.c    | 529 +++++++++++++++++++++++++++++++++++
 4 files changed, 807 insertions(+)
 create mode 100644 arch/riscv/lib/sbi_mpxy.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 265b5320777..e0efcd19ce5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -473,6 +473,15 @@ config SBI_IPI
 	default y if RISCV_SMODE || SPL_RISCV_SMODE
 	depends on SMP
 
+config SBI_MPXY
+	bool "SBI MPXY generic core"
+	depends on RISCV_SMODE || SPL_RISCV_SMODE
+	help
+	  Enable the generic SBI MPXY (Message Proxy Extension) core.
+	  Provides channel discovery, shared memory setup, attribute
+	  caching, and protocol driver registration. Required by
+	  CMD_MPXY and any driver that communicates via MPXY channels.
+
 config XIP
 	bool "XIP mode"
 	help
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 47124dbaac8..d98c98bf4f4 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -10,6 +10,7 @@
 #define _ASM_RISCV_SBI_H
 
 #include <linux/types.h>
+#include <compiler.h>
 
 enum sbi_ext_id {
 	SBI_EXT_0_1_SET_TIMER = 0x0,
@@ -104,6 +105,36 @@ enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE,
 };
 
+/* MPXY Standard Channel Attribute IDs */
+enum sbi_mpxy_attr_id {
+	SBI_MPXY_ATTR_MSG_PROT_ID		= 0x00000000,
+	SBI_MPXY_ATTR_MSG_PROT_VER		= 0x00000001,
+	SBI_MPXY_ATTR_MSG_MAX_LEN		= 0x00000002,
+	SBI_MPXY_ATTR_MSG_SEND_TIMEOUT		= 0x00000003,
+	SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT	= 0x00000004,
+	SBI_MPXY_ATTR_CHANNEL_CAPABILITY	= 0x00000005,
+	SBI_MPXY_ATTR_SSE_EVENT_ID		= 0x00000006,
+	SBI_MPXY_ATTR_MSI_CONTROL		= 0x00000007,
+	SBI_MPXY_ATTR_MSI_ADDR_LO		= 0x00000008,
+	SBI_MPXY_ATTR_MSI_ADDR_HI		= 0x00000009,
+	SBI_MPXY_ATTR_MSI_DATA			= 0x0000000A,
+	SBI_MPXY_ATTR_EVENTS_STATE_CONTROL	= 0x0000000B,
+	SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_START	= 0x80000000,
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_END		= 0xffffffff,
+};
+
+/* MPXY Function IDs */
+enum sbi_ext_mpxy_fid {
+	SBI_EXT_MPXY_GET_SHMEM_SIZE = 0,
+	SBI_EXT_MPXY_SET_SHMEM,
+	SBI_EXT_MPXY_GET_CHANNEL_IDS,
+	SBI_EXT_MPXY_READ_ATTRS,
+	SBI_EXT_MPXY_WRITE_ATTRS,
+	SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
+	SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
+};
+
 #ifdef CONFIG_SBI_V01
 #define SBI_EXT_SET_TIMER		SBI_EXT_0_1_SET_TIMER
 #define SBI_FID_SET_TIMER		0
@@ -128,6 +159,8 @@ enum sbi_ext_dbcn_fid {
 #define SBI_FID_REMOTE_SFENCE_VMA_ASID	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID
 #endif
 
+/* SBI spec version fields */
+#define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
 #define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
@@ -140,11 +173,65 @@ enum sbi_ext_dbcn_fid {
 #define SBI_ERR_DENIED			-4
 #define SBI_ERR_INVALID_ADDRESS		-5
 
+/* SBI MPXY extension defines */
+#define SBI_MPXY_MAX_CHANNELS		16
+#define SBI_MPXY_MAX_MSG_WORDS		64
+#define SBI_MPXY_SHMEM_ALIGN		4096
+#define SBI_MPXY_MSGPROTO_RPMI_ID	0x0
+
 struct sbiret {
 	long error;
 	long value;
 };
 
+struct mpxy_channel;
+
+/**
+ * struct mpxy_proto_ops - Message protocol driver operations
+ *
+ * @proto_id:	Protocol identifier
+ * @name:	Protocol name
+ * @readattr:	Read a protocol-specific attribute (attr_id >= 0x80000000)
+ * @writeattr:	Write a protocol-specific attribute
+ * @send:	Send a message and receive a response
+ */
+struct mpxy_proto_ops {
+	u32		 proto_id;
+	const char	*name;
+
+	int (*readattr)(struct mpxy_channel *chan, u32 attr_id, u32 *attr_val);
+	int (*writeattr)(struct mpxy_channel *chan, u32 attr_id, u32 attr_val);
+};
+
+/* Standard channel attributes as returned by firmware */
+struct sbi_mpxy_channel_attrs {
+	u32 msg_proto_id;
+	u32 msg_proto_version;
+	u32 msg_max_len;
+	u32 msg_send_timeout;
+	u32 msg_completion_timeout;
+	u32 capability;
+	u32 sse_event_id;
+	u32 msi_control;
+	u32 msi_addr_lo;
+	u32 msi_addr_hi;
+	u32 msi_data;
+	u32 events_state_ctrl;
+};
+
+/*
+ * struct mpxy_channel - Represents a single MPXY channel
+ *
+ * @channel_id:	MPXY Channel ID
+ * @std_attrs:	MPXY channel standard attributes
+ * @proto:	Pointer to the protocol driver instance
+ */
+struct mpxy_channel {
+	u32				 channel_id;
+	struct sbi_mpxy_channel_attrs	 std_attrs;
+	const struct mpxy_proto_ops	*proto;
+};
+
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
@@ -165,6 +252,26 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 				unsigned long size,
 				unsigned long asid);
 #endif
+
+/* Get the major version of SBI */
+static inline unsigned long sbi_major_version(long version)
+{
+	return (version >> SBI_SPEC_VERSION_MAJOR_SHIFT) &
+		SBI_SPEC_VERSION_MAJOR_MASK;
+}
+
+/* Get the minor version of SBI */
+static inline unsigned long sbi_minor_version(long version)
+{
+	return (version & SBI_SPEC_VERSION_MINOR_MASK);
+}
+
+/* Check if current SBI specification version is 0.1 or not */
+static inline int sbi_spec_is_0_1(long version)
+{
+	return (version == SBI_SPEC_VERSION_DEFAULT) ? 1 : 0;
+}
+
 void sbi_set_timer(uint64_t stime_value);
 long sbi_get_spec_version(void);
 int sbi_get_impl_id(void);
@@ -176,4 +283,165 @@ int sbi_get_mimpid(long *mimpid);
 void sbi_srst_reset(unsigned long type, unsigned long reason);
 int sbi_dbcn_write_byte(unsigned char ch);
 
+/**
+ * sbi_set_timer() - Program the next timer event
+ * @stime_value:	Absolute time value at which the timer should fire
+ */
+void sbi_set_timer(uint64_t stime_value);
+
+/**
+ * sbi_get_spec_version() - Get the SBI specification version implemented
+ *			    by the running SBI implementation
+ */
+long sbi_get_spec_version(void);
+
+/**
+ * sbi_get_impl_id() - Get the SBI implementation ID
+ */
+int sbi_get_impl_id(void);
+
+/**
+ * sbi_get_impl_version() - Get the SBI implementation version
+ * @version:	Output pointer to store the implementation version
+ */
+int sbi_get_impl_version(long *version);
+
+/**
+ * sbi_probe_extension() - Check whether an SBI extension is available
+ * @ext:	SBI extension ID to probe
+ */
+int sbi_probe_extension(int ext);
+
+/**
+ * sbi_get_mvendorid() - Get the value of the mvendorid CSR
+ * @mvendorid:	Output pointer to store the mvendorid value
+ */
+int sbi_get_mvendorid(long *mvendorid);
+
+/**
+ * sbi_get_marchid() - Get the value of the marchid CSR
+ * @marchid:	Output pointer to store the marchid value
+ */
+int sbi_get_marchid(long *marchid);
+
+/**
+ * sbi_get_mimpid() - Get the value of the mimpid CSR
+ * @mimpid:	Output pointer to store the mimpid value
+ */
+int sbi_get_mimpid(long *mimpid);
+
+/**
+ * sbi_srst_reset() - Request a system reset via the SBI SRST extension
+ * @type:	Reset type (e.g. shutdown, cold reboot, warm reboot)
+ * @reason:	Reset reason code
+ */
+void sbi_srst_reset(unsigned long type, unsigned long reason);
+
+/**
+ * sbi_dbcn_write_byte() - Write a single byte via the SBI Debug Console
+ *			   extension
+ * @ch:		Byte to write
+ */
+int sbi_dbcn_write_byte(unsigned char ch);
+
+/**
+ * sbi_mpxy_register_proto() - Register a message protocol driver
+ * @ops:	Protocol ops to register
+ */
+int sbi_mpxy_register_proto(const struct mpxy_proto_ops *ops);
+
+/**
+ * sbi_mpxy_probe() - Probe MPXY extension, set up shmem, scan channels
+ */
+int sbi_mpxy_probe(void);
+
+/**
+ * sbi_mpxy_is_available() - Check whether MPXY was successfully probed
+ */
+bool sbi_mpxy_is_available(void);
+
+/**
+ * sbi_mpxy_shmem_ptr() - Return pointer to the shared memory window
+ */
+void *sbi_mpxy_shmem_ptr(void);
+
+/**
+ * sbi_mpxy_shmem_size() - Return size of shared memory in bytes
+ */
+u32 sbi_mpxy_shmem_size(void);
+
+/**
+ * sbi_mpxy_channel_count() - Return number of discovered channels
+ */
+int sbi_mpxy_channel_count(void);
+
+/**
+ * sbi_mpxy_get_channel() - Get channel by index
+ * @channel_id:	Index in [0, sbi_mpxy_channel_count())
+ */
+struct mpxy_channel *sbi_mpxy_get_channel(int channel_id);
+
+/**
+ * sbi_mpxy_find_channel() - Find channel by channel ID
+ * @channel_id:	Channel ID to search for
+ */
+struct mpxy_channel *sbi_mpxy_find_channel(u32 channel_id);
+
+/**
+ * sbi_mpxy_read_attrs() - Read a contiguous range of channel attributes
+ * @chan:		Target channel
+ * @base_attr_id:	First attribute ID in the range
+ * @attr_count:		Number of attributes to read
+ * @attrs_buf:		Output buffer (attr_count u32 words)
+ */
+int sbi_mpxy_read_attrs(struct mpxy_channel *chan, u32 base_attr_id,
+			u32 attr_count, u32 *attrs_buf);
+
+/**
+ * sbi_mpxy_write_attrs() - Write a contiguous range of channel attributes
+ *
+ * @chan:		Target channel
+ * @base_attr_id:	First attribute ID in the range
+ * @attr_count:		Number of attributes to write
+ * @attrs_buf:		Input buffer (attr_count u32 words)
+ */
+int sbi_mpxy_write_attrs(struct mpxy_channel *chan, u32 base_attr_id,
+			 u32 attr_count, u32 *attrs_buf);
+
+/**
+ * sbi_mpxy_send_message_with_resp() - Send a message and receive a response
+ * @chan:	Target channel
+ * @msg_id:	Message ID
+ * @tx:		TX payload buffer (copied into shmem before ecall)
+ * @tx_len:	TX payload length in bytes
+ * @rx:		RX buffer (copied from shmem after ecall)
+ * @max_rx_len:	RX buffer capacity in bytes
+ * @rx_len:	Output: actual response length in bytes (from sret.value)
+ */
+int sbi_mpxy_send_message_with_resp(struct mpxy_channel *chan, u32 msg_id,
+				    void *tx, unsigned long tx_len,
+				    void *rx, unsigned long max_rx_len,
+				    unsigned long *rx_len);
+
+/**
+ * sbi_mpxy_send_message_without_resp() - Send a message with no response
+ * @chan:	Target channel
+ * @msg_id:	Message ID
+ * @tx:		TX payload buffer
+ * @tx_len:	TX payload length in bytes
+ */
+int sbi_mpxy_send_message_without_resp(struct mpxy_channel *chan, u32 msg_id,
+				       void *tx, unsigned long tx_len);
+
+/**
+ * sbi_mpxy_send() - Word-oriented send used by the mpxy command
+ * @chan:	Target channel
+ * @tx:		tx[0]=msg_id, tx[1..n-1]=payload words
+ * @tx_words:	Total words including msg_id
+ * @rx:		Receive buffer
+ * @rx_words:	In: capacity; Out: words received
+ */
+int sbi_mpxy_send(struct mpxy_channel *chan, u32 *tx, int tx_words,
+		  u32 *rx, int *rx_words);
+
 #endif
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index f1f50918eff..32f8fb5dbbe 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_ANDES_PLICSW) += andes_plicsw.o
 else
 obj-$(CONFIG_SBI) += sbi.o
 obj-$(CONFIG_SBI_IPI) += sbi_ipi.o
+obj-$(CONFIG_SBI_MPXY) += sbi_mpxy.o
 endif
 obj-y	+= interrupts.o
 ifeq ($(CONFIG_$(PHASE_)SYSRESET),)
diff --git a/arch/riscv/lib/sbi_mpxy.c b/arch/riscv/lib/sbi_mpxy.c
new file mode 100644
index 00000000000..f95cedaabac
--- /dev/null
+++ b/arch/riscv/lib/sbi_mpxy.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SBI MPXY (Message Proxy) Generic Library
+ *
+ * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
+ */
+
+#include <errno.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/sbi.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+/** Maximum number of registered protocol drivers */
+#define MPXY_MAX_PROTOS		8
+
+/**
+ * SBI MPXY channel IDs data in shared memory.
+ */
+struct sbi_mpxy_channel_ids_data {
+	/* Remaining number of channel ids */
+	__le32 remaining;
+	/* Returned channel ids in current function call */
+	__le32 returned;
+	/* Returned channel id array */
+	__le32 channel_array[];
+};
+
+/**
+ * MPXY Context
+ */
+struct mpxy_context {
+	phys_addr_t		 shmem_addr;
+	u32			 shmem_size;
+	struct mpxy_channel	 channels[SBI_MPXY_MAX_CHANNELS];
+	int			 channel_count;
+};
+
+static struct mpxy_context mpxy_ctx;
+static int mpxy_proto_count;
+static const struct mpxy_proto_ops *mpxy_protos[MPXY_MAX_PROTOS];
+
+static bool mpxy_probe_done;
+static bool mpxy_available;
+
+/**
+ * Protocol registration
+ */
+int sbi_mpxy_register_proto(const struct mpxy_proto_ops *ops)
+{
+	if (!ops)
+		return -EINVAL;
+
+	if (mpxy_proto_count >= MPXY_MAX_PROTOS) {
+		log_err("sbi_mpxy: protocol table full, cannot register %s\n",
+			ops->name ? ops->name : "unknown");
+		return -ENOSPC;
+	}
+
+	mpxy_protos[mpxy_proto_count++] = ops;
+	return 0;
+}
+
+/**
+ * Return MPXY shared memory base pointer
+ */
+static inline void *shmem_base(void)
+{
+	return (void *)(uintptr_t)mpxy_ctx.shmem_addr;
+}
+
+/**
+ * Probe MPXY extension
+ */
+static int mpxy_check_extension(void)
+{
+	long ret;
+
+	ret = sbi_get_spec_version();
+	if (ret < 0 || sbi_spec_is_0_1(ret)) {
+		log_err("sbi_mpxy: SBI v0.2+ not detected\n");
+		return -ENOTSUPP;
+	}
+
+	ret = sbi_probe_extension(SBI_EXT_MPXY);
+	if (ret <= 0) {
+		log_err("sbi_mpxy: MPXY extension not available\n");
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * Setup the MPXY shared memory
+ */
+static int mpxy_setup_shmem(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_GET_SHMEM_SIZE,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		log_err("sbi_mpxy: GET_SHMEM_SIZE failed (%ld)\n", ret.error);
+		return -EINVAL;
+	}
+
+	mpxy_ctx.shmem_size = ret.value;
+
+	mpxy_ctx.shmem_addr = (phys_addr_t)(uintptr_t)memalign(SBI_MPXY_SHMEM_ALIGN,
+								mpxy_ctx.shmem_size);
+	if (!mpxy_ctx.shmem_addr) {
+		log_err("sbi_mpxy: failed to allocate %u bytes for shmem\n",
+			mpxy_ctx.shmem_size);
+		return -ENOMEM;
+	}
+
+	ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_SET_SHMEM,
+			mpxy_ctx.shmem_addr, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		log_err("sbi_mpxy: SET_SHMEM failed (%ld)\n", ret.error);
+		free((void *)(uintptr_t)mpxy_ctx.shmem_addr);
+		mpxy_ctx.shmem_addr = 0;
+		return -EINVAL;
+	}
+
+	log_debug("sbi_mpxy: shmem at 0x%llx, size %u\n",
+		  (unsigned long long)mpxy_ctx.shmem_addr,
+		  mpxy_ctx.shmem_size);
+
+	return 0;
+}
+
+/**
+ * Get MPXY channels present in the system
+ */
+static int mpxy_scan_channels(void)
+{
+	struct sbi_mpxy_channel_ids_data *sdata = shmem_base();
+	u32 start = 0, total = 0;
+	u32 remaining, returned;
+	struct sbiret ret;
+	int i;
+
+	do {
+		ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_GET_CHANNEL_IDS,
+				start, 0, 0, 0, 0, 0);
+		if (ret.error) {
+			log_err("sbi_mpxy: GET_CHANNEL_IDS failed (%ld)\n",
+				ret.error);
+			return -EINVAL;
+		}
+
+		remaining = le32_to_cpu(sdata->remaining);
+		returned  = le32_to_cpu(sdata->returned);
+
+		for (i = 0; i < returned; i++) {
+			if (total >= SBI_MPXY_MAX_CHANNELS) {
+				log_warning("sbi_mpxy: channel table full, "
+					    "truncating at %d\n",
+					    SBI_MPXY_MAX_CHANNELS);
+				goto done;
+			}
+			mpxy_ctx.channels[total].channel_id =
+				le32_to_cpu(sdata->channel_array[i]);
+			total++;
+		}
+
+		start += returned;
+
+	} while (remaining);
+
+done:
+	mpxy_ctx.channel_count = total;
+	log_debug("sbi_mpxy: found %d channel(s)\n", total);
+	return 0;
+}
+
+
+static void mpxy_bind_protocols(void)
+{
+	int i, j;
+
+	for (i = 0; i < mpxy_ctx.channel_count; i++) {
+		struct mpxy_channel *chan = &mpxy_ctx.channels[i];
+
+		chan->proto = NULL;
+		for (j = 0; j < mpxy_proto_count; j++) {
+			if (mpxy_protos[j]->proto_id ==
+			    chan->std_attrs.msg_proto_id) {
+				chan->proto = mpxy_protos[j];
+				break;
+			}
+		}
+
+		if (!chan->proto)
+			log_warning("sbi_mpxy: no driver for channel 0x%x "
+				    "protocol 0x%x\n",
+				    chan->channel_id,
+				    chan->std_attrs.msg_proto_id);
+		else
+			log_debug("sbi_mpxy: channel 0x%x bound to %s\n",
+				  chan->channel_id, chan->proto->name);
+	}
+}
+
+int sbi_mpxy_probe(void)
+{
+	int i, ret;
+
+	if (mpxy_probe_done)
+		return mpxy_available ? 0 : -ENOTSUPP;
+
+	mpxy_probe_done = true;
+
+	ret = mpxy_check_extension();
+	if (ret)
+		goto fail;
+
+	ret = mpxy_setup_shmem();
+	if (ret)
+		goto fail;
+
+	ret = mpxy_scan_channels();
+	if (ret)
+		goto fail;
+
+	for (i = 0; i < mpxy_ctx.channel_count; i++) {
+		ret = sbi_mpxy_read_attrs(&mpxy_ctx.channels[i], 0,
+					  sizeof(struct sbi_mpxy_channel_attrs) /
+					  sizeof(u32),
+					  (u32 *)&mpxy_ctx.channels[i].std_attrs);
+		if (ret)
+			goto fail;
+	}
+
+	mpxy_bind_protocols();
+
+	mpxy_available = true;
+	return 0;
+
+fail:
+	mpxy_available = false;
+	return ret;
+}
+
+bool sbi_mpxy_is_available(void)
+{
+	return mpxy_available;
+}
+
+int sbi_mpxy_channel_count(void)
+{
+	if (!sbi_mpxy_is_available())
+		return 0;
+
+	return mpxy_ctx.channel_count;
+}
+
+struct mpxy_channel *sbi_mpxy_get_channel(int channel_id)
+{
+	if (channel_id < 0 || channel_id >= mpxy_ctx.channel_count)
+		return NULL;
+	return &mpxy_ctx.channels[channel_id];
+}
+
+struct mpxy_channel *sbi_mpxy_find_channel(u32 channel_id)
+{
+	int i;
+
+	for (i = 0; i < mpxy_ctx.channel_count; i++) {
+		if (mpxy_ctx.channels[i].channel_id == channel_id)
+			return &mpxy_ctx.channels[i];
+	}
+	return NULL;
+}
+
+/**
+ * Return pointer to the MPXY shared memory
+ */
+void *sbi_mpxy_shmem_ptr(void)
+{
+	if (!sbi_mpxy_is_available())
+		return NULL;
+	return shmem_base();
+}
+
+/**
+ * Get the MPXY shared memory size
+ */
+u32 sbi_mpxy_shmem_size(void)
+{
+	if (!sbi_mpxy_is_available())
+		return 0;
+
+	return mpxy_ctx.shmem_size;
+}
+
+/**
+ * sbi_mpxy_read_attrs() - Read a contiguous range of channel attributes
+ *
+ * @chan:		Target channel
+ * @base_attr_id:	First attribute ID in the range
+ * @attr_count:		Number of attributes to read
+ * @attrs_buf:		Output buffer (attr_count u32 words)
+ */
+int sbi_mpxy_read_attrs(struct mpxy_channel *chan, u32 base_attr_id,
+			u32 attr_count, u32 *attrs_buf)
+{
+	struct sbiret ret;
+	__le32 *shmem;
+	u32 end_id;
+	int i;
+
+	if (!chan || !attr_count || !attrs_buf)
+		return -EINVAL;
+
+	if (attr_count > mpxy_ctx.shmem_size / sizeof(u32))
+		return -EINVAL;
+
+	shmem = (__le32 *)shmem_base();
+	if (!shmem)
+		return -ENXIO;
+
+	end_id = base_attr_id + attr_count - 1;
+
+	if (base_attr_id < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX) {
+		/* Standard attributes */
+		if (end_id >= SBI_MPXY_ATTR_STD_ATTR_MAX_IDX)
+			return -EINVAL;
+
+		ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS,
+				chan->channel_id, base_attr_id, attr_count,
+				0, 0, 0);
+		if (ret.error)
+			return -EINVAL;
+
+		for (i = 0; i < attr_count; i++)
+			attrs_buf[i] = le32_to_cpu(shmem[i]);
+
+		return 0;
+	}
+
+	if (base_attr_id >= SBI_MPXY_ATTR_MSGPROTO_ATTR_START &&
+	    end_id < SBI_MPXY_ATTR_MSGPROTO_ATTR_END) {
+		/* Protocol-specific attributes */
+		if (!chan->proto || !chan->proto->readattr)
+			return -ENOSYS;
+
+		ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS,
+				chan->channel_id, base_attr_id, attr_count,
+				0, 0, 0);
+		if (ret.error)
+			return -EINVAL;
+
+		for (i = 0; i < attr_count; i++)
+			attrs_buf[i] = le32_to_cpu(shmem[i]);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * sbi_mpxy_write_attrs() - Write a contiguous range of channel attributes
+ *
+ * @chan:		Target channel
+ * @base_attr_id:	First attribute ID in the range
+ * @attr_count:		Number of attributes to write
+ * @attrs_buf:		Input buffer (attr_count u32 words)
+ */
+int sbi_mpxy_write_attrs(struct mpxy_channel *chan, u32 base_attr_id,
+			 u32 attr_count, u32 *attrs_buf)
+{
+	struct sbiret ret;
+	__le32 *shmem;
+	u32 end_id;
+	int i;
+
+	if (!chan || !attr_count || !attrs_buf)
+		return -EINVAL;
+
+	if (attr_count > mpxy_ctx.shmem_size / sizeof(u32))
+		return -EINVAL;
+
+	shmem = (__le32 *)shmem_base();
+	if (!shmem)
+		return -ENXIO;
+
+	end_id = base_attr_id + attr_count - 1;
+
+	if (base_attr_id < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX) {
+		/* Standard attributes */
+		if (end_id >= SBI_MPXY_ATTR_STD_ATTR_MAX_IDX)
+			return -EINVAL;
+
+		for (i = 0; i < attr_count; i++)
+			shmem[i] = cpu_to_le32(attrs_buf[i]);
+
+		ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_WRITE_ATTRS,
+				chan->channel_id, base_attr_id, attr_count,
+				0, 0, 0);
+		return ret.error ? -EINVAL : 0;
+	}
+
+	if (base_attr_id >= SBI_MPXY_ATTR_MSGPROTO_ATTR_START &&
+	    end_id < SBI_MPXY_ATTR_MSGPROTO_ATTR_END) {
+		/* Protocol-specific attributes */
+		if (!chan->proto || !chan->proto->writeattr)
+			return -ENOSYS;
+
+		for (i = 0; i < attr_count; i++) {
+			ret.error = chan->proto->writeattr(chan,
+							   base_attr_id + i,
+							   attrs_buf[i]);
+			if (ret.error)
+				return ret.error;
+		}
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * sbi_mpxy_send_message_with_resp() - Send a message and receive a response
+ */
+int sbi_mpxy_send_message_with_resp(struct mpxy_channel *chan, u32 msg_id,
+				    void *tx, unsigned long tx_len,
+				    void *rx, unsigned long max_rx_len,
+				    unsigned long *rx_len)
+{
+	unsigned long rx_bytes;
+	struct sbiret ret;
+	void *shmem;
+
+	if (!chan)
+		return -EINVAL;
+	if (!tx && tx_len)
+		return -EINVAL;
+
+	shmem = sbi_mpxy_shmem_ptr();
+	if (!shmem)
+		return -ENXIO;
+
+	if (tx_len)
+		memcpy(shmem, tx, tx_len);
+
+	ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
+			chan->channel_id, msg_id, tx_len, 0, 0, 0);
+	if (ret.error)
+		return -EINVAL;
+
+	if (rx) {
+		rx_bytes = ret.value;
+		if (rx_bytes > max_rx_len)
+			return -ENOSPC;
+		memcpy(rx, shmem, rx_bytes);
+		if (rx_len)
+			*rx_len = rx_bytes;
+	}
+
+	return 0;
+}
+
+/**
+ * sbi_mpxy_send_message_without_resp() - Send a message with no response
+ */
+int sbi_mpxy_send_message_without_resp(struct mpxy_channel *chan, u32 msg_id,
+				       void *tx, unsigned long tx_len)
+{
+	struct sbiret ret;
+	void *shmem;
+
+	if (!chan)
+		return -EINVAL;
+	if (!tx && tx_len)
+		return -EINVAL;
+
+	shmem = sbi_mpxy_shmem_ptr();
+	if (!shmem)
+		return -ENXIO;
+
+	if (tx_len)
+		memcpy(shmem, tx, tx_len);
+
+	ret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
+			chan->channel_id, msg_id, tx_len, 0, 0, 0);
+
+	return ret.error ? -EINVAL : 0;
+}
+
+/**
+ * sbi_mpxy_send() - Word-oriented send used by the mpxy command
+ *
+ * tx[0] = msg_id, tx[1..n-1] = payload words.
+ * Wraps sbi_mpxy_send_message_with_resp().
+ */
+int sbi_mpxy_send(struct mpxy_channel *chan, u32 *tx, int tx_words,
+		  u32 *rx, int *rx_words)
+{
+	unsigned long rx_len = 0;
+	unsigned long tx_len;
+	u32 msg_id;
+	int ret;
+
+	if (!chan || !tx || !rx || !rx_words)
+		return -EINVAL;
+
+	if (tx_words < 1)
+		return -EINVAL;
+
+	msg_id = tx[0];
+	tx_len = (tx_words - 1) * sizeof(u32);
+
+	ret = sbi_mpxy_send_message_with_resp(chan, msg_id,
+					      tx_words > 1 ? &tx[1] : NULL,
+					      tx_len,
+					      rx,
+					      (unsigned long)(*rx_words) * sizeof(u32),
+					      &rx_len);
+	if (ret)
+		return ret;
+
+	*rx_words = (int)(rx_len / sizeof(u32));
+	return 0;
+}
-- 
2.43.0

