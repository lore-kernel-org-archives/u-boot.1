Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCC7C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EB3E6068B;
	Mon,  3 Aug 2026 15:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0yg3Fcp2V8Cv; Mon,  3 Aug 2026 15:49:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29A316060D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772191;
	bh=UMlm2TSsV44ln1Ba1DQGE8BGvmIZo5VxsfqEVm4LH6c=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GwHAbyX9vlQgE+9+5E++AeSceTIariC3Xu/iWku8BxX63fEsu8I1JnabzLaXKULrL
	 SrK6MY/vHr6jyzMxxmWP76ognNxViloWr5FN0ApUfMxiSsnxpVAakgd5BKOx3vBnVt
	 ROecmYm8nRJqNzUlXH+4TNiSEPbuau/Zkmj+QxiGsomeM9ZuFPCPjC/tPOo84PE5ag
	 0SOdG6FTbQUI914F+iFD+XU6Uh2GdyPcKTVIUwcdHrC4Pcf/oiYoV5R/66NfhlRFFY
	 aC8R9dKFZ1Drlc6+k8ekW/5cQo9lZVtmHNsDaXQPYX+uq0NbXfE9Dx5U+L/2r+RTcr
	 yPSoUrt+cDF5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29A316060D;
	Mon,  3 Aug 2026 15:49:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 854323A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 776266060D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tiwildy2EHEJ for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:49:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5D94B605D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D94B605D5
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D94B605D5
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:48 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673FJg6G2173084
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:49:47 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftwhdr40k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:49:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so5917991a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772187; x=1786376987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UMlm2TSsV44ln1Ba1DQGE8BGvmIZo5VxsfqEVm4LH6c=;
 b=pP+74/CF+C1rHP0xAgdI7gkJHlwAbu1L5wt5u76becmZ0pxDlr9I4PEpyYu5uJJe3G
 vB3gSyvqD+Kbpw1XQH0UTZrAEpF9Xsz1JH4PIu06CMqsh14VmOymz5eAUz51/ONdbMCY
 4EMgd+LVelk4XG0iciyK4/vW2xVf3i2rbWlu73WZT54qgTXc6tBFcku0auAqImpcRvku
 faw3fF8DZk6Juj1XN/AyeGhhv5cVzRUdbF8mnYTHqTFJcCoOTSS5pIVCYVAxAZ8XPq//
 yvocx6HlXTnhm3WXNo786NJiM1E0zUqfV1cv2iTNwecD+ce4BQNHRxYMswS4byPfap8T
 qq3g==
X-Gm-Message-State: AOJu0YxpZY+LThp48pJM9XVK+XA+iQIJ+x2RONyaw1rI7TQHHWmFs/Sm
 SjiFAfS6kSE1QONhYquwxKoCEhOLbNywIVEP5P4GyO8nlYehNVcHC8ypMxeEb2E4oEzQTIvdqqL
 yc3PYPDW09hQEftNVk0soOn/A1PUf8gQtf53BVjcfblmw/2rjL8MPOuO0dAzrdC+uSHUQV2Y=
X-Gm-Gg: AR+sD13arWl9rKUiTjthZGnS+FiiNZJJ8mTC6TlLGMkP6kq12meSrnWVYoz0To8kS2i
 QHMfX1glTC93OzZ15pFhdt1e5AyyHa54/vk4R54R3AA8vgqink6XwwqAKDj61Vl0opDk89FgFTI
 4OXMeIxz6w+QZibnI+wagdiGfwfWW8ntUsb3tql5HCEhjbhHAknhIRZ7FcYhxVNPaPbw0X8J4D/
 meHJH/nFwdq/KkMRhrH6TpG30LIwiwb6KmwK2VvA0ECa6IcTrPjY/gP+OObJwUlYHd5wMPYZQy+
 uZvbouqS62gbLrK1YV33znK9eMPtT8O6lb8Wk8stugc3Y/TBytmC+3snuMV7tamUI5XHsoDyXd4
 oExaNK41ukDhEiabApRoRTakbCE9ZJyl4YbFNV/DlXqZbRhe5CWsCdaT3ibqsW+6p5Ws3JG+kCz
 bNj5t6MUY18smbkO/KDAtKKow8yuEZ
X-Received: by 2002:a17:90b:534e:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-38fbc42bceemr10266572a91.13.1785772187043; 
 Mon, 03 Aug 2026 08:49:47 -0700 (PDT)
X-Received: by 2002:a17:90b:534e:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-38fbc42bceemr10266548a91.13.1785772186612; 
 Mon, 03 Aug 2026 08:49:46 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab13255esm29356854c88.3.2026.08.03.08.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:49:46 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:19:28 +0530
