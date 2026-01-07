Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B4BCFD65A
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 15:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C5583A2D;
	Wed,  7 Jan 2026 16:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xwz8i1Th";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DotNxV/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9384583A2D; Wed,  7 Jan 2026 16:48:52 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C11383A2D
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6079cCpA2877688
 for <u-boot@lists.denx.de>; Wed, 7 Jan 2026 15:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GnwayMyswWO
 vAL8SNBz7rMyNl7EtmQruCGq08wSmYTo=; b=Xwz8i1ThtFUK+kLkt6MHKdz5xkU
 LUrS/HkC5ZwpGkO8WQMMlAp6Eo1iU/kVk3/MJ3AIGYxtcgY5CH2Ay8kkX8OVanUo
 GtMO/UqMDx2BNlvtejc/Yn7fD6Ek+2TWPKXnoNMhYLQtoVq5yVTNxSSlEB7mIIf5
 5qpwbV4KXaey/HWsXgN7L/Iw8omkHnplkI2zU58/kBQ2gKN2/O//ZgupBYiZg2UQ
 Vo7/LUZmf7lgfjegzgat7dlT8t5cFGC5Ao//2+HcMMIXuBdBF4X5BAtT3zy8jHL5
 hsIECKfE6TDHx3gNqt574JFGUaOUndjw0X90up1WaHyJeEaYv1LntGscrKQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn1cs3dq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 15:48:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a0e952f153so56372465ad.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767800928; x=1768405728; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GnwayMyswWOvAL8SNBz7rMyNl7EtmQruCGq08wSmYTo=;
 b=DotNxV/6xlZmadJO5dMMqQt3XdJBj3LhMnD5PXsoxdW4YFUC3tvtAq/95x3UkkCB5t
 KrTugTySIqz1eNK0MgU86KD40XfUyIROzOih85S146FLiNomblNL5nUE85zikC7MVGAe
 sICpii95gjxiwyrpO/p/093qkYCH4Dco3CjPtjSKVcJAOY8DRNtqHurafSIr0Gpq7evL
 vjoD5CIz/a8UejKbDeP++A0L8Po4Htw1pWog/wkZahsoN8GwM/eBDPCXFWM6jRJy9q+2
 3bxfafe//4nBJwruhbCQH5joGgO4IC8s1Xrc1aKexni5xfWc4+OMU1fZtCBxXxkh0Odn
 iKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767800928; x=1768405728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GnwayMyswWOvAL8SNBz7rMyNl7EtmQruCGq08wSmYTo=;
 b=mAGKcxLwztUDG745wCtDICX4KqdzJlaAlobUnFkk62LLGuu5F0iXgcv9UowOqaabR7
 ON/CkAYpkFra4QH9aMNDv8ToICbtHlXjw8klcxx1h1Jbhq3TM+glqbZw482Gomn4w+Qd
 SQ51+hu9k/6PE+lVavNaSeC9a/o2eI11uJNLvUtBJUH/gys8PUy04AyWmEye8zsyQgaV
 jzhn6GXxnIHpeRQ24OOwEUzR8jjgKEe9AQSfQHuhL9lHb8s5X+PpnLna8M2fYgWOZ4tg
 Y0+inAZlf86At1d2ZfyzekO+EgQzHvTkmlLAQAs23/NUlomVbAb1LujNWHEkB0qaTdo2
 VKOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxVjBKUUCWSDIC3plm7vDdHrclDNGEx1c/Cx3bcr26+BI1K6/q6CoJ9w1q9T6dOGZTnTke67A=@lists.denx.de
X-Gm-Message-State: AOJu0YyfHFbED8MgMrtYuubjWHBFsVk1bhbsCkmyPPo2LAVC7wuq7D/C
 vtEEXJ9dY5ytDJ4j4V/EyMPrZtk8Sk9uhHE7w4OHjxEYgsAeGBsPlo3OhWluSRERXS/YBqdtCbV
 vdMHkq1gNi6OdFhi+UEqW2EajCefE/ax6OvNnhl0rE2tjL1WbeXt0IUg5
X-Gm-Gg: AY/fxX4a61LQX2RXhxa0cT1KRb0x2Sq3CuO9NFmAysahbPlGEpeW63K9yxbeg4dvkUm
 12lxFtMo+jLWe0eUnZ3A/MOMAEWqJRoL6TPjVllOD4vp+21LUiUiYYcCiUPRP26vzku+KtQ2o5y
 o2qayximO9k01rXN0WhVUW4LAFKbDeIfoD+wINC/YE7NgqPRYxwotGoDtugDlYiULn4CTC4UcPw
 W3z+hPK4oHE6gd0SQ9XwkVattLizSTj9tKZMTrrmgRHp5fT/xCab18xOCXKMCaYawmkSzdmajoX
 osc78l9+P9Y7Mp3xQQ25bIucOpcMOXehm95cSN5goW/5eQg1T18KWicP7Ot5qY7SVFn7uMP7/uB
 py1rFWbA8XLJKfzxjuqaOHWxrsMn1c9p7n3ZTjiDdLjzaRBpvjG7namLcDTvKC02m7t98gfcwq5
 mOxp7Ev1/lC07naJc9QdJjZwkMQNNg
