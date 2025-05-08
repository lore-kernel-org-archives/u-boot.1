Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8115C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A4D829C7;
	Thu,  8 May 2025 14:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A2wc9kbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA3282153; Thu,  8 May 2025 13:20:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A5D5828B3
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484XBpJ016353
 for <u-boot@lists.denx.de>; Thu, 8 May 2025 11:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VzaeL8cK2C3
 RlMyuOIba/lJOE2Gc5JVSI6jnbcWmpnQ=; b=A2wc9kbHupIwA8tGqkI98GkdSFd
 dbHYhEG7jYjXItQHyyWSRcVFzGcAm6shnEYzW6VnRmLdAtdxGuXI9h+2P5OdUFvC
 HaRgxEsk141mRKsz6Vi0JjW8U/erJNoXPtZpIYHhV3Bkw86lEwrtJRgZA83vuzAW
 2Fmq9e54iXSIaVGOYn9GIxWluqT25EJAQFJ3tWbQR5/JFRLuxOHPlzoQRUDaS907
 6hhjsx9f0xwJOlF55J1ZhDuR+Y+KhTJ+QEJrX4+7f2AbLbEAuzGezlvUzqaIrp6J
 RKMiAdab6+hB/t4z6wixEbnrTzJnxYnLThgkyX2U3xGu+JK1KUqdFKmJeiA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp8s3r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:20:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22651aca434so7738515ad.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 04:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746703223; x=1747308023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VzaeL8cK2C3RlMyuOIba/lJOE2Gc5JVSI6jnbcWmpnQ=;
 b=LXv6MgFdipOCQ4lHZosHBL2X2fAvtrOG+f2xHM5kjuozXBj04IpBA4IoLha1tJ/UcE
 v9IGm4fR/Gvd62Mv4ZjVS5h1SWIlmXBrRoIxtSOOW5yhc4B0CmimfW5YPguVWgsovqYb
 GHVGT3/7q8pcXIxbzWcJ4i8qf0hCQdYoK+sYroVzSZxEX10Z+KgvsCgl1gkIv25mRKql
 Mc0TdJEcrLMn6SQpX6eVwdQGj7hLoB0m3jbN5bq+EY5zLqdJXzEk27X5TDH4qBotcyl9
 jSq0+q7Dw7xqUBkTp7Hdane9Ske4RygPRxPSatwiLZUitmdvZ5bjeDfnjFGHxJ/YOlOJ
 MHLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrAleZyxbfY+Hokdgy5VnCfisXKY4RX3E81WFHAuuKB9vA8PpLcFRN6vKrsbAzMlhvuwAT0Mo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx73Wdp+ar79PhZl0Ev3YuBDL0Q304tLfu22nTnGMjzvAzrTknk
 XkYIhxNDQYmtKhL8WSUnhcBGAmhZq2eCahXy7KIdJFrtzXcv3F3cTW9+bOaeiGzhDdegobrToQ4
 5dm3JZ60VwoM5lXicrvMI4MT8c38aUDjyvJE/wnNSegQ4ktA8X8Ni
X-Gm-Gg: ASbGncuW2q5Zj8aTKrfPdqMWkaSbZKh+FEvVcjEsrcodSwdM08JkxWZENWblUjjukcp
 aVDvmWlx3Uuge+2RmIUWj1ZiuA+DGOAHemG/Mlu64ukRPGgWt9k5vx1h3tsemRNn3S7S4VZmVz1
 +2o1O0xDd/9O/k678BiCXL/yHNVAbe1GUvaeHZnPWzgReHN+WAoPPI7giBsMdeEre1QtOiaEAo+
 OuF5VLymVZQXBxuNrGOsbgGKP49ffI4zEgk7PXHe/Xe2y+uAFrtusXO/ucAoDNpWc47rTfhXlSe
 lPBDkNqeeQafhSJt5/nMefaBEeTlID9VhT31n5PKmGtiE4KdrRqMwYycqJN+dZck5ZWVBMdQk0G
 wg5apinp0mqm4IeSNZVFH28tKDjrtCVwn3JG6AEkn
X-Received: by 2002:a17:903:1cf:b0:220:fb23:48df with SMTP id
 d9443c01a7336-22e865f758bmr43914035ad.36.1746703223261; 
 Thu, 08 May 2025 04:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmEObEX8xB9p3BpDkIQS8uTSYbPvpHP9OFE/WJokeeDMFPY64zvqYsAN5gVM2mja9gfHmaMw==
X-Received: by 2002:a17:903:1cf:b0:220:fb23:48df with SMTP id
 d9443c01a7336-22e865f758bmr43913705ad.36.1746703222878; 
 Thu, 08 May 2025 04:20:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e6c3b6513sm27779765ad.220.2025.05.08.04.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:20:22 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 4/6] phy: qcom: Enable QMP UFS PHY driver for QCS8300
Date: Thu,  8 May 2025 16:49:50 +0530
Message-Id: <20250508111952.2304578-5-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ff15_fAlH2hL6B1ItDg5AbKz9pbH1VL4
X-Proofpoint-ORIG-GUID: Ff15_fAlH2hL6B1ItDg5AbKz9pbH1VL4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfX3fAfmAM2wa1Y
 8M6ldeyA6wBjTjJQG9jfdmkdDxlyDF+0rQEHmvsQipAnhPOqDBsdHORn5gByfHDvRpxbNFtqr+H
 dIAXN6yX1AGevK0GwhuDzKYbNgoQdft91/JsgvRHeq5S2tHmx5Vf5p8KcZsVb/3cgisJSK7wiKk
 mX/QiJKPhm+Se4455XBCRLEB6PKz+pM8WtKp80oqQ4zYU0KHmtNOhwauFB8Ignkpwf1PWDCXDuW
 UoZP1F78LKRdroWCzYi3ggdlLY7Xp6Tc2SMc80v9wPa45Gzkh3OYl7JxLbBR9P35Od73OZzzGWm
 tUCWpeW1yBAFhF2JFpu1b1ZJ+fi+uwLSB5xGC3yVME+rQgUi+nvVvnCfkJq1Ce3KLB0MnJuI7/x
 ny3ixfgi4XTVc5Jlsl/B+7hkvLgsZ4PEercusrYyi+c7cL3EseW2EJXCV1OTNMqGdo5n4p00
X-Authority-Analysis: v=2.4 cv=e/4GSbp/ c=1 sm=1 tr=0 ts=681c9378 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=kTe4e9xCPvT-gjkuE4IA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080094
X-Mailman-Approved-At: Thu, 08 May 2025 14:49:28 +0200
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
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

