Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89FFC7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 04:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B7981F66;
	Fri, 27 Jun 2025 06:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyOZXF9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50AEE82B34; Fri, 27 Jun 2025 06:43:21 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF4B780C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 06:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4DCxe009529
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 04:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=SwxQ0J/x+R3jBcDNpnLhE3yvfk0foMgjB4t
 m9FTxVoo=; b=TyOZXF9I5nQz7QCnFYioYueA+bWRQ8L9/UNs3aGmTG3+bPXXHr0
 B7XEi0hWog0X35uTiFj6iMxh428VUOeMmX+q4y9GIdZExek30URBaQEKtJhQ9Z9f
 N9CKIcIsYxa+Gc+x6cSiyvJkHsw8ifFJOEqEnoxYgXmQC1MVTpdU2M3rxm5cdY7B
 CIHlf7RnBKHAejSUTVVdqYiLWhGrgx3skGyajFp2jTuxNhYtYy6MTieH6IyL7fpy
 3LY/xWekTA05kxcsHWP9yL5zg5/JofY26CYd9RE6MxlEuQyBoQo9unT7EOfgp089
 m70Xqy+vTlyS370lUmoHqxSP2YmxdHqJWbA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b45c14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 04:43:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b115fb801bcso1864374a12.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 21:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750999391; x=1751604191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SwxQ0J/x+R3jBcDNpnLhE3yvfk0foMgjB4tm9FTxVoo=;
 b=ZwrI8XTpDB9CXRTd5vFHYnMrtfsKtHLc+KnkLdkVgNW1ovGbBNQewMkQxvmhMUXHYR
 RWPg6pvYZT6rvlcCPAWIkGocKQ6nkyASzNSLNxJz91P2aElPtw5iVBTmbAZ3fsjO0jWB
 uB0kEZ7g4N24mhGSElnaLFtNLhrmFL9pxIgQ5487p9GS9QgVlFYgGV6CccsKLvG9DW/g
 9xjbVhuRcn/+Tjl/lsD0ymbOGr7APIUQxUpoFxeUKwlgjMWdDWuWOwsiiA2SfuDsKS2V
 2prb7kAUxXhwAcUvzUPyKISfyBgzXIsk7Idf47A+lxXdApR+sK8XA/kMMU2ritaFvHOa
 YGsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqS/l/cj2SH+FwshU2hFj9TNTHAePsbozXjV7fJKsMSXfYrl52w4OVrQIAWFvbBZS38y4pv9c=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7o91c3TN1QvgOP42RIuvfZdZjAMnnruV30TPCKryml7AZchBB
 kiKcBl6IPDsVsJgY9YEmyDarMqaNHoziA6NlA4VF1zO/TVbE/L0PSGZRokz/zibf0wtrSEH8kQw
 iqrYwurQROA5kiq+QlzhDqV/dIlFN/WKySAnUSN+Odqls9XUdnnvhm4Yx
X-Gm-Gg: ASbGncs2Ju/ItmchnIp/DTnsS5ibTvm+iW4rLv+wMOng67RC10D04tGJyyRRl9cs9QF
 1mUorBGj9cj/QpFr9UXednqupAJhn/dAccmk+Qvc6T7mkRNWpa95Ww1LF3NMNyyvvkxrwGjJuci
 lg3GBAgItZ7p5I6kcnV9Mhl/QlvqRvs5VZFRYpDtWJgPBcmrWTPw4w+/PbTkJT9+w4PIqbYuRhO
 DOzOqcOwllKYLpdVABGGplSiUmVMq3qOjy6feKynXNTfdZTwXBXuBlwfNl9rvkOBIrEs+xpDgsI
 HiU38BJ7GHy7fIphZkttj/ZDcvL1rnJTRDRIXl2YpgqOmnhmgX6y22R7jJ2CWTgqv4eudntNCnF
 /lZOJZ3T1gQ+ub9SkrQ+8PFAVvE0nu0UVN6f+Z194y1N6L5rYI04=
