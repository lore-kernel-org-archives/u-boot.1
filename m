Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6A6CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 16:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E9F884873;
	Fri, 19 Jun 2026 18:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgdbZEsb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJmch7KD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5B084873; Fri, 19 Jun 2026 09:34:17 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9731F846E1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 09:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=manivannan.sadhasivam@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7S11F4001582
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 07:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=h4p9piVfh+9etyk9LJnfwqOt47k8FlM16m8
 TyotLEnc=; b=LgdbZEsbAPeGCQE9p/JHvPedlJXStYf36ruOXeRC8pMUpKVOkMG
 8tq5jarGo20Sw9w8hnhQHzpBR82/qoKS7keFR0ZUNPzygIkW+4DdZzqQS8DtuAy7
 YUkUT5qLrq7u6dItfRoGPwEw8TAWTk0IfEaMaqa8r7Cqu26Rid9XRJi1ZhRXIWoz
 2O/ibOagIn9t1x36D5+cblUutPKfxhWbrmOAd6mUlodNpUUSSR1d8hlXce08xlNl
 xYhBO23tUxRYYdMsu9fdGuByq/Se/Vxw6+YEu2FLEww4pHYMoqyO4kiChfsPRW8I
 YltppQMg14q3sYlmhVQ2GFn5k2R59QJs6sg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evpyut3fu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 07:34:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c6a997c400so23377285ad.1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781854453; x=1782459253; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h4p9piVfh+9etyk9LJnfwqOt47k8FlM16m8TyotLEnc=;
 b=aJmch7KDNuD1FPHuhIXz853SzyF7SkQ8jjoxcw1u1k9A7PKUYnMm1S60f1oppi0gSh
 wnzzQivMVpMtDNtslsRRxF5YR2tHjKMx+evEqTkNlh/afxv5MKAZkgevKa9wj+LTPKTx
 UyEK+qVXiX9pwe7pznpm4Qo7URYmH/gXx31+lawr9ngZqABGyN4fgYrOoDnufQXUI+/r
 6U8WEmrd2RBqsdWdc4b4/oxTzRHFFGiVineCJXSMu/N5r2mfGxqhlEri7U9C+Yhbs3Zi
 +JDr0zscnN8rB5DraYglCEEZo/g13jbtdFlzVIRIKOx/Xw6hdu0+odaF/Oa2uCWGodia
 nikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781854453; x=1782459253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4p9piVfh+9etyk9LJnfwqOt47k8FlM16m8TyotLEnc=;
 b=Mf9FS5naNa87vIQpXZWonoKZiXrofk/QsQ0Ojfcy9/NU3auoIjIVM/SfE+oPSqwBDq
 hW5ygr98yLb8AcOv+hy3xhItdJamqwnW/KUe0I1od1B5KgcmZnI/LqaxYxMd/m1MtOJ3
 nU6UxJrtNfCxawjNHhvbvcMpH8yxEdSiI0+EzIjXVkjUfDr2/bMHhjxmW83TFS8f4lTU
 QMoOtohc4FcviP46I5tq80tsjnbTMJiQtcuO4cchkD8IoSlcpgPRNmRTX6ypbo178b/e
 SWLmSQb6iXX11mVgQTpI/l2zyR1UX/ThwAIlxggV2T90q0az+r0fpDZpJS169sRkUP4Z
 uDHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/a3nC0PvIA6V3P5yEsuq0TEBZMF4G7uKL2Gpm+T9j7/hTkn1YGZvYqn1MYqegZby6H7UyO+h0=@lists.denx.de
X-Gm-Message-State: AOJu0YyYIECtZ7RmVas9OpADpZ9iin9oY/L003Txkftvz1vYYjBjejKb
 oQFoafP7J4nDQ/j1UHRTPVadOKa3e+nQY/2aFfuJvxSzD+T1kU9+PwkkTDdysunwKAPpHxpkyCf
 ZcIgRf8qFdwGVmEFIoXpTkJofFyg62mHMmFaxp/IO0on4X8fp6+KcrH8w
