Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8090DCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08D51848BA;
	Mon, 15 Jun 2026 10:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pWq30w4Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CBPK+cnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551C3848B0; Mon, 15 Jun 2026 10:49:04 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6776584895
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6L5C43828339
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1uigWAohpqJ52zNWnRxr4V
 20kQ2Sbcj34XWCdz8iAG4=; b=pWq30w4Yuo479M4GOBuwvgHG+qdyDkWvLOCZHH
 fovR4t7tKJmWPmtML4uJvbTVCJFCy933B1d5trWkus7HwJLQCa5GgIISC6dWDiM8
 Bd7StfDH/34I2ZWfNsSRjUEjVWkCXyG/ZjmkBQrNRJwYbC3/3UQElsJmlxEdSn2y
 stU5QwxWw9SsZ0HRljiAYoc7R5Sr6kl8t06KdWVVHoqQ2TPa7i1AiZeqtg3u6xO0
 AyCvVme1W8QLkA71bDWuQxmu5nRWjbTE07h3VlY6RR5n+l1CIwyjMm1LXJzTTaBl
 ZZaMrotlJpOA484cBz4wdS3Y2gn0IXIwlw7T9gumBSZRe3tw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u6g2q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:48:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a2c0b56fso3115568a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781513339; x=1782118139; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1uigWAohpqJ52zNWnRxr4V20kQ2Sbcj34XWCdz8iAG4=;
 b=CBPK+cnTEXO4cM4fyWlT+xeBVGG7y/140llyFLKvbvsP5A8S6qaeTh3rV6I6qxKyBm
 ODa3TfE8Qh4Noof5fva1UcRh2s2bzhS/VslNwuwKO7G9UwhUZCFLtwxrmsXpN9RpQcuY
 Y44998nFs8lO1s5Alcma+st2kphBG+ohJ5oMU5HaEN9mCLrw3178HONX7tm3Cr9nyVpp
 GR47aMr+3xYCI7ftSVZA53VqmKvLMvhqqJD4XYgcZ6MXTwDkbRSHzkZVuIK2uhBnG0bG
 lAp7H5hHTwJOJpAyGSj2NnRakHy1BIrLhNK1plGPEAmJqCk0ELX4Gcdf3JRhxdUBp4Ew
 yE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781513339; x=1782118139;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uigWAohpqJ52zNWnRxr4V20kQ2Sbcj34XWCdz8iAG4=;
 b=ZxuZsPXe+0WQgJH1Lcoc9/z2+Upa2WcrBhZXL6mNrvXLj0KsfunH/JMw++LitRnz6R
 niTgxUzpCmvO1w3R4hETpCL1m1w9OV+OgIZlxzC31z/SX/R2zGgZav1LclbjS0qL/znI
 +2PeKWt4saRLJXDW28wVlPblbejVbgdWpNmQRXFKOkCF25HDd8UH7IJ1EUUJAfW9rhJD
 SvnCxwZy0Cm+fdU7199RK1Mf4l4FLoVQTJ1V5P0juEQjdXLvxGi5RRvxBECS1a2r8Cfx
 BiZ5GOipikr0GklcsV/Uz9vceVT+gdl6GvTKm+HH8oZhIrPdmQ6JQut9B/dC5bh96FN8
 E8Cg==
X-Gm-Message-State: AOJu0Yw77gDP5o9K6T0q29YrxUz4gG4cBMnJnttQ8RZbKrUuavPAPTh4
 Hginf/1/7I+FyaG2WZV6Eyo6Ffsk/pASL+Ye7t5dCBhSY8RuJMgJRN0kiUShlGlw6hI78TRP4oB
 Elut70QkWJnQiX0Kz2RRL7RhoSAnyVZXYPh6oAWt0tlt4XGteCw+CyF4i
X-Gm-Gg: Acq92OG8ygjxgIfmV/VssNdrK4rn7l0RRMWXVtvwMNfZ4TIIT3dqmRTxL0h59ElbwaB
 eZIemDSnpyV6nV7kK/8pUbsq3YtDc+bZZrujleL5JzJIiMKY09/1FHTog9sijbzyJXRad/x59Rs
 3UIbUA4FqCMn23BeOx1Y3T3FpbmkuT1QaxsFbZxr29JIrg5Oj7YSgoTbqyugTUYz+RMB1Ue43tX
 qrA+RHb/ADSKBZAAmDsWknm6qihon77/3m40JsBIzbLFq7pAqTqr6gLM/rRTUx9LAHGMp2iV4Re
 +X8WMISXcgzLYvbDKpQM6CbieW9gIPokiNz3MRzr90UhbNwU+BdsdbO93rvcTHTYSDQ3SAjE8ua
 cSFz4F79JUQakfWWU4kpW33Dh89nYOP2QuS9riXYUFIAkFReVTRM95l2jEZukHBRSRl/VjcsRye
 tfdxHppoeTcta96QnfgB8y3WFUlHP6JSjel3ACo/g39WsUasl8HQ==
