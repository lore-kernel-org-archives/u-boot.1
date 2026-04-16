Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2C6F433C7
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 05:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72B0840AB;
	Thu, 16 Apr 2026 07:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XdBIKcpQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ju/8+70o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96ECE840AB; Thu, 16 Apr 2026 07:12:05 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFC983C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G4TDOo1553076
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=F/jwK1zTCEyhoI/iLoo2rY+VeIMFvnJeR2O
 YoqSAnq4=; b=XdBIKcpQTBEeZUiuBBSLdyGHPBOSKI+LuzbnqeCanF8vMn+5Yki
 d2L0JLzHxxPPO1HOLSN3eKVSeWNIN8v4jJI/d+7f2EPf24LcgtuzQXkwBX2dlHmT
 MKZyRizXJe2U2F3SrSMnORLsbWJsMifOFWZSaeSukQh1F2mtBBys7PbI6XEhsEab
 2Oh/ug0l0O4RCSAGeVJHxI7N4iILS4aPP9sZOk/xjuHuzeTnpx/g7RWteu2k3oyQ
 Gw7lNN+f9jnuOtyiYcQtR5ER26FfCpxKnWL5NNs4HehjQFJTxYau3aPsM5XC6spl
 A/1NCRLN0s3ZEeHpl4IwHRLomXrbHsXs3Lg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djrsn842j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:12:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82a6c70f1f8so5113278b3a.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776316321; x=1776921121; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=F/jwK1zTCEyhoI/iLoo2rY+VeIMFvnJeR2OYoqSAnq4=;
 b=Ju/8+70o1ryEStdkxcr6OKGSGEQNht0n7kLnQ6mVf7j56GzXYCRYTV3RTRyKWAEJEo
 NHWZAbmxM1I/N+mS22OJJZ759dmb7XUS95FbpsiPX9ULZcdMHSMWH96HoE9ol+2cjMEN
 dIF54FfeV/Qxtg7TFD92EDyw2AjJoZm6FLgmVBuRu7YYdu/+kPZewvIFUz9uxj9Y78mU
 fBOyT+EVwRL4FZfl8p8sVQuKqSAzf93SnsJ1UorBHgBwkN0/rlJDCm5Uvn16V6bpTriF
 vOus+ChczKPkS9rM1oAU0ELPvb0+V6YuNfGpCOZsUC7iO5bflQi5MtOrPwpyXqsafR4s
 tR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776316321; x=1776921121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F/jwK1zTCEyhoI/iLoo2rY+VeIMFvnJeR2OYoqSAnq4=;
 b=dIp4Jo6GSbFyt6lO+DZ5U5O/v6fpfyIcewfMLGVEG23LQiiJLVkYu9GIulPnfjVRd4
 HISz5NEPEhVUNrdOFyNSVXQrVMGb/hYQ+KfHFShyotjKJXYHM6uQrxAufjFlHzKsbzW7
 t2FmrgeRw/IIDMIchIiUt5AtXMxa+6ll5Yp4VmGrhV82ZWdmkLwTuJbfFz0uif5qvXCO
 7o/yoJHiZDY9Jz9cl9Q2kl0jcprcBzEyxv/fIyhMLA8n1AZKqgfFMl2M9KEyQkGJDboL
 fTZjsZKRFbn4WQm1NcfHeidz6kCtA2jOUmicfFaMPufE32natReFN30yOQ+takpz96Hj
 dqDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qmrpNrb+hV2tLOfPpUMufg7RM/H+0VDkZbGdVsQCv+fgj3nynNwteM+Ia1H5O+0qSJw31XBo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb9F2DeYNK2f6seSxIXkduieuYaihyGUSf26b1od22J12C2Rwt
 ipPV8JuHcCNp77VaYxuCHJBBMPTyRV+umdSfFXG7rK5jBNGUAQQqfiYi2M3HALJm6rqxhGQ3GJY
 Us1qjI/+/mhfFjs9vW/nPjvUIdbzJcHwSBIBrHI1g8QicQyBesVGhiys9
