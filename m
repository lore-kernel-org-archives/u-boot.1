Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354A1D12694
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 11:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E7783F8A;
	Wed,  3 Dec 2025 12:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FyaygBh5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hKC8OBIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A32F83F98; Wed,  3 Dec 2025 12:08:28 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04D3383F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 12:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3B3rTr1536812
 for <u-boot@lists.denx.de>; Wed, 3 Dec 2025 11:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/4QoBc+FwNp
 5FOTseRBxzYVHM10CZpmYewJGdU1SxdY=; b=FyaygBh5ef4QHVyN1DwDf0s2fur
 QDSLo4Qc0nTflZKLBFokD70dBwdFxRNkfjrbWkRtLXmN8Nxw1dmnr3h24FtOpA9+
 5cBZTO8+ioyP8Zeuf6xMd8RN0k+iV3j65FVf8L68eQD+jOd8TpmC3xH/wPY4D2a/
 a14vTnfUae9qmjrfA7gHwqDAHfIH2MNuarY5keXpsQRgxkxS40jtAyc0qPP59O7J
 QzmjtzJM0HUjUkECQkFBDJmbgjoCbIri+JPNgafLqAijoNURUit97E0mVDkpcPPl
 BvHc8f7wkl+qE0irWlnPyu7KkluTD/LhDbEI4KzUNJIzYlTJ7owp96JqHPg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm0hr0fn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:08:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-297d50cd8c4so177127895ad.0
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764760103; x=1765364903; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/4QoBc+FwNp5FOTseRBxzYVHM10CZpmYewJGdU1SxdY=;
 b=hKC8OBIao+Sgwi/IA+T4SU8GHMEaC+Y+vBCrDvIEX4D8Iw/regi3IJQHutQ4vfbo/c
 +Po4gUUpD2x8Jqt1D2SJjCf/7NWEbJ+udpiHo5jldU5lZxBU8zDhgm5FvpygpRg70rVF
 nUH+l2kX4DtOVsVVFXjdGc5SoV/Edakby0glac0alTwK1ayFMjQXMc3msEyTBEjZqLkA
 LD0RQNsHAG/eFAq/jupDtPZknbaY5nue3wlG7bzvRqRsGxjnQIo1oUL7GU/WZXlBUlTN
 8BkSzDruhzXMJv5Sn6kaOWvqxm6djenFG4gK9MWAPs9jdGB3MgifzE/NsHSyWxGdxN1v
 U02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764760103; x=1765364903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/4QoBc+FwNp5FOTseRBxzYVHM10CZpmYewJGdU1SxdY=;
 b=DGvo97xHLpaSJPD25ch4XZ1iFIshaalfSJ2DMeLzi9/Y9LEqWDeMekYL6RBQsTR2Uj
 vnRUe+La+6C8qQH1KfjBOpasZldmnKzZnydfT+Yn6eKetM/qkwgnR6I6+RWvnE4DM/rD
 qg7YK0hBX4HrNC3xAedg8CJDD10JSQAuLoao3+mKrUKZweiHFAYWVMjv48JNSH3+6Fwu
 UtpSXF/67BwMq9bqePWbJoDfWykfZWs+98EJs13YJxkMMkToI0r3ErUKGN9c2lSXJhER
 P4Txk4kLFZZJlCd1/USlApZsx3DyWPyRHgPhI/SuUw4P965NIHI9ruy3GQ6ApkOtGu80
 nIJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmaqzUH1L5Z0s27Q4Q7MbxXScqaH0Z0VgYeJQ9ZGHDpfAD+mi4F7WC7vgXynWTiYz+Ee+xFho=@lists.denx.de
X-Gm-Message-State: AOJu0YyLnd4ClcFLFMbfOuYO0ZZo0MX2Jpkr02psm+AiIziPQRtU0co0
 lJyUGl6OINnLVMvvwgLWXOOL1zctyuca7HQ+2EItWEgc+9/ooB/8uhp7RCSg+2d932EPME2+WkO
 YGLsiYyh68n7Bectvpb3u/h3nM1uPwAQXo+IA0wdvOriEkYgOCG8/jCjR
