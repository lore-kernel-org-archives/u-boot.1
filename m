Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BA4C98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3548560E35;
	Fri, 25 Sep 2026 14:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id suI-AwAN_f3G; Fri, 25 Sep 2026 14:27:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0EFA260E22
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346442;
	b=AF611qFoWIi8m6+GILHUd6pX/HAzX+2OhMQSZ6SVo5cyFqVJ8G/E5tEWcQIQ/5vpgGFw
	 XX9j7AOt9EishfNK4dcJXJeN3NoxEQBw1Ekp9FTpPaSBEyG9kVqn7WGWYxkxRe5zfpQnY
	 +LW0G43RT6WAo7aEK66doh0tNPXumL4Xeq2uzDwq/P9gHhNXR+y/q9+P+pA/pIAZsd2qd
	 /5MqSjokhxUqTGlM1G5aGBFFwdIlaHJt+k7nXnD7WFghZZX1I6ZsGi2H8L3fhwlOHZPKr
	 ozzyhe6+BEtN3VHJ6QE5afs9ATIMTfHdEzOBe8Pbe3U8CdyeMxeGqEk1eXzZqauIp+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346442;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7YWpglpFxinAl+SmfTnh2rT4RiyYHNJDo6A8MxlKH80=;
	b=cnSfoadSZYImaut5ibmi+lPYykpWlE5VjGcGKfHUtQDORv4cF5y2riLdqrwSoE51Xet3
	 9YjBYO44NSDYMGDEbepT21Utl90wRLVyTJ9hrb/JZlFXvrdD5b+gFyG2yhuREuyAcXLX4
	 LgWrheRwZ8La1Te0Mg8VNvWbi6hgVA7NgJgPbdtTU1BrAnVKwE1j4F2Qi3yizUCpHA9Cr
	 pi7B1idpB3jYh7wRNoRV103i5ZbNf+Kxgzuz+3qUbns+qk1MjUt9n4VI6vL1+2o+o+ENC
	 iYpcOxCHKFzGcc0P5jFttIMobDBZ2h/qXTY7sISnr6Lf6xhdKLUIrFXgJvpkfU8ImYA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346442;
	bh=7YWpglpFxinAl+SmfTnh2rT4RiyYHNJDo6A8MxlKH80=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xkwmtps7CCpdp9i+4ihV4eg7Pnku9pqsgxmekEICnui/32HkPZ+1vXJKVxK5Kl7G5
	 hKEjysMCFlVyjuH3CqnJ9a2P/jE/iRv9h8DCij8QvLiXlmmTwQxb2Wgrsg2FFJnR1V
	 tjJzXqSdz9ZO7Ldt1NuYW8a5whGTQcT96FWkQKydpfnSUi1kOBI5qNqaEUbm0zRsyB
	 v/L4JmDd4n7ED5rx6PMPmmBLZB9gJTxVkdsM3imm4FtxuHuEBL31ZM52lWRVGv0dvf
	 /dARXb9GS4YOHYz/sEWT1s5j32qcH6ump8ZdnIv3zXBeM09bbxJSa2232lNANTa+4p
	 +gPI+mHk/JLTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EFA260E22;
	Fri, 25 Sep 2026 14:27:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F09935A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70E6840AE9
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eVDOGv7mxTWF for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 72EE340AE5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341108;
 b=LyjtG4a3I1xCya289EF6uGMPz6z6kMonk1BVfyccX1DBSGAgV/jioTrfCVEQIgSRw2s/
 9KTCkobgovS59XpxH5yXMPWPh9WlF9HLrrIIboxk0fSY0yZRAkF/tdAYWznD33NHJoomL
 Sy825ccVcBbQ+tBpyFuH/Q4aQvbcsiXzdUD+Bk/q8udCk/dIK9YmJnjT0Wg1PmVWI9RQm
 gJzp5BYHGqtBkZLBbV6l3OJMhPRfpg0oOLfaoOiAV3EgM1kyiSTriEQrFKPmK+D1NYPLr
 Fosiu+4DnzYLvy10wn/KrxDP5pLnDkmcPYD/CcsDAQG2mAj5JExUbf8zMX3oLhrz7/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341108;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=7YWpglpFxinAl+SmfTnh2rT4RiyYHNJDo6A8MxlKH80=;
 b=PSr42p7QiTFlUZ59BwztYkMLXncIlU91OuP1iEU+fQ/gISfEbF1majnyxlmjtLJp1mat
 JPA5RKm682iG1ZX3pADZnpp57zEULcDq3Ta3Jpu/gIrXfKX7k59LV4NsSPhIYvl02O4xW
 /VSZKeuR5KZmKxbWWaD2NO7NcC0S+pcwe4dLKPyRPnm303eqCXDpdhhVE9tEP97DPjJ2c
 guKtdC5pBFBWTlI8jVIDe7YI8ud5Ca42PFBaIeA1iLYtFJiGCn+dPFPVAQxqNYD/gXoLN
 n4X9iLHdVQ4TohWjc3/II0xofUe1XeDaMjdhOSNWZYkbuBmDVfBpRRwbhY43igUivKQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=fTLZZpOM; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=fTLZZpOM
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72EE340AE5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PA48RR609035; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7YWpglpFxin
 Al+SmfTnh2rT4RiyYHNJDo6A8MxlKH80=; b=fTLZZpOMaMQtPRm+q7w4g5/8l3U
 QrJE4eatxPtV9FkGuEQY+y+RjuDOeYhlnnG9kKD/S2BkwsnHs8RlVN/7m0CJ2ZGP
 kMgO1LOTRpMIlg8oUe/3v4znj6+z7av0jBT1wrGBb76NldfD5o2Ty+4NBSq9RZkH
 N4X2zeNiPhhI7UetjusTf2xtdjKCjeTlK3sgTx/3B09EJJWTifCQPn8AzSk+OzkB
 MSL8nbkOntlWIyQEP9YN1dAMXn+4HI1UbemMcDy2gtNVqS6PcBXdZ5KDqDtky5lU
 BWV6OzHgBJRBrOvzBNPRB4jy67M4Kl+PX0WF8TfyjRBGzO4zTU8D4pE0J8Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnrg8b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwEOx552075; Fri, 25 Sep 2026 12:58:14 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 68PCwDcw552064
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:13 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id 9925B618; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 03/12] board: qualcomm: shikra: add SPL board support
Date: Fri, 25 Sep 2026 05:58:00 -0700
Message-Id: <20260925125809.1360030-4-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: ynM3ePg6jKjaaD4-v0SAsjrTb34wI4d0
X-Proofpoint-GUID: ynM3ePg6jKjaaD4-v0SAsjrTb34wI4d0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfXz9ztTxKi4j0f
 zR5E/MRbblMWGOh4wExFtBTFwLfxpt4DD1hWg4gucIKLF2bN9kT/STYkvEzFkbhM0mzlbTK+gJo
 9mTXOaMSlGyyOoQVY5yXdXKuGiQS9as=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX5joMc/0Vxv5c
 CkJ4dYCXulOeFkEBPMCpc+zmiP+6m/SE5tRLI17TQ9DDf0E2Z9ouUI0D+a7kuYR1N8HQeKt83Xy
 q7UMeJ0rQMkPeY+0IfUOgv02Fguq66R131AnBYW5Mrgt5Mxj/Vnt3nfvIZiMyE0PkTm3KQ23EMW
 k3Z+fsv2RF0gCFZf6j3LH1ztLahbUjA61ISKLGX6RX1rM/Ibm67jBCq5OaXTKFmkt93ckrDTqMF
 AeYDIfk2do2LQ+pjgdLf/3JFFTUpFLRp3xeE4ij5g1CmQd3vbyUqVHqVVveTHy6NkKrZ/O+u8k3
 TZeSY87xXKXr0RbJYIYygsVikw3fPvTwbOhxtQiNxCQO2pqKErgF9u+wW1gzklLxhTZlVO4NzlY
 KfMoGXWnXCzsa74W3olUBUJAckh6s/jS+em1pF2pfQuHscHVaP/o7vqE5r3iIohR+z/C6U6Hfed
 7cSeFliST4aB6w1sfrg==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab66fe6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=U7ebsduSVgTrIjsT4N8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250051
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:47 +0000
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

