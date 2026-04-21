Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0B4F8FA71
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1886841D6;
	Tue, 21 Apr 2026 15:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UFAg7Ebp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OOy1Sgi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837E483BC8; Tue, 21 Apr 2026 15:00:36 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492E6842CD
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L9no0P046130
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xezJYEmgRPQjcSs0pZ+Hpoi0Uui/ZV5odBiKclxrND4=; b=UFAg7EbprargwjM6
 yFgZZozx5/cyhscakJTPXI4gIIBGet9RdOkcHEsmvUOVtx3A8Hq7QojFY+Ib+Wzg
 WP0A4L8Iq4TY/rEo+x4wlzaWsGFT7Q2iBUU2PRYvg4sOvPU5avD1F5eZ18PC77sC
 aMCRm6UgUn2SCjfeD4S1/U81oMgrp/ySUWOxrNRgjzr6V/jwzjyUf4t8ireNQNYL
 tE8HpX1az5IuG1+0MLoZ5ek8m25qT2A2GUi/NUExgJleh+zSO067W+HKVzzPcH4K
 WmWWAfvk6ZB09SuxdvprQwuV5kIaqC1iGkJ1DszvipCvKSGM9rYlwZUGEtu/cyEu
 8gJK5g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp0y1t0ph-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:00:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24cd2e2b3so39972085ad.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776776430; x=1777381230; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xezJYEmgRPQjcSs0pZ+Hpoi0Uui/ZV5odBiKclxrND4=;
 b=OOy1Sgi0G4ECYCXEk3OijLJ8w1pU4f34ZpUoipiB9RbnlnSpEXs1d2BHO+sgjo1Hxz
 gO9BrIYTHhO6oDj2FFcHpUaka5DRX3cudRFcvPWWC4WVReVPAoCODJVSd70IJfbiQ50L
 8j2gEyuw+gou/j5U2BCD2c3NcssLWriLf3kmLIcfRt4TX/uS1z6zhwUwewaARsp9sQaB
 FkkOVd5+lHr98R4OJ3pxPmtRTl2fvv+n/sqc2RNcP3TYc2BHY2vSsykFKXJalzqqsADE
 IgLLIRRDpYizD70359C0NqcQ+RN8NcxYlZtQiaR8V5jnNH0YD/5qoGQkjsgn7+8hTf3j
 A+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776430; x=1777381230;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xezJYEmgRPQjcSs0pZ+Hpoi0Uui/ZV5odBiKclxrND4=;
 b=bmNERjui/8XqgrPX7LqZTzUQYvzgSNxryze6qOtjo4LSE4CvEr/iX/O1VSZ4rtDSfW
 OI5ak4z+2Y4+HxCj8ZC7aWiVSANht08jobxnBUH1l7AKrylEQbGnFH+qB/8BX4oHLnFh
 9E4AjScPjz5vDXbzN7jSKo92MDxjPhu4WER8g2Qua8eWtUmP2jzvJ6Lj9k6sKZ65MQB6
 Dkcx8ldGL6tyiZFHOa7YNKnczehO7tCSjSi2dZyzew+9D478q9NwVOTuft/Kjqt3nv9w
 tGJ56xD+FAMCdILrOlg+Q66azZv10VasN8RQpYgcO1H05XTVe0xXghl0uG2UY+jdjpc3
 M4UQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/m2LZL4oKK8dGkqp2FM6r4tidRfpIk0+h2lvUs7vQ/t9HYAAMWt7/Qb4WVv+TOWEbifeePRhs=@lists.denx.de
X-Gm-Message-State: AOJu0YzzX1o1JwGi2rWNDY+LoJTIiXfCpDtXePJP8v0lUNvYMJrktrhA
 1rKAnAVei8EFZvwKa8em3RSoQ8p4PdRiDPQz04GygF/LqqKDDziNJ/ney0L3/CLxXIG3pENphYu
 xgOsgLVhz7pHP7LzQnRKZf0/LucuS7TeQhGVp2TvJ+MoWfaVHKaRZoZaq
X-Gm-Gg: AeBDievKrNt7Jw8EIO3In6uCt/HbU8UI/nr1lWfAlO7BNihlrv51IDkZ2B4H0N4izL0
 u3aM1IqykdytRPHQ09RH6b6wvGeDQlYMq3ihkHMDpCFIF7plL67OjreoxfMTzc82DBpwlBIBvlD
 a4kXFHWMC/E78Uyf1HXdwB5Gl59n5a6wPgFu/FFe2aHueark5BEy3F8eFaMacLCV6fFzBooDLw0
 lH0FqT2h02FAWups5CYSeOSegdtGzJCfT1LiLj9vqvZb+LGOpUsBJSjpSSejG+X1VAlZqj7T8Md
 MOC/sq96D7COcYY8u3qvVhdyhKZxKqZWiuH1BaD5MDFgXz1x4nZZ3UD+r0nfZBu3Ow+nKNCLfme
 1G/QF9y+Jkq1H/0RrJkmEpNA2hAQqAzQB1E80oP60uQG55xKSVboiFmjt63leKThy/QGOw3ePll
 evE/wsmP9tO4RpdDVo4CUYgh3VNNjFkIihL9s3Lg9pXqBPdjEaJJ43RBk1oz9c
