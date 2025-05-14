Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14C5C3ABCB
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 04:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96FFA82A7B;
	Wed, 14 May 2025 06:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SPTXyfzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 095F882A25; Wed, 14 May 2025 06:42:48 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C706582A4D
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 06:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E2O52k016770
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qE5JeDKglcU
 Q6KVU6eKpsOffPxWWTZcIXz92uNWf814=; b=SPTXyfzhN8IAxHFrRsfdTnEl+2B
 +hANxHoVwYAfNqI5+0svd49ICU/Oe+D/Z2cs5iQuOqriJXey5YXkAQqemU6AH9cD
 4nSp6xF0q+fHg3RCn+f5U+o2FG+XtYgZ9sUdLy4Z1y61McNnej/RjrJDFml9NcN6
 CuN2iiEEMtErpQjJTeLmFrcMVOPygWcQqix2lqirFen3UjWNoQPn2MFgcyFFTro3
 SrsgusU+98WJp1+UT5jq7zOnA8Lfsz9qS3GFmJ58XLvslCDuuTRbDDgk5vIGAUDS
 k6ti6OGnpeIH4nezpbdcvWKi3MKKgWki3P37LZEgYdt5VzIr2prrY8INVSQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcmschw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7424d8944b6so358494b3a.1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 21:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747197763; x=1747802563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qE5JeDKglcUQ6KVU6eKpsOffPxWWTZcIXz92uNWf814=;
 b=KDLefZ+hIuxCqkK/AZiOD0LWNrCKUTyt1/9nW6uMxiTnz8EnA+/QCLNBylCMeKa2F6
 R4tgat/k6DdMCek385eDGeDoUxETipAHwk9H0xpVIPQAOKxqDe4pApgWTLo6VfPNS6bn
 Oa2wmTaj4VinswsO5th/3mZUY1lfg0uIpbrex0T2Eq1zKi5Ux4q65lU7QgCRBg4SgLGE
 JebToLttMA/1OSjEDDuTdKF16niHmcKVTjDK5R4j12bdQZEDwXES2jituFdFeTkNSXn6
 pczVk4sN9zP9yx2XCPWIpvaVpjXwK4goVQGJWO83Aa7XWVlYRQJFBnrIIKroRIzsZl9+
 qebw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ATsyvSijIwDGZrl9eYC0z5oG+yHlRttbtPBp8zAwsvG0rSyEFtR11ZjyX3y5RzMZ4b8x3cg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6Jq3QU5j9p/Kcsg0r+e9Wwugw6uZLuDgnCdM8rL3HE5Y0fn8J
 Bpe/8NPRuN+18S6A0MTDHoSdmAs0b8tmlrPIwlIZHYF6QqRzujGLYD/pcs2yQosu4qIAp0kdX1b
 1m50Ndwu64VAVLMbmpGWDfnv8Kb1xWrb/xqn/PoIJPxIl5HQOCtMz
X-Gm-Gg: ASbGnctb/dsV8pXUw+GJoLeDOCyOWF9Pph3OI9vbmY10SczOy+dMHkRfNkBtX+Vq0uK
 FurUQA0a5PdsBnsJw8zci72+s3Ef0uMnDPurXA+GnYV4BrIxDED97RU2L6nw1g6uB/5A6lhSsEH
 NDTeZIQUbmuL9Qe92mXU8k2DjWa2qf9JgjNvDaO2E7JV/eq9kNDtfPZfstjyArlGNR/DIu5Wz/d
 eX6pBoHJwSOh8x5xNoO5muh04Ljgmc0gKLZzJLvn+LGRtv2m31AadfS682w3jHWfJWG7E+rTYb/
 16rDyebpNTYQ5MRd8reVRP0Pnceo3QwjBD64JBypNCmugO1JllThw3EMNqKtmJsMmN86DwXib1m
 FIP09zTeCUImKRGgRRpttPyKoN6/5hM0LUk8RFmtx
X-Received: by 2002:a05:6a00:2d94:b0:740:58d3:71a8 with SMTP id
 d2e1a72fcca58-74288f83a5cmr2991763b3a.1.1747197763149; 
 Tue, 13 May 2025 21:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjSvar9nwzpoCpRogTeJRkr+N0Y1Neo0Doqw4TykJoURqioq0KlN0h5hKowSGrPRhSxyKKYA==
X-Received: by 2002:a05:6a00:2d94:b0:740:58d3:71a8 with SMTP id
 d2e1a72fcca58-74288f83a5cmr2991741b3a.1.1747197762769; 
 Tue, 13 May 2025 21:42:42 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3dbfesm8889588b3a.138.2025.05.13.21.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 21:42:42 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 4/6] phy: qcom: Enable QMP UFS PHY driver for QCS8300
Date: Wed, 14 May 2025 10:12:10 +0530
Message-Id: <20250514044212.1422714-5-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y3DAOBkqyPygJmY8IsFYMLwvIB5J4vGk
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=68241f44 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=y1BsHS5AD3v-cz7rSzsA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Y3DAOBkqyPygJmY8IsFYMLwvIB5J4vGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAzOSBTYWx0ZWRfXy8+zSK61od8Q
 YH95QRdkhE7AX+HT+3saJ8LKFgwZT3MsmEAQWiZFigcBT64SNi15jOLhtav4XIEIz1CdrhUXgvc
 Epq/svLf0aBfxB0UrvqFZe4hVQJbOYthImp4QXawe+KFfUqEFLRHCUgC03DBelCsoDv0lllTr6h
 ZxE/16pnusISXBKZ0ry6ITXbsVVGz1xcJ3du/nwgkQYwMHvy1PLSFoWaMEuVQtBX+eD64Sm0zP3
 ndzR87TdYsTQpMqZrg04Sacln/qwRUxmwV6GAF40To8yKQWAGvCbGZJYw3ZwTvYdebJaAnyDvf4
 B7oOURQFeW+G+I+7AUSGdtmvDoClF9TmThGb7LP6tA9+P9KTg3zQxCN0mu1qeuGQmjpKGEKaWPx
 Gsg6LKrQo5C40EFGHL2yIstiwmkK/SO1KCiOXBwlaGAUSUxmP8S6o06oRbEDRtyYzcPpAEWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=969 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140039
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

Enable QMP phy for QCS8300, referenced from Linux.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v2:
- No changes to this patch in v2
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 449b9767778..18cc665647f 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -1469,6 +1469,7 @@ static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
 	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
+	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },
 	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
 	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
 	{ .compatible = "qcom,sc7280-qmp-ufs-phy", .data = (ulong)&sc7280_ufsphy_cfg, },
-- 
2.34.1

