Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEA9C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6DE3405A1;
	Mon,  3 Aug 2026 15:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vs3b4bt8Bbzx; Mon,  3 Aug 2026 15:59:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C954940547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772753;
	bh=UMlm2TSsV44ln1Ba1DQGE8BGvmIZo5VxsfqEVm4LH6c=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tPj1IvUL25OQwGso8Oj6iKGwKxsRm9QRpJ6J+w+TiTGjN/85icdLXWzniP2olUE/Q
	 71XAC7MZAPi8/dYQ/dlqlayV78w21Tz9XnYC4XpvSltFp5unWpD5un15Rw28B+zR+j
	 uM/k8BksWToRIlcol8VQlYVLlUxPRTF4Wc9co/XtOZDDO+cOgGLlCEQHw/r5FafdD0
	 PuaL5n9JqzLekbrTVvozow7yw25jozDTQbPrsDqCiLUH0hhdYYHqzTCd2T6I0xT6p1
	 ZG8SSP5+m9cy0q6uhJ9TpbaMGtK19pQq4loO1VGPxUXgpw602jsZciFaLBE87bYNjp
	 ueBxlBEI2Njlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C954940547;
	Mon,  3 Aug 2026 15:59:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B77963A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A970880B49
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEGsrrmIegXf for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:59:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E336E80B96
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E336E80B96
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E336E80B96
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBtMd636331
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:59:10 GMT
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftp4r29f9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:59:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84842381150so7028746b3a.3
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772747; x=1786377547;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UMlm2TSsV44ln1Ba1DQGE8BGvmIZo5VxsfqEVm4LH6c=;
 b=B/N5mRbVctkuSiFuidXBTN/vy5D2gPFsaQXgzQdh5Ss/ZcttvY9mD9MM0mrqDhcf8m
 JENdQbJMeUn/WANIxdnzythyEC4eljY+TPizXSy1fWmLO6EA1PlDXvq0FPqtYb+cwvRY
 GU6SjOnE9R3tZGK7sU8YpVe229uQgcfrnHxkIdgxlHhmdITg5vWGqWC5d1u5DeRl9vRH
 IfC/IowyQPCZidmKmMDGAmIbxOi+t60DigV+vW0LJwOPX7rxl3u24FLNwU6HugjB9p8M
 PU6Jkg+ulDfL/sjsV7fkz6ocm7ExxsBhDTxF9FFGZYBY00+Q3L/lTHoqTlzT6kDw2UQB
 RLSQ==
X-Gm-Message-State: AOJu0YxqkkpaCpckhHdFKKGLuHb0c4crJ93VnjJZwpHF0j8LDiI1rGIv
 AlkpU6HP7+LSJ+vWVz3ey5dVfEXxLnxcz5BKXcrYZ6rasWTLg0tQRoLIZo0zUzKIXX+sewGmlKh
 KYYJvuknGHYxFYhQxnyYeCsYJPark6TSs9in1/Uz64KnTEIdREs8AyxSv7iiMucXv/C3CVm52iv
 q5uio=
X-Gm-Gg: AR+sD10RVRtOmJsd2tdZiqbMLmLVxOCYu8yXYounxO9zyQCr0TUI2tjLDGZhLxgOdD+
 +S2mW4YiJk0ZhMpFBFIkW8eh/Tblz2GwJaWHND4OPuqHvom9i9n7W1g0WmMgsNIaF1cy+tSm1GQ
 K4m7LHcKRNWmyn7sPWZOsk99o8Bcrd9lA/vBh9gqq5DTOYKh0W2yqTJ6f3QwPytyMii07yH9+XT
 ORp3EvtgGP5dKdhLgrkNuVSRfdnfYiTVgxm/CvaL90/P46Oi5ny8Dd8TQaNtL+PldkfWkhpdvDE
 SUToYyKevhG+r4yLTsfHUfH/1bqIO2V0Hh+an5HNLhqAhxuXm92hqemCFv5v7HhoW9UNGhoO3VT
 8TRG7BlcNzNgifSnSylwFj8CxCcH6lbdiXXvOn0I21D5Q/UpOD9zGz/PZYEQA5ytgeymnMZxAmj
 W4FBJpFG1YVqEW2NI6bF5qCcj1wD+B
X-Received: by 2002:a05:6a20:1582:b0:3c4:2fe1:fa29 with SMTP id
 adf61e73a8af0-3c92a8750d8mr11433891637.59.1785772747276; 
 Mon, 03 Aug 2026 08:59:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:1582:b0:3c4:2fe1:fa29 with SMTP id
 adf61e73a8af0-3c92a8750d8mr11433862637.59.1785772746719; 
 Mon, 03 Aug 2026 08:59:06 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c1casm38955713eec.10.2026.08.03.08.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:59:06 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:28:47 +0530
