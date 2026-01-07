Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852D6CF6C1F
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 09:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49F083B03;
	Wed,  7 Jan 2026 10:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMgGu5zd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXTgO99h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0353E83B32; Wed,  7 Jan 2026 10:50:50 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F67383AC5
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 10:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6074N1ZG1462343
 for <u-boot@lists.denx.de>; Wed, 7 Jan 2026 09:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=LxovlaKFpk5Wvosyx3yoOysn1Iru9BdCAOm
 uRkSxfOA=; b=PMgGu5zdL1zGPaSQR5PEEo4W/Ej8n9RL149mjvXxDgtnshVj6WV
 Tet4nTO82F8Sp2Mu80qwUNciv6jqhm+nWPNqLQXpk/AeY839twkb2FDlV2mgB81U
 X6i7n6jtydLwp8hZhRZCoOPDUDceQJbfgkkWSCF8HagnOdgawDhNc4O9PYLXDV8R
 DrFdCbJFhuDgTFgnc99N6pGeL6K8ZgxGNl9Jsxbi9Suv85NgvXbiXRxtDPKRgL6s
 9TJx6RiFft9HtBiX5uD5X/i8vkyHbTjfK5GojYVGdK8AEH1HXB//HVE3vlXozA0q
 Kwf3c3yMKNn2EWmjkLfBPjMkHGSeKPhOGZw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh0vm3u1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 09:50:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34cc88eca7eso3126289a91.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 01:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767779445; x=1768384245; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LxovlaKFpk5Wvosyx3yoOysn1Iru9BdCAOmuRkSxfOA=;
 b=hXTgO99hvsOK3mxHo6eImqCX8radSSZai0EOEEPls0G4J93ND46yXERR+ZK9C6CKaQ
 07cwEn0NAXG3T3wvTfTrArBWE+OcutinyC++2tjXAhYz1KHUs+SfaMxARcr+jtBNYRDC
 HhKQcpr+Vr53ei4d73KXga446PkHNWK0zwVJuu3kBkX5htTaG+CfblNPjfefdIxaM5Qk
 EnVwRypEk5DKVmaOYdgoc/SQPMWP0WRitzGUgDpjAgCISGGRl6ip/cGTKb3YBj17vXQ+
 b7hO8GNL+Y60MsnEh/J3MHq1Bhougd0dHzWoKJ4BFbCfJ+oEUEQao7uDm2+XnBgP0OFk
 O55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767779445; x=1768384245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LxovlaKFpk5Wvosyx3yoOysn1Iru9BdCAOmuRkSxfOA=;
 b=TUdWsBSwOWZtTu4R1CJEFM6MDvLT/v8CevRfT+t871XvwZWzWJLviXIHPtKvgUgiFW
 HwwxtEWAi5IuExh9QYFDr6y3xufp6EfSPOW+FH9RIQFuQO4ilxYo+b55a8Ldb81Q+48w
 zNFx9Rk4I8ZW9EMsNLDm/rw/FfTR6nLyXRGok+EwsSeSbnmE8Ovora4Z5sIVeUX+3pMi
 1cGW1Bjif7utF8jNcxmTqHiNZEusmUOwtrbErii4v8jZ0Xoay0blqPsB7NSPZ7QeK/uE
 o57EFTd+p4Cmc2PkO0ullgiAzGRkKAvwlduoZRx1AxLmV1S4kPV/1zMa6GdN676qLOmv
 YcpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7WHbk4tm+P+kUolurSAXOeApKN7xA6SQA6rUtSoqD8i3pDJziqa6KuBYilAkuKKKqttYxJxw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7kU1CUdSZ40eE9awmo+BDb3TCb00e6j7nq2N2SFDPsKJ8Z76Q
 BcEECzyMfZ+d7pP2mes2ave/Np6N7e9cQsQBiZ6UQPusAYPJuG0C647PQ1IGwPtjJX1aMAynwZF
 UfjF6wGYuCuUekfCPCSlr17O817aPKcmKHg0vuPE50Pi0i2qXCGurT/WN
