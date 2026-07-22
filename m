Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B14C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0FC480CBF;
	Wed, 22 Jul 2026 07:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktduzDOhXPBp; Wed, 22 Jul 2026 07:43:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F94280DB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706213;
	bh=0q8EJ8QXVFX2fJUz6p81w46E9/Vbcyb2AG+lKV2UuEk=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=q/pB4ez4Z7yD2inAYVtoA7tuMUeYjWOrou/Ms3ch8rTwxpnp7nc1O72m5nj7JePl9
	 GHGeziE+nBR1ISuisZxtruE9Lf7vPjW9n2T5Ed/5VWIj3rMp4H6KygJnN6NCWC+WF9
	 WREAz/XK2Dx4JZOyCkmJYFuD1ehEava4FFmAzXheCgfI3J2pql4j18zaNWeuLMsfxE
	 Y6EmM0r+eVh4Z2MEoOCZY2d7cDALtSO5zaWzcEt43VagQQOLUgxwZeDjT4bAni750g
	 PdDBTB7rNCHbz4NuXNXcyZMwvqas291p6qC8hLqMmG41t8Mbh1RADWISi4vTyRHWsN
	 glw2pez0EAOkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F94280DB3;
	Wed, 22 Jul 2026 07:43:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B3F39109F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5CFA60739
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gU46nlKMMa90 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:43:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B3BE860740
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3BE860740
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3BE860740
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:31 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M61uk5984493
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:31 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjr838dk5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccbb61893fso258351905ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706210; x=1785311010;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0q8EJ8QXVFX2fJUz6p81w46E9/Vbcyb2AG+lKV2UuEk=;
 b=qDlezQ7qf/73krKAfD3fthAAeu7UYm+SQO6RiiUGpwunPCwIbSfTu4Y9k/yl/sOFJC
 I/BAaB9t8vCH1D/TyxIMvSbbzkIrsj4HdrEGynu4bty3g5yev7xm/RDY8x0B5DAKjzXi
 rZfXdy02lSEa6p/MPAa0GcY7XXvtvdLGcJWY1s+vNrv4aytoli5Gvu6r9Czf9wXZ/3cL
 /eOBYUEoy9Z+j4dj8TEtR5KWWj+Fs7SbgF8aViPNmgPFm5tbxGjQgOlw/eBShukProa7
 qzJt06kn78aDAdDeIhjLJ5/MHEkDuQjLqncPIHjSY5bNLs5xqoK/8DoJpcncRhye3zle
 X3lg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/jUJev4OpvNaU1AgioxXzG1hn+4G7wdQOHVx27sM7WWc3MzF9M0/w2zhwahYMWOTDO9I11Pc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwZ3DTCjViiQ601EQav0ueoumvHD7piC7E+bIbIo8AtTt2SF6vb
 sbsFrmHz/rxI22+ty8XwwbZHNOJH3hTcvNdGZrvvPg7Vi05Q67t/q+ZajRgMO+ytej8DdL1BoWC
 A+MCs3ulYJlE+XVSw0sVl0VYMXde9RWUcDOoPyl8T7wZ5W+SUekH8BFQ94sqOBdp1qseHAQwdZp
 Frbdk=
X-Gm-Gg: AR+sD12uh+JDk03unEI9mueSF7cnH5t2gPIpVijb1MMaPlIaYZXH5rOPdKzBD3oowwg
 CgfcIDCv0y2iHDjRs5eGWhdxnYqHBgH6IQao6ugmDvn/TutpVe0QMKVziTZ5doS818oK8aAMQ79
 GjOt1STNphgP4Oo4umJRtPopammXP37saKc2kLp97u0r7woBMw10wbl+gkNsZ7qu+G85YBkznOX
 QxVLBa2dpDxBatG+yK/uy5ZV2hBgTFq3kUVEhTyZUD/ODU67o0EgvBylUMOX2T6tT3aUtfIJqxe
 wfcUU2L7M0CG9igThN3z1PxIGoQZeUimh5rBkbpsKHlasSPGvrY6W92sltCuaXy3SpL1PVqQGCa
 KdM0Xyn8G9sAjex7tgVSLpGURT3v7ZMUlmpgUDAXDVv0kdiOR2u1yUE95B4MULD9xgwTjsgDUYi
 bxBqtTywe/K5K/HRCR2+xNLs1oaS4aFQ==
