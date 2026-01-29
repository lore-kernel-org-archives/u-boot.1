Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB02BD73E84
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 18:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F5B840B0;
	Thu, 29 Jan 2026 19:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o/aPRvPc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ia6NSQxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14319840B6; Thu, 29 Jan 2026 19:48:53 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F42840B0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 19:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60TImiO81036605
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sNSJUyXM2ra
 EnEv2vH21QQJdmHXLPHf3aLYC6OnGixY=; b=o/aPRvPcGnF1w0FIOOFrlDDCgCr
 tG5p98Bya0mFL87dNYqLzOIaiNIn8MK3ja/H2hsmwnXnpqa2lvwdKHMDoRrCuLgw
 r/xZuxQpkz5rEiLZY9CLnRSyyhi4kdWYv5gvNRKcIf1z8JidKCGfKM88fYIsXh0b
 Jq2ddaQqUIBsWVGtUkKZ5llERLWhDyP9SaecuqwDTX9KsnPcScpW4FgmgiTbCjZg
 GOTpvQPabybISBUUhG+7XpDCLSIdyCGtZQevbBZugUXU83pfWQz/8/ZAbnh9ZxXr
 v293TrFCRz4KYUqC4pF9pstNx1kzgLNKhI+7Eebwui07riJqC4caKKJ0X1g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0d5fr01s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:48:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a7a98ba326so15406185ad.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769712528; x=1770317328; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sNSJUyXM2raEnEv2vH21QQJdmHXLPHf3aLYC6OnGixY=;
 b=Ia6NSQxN6ER6w01/8/B5TteV9i8k42eLJtqwbaUizX1iA9rJSNiDLj3muPTvqvQqoq
 ysAKlHtEJWRaEl30I1eeUrfOEfDop4us1jXQQXwNUr6SFEhPrs6Sfe5Wg4UFdqjf/EFZ
 ySJhRtwDyzUIygmGSkHt8UDI410KU1ScXSBY/90WGU526h8mHC74lQEQEAaHZR5bQU3D
 Z3bBHQUn5CQ9S7J0Xv1fhsLb3T+EzKvbdeHjjwUDJVpOiQ/5vQBMZ/jv5SK3IQASIZ1r
 94crVetY6FHVHYKkx0IQciUBPUEdJOtWrPTViE+uegsjX6Evpoxkh/oGGyO/tqhX3WCV
 VJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769712528; x=1770317328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sNSJUyXM2raEnEv2vH21QQJdmHXLPHf3aLYC6OnGixY=;
 b=vltVa03esEe+N0uczzuLH3skE5nTcTB5978FXonvdk9gAoX02T9SVEgiD+hWtQhEz+
 cx843u3zIsfVTMCOkyW8dhrfAYtSoJX63ga5vtACIj97U/eGr+PCsmo/4E9INddWUFTL
 GOIXUof+rmS+9sClL4fNcrrhL086wGExnZITVISPfT6C9qHt9ly8OAzrPYQpRCzYSPII
 AFbY47TGHR82bfugBALIQHaxH2CaHcMEQwFwMcPQzJZNr+UBTzjG6jw8H32nzUWVPtjo
 O5QeTn1vXmlscHVWsHUhBP7K+mBe/X8MskMFxVBQQePivNby7VJDfBS3bWjODKJ4D13x
 UmGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeWZFbH3aJBZl4DmB4qtHVTsiPEkvBdn5LKW0GTBmJi/f6P1TJMzfnZWYaLCnM5iNr83NJzbg=@lists.denx.de
X-Gm-Message-State: AOJu0YxNabegmhhUEWkTYXOIQrnwTxEghkBdWqU4XJKuYvHEPDieKBFe
 dP2PYl1GwiLfqpeHr2q2N/w64AGnC7TBJ7I+bNinydv2aTnnVP1PiV9MU++SAaG7K5PGBHFBWQ8
 G6H9oSd9cUsk/4voi6ecLHsfWjEXPBzv0dF3c3N2WUD+FP6dNcJJukUov
X-Gm-Gg: AZuq6aKpyetwkHOhzGp1ZAWFQDMfuxRdx8xawaFjkmpEyeRduIkx8+Klj40Yg41uRXF
 1LgpZRUAJmigQxXnMRtRaiP6oHdGJpgH6meFLAK2zyqHqFpyOYxNbUrOB/Pu25PY8QBP2vOCIcd
 ZqHYaBWCYyZhBzvQnrUXyb8HtFO8+LS8ptDl8PsjbjoLjwbePSyAadnluu6ey8fLrMWdx/rbX8p
 l4IHxGmPkNHn8cJsNZ6icnWmo3sNHKjMSsBXw/FzeRJIVSyctlKgYLU9oY0p9LjW7xmnzL4UtNQ
 CUcao/2FAU8len1dHQlp8iLU0OFk2WboExg1rBSTX3XZoMbjjPi0fbffsr6r4LXqkP6H1CTnzbs
 tMcShugxO5HC8FDaxCu0d+X02lQadOd6esGbZyUjZgNbZedr7ie4tu76HoqogE0mSX7KK6l+Eqk
 /m2iDPWjX3QPuyAzJlaYxIAEaG47ND