X-Gm-Gg: ASbGncsDlrTnVvRJQ6eVKjk0hg1GkKaXnSb+CH2/oJGI2SBzV7AmP6IqT55hI6jhF6+
 nD6FwbA8d1Zyr7fSxL0g9e2sJ1nPW4ZOW6N9DzkrPP4HhT72zB7f6m6pV9OFNZBPTiqq8Xco2Og
 5OYOMibGSaOkoee0GwNQhAQtVJstfY4RM5ArNh4IlCNfT6Fd11qj6TvlBuU1NxzuHdJGQJIDrau
 O+pmecWBdCutC0yS4cFYLdObWx8/Qb7E4fKRM/IiCQ2XwpCUk5ZtIzllo0MPVgQhbwFMq0yi+XF
 HU297RMl4QvdlA4P/GBNB0XDPuCqIhWKacRQbsJkrDWMGNF+X4HaCdgxf9oudni7+8Z3bFx4qyd
 5kuz4/CF3kwLBShHOBp+aXN9jxZhE4JXqH5V5fkooj9rxYt37dE8rT0PdQrtKZh6MES9RDhzvyF
 B9ovx4d9QtxF1+7znKeB7CmYntdm1yWucUYGk8zA==
X-Received: by 2002:a17:903:3c6d:b0:298:2637:800b with SMTP id
 d9443c01a7336-29d684013d5mr22506025ad.31.1764760103350; 
 Wed, 03 Dec 2025 03:08:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc0tbxCgMXpOFQJEKNndxqC3L/Ergk+SrbelQfWzFKz8z5huN9VPK3scaqbQz+rZ2OVP0+aw==
X-Received: by 2002:a17:903:3c6d:b0:298:2637:800b with SMTP id
 d9443c01a7336-29d684013d5mr22505765ad.31.1764760102906; 
 Wed, 03 Dec 2025 03:08:22 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29d7b6ba774sm10132925ad.83.2025.12.03.03.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 03:08:22 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 5/6] configs: qcm6490: Enable super-speed USB support
Date: Wed,  3 Dec 2025 16:37:34 +0530
Message-Id: <20251203110735.1959862-6-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4K3wDFa-KbEPSEaKSy-xGRiKy5UhZkYj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA4NyBTYWx0ZWRfX+yvncfQMnAn1
 jSz0SFcPaQqWhXjpddgTmru9JvkeXWLdl5XVr5veTKDKNAtLKWeAPC2Akb/nohQXSk8w7wHSdyY
 vOXcAsSfmG886Jis59TwaIsuuH7xbLmUWd+TJ4blV2fsg6Z1ybex4ohlTJ7GJHjS5szisHdUaH9
 QW5tGbSEj0ZiY7O6qta3HUQrFP6Esg3yRYcAXwnkVv/yjNWAsk1z30jybgsTXz1ZuDYPmuTcBwq
 4YLH3qMPubVJLDwqR5d7Dq0njXTvDg5ZO0M+F/uGoFDoDsb/oF57JXtAQc3KLaF4dBige8sEV3m
 6nGmpp93HYuadjhxRskZGxTBP7ovaFcttnFwceCNvxVneXw4RMOdglf4wYh3r4cbzbdRt0m7sEo
 1mvAVXQOLvFgdWzydCfdnHm0jgJkcA==
X-Proofpoint-GUID: 4K3wDFa-KbEPSEaKSy-xGRiKy5UhZkYj
X-Authority-Analysis: v=2.4 cv=V5lwEOni c=1 sm=1 tr=0 ts=69301a28 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KbCl6DCfew7V5gVLQd4A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030087
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

Enable the QMP Combo PHY driver to allow super-speed USB
operation on QCM6490 platforms.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v3:
- Removed disabling CONFIG_QCOM_USB_FIXUP as it now removed.
---
 configs/qcm6490_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaec..2418645003e 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -13,3 +13,5 @@ CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
+
+CONFIG_PHY_QCOM_QMP_COMBO=y
-- 
2.34.1

