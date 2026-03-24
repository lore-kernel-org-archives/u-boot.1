Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81680F54ACE
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 15:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE3F807C0;
	Tue, 24 Mar 2026 16:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0cKKwu5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/iGkGgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6414C838BB; Tue, 24 Mar 2026 16:47:06 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F8180087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 16:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OFGg5l3903725
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 15:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CdcFevE5YsgNIizKbhcUa1
 cl6QQwN3kpPYwynUoiPPI=; b=E0cKKwu58nCca31CONjjwBClU8TTKv9DidJOnq
 rOnAHavRWfxtVgIPZ26VwqdoCCYnuZii59KEgJTsSxXsFaL0GPL+z+RxJjp5lGxS
 9vV52AAKJy0EnzjHaHSB6O3UuQKKkgsqRY4eF+86B/9ks+ViNBRHl6Ztw3yXymBw
 dxcDJP1PmBK4TPxBNMqtr4mHqcxBEBphHahFE5BF91lnBLW6+BbX9lB8s9WPZCmX
 yRCK/VBpRz3YBBDG9omyKqDsHrDXq5AIFKD4zNvqWHlIbFuMW7MH4XoALyy/JBrj
 3Tht3/KquA+JauWj9Xc7FaijHLcw2BmhQGLtVLFivrXuSTnA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jt0jpf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 15:47:02 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bce224720d8so3725405a12.1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774367221; x=1774972021; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CdcFevE5YsgNIizKbhcUa1cl6QQwN3kpPYwynUoiPPI=;
 b=A/iGkGgutKJ9mqWBG34Y+ZKBSC4KxIaA4Tn2pdplPfrbFdeQYlN5IJWFFcxneYJCl4
 QhyRGEcwpICQZjxWJ8mjAu6iRoD4+KwrM7mcMG4rT3FqJoAZjQsB8TL7XXXG1s1M02pi
 05scLPleUJe2V0fI3AcufDWxqKPOz9ehulPfOJc0agXYz8U9AfcPz9/QDTm5kh0QK4jA
 YnF529oelfmqOsXscepPvOVqY+2EW5LCKSMgLLrF0cgoC4GnkWT401Ucps9AWi1KVk+w
 9DoafMYabyfqO6cMBZ8aqlxEADjq3SnIp1zxAEkXg7egwVzAaYwF/lRf+LOD1SuFc5Oa
 zqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774367221; x=1774972021;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdcFevE5YsgNIizKbhcUa1cl6QQwN3kpPYwynUoiPPI=;
 b=ryEoy4z55gB+8kGK2e2by5tL7josAp1dsCFpCFvmDUb3NtCl111cnTN2Mif5IlwEMl
 7TD1yLMjdXd04oeJsVQ+tzETw3ywL5eIG47rZruS0BFudsM0jnIYsv5one3JJCrggAWG
 /6Jr1AiDv/aqWNa0gNWx99MANwAZkXU8JXolNKqsZXsEDD3IUY6dI484b6njJjNAgMV9
 gFt8dmA7xLROqPP8roEV0TRxKbNA69jjWFFsdFOaTRVglP3WYOnvUdZYgQpF6ezsOJg0
 b4h20bNQnRqCGAK7j1et3+Hmk6EtbcGa5CnM5UCi71UjSz3llRbHjZ3kklUx35IV1/8N
 GQ+w==
X-Gm-Message-State: AOJu0Yz5wXm41N0SeihcY8BdQEaZbVynXuAYUtP7942AvpyC168lZbqH
 IWdcgPmfya/GsvtCHu5YPqkmCS1vKJYBzOg7cDFPReeuj69z5lWCDzKFwDNGdDw1SMEML5YdN8i
 970LLAn1AmV/iiWrLjzxhbTzp5wxttW6j8rvipKTdM1oYAxkKdkEApgdN
X-Gm-Gg: ATEYQzxKLQfzhiX652XXdED+WYt9J0OA/HLZnAr0eBO7e4JwOy1p0vYGx+vqSd6gOlT
 y9quk2RjMZaORRHS9xI1WMzcdo/vAgWNhGfq6W4EF/rivWAfspH4L7RVabx9yhMWwP7ceu49IRW
 insc4sfb+OAKjdKde4AwLl9HPp5SmiH3moTb/4j64kAeX5f99D/SPQOTbx6O6Qr0C+etQm8BW/v
 Ihb4lu2/hK7uUhcfMDfVMHne13C5HC+M/QX5GRW85mStTLe/YsejUc6oDxUiwH9wZ1xzt8UvdNX
 qGAritCGrMS9y0kYoEEjSTtyfMLAB6V5+uO696I815E5Rzabk/CJm3uClCEh59+csGqNUMUM0V1
 2Ne533tN9eiKS98omIK/2ySbcku/87Cmf3yHsirTGa4dSEw8Dq/5xR4ARI+Tvn+Ap7Dyq40FDCz
 84VuOKkp5eH2RbBnIggy7W7e/vMAc43Vd9gvIvk+JomK8PNDG+3w==
