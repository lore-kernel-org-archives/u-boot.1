Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C993C4453D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE11640758;
	Wed, 22 Jul 2026 07:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KT8lqNociy0G; Wed, 22 Jul 2026 07:43:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E58C4407A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706224;
	bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=X63BbPgMlcnoj/uYdfiR4dXkP08JTO/yt6K6UD8oHBolsjfzs/uAPC9YUeFPl83gl
	 foCLmIDlnUL8R/9dNZ/ltUDXNYVSCubxUbw/YRHoOIj5X5iOFvwVaxWaYjVmuPVDsP
	 4eeRJzPX0xBHGuh0q+qksTWw85yYmOfFHsgAZNihHnJDBr8fPU5dEZPRF2Yc3+pGmp
	 ctUGOsJs3fX64H2RqM1MKBuBPHITvB+vFe3pyIpxvU0U7AEzI6pxWVR0L41g7CRpZL
	 GuSdzFIs1qFvvGsVwYxkmRfo3ZS+YlAS/vCgzOOqRPVvBiIaL3r5rOSH7Q0n0xF033
	 j8uvOjKDoxLrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E58C4407A8;
	Wed, 22 Jul 2026 07:43:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E258DB4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F4F340173
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uu8Eg5JJwxEi for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:43:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F01D8400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F01D8400D8
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F01D8400D8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:41 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53hHh3917564
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:40 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6aatpa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccd1958e8fso124236135ad.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706219; x=1785311019;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=LyWUHOHskUUyvItJE7knpzPqQjrNUZ0ZSmvULjchYJor+8v3JWRvbZKHFZu8tU+k4B
 ERL8yfXud9mj+0+VMLWOPhahGASQ40aEXmN2JSqPAeZcSj2P75bo2SbQbu7jWE0a/q0G
 rrAFmDffChAZSD9MhNkJAiBactiIaeGWkHfOWS8EEkL2MM2PBykapirTMrDm3Un6ouQI
 hWvRgCAs5p5/z53cFdaofVh7SbmBk3LXwODyipYy6lDW/AA91BWfs/zhNg7F3QmC+ocm
 QPHTvTTZpP2Jxc0A2PiZi0Z3Lh8aPcV3vXdVxSlGeD1X0cD8T3MVPLLgAdHuTjkiru20
 s1yA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+cDprRqZHFL8XlWrzUU5lqhHBk62qA7SqZH4EAzks9tjs5nl9lKdJoam2DZqbPkEjY/nh6QA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxhVy/scUrhyVEjF/N5d9Uv8OcmJzP7Wuyob438J5RQ/jvKhHX8
 L4HaQAvQ7CIj+fw2Yh0nOlnaym98K7K4/KqxSfFoDI8TDOfn5eGtn5xVGXJcArXFRroY7VnPFmb
 bNJjBnsDRYBU4DUzbwBcfAXiYctHN2T63TxRp3I7MpUiUYzLJRdSD9YveqEAeZT5QSCcBjDM=
X-Gm-Gg: AR+sD11or8CQr/OqYmuuLSW3I0v3KlmUcZFR9w3qjS23ILT3+P8yYKYaJd+snEed5ap
 x3mGyjE2cT2dRBua1Stg/klIVKO9xV2/k/vrYzOsTYrW1z2NOISfxC6NL4OAHebj91ieIm88b99
 VfvBD90pXvnxOFzAQAf97e+917Oclo4H01Sk8AU+GjRUY0h2bClaFtYQ36SjWLCmXxaotkkOd6X
 G8SLNe99yR9hw8up1nJLBrup9kdPm7lk6TT7dh5KqRDv97b5RMAllT55cFodkVrQEG/GDADfvCG
 qRZQbaTq1VDmOTYVKVjd/0+25X4HRPi3mC2ttmf1gw5FbkcsMOHTmrH33vlaZqVbhZb2qMWWMIl
 Kw1VvQlNQ4GlJ85jyD67uZZGtUNyEcIQD+618IhULZcb7eGN65vEgvtr3Dhr1lv7phDJJelncxF
 Qa7RkLb5Fx8ZmUeIdNbwpFWzIZRbXPFg==
X-Received: by 2002:a17:903:240e:b0:2c9:97a7:f540 with SMTP id
 d9443c01a7336-2cf349fe337mr247308995ad.38.1784706219418; 
 Wed, 22 Jul 2026 00:43:39 -0700 (PDT)
X-Received: by 2002:a17:903:240e:b0:2c9:97a7:f540 with SMTP id
 d9443c01a7336-2cf349fe337mr247308715ad.38.1784706219018; 
 Wed, 22 Jul 2026 00:43:39 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:43:38 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:25 +0530
