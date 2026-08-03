Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34940C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2E1160619;
	Mon,  3 Aug 2026 15:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AtXSOph3GwzW; Mon,  3 Aug 2026 15:49:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DF7E605DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772186;
	bh=kDlkuzt2mSSbL5PTL1dS3ALibCsSXTu9E+W8GttS6d8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HNBEMX9SUtkK+CL9q3qyhxskxSsJZvslxIZiZt4HfQzsr8MZmUS98QLbEccBADPKQ
	 sunRG7jJ8oPmfgB6Cd0NjhpcegyT+15E0mDUqoSRiKm7x1q5CvhSfClrnTN2Err/aj
	 sb595DgPToIrZdQyPcTlnQuUU5LyHYYK6wJFAkZOah1xhKG+atVDh/uKIFkOkAeF4D
	 KkxtAdVsTZdSq0fndbIEipv522uvsFgGp1H48gcw9TdR6NkHoIdjprPbwiiSpEfxee
	 /7KX10QgoBedSZ6G+tdzN09T5p2VejUyD8YCLgQq5pnCiGk/7XCnKDNtR/w9NYdKpo
	 MD9UAOkiB1Kag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DF7E605DE;
	Mon,  3 Aug 2026 15:49:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE877282
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A467A808D2
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JhBnb4y7R2Xg for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:49:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A087480889
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A087480889
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A087480889
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBkYX595650
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:49:43 GMT
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhb2dht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:49:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfa55c9430so30840915ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772182; x=1786376982;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kDlkuzt2mSSbL5PTL1dS3ALibCsSXTu9E+W8GttS6d8=;
 b=ON3Rh5Jkv12rRaccEI1kkkSd2D7aNaxvWl9DfTlOX5jFc9lTWL/NqD0SoIBRv0wDPy
 5tfphE/qtDrMXSSSPY11XFLczqp1GWbGHNixDCigSvEbQRg/IBTiicvSY73plZI+OCb+
 9ZGe0iKDKWBBL+LX3lLCuB1yoR1f/UiYTv6gp9lu4QoVjM55WiP0FGAfJtHcpoaOI9gv
 JpOmy5lG9TmBG35uJ0ZvvblZf/uqrr9xRMEz7baAFGGL4aL6yM+nlXsf+0qa3Mp5Xy7B
 T37CIg+Bb1AjNTYsOvxzHrQ+CtPN1l3wdANJ70sef2D98qCsKBdRSUTDAOQOOGr5ZJrp
 Jwcw==
X-Gm-Message-State: AOJu0Yxzv14IgSl120a9EtfoqsmPaXgxx3yDpoJYE1ofdDlBppllF7Qe
 1fJNwbpJMGWIT0ptrGVhqIWlAJBP8NxdZCwdT/92azPpMAJUaubHdadN3NYZHNUzMv1BxSBePSF
 k9JWXJNzP+SeAmsnpUcQvsOcE2llIsxjALTtdrT3nyT0pxKS2nsuqjQQNIVNBu6M0VWBVtrwU16
 aPwYM=
X-Gm-Gg: AR+sD12A/OHz/M999clvQAAv+7xQfRq/JjlGC6CtrkUntYEQHIc6qc1lFheDlN8bbZP
 GlAbxraKLBvRIkK61mAcqov2XLVrN2mdquMY9d0ji7sEdS3WDOWXOkOl0WYbrxntpW3iD7MYE2k
 aQYDXn8SNg2cD+4x/v1VAFq8Fmt7l0mZjUnXUwOukqOa1SGi41aEy3LPVmM/24fuvglNurMVEhz
 fKV2c6NovGdH0TR9zIFu44lw6hq53nrgBtebjwLwM+GCoZwKAABeTKxlk27WVQ7QvF0MeuVJHJf
 OumNQ8sZl3mGaBrb5PInzhZGpLQU+k+YyKbOF9N76T17sQyQjRPZ9VJ544n2Gi8U1VWems+JYHi
 0beapC6egN9pUvLePbQ0yRxyEt5gGgc9kP4nPgsZfmAygOA3bqNizivRA+DMlphXdx7Nt+Jmrcl
 eFi4EnCqRHW3Kdsratez1FvAVFHn9t
X-Received: by 2002:a05:6a21:394c:b0:3c3:7762:5d5f with SMTP id
 adf61e73a8af0-3c92a6382f3mr10700442637.19.1785772182247; 
 Mon, 03 Aug 2026 08:49:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:394c:b0:3c3:7762:5d5f with SMTP id
 adf61e73a8af0-3c92a6382f3mr10700405637.19.1785772181781; 
 Mon, 03 Aug 2026 08:49:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab13255esm29356854c88.3.2026.08.03.08.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:49:41 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:19:27 +0530
