Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0C8CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961E683E4C;
	Mon, 24 Nov 2025 16:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RdtqiH4c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RH+AJ3g2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1535A83DEC; Mon, 24 Nov 2025 16:56:12 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F3683E92
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AOFVHcb2397579
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4K2IVUX527O
 uk1Jhb7doI/R5KRhTYtzuGIZUYmfl8/g=; b=RdtqiH4cRRivXVIS9Dj3fmYanGm
 14JVg/nHHlhUpnLWMy6aMZj53ks1COlaK35IVH7elav8XfeG5hGUX5oLftbm8bkq
 OhNSM40YvHYEbw/H1EKq7zj6c/fBzv32uhiDHFsx3Gd55U/7dY11ImA49kzOmPo2
 /5KTaRqiCKH1r00gb1HXIYybFB9idZt8meOrtlLddBsxl+Iiz5DGbznLcaNwaj+l
 QaBbQVIwE9YaLw1N0UMtF2w++w04+9RvtCByTXk4M8ZXyxmKK04ctijKUdOP+T0B
 BwxJ8uPjYoWOEV2NcBAo54IPWcVRwR8BzAVtIoyDfY+t1duuLTvpP4oQmnw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak685wkr6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:56:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7ba9c366057so14151709b3a.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763999762; x=1764604562; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4K2IVUX527Ouk1Jhb7doI/R5KRhTYtzuGIZUYmfl8/g=;
 b=RH+AJ3g2bw67erEcXYLMallgwjdhYc8wfhCLRgGTt365XzyeBR03vYr0VsBpUlQTBx
 wktN71LN9BdjW96+I67HNesjJCwfTVYhwzkSx1ZyN3/KcjEvLkXm2R/Ntc6EWjXzxsx2
 fftTzhJOOdERPWlABErzMzmbRfIkqqKLbztT0ilEb2/zNfg7WeciGcdQauOaipHRCXDA
 6r1Xvuodwjem0u+anEoc2ADPMVWmCBGEflBnap1RS6l78M0x7WpqAZwLWG/1sQvsRRNV
 zuqC75+IaQa+9cGF8n81XJdf8BGHFrJKlQHKlFdJVhR5lzNS+LDSIeXvlEOZejq220Pu
 xo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999762; x=1764604562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4K2IVUX527Ouk1Jhb7doI/R5KRhTYtzuGIZUYmfl8/g=;
 b=TSkF+fvDHyaO33vSD/ouBzLmGu3iFLzhwXJRvBJf3VLFcZ1R72vax6kfctkKM3bCfK
 eVqcaBIsTSUsOIJ6WxPAJ+B3moMWbaeZx6q2SNAYuKLh7qBTyhQnmT86CUYGsUfQwaOh
 nIJdLPgzzrJC5JrqT3FAxy98wKS76l16XMFMzhQVQ9UHdiVoNVY0ycNrlSOTzlz8xA7Q
 UMJbaq1qcVVjOTWPpsU4URlq4bV+gAXp6tb8LVUJk4WUFn8hF8lnKGYvKbiMRtCxEQEc
 a0HnANtd7PQPLWDitzSl1JlXWXjfQZf9E3aJmN5bHIRIK+MF88b8lc7D1LNE6mgOwOgf
 xwKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxj2ZbOV9eMlYs43S3oAKdcX3qHDRqvlb5klWKtko7OCTmA/YKHWVNL4S2iUT/EAw7kADxh2E=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3SmQcmd3PENx46zbnOcuXJUVUkHzuKXcMALN2/WqpU0TJjckv
 gch4TFDUTSbmelFrfo3mjzeXp79qxXdPp1j/wpw0TfA7ZMAg1mg3gw67vGJ83q5a8XTJw6hZUOm
 ViRZAVC/ydQoDslNKPtjxH0T3T47oEiIMvV/sSWJBsVT3fU03yrEmPQLN
X-Gm-Gg: ASbGnctmIlvD1giAPsy2pRYAbfNXqwPFAsJYPOSmazwyh0WrI0xDfWGouOPoI6A7yrR
 C+JqH3571lUh5wXaM0QzGzasCcOObsUmbL3HpqHu7dVIdyxRLerv+XMRZsdHlIgV5OQQN3JyTgj
 w/OjDfO5dYtgVxl+xbeSzhtSTsQKHUryqKU7PeFvUmksVO323If4Wzgq0zheEzEXAmjM0q1kRaY
 6apUnD1kaKNU/ySwCFE5A2BF4wv5teAM7lunn/7SRB8KBjeLkqKyNCcMlxJRfjEihGM5/UY1KTj
 DKLVI9lByurJ3+9eCDhpnKF5e3TLFZkKhTxScalCBnvI0WRQMdV/Wb/nweTPprSMnhCMGgUoSKu
 bjW9HdBEYXezW704VR0wq5g0i88ece5vEvlztNYiswpPZSzB0VL4BtiRmi2QWHsWiHd9+VlUZca
 e9Q6Rs+730STM/cIdJ3idquIq3hM/JXQCQRUwlbw==
X-Received: by 2002:a05:6a00:3d51:b0:7ab:f72e:8f9b with SMTP id
 d2e1a72fcca58-7c58e601c9fmr12270682b3a.25.1763999762505; 
 Mon, 24 Nov 2025 07:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZbfIZzDMkEiRbbYCQu+7zFRlj8zSA7UacCsb3t5u3lulV2Erz+/m5CzL49/NAGOWHKY/CIQ==
X-Received: by 2002:a05:6a00:3d51:b0:7ab:f72e:8f9b with SMTP id
 d2e1a72fcca58-7c58e601c9fmr12270632b3a.25.1763999762075; 
 Mon, 24 Nov 2025 07:56:02 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023fd82sm15254884b3a.42.2025.11.24.07.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:56:01 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 7/7] MAINTAINERS: Add entry for Qualcomm PHY drivers
Date: Mon, 24 Nov 2025 21:25:03 +0530
Message-Id: <20251124155503.2839766-8-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Woom8Nfv c=1 sm=1 tr=0 ts=69248013 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Zz4FqkAgjQAisYH1-3EA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: NuaUVGTW-dQVJS4-psQLiBwLfmgN1w-C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzOSBTYWx0ZWRfXz3NPxmSQIBRH
 ZrOPAOy46wgGeZC2t81xDuXFsnpcVmECIBN9KmP4fBED/LS5aBUVNhACX5k/AsLyYnL3FM6sdJV
 +9kGrmVj23v8Z4xgPK0Bhr3HGwFdpaIA4EkvzMFISHXD5bF08O/iMPcRXPmcgIVfI9cpge89Eqh
 DW5zdlRVOcP8M32XjxoCVQYYAYfSGK5tCeqU/6BN/ibQLVoSPkyyfxtAidRitwv5cAxbEZQV9FS
 oMvUcGQR1qbS+p9dULGhOh4vd7Qxkipl9ip7DquxZon9TNhk4UBePS19AHvyQ8tQWwz4i/6E0bM
 mbg3UM+Cn8ACFogLbz6X0IkPJqO04v3tVdRukNKRg==
X-Proofpoint-ORIG-GUID: NuaUVGTW-dQVJS4-psQLiBwLfmgN1w-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2511240139
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

Add the file pattern for Qualcomm PHY drivers to the MAINTAINERS file.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b43dae882b3..9093ae35b65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -672,6 +672,7 @@ F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
+F:	drivers/phy/qcom/
 F:	drivers/serial/serial_msm.c
 F:	drivers/serial/serial_msm_geni.c
 F:	drivers/smem/msm_smem.c
-- 
2.34.1

