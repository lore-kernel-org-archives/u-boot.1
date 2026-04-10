Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCC2F36BAB
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 04:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C25839D9;
	Fri, 10 Apr 2026 06:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESJ1Kocc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iot3wnnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F04984106; Fri, 10 Apr 2026 06:42:21 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78111839D9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639L0X0Y1972554
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kBY3I0NljI9TruewJ5CsMTBXVJpLjduT4hbbVG/CoVo=; b=ESJ1KoccqvnHwqGd
 yLXhZG7tzg8UGnKstjpSVpD3DHjY98EKROKDH0jqzQYOYnTQLygVWfKwXcMl6rdF
 Vey5ujUj3+iJodz0hZLUD38sfSRZLdQlvp7nftkWIMXAl2y7zUQqGC2DBKuJ+fkp
 jmCndB/xI1fw9B1ESOYY68vpURBudjbgKRAqrvBGPIlYNlnZ22UVn0FJWb+801ic
 spAid1ltO4W/sOfsud9XCFyWzjDh7RYpBZyra+dyacIc7G7dJ9ilohtODetEDNpC
 09BeRgrEGrg+4giN2/VRLt3hMSuV1hWbPMEFjbFdTlcVz9Bti/xNIj325Q6EgcJe
 EDXJTQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decms2q14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:42:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c76c60c74f3so1094577a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 21:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775796136; x=1776400936; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kBY3I0NljI9TruewJ5CsMTBXVJpLjduT4hbbVG/CoVo=;
 b=Iot3wnnU4o2JXs7Ft1p2jBDKxauHhhY1tmABeSdU3O2PkvCeidsHsnm4i2+HWEPIjG
 NE11AuuZSzByD3O1b88p+bBqrdo23MyyvPAq9cGbwUvBQkE3sUBhUBkaZDeR5o3CA/AQ
 73FnfBFAXkjc4dmeTrHCfCTI/m04sSM4DcAXewXJad8uVxstd9vGtxi5leExVYm05NGh
 UK+h7gOOyEgr4oCiwB2XyX5Q5am5iJzbKLmUGZ3IAKcMUKq2XdqTVzrD8GtmpzpN5qjK
 hYJ1WaR6D5fzHw3CAzXk9HmJq3k4ZJDCdEdXjDNWn0owsdsYpH67v0Bgg8ZmpFpexVkX
 tODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775796136; x=1776400936;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kBY3I0NljI9TruewJ5CsMTBXVJpLjduT4hbbVG/CoVo=;
 b=jNualAetw91MPLqFyt9ZqG0kfgBjlsw/n+wr7gqcY5Sihx19qPhY5TdTS9jsfzowI1
 VXLM0Hl9rOCvP5PcIMkXfa5QZ4+4D7HGckY2t7dwIGOKktFFkeaxBrp+PuUdJi5lM/r3
 EztblonFBC1MXVG1ZwIUfSb8Z0AyRyinJ66+oCVU8WwEdMvoF0vZ7ZRKLa3D0opdQeu9
 2GWEkzXyPJaBS4WnyXdHz+vq1VerhBupst1+ShCrBAMo398d+Dedymxnfrb3K+J2jP7T
 6qf8FREY/Oagzl12O/XMTzWSFY64khMq6oJefB0chLAXsqL8YTajIdTgbsSZXh7ILpZk
 aIfw==
X-Gm-Message-State: AOJu0YwtBt+5aXRWRGfGK09K3NexoIVRlOc1cRWv1Pk85I4bd1Oj4Ca3
 5q8oIADMjDi9ICc4N6fN3zXZru2DnB3jHpe1SpsYrWtRbcG5eAFEHr7KZTLjhzAYbHeKsgBbeCy
 KXaIalCsH56AdmU8cD6/R5OaYVOwXtwAxH0AbRG/hXJ8Y0XHSNWds8+s1
X-Gm-Gg: AeBDieupuwuXCMWGcBA1RjJOhwMF7PQHKpZWz209e4pE+BEhnHWqP1rub/lRAcsDAew
 95o2xj/CyJeX3s9vrgXWNDn/EARN/wloK6qCYdZWgWdZ3ODYtubPkL5s8OdhI4i0LFLfHxOVkuJ
 P1//L3MF3C9fa1uQc2Pw+ULRd3YEtZrUequbZULqndkI/YvM1xnf/fgyQo+IOhLnNbuw6kXTsxo
 ZcQx3aKufyCtnLFfMpKSUHj9sMrzNX4shKwzRXYv/i2h9HeHxMlk2GLB0HSJrZHdgY6FePPZBiO
 1CdQ7NRXsMkra0VP/Xe+7Lh6yp++r5q+T7VMEopBMulm+g0i01zzzY6kzoolvkbZdxRcg3R1HuQ
 28eruy5lz3jG1tu1k8d74v/61JKY1yHHyg8hhfgP3C8xlkPY77AKyZV42Neca+Rt2pk7aLM9bv3
 rJzyf5sLxYiR7pmztOJSe6JbT/5T5ygchbfPCevOrGn40IiJzj2w==
