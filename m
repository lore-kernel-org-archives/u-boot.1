Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAF7C5AD49
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 03:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80DE88312C;
	Sat, 31 May 2025 05:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5BHQciV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42BD582F8E; Sat, 31 May 2025 05:20:44 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05DE383108
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 05:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54V1m2NZ019638
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1YLOvPhs1+j
 bMEQ7UPRjmE1mTXnfDGaQxBj6HGm+Ytg=; b=b5BHQciVQpVlar28RpPSJ7AEW1e
 OmIINMywKU/Qj4ydw7ULyAGjYtRefO3PF5/g2vQH+4SavVBz4l4bidaHSzQZOefe
 uLnPtkvEpInikjikx7ABrw5uPTORz/fZWPnzzOvmdiG+viti/CFEDLGIcL/gEmMi
 vJngYjOFXr86N7zACtrpEtoGM29kH07ufJ6yRkJkdVkB6P8nwAjuvrCZmLqNA6eh
 t36xdi5Zdmj1xRk/0/t3wkPVdrWwr0OR0c7n4UBFOdnsnMz4OU9WjtatZmsN1B3V
 2DJ1i9f8pVaioiWXf6K92w/bTGzFIeViD+52DP9/0x/k5kkPrcX46f6bMkA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46whufber1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7391d68617cso2876804b3a.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748661639; x=1749266439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1YLOvPhs1+jbMEQ7UPRjmE1mTXnfDGaQxBj6HGm+Ytg=;
 b=lX4eUQQR7m3put+1JSGzWkJTrjghW/Jrqst4SfhOzIj7KF2FWpQGYWaCaFq2TKnoGq
 vgpnUgjKc9cYkKTpMyYIkBFI3oJkHIX4I65SHx6xUSeBX2jNqfOs29mHSSQkCb/t1L+F
 +YS8qhRrYUkFWvz0jzp/0vAD9ai5OX2VDWbB0ZTYMGYfcGL646jVr9IiGrqEX8k+M85/
 uE50TE0LRuxr0cPvI+lhCtiKEcqeRtDF8RNtFveBTtih/PFBEfaWwxcXTx/eeGlTyeqc
 7JI5iRImJMmIYdPkABYQQHln7zTnstuLhcJeAhOekSyaWKEmzPv9i0NHWLjXlM02awwo
 xM6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxs9usIFOrnUHGk4GzDQ2bQGnz2vACkrB6N429Gb+JS/c1FCWitjUvugPcm+hnt9oNFWpbS4g=@lists.denx.de
X-Gm-Message-State: AOJu0YwpQrsA6m+rXpxvkO5c3aQWjhet12UJbznjiAIrDv9UKbNyySxV
 XrR88TFNXtYmjTHmqzktxQO0tWTfH46qqdQHWsc987TamHGrNyRaQUXMldnOlxntpxDwvJ8jx89
 41D1Yk/KLj8vPgZ57S57BeB7y2La9x5oQQLCZGeDODvdO8frJMX8C68oQOAD+SzlV1ZqoIQ==
X-Gm-Gg: ASbGncv0nl7rMVHRx41cyQ2Ahj7OO1oJxAsbIu6C+TYBpsVoLQgKtnQ5RulNBiy7iV+
 E9Zk3GeuDYN9E90b8A4WOOyrzlTKrWhetTXstzGbp7Vbw/33SXdct8xmcQKhAhfLi4U8UruECiD
 /RG41iAUeux1mAmedfUv6/7pT9xFk74qbcfIbrClZdPNPwOYRuAdrC1/Rh9naelOhRsJrneIrLp
 zldyKoPF0c0DTeo/btpw11tinkJMmYDiqMtrvc918744F9Hn/igGYhjU2aJR9wRWjtFx0xoNq3w
 80nGIVjSJlVe4e2CEuDI8Y7370Jv6KZlao3XnH5OycMUx09Dee3DzqYDCkughYa/BXGi0/D+Wjl
 d/4EEE4wNfgCiCPfYq2Nq9aCtEtv3jpHlfexWH5izxca20Zpkzhg=
X-Received: by 2002:a05:6a20:e68c:b0:218:2ee9:2c67 with SMTP id
 adf61e73a8af0-21ac5bd41bcmr15120929637.9.1748661639175; 
 Fri, 30 May 2025 20:20:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgWpZtCL+g/bsXL78VMJSFreCxKe6mHIFgHgrlfd2e8xmlCkH2RE3AVqfuvNnAXceQ+M93Mg==
X-Received: by 2002:a05:6a20:e68c:b0:218:2ee9:2c67 with SMTP id
 adf61e73a8af0-21ac5bd41bcmr15120901637.9.1748661638828; 
 Fri, 30 May 2025 20:20:38 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2ecebb49d4sm1856794a12.64.2025.05.30.20.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 20:20:38 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 5/6] qcom_defconfig: Enable QCS8300 clock driver
Date: Sat, 31 May 2025 08:50:07 +0530
Message-Id: <20250531032008.3083716-6-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OslPyz/t c=1 sm=1 tr=0 ts=683a7588 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yiAYSNrAowt6Iz-k4CwA:9
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ennvZt_ouzwc2ikGhfUfFAUim8xJtfiI
X-Proofpoint-GUID: ennvZt_ouzwc2ikGhfUfFAUim8xJtfiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDAyNiBTYWx0ZWRfXwz76xn5j26YY
 bLAMb9gAVWArNmAMYAtke1DuNJWMvbElwcV+5Z2e+LYi2C0GbPQETbckR57udM6BshuUbIYKs75
 nlYujxyQfIxGiyzN8tdDWWJtaPD8LUV0qxoaoAr+uIho6xMkrQh8l7HogM65PVP9ILWEbqBnh8R
 ycYVGHhIPfNQLWKGkEnnI7tQRKXUFxdxrBPrXotERHy0A914m+pP1VvBBpFSLt770YkqbMgvVdc
 FpKX/STSMW7sMqO9FL1foVaKfOBweIkQckDjSPV8qSL2VHIEydOQvND5oN9ciiut4nNNSsdJcdU
 cWaQ+zmitK11Df6I4cHCW4pA8X1zLlOVm17r5hrlh9BPnv7bvw97f5xMbqtVXI/oJ6YyIEF+hh9
 qvjZ1XL/hlQLnLYRVdaMXkwDkwS6ult6tj38F2Z7aNNQSsw5IEr3uL9DUcIlk0AwwpHPWNnU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxlogscore=765 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505310026
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

Enable the QCS8300 clock driver in Qualcomm defconfig.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v5:
- No changes to this patch in v5

v4:
- No changes to this patch in v4

v3:
- No changes to this patch in v3

v2:
- Arranged the configs in alphabetical order in configs/qcom_defconfig
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da0..fbbf82d947a 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -51,6 +51,7 @@ CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
+CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
-- 
2.34.1

