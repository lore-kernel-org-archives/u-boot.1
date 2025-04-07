Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D350C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D5A282E68;
	Mon,  7 Apr 2025 14:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KosAvXgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A23582E67; Mon,  7 Apr 2025 14:05:51 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452CA82E38
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dopf017417
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 12:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OTrZpweS73c
 9Squl3oSIIBpI7rhP69nspy7/hXQCRco=; b=KosAvXgwP+IEAVH/x5OIm9ZIg9m
 CXhSSNtZaAWIZt3ZSLjwJUnj9rSNMFURp/5nPYNU54neLDKPm1bz0VsKksIS6p/7
 r3vQduyj/Z+ObH3M1FvVf3kBzFyPTOWE+dBSIB2lUYHk6vlGY6J0YyKom6KBiyOC
 pO5SUWMJd6ki3acu7k6H/HOakusjDPIZIFbPYz7ctpyO3qKpo3HJ6Kli0Q3d6pNF
 XBvCDg7F7t2lRAtxPNoohk7cD/TEaJoFFmBP92NK582qvu3aaJCbmxcBzYyFcRkk
 KcfkN7cIVXwropk/urh+AaMUFuh/VBjBIITxV3jvtHIen6Xe2hAJw4nebWg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3c3q6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:05:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5c82c6d72so783278085a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 05:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027546; x=1744632346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTrZpweS73c9Squl3oSIIBpI7rhP69nspy7/hXQCRco=;
 b=K5I4ymn9r3Bq+tDNPSEFY4ECaQylLajzLRPFdbrdBIgTFLkzx8tQx52BWfrpi+GxmX
 fD4GDDJnSsbsr9Vij9gJQe5e5UkCxMz0jeaR1nSr/IS4Ig1/z6bB+/AYHn5/l0cWsCd2
 DDYzT2OZN+qnqF8weOjZM2hUX0jDhfKZpibOOvZ76Coop42kOzNExFC6yc4AJvSVMSX6
 cbLy7eNy8RSBUmrJzcbUx/s1wkFP5X/XDZeco1GyrxkDJa8Yym0HNSN9ogZrOqu3MzdV
 mfHyidzY91ThA9P5aFcd73snZQoQgjg0Z0hvDiyjVVAg1FwIDi22xFOadBnglkhp0k99
 xX7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCULY7mlWyuUzAokz0df8jrmo0KZHmUe64ySRid9KwJ7yOU0WqppgiVkicWJRlh0U4NDiVvnv58=@lists.denx.de
X-Gm-Message-State: AOJu0YzjyabdIcws/eW1Wh621kxfEIs+jho6LtOwuYa+ooxBbIk54hLE
 0fvgIMosNIA94hgUWvBBhXcSgXR1oObAiWSV92meOjXMCV6kiR9ktrHed1wkjsS3dJVnwWa/6MT
 d0Y+FG5X69F2ADlMDJ0e52JDNPXkPjODaiMTK4NoCTnQMSzJkWZaf
X-Gm-Gg: ASbGncuuGswSrTgWVOk9D0fRN2cxyQzZnrxI+ZVziy4rLyHNB0LDp3pXvb70eHELfwm
 a4TxUYGUNl46LLZGfcgE7TRSLnSuscCshrWRyY5bljg6ZsDlgwWi9Stld6A5hDkGvCm59wFdsAc
 ZtG3IhpfKSHuKCOFv2zzQmxGhFXNmaX8xntHhCw1QIYT/8+FKr4P3dZS709mq29M6xfddk4HyCL
 y4Uc9/jvKY3cl6H9yL9zMitNsf654aP9Uuh645o6Gw2I5+uJeASiPY+FTeada2veCm3NSTSC47S
 azdWf2bpssiPmtnkku3+jNr7y1oKZ+xFVfu9NjeiIJPFSsVm7AOK2tjFNLftPbon/qQV1w==
X-Received: by 2002:a05:620a:400b:b0:7c5:3df0:48cf with SMTP id
 af79cd13be357-7c7759e7159mr1736916185a.3.1744027545925; 
 Mon, 07 Apr 2025 05:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcxlElTVX1Gi32fxrFq1kgUyTgAk+LSiRadKafdF2OU76R2+07LB5mFgUzYZUigqK5Tra7AQ==
X-Received: by 2002:a05:620a:400b:b0:7c5:3df0:48cf with SMTP id
 af79cd13be357-7c7759e7159mr1736913285a.3.1744027545642; 
 Mon, 07 Apr 2025 05:05:45 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30227e3bsm11753374f8f.100.2025.04.07.05.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 05:05:45 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 4/5] clk: stub: add qcom,glink-smd-rpm
Date: Mon,  7 Apr 2025 14:05:35 +0200
Message-Id: <20250407120536.236003-4-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: apMTwurtzDcVXBeNvDQbVSkE7vw8hK2Y
X-Proofpoint-ORIG-GUID: apMTwurtzDcVXBeNvDQbVSkE7vw8hK2Y
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f3bf9a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=UqlJzHZL04KVmTu5ItAA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070086
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

Add support for the resource power manager clocks over SMD/GLINK to be
stubbed.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 5fbbb07b7f7..09be2946bbc 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -15,6 +15,7 @@ static const struct udevice_id nop_parent_ids[] = {
 	{ .compatible = "qcom,rpm-proc" },
 	{ .compatible = "qcom,glink-rpm" },
 	{ .compatible = "qcom,rpm-sm6115" },
+	{ .compatible = "qcom,glink-smd-rpm" },
 	{ }
 };
 
-- 
2.34.1

