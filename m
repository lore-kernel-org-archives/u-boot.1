Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CB1C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97758607F0;
	Tue, 21 Jul 2026 06:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1Wjr_OJbpOR; Tue, 21 Jul 2026 06:52:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60D86607E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784616774;
	bh=4xXTe/UnsyTFgY26K/kh4zby0Tr9ZDxCaoAvs62aV6U=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=WkidAd76o+0L+TkV9IYvVWwKdaTgge7emVN4UMeuD8voejt3D4Xrj/wVF2kZo3ctj
	 3Oivtj64NFKPNpUHnJBBsjMzvizQfypIi4cU3uRX0d7/1RA1lZ+OTPhP/HvA8sPiu1
	 Dz+jEVfDAMu+5ZMc7k9z7j5CmIr5prNWbJmty5C/l9uwZ6lVcdn/HNuumJbe1Abksx
	 F10IeE5rcg6jcOfgHtdZgwfSxsDBlS20zZ3aJ3rA92GANEK88uwmlAWj9uc8pJ4HK9
	 sE5zIHvf27ehg3uVtM1BmjqmptgW0PEuka/g+syxTQW2mFjjcndOjSTebyanNZlqTA
	 7FWcukfHcDJrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60D86607E0;
	Tue, 21 Jul 2026 06:52:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C3F161099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C11DD407AD
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLWl0bYyEC14 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:52:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B99B9405BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B99B9405BF
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B99B9405BF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:51 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L460Lr037547
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:50 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1es0kwt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb711c88f2eso1345605a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784616770; x=1785221570;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4xXTe/UnsyTFgY26K/kh4zby0Tr9ZDxCaoAvs62aV6U=;
 b=qKfuSZhx4BKi8CKJyEfd4u2vnFXxiOiCyJmTxbnJ0RlluY3KhGxZBEhjSBU7Z6Gi6l
 WTBhZvB4GuHbNH1+nMXdqtmT0N56jxaNb/6NGg2q8sMAmo1WbPEDwTpOOW5NqxGHd8pb
 xOWq6RkEAtlch7oAN8RIBCP8KLg1FvF5Ezsz3iD4nOaqV2AU0dvJP++N3KbR9hnbAyyy
 TqAM5m68HQKQF2hZBU5xngH3Xr/OKXans2GoWVZ/IgBcz8fD62SxmX2IhnXWKbExdhn2
 I92vFZIpM3TQmLKf2r4PmZMF0f+NN4tV2/zLpimEUv0BwsMaT9x6/zWu7OmkbHEOPLu+
 Z9zA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiDLHplyF3SoKuCyMTgUtSfPik17qZLRrhkv3xc7XLBhgtSy/zSyAYHlyagQeKSMdoC7Nr7nM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyOsFTp4Wjft1qcWUR8lYJkmh2Df98r79M8jd1BCJIdpFXK5C8W
 ZS+aAoUrGT4t1rT9qINIAW6gdmc5y5WYYzQDyh3mGMeMq/dvbWY6jJIKwPCFHxtwr+27bU8hS+5
 YgqoEsw5IPBEpY6xRYtU6UUn8UT0UZ4l1lMtUF71SMLlcThbCL+S7MlXzRy3eGTa9FB9uTrg=
X-Gm-Gg: AfdE7cm8Py8tey5cTJBgLyD68qZXyAY+RuHJxdnbM64LG7n5sKPa/gTBaMInjv6JlWt
 uq1KXXFoXjf9pWokMd0iLJzbmBjG2lKQIoSXrwd4AJ+t6McIDhtrFW4vf+KuEww6xBQbozo2YJc
 Lnlp5Y6RpJgoWQhYlj8oDZ0zgDDEG6aSddWZ/6R59O4+PXd5Li3rbfR0SxNSc/PXgKdfFId2tpm
 k3F+d2dmla/eJOXqCKUUlBGEt1BI6gjZPW24i2i+VMUtA0yeAMU2q6obn4Kuxc+ELzQvkvVMTMj
 Sj7EZredupUpyzaAIPWoyAdFhblDSpX5IVbyYixtVATNDcg6F32QRDuxd8+Vn3ACorfqzElWcWF
 wI5jETxWWTWAQWn0uBJZ+MBeFUF2TZgeTVCaXfKuaTPu/XKh0znqoXGzFd+SYQj/njTozFYQpG9
 +UbK5osial91+xamcICvUW62AGKNyD
X-Received: by 2002:a05:6a20:ae2f:b0:3c3:93ce:663 with SMTP id
 adf61e73a8af0-3c3ad7ab967mr18040067637.26.1784616769925; 
 Mon, 20 Jul 2026 23:52:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:ae2f:b0:3c3:93ce:663 with SMTP id
 adf61e73a8af0-3c3ad7ab967mr18040043637.26.1784616769490; 
 Mon, 20 Jul 2026 23:52:49 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm73931642eec.21.2026.07.20.23.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:52:49 -0700 (PDT)
Subject: [PATCH v3 0/3] Enable eMMC and SD card support for QCS615
Date: Tue, 21 Jul 2026 12:22:41 +0530
Message-Id: <20260721-emmc-v3-0-35cebc036994@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADkXX2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyND3dTc3GTd5ESDVLM042TTVMtEJaDSgqLUtMwKsDHRsbW1AFr5TiN
 WAAAA
