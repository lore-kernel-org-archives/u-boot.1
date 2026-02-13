Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02787EF48EE
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 09:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CE883C4B;
	Fri, 13 Feb 2026 10:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivRiTe5g";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MgbsVjRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A40783C4B; Fri, 13 Feb 2026 10:01:47 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43CE183015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D4AW6o455016
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dVu8lIx5aU04wRA6+1zMUlCRTdxHYyd1TiwqlCLK5WI=; b=ivRiTe5gyBIMFZGf
 s453CLBUWT2HqRSIcMAurn8tpyI+KEFiNBviOz+DHCiBHqSeTxNngpuSb0AXfKKu
 DpspN4TFPcXhkc7WVKRqrSsq/JTvlQbqyj3yDuBr4nB7zI5fndvvpE45sbMsYSnG
 GLMpia3UaN4LoMklqPZLl0c2v8d6jO7dzZ716G95Wh7uzR16d6OvgSpMp4yAS5Yn
 Alz2UWe80ag6V51kZMPv0eZU9BuL/amkYLiid/ouHUp2ulH4uOxWdYHb3wwjHrFx
 gfKvkH8zaMRB3W6lA3rTzPbgNVKFRRjJ6KDEa6fO6yy5n7ODD6lGQINgDly+Ae2y
 MrjUFA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9mev2mmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:01:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a7701b6353so10802125ad.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 01:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770973303; x=1771578103; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dVu8lIx5aU04wRA6+1zMUlCRTdxHYyd1TiwqlCLK5WI=;
 b=MgbsVjRZArJeAjy6YtnNtxT19eXNnjoyZa8Qv/RvZCKFnVf+PO4wqMd2UvIsl2QDXF
 MtbIIIp4nuL4HOdtJ3xi/0wmOt8wBAYsuUU8cndM5oIrzTcCtA16q7PJddFwxUigG1T5
 5mW4/mvil1fL1RrpZgicEdeBfLfVfezQjBP72JHpxx1Um4k2qXHGjUISCY1IvbBjrXEX
 YRHvWX6nJGswRSDiB5uTTnCOZMhPpeIh583wFr2Qq4eD8IONRRnNu0bWDHoNGo51uNln
 KXz0AvHC95irp3tGkMvOEcW2y4p6Ib1Vm+NLlSKJde62gtsLCDFCT/wRS0RiHHuFm+gh
 lECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770973303; x=1771578103;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dVu8lIx5aU04wRA6+1zMUlCRTdxHYyd1TiwqlCLK5WI=;
 b=IQAubs/38jiIhVGPl7Q6+/miPsS1iIS5b4iDKILW4+7jye33/pEXXGYM+p7g0FaPS3
 S8+o2FwOgmBuJNjGQbg9hLaP9t83qhnFdztCQHn5UgFpi9Hhj6lvWYsmFjn9ESaUAR5b
 SW+4b/njS9WBYUFW2VKCmuCbx76Q2qQJD8sloj9LQvsQT7j54T9SedqT9uBcqudl+pPX
 sZ4F0SvrVRrAOpZVQqgGDzKh8QaNGs6hOEH+Qtj9m4ATngvM7o043hKNFK6Z7YitQ3C8
 KYUkE1P97Vy16CzM8GhlhAqj4PhB9TwbOzfJqP7RcN2yikvlr+zsM0WHrZ0Y1V16r1cX
 DaNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVChhcEz3XmbyBbB3UeM9Dx1vmRtBDsj5ZW6sQxYOSBB5c+qLS24CTr9ou5rBAIrpmbvKQQvI=@lists.denx.de
X-Gm-Message-State: AOJu0YyBV1t4lu8HNiy+m0JQekDEssBwzXz+gJn1uavOc3zZAoT2OPSf
 SQhFRaOfEWx7qFB1+nXKO1Y+MmsLYNFR6cODsAziM+hAH3U78k2p3IXqz95xEV1cIsXWbWouYgm
 J3rkVHyiHK3emN7V2VHKpA8pTTsf82omjyIngdvACZvnwRefpxE8yIH67
