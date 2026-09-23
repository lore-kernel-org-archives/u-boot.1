Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFE8C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0516141313;
	Wed, 23 Sep 2026 21:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6HDkyz13_S_l; Wed, 23 Sep 2026 21:30:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5BDDA412FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790199047;
	b=oIWDJ3AyPWgx4QLnmvBFDT+Zke4Kh1S+sMpnc2cG+t6cbd1ItK7PAkaWIm5RhbsqN9+L
	 OxHt8BQS5OVvu/I6UBH6GDw2KB6NzzQaSfjuKK1DqO0VeqvZzhDY4cjExrk+3KeJMduLw
	 dxEck3lFZYeBB9KQTKX//ZKW3SC6wWkT+BbY4Y4K1t8ZtbtO78xg8PBlAuq66o5IGZPO9
	 IRBhaM/Q7QxVLwZRsY5kyEuyHfE2Iagdb+OqU/Jpxh0a50drdtAc9YBUP494C2wB/qhgJ
	 jEwN1UrqKp3bjrs94cDycY0Lvp3r04uh2K0lxy2veZgWBgwCJNgnp2tjNUu+vMBXCLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790199047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1v2YFG6QOU5OKAOxFJhIL9HS/usrtJoJCx6atPN2uOY=;
	b=GRCccy7FSPL59mQcJr0xSSmmSuKH6lSHl7HDybNnnjd2T+Fthv5P6ir/94Zfls+Kltd0
	 JJpdeP/6MFF8Wo1ZfRxna2Dn11cC3KIoefHmz/AS3MjVswlNZ0GJPb6pAkOJFOhoDuiT1
	 8MtHGMllJErFTkX7l6vr+rsKfd13ZQB+YC/XBxt6lPiNw+uFMUio+SSsjui1QBFE5WA0T
	 jPulaNpbE7Pg1fNHMlEi6ztBl8wxcwDpCKmk7ZFD11cazdYKWzju3Bpfgy6hZ+jizR5OI
	 Uthxxkpgv7ar5ZdNEeIYa4LdjXfs4Bev03qCta00d4BUS22h7qFhR2TB7y+nEakPzlw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790199047;
	bh=1v2YFG6QOU5OKAOxFJhIL9HS/usrtJoJCx6atPN2uOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G8A9iCBE4CTXHGwkdbZRs562lBc5f5PEEskbfeAA8oSH6wra/6LaewqRqJzby3pRY
	 Mf7S1umU5ZEwptSglp0lKBzvyt2OlSimVJE2SuR8NrdDdWmakVJJC/CRBf3mCEk8h2
	 jh93TGYoSK0QRIljFFPDKiGupEA2zw6RO1O3aLkHGeOY6lS+EU1EnwIl9+9NvH0h6U
	 cSPGkiQvoiVTPseL0K/nPEpEbxhi5Ii2lSTXZE2aTmNRJVCzct13T1JyuULF+QOVil
	 4dwGEs5ipzda62DmB/LI6nGu5clkMWBLh0iz//I1iP3tJbQOV0z4cWPNYA9G7Sixfv
	 /R95EFulAuEiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BDDA412FC;
	Wed, 23 Sep 2026 21:30:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6569428C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56FA960B85
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id duaLcaQDWkGL for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:30:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 16A5D60B3F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199044;
 b=JeHVfcCWPCygmzAojWghMYTGaPO4BshcBZ0JuNpf9/HoGu8iwfl4J/NWdaq/41gPLVTN
 zJ7bRNwx6KIjYgeHeh7HI5v2BaTiq3QbN9TuKNlURcTJsvb7H9oMfsdMIOevSdY0UyqtU
 Qw5/Y9fYZ/Hl6Yh+hl7fcy9CmifOH1RSHwxLlp0PNW7jptPBB/+QZyYY1Ed8XUZy+T0Jv
 jJxCU8OrhzejCLkYIVgic29MuuDwDRUSaACHCCx8VbW0Srx7Yc8oNuTDh+deuOhQaZ+N0
 2MnsxYB2km5N3MHxj6BAEvQFfXStYec12TGjFueE/t+Wur1mLt36rrmV6/vOuZ81GHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199044;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=1v2YFG6QOU5OKAOxFJhIL9HS/usrtJoJCx6atPN2uOY=;
 b=lslNvaDxpU/zNgyQmzhlkfuMW6jjpg2rhvU4hX02v7+pPIA8e/02tNWEsnSOVD3P24ZK
 BMsptTp0kZUIjvp0NOfFG1w7os1W0U4VBEQ0ozlYymmAZfjiyv++QFk2ErMYO4SjodoqM
 uCwC5+nYNtP6XZ2EZuji5/xwn6Vwg+wWOqQ91cNVhOyQt0hgqdfDxKwGd/j4NVF52Q4rh
 Y0hkjaVWjzRXuxIfLe3R3R3Dty941FpBNEL2/k1w5BV4d6JMW+1ODlL2feLmDcjrkcc4F
 wf4h8Nx7gaXtYxsRkkme8IGR0h6EAwaUAf/1mACtCLevE5gLDoYOgQwvmpidAaeNutg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bAiotgs9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::e;
 helo=mail-pz2-x0e.google.com; envelope-from=visitorckw@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bAiotgs9
