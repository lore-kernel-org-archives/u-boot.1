Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486BBCF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECAB283FFF;
	Wed, 19 Nov 2025 16:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZO0qw/ha";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IBGBKdcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9547084002; Wed, 19 Nov 2025 16:23:23 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581C083F7D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJ7aC8X718640
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=117Kc8R46ThVlFwXHATqnyFweYHtrwAmFZS
 0Hbe9XGY=; b=ZO0qw/ha+NSH7zwsVZAKj7hajkEytJZSHV3naPL7XNeE9lTzlG2
 jR4z+Dw8wfnr4FE+e09sL4pZpDTmihBRXO9+ZjKmasNPv5r+RwxJ9fq5Oe7oe3Jy
 b/jTyYhG3zPj8tsqurOSUrD1dMq+WSZLE96mMHVayuT+Y6s+XI3QUSm5+JTttyGF
 61NNAOzdeOzLh6Cdmw2fN0DEHclIBqXlZ98LvVj3x+bD6R6Tn/BlpQ5p8AtsRtnn
 Db+N6WWBVsMD1LHGH5XE5IhOK4CmyhLXc85RhYNNhF3IwSvj//D+FFn75t/JQLDD
 rcjpBvy347H+H8LCsMlHfQdKflRoXPdLjuQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah9n0sbft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:23:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7a99a5f77e0so13818326b3a.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763565799; x=1764170599; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=117Kc8R46ThVlFwXHATqnyFweYHtrwAmFZS0Hbe9XGY=;
 b=IBGBKdcuXUZIbnN7MhbuUVmgQ9jug7JLJkbigiwONeIorB3PkxK5gAO6OWRyzSw6ci
 VKHn2Sm0o27vO+0Da0TvFmjInx8cKuRK5796b0RRghrZCjZuYJV5Lz614Ha1T7ksK28X
 1jGAJsIM6Wc6hJ8jstlgpNTuLLlPJmJ6qaw/zBXly+fh6aOK6X12UxRCA7efWxiW2oGW
 Upp4ruSnaA0CCNdET+QTGZQCIoMal+Phhxs/8bouPQDeU7g981fJqkOuQV2N9xkZ5arE
 eWLa+GZYDtqnnRgl9TX9hhzk0MLO9xsCtWyfJqQzNQ2ZL5yrVBn1Y/c71s4bNIhfzEAR
 Gk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565799; x=1764170599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=117Kc8R46ThVlFwXHATqnyFweYHtrwAmFZS0Hbe9XGY=;
 b=ZhlTyDsWD+80yuEYCv+JHQBYn5S+e2U5kJQsJmv7nXTC2os45aW2tf5/ImIpTlQluB
 zmA0qhfeVv7/DS/b3JBx5gs7X5kKpGaZmIFDjQAtIzhsnemMlnHicuiAJFTcbwHsWb9C
 jHZnsN3uPdQK8L7xwS6PLX+vpu4oxazTcx6LCRvE3DV/0olfmP723IG4xf5TVtPdoM7j
 wpggk19j2N+vWIsdy3ODuz89dSSxkR0Wd4cur5ZKGRVRzvbVHhCxlkV+lC0eW4INY//2
 v9UcJcYizou5qipVb0B5yCS1VMcN1/+7ygY8EZ1Imz7ToxMIiDQ69aoB2Jyjxu00203j
 f0mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHOR7PpzsLQHWc8jRp7ogeOc1vlPNEfQH0bRdMYIGcfX+18NLtxCJEVUf0ann4HsL1Z8Tgzwk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxrnh2gSqP3TEGohWN9PzlEcoBfN0ljDLCIyDJtZ74aGGwBs+T4
 vA6vHRYjBe8ZYLe7riySdMlqrZ8yiAkQW5wPg7jpknrW7mpOdhSSwZRQ8CEJtlTFV5GyjrIj2zb
 vPrhRc3JJdZCAdk583Qpbi78OW7DMS9Os6qE4Ue9vi8icdAsGVM4QOtIM