X-Received: by 2002:a05:6a20:d507:b0:3bf:a1e5:ff62 with SMTP id
 adf61e73a8af0-3c3ad8b3986mr22766445637.47.1784706210293; 
 Wed, 22 Jul 2026 00:43:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:d507:b0:3bf:a1e5:ff62 with SMTP id
 adf61e73a8af0-3c3ad8b3986mr22766386637.47.1784706209723; 
 Wed, 22 Jul 2026 00:43:29 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:43:29 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:24 +0530
Subject: [PATCH v8 13/15] mach-snapdragon: spl: ipq5210: Add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-13-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: CaoL860rcmJGDPxHgd3AXmEZtO6CuIR_
X-Authority-Analysis: v=2.4 cv=VfrH+lp9 c=1 sm=1 tr=0 ts=6a6074a3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=szQR6NxcgnduxeX9TVQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: CaoL860rcmJGDPxHgd3AXmEZtO6CuIR_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX2WzHp8B1P/gC
 iHWbeGZWA1NKcGMysZGQX4p3iO8tS0NIOKThbDODTDsAws9Kzsz6SsKVpgnoc8bypgfU85urDLs
 NgvEpFzZKS/f4+pDV7xagT8qPTthmyWfVhDSYPHpvEvInX2pXAM7Fev1ynwQUD9UaKyyd8Jyn5o
 QYTGvU6KeDP8RKExwAgQy1ocAYM7KYGGsufrNt9Z/hVCoDG+kTY3rz07rtbFQX1BRapWOPA4Zdu
 gHR+ijECU42ZDbH0YlnekWUJzy7iFV/bkaKcPVaxTXpdAh86vpCtHRTenP40tVoEngDjieTy8QR
 jBe1ZGKym4lN/LHSADmSUtBb7puMUHzX/5Kmrnjtjxijmi46WvSgT57yT/ULBOkUB1wsp6dqvs/
 Our/Vnlj+S++LH9ZF+lohwe2zzU6ms4UIZkbYiR1wHiizBChn2bLhTmseQyAZ0se6HC+YatwUsf
 F1B6D7Lc+BrnMz3aM2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXwEk1U2v5bnGP
 TzAVYXE7sXhKVQt4uZbvlSzv0xcjXRwkLv82MoBFOQSxYvo41gSSzKLqFtIr62T8H2Wd2vG/NxZ
 P4f8N54/ZVOthQ/KP3f2z8qy2zOjYMg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0q8EJ8QXVFX2fJUz6p81w46E9/Vbcyb2AG+lKV2UuEk=; b=cBnygLzFD/ASzULG
 1Rd4pfoc+I7Oh+XTS93XuF1UF5pFMSM40ZAcbE1n1ButzHD6HUTFXWKyB1hZpxA9
 iuQpOBxR1sN19Hc7lxkaEFkd5yMscslaChyCjRKkW6F0gJvMHsj+Pdt4KiNJkXbl
 DYUm/YkZxd1lZ8M7quwZnSTq5bgG9vlfQF9jyD+4vQGxsKMrLbSi+4WVzRSOReOH
 tcNixvnh0C1stPcj7ev8CofeM3PJGDRxnbJ+rti+iS6LaTA01WqJ3TqocJF0+zpJ
 lo0Zt3QV2ILrrMpJNQiK5HwQa6gXBl4+Mak4MBGhRrN7GeT8p8cgV66yueiDJ/5x
 LAfimA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706210; x=1785311010;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0q8EJ8QXVFX2fJUz6p81w46E9/Vbcyb2AG+lKV2UuEk=;
 b=AogB7+re2VmX6sVI1MUzlxIXg2cGazh+uvkF+UySoEB2j0+xwvR03kayOVP974bOMG
 57RXA2Fo8tLQfhjWNqew4GH7SSdcGe9HWrbMZfbeTSCoTAKz3eEn9SwINaeU79iQVbI3
 XVsise8zYg7r7gzlibw8U5F28+Og66xGLL+zNbqWc84HqULZCUgJ90L+uwXLD4HXRknZ
 S8vFodDIQMejBlV68N1fVfOl/WVXWJGcIAGowE32DTPfSRFMPnRfFtrJs3L3ML4FXpY2
 IMmci0GvDZ40HZ9EyX42ObqTWhMM4SvTI3PccYYvYL9Nhq5xdEs+/QSL7rCeWHf5qNyT
 7Ahw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cBnygLzF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AogB7+re
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This patch adds the basic board init routines that invoke the common and
mach-snapdragon specific SPL frameworks to proceed with the hand over from
boot rom to the next stage i.e. U-Boot proper. This also provides the
linker script to generate the SPL image in the format expected by the boot
rom.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/include/mach/spl.h     | 14 ++++
 board/qualcomm/ipq5210/Makefile                 |  3 +
 board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds | 18 +++++
 board/qualcomm/ipq5210/spl-ipq5210.c            | 96 +++++++++++++++++++++++++
 include/configs/ipq5210.h                       | 11 +++
 5 files changed, 142 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
