Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DC3C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACE1640791;
	Wed, 22 Jul 2026 07:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKgXXsSVIN7j; Wed, 22 Jul 2026 07:43:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C53F9407A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706196;
	bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=v944QlPkbIVwcpgHnGohZGf3ZBKdauepqdAO9GXBD/pXbtbeYNyfUK5rxyx7+h7xf
	 cgFzHSebFJrys6cunn8kUxhCyAsTEVF1kyz4CKiysjdS3NQP1PvxzrqhpJx19jfIxL
	 5LLMBGvMplliU+nsDtxmWoqFsV1DS6Dy4jTZc2hJM9UzRrQ/NXvaB8ZhBXU1xnKNHg
	 6KSVaKutZxwjc/AnYiM4p4Q7/tnEQE6xG8rXfVT9RVi5p9yd8Nt9xtCASO2JVmguKv
	 gE858W/TDORU0Ky+Wf+44Tizs+k9UzbG3RuqJsby4NPmUKmEQHRiNt4ZqCvnqiGR0S
	 nV5UKmOxE2UTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C53F9407A1;
	Wed, 22 Jul 2026 07:43:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7256BDB4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57B0480CBF
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5wT6CPt4DsH7 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:43:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2BD0A80DC7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BD0A80DC7
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BD0A80DC7
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:14 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53jll4055077
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:13 GMT
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdgpqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84870e7f498so12734692b3a.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706192; x=1785310992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=PA+5X6G015BDRhj7Fr44ultRIWBFboN6ojU8h8qViN+d7dU2ceDWrXwYOBVyVy6CJw
 jfEqH5sGUkyzQg6cqz5WMDZC6537JuKQfjFwqQRdhUzop9DeQ9xcI5uhUOXa772uXLiO
 ToCyfM6DbDvVz/8ov2ILhfZWEqDVlcXn4/v3ZrhhopEhv6McS4WlhI75w5ggwFa9Jkbq
 H3glfoo8bTmxDYOaShuMbDNqz+TAhC0hgc3or8gttUUs6hsHa5uJCKTfslAe6w+xw+RF
 dOarLMzqtPNH5SbQiF1YmJ/zjbZUirP3MRDjvFCWM2Ossr3gc+iwcI1ABgx3TmXcl11U
 aIhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbfWx7+cAijphgqi5mx+/y+vtJxv2cgLtBe9pFfipPaFZ8sh6EFIBDLlvsebTOEuAbwO9o20Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzdadWfYdgdb9R4+jfkAd/UJEbcU2TIbYvABFjmeMFex3CdSSq+
 QDC2RqngV924cORaF/cQmJcE/h8f8+hu6DHKWsH+4pPraRzLHmN617wdYY/PHUZTLLdSLqtXPVC
 8ehgym1hyoO/sQ8kkSxSbEmobthebUDlA8bS9/HqfPA2a0XiNLKqYQ/BYknhQbYBMgp9c+Tw=
X-Gm-Gg: AR+sD13ZP/PTRb7llAy56EUl+xBFwJAIOxCmsVBKyVY6MHgWfyjjuSgZ2bGRx633yE7
 vo7VjaNihQvjrgX79LBpRejavCCGlSZxkSr5oYcD4lZ1r5RsyD0TjWI/79lwkec2U8KRONKu2Sn
 KSQkO9Ab/16g9W/4CzBuG0LH/f9LWpeKIo08wDzSG+tAnNK0FNvHldMkgk6vhubC9P+FAw5agUn
 mr8MSAys2thkX6T/ed6ljQ6dJZCISWXORYXk+aqKwG44Knk5t8dMi59bxPaAhionQseKamK4sTR
 9SDyUzxyMSw03WjTsl6mlWf+u8tyXZV0DDVJhgaaOq3ju3hXPsIRv0t9rtB2ujYcDJYhUi+34xs
 SZQ/OFbyAanEBNvv6GGSu9HQ5d5hIq99V87VJPGjeSY83xnnwzRF+NtG5TMekWv/B4nve1F2zM1
 6rYBbVyE9IFi9Lr1j3yoatO90sOV+fpg==
X-Received: by 2002:a05:6a20:a103:b0:3c3:87e1:2637 with SMTP id
 adf61e73a8af0-3c3ad7abaefmr23911573637.22.1784706191679; 
 Wed, 22 Jul 2026 00:43:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:a103:b0:3c3:87e1:2637 with SMTP id
 adf61e73a8af0-3c3ad7abaefmr23911536637.22.1784706191250; 
 Wed, 22 Jul 2026 00:43:11 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:43:10 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:22 +0530
Subject: [PATCH v8 11/15] clk/qcom: add clock driver for ipq5210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-11-cbfa79e85a9d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX5n7bvtSOWpUA
 pUva6YwlPpinLi92sWjGlQw+oIJNTBJbPJ5dz6tLyx/5eoc9ZOYS7Vk53wDkS6hxIQqjtThxtWQ
 UHd65fwIe6dYy7JcThyhVmzcjZMzabd4tOXznZaxNQDTTDmITvmvh6rQCaSmFZt/46P3cw1PtR1
 XKFrsIT4sJoN5rh2BFGOrwC4zytGxkiuAnk0w3aE2ocM+py9tn6QH+MVV0xfe6SHses462inkZn
 sV8xKUKHDqgZ+LkyFGlAXtevKgUCpVskzX9m3M753v+Gvo+nqzyIGQMEoKwz2/yA0Y6Zr79PJX3
 tLjFzfKLPoMssDZ8W4rpq3aNoBZhMZiw3+ozlxDGCOS8JN60kmwVrjgqW5xFUe4EesuO8Jis3Sq
 clHUUyNdCwFix9P7/r/6s8EMzyHmcU4OYo3fTqdvq2zfH9Ge9ugaqWSYxXJczJcD26MM/sVNHSR
 bCgXCWM0gUNoy8HV5nA==
