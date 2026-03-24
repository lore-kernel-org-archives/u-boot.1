Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BC4F532DD
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 05:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7260583952;
	Tue, 24 Mar 2026 06:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PPqi+BAo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBFyOVoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E807D83952; Tue, 24 Mar 2026 06:52:58 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7312839A8
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 06:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O3WNNH3903829
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 05:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UKkn9CjDwLH8s92mmEz6huklBd/ZhGpgfEX9gXH8fjM=; b=PPqi+BAoB/x2A/CJ
 Y6Fris2ay343oMSEO8pgckkeTZlb1hB/etz19h/C/FRrIOgKsXmU/ylnn245w17G
 F2jDROCCS/eTIcdkPa4XJc1XNg8oVRV4bSuXYWhBeIHj+kHStirKBjy94Ou4NY3S
 mE+Z9OKc1lbSJV3xPVKzDOEghNZKPxu/Dtd2F7ejwvNmi/ICn4aUOTFISFhl3SlN
 FbJQBXF6RgKRRhO7Gk0B2seRjUTAD7oP+fxRwHmDGTk+WVXtFaf730DT+WmeOLLa
 xYO399p2ZnhA/mD9kEDN3V6xS7rOLxT+u5y7aT82Ruzi2l3U64Mazes5kNA+thp4
 LNsnxA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jt0gdpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 05:52:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-829a655f5e4so2107367b3a.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774331574; x=1774936374; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UKkn9CjDwLH8s92mmEz6huklBd/ZhGpgfEX9gXH8fjM=;
 b=QBFyOVoIsmJOKNiY5DhEvPW404SPvLpXcdTGBFef6gXShYizHgDe+pHgaIXL/W5p+o
 0UGvAQswfuBZ7VohijhsJLT+CPOZQaGliSiNktMVGWxYfNRr1rHPS4geEqERBCKfRru+
 CxD+fTo6CNPiyCJQo/adYyEi6vsQPQPYzj4VtDaVZlG1rN2cie8w7pTeKM4sAO7FAB6n
 CrKfu0AeHPiXmToENxT08zXb0b68f+mNIgVg5sbqz6uA7rKvMY3WtuErTTE1TUGoGcoi
 o1ocHarTJs6+P83gVm4R/hglkBvZQ6H7NTtwVykTddZBHIYQ+BxjbFjBCE9DLaeMFJ5n
 Qjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774331574; x=1774936374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UKkn9CjDwLH8s92mmEz6huklBd/ZhGpgfEX9gXH8fjM=;
 b=I/curD2O4H0QtPQ/iAPiTqXKnSZ80HQmLy1rIoGmI+AkES0xZ8VssGRAqk7UTwIYJt
 PTweWZipn2xkNHSlss88ZVExmXjkUHmEzrAYZQQFdVeasWveFyLGWtbmkvi4CKxIyptJ
 Ntj7v5Sa9r1Mp4gY/abP8xcISQjc1xT+QmqXl7vtX6JSMqIFdOdTGTZ3EL8jFyHaVduu
 a/V6nSvS56sesVhJuGQGA4VdmYyazhgtasutxg6a1TYe+OiAlwjBya1nOHkExYezW1F6
 8cRqcMlnGw76RlIxP1yPPiCnLBCgwIsl8QeaLkHCt2kHT546lNvbulocfg9OJAylWSJ1
 wwxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiunlSQNnGgty3MejV7pQdYd7X6G8grVpEy9dEhTsuhkGY9WevLqud9tV4rp6tpTtN7s2IyOE=@lists.denx.de
X-Gm-Message-State: AOJu0YwxEuUsKdNJU7O63H4EOB696IfW1N1ikefXd2yi5Nu3EeTW18bI
 yLumtH+ra/R4isgjZz1Jw6k40FWv3I0KRfCBXANNVJp+x7L0cALUgexVpE7CSB1r2oN4zSfCHkh
 jQztyAwLwNQor4zd40WOMcLcqYlxfA2TilTWxZvkmOm5zNnmpDE+lQOqv1E/QpEmW