X-Gm-Gg: AZuq6aLZEQUNqztQhuIbXmLbNEGwIyZrWEHcwgEc1kqWrO7Fhj8QeuFgy4UxJPaj955
 r3XdsEWEquOintGHojAFabQv9maGCds09g41xCCsKrOybVU34q+ZoNG0Vc0j/NgDBgA+zTrVmA8
 gSl7gq1CXGOrFh9riRm4f+UOLUO9wlvS9porO28y1eV5MjzaVqR/zS/8++6fLySyZEuVfidTdMM
 PywbE2CIVS17jsIBMpVr1PQ4ROrWxs6UP0jsaqgMqT5CdXc/YMmw7Vp7jHLooMeY5xn+wBRHy62
 FaZ6Gze+7bx8Sr0TkhtRnkGxFhpMfScstnzGAFKzNHSIdyDZmAoefEYXlEmOSDYKuTw8RR7N0cM
 0HbJ332KWnoIQTEBgUvM9H3z7xAisX0XQwprDW+C6RuQO4IpNGBZVkIDGl84mRlGGxWOvdCM/NN
 Q31NEo9tTW/1nm5L/yfQ7Gu+KrebM1scoV467Zd+15z9pn68Wutw==
X-Received: by 2002:a17:903:298d:b0:2aa:f9d7:68a9 with SMTP id
 d9443c01a7336-2ab504fe2ecmr10952215ad.21.1770973302805; 
 Fri, 13 Feb 2026 01:01:42 -0800 (PST)
X-Received: by 2002:a17:903:298d:b0:2aa:f9d7:68a9 with SMTP id
 d9443c01a7336-2ab504fe2ecmr10951935ad.21.1770973302334; 
 Fri, 13 Feb 2026 01:01:42 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29965055sm77524755ad.53.2026.02.13.01.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 01:01:42 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 13 Feb 2026 14:31:18 +0530
Subject: [PATCH 1/3] clk: qcom: qcs615: Add GCC_USB3_PRIM_CLKREF_CLK
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-talos_usb-v1-1-4c4355d61437@oss.qualcomm.com>
References: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
In-Reply-To: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770973294; l=1320;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ig2hVDW6OST9k2tIasb4hCmI2QWxwZfBw31LPqaCZQI=;
 b=F8UzaRpKJJnWc6Kbp0jsaCsefS0rj7KJhY/U3CnKtWSYrivz078T+SZVPJqkGTHIIYRppknCx
 kMc1irAVbhdDjhQTWeWk8Sq5fUr5jRPWqN1nkDjF4kWGjGubC4R4KyW
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Zq7g6t7G c=1 sm=1 tr=0 ts=698ee877 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=G1K_gZgz9GLba3hnKCwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: S_j76eca0PT4L4Sae6tF2BSZM0daOLf4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA2OSBTYWx0ZWRfX1HoJtytXvzo8
 xxiFVBZbR539fF3+0pSmhUy7GeVqO8XgmAyEuuLIZOmldtvBmfB7BbBJWaofVxzqd+xf+eTieuK
 gBhf++5OtEAVuy2xrKnPDekyZY5Ys0Q6GnQRo2jlvLkAHdpwSGcLOLP4rrDFSeW+bDOAefHFGWR
 tg8vrQIPb350W9u1EQF4I3/c07LRH7G066XmE+NrDfPISmh+w0P/TB7Ia1+fhjNT233A3JXD/qJ
 l00iU1DOI4jahAR0Y78fVGn40WyBt0wcqg60IaQb6nqJyWWaXdJdzuts0ldTEgTQaXvdqNieXsO
 GDS3eqErm5S3gsbJX3l+WNy4TYSGud+jRvqktgM+13xiEPPC7JRxWr8h40EZSU2fnKiczW0quGF
 +8Zg0KSPbmyy+f871ynwHE4D7lZCSs6UFHtyIG0rwgzDfyvYUt7e9LtFNHvPoou52R/ca6bYrTr
 dQ+tz0IhcHPodYg+nxg==
X-Proofpoint-GUID: S_j76eca0PT4L4Sae6tF2BSZM0daOLf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130069
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

Add support for GCC_USB3_PRIM_CLKREF_CLK to the QCS615 clock driver.
This clock is referenced in the device tree USB node but was not
implemented in U-Boot, causing "Clock 152 not found" warnings during
fastboot run.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Add support for GCC_USB3_PRIM_CLKREF_CLK to the QCS615 clock driver.
- Removed the logic of removing GCC_USB3_PRIM_CLKREF_CLK from DTS node

Changes in v2:
- No changes in v2
---
 drivers/clk/qcom/clock-qcs615.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 4700baba8c9..65b8db04020 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -66,6 +66,7 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x8c014, BIT(0)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),

-- 
2.34.1

