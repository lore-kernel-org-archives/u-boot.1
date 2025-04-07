Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9CCC3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B3782E86;
	Mon,  7 Apr 2025 14:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfF1T+OG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A10A82E22; Mon,  7 Apr 2025 14:05:51 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48CDE82BCD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378do9p017418
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 12:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FzLxSUWNtiF
 ENImywzkY+3dLPZQzfBi8X6fmvdXLE6g=; b=BfF1T+OGkFmlAD0qei2HT71ReLj
 Qc3GRNdrTOhdoWbNS/7NEiuJ6v30TfjA2yujmMD5AgA2cyS/Ea5MNQrmt6nuQF2F
 VgictATJ1u1oAIliSsTdFaoz9Dw2e7e8atyHvoMXuN6T/nZ4Z20B6iCeEQ49wSwx
 0jdSAvKuBZLIZUnQXo0iPZFw3LfdhKZVxpWKw63SKqN5h1avPmJ3v2yxGp01YVPO
 xDUEEf+EIUsWHTQjMbVRw+x73i6JFcvNZb+e7TUswcY6Hf3QwgmPDUpzH8+v04Rz
 3Zp1Yyf/IGt3BxltzcFKOuaMEcO3MRCltZVXBnlwxDqsohG2jqUPEyp++xQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3c3qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:05:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5c82c6d72so783282785a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 05:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027547; x=1744632347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzLxSUWNtiFENImywzkY+3dLPZQzfBi8X6fmvdXLE6g=;
 b=FbIKQO+4XJisRdNLqzFYT0tcsYo6+264fl8we3WIqNdyjYZzmBe1Uz/8ylWn5a4lCE
 BMjalolCyrjBQLPMJIi8LPqqqJOAzdDDQinbIR0c63xaxNo6J3dLFTioXUcWloYagyDm
 9CdPjJ+9aR9bkTAeTKt7buJBUwL9YNrLZLGrL+WDDBqoz0kjisIqr3OEMTFKpFFUwhgw
 vVT6vkcnC3q0TaSebWjFx8bADLSH7nwPaV4+9hl2eBakfQYdBa1vzkKc7DA2vKfWYEin
 ytCvjbBGAgafPVWZBL1jzQHe4Zz91pqLFhQNzGjuATinpSc4M0TzRcESVucucaR87DZd
 yUEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6sxlQz476h4IFEbGhz5nJrK6kcKJBXkYwvCh1WOnWv3cz2V91Xe/0oi6y3gkjLJcbF5q2yRo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0LHCkDuXAKKn9gt/hKFZQuWLSDxuGCs+TbxVgmvb75RiE1Qxt
 faFrhOQ3unyNg8irLB5zNpzhqVGJzhDgNAeSuq6o6oC8o15fJaDM/J+IQGk+tuDlvFiTZpq6iIO
 N6J6DiYhQpsr48yhUNmptD4qv4LCpga2F/L27a4wIuZrpyf4QQDQ4
X-Gm-Gg: ASbGnctVWDXaknrlYMGD82O2kse8qmQXgztDCOBX39DmRjptomJk0FKPSYiDbCAP2TL
 /lGd5DgqPcZ/HHvhlUGZ4GgYoZdxtkBYjiP8ofK676b7ktlfX0NE7DTnNiBCpH385hYTNMTxWz7
 ihViG4btgtXuTSd//yepOjuzU9dUz9tBlne++teVwawVWDoa9SBHQEQ/fmr5MnDA/8oo9c3Fwtq
 daL0EEhD3Es6rv7rWJ6/qDrXZr/P0MKbKxGd+8fZ2h5idAITNYBGckV2980C22QW9ctz5NxhJmN
 P4HB1UTu3NZMeO9Q4VmVeGBhWXyNREvO3aFzEujnWAAgZ4OkBgOiko7nEgj9yUHcUGKstg==
X-Received: by 2002:a05:620a:8404:b0:7c7:7bd0:916 with SMTP id
 af79cd13be357-7c77bd00db3mr1308936785a.56.1744027547109; 
 Mon, 07 Apr 2025 05:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEllw74PCv1RleBh5yaenHPG0GtztCoiU8pe+2jiDP+nfbdlRmV7Q+dpzXqyClNHbBLjJ8ZDw==
X-Received: by 2002:a05:620a:8404:b0:7c7:7bd0:916 with SMTP id
 af79cd13be357-7c77bd00db3mr1308933285a.56.1744027546764; 
 Mon, 07 Apr 2025 05:05:46 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30227e3bsm11753374f8f.100.2025.04.07.05.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 05:05:46 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 5/5] configs: dragonboard820: updates
Date: Mon,  7 Apr 2025 14:05:36 +0200
Message-Id: <20250407120536.236003-5-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nTKCAH46j9z3iWEWcWaUpdMK3UH4De2M
X-Proofpoint-ORIG-GUID: nTKCAH46j9z3iWEWcWaUpdMK3UH4De2M
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f3bf9b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XlkOo350nRwr8vCprBUA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=963 lowpriorityscore=0 spamscore=0
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

Configure GPIO and CLK_STUBS

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/dragonboard820c_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
index e29bea7deb2..2a5b7212f74 100644
--- a/configs/dragonboard820c_defconfig
+++ b/configs/dragonboard820c_defconfig
@@ -45,4 +45,6 @@ CONFIG_PINCTRL_QCOM_APQ8096=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GPIO=y
 CONFIG_SPMI_MSM=y
+CONFIG_CLK_STUB=y
-- 
2.34.1