X-Gm-Gg: AeBDievJIJbDA4/d5pDN95UgrOvKyQTLI/snvpxV14IWwv+yU0SebmqgK+zJu14N+mU
 mLy/SrD4lFfIFkvvIKYIO/cCqWqF74c5idHiqoKcvhQ+JGORyG5gnpgRNgmSt1Yc7FVk2ysPRw3
 49+IsvywJMfZOL9YVt1DSrxLkr8WChPNprKwb08qAw7r8l0tbWoHLRlnor6soP4hCCHqrHqkZ5h
 u9MhzrKLE+Pu4XkGkgTqWmFG0P/5z9CzYNEyw0KCCITjlBeJ9ZAxGf7JoQdHhV/oyVEvS+yQtOe
 q8QB6JKxJ3SgKYdEQyZQGHt8tsqyIRJsbqtvXxpO7LbQu1eTWgV7Y7GoCuHcnBU68xAlzzsjd+y
 AgX9p4Tnv6jA8CbRFf5v01XnAvkk+cjCARZRGnn+E7XKvxtBSmVOepRHV94IFQvuPYUhLFZ6HPO
 LzkaTEDz2Q7JVl1ulO5OyaWehbI74qFMhCuvYrvO+WAxbkQ/fRLsg=
X-Received: by 2002:a05:6a00:1946:b0:82c:dde3:f2ef with SMTP id
 d2e1a72fcca58-82f0c35f7c9mr23823173b3a.50.1776316320691; 
 Wed, 15 Apr 2026 22:12:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:1946:b0:82c:dde3:f2ef with SMTP id
 d2e1a72fcca58-82f0c35f7c9mr23823150b3a.50.1776316320151; 
 Wed, 15 Apr 2026 22:12:00 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f670374aasm4352919b3a.12.2026.04.15.22.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:11:59 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, loic.poulain@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2] mmc: msm_sdhci: Use max-frequency to get clock rate
Date: Thu, 16 Apr 2026 10:41:51 +0530
Message-Id: <20260416051151.2825532-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4BSv3HCEt4yeSGQoFxq8f-MnuEQZlfmo
X-Proofpoint-GUID: 4BSv3HCEt4yeSGQoFxq8f-MnuEQZlfmo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA0NiBTYWx0ZWRfX48bj5wLXLZ5V
 QMuLiQOHTgKx4TA0S9YGX9Q6SB7FDTHsdghLXZ16vsqLA2AJo/0WtlXaaVCJH4Ck9qYXXr3Vaim
 SCcHYs9JEjXbj765KyXaVj2u7Q+0utbwnJHKy4M6I+iZby//8PgDOtdtnIP21DcvcWOGCM+oFdz
 GfNRiWITpCTzpG56I8SMcYRl/7A9NOVVsCo07juG3QVl1cqXlZ/1cTieNAnxu/LPmoRDBMavdsc
 J9xbwOyf3Gh7ElsHkZlRnXTuOx79O3Indb4nUptuxA2o85UFIgp1vUEie0vj9pcPWuCvuE2kyo4
 Gtr+n7pkfEY3/Tw7BrrZ3If9tIGWa8XvHg8P4dt6TjffITLacuF5Q2zalAtdbU4NcLXZCwWeW7W
 GlGrn2HTlqaQXkLWiPDl/A0KK0oAKWnCRd7Ldmo7WW7/RtS6RVjOq1ikkacgx3Jdf2pihUCSQRJ
 cRo0OH9SIAEe5xweuWg==
X-Authority-Analysis: v=2.4 cv=EojiaycA c=1 sm=1 tr=0 ts=69e06fa1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=YBpYqEoKsAOojBjESW8A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160046
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

msm_sdc_clk_init() uses clock-frequency to get the clock rate for SDC
clocks. However, the DT files seem to use max-frequency for the same.
Since msm_sdc_clk_init() doesn't find clock-frequency in the DT, it sets
201500000 as the clock rate and this results in timeout errors on IPQ
platforms.

Additionally, clock-frequency is not DT bindings compliant. Hence, get
clock rate using DT bindings compliant max-frequency.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 66f3cf2de4f..aaa87923604 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -71,8 +71,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
 
 	var_info = (void *)dev_get_driver_data(dev);
 
-	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
-	if (ret)
+	if (ofnode_read_u32(node, "max-frequency", (uint *)(&clk_rate)))
 		clk_rate = 201500000;
 
 	ret = clk_get_bulk(dev, &prv->clks);
-- 
2.34.1