From: Abhilash V <abhilash.v@oss.qualcomm.com>

Add the Shikra SPL board implementation, build rules, linker
wrapper, and board configuration header. Configure QCLIB
handoff data, early reset handling, and MMC boot-device and
partition selection.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  18 ++
 board/qualcomm/shikra/spl-shikra.c            | 202 ++++++++++++++++++
 include/configs/shikra.h                      |  11 +
 4 files changed, 234 insertions(+)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

diff --git a/board/qualcomm/shikra/Makefile b/board/qualcomm/shikra/Makefile
new file mode 100644
index 00000000000..eb3961a3ead
--- /dev/null
+++ b/board/qualcomm/shikra/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SPL) := spl-shikra.o
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
new file mode 100644
index 00000000000..b2922cd2c2c
--- /dev/null
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
new file mode 100644
index 00000000000..b967b0137b1
--- /dev/null
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <blk.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+#include <part.h>
+#include <spl.h>
+
+#define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
+#define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
+#define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
+
+#define SHIKRA_DDR_INFORMATION		"ddr_information"
+#define SHIKRA_DDR_TRAINING_DATA	"ddr_training_data"
+#define SHIKRA_DDR_SR_EXIT		"ddr_sr_exit"
+#define SHIKRA_PMIC_COCOS		"pmic_cocos"
+#define SHIKRA_PMIC_WAILUA		"pmic_wailua"
+#define SHIKRA_DCB_LP4			"dcb_lp4"
+#define SHIKRA_DCB_LP5			"dcb_lp5"
+#define SHIKRA_ECC			"ecc"
+
+#define SHIKRA_DDR_TRAINING_DATA_ADDR	0x0c368000
+#define SHIKRA_DDR_TRAINING_DATA_SIZE	0x8000
+#define SHIKRA_PMIC_COCOS_SIZE		0xbc00
+#define SHIKRA_PMIC_WAILUA_SIZE	0x6000
+#define SHIKRA_DCB_LP4_SIZE		0x4800
+#define SHIKRA_DCB_LP5_SIZE		0x4800
+#define SHIKRA_ECC_SIZE			0x400
+
+#define SHIKRA_SHRM2_SPROC_CTRL_ADDR			0x0c36000
+#define SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK	BIT(1)
+#define SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK	BIT(3)
+
+/* GCC_APCS_MISC contains the RPM reset control bit. */
+#define SHIKRA_GCC_APCS_MISC_ADDR			0x01491000
+#define SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK		BIT(0)
+
+#define SHIKRA_RPM_STAGING_ADDR			0x04690000
+#define SHIKRA_RPM_STAGING_SIZE			0x1363c
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"uefi_a"
+
+enum {
+	IPQ_SPL_BOOTCFG_DEV_MMC = 0x0,
+	IPQ_SPL_BOOTCFG_DEV_SD_EMMC	= 0x1,
+	IPQ_SPL_BOOTCFG_DEV_EDL		= 0x2,
+	IPQ_SPL_BOOTCFG_DEV_NAND	= 0x3,
+	IPQ_SPL_BOOTCFG_DEV_EMMC_SD		= 0x4,
+	IPQ_SPL_BOOTCFG_DEV_MAX
+};
+
+int qcom_spl_soc_qclib_override(struct interface_table *table,
+				const void *fit, int images_node)
+{
+	static const struct {
+		const char *name;
+		u32 size;
+	} fit_blobs[] = {
+		{ SHIKRA_PMIC_COCOS, SHIKRA_PMIC_COCOS_SIZE },
+		{ SHIKRA_PMIC_WAILUA, SHIKRA_PMIC_WAILUA_SIZE },
+		{ SHIKRA_DCB_LP4, SHIKRA_DCB_LP4_SIZE },
+		{ SHIKRA_DCB_LP5, SHIKRA_DCB_LP5_SIZE },
+		{ SHIKRA_ECC, SHIKRA_ECC_SIZE },
+	};
+	uint i;
+	int ret;
+
+	table->global_attributes |= QCLIB_GA_ENABLE_UART_LOGGING;
+	for (i = 0; i < ARRAY_SIZE(fit_blobs); i++) {
+		ret = qclib_add_iftbl_fit_blob(table, fit, images_node,
+					       fit_blobs[i].name, fit_blobs[i].size);
+		if (ret)
+			return ret;
+	}
+
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
+				    SHIKRA_DDR_TRAINING_DATA_ADDR,
+				    SHIKRA_DDR_TRAINING_DATA_SIZE);
+	if (ret)
+		return ret;
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_INFORMATION, 0, 0);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, SHIKRA_DDR_SR_EXIT, 0, 0);
+}
+
+void qcom_spl_soc_shrm_reset(void)
+{
+	writel(SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK |
+	       SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(0, (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+}
+
+int qcom_spl_soc_pre_qclib_routine(void)
+{
+	qcom_spl_soc_shrm_reset();
+
+	return 0;
+}
+
+void qcom_spl_soc_rpm_reset(void)
+{
+	clrbits_le32((void *)SHIKRA_GCC_APCS_MISC_ADDR,
+		     SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK);
+}
+
+int spl_check_board_image(struct spl_image_info *spl_image,
+			  const struct spl_boot_device *bootdev)
+{
+	qcom_spl_soc_rpm_reset();
+
+	return 0;
+}
+
+int qcom_spl_soc_post_qclib_routine(struct interface_table *table)
+{
+	struct interface_table_entry entry;
+	int ret;
+
+	/*
+	 * Clear the full memory region reserved for the RPM image before loading
+	 * the post-DDR FIT, including its zero-initialized data.
+	 */
+	memset((void *)SHIKRA_RPM_STAGING_ADDR, 0, SHIKRA_RPM_STAGING_SIZE);
+
+	ret = qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_SR_EXIT,
+					       &entry);
+	if (ret)
+		return ret;
+
+	qclib_set_ddr_sr_exit_address(entry.address);
+	return 0;
+}
+
+int spl_mmc_boot_partition(const u32 boot_device)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	int partition;
+
+	if (!IS_ENABLED(CONFIG_MMC))
+		return -ENOSYS;
+
+	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	if (!desc)
+		return -ENODEV;
+
+	partition = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION,
+					  &info);
+	if (partition < 0)
+		return -ENOENT;
+
+	return partition;
+}
+
+/**
+ * spl_boot_device() - Get the boot device.
+ *
+ * Return: U-Boot boot device identifier, or -EINVAL if the device is invalid.
+ */
+u32 spl_boot_device(void)
+{
+	u8 boot_device_cfg =
+	(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+	IPQ_SPL_BOOTCFG_DEV_SHFT;
+	u32 boot_device_smem;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		boot_device_smem = BOOT_DEVICE_MMC1;
+		printf("Selected boot device: MMC\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		boot_device_smem = BOOT_DEVICE_MMC2;
+		printf("Selected boot device: SD MMC\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_EDL:
+		boot_device_smem = BOOT_DEVICE_USB;
+		printf("Selected boot device: SPI-NAND\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_NAND:
+		boot_device_smem = BOOT_DEVICE_NAND;
+		printf("Selected boot device: SPI-NAND\n");
+		break;
+	default:
+		pr_err("Invalid boot device configured: %d\n",
+		       boot_device_cfg);
+		return -EINVAL;
+	}
+
+	return boot_device_smem;
+}
diff --git a/include/configs/shikra.h b/include/configs/shikra.h
new file mode 100644
index 00000000000..7d88dc0e670
--- /dev/null
+++ b/include/configs/shikra.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_SHIKRA_H
+#define __CONFIGS_SHIKRA_H
+
+#include <linux/sizes.h>
+
+#endif
-- 
2.34.1