X-Received: by 2002:a17:903:3bc5:b0:2a7:80bf:3125 with SMTP id
 d9443c01a7336-2a8d98f488cmr1553305ad.13.1769712528208; 
 Thu, 29 Jan 2026 10:48:48 -0800 (PST)
X-Received: by 2002:a17:903:3bc5:b0:2a7:80bf:3125 with SMTP id
 d9443c01a7336-2a8d98f488cmr1553055ad.13.1769712527729; 
 Thu, 29 Jan 2026 10:48:47 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4c3deasm58837295ad.57.2026.01.29.10.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 10:48:47 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 quic_varada@quicinc.com, me@samcday.com, sughosh.ganu@linaro.org,
 ilias.apalodimas@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 3/3] configs: snapdragon: Enable FIT multi-DTB and
 configure IMEM
Date: Fri, 30 Jan 2026 00:18:17 +0530
Message-Id: <20260129184817.224101-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
References: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzNCBTYWx0ZWRfX2x+haHSxejDQ
 jiRUgvBSYrQeZ7jcnQk1a+8lOnCA6HvaPxPa3tQhaN+T/Bwnwcl1RmUcRCdo2VGBqrWoH4g9i35
 0jjvKuAXe4axHP7Bwx3HE0IM/7rw4LgqeDXzgkYv8bN9Ij2HkU4jeWjptVNVSVusWK5y6MjckA4
 PKGGGEk6Z72y7SoOcUsftmIT+VEWFf+fC/mo9w8anqSeMvD/exBN7IQZ28EKQ21Jde7AJ21RJlX
 NccOayjRzZ0bL1cZjNyxeXisyXE/yuXGnX+MOe9eCQNcjQoZf0n34gp9u0ZqY1ZOWiE3RX3BAsv
 9CNOQxwG7lOislzw33k2Q1D67N22fLX0+YZUBq5YSaSoBcC/U60v6bgAmRvscfHss7Te1PgyGY+
 PSmWag51+j/rNunoOuH/VoXpG0/s/pugx4WdOCAq4/5N+s9r+iYuPY4L1CFcMYSgr+mV5MlIGqX
 +kofHwo2DtIkcd/NhoQ==
X-Authority-Analysis: v=2.4 cv=U/6fzOru c=1 sm=1 tr=0 ts=697bab91 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DZuee55P9Dm6Ig52_PoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: FTA_mtSZoDLrXh39-VCr682Qkctsh3Eg
X-Proofpoint-GUID: FTA_mtSZoDLrXh39-VCr682Qkctsh3Eg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
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

Enable CONFIG_QCOM_FIT_MULTIDTB and CONFIG_OF_LIBFDT_OVERLAY by
default for Qualcomm Snapdragon platforms to provide automatic DTB
selection from qclinux_fit.img with overlay support.

This allows U-Boot to automatically select the appropriate device
tree based on hardware parameters detected from SMEM, improving
boot compatibility across different hardware variants and reducing
the need for board-specific DTB selection logic.

Additionally, configure platform-specific IMEM sizes required for
storage type detection:
- QCM6490 and QCS615: 0x2B000
- QCS9100: 0x59000

The IMEM size configuration enables proper shared IMEM cookie
access for boot device type detection (UFS/eMMC/NAND), which is
essential for the FIT multi-DTB selection process.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcm6490_defconfig      | 2 ++
 configs/qcom_defconfig         | 2 ++
 configs/qcom_qcs615_defconfig  | 2 ++
 configs/qcom_qcs9100_defconfig | 1 +
 4 files changed, 7 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 618098c8860..f3caa2a5e86 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -15,3 +15,5 @@ CONFIG_REMAKE_ELF=y
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
 
 CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
+
+CONFIG_QCOM_IMEM_SIZE=0x2B000
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..314fc0c4903 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -12,6 +12,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_QCOM_FIT_MULTIDTB=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_BOOTDELAY=1
@@ -48,6 +49,7 @@ CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
 CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 27666a8129d..1f81ec1f14a 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -22,3 +22,5 @@ CONFIG_REMAKE_ELF=y
 CONFIG_TEXT_BASE=0x9fc00000
 
 CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
+
+CONFIG_QCOM_IMEM_SIZE=0x2B000
diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 371448b8b1b..6be85f05fcd 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -14,3 +14,4 @@ CONFIG_ENV_IS_IN_SCSI=y
 CONFIG_SCSI_ENV_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_DEFAULT is not set
 # CONFIG_ENV_IS_NOWHERE is not set
+CONFIG_QCOM_IMEM_SIZE=0x59000
-- 
2.34.1