X-Received: by 2002:a05:6a00:a228:b0:829:809e:8977 with SMTP id
 d2e1a72fcca58-82f0c358230mr2008972b3a.49.1775796135649; 
 Thu, 09 Apr 2026 21:42:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:a228:b0:829:809e:8977 with SMTP id
 d2e1a72fcca58-82f0c358230mr2008931b3a.49.1775796135082; 
 Thu, 09 Apr 2026 21:42:15 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4b3b29sm1198815b3a.36.2026.04.09.21.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 21:42:14 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 10:12:01 +0530
Subject: [PATCH 2/2] doc: fastboot: Document block device selection syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-fb_block-v1-2-68f0c976fe0e@oss.qualcomm.com>
References: <20260410-fb_block-v1-0-68f0c976fe0e@oss.qualcomm.com>
In-Reply-To: <20260410-fb_block-v1-0-68f0c976fe0e@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Michael Walle <mwalle@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775796123; l=2708;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=yfoXaj9Vin/uKgBCNvhLko3vCq8sYb9m/uwkOggxA0I=;
 b=h4MAal5Udbb0T+yCi32f9sKVZYytZPdyaeYe5ueAr1s3Tml7/lFSQRMWJ+gG2VQp1IxcI/9Vh
 zM7VIV/N5mlAb6D0TRuC6Mx+cQQBBO5b3jnQe8d30xLAn1fIWotSitu
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: mn6apOD3ob2J1LkmHfIt75qbJPO5e8gZ
X-Proofpoint-GUID: mn6apOD3ob2J1LkmHfIt75qbJPO5e8gZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA0MCBTYWx0ZWRfX0LPrRUMv8TkQ
 i532XzzJ/vx8kUT69J4zRYZi8Hd4oQZ/otzSk/Z5wgLPa42GIDDZXN8wJ642u9Mncgxo27EvzRi
 T+I2oe52D09mJmeWbeHIQ6FfUsjUTq9UZUpYaSxIT8aoD1fS3JVXAF+AHiR7EpQ4ojXhEoNoy7d
 V/IKvDgW2YHUpdwXkIW81SrZLxdSUYaQfisvUj7rjithqU8hEG1Ym73oO1r2I9XwyrVOcXMkMfq
 Xbm7ZB27pIzV4MqgETyDZ6/h2rU0gkNpC+ykKb9m+icZrnUw0+diWTVAdphYuFJWRTdx9PgNRGM
 5lFMg0YwbPmURWJGFiQ1BCmTTs70MPAOldQL7eIJp296lfwkG6YrAcRIVs6H4YBBTYGN2eXLwVb
 Shll2G+LVvGCjQfbp/XU0Sf+LOaOVUYT1jW/104ZYdkQrw9sqKj+qgd93lDcfsrN1orH41JZUeD
 hZZnRz+7G/mwIffXrjA==
X-Authority-Analysis: v=2.4 cv=N/sZ0W9B c=1 sm=1 tr=0 ts=69d87fa8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=LaZClvyRMV3iiGpkPsEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100040
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

Add documentation for the device selection syntax in fastboot
block device operations. Users can now specify target devices
using "N:partition" format where N is the device number.

Document usage examples for regular partition operations like
"fastboot flash 0:boot boot.img" and partition table operations
like "fastboot flash 1:gpt gpt.img". When no device number is
specified, the default from CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID
is used.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 doc/android/fastboot.rst | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 19e2ee9d407..ce3a030e701 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -147,6 +147,38 @@ The Fastboot implementation in U-Boot allows to write images into disk
 partitions. Target partitions are referred on the host computer by
 their names.
 
+Device Selection for Block Devices
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When using ``FASTBOOT_FLASH_BLOCK``, you can specify which block device to
+target by prefixing the partition name with the device number and a colon.
+
+Syntax::
+
+    <device_number>:<partition_name>
+
+Examples::
+
+    fastboot flash 0:boot boot.img        # Flash to device 0, partition "boot"
+    fastboot flash 1:system system.img    # Flash to device 1, partition "system"
+    fastboot flash 0:gpt gpt.img          # Write GPT to device 0
+    fastboot flash 1:mbr mbr.img          # Write MBR to device 1
+
+If no device number is specified, the default device from
+``CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID`` is used::
+
+    fastboot flash boot boot.img          # Uses default device
+
+This syntax is supported for:
+
+* Regular partition flashing
+* GPT partition table updates (``gpt`` or ``N:gpt``)
+* MBR partition table updates (``mbr`` or ``N:mbr``)
+* Partition erasing operations
+
+Partition Name Formats
+^^^^^^^^^^^^^^^^^^^^^^
+
 For GPT/EFI the respective partition name is used.
 
 For MBR the partitions are referred by generic names according to the
@@ -186,6 +218,15 @@ configuration options:
    CONFIG_FASTBOOT_GPT_NAME
    CONFIG_FASTBOOT_MBR_NAME
 
+When using block devices (``FASTBOOT_FLASH_BLOCK``), you can specify the target
+device by prefixing with the device number::
+
+   fastboot flash 0:gpt gpt.img    # Write GPT to device 0
+   fastboot flash 1:mbr mbr.img    # Write MBR to device 1
+
+If no device number is specified, the default device from
+``CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID`` is used.
+
 In Action
 ---------
 

-- 
2.34.1

