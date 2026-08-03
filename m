Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5C1C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37B6560697;
	Mon,  3 Aug 2026 15:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9kKgOaCXFc2; Mon,  3 Aug 2026 15:50:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A23360625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772200;
	bh=VSnqj6TBb3fRydfEGm3isQgxi8NQKh4noba6DONmQec=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Fe+wtaNn4i5jtAx4irM8ZSy6YSyzjv9IvAYmAvKAOM1WmQrp5EMm8dBUXNx3bCQK7
	 atMA4QtTHenTD/dg1GljgT850ABu8ROa14S4clYHEnREOBPFKZYWBF0+NyBHzj+qqh
	 8Jkd3AS/8/edzDmsSXZVVOMuexUu6mFnkN0xPkJJKlWHU6McUCCRDXHZn/0yB+z24j
	 Wls/a5hSVm1Kre9OKqIkfENj053XgBFVuPORyJbfBm54Y5rbG/sFjBd1TFMVp/rLLt
	 eERiL2v/7GEYvsS+unRJNz4AM3KRq3d8WQMG2zWr0oJPqWfK6WiT3yBmzmias2w6I/
	 l7RF9ATPvnTeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A23360625;
	Mon,  3 Aug 2026 15:50:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ABCF2AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D5884059F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uo0dpk-FX9zo for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:49:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3CD2B405D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CD2B405D3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CD2B405D3
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:58 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBkNp976575
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:49:57 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftp16a80s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:49:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb6ef846b33so12709a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772197; x=1786376997;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VSnqj6TBb3fRydfEGm3isQgxi8NQKh4noba6DONmQec=;
 b=TCOFrKsFDKrlbxmHnsVuyW3c+aLeyngu2beOWeSXxQ56I9XAwuev3wlRA8nLt2uD/W
 TgQad4dK9kX0cyfO+USrxCMhzzvgvm1Kb9qPKQyBSzQu7CYHurjg8uf1q9lrgFIk5Tk7
 0J/keRPh9093NZMrmQ37KfA0h9aqRgEo8Bv71tzIaX73U5BTF7BCnPf+0+Zee22kuxNw
 wKZpwfruks4S9x77jx2sFzwC/9XmLnbYoeAtiwlvNRRiq3fSYSUGRfaevg3FHiekNqOM
 EiijB9WtaNEHIzmLFLMZe+G+0PeFZGY1CM0tuIwknbaZvjo72e13PKu4wTld0/yFz3WJ
 mj2g==
X-Gm-Message-State: AOJu0YwXClpag9MQtVsbqyogJlBOBzkptTCJSu82l4NaDNZVyxhoYU4i
 7WGt6EBU40vwlYPZZdPY3Te5uHBZ1vwicNYhabKiJZ5xs0s92J4nx4rtkiAFR1hhYDVGWyIegdf
 CPohSp13s1bYLSRdJRT9v8zkPXzewh9+tANcpvXkuQenMkBoJDCGK1MXMPmFWoDyOkZxGBvs=
X-Gm-Gg: AR+sD10FX38BNXYxcByLzslTM3M3CeHxAKhW8xo+MjSFd59tcPgS9ToE0Cc9N9DHk61
 AIR+ONpi9LLj0BbFqDOox5CIvQgJTCuRPJ4F6KjNuHtuhWOv7vNB3+J35jztzFJHGi2aCegCVKT
 ofc8TvhHGYnNFm0KomJMFQM/s2a6IF7sGITamh6a3MSuOjB/ckYJAhGLaVLcqQwmFIZilJHpY/o
 aFzJlQ9Wz6Y2Od/XSCGXOmvAOimqJ3z/cW4MPek326fUcBShCEV8Q2f1wAjlEPOzl2eoo0wBfb6
 pUJRG7lzfl/SaN4ftct8ICy7f15Dl9Uld/69UQMbvhHIIpyeT9ZdWkMgb6o/VCuYCKAsD/EzBwb
 CpD0eFL3J+9LdDsdM3q6QgRRLfiYxu1W6Gm+pyJ6N8R0A+RNcEyByagOmjk9C4Gw+WXMZO+F/8a
 nnA8kFgrCpTN3CNUfEgKSDgRfYz0vl
X-Received: by 2002:a05:6a21:9204:b0:3bf:9bd9:cf54 with SMTP id
 adf61e73a8af0-3cb6c754d9bmr86281637.8.1785772196646; 
 Mon, 03 Aug 2026 08:49:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:9204:b0:3bf:9bd9:cf54 with SMTP id
 adf61e73a8af0-3cb6c754d9bmr86256637.8.1785772196211; 
 Mon, 03 Aug 2026 08:49:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab13255esm29356854c88.3.2026.08.03.08.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:49:55 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:19:30 +0530