Subject: [PATCH v6 2/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v6-2-e8bf7a6fc0a4@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772731; l=1415;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=uDfybh3CZbbL3FOleOALKwIqgMmVn/y32Z8xubXPGUM=;
 b=WPQ6gX6gmsZD+5gBmO1HJSHElhpfbp5353K1S3kgZGY2lF+neMIZgud6xpoB+xJNza6PmoeC4
 y+sJZBy1rHIBnKbrCyU3oxlBl9OmfZ1yuOxZbcRV7VpNoP4gMGO4lN9
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=X9Ri7mTe c=1 sm=1 tr=0 ts=6a70bace cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=xAI3I7ZSbV2oIbCD5NEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: R06QsjfoOfIoLR5RekIPQ40J9816lPbh
X-Proofpoint-GUID: R06QsjfoOfIoLR5RekIPQ40J9816lPbh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX/80EiVxq3XW3
 8+7luJ/cAGVSwVgkGzlRzmRwyLp7uvsmMotiuT1ZHmvOGZ9Jkkz47p+B1IZKlWhDmlOUP9mKUbq
 l9p08u95noyL5bXSkL1kVj+O+05E2BY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX1HgYJV2zRZNT
 6/B0A0DqAz8WVFjeNG/1qHu658BjvqbAN0tRj0sDQsX7xVd9oePmBzlwM0LOnypvuqvkFQ1stXz
 ZShtggPxHXFCGeXgLohq7XqHsuJG1QsqmXocOi8WgVEJBvGoX7bW3ZznmJMhw61mHfcqdYsAqda
 p0dKmGJnlvokjjjDZwo9kge458qv2lx3kKUfs8HeQKTH3iOcxqJSJRwQ2HOge0QXEZUYSRVmFBG
 6arnNE/a8oHhQim2lcrSfv9VeNELVjoiIounkGOl4xJOdLeo6yZkPpmxAfXEBO4jEU8sMebtBwD
 FuKtrMUJGkLpa/8K6zyQF2z8RNn3tOPnnfNDytiLYpfwgN3shw3yuq+MVgEHckwSd6LwPFmw+G4
 WOCGg5TgqqGtWi/hhMFbWLhgexnr5NAYyOgW9E7rc2FgmPiH1J5+r9UeiaQ7/JA/FAKPpN30UWw
 lFR/DmrMyRFDnY8IU/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030143
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UMlm2TSsV44ln1Ba1DQGE8BGvmIZo5VxsfqEVm4LH6c=; b=aRFx8MTmZKt2kiC1
 S8v0Xo7NF27Mx63YkF7rlRSHKpvR3jxmIc0MJqfyJ05QmMvtWesr7Fz0a8KhST/A
 E+AC/BeUHVIuz6rAgUQh5y93Ir7QiUEf9Tb0P4MutZPht9Z4DSL9x1pyxNNAGjP5
 QFh4I1mC6K+IxMPVdtvdlMlaAY7jihepU0p6wnuTKCvlWsQEY250OIrY/QnKm9M5
 V0yJ6DfIoyuAdbwlhJcb6PmQYyLqlQfzTsLP+AgjbXCamhPVqjU7RmpbVw/5DdoC
 XK5HbDifsjw4jBVeLdYWli6LmGxuXAjkQGaRdBDtzb7yBhHsla51lbMEMgoM9oA9
 f8HDVw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772747; x=1786377547;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMlm2TSsV44ln1Ba1DQGE8BGvmIZo5VxsfqEVm4LH6c=;
 b=aGAbM8Rdt5lxGRJVZ5sg8gEIseZJu2aZd8BZNq1cZe9zmqjxn7K9qN5i7qHn1h0D5E
 6JHeZDZPZFCZgZJoWcHeeB/QUnLWRmSy/Bd/3X9AF64VNxtf2K0UHb7WoHKRPSZjpfxA
 v46HinXE5Jstnfq69eSqK5mseuGjAd6FFxHg5HukijYSAM2JkB4oDA9malQZKjCFG5th
 JduyYuqoLeHUyVsgBXP2pBpMx0xKyGW0QazT1aB6/M3NjB313R7w0+7dUydaXkZFFZCr
 FXOOlMA0IH7OqCepf76JA2Tu58IbV8Cutzlv8CbTgmAiTIOKgZ9YzA2cwbiv7DWcfv2b
 1uew==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=aRFx8MTm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aGAbM8Rd
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

