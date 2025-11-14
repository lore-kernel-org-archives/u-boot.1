Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958A7CDE013
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 06:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0239783E83;
	Fri, 14 Nov 2025 07:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFrNL7k1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AdRC3ENf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94EE883E86; Fri, 14 Nov 2025 07:35:20 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F3883E76
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ADMatgw1426033
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=bY2ubOGwx7VoNXiMkyGAEERz18v0Il36X/h
 YDjM83dM=; b=FFrNL7k1uqH78vx8C8trpt8tXqf4he1ZPl0/rHCGZp0ESGsfJ2a
 xfKcdoi0qrzBf7afGz6jBhNA89Qq7RoYNObZxZYOrmRQqxd+YFMUYlaBcZ3yOao2
 0q4SXqFL7LZ+tZf0GHGdlCnB6PgUQ+1kYWvzNN7K4J6Eb9LxbfuzmJ3n2U38Lom6
 ZfTt6bn4xE/Ke5gKQx7dC0AMOFUiCvc2/oGU6VITjyo/FfWxImlHEJdP1wodTpzz
 llktVRl14eCXq2utfAxy8U87yiCF8yFC1e4JmKfUYskaERW1eUBiSXKh/Ow0By1K
 ZwKDBjmkj7goU+Dhvyop26TCY2W7FEFjszA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9g12xv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:35:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7a432101881so3072800b3a.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763102116; x=1763706916; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bY2ubOGwx7VoNXiMkyGAEERz18v0Il36X/hYDjM83dM=;
 b=AdRC3ENfkJq6GCC8UDZ9SWsM/FNZiH0omQrll7UPrGo9spMys2KTPsI/oGoJ6Wjr5Q
 XPF+zILC+DgKIdl5tmeyEF5oivXfD6AMdb01D3uX7am2g/n5sZJolfJTLKkzdyNCWuLr
 A6iLNYoxH/7Ix+SjjKLN10aS2eMQ5mYj4BdlwWdFcFs+5O3sJ0zX2XmgY/YtBT8SK42K
 p3cvs5isuzhGFN3cpyEDm6dcGDeZGwrVI5oqlGm6PRLd/sW9M9tJV1za6COs2psXYUJG
 99JntqpcOQUsHf4N4hp6i4YgmUlZ09RVt0wXcomMkx14g5tm5+7mOzKnAtMop0kA56M4
 EiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763102116; x=1763706916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bY2ubOGwx7VoNXiMkyGAEERz18v0Il36X/hYDjM83dM=;
 b=khCfu8K6qh8aDX15xfIygM2vdzrjx9QdNIBkMXB28gxZgPSMgiTU26Uj6jOTphlri2
 jMFHvCj1UYBnIyhHhEUJkeFw0RCwKSgEqCE1E5mJU76e37jovgLpCR1GzOJhhlnec8Jw
 fsIR/nA+WPKMItlmsNYAMpOxKrGC4lnRr/+W+d9NHM34FPuUpzLR3ruOB/xrRrvln9vz
 uJ7/s/Jix2hxAQ1B1kWvX4DJ9BTEhn7Ga0suCY9oNCz8bfXhps/D6Pvm/umzL0HyNjN9
 r3MguzgYutyUmhcs8UGks3JUTY0u9kCJkYH/h1q0+2iq5tU345TjGNuQLqUEvqXBUcgY
 TKVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc+RktP/VQcZRzWcPkrLpfnv2fGodSyZNbNyRd7veWMAlbSq/hId/H0oucpvXXjpycWUVVMJI=@lists.denx.de
X-Gm-Message-State: AOJu0YwXc+3wFQhfgKN3l2lM+MpsMmAB9P5q1UOarxhHMgY++mLHAC9x
 AvfQcy7tss1H4LnHWN88PB5A6YTyAzZqFH+R8fT315b4T5r4YcRwJhceW606KCoR/0k4lIDU8zI
 MizniIc67CqYW71gdpPMtaRkv2KutCUv9hXkkxQScSExH3Hy0BldVMlZ3
