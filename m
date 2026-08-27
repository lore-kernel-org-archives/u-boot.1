Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D763DC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23808406BF;
	Thu, 27 Aug 2026 07:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3x19ilSPBNc; Thu, 27 Aug 2026 07:33:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816031;
	bh=9HQb9V96+M7HmLbBshz5FkpDq1MwtH4cM2hrEGTLBTc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GXMPaKQJYVvHPmTrrVU+DK4Mv2Qv1As3no2X47Cvuhh+Wu3zzWS3cEHiiorwlzjc9
	 7k9oiDUojr7O8nDloloF4DqHFNoWG2RsAisfuYf02pEl3XJ1ZO/JbXQxKHH/nAIltN
	 sFVyIYxdxG4wCrT3Ou/sSgRMG3AViKPxMOJS376pX+Lt6oMPs2Dt2IVkeDoDPOD9Oh
	 8UXEtc/RzDxKZhOJC5oEPrmGfltgESts0+qEqBHCXhG0eNgbueVqnGS0Izclu06Io/
	 2QuhLMwuyE1a+1ybIx/iAoq0LaG3kEXLFhvKkeDSxgAgxX4wgTs7rBggbfUWgS+0za
	 OXI3tDvWygnvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F962406A0;
	Thu, 27 Aug 2026 07:33:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0C62334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE5E480D09
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ujb08KoZsR0j for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:33:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yb9peq69; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Oyemqhfr
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE65680D1C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:48 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R7KI2074777
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9HQb9V96+M7HmLbBshz5FkpDq1MwtH4cM2h
 rEGTLBTc=; b=Yb9peq69unwJjjIJO1anwaTjTZuJBRZFoAobG+bdVoYfhXhWis7
 u3h/11RZ5nl8n67lpDwqQiDcrQIF37d1EZMrTrc2xUC96F2nzH4poJ3+rUU1aFqH
 hr0afeN8obBpMNphOAOOvW8gW9ROVIh5kNBKX59jtSFQBwoFvrPU7uQQ/bQY1r88
 1yuBxRmBFHt42WIAag+Nle2PPH0GR6PnZyAnbq+v/mPEXGvYvPQ4Bvs+MlL64cYH
 ioZxSt/nanJES8N29hgyPPjgVwQTfpQlaN9To1KWZI0xeZjnluOKVAAm/L5WROoQ
 ow9pObLmsn4VDFGKNYVmi1cxzqkwdsNt25Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bhd7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso408024a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787816026; x=1788420826;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9HQb9V96+M7HmLbBshz5FkpDq1MwtH4cM2hrEGTLBTc=;
 b=Oyemqhfr0+ZBhKpKikSitOPJwNLfOGet+uKT5FPGO8eCT41PbnneSKFbjoJ7byd01k
 wOY6wtrugZoPXKl4sP41T3nJ+ACjD/4HaJ1Q89XqXceQ+/9++42COXxVU7x2bo/rOTLh
 QKH4bg5wXwikLTuAz1XqsT93eYJu7ZVC+wzZ535k4m96Sgpa06yD8DAOQde2XuitkasN
 D7J2QQBxlKDWqO413g4qi9x+0oxseUVRO0gb5g1cpLVCL35sBMJkp+nrBEy6zgEBcmRK
 YAmghsFzmGgTOcyXDE5+pCtvpSoqX+y89ET6CME0Jk/B3tNgR4Sw+QNv0HMNYmsmCxXO
 MAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816026; x=1788420826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9HQb9V96+M7HmLbBshz5FkpDq1MwtH4cM2hrEGTLBTc=;
 b=FCMz6RkDaG8cLOUnvSowISICMQakH/SnfT6FH0H3TSMBqFyKnMvRsyHOWW1myoy3Nk
 jXICD7Rs+oetflWOjNhpkjeSspx6x4u4w6uWTnKtc/Z9ASGAfE7XMIZsN0H91NJI96GX
 zJcwA+fuCkt8CwYuqVrln47G449XWzfzXi25eyuEyXKrXXVUI3UFZC5jEHvShDzMJ3ls
 mSV5pRwJadP1M7UBFnrtGGTevzvclq1/SMllrczDbd5+UCfSRHZXsvpfakvpJg+u/U6r
 cjz332XFawHpgNh/TBw/774TkMiJEIPFYE9m4SXTWjXo+tyz3dz718BYrX3ioSraRgX1
 JA7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPjFosmCzQViMzUwiAYBbdBIxiIbwFQAF34YL1Ex7wPA/GTHL9PdQjbyBpyF6xmYGYlXlQ9rU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kj/8mHQM8TJHK6FHMhapOfLXjuhhlNRFL1KZxPG70X5bbXNCuS
 hNJNdmiQUBwYVLUdO5VHV+UHbtwWXCRds6ZfwvgPyMPrrCDkFzpu6g39FWvYGhCsaan484JPfTY
 1QZdR21PxX7OG4nmeN0hJkh4eoyh1fadL+n/4cufHuvSVkCc18ZNPtJObbU+kOEviJWPQkDQ=
