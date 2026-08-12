Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED30C5CFDB
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 01:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAD38608EF;
	Wed, 12 Aug 2026 01:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxhbvkzKlqvs; Wed, 12 Aug 2026 01:12:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B68CA608DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786497162;
	bh=FP4vSH+jrkU46KyOdCKiKgS3WzdwHZb3mjAzTU9jj2Y=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QF80ZLLiYljIGHFqHjH0grHRvRvkhTcJE4cXz+Ymx77rPXu5mr4llxcYg6B/ui+uJ
	 RyCoRIefVkbnuMb8CNlFlUSbGQ5H8AUknMXk8SoM227VmKRTQf9XA+8MBGEJJEsfil
	 Dh3FkEGPLuqq4XGZqZ0GbksePKkgwtrYsjeiuXo/3XN3RxKCqF9p07UZjiBLNsRmaM
	 RJEqK22xU+Ek2cJFXNAo6ZMkJVfRMOH4SHgYLxTzgzxNzUf3HvluKTSfEgvQ1o1u+B
	 pwsPCWG7NYyxdEZj9fcidoXB9btvUHGY9obLL6OHqG5c/B8zJ6harEEzN/PGMLf/KN
	 WtEQDiE2bMPXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B68CA608DA;
	Wed, 12 Aug 2026 01:12:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E0151F47
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BA4E80F29
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Yp40ECXvD7Z for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 01:12:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0B56A80DB0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B56A80DB0
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B56A80DB0
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BNH6G81990187
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:38 GMT
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049gtt64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e5a616d07so552886a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786497157; x=1787101957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FP4vSH+jrkU46KyOdCKiKgS3WzdwHZb3mjAzTU9jj2Y=;
 b=E5/JPOLmNoFjHBsojvtmcAKb4RnuX+jxc95Y3hiyLdDQSp2y+kP+4k5FGPjwgXe58d
 ng4Hg5Srw8jw4S+h1cTmNfNsdyJKpgg83eND4kMM46Q8lgw0XRciBzeLq9w0LEaZe+Mj
 8XLshJmjYbq8WT16Z+M+8CZ4W4igCul1uUjL9T3eJIelitkLUePagpAXAPrltDJzZzqj
 Ya8eGJ3IzDHlJch9vXktbbX0/Ygdvad1RwL3F7bf1hmgNPanv36b8tQ9QlDIZHyWNvbD
 pvf9rHlHuzQdYmW4IKNb2XhZh1Ua94VtsAi71qNKXLCJFz3KLpozOBjuai5Pj+XTgepp
 SmAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrhnx7MalCXoste5KsT7byAc5/3SLpWlx+wv8/+HK7d5F38QUH4FP1ta/CmSx3UmSFDautAWCc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzStcbGFl1ygji7mSDPzQuesX0NEZAexHWtz9WJjbMlyYHnZnuk
 MmK0g7PozwyWJQcxkitkDBCsCiW4lF1podbypF3wibqRSxrWlDztk/5DpPKApKUy+dT+VIbtHA5
 LJqQICC0uEL6jp1MA6Ded1/qDDLrbuWfWExjUGenZkaUouoVohIdgSx5QX/VJSXB9SFjKV+g=
X-Gm-Gg: AR+sD121cGMFavEcsGGLY1HG8vvHZitzLr6mtzEZGEUtXFKRAl2SEZl86G95g1sfLgx
 Z9qmLosrL7ftsVIvUIsrpKxsY+XRLGTMeSTFE95cNQ7B8JV4/xZBE4ZyP4O5ZIG6TjOnomZgRGC
 W/caeIoR8mUE5QzH/Dz2KfhWRSYkU/Hn16A1ciQ8kSBOdAMh6yT68i8U5Cn21xrgbmcpAFPCwo7
 OMuBErHkZpvF6+9qh5+O5h9mSU3QnrD0033EX2/D+FfBfddwphBt1c9i0+RN4BMrBJXk0rRSXNR
 8Z6Vl1PMdukWHf5h3jAu0j9LuItkrv+3cJP8okEtNuhTRnm+QboM7SRHbjXkR/Fq5FuQs0lecDa
 miJi/sRJS0MhlvCJzYuxcLHUhHiocVTF+XNs3SkKRR+ObjgzWOHdiB0Xu/ko8Pr1F1H15OpnrYK
 BcTXr2B8nFVqtSgzwrYecMagHpcGUm
X-Received: by 2002:a17:90b:2701:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-39301490cefmr1282273a91.13.1786497157141; 
 Tue, 11 Aug 2026 18:12:37 -0700 (PDT)
X-Received: by 2002:a17:90b:2701:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-39301490cefmr1282213a91.13.1786497156668; 
 Tue, 11 Aug 2026 18:12:36 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf6d7a366sm4371725eec.27.2026.08.11.18.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 18:12:36 -0700 (PDT)
