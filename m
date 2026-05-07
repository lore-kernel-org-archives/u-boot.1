Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE19BCD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 04:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FCAD8488B;
	Thu,  7 May 2026 06:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oru43dnu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UL+vWq7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E088848BC; Thu,  7 May 2026 06:36:36 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45540847FD
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 06:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6473eSsX026471
 for <u-boot@lists.denx.de>; Thu, 7 May 2026 04:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Oi/obNZNis6abKUz9/ocyP
 E9Y07F1Fqgj3gRNLZs300=; b=oru43dnusL4sZk3drazVCWP23/Vx2kV3/ydpHy
 wY/IDz8xs3MpmvG0wLhisgtq8S4Bxe0Xqvmm3GsTtlU0V9XMIP8lgl2MJ+xkBi/p
 iTUFy9NqmBuhej6Cyls5VCEzw4ImUYA50MLGAFaAgQeOhIp9cv3XONef8kBE7urg
 Q0+ba1tlDuwyaoXvY1CYLRKQI9JFmkoN1xvIfdXngdx70+0zQY6JEKsGVSx19EuY
 mzvNhtBC4TUIjhxEzy9nxLDxeM3CCh4lZX/3sBlJF27l1VXXYgZzRsfoZ6Rj+3De
 7kByiC0nDVp5SU9hW5u+daXPbd9bClHvwAsDeRXkCyeeJ8Gg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t04cs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 04:36:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ba603a7d2cso4681355ad.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778128591; x=1778733391; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oi/obNZNis6abKUz9/ocyPE9Y07F1Fqgj3gRNLZs300=;
 b=UL+vWq7pxVW7D3n9ceUXTUb0GjqOSzEOQ5hRntyxDdJHWKcprX6lEjPdrV54Nt0N3R
 wStshKcFHVBkFyuJFETOFXK9S0NImip1pIT8mTIt/BqXjvaq5uc3jnWgxl6KwTEnH/Yn
 Le6MOsuvV1DmKLUukXRGDSN09w3bjjkJb++Qf13nfK5eJtBoetJdJZlaI8zXO+VjBoy+
 1uSKnB3yByhGmlJcK/ayzu8ZFTzBgR4/rAnqBo2QNfNtDNhqe3hHoYH8y+2O8A1MceIT
 pKgscKh8OcpD3bCS5RptO2cX7jSXcuV1zUPFG7IIqcqQ8c/tsogYtN8OWv2DER1shpXx
 B/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778128591; x=1778733391;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oi/obNZNis6abKUz9/ocyPE9Y07F1Fqgj3gRNLZs300=;
 b=q1QAd8OjjhACtJnn+5/pIbP6n7bsOUqm5wCtmnczs+DWTIYu95npMt0BfEF871Dzvj
 u0gTvvmbVT/aZ1X+wb+tbRQaZWv5iRQlmwsgdn7+7b4Vn+vTh323UuxHTiIm77r71BZz
 l7z2D/KRNJP6v2XGNjDyp9Q9s4BKLHCNlOh3Xi5R4EAiNP1NigMBDPAkJseFI01XbWhp
 GHM2oixHgWw689n8scRc8sNdPxum6Cc8Oog8uGymBI3A1UU4GGX9syy2nanaqFFjUdPv
 MfB36O0yhZHLm9KGQoVT3lkNod6rZjs4bn7pvSSC0GE/98LVc5laohRrgYwmIQB/fWIS
 fwLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VGiB78LrPRe4GvKfjNYAb+1ZxA+ZgCgkw2Wu80kWqT4WSq97KGYogDWmjcvd7BAL2XFppPbY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2d1RyLJDRpGStOqpWhfxBv6FzWZCoH7sdrEuJeED88Bd7eviG
 8zayB84fxP4QYQQ6kVick0Tl/RYTBNUnymbHK1fzVguqolgfBhp+8F5lZHjGeVSbaGhT+OsPlyO
 S7agYm4QnNs4XT/BZ5JhAqC115Iccn9I5/uyUcB/xhtHEY0jia+gKesp8rT7iU+pZ
