Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A800C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 005F880B53;
	Mon,  3 Aug 2026 15:59:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VB3U8_zEsnbH; Mon,  3 Aug 2026 15:59:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2F2280B34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772746;
	bh=kDlkuzt2mSSbL5PTL1dS3ALibCsSXTu9E+W8GttS6d8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=M/dMtZdUUHNCXWp2TIJqYpYOIS9ikWONqLZgHQ5TvemwzAEqHRjKWMmoJK45z9ZU2
	 UosDHmeamGFucxvowYe81BrYyTpY3S1dAXIPj7CEBizZW51mOmTamq7KtkX+rYYDCA
	 dp/JwF0T8cMpXfJcQuj/uMA6T4DHysANJQodvAPBoG8QaEG8iyRg0dw6xWjFdFEuOQ
	 zcMzosLg7HI9CFQ0a3m3Oir0p4L80i2cu6fIWOTr+GNcOs46t7ZYUbAsAegork1UER
	 tvZfHrqeK6kQLlPOSMLPCElE6LTKOjHBDIfdzErrV7pP52rC8M480gbZ56f3Zqk8+s
	 8KZIhEjyO2zIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2F2280B34;
	Mon,  3 Aug 2026 15:59:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA35E218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEA3560621
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UNnnS3ieVJTd for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:59:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C9E2A6060A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9E2A6060A
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9E2A6060A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EC2mZ1355162
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:59:04 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrdadjv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:59:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbe62e01567so202732a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772742; x=1786377542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kDlkuzt2mSSbL5PTL1dS3ALibCsSXTu9E+W8GttS6d8=;
 b=CaInxpmeuTmhYHSgv8a9rce1P2xu0InpizPCj5b5wAf0/qRyADgER6bJpMw24aWvcH
 M5fyrNaJCHldPfRsC2qQinioyXV1t6DHhRQ4E+j+fwb/pXBy5+s0mhlTeENQukA62tPu
 Dnwju+HNLIoidE185olDi6Uu+e6imLy4w1msHblYqX/WZ/g+tJy04OlNFTDaatxJ285Z
 H5cPtG7Q25UIAghNPWt+A8kn3MAOjfDlF1NlSyb4lwR00POo2NKsV0C2oAwA21SbrrPp
 EY/SBvPfMrIASmg4PCEDIQ4n0l5QQPH1fcAbRqP5hV9vOkCX8wq33tDelfXYdm3pVLh5
 c2qg==
X-Gm-Message-State: AOJu0Yy/6BZK1WAb8Y0IQWQWn948rsVWM0bIwpNyTWWXRmxlkHN8prYv
 oF+ldYG39uKS90rlvCV731TRRH5QC9sPDYax6EgLJ8JXUTYLzYTG+xoMjOdAEFvysIDN6uO58D7
 HBCKTJxwOZ+cCMDfTUGcWXGcI7VHRvq9XqieY5ZsaPH3hvgjYPj+Yj60SJ1sNOzTHUxWhF35nz+
 v6OZ8=
X-Gm-Gg: AR+sD12GhyjN6usvkA6/wBsoS7pXCwIyW9NLbg026WYAATDhqgZMM0613p0FlOMP8Bg
 mYu7w9PJeVAMIcfFYFmMR2SDHKiipeoPh4zxT045/WL9cjcDulbG9qZ7tpWOXQzre4e8Y7KhK7v
 Rq4FHCql/Wni07/AVENmMJvEA7M1NVyo16tp1Cq09TbpXki/MeOwiRqozrqcpJhr/iDXdkTTXhN
 QC50XeeQ/9vwcudWq8SGWeoW2LMZRnLhXz8Qr8anUVhmvo0uoqUDuhpS/kZD9WdzU2Cc+fCCOsG
 4ayLLSP7mtSB6mwnL+bMUn22syQQX15dqq3HJguOx7m0zBBWB18krPH/POknHAlQPDvrJ0lZUb8
 9S9S6+KwCh/ho9ecp8PZrS9DYq9m9v6vjLSxd2peg3PC0gbzfdV0fjzNPnK52zB8oHoiHtnPNoW
 ZmkVHsA3b1Ofk6ml6AisRAKhT6Kw5z
X-Received: by 2002:a05:6a21:600c:b0:3bf:a881:4094 with SMTP id
 adf61e73a8af0-3c92a88e449mr10022541637.50.1785772742361; 
 Mon, 03 Aug 2026 08:59:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:600c:b0:3bf:a881:4094 with SMTP id
 adf61e73a8af0-3c92a88e449mr10022504637.50.1785772741943; 
 Mon, 03 Aug 2026 08:59:01 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c1casm38955713eec.10.2026.08.03.08.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:59:01 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:28:46 +0530