X-Gm-Gg: AY/fxX7TInHHzgpMST77KIR1uHToVowd/9Q0PFvq8HWONf2VbZ/MVLFYpsAy1cjp/If
 V4DftP9n9b4Oq7d1Oam0AIrIlEugXemnhgyGXTtfpoIO82EkXUzk4uxVrDvg4+pcCKiE8I0i5MV
 VVeR1wbVin8GS8/L3YCsEl0BBBYSpQIHTbMK20mH0G7aMSIF6JA0gZKwsi3yl8kNI/CZqvP0NzZ
 ALZQiMwffxR+FLkGdENaZLNd+a3/kX28sfqkWcUgOy3+AYEAmHm+lhcSOyOSIuipY00PIUOzd+S
 5i8hMrSMD6FdkpASU48nj7/b1tBvK7q0ONEYFOiGGtxCldwlU9/2BxY2dDFQE3qGrv9HxN/eVyG
 zKqbXasHTxWe9PcYSn2eKx9Fx7LtopMi99CxqUMkqdcJfEBXkcbRsrB4R9TsomvRAZxSnyNFECg
 XRu6aZ5x7omS7jBbrYyDrHacFNmSLfA94LEUwZ2w==
X-Received: by 2002:a17:90b:2783:b0:340:c179:3666 with SMTP id
 98e67ed59e1d1-34f68c023dfmr1853692a91.8.1767779444976; 
 Wed, 07 Jan 2026 01:50:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGabX3J7a8z6VNCJgwy7GcurUH18kt3ikkOYKiOCLRioPxxYSfSZXjwfMcIcXvbvEa/R793Ag==
X-Received: by 2002:a17:90b:2783:b0:340:c179:3666 with SMTP id
 98e67ed59e1d1-34f68c023dfmr1853669a91.8.1767779444500; 
 Wed, 07 Jan 2026 01:50:44 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cca258e05sm4880063a12.35.2026.01.07.01.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 01:50:44 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v1] configs: Fix fastboot buffer address for QCS615 and
 QCM6490 boards
Date: Wed,  7 Jan 2026 15:20:38 +0530
Message-Id: <20260107095038.2491697-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Pa3yRyhd c=1 sm=1 tr=0 ts=695e2c75 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8899T97WiUtPmHQBOwYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 3U0iKYovaVf1qjNFTfLSysm3zsHVkfYT
X-Proofpoint-ORIG-GUID: 3U0iKYovaVf1qjNFTfLSysm3zsHVkfYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3OSBTYWx0ZWRfX/5Lw+rowjWxY
 wPGIzxiNB9s/40nihh525dgu4Y96M2xX4rkWvhHRCdlgejfaNg3uG7DQ3dTd7aAN0hEL134S5Bi
 aWIC74TURXfiUPObt5LCVKrN3jEbVVEL1WAOqJMlWwj3JGFC1jUnBsc0NJ07oquz66988y+9nMy
 IU4IlNGTfRMFcuwIpU77ylJF/74zb3Z5v2xZoV756LsEK7RXNpkivLPVRBWD5nkmw9rtnckp7LX
 Dwru7wyTYYgDEoEe1kiEvGsqcASnODfV6CYSwtYN9AhpIxWKxjZTdbd/du4b0eCbBOFOCPr3b2m
 0fU0/pNmEpKEXWOFjRiEgxHUpKt2nayNWZlb1tRfFU2Yeu2NSY+jK4o79AddIW6BQ6SovnFX9J3
 VTglb2A9sYN6zgsQwKPoUpOnhoAjdz3Sp8LnQm1B/nb8YDWj9j/FC0GN+9+3Kx/bgDTz28+HLJC
 VyuiScQ4VoGBtq54HmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070079
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

The default value of CONFIG_FASTBOOT_BUF_ADDR is 0, which causes
NULL pointer dereference during fastboot commands when users dont
provide "-l" option in fastboot usb command.

Set it to safe and sufficiently large region in RAM
of the QCS615 and QCM6490 boards, to prevent crashes.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcm6490_defconfig     | 2 ++
 configs/qcom_qcs615_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaec..618098c8860 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -13,3 +13,5 @@ CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
+
+CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 2468267b955..14043b4f23d 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -20,3 +20,5 @@ CONFIG_REMAKE_ELF=y
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
+
+CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
-- 
2.34.1