X-Gm-Gg: AeBDievA7WIUYbAjseByuo3mCd8eVMmRtOpnvhqcwYuKvw1hCG2bzis/fgEPMRymuJy
 kxmhoDd6SdJCqAmk03f/ozepuImKI7NbK8Yz9CPnQZgzZMK1du2CS5aIsMTVbiF42KDXoVwiMQa
 LZ0FOpSGoQisTZSluHWkXzcQJPb+RgEGg8IoG+u6Po87vlLIoi1w4usFTVPEaffWoEsi7QueEbV
 PjnZj5XjKd0ZmEL4ylwn3ffAqXdswXs7Q+svoqNqP7hxYdNPFt9UXn0lW0KbUgU+NWg0GDyRM3A
 OCXdsB7T2PqqH/MbJU60cQSoYunXiSUTtxXErAIpI52mNcypvWXmA80Cp17pWroyS90AFlaeEAs
 a+TwfW8XYMfgoYsNQjauvz9QchbEsyHLg7oyu3irb9TRYbwnjMvLxD48cm32WTFKwwzYwUkPiMi
 78x6UAgtsH94kzhWzhIro4QG/S3F7ICbHXIkb7m6I4PsHgX/V1p8VJMlRPUCK5
X-Received: by 2002:a17:903:2f0b:b0:2b7:88f9:9c28 with SMTP id
 d9443c01a7336-2babc8546fdmr11754645ad.5.1778128590655; 
 Wed, 06 May 2026 21:36:30 -0700 (PDT)
X-Received: by 2002:a17:903:2f0b:b0:2b7:88f9:9c28 with SMTP id
 d9443c01a7336-2babc8546fdmr11754365ad.5.1778128590152; 
 Wed, 06 May 2026 21:36:30 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babadd22ddsm9327465ad.39.2026.05.06.21.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:36:29 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 07 May 2026 10:06:25 +0530
Subject: [PATCH v2] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-usb-v2-1-3958b8732553@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMgW/GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNz3dLiJF1jkyQTA5O0NAMz40QloMqCotS0zAqwKdGxtbUA9NiP4FU
 AAAA=
X-Change-ID: 20260507-usb-34b404ff063a
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778128586; l=1300;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=rxBjcaFMm17Ir1DoIX/cAC7WPn61WZSE0nrD7p7SdBs=;
 b=1RblOm+vEB5WfmU4OP/QflzuHHTHuAIypkB/sTgvnP/rGAH+p7hFxF/tKEdi26HlolvSIccOn
 L1F1he/YdrNBmp2mw+7K9bd47W4QXaMGJ/VYpLwyos8VapIdoIyQ/QR
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc16cf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fKU-DjF7s0nMRrjlPjIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: NbYItNB-UuTBxb5LvkKoT9t4dMk4Xgzw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA0MiBTYWx0ZWRfX4lxVytwASa4i
 xlrvzWSv84huU6OrzVEnrWqgvSwJcCMY5zuku5+HVYi4hwxEX90t+lwhqYIM4jtDooN1mht0nDd
 Tyyuzw4u+PKl0soM9Jnlq3Do92EhIXuwEIANNWipkqxar01VGwl1IwSWxsLPijWsQsGiq5dgSu/
 q7Lg6WBcuzUhF0TSZd0mRLWt+fSvK1m6DvDJTjoNi4xHatzi/aLld7LBAsAMqDpUAa3LjKhAeRS
 yON9h7oQCS1GeRf++Bml+OsAAEv/orU0Z+HUKR9kky3T+eiKM1UHOI0+0oD3eewC/eaJB7DlA/R
 WHc8DE7bH036DuOUlTBAGWSHS2yUZcP9TBI84owjA7c6q927svttZPouGrfz5hxe/kUMM2NhDGo
 3lq/ThX1Ilm/XFXRnZzB3yy6fmmfv7GsGvKx+uwXZzTQSFlNXLZ0I1p2HLa7XEk8fvD7IJf84fE
 C+mLBw9ZPLtqxDvT7iA==
X-Proofpoint-GUID: NbYItNB-UuTBxb5LvkKoT9t4dMk4Xgzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070042
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
change-id: 20260507-usb-34b404ff063a

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