Subject: [PATCH v8 14/15] configs: Add qcom_ipq5210_mmc_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-14-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXwP8WldlRhn4i
 hdTX7vy6Lt+t4Tuqz3aknD7D/tUIuu9lfbsYDQvh2bxaCuYm9jmiov0+J+jfFoKFhVDWqtTeIoU
 02wxbBRhLuudXIezwff1W5Rddst8C/ExX/g5DU4N6UUu3zyBpkhvv+x09LgQpr4lm+yhLHM+g6H
 VHgIxuh/GMOVzCpKCe9rJhfLOsKuQbvaziskWQqCmnIbd54A6dRgJ1JOkfDFRXYnCJDqgiH5ebe
 xRAEmwLni/I5ppnC4Q0tRsUv+slPMQwcXBZuXbpwvKA+FcjU0qdIAjzBFIhrRQWqfSCRI7+nJdM
 OlPDixmNx3TWVG3pqu7M8fgv94j7l4yNtID7ydsgzxkTgYfc1jKJpNlA/94Arkw1S5220lPPwU6
 F1DZUA1NFxRFkYNwTYbdvPQZrG7llMZK5d6+lysTmGtmYlRa4+Q+pDL9LXwT1uc7W9s5ZfyRjiJ
 yk4vtjxI1rpy0gjP7iw==
X-Proofpoint-GUID: 0VFzDeK2PlhFmEm2Rpn6dwhy-DEuAtF-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX2uGjKhKE1dRA
 owgRoKu1KQnKmhMBoSobw50pc5XBdJF3d29LRGJDLCnek84h+/Qgdj2L6os9y/ZkPKRKMGTYqec
 FDyNcPG2D63jvp6Npq6gDHLdNVGdpgs=
X-Authority-Analysis: v=2.4 cv=HvJG3UTS c=1 sm=1 tr=0 ts=6a6074ac cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=bkeBrEV1CVOi_WhrbfQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 0VFzDeK2PlhFmEm2Rpn6dwhy-DEuAtF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=; b=GdErUMeS/VxYfxGY
 /9cv/QUAqXueJkd4mFP80utpHXqUypCtqhREFakFotxrRs22i8LpxjtQdSegxEKC
 tkDgXIyTMXpZHGjQEYrJz2S40DqYm4Lx/wjSNWG8ih8FsProbCreU6veDx/p4/jl
 MUe0esm5QP7rAI67sKy0aC4Ja06Z5t/cPcwST0yTzB3TE7/USi+U5IAFRxrGoz2i
 ZpmZ3qGrvZorAyWvrWSf4TAE3aDogSpNfJ5pPbbmLLPyS7K165VuIAhNCdlf9Zzj
 dWF1TKgZK3FO1Y6M/kEcni0VugMOjlPH+tcVQhhQeNBeh2paTyc/CKqbyQoTlgI2
 QLHnKg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706219; x=1785311019;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=c871+r8D8EkkYhy5UnQo7PnGOyxOjopu9v0E8WB9OQ9jQc3l5w7Hs0ExLLjqmKIIBi
 n0f/JYOsDCo9txJhebwjqccrqc5KkrSMZUS+dGvAUBZAmeJwxj052VY5CNSTNz0N1aVl
 oYVExNlM4DKaBSzbn1se2Lzuraj4cPFLSLxU/4SkDC63MD/Zh9M4zypZ2eofd5IyHLBt
 a3l0DWPsw5j7jbpSjBGURc+J0UGsF1I0SrnOSo0TJ2uJmy1/zb68gOWvujdfaAIY36Tk
 5RCuVKIGXjZ+wJlzjqURJ5OwCiE6ZkTeBivS32CvlX2lk6mQFlEYPKm3JzGlzxq4VVlV
 YAkw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GdErUMeS; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=c871+r8D
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Introduce a defconfig for the Qualcomm IPQ5210 SoC based RDPs.
Presently supports eMMC.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_ipq5210_mmc_defconfig | 113 +++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
new file mode 100644
index 00000000000..56a22ce346a
--- /dev/null
+++ b/configs/qcom_ipq5210_mmc_defconfig
@@ -0,0 +1,113 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_EVENT=y
+CONFIG_TEXT_BASE=0x87980000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq5210-rdp504"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=1024
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_IPQ5210=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_QCOM_GENI_MINICORE=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_ADMA_HELPERS is not set
+# CONFIG_MMC_SDHCI_ADMA is not set
+# CONFIG_MMC_SDHCI_ADMA_FORCE_32BIT is not set
+# CONFIG_MMC_SDHCI_ADMA_64BIT is not set
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_IPQ5210=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_SPL=y
+CONFIG_SPL_FRAMEWORK=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SMEM=y
+CONFIG_DM_STATS=y
+CONFIG_SPL_SYS_MALLOC_F=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SYS_MALLOC_DEFAULT_TO_INIT=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80008000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x20000
+# CONFIG_SPL_SEPARATE_BSS is not set
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_TEXT_BASE=0x08c2e000
+CONFIG_SPL_MAX_SIZE=0x3D000
+CONFIG_SPL_MMC=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x00
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SPL_STACKPROTECTOR=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x08cbe000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0x08c2e000
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_EVENT=y
+CONFIG_SYS_BOARD="ipq5210"
+CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds"
+CONFIG_QCOM_TMEL_ELF="../tmel-ipq52xx-patch.elf"
+CONFIG_QCOM_GENERATE_MBN=y
+CONFIG_SYSRESET_PSCI=y

-- 
2.34.1