X-Received: by 2002:a05:6a20:7f81:b0:220:842f:2745 with SMTP id
 adf61e73a8af0-220a12640e2mr2423307637.4.1750999390974; 
 Thu, 26 Jun 2025 21:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN9Aoy+s0YaxqUhO+I2gSKgXYSFUPwwlR5/zPJo6uPK06o3jgC2aSvFQSgN/xEL5bszWWdWQ==
X-Received: by 2002:a05:6a20:7f81:b0:220:842f:2745 with SMTP id
 adf61e73a8af0-220a12640e2mr2423276637.4.1750999390583; 
 Thu, 26 Jun 2025 21:43:10 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af5805265sm1245207b3a.168.2025.06.26.21.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 21:43:10 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com,
 balaji.selvanthan@oss.qualcomm.com, s-vadapalli@ti.com,
 jan.kiszka@siemens.com, u-boot@lists.denx.de
Subject: [PATCH v1] usb: dwc3: qcom: Add delays in UTMI clock selection for
 Qscratch
Date: Fri, 27 Jun 2025 10:13:04 +0530
Message-Id: <20250627044304.2223767-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAzNSBTYWx0ZWRfX5TYwfvgnGGWi
 S9qEx3GMCol1fJDElZQ8a3quDSYlLuKU89zs6mhmEaHpsNd8jJWChfY4ffMgKi57GqsafpmCHBd
 uuYM4WKgZoOR7J3TXO8Fr2AUCMqF8Riuvf/PoHuu8U200EbOSd2IT0eVsxczcggMYzjPF+rJPmv
 3xLGHRi6CfBdOWisSyq9yaDKOoiHTHqNiCojGCfj2NfvNDcAjnfqwCTErZMDTwJvxJrNtmd4tZ4
 Msx8gzLjL1l74fvWx4Xj/tLGY5t/eMzMhAp7ci6Xcb5kkEjT9YblnugtBYk+lJZeMWsLz1Aq8Dh
 OZXBwQqsy3PpvWsjph57JSMrDgnnEcX/0NnlXwLbrzBHYp00ObfTLe5J7o/CgzCBHBmd/R2Cfd0
 N0qGTKiLN5UxdJyOmNZWxOMG+o1KJCb8eT7NN+hqLcfNDFqojMvDi89ljFR4QViTEbd+Pb1I
X-Proofpoint-ORIG-GUID: 3YiGRlH8J7sN90E98N-bkylXKT_BssfN
X-Proofpoint-GUID: 3YiGRlH8J7sN90E98N-bkylXKT_BssfN
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685e215f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bGMnijIEohOSe27sD7AA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=997 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270035
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

From: Balaji Selvanathan <balaji.selvanthan@oss.qualcomm.com>

Added delays before and after setting the PIPE_UTMI_CLK_SEL and
PIPE3_PHYSTATUS_SW bits in the Qscratch GENERAL_CFG register
during UTMI clock selection for DWC3 on Qualcomm platforms.

These delays help ensure proper timing and stability of the UTMI
clock switching sequence, potentially avoiding race conditions or
unstable PHY behavior during initialization.

Tested on platform using Qscratch-based DWC3 PHY configuration.

This change is taken from this Linux kernel implementation:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/dwc3-qcom.c?id=a4333c3a6ba9ca9cff50a3c1d1bf193dc5489e1c

Signed-off-by: Balaji Selvanathan <balaji.selvanthan@oss.qualcomm.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 21452ad1569..4800eb64484 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -460,9 +460,13 @@ static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
 	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
 			  PIPE_UTMI_CLK_DIS);
 
+	udelay(100);
+
 	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
 			  PIPE_UTMI_CLK_SEL | PIPE3_PHYSTATUS_SW);
 
+	udelay(100);
+
 	clrbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
 			  PIPE_UTMI_CLK_DIS);
 }
-- 
2.34.1

