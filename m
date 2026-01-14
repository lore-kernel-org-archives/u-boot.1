Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECB4D29FEC
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 11:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 015208063E;
	Wed, 14 Jan 2026 12:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pjxoVaFX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="flSexk1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 485BA808AF; Wed, 14 Jan 2026 12:16:51 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09258003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 12:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60E7j6R73270962
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 11:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=F5zcRFlBtZZR57dmfhP2YJ
 KyUb47PXsdtD7NT1d7yh8=; b=pjxoVaFX7w1ZhuewMeFCzf+jlmXwwbU3mJPjYO
 2VXqAHkZgpobnNPp/cxctyT/K8jiP3EdVZ2L5KBX6qCtuN8KyCNfKoMg+x+drf8T
 3PGsmk7NvhdrtRmlg0QIgauZUKqSZml3o2wpHxBccOBo2LP1eXRIT1+3HiBzRAPQ
 sq0w6sHW4x5t3AXCk2JADkiEYQeq/8tIumysWDALz9THdhtV5gncZq+0zxDVKgLe
 6MEikhIi+wP2HfktjYTJqZmmLDvG9a3xtqgivJ8S2rdyv0jtCl3YRhGQ6o9TsyUg
 ayXuheOOffI2ljBBH7CGjgEjUg+yB8OuqP0oZP/8fY6ZKcWg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bns8v3k7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 11:16:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a31087af17so105193085ad.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 03:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768389405; x=1768994205; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=F5zcRFlBtZZR57dmfhP2YJKyUb47PXsdtD7NT1d7yh8=;
 b=flSexk1/47rI9stYg3XD9r3nSvewBTwBoZkMYWyROET2DQ6YI3IoG08OF2ox0ix3GN
 AVDAgWgk9h9eg5/dBS7j1rELSSfRjJjP/Knrk2s6Oq0Nj7kL7MOlA2FA5FNkZGLUTfAn
 P5BEAU7VJ4lJxvFbWveNMs0m99I2kjgS2HBL1Fv7CR4CAJo7lWxMrHBVVzWyWwBuhCTN
 1r+LW+Ak9b28sNpxpINN6poEY/lZ27EpVKjYELPeHaPJ7LumM5VoXgCfPhJJcDCuTQI5
 Y7wo8wvMH1pzlltSmfRTmA+VGu+PwRSLHLoZb3M8CNGLVYg5We8I19jwvTxLv+jc4J41
 dY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768389405; x=1768994205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5zcRFlBtZZR57dmfhP2YJKyUb47PXsdtD7NT1d7yh8=;
 b=Z8ZUJgWaeqmDxftjGDsd0ZLc7O1wNhGpo/6pAERcjCJrnavTt/Ab+QsZnJYVKRw/qU
 E1Ps3exc4OZcPRQBEq1L12P7hk22dFMk1qxKPMCdlN4D0vVixanVXh9gRry3xY4tZYwU
 98lTZUSqTCcIwCynZ5r1vEInONfzTAsN90YKnGgo3pTBDRHyr1Sy8gND+M3AVmNTNK4/
 6ImXq4/YeK9iOlY3Zj6/uzaoqWKPelmU6PGgwEZgP3iJnLVYXQ2PiSG3mXsDcBJnFZAk
 YHsN7lizxXEwP0I+9jshL8aWQ7iINFAp3/Crz0T8svkEGJgl4ajCvs3L7QMuF/aXz9vm
 4WcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUloD2uUt9KpC5rUtrcPFM9mob/ki0aXEOO12u3iBjwzYTSVMeX3rC3+LcqAKa5AKM2kv3JbAk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw4PzDQqv5AUOaUeYokwVE2cP+an7QeWJooni23UOVkyDuYU81
 keDK7h4aoUU+o1s/WoTo6X4g3BcANcalFIKUJlJBi56TLZCebxXySSgOkf12UtTjPKp5yuMCRmD
 XJqPni5nzICSV//7PrVeh9tKRpY/qYp76JqR9o0VTWCyXMdJR0IXZ5vz0