Date: Wed, 12 Aug 2026 06:42:02 +0530
Subject: [PATCH v2 4/7] interconnect: qcom: Add QCS8300 interconnect driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-b4-monaco-v2-4-865d288c0be6@oss.qualcomm.com>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
In-Reply-To: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786497134; l=9502;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=oBtjkMq/XioB/Lvcttl9RVAztGNo+oKwF/YTqMVpCfw=;
 b=uZ/XGD+XdWiMzFM/bz3OTMflRXN0LzMpdtMk5SojaS6oY6vu84iQcQ5FsMxdaXyzrC7gA1Rg4
 gOoAh87M5wVCMJ/X3dFxdGMlktp+TyCf1hz009KQX6yfvbwZk2NoFpq
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfX6yJ1x9bLn52a
 ekQ3HCF4BvK2B7Mze/yDLd9Xa5q8T6rV7d6ULARSFs35fqK73ROcQNZaAdnFH0PqdO68veinfe8
 FZTaArVByrwwlzM7MXRX3AVi/2smheA=
X-Proofpoint-ORIG-GUID: ltS9TsDFiLQc1DHChxDFFINk2ef-tdGD
X-Proofpoint-GUID: ltS9TsDFiLQc1DHChxDFFINk2ef-tdGD
X-Authority-Analysis: v=2.4 cv=cvarVV4i c=1 sm=1 tr=0 ts=6a7bc886 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dgP1Qy9_uxgTXmFQ1VAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfX98xWe1m6vle0
 dTMmAq6cGB2m+yCQa3M1cjsxsCU7EphuV11enRWjQBHCi1wFAjz54EAs2Cjt7Y5iO9KDppCkQWD
 Th1jW5OWakLmfZq4kuiObg4MJrIXmEjnXdO3qn6ZmwW/5Rz1CKRkxkd0q1CGnwVcI2SNbj29UTr
 ZDZRiroj9/zVs3/14z+r7cEmXgL0o2UchHNyqeTeJO8zWZ2wt8L17E/a9s3Zf+1RPwOpbdXVj+y
 abIAGpg8KtlmmM4Pp1tRPHs6+wkDR+bym8xqaS2zR334fKI4gKylg5erL5d5ypYV4PsxlfEPryG
 Tb6WEhBgy99P5KOZRdJXAmiZs8v4nHjweRHYTHM59E37KxAF2OEDlsNf2oEBGwu4OWIvBJMvZg/
 T4IwA+Ogv1PIyiigE5ta0Nn2lDlRMfKE0gKfqokIL4dAFc4ocAdZu/8N4NmfxOp6i+MHgGVvq7m
 Y9bA1TZuSTZQjKsvFzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120006
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FP4vSH+jrkU46KyOdCKiKgS3WzdwHZb3mjAzTU9jj2Y=; b=A+cCsDALjDlCUECu
 Tf5LWlPz/NhnTQ7CnQL+GotugZQZoTONRU2PKP1LR/NRkR5VicNS0wm6hUUQcha3
 KS/OMNVrw2lfclsYPFYeyKk3cTub+J4KNzAak443Azr7HmPIorwyid+Hj9gXXQXQ
 OG3z8beaeq/+bp1TY2wzCldld2g5oUaHzdl+apaNmsiJEYpk2T1kHTbzeHN6Ej0e
 RO8K97lPV5d5356yYndV3/m9bO1XMb5asnna9nWdFTit9hN/jWL5XxN8zBw2o9ES
 pUrhacQ9mjK2VLGkNJ6gIprb23pHrX4eSOAjlO5RHFkqsjywUQ7gLsnFijKImIgw
 Nu9cpw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786497157; x=1787101957;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FP4vSH+jrkU46KyOdCKiKgS3WzdwHZb3mjAzTU9jj2Y=;
 b=Ewg2n0LNejMrgCdJZkFzUUy2BE7wKp8A35pZBu5L2Dx3bdeIS8lwCgogDay4kGEftf
 228Gz/dmOm0nbi73x678cwfv9Un/zosk1/8r1Us4UlIvDGJsxxhnXEVFTJbRdgJOdbjf
 AowHQtc0YQF+ZmdO5V68TtGKCARopLFSUsmVp+G089elBkALITCpkrqXyPtc/rZWkis1
 e4FEdptYOHfgFpx7j/6CU6JC7hf+nlGDMMJqYApiFgOG0xBKpDKoI+VY4kh1wP+n9qyy
 Pe077SmJZxmjbvNnGj/AU7iOPEvJ5Hi2xWNjLzC7eimz54S3nl6Q08jRqqmZLd7x9C9N
 L83Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=A+cCsDAL; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ewg2n0LN
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add the interconnect (NoC) driver for QCS8300.

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig   |   6 +
 drivers/interconnect/qcom/Makefile  |   1 +
 drivers/interconnect/qcom/qcs8300.c | 269 ++++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/qcs8300.h |  24 ++++
 4 files changed, 300 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index b105c3a1f9a..906f2fa604a 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -5,6 +5,12 @@ config INTERCONNECT_QCOM_RPMH
 	  Enable support for the interconnect helpers to vote with
 	  the RPMh subsystems in Qualcomm SoCs
 
