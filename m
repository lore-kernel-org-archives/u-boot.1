Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F753F8FA71
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A5E84307;
	Tue, 21 Apr 2026 15:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zsv1jcD8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnW8ARus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E7383BC8; Tue, 21 Apr 2026 15:00:44 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A168284307
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L9J2jR046050
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AipInJ9YGZUCHnp2SHR2m35ZW+8Vdb5775FhpZs6NCk=; b=Zsv1jcD8It0ClkuU
 ApD1O+UTHWMBOhs1FCG7v/CJl/wc4r24Ts7BJUaPWhBYOaTXQgHu0wSbqiVHr3B1
 FnLTn0xRodc/rdDsNeoZ6P0mCGRc+HxMCNGEln49MWYNzo4eGxycxgomb/GUiumV
 GQgDq/XdDm0pkJKj3dr14t5ESyrW4NXws03dTlMbguucwoGhQxHtYEjzmLrpABAt
 T9N86o83FghFdcg8frdcqDeY4wXoE/+boFk0t2jusdLh8Fs0cqFUC6ZHb4Dl+rCR
 3F2PUkRxn2SGVzxo6g2tHLKLGR0ECKQLvO2SfY7MW4lrLe2B+cGy2dJIZ20icchL
 k9B66Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp0y1t0qk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:00:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e8ff14e5so32685115ad.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776776440; x=1777381240; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AipInJ9YGZUCHnp2SHR2m35ZW+8Vdb5775FhpZs6NCk=;
 b=dnW8ARusUCm5CCpYwQb1mmx4M10z+1sRxYC2lMYt9lcYCPcJeVkTst+YLqJdnzvWZp
 1meY1fLQvouM2an64WeUd1NaAE+LshRyRQIEj7rPKYNyqKezSzv40oQZcGNDhSsJ9Pvu
 vi0lso9B4EwaljaK3T7IsnJ1ifw52xUKuYvQMAxEjyoX5kMAKCJiOjCF02qNwSqgCS8Z
 1ULm2fd+Ych24mAjXOY70rNH7QvtID3ejjwDMd53k42p9JOMHMQfySklBfbWL4zOWhcE
 jI0RRI8yA9zjgaOXrHAjesZI7eLtZHUKwSAgfxZxOHs0nVcAQIGHGXzM26BdgeuluZ5I
 NztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776440; x=1777381240;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AipInJ9YGZUCHnp2SHR2m35ZW+8Vdb5775FhpZs6NCk=;
 b=mwdu1aGyZ0EqYL0yw0EDRJdx62XcmfdFYrIh0KyUKlXi0QAzbaSVuaNM5uk/d6JaQr
 tMSj8Ts9hfvFH4jJObkkUtEHm1Oxlgs2AX+daUf3lu6nE/yNBB7/TwocEB9Cq5cLKpg4
 h+IaK5o7RKS1cBEm495tuZiSVwmU4oNHEoJMzHnQ5+Omyl71BzqhPMgbToTe8o98r+62
 U/Rs09NC6pnsl0JYhZV99jNxNm9KCDT0EmwE47ljhEIFmKGTTiGHvVAzchrrf6Tm9V3e
 /aauYPNjRcAzsgGZPYmtP7EBz6n6ue6ISzdcRpv37a7fIrxABv5iLHrBntYAttWRJbj6
 y+HA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RUI2Z+WIenQnedCMFx37GShklg6/AOhvn65s901Zf0mBOkW8X4M8PgXWsBJ+6LF7Gxu62LhE=@lists.denx.de
X-Gm-Message-State: AOJu0YyBTNe9N+l33eRA4Pg5o8yZnhu7SMtXZBQRzbDG4plHQxIBrlbs
 0Ag7SFH7YYQlGG6FDtKbBwZ2w+Yuv2YwTbYvfJ7Mntiv5fyThk9EGlpkd4A2LvNoQ23a4qYlF7x
 Wd/ldSNahRYx4U8WReASQwyqeAMtn/VEfPtRVzE1TxiqvSHDziMCJ1rEw
