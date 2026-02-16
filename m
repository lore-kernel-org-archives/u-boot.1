Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D69E81A3C
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 16:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61A378063E;
	Mon, 16 Feb 2026 17:16:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gv2YSFBr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sscvo71m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8807980FA1; Mon, 16 Feb 2026 17:16:06 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501D680325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 17:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GFkvxY982785
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 16:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=x63TySXYXngbzYvzYJE0z7
 p/jEbBP8DR5slEFVs7pVw=; b=gv2YSFBrFApRutcwToGVKHA7B0B8rAxgmDLrbY
 N0l5LyHRi+bS0fpW95DBXvH+uY9JSAWoGCmpuTaPCsaoa7Lyg67o1yjbNz5jeWYY
 NTfyh9TFgxEbvi+VlXKV/A7UigQ80VZUSuUU0M/7mzChyYqSiqkTRSu8Xeck0Luz
 Nec6J9ZfM1oyhRxIhCUUlBQNSh7lfriwWgWswt66GN5fUxWyiCN6MDTNUgdofduQ
 eYz3W4R4JkFwN5O3hHCCgT7moIczcunMDSZNNT+3mSnBWgw9s0yBUEFPdOnXKoDC
 f+OsdPzOu+jOm9fCv7m7uYdfuc64wH0CuNtL396+aYODhysA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc662r2hk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 16:16:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aaf2ce5d81so40694525ad.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 08:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771258562; x=1771863362; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x63TySXYXngbzYvzYJE0z7p/jEbBP8DR5slEFVs7pVw=;
 b=Sscvo71mlsYPylQsO4/g+8Ip4Ude0Cb9hKjZCq4xJptdsdR1jBfRVg1Fs8xvH1S3sH
 13IvMIh2lpO1UIDYMHOAS/Kqap1tlgfpavVKlXPC5rFMV2bzKN7fRTIkXwoNOAYC54mo
 1R/CUkCtSTvLZIuKyeR1eux2FVvZ3Msp5JMRoXIpnufIuS8sZ2YbIYfGF+/ip9r7veev
 sgoHewbRSULKNvXefdg+F7oJCZcnE+oUi7AFm9mw7xJCLvVwTz8372xehuH2Lg4jOgU9
 ZLgCIsnRJFs9d1q/BFl+qU0HvB9WG5W44KYnFqa9hblXR69IASjfwdb9dyBZ8Z0sXQrx
 UMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771258562; x=1771863362;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x63TySXYXngbzYvzYJE0z7p/jEbBP8DR5slEFVs7pVw=;
 b=OMxpEiKoODPM06yv3gkq1mDX86u1Nyart+jhUdTSrSZZNp2I0twMdNu5Qr7chA89rm
 KQ2BEyvblMUnWJRFXld3Vlu110LxHlgniHaC/TVfELPX+gw/LOPEo+RuspXEKT3G3ugv
 fXdsBltXIL5mHIGmrDlz+PVzQm0DjZWsVCCprSo/3I/Kpqxhq5uETyHY/AZOm29Kblcb
 wkI3zymti3sHhvyjmUGEGwc/8F6IAHQnW+aALdaFNctc5ub4GmcDxc7Bjh1mbRCtUNYc
 Y64Rz8lhl5jxjjpTxPtsOdMAw/lkrjcqw+9Tn/Rhu0bF7qFfXkjZF7jQv0wMmjwIaJr0
 mXpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVym2pYJXI0fX4gT8w8puQmJHQ9g2KlUVAZhJCX2stx/AN+oRk0+mnfIbWKL/kG5kTofIngKiA=@lists.denx.de
X-Gm-Message-State: AOJu0YxnD0iLDEsgwK1MOMPyhxFkhJOOKxxcLJOeYwTpWe3cnqkatMUn
 GJTcxm0+XQ+2+ECNHFKmNdmfCifJfjk6l6zDjEdMnoR02Sz3StM8SiW3sTAiBZD2STjZv9OISnt
 mpT67jBSpQMXE/EVsXw/aWSOSle714dBfRuQOFY0eIfEQt/LG4S61Abfa
