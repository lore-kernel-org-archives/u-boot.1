Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8B0C3ABD7
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 11:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A55082A7B;
	Tue, 13 May 2025 13:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GCHKstSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 428B282A4D; Tue, 13 May 2025 13:03:01 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC4082A33
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6plRA015454
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Q4tnm0KLqnm
 /E5CaoBEXKz5lntEKwht53bVeQuDrvxg=; b=GCHKstSPUFwwUZ6ART3zP2f9Wb0
 TjkoCltaE5SNqNUyj/+aFJDJqrdCleuFxBo4jrfB9Cr8ZlBi+pGKsoenI66qOgnJ
 gnBq6dh9vTr242ctag88Z3OynKrg/8Ivcul2CCboY+Abz3Pp2eGvltB3xwKLGDwo
 77Piu6dnnTUP7TiziDgrvWxOjO+v7cZbgLQodzoAuIoVFZgLWhlwu4VucQKTcLsD
 QWnf+/2YA3Z2ly5tmfo0tEw0A4usbO16c+hf9xLjwTeAzVnjRq5b14KP8Vt2oeDx
 18NTBZZecqjgL9rxz7G2WJsgOsOvoq29f5Fm45eINgMuL0NQpQc+XOLFy2g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hwt97g6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22e3abea7e8so57643255ad.2
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 04:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134169; x=1747738969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4tnm0KLqnm/E5CaoBEXKz5lntEKwht53bVeQuDrvxg=;
 b=e9RQ5K418sGKpw0Bu7G36zVOt7j3aSvrz3i0sI0yB51eV5O7/U8hgiwwQSfs//gj9+
 SCkMM1aae3uqFYzd2C/Xe7zHXxJLJJ8nC6OQDEGkT/EJ+m+jQVD0ccOiDjZtuig2Si0q
 MAGuGsTq6vmU1OHharMfIEek+o5etZLQRhV6l0S4ujk1KG+xUK93+MMCWjFnxT1ZAxze
 IELBGZepdxiKh/x+oYStDtNzU/q85Nd0O8X8PvIfZC6GsdXWOkKq+2ZJCo3QzOM92WZW
 8IYxxu2VeLjDWH8KPIiU6KQyemNyoNPearoF1oy6DQl3cF5zi3fJ3JIBmayGR53oUP2v
 oiRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIj8+nxfkdstCq+lbSobFzDoXKeQhR/Betb3COcPbl1yPq+E3PqBdXKaniEEC2q93C/B+ghZw=@lists.denx.de
X-Gm-Message-State: AOJu0YzPDj37gCKgd5pRru72i9ypX4ECO8ll94lK+bBzYiOlz5q/uLI0
 7eXPyBGF2rcwruUddMidCTbU3obhfY79udXc0o0WVf8c9e35GOLwgrS6hX5dhmPluMfedb/kx/J
 J9Dga2YC/UsVJBhQPF+v1+QsF1eWdMvnteow9yHl2+2PgPnBuSImc
X-Gm-Gg: ASbGncvcAwIfghG9elHbUfgR3LP64L6xWiOdd3lovsw0g0cgUhfn5OyfBSvFYdKKAJv
 N00urngWVGkPsMvTWkNuHMqGGJ1M0VA9l6v47yVzNCROkP57xIqoWMpq8j2c1wRFpvj/pRzw4cT
 liPQBtkKgVhoWmi/BWsmzgJ0AgTHsjzLqEm7ZuInY7Zga1RydmtDTzlvwbpXcrdXs1NZW3+ggxi
 QpLdE0y6KCUKQHQ9YpXP/JQqqjnwAAz+Yh3MLjxiUBIad2FWAy5nA35H0kKIng5p78Qv8V4TQnP
 4C8FIyAdmD1BnnEX+03P87tKAaOXNWxm4TSf6Z6qMy0A0ETDE8+/uvNXYTHLbfCCOUCl2VtRq5g
 U9xGI1mgccxOIVfn45869veT+NU5plp8=
X-Received: by 2002:a17:902:f393:b0:224:191d:8a87 with SMTP id
 d9443c01a7336-2315b29b684mr46446775ad.26.1747134169442; 
 Tue, 13 May 2025 04:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9vUuQkmXdbhoatF1Lo3EoRtutpSFdHbjS4TeMbvg4mVoyvCoW1obkjwDEBeL5Ed8sTMBBUw==
X-Received: by 2002:a17:902:f393:b0:224:191d:8a87 with SMTP id
 d9443c01a7336-2315b29b684mr46446485ad.26.1747134169040; 
 Tue, 13 May 2025 04:02:49 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82bfa11sm78362135ad.254.2025.05.13.04.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 04:02:47 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 4/5] qcom_defconfig: Enable QCS615 clock driver
Date: Tue, 13 May 2025 16:32:12 +0530
Message-Id: <20250513110213.330495-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
References: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNSBTYWx0ZWRfXzR02UMFakULR
 m/9ZJciPF/0CGu7odQFdqcfQXj6DtR+S1XUlklLYA4uZfTAJ/wCwF6Cyue0Uf+QYvOvaxVbmXpe
 HRhzp5zxZ8EXMggAxElANbVG9s68PP3Ce+JvT7wpJACCeb/ssPOjc0MBS5lZPjiJcyXQ5F4Gz6I
 l+AwrSR5Asz9440FNxX1PEjjBMlNpW32fxHRsgpreVbwMAsAJKYMa7kPn1b6+MA3LWBZ3eefxg+
 ZbjwgOXDAVBc3lyAuW4BNeKYKoFcSbAQqpnn5NiJmqZ0bdXVQcg7JLbI+jCeh3berA9GCgATz+a
 7XmMOnHjQLS4DnF4u+0kQAfC8bQLHD8xfLFyxzyY9lKe0FCVBnsBXODRdigrjud+cHLGs44+VBK
 7LWNpWLiEle6LOnTyPMWGV2/EYHrideFBLrZqKKUvbdIH8eVkX4MMkf/mG6PC4t9RtYUlMN3
X-Proofpoint-ORIG-GUID: 3qjIpMYadUV_aXSiBOHEbelTnZ5vIKvm
X-Proofpoint-GUID: 3qjIpMYadUV_aXSiBOHEbelTnZ5vIKvm
X-Authority-Analysis: v=2.4 cv=a58w9VSF c=1 sm=1 tr=0 ts=682326e0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=Z22XvwZFbGG9hQITJ7MA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=774 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130105
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

Enable the QCS615 clock driver in Qualcomm defconfig.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da0..8510828824f 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -51,6 +51,7 @@ CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
+CONFIG_CLK_QCOM_QCS615=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
-- 
2.34.1