X-Received: by 2002:a17:902:c94b:b0:2a9:e8b:5326 with SMTP id
 d9443c01a7336-2b5f9f51e59mr171282475ad.23.1776776429575; 
 Tue, 21 Apr 2026 06:00:29 -0700 (PDT)
X-Received: by 2002:a17:902:c94b:b0:2a9:e8b:5326 with SMTP id
 d9443c01a7336-2b5f9f51e59mr171281615ad.23.1776776428658; 
 Tue, 21 Apr 2026 06:00:28 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cb92sm130117335ad.50.2026.04.21.06.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:00:28 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 18:30:09 +0530
Subject: [PATCH v2 2/3] drivers: mmc: uclass: Set removable flag based on
 device tree property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-emmc-v2-2-0ebd3322b676@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776776410; l=1844;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=JrvS40pjc/azUCX9N8yLSKcxUAOuzgbKQx8jXDu7EhY=;
 b=WIZAQru/cw3QSHArLCA4+xk8EVOAzrdFDFamiwZ3lpxW8mUNIaDiGaNgakMFkCGvsK+/env3W
 rMVfCxcez9nAuzJmReBFK8SolCXMNYXU5fpvnHp7JbhdIyh5G2c1CCp
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=69e774ef cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=XGATPFSgMOfaP4SSs2EA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEyOSBTYWx0ZWRfX99ghHuOoi1ku
 dhB8jJ+QRzCvVSMLmN6lnBnBMnb4stBFMvTNCGuaatL8NppeA/OfxovFifU1BFwvt4XzP1lPwrc
 A1go5WmPMDE9OmdqCGj0HivwtYKHlTiSi7YjQUMslBe6ufVBtOPLBR97aOX0EaxRHqjHSQYrjEG
 7ta3oqyHKtWDCHM47ocSZpOSXYGMc55bFVPvjwXzLw3wXY2GwnTewsH6Wuqdi2fqYH9wrTyGV7M
 rtO3bazte6MFJMGwA+psJZ5M2qvZ6xe5wLHuUyDukV+SR3hUpYaOqwLpx9A0z7JKqIkJrYk2/wO
 LCdvifIxtnXZPD3nCqZ0PyxxXbtwlkKB9R0Odf598ziwV6F/osD+cwcRw4tqpzoHOiAJvXRU8cB
 J+D94VibiPy8IYoLlAlXZLucthkiybVFmYY2Z0gE1UMrsP6OJ6i8hb6tj9isgi2clMaU6spxF4t
 mCWXIDyoDUPfEGgJMzg==
X-Proofpoint-ORIG-GUID: Nk3H1hyVw-iTNhaLzdqFi9m6o5kiTFkU
X-Proofpoint-GUID: Nk3H1hyVw-iTNhaLzdqFi9m6o5kiTFkU
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

The block device removable flag should reflect whether the MMC
device is physically removable (SD card) or soldered (eMMC). This
information is specified in the device tree via the "non-removable"
property and stored in the MMC_CAP_NONREMOVABLE capability flag.

Update the removable flag in the block device descriptor during
controller probe to properly reflect the device's removable status.
This allows the block layer and upper layers (particularly EFI boot
manager) to distinguish between eMMC and SD cards for appropriate
handling.

The default removable=1 is set in mmc_bind(), and this change
overrides it only for non-removable devices after mmc_of_parse()
has set the MMC_CAP_NONREMOVABLE capability from the device tree.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Moved removable flag update from generic mmc-uclass.c to platform-
  specific msm_sdhci.c driver
---
 drivers/mmc/msm_sdhci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 66f3cf2de4f..13fd4ae8a7d 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -189,6 +189,7 @@ static int msm_sdc_probe(struct udevice *dev)
 	struct sdhci_host *host = &prv->host;
 	u32 core_version, core_minor, core_major;
 	struct reset_ctl bcr_rst;
+	struct blk_desc *bdesc;
 	u32 caps;
 	int ret;
 
@@ -252,6 +253,12 @@ static int msm_sdc_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) {
+		bdesc = mmc_get_blk_desc(&plat->mmc);
+		if (bdesc)
+			bdesc->removable = 0;
+	}
+
 	host->mmc = &plat->mmc;
 	host->mmc->dev = dev;
 	host->ops = &msm_sdhci_ops;

-- 
2.34.1