X-Gm-Gg: AZuq6aKs6dNTm8z4Z3aOK4ub5tD65EOBEsQ7zMq7XbzboCoV4KQSUmUd6UnbKOyw7c8
 V0EiuSZQGIrOFh/XBWhLuQFJB6+EJHt1awyRwFuBj5caEnwzBVn0YChEJ1y20lrlli3tNcnYe/x
 BX3HoC37zzQfvz3Q+tskoihrVhPgaVnDEUZc9tImzFHQOqZHTO9C1z1Pj+n8cXNNdDRZVHCE7gj
 Bx/VMOuE7cxONNdfLkMaArV9pnYYUds2n1Dkf56wZq4q2Gvds1qcD4ktF4TZ2cf0aEc3jBhp5RO
 J6AlZNtGE4qw17qtMSBoKZQVFAwAP0QH6oWXjYDQfVirdqr0zOtqgi40FGp6ZZJJExWtiD3baF+
 Ua6ihzBeXdDl3T3ENDy7GAtrAdAB8uf1yeFwRfcKL1MhXGRXR/BgQdGmWrF9LUSKr46+eTqrKji
 IXr8CPuPvyci4PixfNoypzAD+aPQmWnEtNPGcofqWellu7PWtwSQ==
X-Received: by 2002:a05:6a21:748e:b0:38e:5655:2897 with SMTP id
 adf61e73a8af0-3948389a31bmr7495553637.22.1771258561579; 
 Mon, 16 Feb 2026 08:16:01 -0800 (PST)
X-Received: by 2002:a05:6a21:748e:b0:38e:5655:2897 with SMTP id
 adf61e73a8af0-3948389a31bmr7495512637.22.1771258560971; 
 Mon, 16 Feb 2026 08:16:00 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e5331bbe2sm7539651a12.28.2026.02.16.08.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:16:00 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 21:45:49 +0530
Subject: [PATCH] qcom_defconfig: Switch Qualcomm fastboot flash from MMC to
 block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALRCk2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0Mz3bSk+KSc/ORsXTNDS+PUZEPT5OQ0MyWg8oKi1LTMCrBR0bG1tQD
 /LxjXWgAAAA==
X-Change-ID: 20260216-fb_block-6193ec15ccf6
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771258557; l=1169;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=L8dfRevWdjVZnGfBGfNPHnmnrSfmBu/19qOO9DZPY6E=;
 b=TaBXxNDw7nqMnotaY77TCli41gXGoOqfVTyFJcuzt9nbR3NGpLq4QW/noycj7bLT2H+fOLrsU
 9Xi/mpT8yTcBtth7U1S+ryBkttlpzRxKu092NimVc+/oOqSSV6VOebo
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEzOSBTYWx0ZWRfXwA0I5TDqzWBh
 aM8/4gcnZwHvt7+Gip/3iYvmSx1vdi4xqi0lg0LBHoxnDrePZdgxuAubvVM6iPQwzAISK+nPyBt
 mOdD3s0Izu+AJVh9OMCR3HhtWb2/tACZyTnTBbA0qTyrBfDHSCq2X3YlaA7y33w74Kx0Dr1hEYC
 nnvS8P+hv9n6yi2fXnCisgJWTw3rfeFI4qJ88+wtYEeDpVD2ijUWI1uFqr2iYLfwAWSVxpmQ24T
 lzdKTswbu+m2rC1Z6mi2DnwtYyIqPiYI4zN2khcc/BNUfznC9tkm62I9+kk1XCOZD4DEovG0bmL
 EnClQ//AYuM6VFlzxQFaK5e83o8GNJHAb8tXe10DuJboaC9bu2RidVic60WBX5sw0DeeBSg0Wzn
 ZgTJRGbHhYgc77zejulLEyUz0CKS5HC3KQrD4iPoHq4NGZNS/l6PDgs9P/XL9n0sYiHf5T8IHee
 X9zvOI/qkjVG5+v9qtQ==
X-Authority-Analysis: v=2.4 cv=Y6b1cxeN c=1 sm=1 tr=0 ts=699342c2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=7xorb5Et9y77LehQ4dEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ryquFWVnNU59dRWQ6wviYKMv-QaGeSi7
X-Proofpoint-ORIG-GUID: ryquFWVnNU59dRWQ6wviYKMv-QaGeSi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_05,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160139
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

Replace MMC-specific fastboot flash configuration with generic
block device support for Qualcomm platforms. This change switches
from MMC device 0 to SCSI interface with device ID 4, enabling
fastboot operations on UFS storage instead of eMMC.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..2666adb0569 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -77,8 +77,9 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x0
 CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=0
-CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y

---
base-commit: f9ffeec4bdcf1da655a0ffea482062adde78fee8
change-id: 20260216-fb_block-6193ec15ccf6

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