X-Gm-Gg: ASbGncsPD9DL+y40m70HTatXeNCSY4LSlwW1pVpZSVODmYv9VYDgTDbVAGRzLh+Y/TI
 ijC4qbT47XvcEwMoGy9AEJFNh2QOXE/i1yT5MqQ/BKjGEzyr9n7hPXZ5kDv0tQ1pkTkm6x9sjzD
 EakNnoXt+HLdc6bu6zRNvodqXfzP6yXSPtWEIHdWtFUVe30ynRj+eaMgig8UnUHZKQjKxMiCx8T
 wgAj0dRhKxeyBSbfZEF3htC/V/qL6BXa+mG1o3xiIWL73t29FhQfChAPNMZycYNqkDCEKAa4zmq
 Io4i3WFvxibQ1lFZfVASQy7qgv7V+ZWxDiknx8byj28vTomjtfSS8spi8hnOLYxsw9sSvqGVVMz
 Iz2jTDoOy/OMAk3Pbw+SbSWvemayfwvAPxEmvdRnjwJlcrtQSsYEzoWeipVPj8WTSIE2VRSb9hf
 vv7tYIdjgdjBsDwLOyj3VPKcW4G48gdh27BdKQhA==
X-Received: by 2002:a05:6a00:2d87:b0:7b8:6a99:f795 with SMTP id
 d2e1a72fcca58-7ba3c2725a3mr28488785b3a.32.1763565798757; 
 Wed, 19 Nov 2025 07:23:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqfaL6kFfCnvKyuEP5dCkUk5jFXBXUW81+V/xu2ipxZpx3jEU8cY3l80C+MctLfG44I6QWuQ==
X-Received: by 2002:a05:6a00:2d87:b0:7b8:6a99:f795 with SMTP id
 d2e1a72fcca58-7ba3c2725a3mr28488727b3a.32.1763565798226; 
 Wed, 19 Nov 2025 07:23:18 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b9250d195fsm19940699b3a.18.2025.11.19.07.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 07:23:17 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] configs: qcom_qcs615: Correct debug UART clock frequency
Date: Wed, 19 Nov 2025 20:53:12 +0530
Message-Id: <20251119152312.4175482-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMyBTYWx0ZWRfX1oZDvDipNFwQ
 ktu2mv41nTMVAfJqq4dvNQi6ZPFxPnNIZ2xnVSh04Xb3njTkzgqSqwnrATOGVy6ccWQQE7HXQyU
 /fHn7TfEjWZhoGK7SvMSeMmWq+ck7LnBUtYqFxZ+9vmghAMq1HqaZ3aqzzOh7zbXDN8TijiYI64
 G8bbzFPT3fHdCFjrgHtnsd5B3BHF4TCCoHD4DeMPr9Y5enO4zaO53f9hsg+Bi//9mb7X/akzgwJ
 1qfMng1Ua7IUSWDgnxcr3m2bT2hPVmP5tUpPjiahX0F4qBINHJOq6o3Cc52t8zUGsSZ6keDZq56
 p60/JP58K7OWyFejwgklruwWfPzahMxnDK6BR2wR6Y+WiwnxKAvBIBiBmsEKLb1fSiXf8FjeggA
 k6KPquMQowxW3GsS2YtDA5wUERBNmA==
X-Proofpoint-GUID: 2j5mCOwEseULYH4E1_yxr4wp4AZi2kl4
X-Authority-Analysis: v=2.4 cv=QZlrf8bv c=1 sm=1 tr=0 ts=691de0e7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=yPvp4niUqsDbSxo28C4A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 2j5mCOwEseULYH4E1_yxr4wp4AZi2kl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190123
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

Adjust the debug UART clock frequency from 14745600 Hz to 7372800 Hz
for the QCS615 platform. This correction ensures proper UART
communication timing and resolves baud rate miscalculations
that affects early boot console output.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 2468267b955..f0362aa6976 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -12,7 +12,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_BASE=0x880000
 CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_DEBUG_UART_CLOCK=7372800
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs615-ride"
 
-- 
2.34.1

