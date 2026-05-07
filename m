Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D4ECD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCDC84A7B;
	Thu,  7 May 2026 17:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HQ1+04UA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLW5US+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE7D284A7D; Thu,  7 May 2026 17:20:47 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6324E84A44
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BxZPd2734082
 for <u-boot@lists.denx.de>; Thu, 7 May 2026 15:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=TMZMBQoxOnFe92ZWFDjt0B
 5a4Nvs71iFwhWGLc5N1rw=; b=HQ1+04UA9B8/r5ASyJ9N8Cy9q0cvomwFj5uP1C
 TGEFiFQBwEgrrnpCS0Hame9M6ZbHH9/eN2sSX1NjEtZvrersKQgbq+rU8QbTT+y2
 Q26uPUSLBnoQ/9AvoUzCD+PzdgRGDKf5woEKLHqIdRpYQgpNOZovhnrz2oNiUjZh
 m7RN8ZFVc3EQ2L9jkPu/oIC0ee23b7Y70EAwrB4+mXQmF8i6GaiZ1voGU5+exiVL
 gjXXgroH0BkBgiCtguuQPEtisTgfeoPICryOIWA5UeWAJ/bnhFOFMJBANn8y6YRk
 7t0BUUFMcyQbDUQrqo2N43bkRh0bd3/sj5DuQMwTS8kGJD7A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tbqrskn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 15:20:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2eba42b8dso12190495ad.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778167242; x=1778772042; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TMZMBQoxOnFe92ZWFDjt0B5a4Nvs71iFwhWGLc5N1rw=;
 b=XLW5US+BwpXE1nEsUysarvbqDfqjBcl9uf8NZD4aKxUcKhonY8amCE6CSijNWm49Es
 cwmbd8++G0OxYcznauRiWuzhcqnQjtnNJmqLZzmwtc6G/ebgpYfZmnnLAW50TWGNig8I
 nu40A0raZrtEYcBqvKos3TH3XR6puZSWylCNGrwU99tVB5RnA58wCneX6xFC8l28Ab4Q
 niEaRb/3bdATsZ2qw+bMynQphYgd1w2Nou5Vt6nU4xH7Aidb+GMX62Rd+9Mcy0RAkR5k
 VDPasjQOYGFX8cXtFF0P9p3awv736IFviJ1xGg8Luy8Ef2Kc+tVXsOuDWqX8pxvCDJGD
 Cs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167242; x=1778772042;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMZMBQoxOnFe92ZWFDjt0B5a4Nvs71iFwhWGLc5N1rw=;
 b=C7CJwBCWwjPsFXOGud8ACQs0IeAbRR5uZI3jvuB0Pi8avgh0pcfbHQviBSCMXt8Kj3
 0ibzkhXfpvoGdsBqgwENoT1cOXYNk3owqMpIkeSiUHik1+j7EoHL///9ZmhSGENXbzze
 6rEMiwEEcBopZUlauqiXz5rU0HmSJNxJRz//u5B0p5k07HwEDv+vC0F8soYbgpSZ0aaJ
 ipcTaCQkWjbeL6Y+0PdeDVQ3VWOvJjorxdYe/69ZEuZhzIWbIfClKYTycLISayB1jRlx
 1eBSTRlRcqf0n8MDMUl/PzkxtWWaOQAx287boTppZmy1vVS2nsFIuOtk02V37ZIcFSl5
 EWRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nCpd6G8vNtE3yaEc/e+1WQwzNXW5J7f4yx1BWZor5g9wfblLGYKi7kSaKUn44hgmwbITflxM=@lists.denx.de
X-Gm-Message-State: AOJu0YzkvwUpDGAVKH5Mw0WuNzfTxAeyZw4emtMYnYyoRk4eZIjIrrlJ
 HaPN71TfvaHBF4r8f60O1kvTCJImdxW8M00XUeNbB6BdH2/FYZER1YcwNyEMujTPjd528XG1KeF
 mZ41ljAxRjAdHkeE1fTTKXXqTd6IXVz4TYGkuUn4UI/jFnJ1v9JmFrwCOMh5SBzcJ