X-Received: by 2002:a05:6a20:432b:b0:39b:c10a:bec9 with SMTP id
 adf61e73a8af0-39c4aa68bd7mr279612637.2.1774367220866; 
 Tue, 24 Mar 2026 08:47:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:432b:b0:39b:c10a:bec9 with SMTP id
 adf61e73a8af0-39c4aa68bd7mr279581637.2.1774367220333; 
 Tue, 24 Mar 2026 08:47:00 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c743a7ffafdsm10108509a12.7.2026.03.24.08.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:46:59 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 21:16:55 +0530
Subject: [PATCH v2] dts: qcs6490-rb3gen2: Remove USB controller dr_mode
 override
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-kodiak_dts-v2-1-243c28a3ffb9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAO6xwmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMT3ez8lMzE7PiUkmLdpERzszTTFCNTQ0NjJaCGgqLUtMwKsGHRsbW
 1AMDdf0pcAAAA
X-Change-ID: 20260324-kodiak_dts-ba76f5d25113
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774367217; l=1596;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=U7ftOFpKfUsanznc+NToeVpNe6umATH2uIw8TdeRy/A=;
 b=qH89vSNgpyH0x231b1DwgIyxjq1Td9l4tBx5wZ9RBIP7dIbPxPHvKAA/jISkKTUNzXsC8s5Iy
 nUaxox2DpTzA3Ml+EN1KgoTMw+ZyKtwQqo8e0pbJUkGRERR8Rs1bmAu
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: MGQz7ICNmli246NPdVjhFZKOYSrHYbPA
X-Authority-Analysis: v=2.4 cv=Nc3rFmD4 c=1 sm=1 tr=0 ts=69c2b1f6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VeTN72RG__Jq-RpK3zUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: MGQz7ICNmli246NPdVjhFZKOYSrHYbPA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEyMyBTYWx0ZWRfX8zFMPLbqfnEV
 2D8kgJ2vXfvFf/D4rR/mBstB1ZbDDL50wQPYKuYLCGi0cyKUXNooS/jafcj12TwyY3SMX2MimiO
 XGsMbm+HjDh20mL6e6bacJHPqnvmMpmGne9fvi/2BDebKyQW3cR318lGn4yVjGlBM0xGYKZsoV3
 jA4uuXo2/Jyyp8DHVoHbb/E8FCs17NRPT1WWohNdK5fs7/wN79TYO6os1LNiwT00P08KZLJqtLF
 r0Igib+PNBBCqOV0vbbihfzX5k6JeyrZf3RswJ5GdTVvJ37WDwD+SBdJlmW1IpNMWOwSr9k4voc
 +lmcVzH0dd+QkZPC6xLskSLsX5M5AsbuL6nudbhelhys08Ks86y+yqic6x5bzStQwK1IW2/atjG
 7/J5FbiCHzo4wq8nrFX21IIG0r8H3+RbGNlW4oMVilvIuVeskquvEbubYbNQqPLxhg77uhuVCQg
 TSZb/pQ4JEIlAkB570w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240123
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

Remove the USB controller dr_mode override from the u-boot device
tree. The upstream Linux device tree already configures the USB
controller with dr_mode = "otg", which supports both host and
peripheral modes including fastboot.

The previous override to "host" mode prevented fastboot from working
as it requires peripheral mode support. By removing this override,
the upstream OTG configuration is inherited, enabling fastboot while
maintaining host mode capability through the usb-role-switch
property.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Removed the USB controller dr_mode override as existing mode is "otg"
  which supports both host and peripheral modes
- Link to v1: https://lore.kernel.org/u-boot/20251114064042.3835312-1-balaji.selvanathan@oss.qualcomm.com/
---
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index 8d4871135fa..c3ec4a317f7 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -17,10 +17,6 @@
 	};
 };
 
-&usb_1 {
-	dr_mode = "host";
-};
-
 // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
 // RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
 // RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000

---
base-commit: 108bc442ed292dac4ea9175ede1bc8d1ed687788
change-id: 20260324-kodiak_dts-ba76f5d25113

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