+config INTERCONNECT_QCOM_QCS8300
+	bool "Enable interconnect support for QCS8300 SoC"
+	depends on INTERCONNECT_QCOM_RPMH
+	help
+	  Enable support for the interconnect driver for the QCS8300 SoC.
+
 config INTERCONNECT_QCOM_SM8650
 	bool "Enable interconnect support for SM8650 SoC"
 	depends on INTERCONNECT_QCOM_RPMH
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index a33a65bd82e..6ba69269621 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -4,4 +4,5 @@
 #
 
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_RPMH) += icc-rpmh.o bcm-voter.o
+obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_QCS8300) += qcs8300.o
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SM8650) += sm8650.o
diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
new file mode 100644
index 00000000000..db5316af2cb
--- /dev/null
+++ b/drivers/interconnect/qcom/qcs8300.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+#include <interconnect-uclass.h>
+#include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
+
+#include "icc-rpmh.h"
+#include "qcs8300.h"
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = QCS8300_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = QCS8300_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS8300_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = QCS8300_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = QCS8300_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = QCS8300_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = QCS8300_MASTER_APPSS_PROC,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = QCS8300_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = QCS8300_SLAVE_LLCC,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_MASTER_LLCC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = QCS8300_MASTER_LLCC,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = QCS8300_SLAVE_EBI1,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = QCS8300_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_UFS_MEM_CFG },
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = QCS8300_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 2,
+	.nodes = { &qns_a1noc_snoc, &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.num_nodes = 1,
+	.nodes = { &chm_apps },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = BIT(3),
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc_cnoc },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+	&bcm_sn3,
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct qcom_icc_desc qcs8300_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct qcom_icc_desc qcs8300_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh2,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+};
+
+static const struct qcom_icc_desc qcs8300_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc qcs8300_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const config_noc_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+};
+
+static const struct qcom_icc_desc qcs8300_config_noc = {
+	.nodes = config_noc_nodes,
+	.num_nodes = ARRAY_SIZE(config_noc_nodes),
+	.bcms = config_noc_bcms,
+	.num_bcms = ARRAY_SIZE(config_noc_bcms),
+};
+
+static const struct udevice_id qnoc_of_match[] = {
+	{ .compatible = "qcom,qcs8300-aggre1-noc", .data = (ulong)&qcs8300_aggre1_noc },
+	{ .compatible = "qcom,qcs8300-system-noc", .data = (ulong)&qcs8300_system_noc },
+	{ .compatible = "qcom,qcs8300-gem-noc", .data = (ulong)&qcs8300_gem_noc },
+	{ .compatible = "qcom,qcs8300-mc-virt", .data = (ulong)&qcs8300_mc_virt },
+	{ .compatible = "qcom,qcs8300-config-noc", .data = (ulong)&qcs8300_config_noc },
+	{ }
+};
+
+U_BOOT_DRIVER(qnoc_qcs8300) = {
+	.name = "qnoc-qcs8300",
+	.id = UCLASS_INTERCONNECT,
+	.of_match = qnoc_of_match,
+	.probe = qcom_icc_rpmh_probe,
+	.bind = qcom_icc_rpmh_bind,
+	.unbind = qcom_icc_rpmh_unbind,
+	.ops = &qcom_icc_rpmh_ops,
+	.plat_auto = sizeof(struct qcom_icc_provider),
+};
diff --git a/drivers/interconnect/qcom/qcs8300.h b/drivers/interconnect/qcom/qcs8300.h
new file mode 100644
index 00000000000..2dc523d127e
--- /dev/null
+++ b/drivers/interconnect/qcom/qcs8300.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * QCS8300 interconnect IDs
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_QCS8300_H
+#define __DRIVERS_INTERCONNECT_QCOM_QCS8300_H
+
+#define QCS8300_MASTER_UFS_MEM			0
+#define QCS8300_SLAVE_A1NOC_SNOC		1
+#define QCS8300_MASTER_A1NOC_SNOC		2
+#define QCS8300_SLAVE_SNOC_GEM_NOC_SF		3
+#define QCS8300_MASTER_SNOC_SF_MEM_NOC		4
+#define QCS8300_SLAVE_LLCC			5
+#define QCS8300_MASTER_APPSS_PROC		6
+#define QCS8300_SLAVE_GEM_NOC_CNOC		7
+#define QCS8300_MASTER_GEM_NOC_CNOC		8
+#define QCS8300_MASTER_LLCC			9
+#define QCS8300_SLAVE_EBI1			10
+#define QCS8300_SLAVE_UFS_MEM_CFG		11
+
+#endif

-- 
2.34.1