X-Proofpoint-GUID: Wdi3G6ZU1jg_0M1REVFwME8KnDJxm-EI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX+FgPTF456NC9
 TCurE/DfSvd048tuy/VUWts1WG9V+wNb/KhzL1sbwbTJ+lwwjWnOUySBXpKXNZa2U/8R2Jk0sRQ
 gMmiIu/Vwxd7lD4LSWLwfz/C46exX20=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a607490 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=ttnG5VEth79ohM5wMFYA:9
 a=kETcTEvuJSViBEbj:21 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: Wdi3G6ZU1jg_0M1REVFwME8KnDJxm-EI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=; b=ZoQ5yfNOjeWTVLQy
 MkoNYCkMdHiEUj/h11Rm5tRPY8C+ZmhqVohcgzyK4uQw+kQCyTq/cO31XAApyj7p
 sAQrveIr4fwXa/KxCFTDAndzZNfd5E7Gb04Z8v2GhtYYZ2R46OAPekgU68iowa3z
 NB67p8CTUsxQ8Fp8g7YP77lFXLf14HhaIzzjObnfRQe8CpZf+myoTtUT36Fk90jB
 jdAzMcx4FDhoM8h8D08RfedWUmPCBymDqv9T5Q6VO0GI5uaAK9B6LlKP1TTwEkzK
 IKIUjC1gQO4KcgZ6XC4E2zGsZs8Sah23E5Q12Em1C5Z93qEkANAtp3lrpj6gIwNQ
 sdX0fg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706192; x=1785310992;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=S4UldUs+4jJFpALoQ/opyyBf5Ep9NqzESuQM8T/kD210RSqJnuydZfV0j+RyG9DZ95
 9iW/+BqmGjdm3ypAzBX/MlaagDsDXG0QHLV6xd+aT8ecogzzAp4SO66dOvSffgafqu1N
 TVcOLY789QuseB03rZ9t/7EJ8B/XpVt72tFXl/hvbV/BCILMmZz+EZLOJVUyioEWmskI
 BnehpyWsbjwivF1Sf8kDBAjmyDEIZ0s0r/QErM/Nj5tTYYrbCSXpB6qLO/kDuSkABrao
 hv0O0z9EA6UpW2L4euX3eiOmUQCULKgy6lRuKT0QNt0ZaWvWD8KxrA04pyeTQxR1MFNV
 WVng==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZoQ5yfNO; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=S4UldUs+
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

Add clocks and resets for enabling U-Boot on ipq5210 based RDP platforms.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 ++++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq5210.c | 93 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831a3..a142890acdd 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
 	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ5210 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1adca029b11..8934635fb48 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
diff --git a/drivers/clk/qcom/clock-ipq5210.c b/drivers/clk/qcom/clock-ipq5210.c
new file mode 100644
index 00000000000..cd82b238bea
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq5210.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm IPQ5210
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/reset/qcom,ipq5210-gcc.h>
+#include "clock-qcom.h"
+
+static ulong ipq5210_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE1_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 2, 217, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	case GCC_SDCC1_AHB_CLK:
+		break;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 6, 25, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rate;
+}
+
+static const struct gate_clk ipq5210_clks[] = {
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE1_CLK,	0x05020, BIT(0),	0x05004),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,	0x3303c, BIT(0),	0x3303c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,	0x3302c, BIT(0),	0x33004),
+};
+
+static int ipq5210_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks <= clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return -ENOENT;
+	}
+
+	debug("%s: clk %s\n", __func__, ipq5210_clks[clk->id].name);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map ipq5210_gcc_resets[] = {
+	[GCC_SDCC_BCR]			= {0x33000, 0},
+	[GCC_USB0_PHY_BCR]		= {0x2c06c, 0},
+	[GCC_USB3PHY_0_PHY_BCR]		= {0x2c070, 0},
+	[GCC_QUSB2_0_PHY_BCR]		= {0x2c068, 0},
+	[GCC_USB_BCR]			= {0x2c000, 0},
+};
+
+static struct msm_clk_data ipq5210_gcc_data = {
+	.resets = ipq5210_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq5210_gcc_resets),
+	.clks = ipq5210_clks,
+	.num_clks = ARRAY_SIZE(ipq5210_clks),
+	.enable = ipq5210_enable,
+	.set_rate = ipq5210_set_rate,
+};
+
+static const struct udevice_id gcc_ipq5210_of_match[] = {
+	{
+		.compatible = "qcom,ipq5210-gcc",
+		.data = (ulong)&ipq5210_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_ipq5210) = {
+	.name		= "gcc_ipq5210",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq5210_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