X-Gm-Gg: AY/fxX4iRJbdWIiHOCgi8hG5Mii1CS2B8xVfvNOFYgMrx/oUYdh9AHET3bJmPijfLIj
 x3v/kt/idZhZ0XkclHInQ0xb1yV2tMOFYHQJxAWqsW4IiruJOk80sOvDKa7eSaGtPZBD8BEph7Z
 rXAAHZ22aEmAYwS7EXJyGYmLIq+ok84+bXv3+k/2FI7AQ2OM03Rm0KVJ1kgZ0x5u9zi7WJGBPhu
 iyr7lcrDlkuiapHlrkB9Fnqv1FIXtZcNmxnYwYzgoAz9hWd8GS52By9dWsKkJAjUvLomM/2X8jt
 bprOLB4gRiL7TAS5tfC02zio6MWairxYj/cEIsyU6W2h/o0zKKF1nMMZNGaovAXdAwKYCg5LQqa
 DYQWl6O44H/KFGHTNnQ5ONZFwMySZry7TvOySGgywYlsD74FpUtZuh6HKsvvxqaN3yPHZ0xjL5O
 tpbuORHCsRcUqUGI/0CchtMPpuMGoe
X-Received: by 2002:a17:903:182:b0:29e:bf7b:7f36 with SMTP id
 d9443c01a7336-2a59bc65b00mr18652345ad.58.1768389405259; 
 Wed, 14 Jan 2026 03:16:45 -0800 (PST)
X-Received: by 2002:a17:903:182:b0:29e:bf7b:7f36 with SMTP id
 d9443c01a7336-2a59bc65b00mr18652105ad.58.1768389404720; 
 Wed, 14 Jan 2026 03:16:44 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd4654sm227758225ad.97.2026.01.14.03.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 03:16:44 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 quic_varada@quicinc.com, me@samcday.com, michal.simek@amd.com,
 sjg@chromium.org, j-humphreys@ti.com, paul.liu@linaro.org,
 raymondmaoca@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 0/2] qcom: EFI PSCI runtime reset handling and config update
Date: Wed, 14 Jan 2026 16:46:22 +0530
Message-Id: <20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aY5sXBot c=1 sm=1 tr=0 ts=69677b1e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OVXGrgphwjEQls6GgNsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: I4CKbeRSWDco0UZr3HPwgz85wtoeM1SS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX6aSQim+nHPwS
 GcZ5O3AVxY9WcVZ8fDpC+91XtHh72SiRu2XjKINnBcnXC0fiwJNa3lpxtK0LXO0OruwkivbZl9g
 8LOeI8QnDVd1TQctLzohXCEVBCelTd5KFp35wiUiJ4zCeM+vRFedRtd1Slow7Ulj7vmaMHKOQer
 Q0LTFp8rwq+f0hs5iUpxp8xNZxxsbDlQtAYmxsBegFWC1/P+e9p/BhVE18T+FAz1fWhQULYUDH7
 X5o35xdsnOGjomiAbAkKBEzufhO7lju0iJnTEL/fKxa/RjkA9ZspwtBmCbwa7NMczqDCYR8Dvpa
 gDErpr7zbafZy2tafJB4xi8PEIeG7U0E2dRo0Ari4+E7N7XD2J66KyhWT3ophLGI5P1I2wabdOo
 MG+UaD9n+dHd2zynhLrFsBXpSJpZ1sMTmLNekYVxvJIHImW64vrUuNZTf2Lcxcnj1oiryq0Jfkt
 X74tn6ZLCf0g9asyVLQ==
X-Proofpoint-GUID: I4CKbeRSWDco0UZr3HPwgz85wtoeM1SS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140093
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

This series refactors the EFI runtime PSCI reset handling:

1. Introduce EFI_PSCI_RESET_RUNTIME config to control PSCI-based EFI reset
   logic in U-Boot. This allows platforms to disable U-Boot’s runtime reset
   handling when the kernel needs to manage specialized reboot modes.

2. Disable CONFIG_EFI_PSCI_RESET_RUNTIME in qcom_defconfig so that the
   kernel retains full control over reset modes (e.g., EDL, bootloader),
   ensuring correct behavior for advanced reboot requests.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
- Disabled the EFI_PSCI_RESET_RUNTIME config for qualcomm platforms
- Link to v1: https://lore.kernel.org/all/20260108105146.1285450-1-aswin.murugan@oss.qualcomm.com/
---

Aswin Murugan (2):
  firmware: psci: Refactor EFI runtime PSCI reset handling
  qcom_defconfig: Disable CONFIG_EFI_PSCI_RESET_RUNTIME

 configs/qcom_defconfig  |  1 +
 drivers/firmware/psci.c |  4 ++--
 lib/efi_loader/Kconfig  | 11 +++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.34.1