X-Gm-Gg: AeBDieu8rkSFT1xfiILZ2XjL8oiay+iBmsOSwa2lqLr3f3TsC9XXbQv3gtakaZSg3bq
 FmC4nkz84fropRibPRA2zyMUa9EF2x+Y8lH/Rcgqtpk8A3H4fNvgg63TSuPFywOPwAbrerr8AGD
 xLIaf0qnGXi9pL/niG50oBssRJnoQxCUxFlv1Eh+skPsG8khRTyG8Wzsemahm/l68npj34a+oW4
 6cz1GdhUcM5WHqeROszYRJuYWOliYAQ3T69bxPGK/E+URNXRpi4ToTzUgdR0rR728PqWoqPJiaF
 E67LVmzpmdzUcgyIkGwqca3sF7MP3x6QMk5esUa54lMq8jtVt4mFO49TxCVd5i0m9y+hDmrl9xZ
 mv5P2lQ4iUU1YLuVCyPQ/R8vBaLZ1ALCIEkC2rh//nrKcDLZeyxhF8KdBmu/aR0ynLJpwgjMj2e
 K69bZCt1CcHpUuRnEgHlMowGsGNbP1mL46W1D+mMopVdBFc0YChnY9jqnC5ltJ
X-Received: by 2002:a17:902:868a:b0:2b0:4579:ae6 with SMTP id
 d9443c01a7336-2b5f9fe1e73mr131595335ad.38.1776776435028; 
 Tue, 21 Apr 2026 06:00:35 -0700 (PDT)
X-Received: by 2002:a17:902:868a:b0:2b0:4579:ae6 with SMTP id
 d9443c01a7336-2b5f9fe1e73mr131594795ad.38.1776776434319; 
 Tue, 21 Apr 2026 06:00:34 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cb92sm130117335ad.50.2026.04.21.06.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:00:33 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 18:30:10 +0530
Subject: [PATCH v2 3/3] configs: qcom_defconfig: Limit MMC transfer size to
 prevent controller timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-emmc-v2-3-0ebd3322b676@oss.qualcomm.com>
References: <20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com>
In-Reply-To: <20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Sajna <sajattack@postmarketos.org>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776776410; l=750;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=j1ehxDvp7nFZ54pK6LgR2kXVwqUq+qYgg26diNa5hxo=;
 b=JNce0EyK36Dh2wQYTuyQ//qNl6o/+HS0cylxNFnii+wqXtFbF9w5FI4Q6RnHGAX6aW0qg2hbA
 76IjUTBy/IrAMqekYz38csbNh1/00X1CvFFwaUs9xHZRo9Am23a1at9
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=69e774f8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ejx-2cUjrn5TueQHoQIA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEyOSBTYWx0ZWRfX1OM7FTIpyhcL
 Ni5EKz+AgDs9q2yGnmDqRuMLivNmSntpNOtWY2sVqKGOaZxdW/2rmVrnu6xKmGSjol8Tm0iJWtc
 19JueQGjr3/44ihMOlwJAUC00jxS5kvughbWpISxjIomINFaKQT5BuiP+DJNodHdFeZtAR2qeK1
 N6P5kLfp3NIwma0rEFkmYgZ/ScBYJY0ciIZz3eeE24U/0aAWn8kdhYN6lOXMHuGvf2TWAQ6RuMF
 Yhu4mLa2dOeQfGHTMhpPUxwmAMFbD7OaXFFH/cgUEUECAGm92JQMXyK8HcmRzYje5zkO78+ryRZ
 qF1ahnEcvCrL+pVbatI+up6EKK2ZlxGAqK+sAOWQsvpXVpzjouuHKpsMbTv/aw97Bgb5WkhD0Le
 zkTWVBqAktboUJRr14UfWB+6OQfCzBANfRaMF7gmrbJtficIJaaGmG9mL4Nql12/A5TWyKjCmYt
 bsaGMI3FOEJ63g0bkpA==
X-Proofpoint-ORIG-GUID: wX-p7QVH3AJfkMh67lLUtvOpHocN_FMr
X-Proofpoint-GUID: wX-p7QVH3AJfkMh67lLUtvOpHocN_FMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210129
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

Set CONFIG_SYS_MMC_MAX_BLK_COUNT to 16384 blocks to limit the
maximum transfer size per operation. This prevents controller timeouts.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Set CONFIG_SYS_MMC_MAX_BLK_COUNT to deal with controller timeout.
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index baad5f09455..315107fd279 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -96,6 +96,7 @@ CONFIG_MISC=y
 CONFIG_NVMEM=y
 CONFIG_QCOM_GENI=y
 CONFIG_I2C_EEPROM=y
+CONFIG_SYS_MMC_MAX_BLK_COUNT=16384
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y

-- 
2.34.1

