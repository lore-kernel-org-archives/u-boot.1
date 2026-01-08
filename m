Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE56D148AF
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 06:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B1E83C23;
	Thu,  8 Jan 2026 07:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hX4OZzzD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WayBguMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1993483C23; Thu,  8 Jan 2026 07:50:22 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB68839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 07:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60846h832784112
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 06:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yZXZJrH0Gco
 fpnA+ZRftPza/cF2sgSPYBSq+kr9Qmks=; b=hX4OZzzDXKelog/eIWzYEakxUvg
 GUHNMud2n7xj7xi1j/HzN01D6T6Ror70BpcfC2cxkhDYz8fYKrZMwqIImS5X0I9B
 nQsT+9qOto7aAwt0V679GulhA4h70ePb4m5LJ4uSpMgsTqXc6X8gD3T0CL2x+qx5
 xqGALEOMEoM8jNY1SBanUwl0aJhvIzzlI8cG+jWt2xaG6nyg7KHDeL4aj5KUwBFE
 vzMtiFW5+it4hY8M/pltuq1k87I3Wi89ulrJtEjc5NgMT0fh17LsihLW+e6V9dOn
 2njPbMjOtJ3vdpUgMhtkdWRejkMYn7nwYnUjxK19E3pLVvuQT/i+eeAs7zQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj58ugeba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:50:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c21341f56so6384552a91.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 22:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767855017; x=1768459817; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yZXZJrH0GcofpnA+ZRftPza/cF2sgSPYBSq+kr9Qmks=;
 b=WayBguMUvGwE18yQuKDXMnYGl6S0CPkvncNNikKouPHneicd8U6jgPjdvlPU2vlJRO
 n5BRcEgZn12YUOs3IES1UKFyuRN+fGErn2ZNvhQn1EMljOiouSyDTiPL8vZJlv0Cwgzf
 LPF884WrwuUa2urwGzFca2kN44HD6QL88InVKwLwEdNabid8xTMqpOPXQ0y31C07z0nG
 JwqxB7qM5wz9yecsd2tb+IPbNA0YnY9Is3rRFo2CVsOLlnk/76A+yjHLTQpmzgEAaw7B
 k17qqc7rCXRNfvrm3l9hbn5Bom+t5ZwVKH1zmA7/nNWkrRcTrH8ZQ9qayYG7jrlHaiKX
 RAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767855017; x=1768459817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yZXZJrH0GcofpnA+ZRftPza/cF2sgSPYBSq+kr9Qmks=;
 b=Oae4O5JZ6hsuzg7jJKqt69/9bPn5AeAtaz5Aa5YkMnYvFDRWBmdBb2pU18Q3kfBFv0
 G4tEKaivN6RDBEdHL5v+QCpS/CzkMdcoz+Ey0+OON2RCUNwej6KwvNYbI0RLFdjdPMvU
 FrggIiP7XQt8jD8XI03EWBHTzY4q6S22twFcURa6/lEz63wwz3wfVqHln/5/Vd4eBzgU
 xNwR2pry4+7abYBUYsI+nER8qMGHrXP8VFPRGofAGiHpP5UqXZXqYEEPZr30F3oXZB2q
 uGS2kBhgafJSsMk4O31wdLq9ZE0fukB44rhggSII9YDs9XEGLT2HN8Zhyf9An971Xq3V
 KDWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY9eYXuvpM+XclGCRPC4GyBvtaSJ75fFt5zdOc1fhCA3d9GC6L6HJH8qDTphBu3S4OBd8GbJ4=@lists.denx.de
X-Gm-Message-State: AOJu0YzC5TNMwZuidGB0Jf9aUvaYK6eClxdp2M3bJdBXcoTolQd4ArEu
 OrpZ/JxtsPKA+fYzUG1ZsVuNZrR3ZjTxlnIvR2D5yieLK94lSxDtHg1LBCRpmdKrfWzmjV4WD7A
 kIoe+hPR4wwz4FIrJIfWYDFlb1gklPm8un+vc+enfaK/cVjC0QmOZKpJu