Received: from mail-pz2-x0e.google.com (mail-pz2-x0e.google.com
 [IPv6:2607:f8b0:4864:3b::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16A5D60B3F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:43 +0000 (UTC)
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea34f01so873792a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199043; x=1790803843;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1v2YFG6QOU5OKAOxFJhIL9HS/usrtJoJCx6atPN2uOY=;
 b=bAiotgs9KuxTJ3YkEUkrrC+iZo0w/RL6KBAqmcuaPss2FAiO6ZoX/5ZkVFQALoYNE/
 IvCZ4zhAygH2/Y8LLUk6qxCieSolKr9Ug8+MCMEJus+ajHeEESyHrCNBI1pRNx6asF7P
 ocP5zkcHMlVrtQ3i98lYDgssfh9++fZgTug5S78y2VCUjXMzow6hARVRIJ1CqOCh+amY
 bQiOu3m4WHpZK4+eLud1KBzJraomyhB5P7b3qiIHah1mxltV0Iv+sX7vkJZkDyFP7dkK
 OZT7p8HuGu4jxsA2JuMV71SleOV5gK77a+5F8oodjqQxJ7Tz6/bKmdtuQspjpZTyq96T
 mE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199043; x=1790803843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1v2YFG6QOU5OKAOxFJhIL9HS/usrtJoJCx6atPN2uOY=;
 b=G0hWUNp3cEJkGEdpyygKqWiVwCte7mkcFmLDhBeVHwrLFBj5xlDYHMBPQ1jBcg9/V5
 1zCLse4zkjPFIU4op0jO/X3lIg10DysrxUeGeL9EDGMWr3WXkWEM8zpq3FB1bIQxOC+S
 cx/AaCynLzEkqDmtJwLXhlQZKj6w85U7PhaG2vuDsPOH+AcXTLxyquVIr4LbH5gA9HzB
 BBkJYgVlfNPmbCeQRfCjYlIVcDReYnbJyQFVr2EdelENLoXydH2q4VMNiW2TWw+RDNu+
 VPpGKZ2dGYdRlbLG/ZW6UIow39PxXYvahcapZivKjiN51Sny+sOMG6HiuBS9GkaPc406
 kmXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnOhkdm44UvBuUqHm/+sVP5ah7abl+a2VuHn74yUyJ8QRMZYOn6L2nFIa16my0+rhbdBRPoGc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n0E0d8E2W3kQiAey7zuaWU0KoyEsntbbsNP02T4nPyk6jMn0f6
 l1SiB/WI1UWhWHhZvyidmzogdhR4lsYLpIKQRZv+3RA3wWOg1SG7AIkn
X-Gm-Gg: AYBFou3iKhGRB3lT76AQKTJYMloDpYtiXA1QVMD50jVKkpztf5i73j6aCfUO93uZB4Z
 +Jxj+mANxecx93HBjrBlTxl1UpnkBCLo64yQj251iTaJPSBvKwDqgnmuIcrGdY48m8rELCQrOp3
 Wo7PxbPjDqRVxRQRO4i8+dIY4qmxYmR/Nlti7DNCZj9tgfHzoeJJYtvpPldPIMze5Xi6TOsKGME
 Z4PioqMr0bm2gf+EBjbEOOYaylS4siq8+4P9ALBluYuBaXd6sKnBpD2xcHJLTgtKP/++fExZFYW
 hPbSfnTK74EEZgVnn+jS0kjdwYXbpEitScvfj2svQbcMpxyhD9sOEpB4myg1DWxl1VP/mzmaI4e
 IonkXekcoqBIqQBAT220TKr9Js3iYdMsOZCvCsSTpwu0SAwYDIJ9TQTa4MXmDI+WdtkVkNTxlYe
 Yz5PAcLqw6FR9Y/YClJYLyf4tc4ZGQ4JDRC/H1TXAxh/AVyreoBfMX6C4ab4FxBwvjiBoqO8d5q
 PcAgxk84CPCDTWvPm20OBhp7ixaUB92tnsk5/FN/pDdIUB2y7WOzebAlduLD+dr+LLcgdMUpMDv
X-Received: by 2002:a17:90b:3dc6:b0:39e:24ab:9fb0 with SMTP id
 98e67ed59e1d1-3a098d43b17mr332316a91.6.1790199042787; 
 Wed, 23 Sep 2026 14:30:42 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0973c4fb4sm909513a91.17.2026.09.23.14.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:30:42 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 1/6] net: 9p: Add 9P2000.L protocol support
Date: Wed, 23 Sep 2026 21:29:57 +0000
Message-ID: <20260923213002.1070404-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923213002.1070404-1-visitorckw@gmail.com>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Introduce the core 9P network protocol client implementation.

9P is a network filesystem protocol originally developed for the
Plan 9 operating system. Add the baseline 9P2000.L protocol handling,
including message serialization, DM UCLASS_9P transport management,
and basic transport operations.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Check received byte count against reply header size in p9_request().
---
 include/9p.h           | 203 ++++++++++++++++++++
 include/dm/uclass-id.h |   1 +
 net/9p/Kconfig         |   5 +
 net/9p/Makefile        |   5 +
 net/9p/client.c        | 415 +++++++++++++++++++++++++++++++++++++++++
 net/Kconfig            |   2 +
 net/Makefile           |   1 +
 7 files changed, 632 insertions(+)
 create mode 100644 include/9p.h
 create mode 100644 net/9p/Kconfig
 create mode 100644 net/9p/Makefile
 create mode 100644 net/9p/client.c

diff --git a/include/9p.h b/include/9p.h
new file mode 100644
index 00000000000..e755c78be0f
--- /dev/null
+++ b/include/9p.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef __9P_H__
+#define __9P_H__
+
+#include <linux/types.h>
+
+#define P9_MSIZE            65536
+#define P9_NOFID            (~0U)
+#define P9_NOTAG            0xFFFF
+#define P9_REQ_TAG          1
+
+#define P9_RLERROR          7
+#define P9_TLOPEN           12
+#define P9_RLOPEN           13
+#define P9_TGETATTR         24
+#define P9_RGETATTR         25
+#define P9_TREADDIR         40
+#define P9_RREADDIR         41
+#define P9_TVERSION         100
+#define P9_RVERSION         101
+#define P9_TATTACH          104
+#define P9_RATTACH          105
+#define P9_TWALK            110
+#define P9_RWALK            111
+#define P9_TREAD            116
+#define P9_RREAD            117
+#define P9_TCLUNK           120
+#define P9_RCLUNK           121
+
+#define P9_O_RDONLY         00000000
+#define P9_GETATTR_SIZE     0x00000010ULL
+#define P9_GETATTR_SIZE_OFFSET  41
+#define P9_DT_DIR           4
+
+/**
+ * struct p9_dirent_hdr - 9P2000.L directory entry wire header
+ * @qid: File QID (13 bytes)
+ * @offset: Offset cookie for next readdir (8 bytes)
+ * @type: Directory entry type (1 byte)
+ * @name_len: Length of filename (2 bytes)
+ */
+struct p9_dirent_hdr {
+	u8  qid[13];
+	u64 offset;
+	u8  type;
+	u16 name_len;
+} __packed;
+
+/**
+ * struct p9_header - 9P message header
+ * @size: Total message size in bytes, including this header
+ * @id: Message type / opcode (e.g. P9_TVERSION)
+ * @tag: Message tag to match request and reply
+ */
+struct p9_header {
+	u32 size;
+	u8  id;
+	u16 tag;
+} __packed;
+
+struct udevice;
+
+/**
+ * struct dm_p9_ops - Driver model operations for 9P transports
+ * @request: Execute a transmit/receive transaction
+ * @get_mount_tag: (optional) Retrieve the mount tag string
+ */
+struct dm_p9_ops {
+	int (*request)(struct udevice *dev, void *tx, int tx_len, void *rx, int rx_len);
+	const char *(*get_mount_tag)(struct udevice *dev);
+};
+
+/**
+ * struct p9_client - 9P client state
+ * @dev: Underlying transport udevice
+ * @tx: Transmit buffer
+ * @rx: Receive buffer
+ * @next_fid: Next FID to allocate
+ * @msize: Negotiated maximum message size
+ */
+struct p9_client {
+	struct udevice *dev;
+	u8 *tx;
+	u8 *rx;
+	u32 next_fid;
+	u32 msize;
+};
+
+/**
+ * p9_get_device() - Find a 9P transport device by mount tag or default
+ * @tag: Mount tag to match, or NULL/"-" for default/first device
+ * @devp: Output pointer to the found udevice
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_get_device(const char *tag, struct udevice **devp);
+
+/**
+ * p9_get_client() - Get 9P client state from a transport udevice
+ * @dev: 9P transport udevice
+ *
+ * Return: Pointer to struct p9_client
+ */
+struct p9_client *p9_get_client(struct udevice *dev);
+
+/**
+ * p9_client_alloc_fid() - Allocate a unique FID
+ * @c: Pointer to 9P client
+ *
+ * Return: Newly allocated FID
+ */
+u32 p9_client_alloc_fid(struct p9_client *c);
+
+/**
+ * p9_client_version() - Negotiate 9P2000.L protocol version and msize
+ * @c: Pointer to 9P client
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_version(struct p9_client *c);
+
+/**
+ * p9_client_attach() - Attach to the root directory
+ * @c: Pointer to 9P client
+ * @fid: FID to assign to root
+ * @uname: User name
+ * @aname: File tree / mount point name
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_attach(struct p9_client *c, u32 fid, const char *uname, const char *aname);
+
+/**
+ * p9_client_walk() - Walk a path and associate with a new FID
+ * @c: Pointer to 9P client
+ * @base_fid: Starting directory FID
+ * @new_fid: New FID to associate with target path
+ * @path: Relative path to walk
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_walk(struct p9_client *c, u32 base_fid, u32 new_fid, const char *path);
+
+/**
+ * p9_client_lopen() - Open a file (9P2000.L)
+ * @c: Pointer to 9P client
+ * @fid: FID of file to open
+ * @flags: Open flags (e.g. P9_O_RDONLY)
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_lopen(struct p9_client *c, u32 fid, u32 flags);
+
+/**
+ * p9_client_clunk() - Forget / close a FID
+ * @c: Pointer to 9P client
+ * @fid: FID to clunk
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_clunk(struct p9_client *c, u32 fid);
+
+/**
+ * p9_client_stat() - Get file size attribute via Tgetattr
+ * @c: Pointer to 9P client
+ * @fid: FID of file
+ * @size: Output pointer for file size
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_stat(struct p9_client *c, u32 fid, loff_t *size);
+
+/**
+ * p9_client_read() - Read data from a file
+ * @c: Pointer to 9P client
+ * @fid: FID of file
+ * @offset: Byte offset in file to read from
+ * @count: Maximum number of bytes to read
+ * @buf: Destination buffer
+ * @actread: Output pointer for actual bytes read
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_read(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread);
+
+/**
+ * p9_client_readdir() - Read directory entries
+ * @c: Pointer to 9P client
+ * @fid: FID of directory
+ * @offset: Directory offset / cookie
+ * @count: Maximum bytes of dirents to read
+ * @buf: Destination buffer
+ * @actread: Output pointer for actual bytes returned
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int p9_client_readdir(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread);
+
+#endif /* __9P_H__ */
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index fe0aae2720c..10680dc860c 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -108,6 +108,7 @@ enum uclass_id {
 	UCLASS_PANEL,		/* Display panel, such as an LCD */
 	UCLASS_PANEL_BACKLIGHT,	/* Backlight controller for panel */
 	UCLASS_PARTITION,	/* Logical disk partition device */
+	UCLASS_9P,		/* 9P protocol transport */
 	UCLASS_PCH,		/* x86 platform controller hub */
 	UCLASS_PCI,		/* PCI bus */
 	UCLASS_PCI_EP,		/* PCI endpoint device */
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
new file mode 100644
index 00000000000..5fda98cb23d
--- /dev/null
+++ b/net/9p/Kconfig
@@ -0,0 +1,5 @@
+config NET_9P
+	bool "9P2000.L protocol support"
+	help
+	  This enables support for the 9P network protocol (9P2000.L).
+	  It implements the core 9P2000.L client and protocol handling.
diff --git a/net/9p/Makefile b/net/9p/Makefile
new file mode 100644
index 00000000000..e9220b0826e
--- /dev/null
+++ b/net/9p/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+obj-y += client.o
diff --git a/net/9p/client.c b/net/9p/client.c
new file mode 100644
index 00000000000..903dfe56647
--- /dev/null
+++ b/net/9p/client.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#define LOG_CATEGORY LOGC_NET
+
+#include <9p.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/cache.h>
+#include <asm/unaligned.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+static int p9_post_probe(struct udevice *dev)
+{
+	struct p9_client *c = dev_get_uclass_priv(dev);
+
+	c->dev = dev;
+	return 0;
+}
+
+UCLASS_DRIVER(p9) = {
+	.name = "p9",
+	.id = UCLASS_9P,
+	.per_device_auto = sizeof(struct p9_client),
+	.post_probe = p9_post_probe,
+};
+
+struct p9_client *p9_get_client(struct udevice *dev)
+{
+	return dev_get_uclass_priv(dev);
+}
+
+int p9_get_device(const char *tag, struct udevice **devp)
+{
+	struct udevice *dev;
+	char *endp;
+	ulong num;
+	int ret;
+
+	if (!tag || !tag[0] || !strcmp(tag, "-"))
+		return uclass_first_device_err(UCLASS_9P, devp);
+
+	num = simple_strtoul(tag, &endp, 10);
+	if (*endp == '\0') {
+		ret = uclass_get_device(UCLASS_9P, num, devp);
+		if (!ret)
+			return 0;
+	}
+
+	uclass_foreach_dev_probe(UCLASS_9P, dev) {
+		const struct dm_p9_ops *ops = device_get_ops(dev);
+
+		if (ops && ops->get_mount_tag) {
+			const char *mtag = ops->get_mount_tag(dev);
+
+			if (mtag && !strcmp(mtag, tag)) {
+				*devp = dev;
+				return 0;
+			}
+		}
+
+		if (!strcmp(dev->name, tag)) {
+			*devp = dev;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+u32 p9_client_alloc_fid(struct p9_client *c)
+{
+	if (c->next_fid >= 0xFFFF0000 || c->next_fid == 0)
+		c->next_fid = 2; /* fid 1 is reserved for root */
+	return c->next_fid++;
+}
+
+static void p9_put_u16(u8 **p, u16 v)
+{
+	put_unaligned_le16(v, *p);
+	*p += 2;
+}
+
+static void p9_put_u32(u8 **p, u32 v)
+{
+	put_unaligned_le32(v, *p);
+	*p += 4;
+}
+
+static void p9_put_u64(u8 **p, u64 v)
+{
+	put_unaligned_le64(v, *p);
+	*p += 8;
+}
+
+static void p9_put_str(u8 **p, const char *s)
+{
+	u16 len = strlen(s);
+
+	put_unaligned_le16(len, *p);
+	*p += 2;
+	memcpy(*p, s, len);
+	*p += len;
+}
+
+static int p9_request(struct p9_client *c, void *tx, int tx_len, void *rx, int rx_len)
+{
+	const struct dm_p9_ops *ops = device_get_ops(c->dev);
+	int ret;
+
+	if (!ops || !ops->request)
+		return -ENOSYS;
+
+	ret = ops->request(c->dev, tx, tx_len, rx, rx_len);
+	if (ret < 0)
+		return ret;
+	if (ret < get_unaligned_le32(rx))
+		return -EIO;
+
+	return 0;
+}
+
+static int p9_check_error(struct p9_client *c, int expected_id, const char *step)
+{
+	struct p9_header *rx_hdr = (struct p9_header *)c->rx;
+	u32 ecode;
+
+	if (rx_hdr->id == P9_RLERROR) {
+		ecode = get_unaligned_le32(c->rx + sizeof(struct p9_header));
+		log_err("9P Error: %s failed (ecode=%u)\n", step, ecode);
+		return -ecode;
+	} else if (rx_hdr->id != expected_id) {
+		log_err("9P Error: %s got id %d (expected %d)\n", step, rx_hdr->id, expected_id);
+		return -EIO;
+	}
+	return 0;
+}
+
+int p9_client_version(struct p9_client *c)
+{
+	struct p9_header *hdr;
+	u8 *ptr;
+	u32 server_msize;
+	u16 vlen;
+	int ret;
+
+	if (!c->tx) {
+		c->tx = memalign(ARCH_DMA_MINALIGN, P9_MSIZE);
+		if (!c->tx)
+			return -ENOMEM;
+	}
+	if (!c->rx) {
+		c->rx = memalign(ARCH_DMA_MINALIGN, P9_MSIZE);
+		if (!c->rx) {
+			free(c->tx);
+			c->tx = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	hdr = (struct p9_header *)c->tx;
+	ptr = c->tx + sizeof(*hdr);
+	p9_put_u32(&ptr, P9_MSIZE);
+	p9_put_str(&ptr, "9P2000.L");
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TVERSION;
+	hdr->tag = P9_NOTAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RVERSION, "Tversion");
+	if (ret < 0)
+		return ret;
+
+	ptr = c->rx + sizeof(*hdr);
+	server_msize = get_unaligned_le32(ptr);
+	ptr += 4;
+	vlen = get_unaligned_le16(ptr);
+	ptr += 2;
+
+	if (vlen != strlen("9P2000.L") || memcmp(ptr, "9P2000.L", vlen) != 0) {
+		log_err("9P: Unsupported server version: %.*s\n", vlen, ptr);
+		return -EPROTONOSUPPORT;
+	}
+
+	c->msize = min((u32)P9_MSIZE, server_msize);
+	return 0;
+}
+
+int p9_client_attach(struct p9_client *c, u32 fid, const char *uname, const char *aname)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u32(&ptr, P9_NOFID);
+	p9_put_str(&ptr, uname);
+	p9_put_str(&ptr, aname);
+	p9_put_u32(&ptr, 0);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TATTACH;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	return p9_check_error(c, P9_RATTACH, "Tattach");
+}
+
+int p9_client_walk(struct p9_client *c, u32 base_fid, u32 new_fid, const char *path)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	char path_buf[128];
+	char *wnames[16];
+	char *token, *p = path_buf;
+	int nwname = 0, i, ret;
+	u16 nwqid;
+
+	if (strlcpy(path_buf, path, sizeof(path_buf)) >= sizeof(path_buf)) {
+		log_err("9P: Path too long\n");
+		return -ENAMETOOLONG;
+	}
+
+	while ((token = strsep(&p, "/")) != NULL) {
+		if (*token == '\0' || strcmp(token, ".") == 0)
+			continue;
+		if (nwname >= 16) {
+			log_err("9P: Path too deep (max 16 levels)\n");
+			return -EINVAL;
+		}
+		wnames[nwname++] = token;
+	}
+
+	p9_put_u32(&ptr, base_fid);
+	p9_put_u32(&ptr, new_fid);
+	p9_put_u16(&ptr, nwname);
+	for (i = 0; i < nwname; i++)
+		p9_put_str(&ptr, wnames[i]);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TWALK;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RWALK, "Twalk");
+	if (ret < 0)
+		return ret;
+
+	ptr = c->rx + sizeof(*hdr);
+	nwqid = get_unaligned_le16(ptr);
+	if (nwqid != nwname)
+		return -ENOENT;
+
+	return 0;
+}
+
+int p9_client_lopen(struct p9_client *c, u32 fid, u32 flags)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u32(&ptr, flags);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TLOPEN;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	return p9_check_error(c, P9_RLOPEN, "Tlopen");
+}
+
+int p9_client_clunk(struct p9_client *c, u32 fid)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+
+	p9_put_u32(&ptr, fid);
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TCLUNK;
+	hdr->tag = P9_REQ_TAG;
+
+	return p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+}
+
+int p9_client_stat(struct p9_client *c, u32 fid, loff_t *size)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	u64 valid;
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u64(&ptr, P9_GETATTR_SIZE);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TGETATTR;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RGETATTR, "Tgetattr");
+	if (ret == 0) {
+		ptr = c->rx + sizeof(*hdr);
+		valid = get_unaligned_le64(ptr);
+		ptr += sizeof(valid);
+		ptr += P9_GETATTR_SIZE_OFFSET;
+		if (valid & P9_GETATTR_SIZE) {
+			*size = get_unaligned_le64(ptr);
+			return 0;
+		}
+	}
+	return ret ? ret : -EIO;
+}
+
+int p9_client_read(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	u32 max_read = (c->msize ? c->msize : P9_MSIZE) - 24;
+	u32 read_len = (count == 0 || count > max_read) ? max_read : count;
+	u32 count_rx;
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u64(&ptr, offset);
+	p9_put_u32(&ptr, read_len);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TREAD;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RREAD, "Tread");
+	if (ret < 0)
+		return ret;
+
+	ptr = c->rx + sizeof(*hdr);
+	count_rx = get_unaligned_le32(ptr);
+	ptr += 4;
+	if (count_rx > read_len) {
+		log_err("9P: Tread returned count %u > requested %u\n", count_rx, read_len);
+		return -EIO;
+	}
+
+	*actread = count_rx;
+	memcpy(buf, ptr, count_rx);
+	return 0;
+}
+
+int p9_client_readdir(struct p9_client *c, u32 fid, u64 offset, u32 count, void *buf, u32 *actread)
+{
+	struct p9_header *hdr = (struct p9_header *)c->tx;
+	u8 *ptr = c->tx + sizeof(*hdr);
+	u32 max_read = (c->msize ? c->msize : P9_MSIZE) - 24;
+	u32 read_len = (count == 0 || count > max_read) ? max_read : count;
+	u32 count_rx;
+	int ret;
+
+	p9_put_u32(&ptr, fid);
+	p9_put_u64(&ptr, offset);
+	p9_put_u32(&ptr, read_len);
+
+	hdr->size = ptr - c->tx;
+	hdr->id = P9_TREADDIR;
+	hdr->tag = P9_REQ_TAG;
+
+	ret = p9_request(c, c->tx, hdr->size, c->rx, c->msize ? c->msize : P9_MSIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = p9_check_error(c, P9_RREADDIR, "Treaddir");
+	if (ret < 0)
+		return ret;
+
+	ptr = c->rx + sizeof(*hdr);
+	count_rx = get_unaligned_le32(ptr);
+	ptr += 4;
+	if (count_rx > read_len) {
+		log_err("9P: Treaddir returned count %u > requested %u\n", count_rx, read_len);
+		return -EIO;
+	}
+
+	*actread = count_rx;
+	memcpy(buf, ptr, count_rx);
+	return 0;
+}
diff --git a/net/Kconfig b/net/Kconfig
index 386376ce884..00448ab4cc6 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -236,6 +236,8 @@ endif   # if NET_LEGACY
 
 source "net/lwip/Kconfig"
 
+source "net/9p/Kconfig"
+
 config BOOTDEV_ETH
 	bool "Enable bootdev for ethernet"
 	depends on BOOTSTD
diff --git a/net/Makefile b/net/Makefile
index ceac6de6377..7745607248b 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -49,3 +49,4 @@ obj-y += net-common.o
 endif
 
 obj-$(CONFIG_NET_LWIP) += lwip/
+obj-$(CONFIG_NET_9P) += 9p/
-- 
2.56.0.rc1.310.g51773c2048-goog