X-Gm-Gg: AR+sD12TiVgOkZGX+qAFju37avA2arhOaaxUet5ITWNLd/3Fr1tKucllP2Fb9UGA8NY
 0aJlWX1Ba/FOqVDS6PMgB0c5mXxsHCxLSrVdlz7sBVcMNz8QQh9b1d7BM4Nu/8h7wakBa30jeVA
 UTuIXu5YFoXVGJn+0F58m3cN448l1baMDO5Alwd6WdCJF8PnL/JDnMWGpl7uBhi0gUITnlaVdyS
 4I2Buyq0poEi1sWrFUs9IyA5u+HDwILuAkn2joo6jFqeVGlhBx2mkmLiw/UVPG+qbFF4BKggGgK
 ev0IIfID6KY39y1PZvOUe6jTs3BHWxVZMVv6NsVeqRFeO2TMSYeuYlpir6FlQEAwIJFPk7n/hhJ
 KhnNTpI0A9FonAOksOC1uYL7kdpzyYd7cMLwWONJF0lXDLKqCR9tulB+4ogaDv4U7nGWFDm9E6r
 cW2p9GnKLkRsGC/pDpviA=
X-Received: by 2002:a05:6a21:8986:b0:3d0:868d:8ccb with SMTP id
 adf61e73a8af0-3d0868d974amr15239521637.13.1787816026138; 
 Thu, 27 Aug 2026 00:33:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:8986:b0:3d0:868d:8ccb with SMTP id
 adf61e73a8af0-3d0868d974amr15239431637.13.1787816025756; 
 Thu, 27 Aug 2026 00:33:45 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d8dc465sm15146713eec.24.2026.08.27.00.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:33:45 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/3] qcom: Enable HS200/HS400 eMMC modes on Qualcomm
 platforms
Date: Thu, 27 Aug 2026 13:03:22 +0530
Message-Id: <20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX4dlvkmmvlHOB
 w6yiVLDYFvV31eHHKpGpjQidBq3724/VMgY9yJSugdsJ12XuOtpE5zku2ciFSe0kcwK1wIfafbj
 4yj2q78nX9JUpaZdKhCGmt5ztMOZSr56EP+R7qBAqhoXlxcCPlmiQF3hrJPhhYalMleC/ujtvM2
 9Yu681dLKPkgI92V7oucYSeTEryJMO8GBoatPDIiGtkzkHwKbxsU7sCKeAfJsxOTSydmfu2A80a
 mVYUf5+gEhtX4ksnHARlBVZKVyjhpMqby6pirmGL6hDJ/WSFpph61oP8nXoiybkVeceJWlAzkq7
 i6Z6DmKjho51ooPUiiQ3t7wG/RaeXvDUxhd3+jrw/6D4OsbP3bs5wWQvDGJ2wbjEWPQ8JvS2hsk
 ffmnb/96HUYKOtze6siHktJcaeTtMu5QHuKMAaJyi0uvgZGMyBvu5o6lzNbND/qQ2am9uTEaiAC
 I2hMQW4VNfr5NInpr+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX5U32NHoehpO5
 dxCSu4EMzLbuQkABTgFIrwD4bLrTI4Ww+u2sIzJBkubSMMrCYkergOJmA1fBo7TsRgCFJRiQGgL
 HIl62WT9OeUzS6oZ742M1AeigRNB5f0=
X-Proofpoint-ORIG-GUID: uvFiKDUecTTbiOIdpbZUr-Jn1zMr0nlp
X-Proofpoint-GUID: uvFiKDUecTTbiOIdpbZUr-Jn1zMr0nlp
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a8fe85b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=ZVmrP1e12zO-epOluA0A:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270061
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds HS200 and HS400 support for Qualcomm SDHCI controllers
by implementing the required DLL initialization, tuning, and calibration
sequences in the msm_sdhci driver.

Qualcomm SDHCI controllers were previously limited to High Speed and
DDR52 modes due to the lack of HS200 tuning and HS400 DLL calibration
support. This series enables higher-speed eMMC modes by adding the
required controller-specific programming sequences while preserving
support for the existing SDCC core variants.

In addition, the series fixes an issue in the handling of the
"max-frequency" device tree property and enables HS400 support in
Qualcomm defconfigs.

Aswin Murugan (3):
  mmc: msm_sdhci: fix max-frequency read into wrong-sized variable
  mmc: msm_sdhci: add HS200/HS400 support
  configs: qcom: enable CONFIG_MMC_HS400_SUPPORT

 configs/qcom_defconfig  |   1 +
 drivers/mmc/msm_sdhci.c | 860 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 859 insertions(+), 2 deletions(-)

-- 
2.34.1

