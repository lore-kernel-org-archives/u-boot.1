Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE6BC2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D355F82E37;
	Wed, 21 May 2025 11:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JORvQZxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678AA82E27; Wed, 21 May 2025 11:45:15 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCFA82E28
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XMSL024821
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dwU3gZTh0xC
 Ai2m+zfIQOmr/fk5RatLGjEyDdnnyCO8=; b=JORvQZxX+ONc9mcOXNWpXSjNviv
 mduCAvvBXKQfxz6mprtgRF9z6a45oo0foQaMXORa5xdGqsywFWwh7R+3MkCzqkbw
 DfTqMt+8GptT/Yfn5atIhaKKTObMitp0JdUIB2imbd9plsqmtr6vn6iGNzWfa+/G
 MNaRT+heS7JYWBwAxpEKK0xyz+JwpUMAzTnf6M8gbZYwsUKNW53tquXzVAMAiLmp
 Qkd7axzb7ymWLY4CBRt0AXFhmf7ptQhyGpXGeMdaQ0u5BugLptY3b61md1Gb2zFv
 IjVbihy0uyf1PzNdGAL4AodE2053H2rHusOMFoZiLQSLcahD1FYQuis/09A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4tdct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30a59538b17so6057800a91.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820710; x=1748425510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwU3gZTh0xCAi2m+zfIQOmr/fk5RatLGjEyDdnnyCO8=;
 b=bON5rjKrEQjViM99dMWe1B1MZ85xW5RJWmKM5OuuC6exjY1KLmQcM+6sSYKOV2TXKR
 lvkcsvGYFyQCELUioKaWcwKde1GkA09jyXGaBCWbzuhGW7mtHit7OeX3dWTKgP6xJskL
 lWrYFnC11AFcSXtjG1Ae+mDuZ085+8p+nSisHcrt9F+3VTyfFsoJtOW54wjMRabcLTfJ
 H3NWOQw4/gn1bbg6AAUVyiRWQK/Vau30m32BjUJUctlzaP+3qxRnSlB5cMxfkrpUaHqw
 7bf9Yw1gnx2kOvZrNaOe3KFVCPgqzCflZ5lY0Kna7X1K4CLJ1EmDXKFC0+vVFSrhPoJO
 HCgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzqT1CmO28y4Z6HKm3FXtqBd588PdgT1AJukyIPusKQLaxcOxD5Lznec0p32+J8aWJxxPxhlw=@lists.denx.de
X-Gm-Message-State: AOJu0YwFS2pSJLPzSDQE5KJkKIajbUV0mt7fNwymQVuVwS0ioDDn6mPg
 nxMusGuhGTOyVUf3uZELHHUnpQWGhOMIWus02v4PeaqnVskOy4LxadAh9bhbPTzS7y2elrlj2D0
 w4xNoHtHuAZxgb4hPANY+f+z2bMVmez73NLAkKNDNF7HvapEnzkOTbN7A
X-Gm-Gg: ASbGncsf1CMzNpGdxF/nXIb+Mlltk9uuNzJ9LT+O8wZrFN7judGXMwfrBBl/YoGP1u2
 Oc3QGEP557oLOgG+Mu5b/GPOcNWEkcIPb2PVInYZnC51DtdAnlItDMeB0mMjW3lLpY7y55/JV3j
 BS6i/+XVk5N1Bb6jQmIquvYe7T2ybWkQDFbFEpL3kYFpFXq0UeXsv1Tf/VOSCgE6ctfi6LhgDY/
 6VDtzbmjHmJML2lE6q8QeLmRgv59kZ4DQFx+Y5RZtjL7SPk8xOkuVei5X+4OtoCg3Hm0PjMoMHN
 f+SCYJy06XNGID2dLQV5md57NmJaL3dumVJMp2ObqBJrl7huiswkPJ9nzl3WK4xdjs8ZLMoyrHE
 ox+FmKM5DHPeIJvnkYyrmBNXKUh+DzDLxJBnzuKu9
X-Received: by 2002:a17:90b:4c0a:b0:2fa:157e:c78e with SMTP id
 98e67ed59e1d1-30e7d4ebdb1mr32454542a91.7.1747820710460; 
 Wed, 21 May 2025 02:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENvNa3BlTN0oEPByj0KD8e93JPnrLL8EqcjqJskYpNVXNvWFvoQ4GslzF1IyDGuw9YLQXdSg==
X-Received: by 2002:a17:90b:4c0a:b0:2fa:157e:c78e with SMTP id
 98e67ed59e1d1-30e7d4ebdb1mr32454493a91.7.1747820710040; 
 Wed, 21 May 2025 02:45:10 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3650000csm3226367a91.37.2025.05.21.02.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:45:09 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 4/6] phy: qcom: Enable QMP UFS PHY driver for QCS8300
Date: Wed, 21 May 2025 15:14:40 +0530
Message-Id: <20250521094442.3522036-5-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gWiCHYN4TPhYBpN98OcHqLUS_GS0xwBY
X-Proofpoint-ORIG-GUID: gWiCHYN4TPhYBpN98OcHqLUS_GS0xwBY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5NiBTYWx0ZWRfX3N6afcjPNDRi
 D8lwd/IU+PuTwc4e9BTgbCZYu+vMq2ERJ0ZkbJSEvi5zYVZ5HK4MRYxuPgzISXp0XGyFTKz8DYw
 WTyLYs+ujPnjP1IGgKAW7HlCsJu4nZ5ft498IGRHDFeGN2Qv5WgOmK4qhhfRRooFtPrsAbBamk6
 vhPWcg2ic1yP74FM9pyamOf1rEQ25RuncsafgZmCmbGRexZJZVmC6Uf1XobIJ78EwDMnP/JcAak
 MrVggD7wQ3hCEDk8F7hMkP6QpsC/up5dcijARrPUD7EeVBwHiU9/JommYy24ux4ZKBbZ1PFMRT9
 nNy2CCm0atmAWGH9anZuw0G9bRj7cw2ezlNDxjiBV761d2T48irj53wRV+YQiWuqj2Z4FpFGFB8
 8fCBdo4hE0cYZOb2dSYIH0z3+jgsZpHkdE+TRf18DC3gpgeAF4JEqNRkdQnzqz9KWjTp6LSR
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682da0a7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=r8rJKzWKWRMvNJIZJiEA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210096
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v3:
- No changes to this patch in v3

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

