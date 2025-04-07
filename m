Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2283C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D8682CF8;
	Mon,  7 Apr 2025 10:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UcqrPhgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F6082CEB; Mon,  7 Apr 2025 10:19:42 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 866D582CFA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53766Zuc007596
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 08:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OH6jgkVPnko
 KjRbnf02iIxm4SQqJhNT2/25x1OD7hoA=; b=UcqrPhgGh0sdX2tx+No3dOLz4qC
 qkHvFpHJSA9McaU4ASYDxNlk29ErfUFt1vNr8wtl04D/LlUymvtyFEgJn7x5Kixg
 zYxvcD9UB0bWzNLKBZnP9tYfkBa8OmuxsVXjSufjcZQCHH+Nl4+yOSkYXUHCiwYU
 SxXJDp4W5d8HEfqT2BPPB3DN5peqhLliPvSdnxJjcL1V/DPi1FYxpeKpfqLCvRzV
 K03wYx25PEoDI11aPwyLDO1lslyQRI12E8lJ4v6Ui5fSzbjyKYFc4rdg3I9FuE6a
 Bbfrmu7SEhXSC0+3ASJr4aDIQchF0yLkcBan3fvIEgBytjZlUIDMwS1Wyhg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3bds8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:19:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c3c8f8ab79so653642285a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 01:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744013978; x=1744618778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OH6jgkVPnkoKjRbnf02iIxm4SQqJhNT2/25x1OD7hoA=;
 b=thOh4LXWlVtblLSY9e3pV+lsggzHOUXyrrf+vCRiuSMEUioinUPgI2BFJ1uOeNryWF
 EhXuKwqQAfEti/GY+yOuQRb/u07oBzoiQ8AerMXLxMeHZvwUZU9mHhVCusOJ5u/vR0bF
 8vAxHZHmwdS9donhEI7wm3WE9XReJE9MRsUK7VM2DmytbupE7fDI3PL2ryX0tUr4NNrz
 psTu4uz12V1i13cUZT4GwEErmdrObzEWkXFhWhVrkxUjmPKzreiAQD/tdSMDw8fQQgtp
 5Uea5t2GgjiC//J2cMcG8/njfEUc4BYUppIdRR7Et3u39KL5BXCdjF+z/UlM/iirpb/W
 HwiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYEh0aX1n/+upks42De4XXr3A/oIWIvFui4onibBnE3gmsj4IK0RXzNl0CwH/mpTT0wm1Flf4=@lists.denx.de
X-Gm-Message-State: AOJu0YxowJsm9aOhjZ5jMhqyoi971fTlDTHK4zfYdD0t2yb2f5m7XvX0
 1BGoLwIz7seHC//SZziYL9dIQyrcMsB68wO6jeweqXEXEjPoUUYe5jG8nMHf1Xs9q4mt5/HiEIT
 gKIKoRfCXtMgCma/aBj/HFa2+DMzoGAItN2E7BlHWFV7Tipib9efH
X-Gm-Gg: ASbGncseJ1CewZxKt/E+eS4Y6nIsFY/PYxgxzlfXxmPRRKgUMh0V2LHM1YC+heAdoAB
 5Sr+K1cfzssrGM8ea9fSYuC/inrCRRyerA7thulQGXvjutJzMU/VqH83hTeYPTDUAOsOkJK+uJU
 g58MGp5KhUnepaNdeAstbfGfk98PaJjM0MsPOd2EUYr8g1UaEWgJEUu1ugGzcA8KyEHyCqlhC/g
 A5u+VJPMzZL8LlPoQxJ51DxqxsCQ9TYygbV0LnnHt8QoJDmEwEf5TDH9xnn8K4NkfwZCV7g+hq5
 lIzImvLwV1oeX6Ynvu/hJm2XqMNO7qUInJOflNiwC5Qn/Kv3e4gmiPoZ993Ju884xKz0Rg==
X-Received: by 2002:a05:620a:2448:b0:7c5:a232:8e27 with SMTP id
 af79cd13be357-7c77dd44977mr999596485a.11.1744013978399; 
 Mon, 07 Apr 2025 01:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeeQ8I3l0OMP5Aq+W16bXCWmZ3ifBet+lRBUC5pIs/L9OBNvOFnV6eKP3DVPK66LblyD/tVw==
X-Received: by 2002:a05:620a:2448:b0:7c5:a232:8e27 with SMTP id
 af79cd13be357-7c77dd44977mr999595485a.11.1744013978103; 
 Mon, 07 Apr 2025 01:19:38 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm125815155e9.20.2025.04.07.01.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 01:19:37 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 5/7] configs: dragonboard820: enable GPIO
Date: Mon,  7 Apr 2025 10:19:25 +0200
Message-Id: <20250407081927.138915-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1R9DNqzLA9ZoiqzJDoB3MP2tD3m827iL
X-Proofpoint-ORIG-GUID: 1R9DNqzLA9ZoiqzJDoB3MP2tD3m827iL
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f38a9b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=CGipXAzhEpDgXRd6qxUA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=880 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070058
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

Configure GPIO.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 configs/dragonboard820c_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
index e29bea7deb2..b5b6bc026e8 100644
--- a/configs/dragonboard820c_defconfig
+++ b/configs/dragonboard820c_defconfig
@@ -45,4 +45,5 @@ CONFIG_PINCTRL_QCOM_APQ8096=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GPIO=y
 CONFIG_SPMI_MSM=y
-- 
2.34.1

