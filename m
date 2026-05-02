Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13792CCFA13
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 02:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED08E840D8;
	Sat,  2 May 2026 04:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFWXpmfI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EOoxlAe1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B8E840D8; Sat,  2 May 2026 04:02:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F106180F0E
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 04:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641GLl1f2661580
 for <u-boot@lists.denx.de>; Sat, 2 May 2026 02:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=vAXh4hgZc9Xp8J97ij0ybx
 D2hMB+KrX6b6XFPNfShgA=; b=JFWXpmfI7xTgAQbdutxpOG+1uW2r0jCmhVGj+9
 WzxSglZvq4wYR/KmpQrcQXyQt7w/ol8+5ivfqyV0g8tMcMeRWLhKwoW8GtczxlO0
 eXTwSljZKcahESFaVFFnV5hV8ZKKM5h5sMDXQe8PZEWDaV2ZDFYZOBlDRzYlbk3g
 IIj6GoQuS+2VMQ5kNI2iJU8BZv0Gki+09KTNRRODapb9lIVrcemuI3r3Hh25usjL
 nqsYCgT+RQigHU3w7VU0WsHgnuGq2cA5HuoCRX7KxojRFnw1YS8FVEn2Rwr+U3Qu
 Q7Ln3Ubfoe6vFiN81X0Y9kanZaBc03hRwi9urPtO9i8GyQeQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvhbtkgex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 02 May 2026 02:01:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f07078eaaso1860445b3a.0
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777687313; x=1778292113; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vAXh4hgZc9Xp8J97ij0ybxD2hMB+KrX6b6XFPNfShgA=;
 b=EOoxlAe1JO1yDN6CAKoJjC5ndopw+zmfsDdQJTw84NuYOBVu7DmqYu9K/Z8i31O590
 AZ59cv/k49QTum6aqufT4K+S1vbm6gIlBLb7mBwR4XurC7k2uPobxruf+6mBKLStssno
 fJ+5EtyF6NliT6CTOQEECv4E3UR0jSPnQ7Vi1dCZJBm8pjaEf6cuqeSEbOitCY54XXox
 JrsN6db1u0gpaQ71p/Ul3JsQm644EwVpC6Wij6cPOCdjHHOi3ktc95yJh7yP2rnwK85R
 enbZ437SBBX4iwSKGIKDTarXZCaN2PXVcHJWrkPzVxE5WR5yp5KJ51NR6dcWV3LM21lq
 t8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777687313; x=1778292113;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAXh4hgZc9Xp8J97ij0ybxD2hMB+KrX6b6XFPNfShgA=;
 b=RJ281YWGcDaK6RHSj1ejAsOWLE+3jqNv3asN8jBfN8AlUH1aK+DoWDS4Qnyys13B26
 s2p4SyVIhwQgXIRiCKpnNVrRP64WiJRMfhZtNiyMBTXgvMw6U5pYZJObqWRAQmRIimQL
 uV6xKU/rBFMEJQRV2x/cyB4cD0q7qSrEal1fwcJSFkVwhhfGF8TvHqJYNpz1Nq7pDwgg
 4W2Pi3d/3bporT2HgsIE7Fdbd4pADub8g3x2K8I0qrrpLaC+28LTGxFl/fnBqi9QJuaM
 ieLtfQdiCirkEgnnUzS2AGm4I+kX5zOrl8P8W2vuIvUGbDpnPUxFOj44eiuzb2ylOUOr
 WqtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GOZu48Vq4Otoe0XFE3fpSPGXsTQlBrOSq+Ib+ZZR4vELvUVoABx8+3ncHJ7Y/Uo/lGMHVA6c=@lists.denx.de
X-Gm-Message-State: AOJu0YxaP59z4VvIZKAnxlEp2JY/21lRgTOCjkiAVK81ck2Y8uOd9mbU
 KOIlEtaXQepH8OaZMnlf6iMpatV6fOcViUzyHrs1ZmvTXozytlc/WB9fSayuOTWVtAaylXLGAUm
 vZ/6z9/PKYGsJTt/nY9biD7eY5Q55ZZOaYHos+AY2PNczJ0PWrm6X/yxZ
