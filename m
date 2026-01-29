Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE8DD73E83
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 18:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD6084082;
	Thu, 29 Jan 2026 19:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MhzXJEwg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IzG0waPq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C234F8409A; Thu, 29 Jan 2026 19:48:39 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB9A83FFF
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 19:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60THUMCe3673990
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=uCfL8cEeDcvIOnV/JpRQJNfND90BIGUVZ8Z
 4anxBljI=; b=MhzXJEwgU3gJG2Vw4JsSdaQjfZiz2Z6rgZI4dU/l8v8pn6OuPao
 j/z6qxsCJ/YVmhxduEJJU7yJLUKqXwDUC9QUkHifpLU4gU9zVMko+PuYoYy4VVXQ
 rW+VZRHSYHnr1LOCxwheb3AccUVXSpS5SQCwVy2nCtUcFPBp5v2qi1P//hl/0GCC
 DjkvUn1fouQ2jKU0b53jsSklwEcLdb02MTY9qItJq/mBqrfCKO+2xAqaVoCY9KAZ
 2q+0ZcHP+9GdSr0w2nWnvLa+mRM1fWOu9xGnA0lab9BeNrjilqpU/0cu4tNmFH/e
 3xWbzH4uloesCsByPByPvC13XXq7VSl2qwA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c05q7hqe7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:48:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a78c094ad6so14044905ad.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769712514; x=1770317314; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uCfL8cEeDcvIOnV/JpRQJNfND90BIGUVZ8Z4anxBljI=;
 b=IzG0waPqpdxp4PwcfuDxddGEtAhoZOHdEzU5ytHulVrqZrY8kYaiLMQh2Ud8PLezbR
 ka7ky8qwNphpOZZvDro6qViaaL6ucuIXDkPdXxQbuBuaf2PN69r0b4R68NlUsglnJiLP
 PCpBmIamfuXiGRRO417u6nkX8izrvgKGmspO/KcgSi4H0HechbQ8O1xlN9iWLAZTWmOZ
 L7llqtVNysB0331qPQCqK+fLiFTx5/AgS74+232OIbD+ILUnYovRpgChKJwlC8CFn1uQ
 CoharRXSCcEQ4/xqSBVsIOwpcHWjdI+AwBBEvF8sGMp7u7S0yClJ1nzuhj6QAxUz3VY3
 bAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769712514; x=1770317314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uCfL8cEeDcvIOnV/JpRQJNfND90BIGUVZ8Z4anxBljI=;
 b=eZ3Q9Z7JM0TrV9Ku5OgVQNLf0wfKpPTpvdJ3WWS/SyoR6qUJAJrEngypXXydyYm7ZO
 Tr5yIAlwF1cwRTxDWIsZ6ngm0ljtgZ/vnGH0xm8f6dBiBFPVSE94k5+UcQjVhjY3OcKE
 IxxCME4P2/WvVdkTor+6dsM2nsOl6pg6OBDq+jqoH+8JLhUhJqHzvoIcQ62liG+at+Je
 /JUq+beh8DszbHKaS8vAj23NXInh7IMN3H/pSzfnvQbjPASi8PhXzIfCpQKWbTEPIJoG
 p+C2DsU5TtQ8rW6bnDi/YHMjc5ZNWM1nIUY5/25rYBLFiPggflWINYAmlOj4r59OjaWd
 QW9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnalH1huvmuntpxc1tgN3oU6as+hsy00hoVgpl2rXSQaVxmSB3qD/zx3R51ItE/hl4CCv8Ihs=@lists.denx.de
X-Gm-Message-State: AOJu0YyW2BVtpiRzTEZ9Bek3kogvUYAfvEDZXRQv7QjKIYin448PtcO+
 Vqx8Oy3q2Rtsm0JImgIyN5qz6nodB4PIHdFS/ug/BNiMK29V5VFFytB9mLjeEnOTFhGGCBHCuJJ
 hMM7PNMviKZ3cYhX4DkNmRZxHjUZBJWtjzW+dhtjH4M6c0z0zV9ydZ51d
X-Gm-Gg: AZuq6aLoRH1Y6DBY158cb6EAk88wZ9bskgvXMiJAA6MQOu9a6hKSCvMk5MEbu06YVry
 6/vx3kKTArV8oOubOtocsLWzr8WNDRZ4hB4M12zLkG3LXdeMcGiAPvi9jAZYTCPJ8eVPudu324j
 vOPIO+XAMyjH3qxHYWWfekMzJlP59wKxe02GrdGwomZ973b2mxE1ONJnRfVf9IoRFmtgAFpTyps
 Iyfr3G3a48hCSTfEj+TyWa619tVLcQwnPRZddbJ1y89q99QKJEw+Ru3x0Uzs/a8P1HEQkPzUbix
 zIekP6vsrwTVqUL4fdDNkyq6b8TOJBKDbluBHO7Nbks8Grf7skVmA+ghYv/EujVn7sPJ8UhA9xV
 ZpM1B9fKcL2blUQ1ND5JGbVsncMJFzcDHIOs+ieRHJ+7UWMf9d4KgpJGWpmM+6yX5af+DKgIFjw
 owAZAon/j1DXZdGSZDRZtunrWXTukB
