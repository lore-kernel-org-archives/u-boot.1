Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A01E6749B
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B909F83EE2;
	Mon, 22 Dec 2025 12:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZPF8HyOw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aeXxs7qV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E879A83EE2; Mon, 22 Dec 2025 12:49:22 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE00B83FD9
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BMBagR21200900
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=O9EfnF3Aj7f
 j25D+hNeT3DRZlQfpdp4NFZkEBUIppN8=; b=ZPF8HyOwHB/Icu+mLT141s5Wxnm
 V7bz7NPZgzaGhq1C4ZrsNfdtK1EPBYy8izkpMnUJQ311TwCy/1Pq5COWDzvqIVXj
 7oW+iPBPa59A6L2UWDwmT4sgAfBKo5NfkvxqmtTcqycgmaXNTHQebq3LBvvMqfAJ
 i+ZW+HxKUeSh1LuqJctEyzGRs3bzOWx7ERO1oC/vI36f8lrJ6wT9hUD8rIdGlTUv
 EqiR6/1Vu5jY85UliqZYnMg8xICA/O8nSXMdk+b+knTmhSwO3V9MgNAHKdo5KLln
 lu1kwqTH+r5sWBQx/Hw6CvADe9m4KoUorw8KxV7FOkDzQbabhE9LDwCkJCQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b758y00wm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:49:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a089575ab3so50428435ad.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 03:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766404157; x=1767008957; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9EfnF3Aj7fj25D+hNeT3DRZlQfpdp4NFZkEBUIppN8=;
 b=aeXxs7qV7indPeKCt8+wsOkojcHwvQTc531W0gFU92aPucP7eToxxVPlx5+h252mdQ
 z33cUL1MdrE238mvJi/Hsbnn7fHPQQVaKhyFUUEXBaUn+r640aXjMbNbRz2hGk4T0FzJ
 2314QxPI68hWbPdD3pUPhzCh6ZcUzeG/s3MzIVtO1p+3Reo4pKn+zVOlWLcrcJ3J3XNQ
 nrC+FpXrYb1UjhyuIeDNhyEBXWOxHdHrQtxYX2XVBxGptK+BKUuQhknfSZO4HHsgFndR
 Ai8oYNdplYVrfCQGPdcpuuhtcGGCJKNz8HZuA8mWnq4GNoN63tIssqjLaos3CH77g7rO
 VwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766404157; x=1767008957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O9EfnF3Aj7fj25D+hNeT3DRZlQfpdp4NFZkEBUIppN8=;
 b=nn/OzqgdO6P/5eTSpeC76SmcEwK5VpGmVhvWaSv9uMhS3GpOEQWUisAzPyaNm/kdil
 JXwo61Fe0XXgLNypDXgftsKYhtDI7AR5rYqZbDq1lpxx36Z9/Q+amgVh8SXKyhdxp4eV
 gwSp7j7j+De9mCVlEyWeGNK6dkbuOzUq5ZWFAxWh/WERxGyxPlMBYv6A6hj/NEMJWGCb
 DXUlHvgb6230e7NHPRVtTjm6vlmz0bNAtbNd4/BoTwu8egPA/QEsb2uJCndhWNG8zVAw
 SbVK6bKUBGwk5yOlOo+yvSaP5F5ejKU87ZfyP+PwIGNTJyvTKDQ/tpoFWQvciHYTUyux
 BZXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSTassXUt7zmWSqenhTXKQ6DavmknjznZYQ95oq+uaY2whfY8QkpbLmlw6tN8fRWwU4/DGq2w=@lists.denx.de
X-Gm-Message-State: AOJu0YzVw4HDBjRAu5gd+BRTDUdBVGtRvbLGwNggx2Klm0DgQ+8k9M5n
 s0AgLXeHx43AnvuGdtoWj3kRbJrMO1p9IsBdNP2KQk/LKt4znFRdQrj/ScTOcRJiNCBHaVb9puI
 +4nBYgQBvzsRsbLTYw+i3Pp1vnCRgJ+Ojp+BvVgml+F8LDEoQ38iGaYPkqsnX2Pvu