X-Gm-Gg: AY/fxX4Gh0qrdyenDn8wgdM/u1aQIOsMsYdD5PfUSjR4zu9th+qEsXRWKQNIUMAd7dh
 bj4XfWLZTnq3zJejAD82krgZ258qT3gf7vAg0Soe/6PgZdqEcAuBONw1yHtML4GGZjCXyfIUTwI
 4N8PQIHRzAqS2S8q/X2PtMcNC+rgl6hYyu+iHYo+9TplUEbjR8+FG/I9k3no0P0wuxnjoPa8ARk
 3hx0Mnsy5hFs8w/QGNPE6Fm4JG4U6S/ElffXIyfnjQ3/PcW/G0WV6X1v9s8CsK3WXsWxu8naGnN
 1LnD1i9dl8wDAFAStTlHm6QiOrrZP9ND1zPFLtr0vDyqJK/Ffg6sXy+ymaqJ5snP6h/oJST73/9
 LqpxZo4qW4ZZ8vLZT7s/LCAsYd2PMA60L2cEbD2nkL4u7GJkOUZDg9xlF8EOozjWyo/+qWPwu/t
 /6k5GW0THpv9Psx9kgaMDbZ//OsqUKt0fbggyadg==
X-Received: by 2002:a05:6a20:3d1c:b0:364:1403:7c9b with SMTP id
 adf61e73a8af0-3898f90514amr4756690637.21.1767855017251; 
 Wed, 07 Jan 2026 22:50:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEScL2WQCrQ1djYm+zHvLEWwn/ne8xPLJX21Klrsm0rRGJUY6veS9IOqvUb50FS/vYcGl5H7A==
X-Received: by 2002:a05:6a20:3d1c:b0:364:1403:7c9b with SMTP id
 adf61e73a8af0-3898f90514amr4756655637.21.1767855016709; 
 Wed, 07 Jan 2026 22:50:16 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28faa9sm6918641a12.2.2026.01.07.22.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 22:50:16 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 quentin.schulz@cherry.de, ravi@prevas.dk, javier.tia@linaro.org,
 quic_varada@quicinc.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, ansuelsmth@gmail.com, mwalle@kernel.org,
 anshuld@ti.com, jan.kiszka@siemens.com, javierm@redhat.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 4/4] configs: Enable partition type GUID for QCM6490 and
 QCS615 boards
Date: Thu,  8 Jan 2026 12:19:47 +0530
Message-Id: <20260108064947.3237361-5-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0MyBTYWx0ZWRfX1DwPBZNImqyi
 Kv+Xxj1mPf9Mbhe2rmpHZvlmwr0Y1TACfmKUiN1smI6O/y5g0g/wQslO6RVlHXSN6vO53DaBRHc
 3D7Z04yUnHK7yTm3ibItliPm6N/NMvoIyacDyv0c7XbYhy2ecfSjlmKKdVh+6VmwfVv5ECV0W53
 z2Mko+kK1X1XcOj2hivx/zMRl9UD9PtCJbBH3nddqKDcEOs80dgWRPCTDRlUc1VdaAenebM1DxF
 wdQh29ZusDLjqmYerBeEZFuajiwRB6phk9A6D+hKVt3c6GcFU+ulG9mrOwM8r9gj8NNAehRu3FD
 YNMT6QQ1rkyHUJrwk14nRiQzhGsvZ+P+nFtBkY4O0gzxaqQ6ilOp5U3WLfbkQUg4ZrKm9z3EIQM
 tiQdNu3DLdOinmWZN1srYFlFhHo0Dy+uNUoYTUZv6EzVTCQqM3iEE2S7NKnzUn4pGXQrMaGlFac
 kIx8pFtsly5G5vHHVfw==
X-Proofpoint-GUID: xTINs1EN86Jo6GaihzHrqVMjCGK57ek9
X-Proofpoint-ORIG-GUID: xTINs1EN86Jo6GaihzHrqVMjCGK57ek9
X-Authority-Analysis: v=2.4 cv=CMgnnBrD c=1 sm=1 tr=0 ts=695f53a9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SnKe6nP6TuTyLeAWX7IA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080043
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

Enable CONFIG_PARTITION_TYPE_GUID and configure SCSI environment
partition type GUID for QCM6490 and QCS615 board configurations.
This allows these platforms to locate the environment partition
using GPT type GUID instead of unique UUID.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcm6490_defconfig     | 4 ++++
 configs/qcom_qcs615_defconfig | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaec..e1296fa268e 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -13,3 +13,7 @@ CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_SCSI_ENV_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 2468267b955..4a41602be10 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -20,3 +20,7 @@ CONFIG_REMAKE_ELF=y
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_SCSI_ENV_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
-- 
2.34.1

