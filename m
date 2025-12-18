Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABA8D68BDD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 06:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D4083CAA;
	Thu, 18 Dec 2025 07:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sxe/EbrG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kDslMfZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB4083CC7; Thu, 18 Dec 2025 07:16:29 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EF7583CB1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1YUlG4057276
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AuxewVTrUUW
 3kgJ0hMK31htPumzab9HBdh6BhHTkmJM=; b=Sxe/EbrGWBiDBDkfs/LLl3D+/H6
 /7aqbhfq6AqI+1cijNfq7KI6c6pkN9+bs6eOm5VETErxIS27r89uNVAj1fd42ljp
 nbdQObPxdE8WcrC74zWxnXwzA5F+B4sGMLzrWM7uyclw3H769h2002b55RfqjWWg
 cquYPZXNKnY6GQLsekuB36swcP/WrvjKDfe8GOfg8W1OU9Nbhz/jsme8YAJjms2f
 2V1DxUOL6nuvARZhRZsA86AVnCLJDK9xnpvo4uZzFw4erbkyElY467J2D46nJuu8
 Y9Mar8l7UMJFLRYgovGzbXAC2cGLP1t9BVqPl1EhJsTbyvCfyR6WZa4LiPg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3xr5acdj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b9d73d57328so395980a12.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 22:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766038585; x=1766643385; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AuxewVTrUUW3kgJ0hMK31htPumzab9HBdh6BhHTkmJM=;
 b=kDslMfZAAlP8AJZlvkL0tbi3fgXUSnQDSrkD1NrcT3velHwfNu+PjZOCsvTs6kC+qW
 3A/eOLA0Wun4qaRp4AsI/Sj005jYmyvIYTBHVK5bNwK+gxdai31ONry/EZuXIxWP4i+/
 bgr/ZMV5a7jyhY3gooSs0WUJ3IM3cLewb9ADCuHC+uVrrktMLWakN11VtLcpUy3N/V93
 ush7sYz0zNfxQD2D21iCa2YJJ8wao9ajHomeI2bywl+KJLj5fRkr4qcASr+J80+hBxEP
 srkJ4gWaHgG5HKSxBhGybbxxDEIr3Wn2gD4I5qXcK3QoPModEYr3q4fZhQWGDYUWGV8O
 HtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766038585; x=1766643385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AuxewVTrUUW3kgJ0hMK31htPumzab9HBdh6BhHTkmJM=;
 b=UoLwl3ApOxuD9enkIOyKRoqP+LoY2Q5cAOueNtAKgOc5b2yDU6XYntCbr0iXGI8YPr
 oY/URQYLfRp3MlFH+xFXNgDu1Os42IPs2yU6wsQrl/IrqhI1XNNsYFn2Lum/IHX1m1Pb
 RSsRa97c0+cOXlBo04oURmU5e6si6UjuHb4XVVcFtpZ8HeGjPqIfyTfHKE3AVGJqW5Kt
 0ytaTihXw+WslaTiY9R0i4n7r2Z4/qACyFj+xmeAb6zPnd3Buy0rjekMhmOKxZnEFBC0
 RSs53N2NJ2cNN8WV0f8AMdxJ/N3LNzIGbBOUkelhCG3aA78Ewup9eLOyvzBC1izXIRH/
 1KKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXedmzcWUTn0yb6o8rTM0ls1UUhbm9nDDu8SzIRzJqY7CPbNg6Y6/DN5ZS8VUrMyZRsLSaFlC0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6qp4PiM/xAfmfcl36zC2vGX7Sh2rdgF0G9Dbl+F6Fa4aEN9f1
 XP69WkEdXZKASSHS6CtkYA0/g07skhFaLqR+ai7K47teLV+j6XDrDjwjXFGva7MeMCZa8aWPtSY
 I7VlmgQOllT2zRhM6SWpzVA/NBAPW8dZVxGtjsHq3sWcia67kpcPnnOuW