X-Gm-Gg: AY/fxX5gjKKTx0MKDefcuaVpf+auDwDYSyD3vG15CiTa4D/78PXc5BLXs/xW+G4mEIs
 QCOtyGR7B/TOrb6BqcK5S+uyLFM904ZnZp488IAlETaGrrGQa+bZBidoWgTaZbrMAZoLdf0YUK9
 4Q0iwLNylp548iHPiwKSDk//VJ2WkCXevTm8KYgkx9IImiU5eZCWnGls3VFGlqkyBo1SQ6zMvHK
 g8qe4lgFn00tOYnytPw8zn/QdPbWIFNdy7VYsEHGJHU4dxdRj69sjNZDnIsjDfID4vBAyUw9frT
 dAZoQ/NBSf0fCZCMV8GZJepZYl2S7+SDOvFU8HbNUWpFtguTsJbHqoTHwh9g7WTvFQfAmwmeM4J
 0Tsaw7L8+XAvwqMugkXaqGjLEl4WkWm1kKP1GrDyKngnHOtMFDH4spGQC0dsouvILpeK+gA8uhs
 5zW9ALw95Ao+YdiSY8H1Kl50x3T0tL
X-Received: by 2002:a17:902:e849:b0:2a2:bff6:42ef with SMTP id
 d9443c01a7336-2a2f2202e4cmr130231735ad.7.1766404157363; 
 Mon, 22 Dec 2025 03:49:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8GlWhrKw4PFwD4QBvL2OL/QiGk+tiQBOPTwVFFiuF5oJb8pmC6Gwe/C5+7XwUDLfLeKKulw==
X-Received: by 2002:a17:902:e849:b0:2a2:bff6:42ef with SMTP id
 d9443c01a7336-2a2f2202e4cmr130231545ad.7.1766404156884; 
 Mon, 22 Dec 2025 03:49:16 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d658sm94875935ad.78.2025.12.22.03.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 03:49:16 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v7 4/4] configs: qcom: Add QCOM_POWER_DOMAIN config
Date: Mon, 22 Dec 2025 17:18:23 +0530
Message-Id: <20251222114823.2146775-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
References: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TOdIilla c=1 sm=1 tr=0 ts=6949303e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=sbwBSw1Q_kG3G2zi_HwA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3mv-I_Qs2X37AAuxRgfpvk0N7-_HAaGY
X-Proofpoint-GUID: 3mv-I_Qs2X37AAuxRgfpvk0N7-_HAaGY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwNiBTYWx0ZWRfX1sXlPgZO2+Wm
 IxU3ShG0mmb7SZ7kZukvQvF4axMjIl+WfBV2FerUX6r+C45c8TW3o29xbGELTUr1+Ut09JMi0Ix
 qzbvIQ2goXTb43NPB6PlOWnV1QLW6Pl+lzPy4PvnxJet/X50cG6YfVgRVSHz7B4foaddh5XwSw3
 HeW0gqpA264MRhFiwXnPgAr1d2aRhxNTuLaZIPMB6E5polA/1t8QzBd1FIn8hpXINUePWr3W2/r
 zsuNQhGQ614z9FLPalWYzQmCW7IPY8cvEsCwBs1ebOcVOxPHB/y4GuQkGWh6sUoTXlkPpA26KpA
 ZmEI0dFgLF7JQ2VOoXFyFo+mJbjM3Lfb1SKgmbgOkK8lk0Xuu5lKwlMagl0le3Zjyem1jXhTJYU
 WCK63f8R2h9898KgeLtYSiZSV7DvXD4bN0YQOnbq3a+987ozjJt5Y/98771mAyDiPFKZzYghipY
 X8aUwASspjeFp0NC05Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220106
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

Enable QCOM_POWER_DOMAIN config for qualcomm devices

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v7:
- No changes to this patch in v7

v6:
- No changes to this patch in v6

v5:
- No changes to this patch in v5

v4:
- No changes to this patch in v4

v3:
- Removed OF_LIVE_SA8775P config, since there is no SA8775p specific fixups are done

v2:
- No changes to this patch in v2
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e1ae0d946ee..19b63d6f1ca 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -122,6 +122,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_POWER_DOMAIN=y
 CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
-- 
2.34.1