X-Received: by 2002:a17:903:11c9:b0:2a0:afeb:fbbb with SMTP id
 d9443c01a7336-2a8d7eb5ab1mr3293905ad.1.1769712514423; 
 Thu, 29 Jan 2026 10:48:34 -0800 (PST)
X-Received: by 2002:a17:903:11c9:b0:2a0:afeb:fbbb with SMTP id
 d9443c01a7336-2a8d7eb5ab1mr3293635ad.1.1769712513870; 
 Thu, 29 Jan 2026 10:48:33 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4c3deasm58837295ad.57.2026.01.29.10.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 10:48:33 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 quic_varada@quicinc.com, me@samcday.com, sughosh.ganu@linaro.org,
 ilias.apalodimas@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 0/3] Add FIT multi-DTB selection for Qualcomm platforms
Date: Fri, 30 Jan 2026 00:18:14 +0530
Message-Id: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PTNLVsKpCCrHaOIq18qnDRHmfiLwTKEw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzNCBTYWx0ZWRfX8E7LI3Q11N6n
 bdD/PHYE9lYLtq7p/8trsrG5Zn2UwSu2bun2pWGDK/sGJw5eG4q8KLJmMcCwDVXG43Jhl9DTMPK
 34cZTJa1uS0rNtC9PB2S8EgIEpPnCeTDdomgUQWtpSZEPgvPxByO1Nb7PSTbmZMsHczQUbMklji
 xvRoLj7rPnWSGmqHqkdta0uKVGdh67qxzPICTnpMlG45htEm+XNZ/000lM+RUIUUnUPCkgmc9hl
 R+EnbaDiDnwJ+UoP9K6qvb8pP7l2LdVaAVpqDn76uk7alh7qJtJDP0xAXI8WWI2OD/J7a+Xl24o
 r2lG2nUQgyaXY/67im0YE7sk+5wxhZcnWyIQKdAXEBYU2Qaf6VsXHVZBDNPTx1yb8IgiS1BpWH9
 aVCKq1tGCLvr2pt5UcV4ftzdnmzubaRxmD1SPKhrrCSJ19fMWLbQ03jNjCLIoXBOR84OJ+OeqBR
 KEVoOLsg63Tplh5qpwA==
X-Authority-Analysis: v=2.4 cv=donWylg4 c=1 sm=1 tr=0 ts=697bab83 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cSziVDP4AAAA:20 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RKevqtePZlTsVCDRLngA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: PTNLVsKpCCrHaOIq18qnDRHmfiLwTKEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290134
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

This series adds dynamic device tree selection from FIT images for
Qualcomm Snapdragon platforms, enabling U-Boot to select the
appropriate DTB based on hardware parameters detected from SMEM.

Qualcomm fit based DTB format is documented in [1]
The fit image contains only DTB, while the kernel will be part of UKI image.

The implementation consists of three parts:

1. SMEM cache infrastructure: Provides cached access to commonly
   used SMEM data (socinfo, RAM partitions) to avoid redundant
   lookups during boot. Includes socinfo header from Linux kernel
   for SoC identification.

2. FIT multi-DTB selection: Implements the core selection logic
   that reads hardware parameters from SMEM, parses metadata DTB,
   matches FIT configurations, and loads the selected DTB with
   overlays. Integrates with EFI boot flow by setting fdt_addr.

3. Platform configuration: Enables the feature by default and
   configures platform-specific IMEM sizes needed for storage
   type detection (QCM6490/QCS615: 0x2B000, QCS9100: 0x59000).

[1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/Documentation.md

---
Changes in v2:
- In v1, a combined DTB format was used for multi-DTB support. Based on
  feedback, v2 implements FIT-based DTB selection instead.
- Link to v1: https://lore.kernel.org/all/20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (3):
  mach-snapdragon: Add generic SMEM cache infrastructure
  mach-snapdragon: Add FIT multi-DTB selection support
  configs: snapdragon: Enable FIT multi-DTB and configure IMEM

 arch/arm/mach-snapdragon/Kconfig             |   18 +
 arch/arm/mach-snapdragon/Makefile            |    1 +
 arch/arm/mach-snapdragon/board.c             |  112 ++
 arch/arm/mach-snapdragon/qcom-priv.h         |   10 +
 arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1237 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom_fit_multidtb.h |  170 +++
 arch/arm/mach-snapdragon/rampart.h           |  236 ++++
 configs/qcm6490_defconfig                    |    2 +
 configs/qcom_defconfig                       |    2 +
 configs/qcom_qcs615_defconfig                |    2 +
 configs/qcom_qcs9100_defconfig               |    1 +
 include/soc/qcom/socinfo.h                   |  114 ++
 12 files changed, 1905 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h
 create mode 100644 arch/arm/mach-snapdragon/rampart.h
 create mode 100644 include/soc/qcom/socinfo.h

-- 
2.34.1