X-Change-ID: 20260721-emmc-ca0e6f3c5e9a
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784616764; l=1490;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=EfYfJQYogz3+poVdNE8BFTeSIx8oAnjbgY+5Z4bm8qY=;
 b=KT+5gG/85J2F+IctJpQMHrvj6YFGeRgbXBEMMAPhr8ebc5Y3ouRAyAeAQ/8zDgTmMxX/Y9oyL
 5BAFliZTcr/D2IPlGLqusVlTtqcDS+vaQVJ0qaphL1QWPCZxpVUrsy/
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=SPZykuvH c=1 sm=1 tr=0 ts=6a5f1742 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9gW7mo8bt9U-28u8YEYA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: hQJUMKC8kliDsA1ddAirkkkillZQy9XD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfXw8Y6FFK2Qxp/
 v88QBqUNoy/haGSxsV/4YL3x/gxgs6SmC/j6D2/IjsHw6mTtC27yC5PqdwolMOzHnyKEiaUqPnD
 eg9UX84myZro+ASWQ98UAM+p/SFHy3n+m0ALjBVAAvedvEN9dy1yeqLprECRYf3gtsnXXqmSfuS
 2Gt46C9Re0Tmb/k93/aZeJYtS1z6Q91YcAEAV+S7BOCmOCQz0jw3QlNfFqtkcA8wgom9l6NlMYa
 D/tsKofwCVultKFoMbQNMCQRXbDZ3JHY1VuHCa0bzDO2KeCEUZKhnipLx/MI/Ph2YvWqmA1uy2A
 JjKJFsa8PjAMbbPFZ4zyiboLAg6sM9N8Y+rBSk9RLFGIu9r4VMAx7RmzPs6fdneoS+Ifa8vfaaP
 ZFd5pUi9Uno3aTzsRp6y5bRKGMO+hrVaRALgSL4DTQbum6Fz7FwGRdTZT+y+k7VvZKufBMcEX4m
 /Wx7op7Kfy7zZmHMc4g==
X-Proofpoint-ORIG-GUID: hQJUMKC8kliDsA1ddAirkkkillZQy9XD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfXwX2rJhM8Fmzw
 M0LlssZxsxVQ5t+WRLxWRMVTpl8OgWRdSz8h8Qn+vIsKM9MPrJKy/XuDEOxZqwItqii7uqMkBWL
 aEyefP7uWFp2MoLuvVgWN83vset9Khk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=4xXTe/UnsyTFgY26K/kh4z
 by0Tr9ZDxCaoAvs62aV6U=; b=XB87KN+SfipU/8vxsZ7QGBIkLvgsL/XaK5FRxa
 E3iT6Q0CTWnke+37nn7D1uf6w8eCATSBtuQZuTclq52yBLrq0MMEXUeDKdznlnlY
 5C9RKSa8lXonZHCmbO+lh9GFNVM9dZ/Q5EfymP8tH2nmJ4n6dl1Fp4S3jhSUIEr7
 QGVomrflTViv8bvvv3sEmlBeP1GgnBWPeNUV1Upoc7crU7RAOuqttrdct11ExT3f
 wUhz+CKoU9NRRb3eOtpvXLwUheM6ZZh+Pkayx4TE32SkoJ9vfa53l/abnhGHn1wt
 MLjp3EfduYNZoVUNIA8TfRVfHaom4ZOU8HPNddqwZm3+NsBQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784616770; x=1785221570;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4xXTe/UnsyTFgY26K/kh4zby0Tr9ZDxCaoAvs62aV6U=;
 b=CNqnNkcizTIa3Z8Rj4vdd0tq7nMZZ976UFHxkR5iHyRSP0ziGj3OMHn0Jf89oLDlhL
 QUP64/7ZNi4SjGCCdzJQPV+4VULVU1nu4601TErgC4GbMySz3XQL0mtTcwE5ilbBl6LZ
 ePdTQjwb4MUkOPia9S+jtC3mtNt/fYO5PBHJo6GKYdAF8gXNYxp+7h8Be9vQc3Gi8I98
 vvaJznJsk/KKml2daNwkc7q6IA7yUrjb5xCuZAJX0/n9oANoRCrXf0m2XcxMqKjkAmKg
 XSeQdgVvLJluK84NRaKLPE3bkWIV6VW3suEyEHPZxcI5GVQ1Zn2O7ucmvpVUxPi9Xe6c
 ZaJg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XB87KN+S; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CNqnNkci
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

This patch series enables eMMC and SD card support on the Qualcomm
QCS615 platform by adding the necessary clock support, fixing device
type detection for proper EFI boot handling, and addressing controller
timeout issues.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Add proper error handle for bdesc in msm_sdc_probe while setting
  removable property of bdesc
- Link to v2: https://lore.kernel.org/u-boot/20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com/

Changes in v2:
- Moved removable flag update from generic mmc-uclass.c to platform-
  specific msm_sdhci.c driver.
- Set CONFIG_SYS_MMC_MAX_BLK_COUNT to deal with controller timeout.
- Link to v1: https://lore.kernel.org/u-boot/20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com/

---
Balaji Selvanathan (3):
      clk: qcom: qcs615: Add SDCC1 and SDCC2 clock support
      drivers: mmc: uclass: Set removable flag based on device tree property
      configs: qcom_defconfig: Limit MMC transfer size to prevent controller timeout

 configs/qcom_defconfig          |  1 +
 drivers/clk/qcom/clock-qcom.h   |  2 ++
 drivers/clk/qcom/clock-qcs615.c | 46 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/msm_sdhci.c         |  8 +++++++
 4 files changed, 57 insertions(+)
---
base-commit: 042e45e026c77227319a426940577856ffe62e7b
change-id: 20260721-emmc-ca0e6f3c5e9a

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

