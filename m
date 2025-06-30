Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC58C83000
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 07:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B1C82EC6;
	Mon, 30 Jun 2025 09:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M1QI8vA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523B782E5A; Mon, 30 Jun 2025 09:01:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30FE81E13
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TAsCr7012874
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KeWRXaRWxqK
 136DBI5xlnSei4e8xC5WKI1fcg9eIlm8=; b=M1QI8vA5rLNnB4J13ZB1FIW8oyp
 mtb1JYf4ELTa0i1K2bPWCVGSIeJNIhgUHZkJLovq9oyZBS8uDtTWK6W9RG0P1ytP
 BhTrXP1RNn5rN7Cqlg86+pTOpmE8OPoRCayO/gpZNghIXpXzhDAwCAkoUpnPKu/Q
 6Ay6cb2kh6T1NllwWYxC8n34ZZOuE8Z/RX0Ph2HmNEZuV+BG8GKxJwH6J7yKTP5y
 2axFN5376jm/mETIHQImQPHEGdZ0PhF3KxW3TxyS/95YMuSVqecYF+tSfhF+kSq5
 OOINGoNVs/z3MWKMbyHwPd/rmjcdakmexR8sVDxZcSqkwK/Qnmi/4pDcGWg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pckkyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:00:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b31f4a9f67cso2632441a12.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 00:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751266849; x=1751871649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeWRXaRWxqK136DBI5xlnSei4e8xC5WKI1fcg9eIlm8=;
 b=KHu4KWoxqcJB51rhrEhZD/XMz+rsbdmuH3b6g0GlcKMNfJXG2TJEWgBZ/182yQ8WpD
 ZcYiGfzbV9OR3gdjsGfWzgukSzo9yoU2hdLk8UjP5M738JQZktNE7K8k5LFGXI9dImkO
 1M443T2HBAuE0AZvCc5wDXkWA01dSkxiYagX2ZwHtWHXWOQZZjbIwoB90iiu33j0jNRK
 w1vZtxdbFBbKLOeWRaWsI0bdrwiWExchM4qk5tI7AA8vxjaGVaAedqMC5TlMAlVcc6jy
 7Tlmpe5+0ZwwNSo1lScORUH3ufPXpQrj8u3XVIm2+SfN7vM0pAnq00vMX2qn9GrO5IH2
 8C+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgKDGAyF/MXiW1yCmBldgKnB0NmDniFWrxSOpDB7wi14moN8LrlHnaIR1QXdcZk+juc8iSYns=@lists.denx.de
X-Gm-Message-State: AOJu0YxZrBTD/+/iuSYBnv6sTZdYOA7HvfmlIptXrZyWS8jHMORGBmEU
 joVeGXZERxdM0ilUo6utTL0JvZmLNq3nnGdDdWInN2GqHH/GUKWsclYC7vFgid6+IOv5C+9pL23
 c9qaLZ9roelVzwwct28Da+ZHqqs9xmAFRe4mlMmGKgwSSod5pNxmY49oy
X-Gm-Gg: ASbGncvh4ey+fB2VkKh2GObyoKdCkBOnjYOPNr9C+uuVd8PPdxHv6QLezR215uwx0Pl
 yZdv8vJsCPPMhQYnEEIv7dHC4yyiskuTC+GPISmLHsyjEjaYTvn4XwrgVEtkOsl03ZfcpXcyafx
 z7z+HX0TP8C4rAPdcdTwpzTyoQqzDsb8DKNw4fy5WxGUDEJ3TtDQRl1m330YYGXGD8dpoyj/IaS
 pLHLAmWrA4EwbBtqP8B6EcbSMlvigBbfcpkN0YEMekzquPBIQWsrjk2C1qnAEFDqztLz8EMLljC
 Z0BL4fPA4cQ+bWWQ0TArN+stCmffeUVDc+96/LNNLxJmFOAa09hwk1SgQ/cmgUGRRAdSBCNVHMr
 sTmolQx4q/+NpoADHWiQQ1/CD6i1Lae/ZQwGAwO1oDtCMyTWawks=
X-Received: by 2002:a05:6a20:c704:b0:220:63bd:2bdb with SMTP id
 adf61e73a8af0-220a16ca7famr20225285637.40.1751266848955; 
 Mon, 30 Jun 2025 00:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb7G0JYNr9OSzgvYl7hZyqxXHxCa095tylf90wHScEr6+oEyBRo0iX1FFAmxUYDAAxfjbFHg==
X-Received: by 2002:a05:6a20:c704:b0:220:63bd:2bdb with SMTP id
 adf61e73a8af0-220a16ca7famr20225218637.40.1751266848549; 
 Mon, 30 Jun 2025 00:00:48 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af540b443sm8383634b3a.15.2025.06.30.00.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 00:00:48 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/2] configs: Rename qcs9100_defconfig to
 qcom_qcs9100_defconfig
Date: Mon, 30 Jun 2025 12:30:39 +0530
Message-Id: <20250630070040.734486-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630070040.734486-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250630070040.734486-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D5F-zwrL5Bnl9mssmXFxwJBMeack4n4E
X-Proofpoint-ORIG-GUID: D5F-zwrL5Bnl9mssmXFxwJBMeack4n4E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1NyBTYWx0ZWRfX7c+smLuTHg+1
 M6X9B896lKz8g+BhrBj6FzWZ43FUvy0kjGpwyJ1NNqW4MUNVJVsi2VtR8MlolYeF3e/8tqInI5R
 znZggF5r8uAHXjJU4CKr3oB3MaZyJm4pAZUPAbez57AMeGhzFGXLtp8rQ7f9gVZMQLX3FAlwpf9
 yZznqLDkmsDDnBG+hzezyPoWVcRc4q4m9/Q0T+IifXP7Bc9rhEiBqrZAf22H4XZyl8sZvejwoUA
 TRyjH6TSri72QkMIwhOzWXmgwdZ3Jrzu2npl1GU7hW9Z7G1QbTn2/Ek2zeDNvJdnG10NDvg8TF8
 E0Kc8mq8qyf+WzU2GOnJ6c2CLu08mLNLLzFP/hTSUX8ebq4Q6sq7glAtLIsi2ITnpeafZ9o+of5
 vVbpHOgGPRFFwKWshhNTME3rlr7a9XgWHZgF3HRcJ8PzC6I9WM/G3SjeK1dxDbHKM4idELqP
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=68623621 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=FJz27EJTjh5BYeropFsA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=788 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300057
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

To align with the naming convention used for Qualcomm platforms in
U-Boot, renamed the defconfig file from qcs9100_defconfig to
qcom_qcs9100_defconfig.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/{qcs9100_defconfig => qcom_qcs9100_defconfig} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename configs/{qcs9100_defconfig => qcom_qcs9100_defconfig} (100%)

diff --git a/configs/qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
similarity index 100%
rename from configs/qcs9100_defconfig
rename to configs/qcom_qcs9100_defconfig
-- 
2.34.1