Subject: [PATCH v5 2/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v5-2-00ef4542934e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772171; l=1415;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=uDfybh3CZbbL3FOleOALKwIqgMmVn/y32Z8xubXPGUM=;
 b=oqJW7Z/WzXgGKO1zS8NdUDhhZpP2OJb2vH2RsQT1sAi/A/rkd+frecWOkq4sSl2SBTXFuHQ+F
 RAEU/inZCABCoaVlkSNLIwbR9ckS82Xr6MpvcerFF+6x6OCczV+f/fL
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Zf4t8MVA c=1 sm=1 tr=0 ts=6a70b89b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xAI3I7ZSbV2oIbCD5NEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: QAHFEcBJKB-MWmBlvxuqmCqiGga0QE9j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX4dl9BTsF1mnY
 2QmeN6gk0OZsVeVHhLmnBae0xeui8KiNP/x2fhPFfEIPn3Y7F/7zwCiwnEdRc1WCwSIdpRfKPZX
 OJ1x0g5e2InS1L7jpBBfdR5ngTqmx3DQKm7jPVNmhygBTLrUjAs5VGGrvERPlgdXx6O1/hi5EMe
 LmR8+VhZx6202DFJU79ENOcEY85N9qPmpJIGY7Ys3yTHB5sDY9CEd/+Jy3jVdLRzodyeA/Fxh8Z
 GXjHxrl8dIY8L+5o4IZPsW5ePBD6D9Y5Oi4lyCVJi2lgyYqwrfuArijJVVaYBhadrWA/nt+xike
 PlkZkGAibkHHGmM9TJDLu0oYfBA6TaVVhOqrw0oW2LyihXr2JN0IkJYFLaJ3SF0s1OBsJ/vmOE5
 I6t5mpJxWF8pZfQPq7JXpUHuCrC53szj1hOV/rRFKI4mjts4p6B50y/7eGCII2uKyaKJX+ENY0J
 e5FyHUHS7SAQj4vw+oA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX8D8kA9xJ3vty
 Gxf1ieONt5J4iJwH5lYwHPVOgHsfZZnGvAChYy6bO41A8l2oA8CSGhyEu+1YrrTIx+k7yFrQMAt
 dIeVbHpnzWYd51Ka8cGfVCBrx7HiWBw=
X-Proofpoint-GUID: QAHFEcBJKB-MWmBlvxuqmCqiGga0QE9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UMlm2TSsV44ln1Ba1DQGE8BGvmIZo5VxsfqEVm4LH6c=; b=kLBoc+YniCFvC3oP
 njpwW4aLJsutZPMBys5E1d6vwUuXdigJr/ydE7OOz/tMNmXIjFt1KGRJOfbj00nq
 EhasjlBzp08DBLGnPKHEmKI2aGMc3tRI4qcLI5nwxHNwj33OpA9Fs0j98pIUEYGG
 X5MiuUIwbh9cjmienx1FwhYkJJ1Nqnhbve/ZhUCh78/QsdsIT7wo8hqSMd51ghuL
 NUUIIYltv9vrInispxS+ijHbGoxwTrbkI5MIC3jndVIhmZTTNWV5hZSTev/HXxOc
 6MRaDvV66qKKeohh2WgLdvswrL1pP2lanD4m+uCiv+o8X5HUUO0YfGPsrpVORXzb
 Iil/+g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772187; x=1786376987;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMlm2TSsV44ln1Ba1DQGE8BGvmIZo5VxsfqEVm4LH6c=;
 b=iYY7q2GDZDudxjLY7FnUojJPTtmrF5HDK0A2FqVmYdj82tnh9Gdwq+0WtNo1/6vINS
 ABtoDZFf8dBAslthxLHpd4beaVw1wjUC0jIzViuY5MwADj/EXFLwknTfd8k8rckKmChp
 5nnL4qXq/gvXym1yYyQ4V91Kgd/TjjHtyFokKxbmY6jAsRTrOmA3zo805QYTTmSMGsfS
 Z+7nZImF1Botb8TMeV3mk3qTmFh3hQmGN0svm+t9uhzCqM8OB0H76+mdGiGc40k00zR7
 pUFDdxv4FmdXotUA6PJp3xvq3e+F+3sFvmZiG6H8zP+3XRH2cQkUR+e3U4kP06Bd+8Jy
 Hb9A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=kLBoc+Yn; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iYY7q2GD
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

In snagboot mode, U-Boot is loaded directly by XBL without PSCI
firmware support. The functions show_psci_version() and
qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
CONFIG_ARM_SMCCC is disabled, causing build failures.

Hence, added CONFIG_ARM_SMCCC guards to both functions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- No changes

Changes in v4:
- No changes

Changes in v3:
- Added CONFIG_ARM_SMCCC guards

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 9866a3e4607..8eba08eca20 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -50,6 +50,9 @@ static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	/* Some older SoCs like MSM8916 don't always support PSCI */
@@ -73,6 +76,9 @@ static void qcom_psci_fixup(void *fdt)
 	int offset, ret;
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)

-- 
2.34.1