X-Gm-Gg: AY/fxX6XRVm5UiAQTdXR094AP3mgnJj4M1QbTmMggJVeHOL3paKGLKRPQiydzE2ijuF
 A+hKmaKeVlEEscvBlHyLSFuZCQKSVQxVVD+sMfzsl0iSeHUdwQnCAxEto1uVjCnM6hMuegfNPo/
 o9bLpfnvFrEfXSQ7jwPAuX+KodtVozAD550LuawJV8ldWWxrd5JJcPDpHLHcvx4rZXIIKKGnyIm
 wvbNjGZLzvN12hT/azWH6oTPmyR9oFXWYP5pcZd1jRONoumboLzMGuXfMobnWnHOKxICsooVcZR
 /AtswXj014cop0zcqlwfuiCyx21y3sR4+UElvva6qUz5gvd9/c7JeFK90ScNPHAPZu9/L2qK+SB
 W4XOOpSTUClrtvFTfDeJ0kA2D7DVnNK0AwPuqfPo6ClZAFE6ejOiA82ChvbSTkV8VmqdiExIwW9
 JVY7VEqIqCSQqmb6VobFQzOAqzOWLfqUU0tL2x09o=
X-Received: by 2002:a05:6a20:4306:b0:366:1e4c:e6dc with SMTP id
 adf61e73a8af0-369ad9d825amr18473307637.3.1766038584890; 
 Wed, 17 Dec 2025 22:16:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7SwfCIQDxMEmf4Hfx/74+Y1QA8QJP6RryUA8eZ5tuP1Vul15HIAIFbZ5R1WRZ04BgZ42gGw==
X-Received: by 2002:a05:6a20:4306:b0:366:1e4c:e6dc with SMTP id
 adf61e73a8af0-369ad9d825amr18473276637.3.1766038584399; 
 Wed, 17 Dec 2025 22:16:24 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d2fa228b5sm1198995a12.18.2025.12.17.22.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 22:16:24 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [RESEND v2 4/6] configs: ipq9574: Enable fastboot support
Date: Thu, 18 Dec 2025 11:45:55 +0530
Message-Id: <20251218061557.1999367-5-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _Jf9AyCotf59_PTC7g44kYFHhgftNpIz
X-Authority-Analysis: v=2.4 cv=DsBbOW/+ c=1 sm=1 tr=0 ts=69439c39 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6zSr0Cm5jUOs9Rz06jIA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0OSBTYWx0ZWRfX90lN1EtEzVoU
 /euHpJAS9m8cFuiuDwvJyDxQFlzKWkafBKYkv6YuZVpDSYfJubRKHTOKon3Q0dl1WuaRpq5o4sR
 NijV03xcnYY4pm5e6O1F4WZMX6I3EDfGvwbmN/MOJW+j8mtlmGxJ5DP7OGfw0zcXdWsvfF7+47p
 TQCXXWkjoX9FC1ywPcmlbaR9ofDVo0K7XKfOdFBFgfzUSZeDpqvY2EvmcpfqCta2tcjqJqKQrfR
 7Qo+pIQD69xP1rOHH+YfKwmWZxNzxql+Krn4VrQ/uotT7rI/RVZHQYvRvWQX3Sv/tnDh4+HPNv3
 8kNUxjlZqKmWKY0BrwFX87KHc1u+nBmrRBbMCPI1u3ccyNWIUwjIvvx7lFO7FS2IlZiVhiW7dgV
 TJ+8enea56xYF5dRPTx/Y96CGFwQiA==
X-Proofpoint-ORIG-GUID: _Jf9AyCotf59_PTC7g44kYFHhgftNpIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180049
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

Enable relevant configs like USB PHY, gadget, fastboot,
fastboot MMC support etc. to enable fastboot flashing
of IPQ9574 based boards.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_ipq9574_mmc_defconfig | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 6592d9de39d..ac534738994 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -45,7 +45,7 @@ CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_QCOM=y
 CONFIG_RGMII=y
 CONFIG_PHY=y
-CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QMP_USB=y
 CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
@@ -54,3 +54,23 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_CMD_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GADGET=y
+CONFIG_MISC=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT=y
+CONFIG_CMD_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=y
+CONFIG_FASTBOOT_BUF_SIZE=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
+CONFIG_FASTBOOT_BUF_ADDR=0x50000000
+CONFIG_FASTBOOT_BUF_SIZE=0x4000000
-- 
2.34.1