Subject: [PATCH v6 1/8] arm: snapdragon: Make SYSRESET_PSCI optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v6-1-e8bf7a6fc0a4@oss.qualcomm.com>
References: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772731; l=1050;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=cjYIJ6BoQnMb3Ha0ZQQwSM25SZZ0bjNLppahu3/OiKs=;
 b=NKwHAUT7fGVb5yw6r6NZBa1U3WKySKXRSz4LfpgcVu3JiM1GNr0vm1+Mw4ZIKMnwB6vyGkpkc
 Ro09Dp2cw04CkFYNzQoF1T4ujjDP62fb1M+SPuzax4j6bcBR7XOm+0k
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX/v/q1QOjAqfL
 3fVwL7VrrTLbzY7bhMbxlNae8qacw6WCv8WM27IujmVuhkmHfZb86PqITaAnhgW/4DqywAjMNqD
 FZuswicH0YlnEh0xkhbtF7w3SIux2oI=
X-Authority-Analysis: v=2.4 cv=f/94wuyM c=1 sm=1 tr=0 ts=6a70bac7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=881fuD-RhmhaU7In5wAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: tIkrswbDX0b_TflDW7pHb0cVNrH0mojl
X-Proofpoint-ORIG-GUID: tIkrswbDX0b_TflDW7pHb0cVNrH0mojl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX/xxbIVIOAj7l
 nZUOTW2vw2QbQHI4OAkcZHWn8fbA93kN6V/pJ+Dh58tQTvyt3QIL5OhoWsJ/Luh8CXgpM305A11
 Am/Y9PDqW+uITNq8lRemnIsgNJYOf4abSsVQ2bms8jWeU71ndOqQJ65/3TcQlVUm40vTHZlr3pC
 weiR5QSJg5lMZRVvlKgTpDIX4e7Z7YdpAjJLz9ANpG4hkzeRZmMKugm6GoGwICkHWHJkMdp+rNr
 36bGJk3pEeaKrENvGAitlZ1Kj4t3AG00qN4HviU0xPEHmn9ajMX9uKa1AiHiqQj/jGboBfAOOxC
 6/xj0vTzeCIrbbhtPhPIVcjBEUpmMDVXuqhEmbau3c759Hqo3meo7MC+a+Mg19EPn7qgkbJFvlm
 4a9cW20L1k8v55WZMFtYVEnISDG2TLvCQgZXNQzKnn+LhYbQnkt8C3hIedSlryttb/HAokHdrLZ
 MByGEcQPZo2N3K44r2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030143
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kDlkuzt2mSSbL5PTL1dS3ALibCsSXTu9E+W8GttS6d8=; b=TNRF/JbFGfYPfKhp
 OgJZqbBSbS0KHOSaTIQXGxi7WMkLyqsULGro/lNw8Ka68vWfoi6JixGfLE+1ICpy
 pB3GYSU3+cz5S6ulJI3bJRG45Tta+tn9vrJ3qOHSAubpxSn4smH2YEIR7yPFU1aE
 eOVaEHyo6+ICWpW9zKi2ifAKvY22rRTF+Ykxbx2gqyuj8BuSrYga0jeNA8PJlz3h
 i/2OSlqbR9eQ5j7Nc0P0mdJM/ZH/xkA336JoxOxDkC3ebRTQs3fP7qHqLvqqxCTy
 X9wr1zsJO3LlDb76OMGfuqSgJQc0LOZf9FcW65OG28DT0y3uzg3ZoaGTtz2eyFoD
 hMaY7Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772742; x=1786377542;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kDlkuzt2mSSbL5PTL1dS3ALibCsSXTu9E+W8GttS6d8=;
 b=J9K37vC8FYWX51xTF6DOkgf91FzTCHJPTjtJ16nwfVgucJLKNzcdLOOgsNkw4N00+6
 vNfrldVn5yOEndSsQqe7lLZ7WmPnuWJfupPgZLjqofQnTRJzWc57vV2T4qeU8FBYCj0h
 V+EuXcXwTwbQp4yQ7m+PW3E5GfupXwZJdCZNX5tjoJXG495/U4yF9nRHMqQMiSVMMKiR
 /7VWfGAQvE8SfhrVQuCkjPDqKVzmW7rh1QYEjTRzP0xRmjozWtYa11tdbSI2/LeAkQOo
 dPkWqTa9YGHJVvSxtP3x05ZtKSRU+70Z2FRHLkO1CRyMRNTfTBg8XxBZ0jkO5GaUSh+D
 xZTw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TNRF/JbF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J9K37vC8
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

In snagboot mode, there is no PSCI firmware and U-Boot will crash if it
attempts to make PSCI calls so disable it in this case.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- No changes

Changes in v4:
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE

Changes in v3:
- No changes

Changes in v2:
- Newly introduced in v2
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 663594af60a..5b2034bd642 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1149,7 +1149,7 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI
+	select SYSRESET_PSCI if !QCOM_SNAGBOOT_MODE
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
 	imply OF_UPSTREAM

-- 
2.34.1