X-Gm-Gg: ASbGncuMRGFiPap3OkRD5y412sEnp1+ktcw85LbLYVd9MwAM9nl7D7i+f7rLa9phLH/
 1c700T55z9cfS5qGruevDGQ5ICxqHoN94UqPrcNag5L2scsAHWIRzt/iCvFphITztA54qVWTPoI
 0CjJ/ZDM22XDLydreo3zQWKp08wqXkPeclKyoNhp5oQmA018O93gm0fWQ/S6IPojEfStuRU1RPR
 e1AysBFTtQ1PpIcLYRIV3uI3aHe4H6nE4x0nsI93b2Do9jsA/OxYU0CKTrnp8soMryrNAZnd0Tr
 B3RODflEpD8b4A3IDq5Ac1d+NrsNu0nIu3siRcb8GKanpEhrCPlqrzrsU1lK2aIqQoKQqNiAzmH
 sjZi7Jkrrw8Qk0AsId4Pj0XxK03KTwstMGdiKaoNjSAKwNad+P+DK8XtPq1CeKcnzJrxlDbhYTe
 Fqq+pO4jQEI7C4gK+YWCFlamWC3fCx2rlO2eAamg==
X-Received: by 2002:a05:6a00:3cc8:b0:7a2:8529:259 with SMTP id
 d2e1a72fcca58-7ba39b918e8mr2693759b3a.9.1763102115866; 
 Thu, 13 Nov 2025 22:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc+I958CiysTulAp9/ErHhrUN77SUO0VqWPctAbHinWfukm9v9Z+jP9GyoXd3ngqfXha3+wQ==
X-Received: by 2002:a05:6a00:3cc8:b0:7a2:8529:259 with SMTP id
 d2e1a72fcca58-7ba39b918e8mr2693738b3a.9.1763102115410; 
 Thu, 13 Nov 2025 22:35:15 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b9271502c9sm4044685b3a.36.2025.11.13.22.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 22:35:15 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, sajattack@postmarketos.org,
 balaji.selvanathan@oss.qualcomm.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] configs: qcom_defconfig: Configure USB gadget for fastboot
 support
Date: Fri, 14 Nov 2025 12:05:07 +0530
Message-Id: <20251114063507.3834973-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=L+AQguT8 c=1 sm=1 tr=0 ts=6916cda4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=7txCI4ylUhOV7w6tKwcA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA0OSBTYWx0ZWRfX1QUM4feZPHt0
 xqufwqO2CD8Gq9xcA26c1bUq7KKSavhjq32O5xUujCUiA1GcVed4WEFD04x1R9hu0CirFwbZifU
 FUvqJ8HDaAfLWJJa/5rWu/Jym7Ss/G5Yc/2Kus8e4JEO1dRxBotlWjgoF3u+odP0TMLfC6xRitF
 nY7xCo+db1HjYsObgMlwtHV7LtspKqg6xLI4H8crl0G0/TNrgPrJVgEHND/HkWmgYsJG4gqSpgQ
 IiMJCzg4zSGNhfDbdskasRWjpSWe3A6F4LpxSHlS/XlCeSSU0207KshwfHS7g28UF8n1GksbQqv
 cGn/qVCv4v1JzNGf5Boai8kTaoyKvN7xAox3QRoWGUJ1n57VIQTDJcur+3TvehkOJmLiX1pBcI2
 nVSdo5H5isD8uqBoXKE7f0apPfqOhw==
X-Proofpoint-ORIG-GUID: 5D2-Wn6MvLtpIvt7Q4MKWvTqlC8mO0rj
X-Proofpoint-GUID: 5D2-Wn6MvLtpIvt7Q4MKWvTqlC8mO0rj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140049
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

Added USB gadget configuration to enable fastboot functionality on
Qualcomm platforms. This configures the USB device with Google's
vendor ID and the standard fastboot product ID, which are required
for proper fastboot protocol operation.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e686ea857b9..1510dbdcfd3 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -150,6 +150,9 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="fastboot"
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
 CONFIG_UFS=y
 CONFIG_QCOM_UFS=y
 CONFIG_VIDEO=y
-- 
2.34.1