X-Gm-Gg: AeBDievSiZYwng4d3wQi7Ftgb0SU9MtO2FTlkI7JtSiRdYzYB7jsW/+fN27ZWawCXbs
 G4EJ88bWPjEQyIPpcCGFmWhJGVS8eRmOWwQfc+eLCz8liwxmsukEZOU5O2YkVHA6mxBDsdJicGw
 Wc5gpLbGxBEomyYbGZ+J8KBRn/OyWLZfTWTl4vkU3qPdc42w5v1EHT6slZ8JqPivu/xgQhq1lU0
 Y/fAlgiD68IxlEASChjCqpYcce1kWwX60kUPjrYIYToavhLeGYDty11MELFllcHMlAO7st1f/0N
 8ONdYrlFqrit1WUEhUj+vpDOjXIT+uRCqgy8aJUgNHTN1eu87Bi/O3SH4b2BlptEeFsPfN9ZGQE
 v87IBO7XDOzQ3SlEwwGzOJhN/sEyRtAYM7MxGHYzbJC3mt945l6rNQlotPRgfzlzdv3eBOsNU3N
 sAErfjifWczsdnOcHRIjiIcdNKwxS/hgCFOOkioL71jquChPdqbWcMXwslMVla
X-Received: by 2002:a05:6a00:2d84:b0:82a:5d55:5807 with SMTP id
 d2e1a72fcca58-8352d03bf63mr1483407b3a.6.1777687313309; 
 Fri, 01 May 2026 19:01:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d84:b0:82a:5d55:5807 with SMTP id
 d2e1a72fcca58-8352d03bf63mr1483363b3a.6.1777687312766; 
 Fri, 01 May 2026 19:01:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515836e8csm3607059b3a.7.2026.05.01.19.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 19:01:52 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/2] qcom: qcs615: align storage and environment with eMMC
Date: Sat, 02 May 2026 07:31:47 +0530
Message-Id: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAtb9WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMj3ZLEnPzi+NTc3GTdtCSzRANzS2ML8xRzJaCGgqLUtMwKsGHRsbW
 1AMLFR/tcAAAA
X-Change-ID: 20260502-talos_emmc-fb6a079387d7
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777687309; l=924;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=/WhasJTfZDhUrFICTDzueV7oZpItVw4TdYpsPmQ21pQ=;
 b=GH5SpXhS58z5rYCq7fjFu3zDlS+rX5la78pRw9rLw6DujErAX7YL2v9QzXFGYBKqK0ns8D7O3
 jTrtzBV4SOtAvrnk7qYfvv3V/hwSfB3YZJxwzDxwL2a1Nybn0NlTUyj
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=cP7QdFeN c=1 sm=1 tr=0 ts=69f55b12 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=GPYE2C68nvbreX4YPR8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: vyKN6_LZQv1VWwF4akxGL97mYcok6fPY
X-Proofpoint-GUID: vyKN6_LZQv1VWwF4akxGL97mYcok6fPY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDAxOCBTYWx0ZWRfX4i1jraYiLr7Z
 oAEXUFMyAclGnYc3g75Y1EufSzHNGovIXDGBvye/mKNoFJh01GC1s+5mMPO2KjdOoKUeUZVCfHZ
 +hG+K60npSu8COWpB7eLkC4AC1l9CohBSOL1MlN8ZhJuCJpNSSRrtyqWP8QKPWj0T3AH7hRWe3H
 gsVTGcKok2rWPY85YSftMCJsf+5yV+HiCg1hDhQlI0xzIXch/Ikw4z5NoNhKJ39w8fcKHTrQesA
 28VB57AyuHEAVp8OFEhs5i8V5XZmhbceHHyoQ3RbXXumxZuK0K7hqPMBCdIMZkexeYGtjgNWR5T
 oHZBcSvKXRBktiWr9FT7fItADPsdbAPcku2k1dFKjmBz5bLYfJwNIZWjrmM9zt7ZXdERPN0ctuW
 BvVOH0YlyCe/2yckpfWHIPLzpMrFigweaQSUI9lpx8t0f9rtoPjzNbp+X1rVoKW6Uz18HTZubQN
 Sl2YGCuosFGCyCC/lIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_07,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605020018
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

This patch series updates the QCS615 defconfig to correctly reflect the
platform's use of eMMC-only storage.

Patch 1 disables SCSI support and overrides inherited fastboot
settings to use the MMC block interface, as QCS615 platforms are equipped
with eMMC only and do not support UFS or other SCSI-backed devices.

Patch 2 configures the U-Boot environment to be stored in eMMC
using a software-defined partition.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (2):
      qcom: qcs615: disable SCSI and use MMC for fastboot
      qcom: qcs615: store environment in eMMC logfs partition

 configs/qcom_qcs615_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)
---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
change-id: 20260502-talos_emmc-fb6a079387d7

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