Subject: [PATCH v5 4/8] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v5-4-00ef4542934e@oss.qualcomm.com>
References: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772171; l=2045;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=QGi+Vu1LgJvQVFfHj3/Pqd8bdl6aU2WQsiC2oQGXszk=;
 b=ssySP9M7QzlhzLX0FECMyG0l1vHrvJXRMTEDSATVhMCylCh1XBHhqfUe5FfVuOSnRPk6QDfUR
 MoaXSEf9sNgABBNRPjypfzVLbZQHSNNwJk16hKOHNO3k8bIR8JXY7uP
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX71Xw61UciwfX
 K59xhbxO988KWRyFdc9nGFW8aT3qUJ9C7u/ro2KtccrtRsqA5JtyPkPQZlUG2B3CxPfsEvVLRKn
 xqcubn7oA4/iW7dEUJ3sXKQLBm/uCNEFnZ9jB8FACmOm/WQDInFSi1aTGalE0xBLDvRzvKExYyC
 b8UlVBoE90G3dOG/IRXmHxOzQqf+SbjVGKI4NRJ7eRQu2R3wYUlmh51NrjLd6LvjyCpEQzgXLcL
 osoizKn5TW3J4Lq8ZY/bzFT2s/0556m1KlNKkU0N9GiHXXgkZJ+DwFqNoIG4/D4sLbRsYt5HXb4
 EbqFG+3RWab3nMEOb3byyxKnNsQdyo5o71tzFmzZZ0Zwok0cTYNVB2ZPmgtzxtSJYQksbdn5ZsS
 iqW7koH0wO8r3bccVYz3P4WWnwP8wDQ/vvIC3eq8E7qHQMtjolzfUUyTro93+KCVuc4toHL4mtT
 6WDNjgflhcOF5tIqYYw==
X-Authority-Analysis: v=2.4 cv=Wpob99fv c=1 sm=1 tr=0 ts=6a70b8a5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ZHSanarjU4c6-wJI9dcA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX7uwXQA9NIAhU
 FNuK8hLRIYFxdTVsPWqKiX6hajJ7GuA0RMa96ULcMsH5w6Gi3oXrTHF1iRIMQHm3VaasFe4HolW
 SwpJRHO8ubB4mQirNxT6ZOBd6CwfIQA=
X-Proofpoint-ORIG-GUID: OhWScopTSvYmFay1s-MHR8N8nEYO5zzB
X-Proofpoint-GUID: OhWScopTSvYmFay1s-MHR8N8nEYO5zzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VSnqj6TBb3fRydfEGm3isQgxi8NQKh4noba6DONmQec=; b=ibappBxSJ2cgfvQF
 QfdBrIk1wcVlH+8jigwOP1co+Fbx/W71+EehDiiUEJjYVJFumiQ/kbNXqNEI5cua
 mo9dXEGX2dBt2HAU+Z8AfwixtIYEYX6pxH0+HFEcGoN9gZhmjDYjq5qB/3nWAEfV
 E4Sx5nVC0sk0kh9CGx9BWqz1ZBz0aE5ut4mvTBUx0h+g09vbqONDVeOn8DjMsRKQ
 +fjDNsJAOBPfX95VznctCJBbGYoRGpQZ6/P2Rr4lsNulNPw+8wJNwAf3ssYE8gIl
 rh42AAwBDnVTaujdq1Ljo2UnGu05f6VRbXFo3NbzyH6WmhDavK0Pl0Gt5r5rp9OD
 cy/LFg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772197; x=1786376997;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VSnqj6TBb3fRydfEGm3isQgxi8NQKh4noba6DONmQec=;
 b=NuDY53c5jnRgP0bup+auOxjLaz4zByf+jrtFzomOXUCk996vXZZYFzFgfV0Ddn5B+2
 PK/ZdJEwCCnWHYqQdltiP1ME2MjqoMfGjFZwGPh6H64jo5JY4sdSW2xWTFljssdIHboR
 NYoOtWMmCUxEsor/MQrrAoXpXnxN4ltvYoWArUNYMvfb0Krq2QHtGoxGO7xBnh/INByD
 pZkBuFUgZQSdiFQ/nCKAqT5a7HeHfpyYPhdstmyUbe4KcWudbifpJd/pybU3zoKW5dVP
 NgPZT7DFSUDu9Be5egOQbetT5iwIYM0tKsVcb9R2wLqOfXeowwWx51tzhrwGNntJASIH
 bDuQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ibappBxS; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NuDY53c5
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
platforms. This config automatically selects the required dependencies.
Express the platform-specific requirements and configs that must be
selected and disabled in snagboot mode.

Add QCOM_BOOT0_SNAGBOOT_MODE as a hidden boot0.h config, selected
automatically by QCOM_SNAGBOOT_MODE. This boot0.h config is for
disabling MMU at the start of U-Boot execution.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Made QCOM_BOOT0_SNAGBOOT_MODE dependent on QCOM_SNAGBOOT_MODE so
  it is not exposed to users
- Add dependencies for QCOM_SNAGBOOT_MODE explicitly as "depends"

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
  QCOM_SNAGBOOT_MODE
- Document the platform-specific requirements and configs that must be
  disabled in snagboot mode.

Changes in v3:
- Newly introduced in v3
---
 arch/arm/mach-snapdragon/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index f863daf6bb9..3cfac19188c 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -58,4 +58,24 @@ config BOOT0_MSM8916_PSCI_WORKAROUND
 	  uses the buggy PSCI implementation.
 endchoice
 
+config QCOM_BOOT0_SNAGBOOT_MODE
+	bool
+	depends on QCOM_SNAGBOOT_MODE
+
+config QCOM_SNAGBOOT_MODE
+	bool "Build U-Boot for Snagboot mode loading"
+	select QCOM_BOOT0_SNAGBOOT_MODE
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select SKIP_RELOCATE
+	select ENV_IS_NOWHERE
+	depends on !ENV_IS_IN_SCSI
+	depends on !PSCI_RESET
+	depends on !IOMMU
+	depends on !SAVE_PREV_BL_INITRAMFS_START_ADDR
+	depends on COUNTER_FREQUENCY != 0
+	depends on TEXT_BASE != 0
+	help
+	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
+	  for device/factory provisioning using fastboot.
+
 endif

-- 
2.34.1