X-Received: by 2002:a17:902:dace:b0:294:d953:6ff9 with SMTP id
 d9443c01a7336-2a3ee49b44dmr31613825ad.47.1767800927887; 
 Wed, 07 Jan 2026 07:48:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0zN1gF/vzOWzhmlSgoZ+IzstGjOf8BZjC95mrd8kBO6asOBaPRtztMdPVojLMs58+0wyN2Q==
X-Received: by 2002:a17:902:dace:b0:294:d953:6ff9 with SMTP id
 d9443c01a7336-2a3ee49b44dmr31613535ad.47.1767800927439; 
 Wed, 07 Jan 2026 07:48:47 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47221sm54219005ad.23.2026.01.07.07.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:48:47 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, alexeymin@minlexx.ru,
 danila@jiaxyga.com, david.wronek@mainlining.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/2] qcom_defconfig: Remove redundant pinctrl driver
 selections
Date: Wed,  7 Jan 2026 21:17:45 +0530
Message-Id: <20260107154745.571319-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
References: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEyMyBTYWx0ZWRfX7Ee9CcuBK8lL
 v7gWvnP9wRbiB4IWt+zsXkBaVzGwi4UFJXnP2tA+tcFQ+44U0979u+1y/295w8BCJUeSQWrmZB5
 5ET9Mb1K4RrcHRUWoob2nG449Uzgpmm1f/no45Ih3vY9nSfs202Ecg5k4uOccWCo3JQqJwLEP4I
 tWCZT30Q/M+HM7CAFCwycnpO6ly2UdY2pgLm+kcstc9XL8ZuSlEIULmxkBSLDI+NK+0DbHxaVAe
 A3SL8HCuTuWIiepiKwWvX4WLptTs6ddMKOe+aOPkAxctCDvsJes9/4vnm/p+64i+9j2XoewijRU
 5nnKCOB1brap9K+x+/o1B+B8ozXfFKeAF9uKxmjnNa8reDeKjxQlFSCE8Q7ZTAXpT8r/QpE3FCC
 Fv+3CrjGj+w6o/+RSh/LckvDzY9T1HMBn3soVPaq8nWMzynTJYPd5IxTL9CBD21szZuqkc/UA0r
 Hiry4ULB55IYNfpkTjw==
X-Authority-Analysis: v=2.4 cv=INwPywvG c=1 sm=1 tr=0 ts=695e8060 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3Ywh16zS-PkExWgXSrwA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: ydOSk-Y67pNuEXmWFEfL1jvJXBt7wWHz
X-Proofpoint-GUID: ydOSk-Y67pNuEXmWFEfL1jvJXBt7wWHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070123
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

Enable PINCTRL_QCOM_GENERIC config
The pinctrl drivers are now automatically enabled via Kconfig
defaults based on PINCTRL_QCOM_GENERIC, so explicit selection in the
defconfig is no longer needed.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- Enable newly added PINCTRL_QCOM_GENERIC config
---
 configs/qcom_defconfig | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index aa3902f5627..fe5880de1fd 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -113,24 +113,7 @@ CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PHY_QCOM_SNPS_EUSB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
-CONFIG_PINCTRL_QCOM_APQ8016=y
-CONFIG_PINCTRL_QCOM_APQ8096=y
-CONFIG_PINCTRL_QCOM_QCM2290=y
-CONFIG_PINCTRL_QCOM_QCS404=y
-CONFIG_PINCTRL_QCOM_QCS615=y
-CONFIG_PINCTRL_QCOM_SA8775P=y
-CONFIG_PINCTRL_QCOM_SC7280=y
-CONFIG_PINCTRL_QCOM_SDM670=y
-CONFIG_PINCTRL_QCOM_SDM660=y
-CONFIG_PINCTRL_QCOM_SDM845=y
-CONFIG_PINCTRL_QCOM_SM6115=y
-CONFIG_PINCTRL_QCOM_SM6350=y
-CONFIG_PINCTRL_QCOM_SM7150=y
-CONFIG_PINCTRL_QCOM_SM8150=y
-CONFIG_PINCTRL_QCOM_SM8250=y
-CONFIG_PINCTRL_QCOM_SM8550=y
-CONFIG_PINCTRL_QCOM_SM8650=y
-CONFIG_PINCTRL_QCOM_X1E80100=y
+CONFIG_PINCTRL_QCOM_GENERIC=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
-- 
2.34.1