X-Gm-Gg: AfdE7cnRk7on42v3C17PaynMVPyLUGZijclpgC46lk1x+cx/aNOys7fKiPrWFzxNMny
 Fcc+W5xgeQ/aZHH66Lgbp8mXUv65RYvBb++pLO15uRFdQptT/RSo2FuZuApx1VgQi1Bo8hOCv6J
 E0bxNUpgh+SGtPz8utXOzXqdjl2HRsbYav/NNLmdSioDZ18VEw8lP33262O0KGLRUbUun4ssm87
 OgQYbBR6zBGbsOOgwBWoWx3MdP3KQRDyPTAMcQKaUAwGo9YkwkTm7q+KcPK04rQ3A65yxu8c8Db
 /iz4cXUPnJBYPxeF7sg1xEqG5o0+OQf3KffyKfZFrjbWE/kwBQEOS3ss51y+xtllQ+rSP0nvLok
 SPWrdjoOONd9HP/qNd7IbvzUPTJPT7He0RuGHMbb3uyXfuIS6U+OGEIKGh0Wp
X-Received: by 2002:a17:903:13ce:b0:2bd:d6f1:3388 with SMTP id
 d9443c01a7336-2c719653813mr21963405ad.28.1781854453004; 
 Fri, 19 Jun 2026 00:34:13 -0700 (PDT)
X-Received: by 2002:a17:903:13ce:b0:2bd:d6f1:3388 with SMTP id
 d9443c01a7336-2c719653813mr21963015ad.28.1781854452423; 
 Fri, 19 Jun 2026 00:34:12 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.68.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7209bbb53sm16395235ad.51.2026.06.19.00.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 00:34:11 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org
Cc: sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, mani@kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH] configs: qcm6490_defconfig: Enable SCSI as the Fastboot flash
 block interface
Date: Fri, 19 Jun 2026 09:34:00 +0200
Message-ID: <20260619073400.387171-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA2OSBTYWx0ZWRfX0O7VJ9G7Jlwf
 39rZNLakxdpZxuD7ZzbKcL3pmVrvhy3NFeNKWOEOgtpMC9Y9mWtPjnzb0rzV197xtcrmmcnmJM/
 aULOeIBbsKWwkOx3Eo8T/ZwRF0C5rC0=
X-Proofpoint-GUID: _79MimFdGXMzSY4iudA83fIZTgEAsJd6
X-Proofpoint-ORIG-GUID: _79MimFdGXMzSY4iudA83fIZTgEAsJd6
X-Authority-Analysis: v=2.4 cv=cY3iaHDM c=1 sm=1 tr=0 ts=6a34f0f6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZRjYPw5CqDOT13eA26lF3g==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=g77dXaux-1903aQYT9YA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2OSBTYWx0ZWRfX7IwnRsZ39JP/
 F3xa2WaoinPpcrBrkwXcRUWMzhGkOoWxRtryHi/+hXCvA1ljunacBXJWLlAzRCTRkjdOYAhwLM4
 Q8r4vtisANvjVj9OSlpNhjEV0V+NZsRJMBY0jnKDnqcxzMMBoESK2XZxaRLRA5uJOJQumE5qUVE
 IidEIEYWcftMQbrkEhZrSRVRulxglLrS3uZ2Ol0YdWOjRcVXCLsghGBHCZKDT3uxUEdEH2YkhLb
 4b4rk5QZUa0EX3I2b0BEP4/g/1IWld7lKH4QWsoaeA0+0Wlk25g4t2uBQXH882XOvorK8HP4SkY
 kBItCI5Zz36+7jGG83Ea3MTlHZm44pgzxjFQo/GjH1FV9gijiS8U9hc9TgC+lPvSTpXq0asR+F9
 B3FbD04uoqz2KCK7VLygLYQBNdmSQORQHyMG75zgVID4It05oqeyVT7SKesL9urcLTChxjjEEHu
 gG4mRDMuYbzivgE2bew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190069
X-Mailman-Approved-At: Fri, 19 Jun 2026 18:31:25 +0200
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

qcom_defconfig uses EMMC as the flash interface for Fasboot, but QCS6490
RB3Gen2 has no on-board eMMC. So override the config to use UFS as the
flash medium by selecting 'scsi' interface.

This enables flashing the images over Fastboot on this board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 configs/qcm6490_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index b088367f86c..d599e7611c1 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -16,3 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
 
 CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
 CONFIG_PHY_QCOM_QMP_COMBO=y
+
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
-- 
2.43.0

