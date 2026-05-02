Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A36ECCFA13
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 02:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3FDA8432A;
	Sat,  2 May 2026 04:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UvuztEW0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jv4+PEzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 060B584255; Sat,  2 May 2026 04:02:01 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA53D840D8
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 04:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641GLX0D987597
 for <u-boot@lists.denx.de>; Sat, 2 May 2026 02:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qZl3m+suZopm3fHQPLJfMoqMS3CuXwg/l2y4suyeVxo=; b=UvuztEW072Z4e9Ze
 fNwihcXzjJDzDZamgQi1qsC1xEMiFlHoDM3Z+nFTiXcGmibdw5REVYidMBBdNdcz
 901UwfvqCtQaYStN6qthODNnV0wBuzDcVFfQIk+F+guTlNBTEzqAjN4GoXxoP/Tk
 K2gyjpzUp96PcNmdm8wEMKGsVdhfEyNBVK+YJGaUk6dfFccs3CYDDV+yqOXpiD4M
 WjgaRoW3TjLFqIhVy8N7jXNETwjZPBM0bc9FUtroTl/Yf2BAq9IHs94Fgyn/aiuN
 HNcMHy/bwMjR9bDo4SGysMuhRQv1CuRRi81gEdpCXt9AoOLFftz7zRBbIhKb4rpA
 MQO26w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvjhsu9dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 02 May 2026 02:01:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f71437218so1748784b3a.2
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 19:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777687317; x=1778292117; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qZl3m+suZopm3fHQPLJfMoqMS3CuXwg/l2y4suyeVxo=;
 b=jv4+PEzKkE9/3oVE28dmyZB4ITPbhD8aaw/qbN9oFgP89apkWl+AXqhKqXw/q9xXTt
 PHcRYCScSbmyBgH1zpNW27BZZfck22RT55hVA7D8DdX19vRyEGxCs3rfv9B1V30fAkqI
 ypbG1VbH3CPshaDZ3UOrmWo93bOqJ8kiD528CKgA8eihPH7ZKyYXhKz7CjU+Bol1z9hU
 MwuYegygJatRdnDDa8wMqWLWU1u83DPNJqfUKRjx+9zsakX3QBh7Pqu/qk9VcG8RgD6x
 2hha/RbgknkJej8qKUDEEn46Bk9w31n0i5l9Df6fViZh2kH/tQdT3IIzZnaZb+6eGX0O
 PgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777687317; x=1778292117;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qZl3m+suZopm3fHQPLJfMoqMS3CuXwg/l2y4suyeVxo=;
 b=M1MGo9u1x9KjgM+W9Gv7bMMvkfPeWyz3Upge2/4sDv6g/JxDg6+UwzilWWkS19xSw2
 bvKqiDCTUQY8NQctfKmEG/HLjFKY4xM6FPVKBe+4DXCTOmjXMUw3xws9VE+nScbeAW/I
 YSLvVpn9U+FFpN32q3G41ftCLuqsXvjSjilDh+DZr4+l/MxZ0hWtzOMceLMxY9/XcQE1
 0EhUwv8FhR4/+XS9W96JOY2oFYNvyu2YMRmxqrC6aHBhxT3vZOwcNUM3SWckYJXcsU2b
 C5Yxx51wb4Wtp5IepuPAqBTiyiDo26oWaroVndUGy4+DEGJogmY+2I2Yg5XX+OC2TkY5
 ZYlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9o/+1jlvL5vnSGj9KkhhjogjBU1DRrH4MlLcrCtI6V55Y4fuJJRtxcC5HHKibD5az+vMwm6ao=@lists.denx.de
X-Gm-Message-State: AOJu0YzmyDbrFuzpUrMv7OucG4E/EfqyFn71ve9WpRu+OkO40mfoUXPe
 84K8cJJ8zlGp/6Es6rE5U2Vi6cWEI1MTrqYdPNsIfKlb5GddQq2f69+938ELdOOJFfbVt3waCMV
 ALO/kLagPEA2pC4GiWCTvw33bAk1eljqrPFEzOtl3bXrXamkpZf9esFis