Subject: [PATCH v5 1/8] arm: snapdragon: Make SYSRESET_PSCI optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v5-1-00ef4542934e@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772171; l=1050;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=cjYIJ6BoQnMb3Ha0ZQQwSM25SZZ0bjNLppahu3/OiKs=;
 b=xiAyKMXhhCRN1AjOFOQDtZx5NiFR/JOTOHQZyuTGVZs+jz4tSSkETYD423CpZxXp+4mF32tdg
 RVS+La7iibsC3FWwPxhvVb+WYGNg9OazJQKl9hPcz4pO8oEjHvLmV/q
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: vSuIRLTgXBs6qVa9in_HkmvjsSPJPN2E
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX+uE3q27de8ah
 ML5M51Z+u+3ZYLgTDHTbb8F6Qg/EwClyc7RyK9+240EGAgF/Qx8qQ/6qg8OQc1JwVqt1zWtJRwZ
 HGTlPcWW6NDVXZ6GT+d/I7qOK239uRA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX668auvqRf82W
 CD5IVA1KoVf7pbgLzu+Z3lv+4r9lXVuMoTU65yC5V7YJTbS2IfwOItPSOMTMqfo2B4n0QeMOVSf
 HPtBRQlGBE8ovvLEyztnyo2gpshhDPfA39n/39zwjPT9S5bc/HNyLOWrjUaoPWIWCqkzKOkD9cg
 ztCGsP3rLQBbXScnqnoYOuEOuchRmR9ahQ6jlLPzhdALTWbBepsdN3Y93RgiEnR4pTun58weGRs
 1K40pW9wURXo+u4PiGS/08gJnBbA2uhhlrLUqcFSQ5Tb+Up1TYAk0Ylr1wXa9WrCpa7+zdIHBHb
 KOxUAxafAN8F45s0Dl+KpYIitCubOXfd1gqnZrCH0onWC8YZVgYWV4Bh7yf4wRDYjtUdnkzFwNp
 FSP4RXtxJpWbDBTFPL/29imqXuafTzIbwlULuTm6m5pZem7leOELDvvsGOPT48s8Za7tPRetwIh
 iZ2PmEZLcksAG/aX90Q==
X-Proofpoint-GUID: vSuIRLTgXBs6qVa9in_HkmvjsSPJPN2E
X-Authority-Analysis: v=2.4 cv=bKEm5v+Z c=1 sm=1 tr=0 ts=6a70b896 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=881fuD-RhmhaU7In5wAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kDlkuzt2mSSbL5PTL1dS3ALibCsSXTu9E+W8GttS6d8=; b=ZvoTK6hvp5voG/v9
 bvikOb7yK8xBu34JQGawGddAgSVbxwIk09GiqYn8FV/1fe7/2xSBEUE8kij8VNKG
 iDtlyB8UIpy/krV1zhehnOHuEDYSe6b5z9tAG+QCiL76gjDaBFCGYZZyJQMgfad3
 5LyRKaCzOS0USNJJm7zELdWQp1z7Pn29Ba13o5soGv0Y2tKQZGXQ7tKaaVkRhae3
 ao2KoJsRZw1HPDLcr57kLX6+ac7vO/TFvm4FZs07Tav3CkJsmeePMXbMe/AYDh50
 NNLuFjnBgDMq//8NhbTft5VuIgl2CsJb+ysWjD4Bkb4kGSBwl+6nvggG+fLy+glN
 QB7SJw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772182; x=1786376982;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kDlkuzt2mSSbL5PTL1dS3ALibCsSXTu9E+W8GttS6d8=;
 b=ilyQ04c4r+jVIFbvavf+xcoaL0VCS0hy+NNIPSzPNUa7lB5AcTkPFYJiTzG16+4eb2
 PIykT9eGvC4zV6l616rw6umFOfziH+j+LNXliNTW9xRn5EDnsxtqhPFzESB0nGaD8Dq8
 x67ATY22/56ycULQHrvS/TDjlWVe8VMxb3Iveeh544+dgQrRtC0sIX3ozUE5QYYJgf+P
 C0OVhCq482m19spxpEPgLUI4SNrCbkPLrxShFJsGx5JhZOkBJCAHzlPU+4xRps91/noO
 UXjOfIbiH8/W/DEdmQvLD8jlidEoffsohpStlujImR2lC4i+CJS7T+6nUwgGJVJdLyBy
 ZVFw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZvoTK6hv; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ilyQ04c4
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