X-Gm-Gg: ATEYQzzMyYX8vkQ9KHfZ0RHg6FJ71+S5YM39VMR4IPiCQlvSIKDcQSl858Ynu48bI/8
 vD9SrBt+teqy1Hqy5AyMIJd7TKqt2XAe54oUmR40Y69qhUx5oVkDQBiG2TT0XP8ZdagmiZQInS5
 T060Mo2mq+wIM1ihBxeTp90gZDBK2uSoZFAZFP5ogETqdxRhhuj59Ra9Y/hCb1j5kM77LjtYqig
 yRvDvHtBV6q6Ium79xu6fJNM7J8HXPiVreYb+VoqpmcB1C+kKskudgELhzQjFn1TKY4/hrlNbBM
 wRxa/bFij0UqCifUeWZzniaAOVvAr/VSyuGilrkiceHoPy4C904e6C+HR0NMRqbWxK39LT2apU8
 +fDj3UOdtPQVEVvCL9d6+VhN9KujdhlsTiC+iNXoVbW7tpCSOYfP2ZsRWbYPNsT+DmGUOELg+mz
 7eqi5NXBK1MYvQ5pMVlnG5Av837jmnCR1cb9CjnFQGYvCI+Wh0fg==
X-Received: by 2002:a05:6a00:9293:b0:824:ca0d:bd14 with SMTP id
 d2e1a72fcca58-82a8bf86225mr12026383b3a.0.1774331573837; 
 Mon, 23 Mar 2026 22:52:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:9293:b0:824:ca0d:bd14 with SMTP id
 d2e1a72fcca58-82a8bf86225mr12026364b3a.0.1774331573311; 
 Mon, 23 Mar 2026 22:52:53 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c212ac8a2sm12874783b3a.17.2026.03.23.22.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 22:52:52 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:22:35 +0530
Subject: [PATCH 2/3] drivers: mmc: uclass: Set removable flag based on
 device tree property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-emmc_sd-v1-2-883a45538b6e@oss.qualcomm.com>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
In-Reply-To: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774331557; l=1580;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=TYiIZvlXIAph6dtABNp3HKF0dHWPALqhoAXR/ZVmU2I=;
 b=o69iQooT3QLnb66WXvOLvOxKBxwsCPVSHUoTrZ8qF2vuYMA06f5kYkXsixJUypkabP6ZRrVFO
 5dRfUpZHAWMCJ77ctmzy5bbOtBvaZuBaeg5AICx4Ba5HgvmGC8MuQXu
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 1aI8uiMi0BmxSlAplyfJWV1SWOPYuP4y
X-Authority-Analysis: v=2.4 cv=Nc3rFmD4 c=1 sm=1 tr=0 ts=69c226b7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=T9czmWveQvdZQJR3pJcA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 1aI8uiMi0BmxSlAplyfJWV1SWOPYuP4y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA0NiBTYWx0ZWRfX8aK19msxCLJP
 HtI8+5ykp9hrG9bbf3EqLQIj4FSGUlAeaXNYMGULDhAa9hpOlTt68yqbt5FaHOEvEJJyhHdV/N+
 ase+1Uahu6wN90v8uzUtvIUtynO+OZyJ/fUtY//NYlh4pPhvDmzm6v39IjKZdYSfVktqHr+7NOs
 gkG+cEoD0ycsiMYP1bDIVUUpZ3DPjmO/azEM9sVgOV/tSZC72bpQXwOFUifNt7GgRX9csH1I2DV
 i7l/bTaJMm/CZoamHacez+P9OkjBTQWxrjfo/KqqdQNMbRcQ86SQYwCtj1XpsejqqoRYf132vr/
 PDQxrkBSVzwYFpt1T/2DvQbgAjeI5/myE+BhTZ5gi9cnYiTHfxgPnn4F+rGd1CI9cASerDFrBpC
 DutZSkmmxB4iNlk7diYTLBCSH1T0fdtLENTOQPgQuFSYbi8oqp3BPuWFAXTmV0c1X7W7Di2NtZv
 gWPKa7VoNroOc0o/ZXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240046
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

Update the removable flag in the block device descriptor after
successful MMC initialization to properly reflect the device's
removable status. This allows the block layer and upper layers to
distinguish between eMMC and SD cards for appropriate handling.

The default removable=1 is set in mmc_bind(), and this change
overrides it only for non-removable devices after confirming
successful initialization.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/mmc/mmc-uclass.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 698530088fe..b218c69b494 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -507,6 +507,7 @@ static int mmc_blk_probe(struct udevice *dev)
 	struct udevice *mmc_dev = dev_get_parent(dev);
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(mmc_dev);
 	struct mmc *mmc = upriv->mmc;
+	struct blk_desc *bdesc = dev_get_uclass_plat(dev);
 	int ret;
 
 	ret = mmc_init(mmc);
@@ -515,6 +516,10 @@ static int mmc_blk_probe(struct udevice *dev)
 		return ret;
 	}
 
+	/* Update removable flag based on device capabilities */
+	if (mmc->cfg->host_caps & MMC_CAP_NONREMOVABLE)
+		bdesc->removable = 0;
+
 	return 0;
 }
 

-- 
2.34.1