X-Gm-Gg: AeBDietH+irQ1I5EHqQr2Y9Y90B/G9i//Hd72vIBgB8YqR9Ka2rJE/HPdDWidaVAyse
 Bd9t+2s0cvgbP2Q4OkpW3pyoJb5Jr7WeYUk5TLRARFyUnFPF/Tnw9tuRS95iIDkVoiFzHMl/9p+
 Zycn6o+0vFoUBZoNceh8dkQJzW8W3rvDHJ+1FgdM7sC+h8UiSxXRCFlztaQKv6AUXgCU75F4JtS
 3QLJRpK3UNeP9QPLHDxjROJsn4Wqu0r12AA9usPpt6c0WGuLYIdNU7P9PIrzF4ZXqgG1jKAgeVV
 a0405xLBIdRyttu6XB4Qzc3eDJuKLPO747lvHE8/WnjH1nqy8p6Z6BSbbmWNwdQGZHwGPfAdOtZ
 pMHeXQt/qRvmE8SxMfe2QUXbiDdMXQNYA+9e6G8lQq1XC7J89UmLDuJE/4h70r1T9i8Hjn62c/y
 xGG2M1n6D1JqhzF7wRwih8Yw3PVFyjfAXMtND8XAC7UbwlQXdxI6ppCQXfWdaI
X-Received: by 2002:a05:6a00:1701:b0:82c:e4b4:b04f with SMTP id
 d2e1a72fcca58-8352d2a1cbbmr1426940b3a.47.1777687317147; 
 Fri, 01 May 2026 19:01:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:1701:b0:82c:e4b4:b04f with SMTP id
 d2e1a72fcca58-8352d2a1cbbmr1426912b3a.47.1777687316686; 
 Fri, 01 May 2026 19:01:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515836e8csm3607059b3a.7.2026.05.01.19.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 19:01:56 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 02 May 2026 07:31:48 +0530
Subject: [PATCH 1/2] qcom: qcs615: disable SCSI and use MMC for fastboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-talos_emmc-v1-1-98fe4a4d6f8d@oss.qualcomm.com>
References: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
In-Reply-To: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777687309; l=912;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Z1VpkinYaLVxElww6FuzUgXb1rb2VgU0gCoI09MCLdQ=;
 b=2S2NAw8BhMzR+Ze8BgZK2E+4rAgzTWIdm/g4EgRFMeguYGEkHp2EIltxlWKTQAE2RjzYQFBV7
 pW3suEgbWG3DunMJRegYIfnwKi6kHeNfnPjAulJEoSwrUt9T9CVUG2n
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Br6tB4X5 c=1 sm=1 tr=0 ts=69f55b16 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3V2iVeP53uLT_SfLFa4A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: SCY-x_IKvXHDX_-HvjKM9hLpCgaS0rXr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDAxOCBTYWx0ZWRfX5P9D3zbG4+sA
 izwLuyfcNtGH73AalpBOcxVHARFWEzcpltI8+btuzEFSGtH1DqApAxM+3vEI3qvY3Zek6d5jc9a
 dY8dwASZP+U/pRsDm9NPytcEjEkt5fMaTipygIgUcFeIZUl/oOnhdMyVIZJE4HTNUjRXIPE/sD+
 7nHsMRJc9F/r5M2wnz0wL2uI2bXaoaVxRCoxe4ywa/viy9wvNWagbqys0r+fqjQ9okeTCc6QMuv
 39v0+1CfoojrPadnNb7DTAQKLKU/12Z6mJIy9hMkm67LJyDJLFanM4/cGXkIcbespmnRXUEiPP0
 gBtd/qazYx3EeZWm5bXBKLABLCGGZ9FNyqJvANBqWVcEuCMQNHuY0MSRRVcofPtFbeNvDLqDdE4
 pTQFxRWSjpGW7y7V7b/VhGQ30TnUISuDtUZkJSmlP8rSwQJSndOKQBCAkShbkexESC1ZUD7SWhA
 1tQNVW6ttDMJJuDtfnA==
X-Proofpoint-GUID: SCY-x_IKvXHDX_-HvjKM9hLpCgaS0rXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_07,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
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

QCS615 platforms are equipped with eMMC storage only and do not
support UFS or other SCSI-backed devices.

Disable SCSI support and override the inherited qcom_defconfig
fastboot settings to use the MMC block interface with device 0.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 27666a8129d..494e55bb18c 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -22,3 +22,9 @@ CONFIG_REMAKE_ELF=y
 CONFIG_TEXT_BASE=0x9fc00000
 
 CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
+
+# CONFIG_SCSI is not set
+
+# QCS615 has eMMC only, not UFS/SCSI - override qcom_defconfig settings
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0

-- 
2.34.1