new file mode 100644
index 00000000000..9e09bad82bc
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __SPL_H__
+#define __SPL_H__
+
+void qcom_spl_malloc_init_f(void);
+int qcom_spl_loader_pre_ddr(u8 boot_device);
+int qclib_post_process_from_spl(void);
+void qcom_spl_error_handler(void *arg);
+
+#endif /* __SPL_H__ */
diff --git a/board/qualcomm/ipq5210/Makefile b/board/qualcomm/ipq5210/Makefile
new file mode 100644
index 00000000000..d808c106524
--- /dev/null
+++ b/board/qualcomm/ipq5210/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SPL) := spl-ipq5210.o
diff --git a/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds b/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds
new file mode 100644
index 00000000000..f0ced6765da
--- /dev/null
+++ b/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
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
diff --git a/board/qualcomm/ipq5210/spl-ipq5210.c b/board/qualcomm/ipq5210/spl-ipq5210.c
new file mode 100644
index 00000000000..e0c52c0a6f6
--- /dev/null
+++ b/board/qualcomm/ipq5210/spl-ipq5210.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <hang.h>
+#include <cpu_func.h>
+#include <event.h>
+#include <init.h>
+#include <image.h>
+#include <spl.h>
+#include <spl_load.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <soc/qcom/smem.h>
+#include <atf_common.h>
+#include <linux/err.h>
+#include <dm/device-internal.h>
+#include <part.h>
+#include <blk.h>
+#include <dm/uclass.h>
+#include <mach/pbl.h>
+#include <mach/spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#if defined(CONFIG_SPL_BUILD)
+/**
+ * board_init_f() - Main entry point for SPL.
+ * @dummy:	Dummy argument (unused).
+ */
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	memset(__bss_start, 0, __bss_end - __bss_start); /* Clear BSS */
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qclib_post_process_from_spl();
+	if (ret) {
+		pr_debug("qclib_post_process_from_spl() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}
+#endif /* CONFIG_SPL_BUILD */
+
+int board_fit_config_name_match(const char *name)
+{
+	/*
+	 * SPL loads the pre-HLOS images from bootldr FIT image
+	 * as below
+	 *
+	 * In board_init_f() - Matches "pre-ddr" configuration node and
+	 * load the images mentioned in its <loadables>
+	 *
+	 * In board_init_r() - Matches "post-ddr" configuration node and
+	 * load the images mentioned in its <loadables>
+	 *
+	 */
+	if (!(gd->flags & GD_FLG_SPL_INIT)) {
+		if (!strcmp(name, "pre-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	} else {
+		if (!strcmp(name, "post-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
diff --git a/include/configs/ipq5210.h b/include/configs/ipq5210.h
new file mode 100644
index 00000000000..5cbf838af82
--- /dev/null
+++ b/include/configs/ipq5210.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_IPQ5210_H
+#define __CONFIGS_IPQ5210_H
+
+#include <linux/sizes.h>
+
+#endif

-- 
2.34.1