X-Received: by 2002:a05:6a21:4d18:b0:3b4:93b9:2b91 with SMTP id
 adf61e73a8af0-3b783b87302mr14181628637.12.1781513338582; 
 Mon, 15 Jun 2026 01:48:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d18:b0:3b4:93b9:2b91 with SMTP id
 adf61e73a8af0-3b783b87302mr14181585637.12.1781513338088; 
 Mon, 15 Jun 2026 01:48:58 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866325d1d3sm8014848a12.11.2026.06.15.01.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 01:48:57 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Enable U-Boot SPL support for Lemans EVK
Date: Mon, 15 Jun 2026 14:18:51 +0530
Message-Id: <20260615-spl_lemans-v2-0-d15746f4a64c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHO8L2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDM0NT3eKCnPic1NzEvGJds5SUxEQDSyMDA+NkJaCGgqLUtMwKsGHRsbW
 1ALkTEhlcAAAA
X-Change-ID: 20260615-spl_lemans-6ddaa092003c
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781513334; l=1125;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=orvC6VCkV0ypL2z7SSqHGctBd35dJY+iZdt/m2QHjIQ=;
 b=l6qH0+YroOj4XcC1LORLd+VgCelZUYx3IRtTNG6/YJhNirD4b3JKMuZ0pUa8GkA6WhOtKidfb
 a5V7fu/iNH9D8Ib2aWYv4VGrU8b+je3HG0riwM22vDiK4C3OHApl3lM
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2fbc7b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=A00j17wPPpWeETL2Pz8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 1q-91MNWVlBVbJrnNu2G-fkgJof9im57
X-Proofpoint-ORIG-GUID: 1q-91MNWVlBVbJrnNu2G-fkgJof9im57
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfXz/XdQnu3i1Su
 j16XK7mRcXZi9ZXWxUuYZXPX84fAtlYzbUxe0KK99Ow8i0WRmOiZzoQNHaWJl+cRKi3yWGW7Gm1
 6lO0ClQKSbERrmdOWa8GLKsqaxzHZbYq/e58DmpFBJ5zUEacPhuPn+uIIvgc7/BZAhdnFfb6x1q
 gJgZ0e1YJeERmkVcZ1vBXwvBWFPiop6Ox58RzQJknGrV+mTKL0mgpqCFTzxYSPWp+qyxt+V20WM
 En1xjz6NeznvutSwRhEXrCPmQ6EFnmmiqS/vvPqIiudSoK/Pr6obVSCpASgaRnasI+QfK5jBJUL
 TZjy5utluEpvfgHuYIz7pm6FOHgydYMXUmJoflqVyGxlzIpf30UkK1ONJY6ERUbasmGMWOjIb2Y
 a62UsrSj3Uqu+cmpJc4ygh0G06uvSDAj2H5iKDKn8CXjFkPfUtUq50PgeWEplkGU17ENgtlbl9n
 nLKlLvkB6kmtLdjg8Eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX/NGB2j8ApseR
 ed38VSFnqVbzuaK24N4QpQo4yMLlbwWnWxalewA6/i8DY6P6uzVtM8ZvW40Or7hLW1RfmrtEgT7
 c72/aXka/Bhvp+WCtjKyhB9yXhar/kU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150092
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

This series enables initial U-Boot SPL support, enabling the SPL to load
a FIT image containing TF-A, OP-TEE and U-Boot proper from the "uefi_a"
UFS partition and hand off to TF-A.

Patch 1 adds bootph-all properties to device tree nodes required for SPL
Patch 2 adds the SPL defconfig for the Lemans EVK.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Rebase changes on top of already added arch/arm/dts/lemans-evk-u-boot.dtsi
- Link to v1: https://lore.kernel.org/u-boot/20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com/

---
Balaji Selvanathan (2):
      arm: dts: lemans-evk: enable SPL support for UFS and dependencies
      configs: qcom: Add qcom_lemans_spl_defconfig for Lemans EVK

 arch/arm/dts/lemans-evk-u-boot.dtsi |  42 +++++++++++++++
 configs/qcom_lemans_spl_defconfig   | 104 ++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)
---
base-commit: 1e80ee41441c612f05787a93bbef4e6e422e29d1
change-id: 20260615-spl_lemans-6ddaa092003c

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

