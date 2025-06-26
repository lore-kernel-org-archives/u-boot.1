Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A90C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 11:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E36F82E86;
	Thu, 26 Jun 2025 13:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XFmoVSCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E682A82E40; Thu, 26 Jun 2025 13:25:28 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F382682E17
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9ZxFx029523
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SQpXBmHaT09
 P6b3moNyYlHp0l7MTImuDlI3KcyRVnbA=; b=XFmoVSCVekUMOYQwpq0lLds3JGq
 VczBUVf74zsYcoDugpnCkwxEk0n9L44QisQMNMtZPUTnXm/qTbpRloPzaZf8lI9N
 8eC29gPN0OVsPPxzaM8pU8QZUz/lszDAjaNCtw1XefQy/KU411Z682JQH7J5D8Pa
 nWIOn4kgwb9xB/Rdsf/AfdLJtVxx7P1MmWwIEa7lvtDRD9A4OAhiM0mGPyKX4156
 N3cDo4R0vHOj7ePWU6R8i4TOpTIF6yOR+BZdD8DdSrJf9SnvHJTyezxeyi14r8Zo
 ABMOfnqzRJFDdOowvqnMJ9jEDaRJ1L4f1Z8fDXbBWa89AApOcK0wYCEv/8Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4vcet-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-234fedd3e51so9736225ad.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 04:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750937117; x=1751541917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQpXBmHaT09P6b3moNyYlHp0l7MTImuDlI3KcyRVnbA=;
 b=tu5u6N5cCgNaghv5//gtQen/xDk8Q67lN4O700z6UqEq8k0+AWYuRhAELZVrmx/DyB
 TSYARofrxyhoEnvo9561TZnie1D0YT12sCunJT3lRnvvMwkQkw7RHb3uIAZz6QF+U+Xm
 8po7/OR5C75vnGg05O+0BKUHyUqM59iihXMevSvcoUILEecycnuVvMUc31IjHInXyfMA
 t3MxsFXrWFTE6MTTsGegnXo3M4cRi0GqiFi8HwBNtaeOOXzuGKgC/k4cz/Z9SY7i1V9X
 lCxVP+7r/LQXCntAK7Euya2DDQmhWe816fzX1UPRoBqIgdRMk3XInPs3Kz0Ul1uD8ldL
 uVsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXdyvypCwfAhhIROKfQpxNXjxds1HPkpgPXSEHdfftI4pahawhRgFhfk+2trKdTs1kz8ppGKU=@lists.denx.de
X-Gm-Message-State: AOJu0YwoXttY9lBVfW0eHS0q5WyuHVFIkbDowVqbrF4gal3fVm3zZcg6
 eX8Yg0MClmB0e3USfOtuZTmO6YhYW4n15imROrqy+nEK74m6kubrrmNVGZ4MWoObmsuSOCukYfP
 5ZDbzBQu+iXSTC6n3QOqIidc+Mk7BFqyFYYafsbc/yxWO2NlUArxi1pau
X-Gm-Gg: ASbGnctXnqcUL9/knQSZV/HiACA+KO6EGNCNjFWSd+RGM4V8jnoO3mZac0AXVdJaQSk
 96JXC+xvkMDTlzU6f6jXVDntgp26vTJ+7Y/0N+EPF6H0km8s2gzeGAMQjXfiawpL9J2BVwAth9r
 J68TH4yP8rIiyX0RwLSTycTpO3HQ9SSKvM9BuqNwO5L3ISxLUVrBezTYTL8AbHq3bDkbb+FDM6c
 ZtZ/cnhMKWYVEkZGNMjeGa+0lVQb/kcJJEl5hpJLQpa6AZvoAmGtECj0PlomDz7z6agiBBNWQ/X
 HEQd9ilibz9xJH4Kawe3E1cg50RgOaLzrnW9QfXsrruxbmvpUs7fZf8u1X476yp2QDBvSt0WPnY
 Y7VhBH4evkCvUGSYY/ebs1eFEmFc0NugL42cNndju/Q==
X-Received: by 2002:a17:902:e88a:b0:236:9726:7261 with SMTP id
 d9443c01a7336-2382404d970mr102226535ad.39.1750937117451; 
 Thu, 26 Jun 2025 04:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxpmdGScCfqbmjOKIH6iioaSoteZHuGaSQJITAkwXc+Tznv0eySeGh26ACGGAKGJPIPVjwjA==
X-Received: by 2002:a17:902:e88a:b0:236:9726:7261 with SMTP id
 d9443c01a7336-2382404d970mr102226125ad.39.1750937117031; 
 Thu, 26 Jun 2025 04:25:17 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d867b438sm154528185ad.176.2025.06.26.04.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 04:25:16 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, me@samcday.com, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, sjg@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 4/4] configs: qcom: Add OF_LIVE_SA8775P & QCOM_POWER_DOMAIN
 config
Date: Thu, 26 Jun 2025 16:54:41 +0530
Message-Id: <20250626112441.143064-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
References: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685d2e21 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=uH0TRCUCYLZtirlkuZ4A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: a0vshgFKcG8r0oXsyyfdIxcItLgu8rKC
X-Proofpoint-ORIG-GUID: a0vshgFKcG8r0oXsyyfdIxcItLgu8rKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5NiBTYWx0ZWRfXzEsfgNmlDCLi
 OGtYNwaANJRa/c1hAxgrivmquhsY4HhCSWliea2rYcclEfxp2f7sWu4kXUkyWTdaoNKxzj07NVm
 FAZ2w+TNiOWKWUAKg72cV9OG6lu5reZs1gVqOAjSYIRxcmhjKOoFCE7rNCMgzP6ke/AGpDy3+zp
 MIpT9HdR6W3c7eBzmhO/Bpg40y+qU2wALWWnHxDQ/+E/btl6epI+m3wXV+MiFo3BnAhDGMWV134
 3GR0de1GR43782qESWxNVDRVWdX5UCp7hs/yZmYyQ+gwGfRyYDWWW+x6NXF63HU+fNTFHb39RKy
 tl6Lxw8MMt51OcDUe0Pm8wJwpuzSGF0hrBC+rtGr+I2k/2A+Q8KXEEg5sV+0LGPRMfk/DmMIdGt
 AlaOHJYABG42IwEnxD7nnWKZHBjZmXigPeMvCABbXsdWokI+/gjglajWskWpKmnOj/Vi54dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=893
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260096
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

Enable QCOM_POWER_DOMAIN & OF_LIVE_SA8775P config for qcs9100

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig    | 1 +
 configs/qcs9100_defconfig | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da0..f7780c06454 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -123,6 +123,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_POWER_DOMAIN=y
 CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 10ff4d25398..19bc1cab0e3 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -11,6 +11,8 @@ CONFIG_DEBUG_UART_BASE=0xA8C000
 CONFIG_DEBUG_UART_MSM_GENI=y
 CONFIG_DEBUG_UART_CLOCK=14745600
 
+CONFIG_OF_LIVE_SA8775P=y
+
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
-- 
2.34.1