X-Gm-Gg: AeBDieuqNm4O6B+8f9Fw0rSu+Ooze9f0VCCAI0J05zv+UvcyIGXqNHCIcU+cLvF3Lkt
 AflYOqfB2mHE113chNIGcaGnxGQU7nTCc8GaZX/ZKU44/Nr8LK7zhf6hHg3bDjJhQx51Qai9kYv
 MZIghzPK437I+7B/IafGpe8GWG6tYRRgBUhjZPtK3TCTxCLrrEuL97Jw7PeaqPk3EkMVGYh4nS3
 lNIndXVvjVh+okkrHd0faCGTw0EiFX2/fAJgyx9WMnSS7vKQIQglHIXmkyw7oBWzO+WfCqZHsfr
 E6xR7Re0tK9C+mrlpzrcxAkjDMJIHuIu7Sf1NDJPHoydSO3VX5MdHZHGrAma52FB7UBBolHn1bu
 umA4DK+5q44VYJ2f1Tj7Q0BWIONf/PtwhROPLQfgdNKgnVcCd0i3zQ46APZGOEWbFrh/r+XyRc/
 jOY22MWWPqNSUCZjd2wmmWHZIGnph7EVilXL+AO3wfY3qSrq75QzkG152nDLy6
X-Received: by 2002:a17:902:ef0f:b0:2b4:5f83:a9d6 with SMTP id
 d9443c01a7336-2ba7a358604mr86435095ad.34.1778167242347; 
 Thu, 07 May 2026 08:20:42 -0700 (PDT)
X-Received: by 2002:a17:902:ef0f:b0:2b4:5f83:a9d6 with SMTP id
 d9443c01a7336-2ba7a358604mr86434735ad.34.1778167241831; 
 Thu, 07 May 2026 08:20:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bae757dc43sm479285ad.37.2026.05.07.08.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:20:41 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 07 May 2026 20:50:35 +0530
Subject: [PATCH v3] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-usb-v3-1-402b37fc2154@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMOt/GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNz3dLiJN0kg5S0pLS0VANLEzMloMqCotS0zAqwKdGxtbUAvSN+5FU
 AAAA=
X-Change-ID: 20260507-usb-b0dfbffe0946
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778167238; l=1468;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=zfFIweHH8FPFjxT+GqZ7e81PkTJuChFScUH5zL0vW1Q=;
 b=N/mIjKclYIGizLFH2DkqlkVD9eYYmG/bomHCzb3HSWyb9b0zOeFmh+ZuINp46gu0G+FOTmwXl
 NFAvzNcfOsBBnHm+pWry2LvCi1wSveFrUfIAm2d4aI6ivb40R7EAisB
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: tqVKpRH10yjaa7g0rTHItnKh89w8Pcq4
X-Authority-Analysis: v=2.4 cv=SJVykuvH c=1 sm=1 tr=0 ts=69fcadcb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fKU-DjF7s0nMRrjlPjIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: tqVKpRH10yjaa7g0rTHItnKh89w8Pcq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1MyBTYWx0ZWRfX/sbkmUIckEyT
 g1zZ8+Si4P6GEaRs7tB4Qy5ORs7aRx/rj3AFwRc5f2reNaKB60Z7603ulWQBfDNQb8uFERYYRLF
 l9cNtPas7E2+KwRCU90qkT5y/ZZgpxQVMSZho81wvpHSx/VgihSQYoaTe0h2MLRJFWbeVBos8zf
 xpIQPdquEcf+lpOwTwLGksZDiERb2blD3wzWxPPHKkfa75bffQF7T2+C01WomaduRGyWV2SSRtH
 /dgFmX1OvNo5/wsOHrclD1Q8DrTKQlq16Xev5aCK3QCoJ8HG10Bqc7z9p3Kbkz1m60NxtakWpgM
 x6HAe/0HltybM+KLFWJxJXwmirx0jQP31rrM2ROdWU3VgrDAP2U4KbqMD67iQn9yu2fm+1+DiSN
 Ada/m9yu4zIy3TGppsDTJLVAU8iHG+0B9Y+zgvbfYlRmKmo+X0+IiYQWUuEeF9ZP0eD+jus8BXs
 B2mQ2oCMQ1CcJNKwPkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070153
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

The dwc3_free_one_event_buffer() function incorrectly called free()
on event buffer structures allocated with devm_kzalloc(). This
caused heap corruption and a synchronous abort when exiting
fastboot mode via "fastboot continue".

Device-managed memory is automatically freed when the device is
removed, so manual deallocation causes the heap allocator to access
corrupted metadata.

Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event buffer cleanup")
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Move Fixes tag to commit footer in commit description
- Link to v2: https://lore.kernel.org/u-boot/20260507-usb-v2-1-3958b8732553@oss.qualcomm.com/

Changes in v2:
- Added Fixes tag in commit description
- Link to v1: https://lore.kernel.org/u-boot/20260506-usb-v1-1-e0f426bb1e42@oss.qualcomm.com/
---
 drivers/usb/dwc3/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0dee14c8b59..be198041f08 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -208,7 +208,6 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
 	dma_free_coherent(evt->buf);
-	free(evt);
 }
 
 /**

---
base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
change-id: 20260507-usb-b0dfbffe0946

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

