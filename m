Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BEFE7490D
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 04:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38146841BC;
	Wed, 24 Dec 2025 05:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gK3w/sk7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DT93odhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E56841BD; Wed, 24 Dec 2025 05:48:06 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898FF84198
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 05:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BNJCrqb1056218
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 04:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=3sEktVcYI/kpco4D5J7+jG1hC+ETkI0+hsy
 n6cv/IPs=; b=gK3w/sk7QjPm677adwk+v4w/MjcnlK1+caLUA1Q4G+iShSgtyLR
 5VjhhttBxRKN3p7a1gWUQnNVgL/PnwhQa9T2n3uYkrPxs98p7ughLcJMJpV5vSUY
 WgG/1H5bRph0jbnbvqoE1QZ/cXCi5jDHHhFRgZ5ONodex4filYq+0trk5KEGdOQ7
 kqBFw/WaEyls0ApsZDPnXuVJfd1wivoSwnZn3+Uj/svY9wpn3rJ6KZ9NvokMVD/l
 rKYuDxqUwzxjiz8GT4U+tHfM5MYG8OnIq9u17BWF0pMRpVk/iZqCwwwbuwNwYGqD
 190ZPlsx/K+LaO3yUf7SUiULIWJ6ZEyc8iQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b811v1ak0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 04:47:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7baaf371585so3827145b3a.0
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 20:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766551676; x=1767156476; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3sEktVcYI/kpco4D5J7+jG1hC+ETkI0+hsyn6cv/IPs=;
 b=DT93odhjRr3aUPuIeWaXOUBa2Gnqo3FMM7u+kA0Cj8Oa8925WWh+ws/Ls+xQvCJBy/
 MujLgv+iZmcS+d4HAadJccS/UltUJs9k00sPpz/oomRi98mr7b7CnfDaGv0p3fsez2ba
 HFYHPUVY4k/201qr3aImxodWeFMrQpVMIvapGyRMHfDSG+I6xqRUx/oQi98rL51vpFr5
 DJZ2vMKE+dXW8KbS3BGxokrXEcwCTQ77mu1W7jD6adJhFG5egXF/kU32BaXacVqkiTEW
 NJAahwgpFX4zJ2YmVjB2mr76CnCRXblMx4fptySn+WOqYoibyj+dTB04RRi06lOG9OLh
 L+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766551676; x=1767156476;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3sEktVcYI/kpco4D5J7+jG1hC+ETkI0+hsyn6cv/IPs=;
 b=TWPefKy/FbH2T1vlKsyA6+2mOnucgPzphFlWE/ZUFU0FPKUZdvUcXsYmLom8fkl+JG
 Lt6a/f6aOf4Vw0P6vlm6HdWRsgErS9Jyl1zXC0vt54Aq7PV2drvm0LZ4/K3TyBGRs6TC
 TegewtEwbAZS/wnerUSF7SCOR5ynICgxYnsMK3AzqzTW/CMzWaWORO0FqnC/UAViTB0V
 XCHJKhGPYQslZMod0VhYjNhwiRXqxmeL5+qJQpKcyRrkvhBZAqSyR9S+bT3ttPnRKI5n
 zkIYP7E5Pbj/WR94Yj0ZI+wcyIdxc0i8Sg5PCcd1ZeFxlOhXSZMtfI0es6HX3JggJYW5
 f/9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvH18YWUtVZbfrTC4OGgYbb5kOA5WEqSHpGYarjuhoMhC65NTLC+zDEIQlGkA3MquEgJ2RNaw=@lists.denx.de
X-Gm-Message-State: AOJu0YwtUgFNDqyQuLJ8grSJmu8XnS8bKXx0xouOZLWuVOg610RKu1LW
 HCHqqlHRKA3IgChREW6CEGjzgvnd8tamKmaitYyp56IlEpvi6IisdgPTAFwbSXeYP6dFZ1mk0N2
 G7dynUsWwe38dEi5n7Wa32c/Z15eAdWI20eB7g4eDfcfJZE2d1z/TrRzU
X-Gm-Gg: AY/fxX5RwJHSrQpCLf7uo0bOUb3SbgIarl9Tkqjorrqt4EAM0xzGBUMr9ycVphyYsWn
 j6rmQpn5lVAfrCQU8zL/Y0UuDC6jJjpmsWcGHsgr0J/hNE8jHy/Cq3M8bpJKpieB8O6u0hfaK8a
 DIgmyIMoaenPJpsS89YmW/UbTBqfU/oychRTOd8jum8FfASY9Pqdc2GJEcnQ4GX/StsdMxi2rwz
 jmg9LWJj+I8waB3K6SDSLe/zBmjE4+6hAWEZ0ZQI+MeO6SsCv5hTMlCLEUvjhrISZLoYvXHpmjV
 SUxDqrnbBAgjTJMyXSsNrL/wjv+3A/yyhwBASLn2SgelTlr2n6qfyYDUD73OzB5OetxYYb1+CKH
 gVovIKRgs0Hh97Qef05xRBKXyq+M6fBFLQUBTsW3NI0/3TXIiQHUEtzIgXcVrO++4pX75wEfY8u
 bHneS1gC7fd5yZmHN92EDD3MYuQoAc0R0ECO6UdA==
X-Received: by 2002:aa7:9309:0:b0:7e8:3fcb:bc41 with SMTP id
 d2e1a72fcca58-7ff547df601mr15079685b3a.22.1766551675857; 
 Tue, 23 Dec 2025 20:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf+ifd2PQizTx/GlK4OSfe83xLZueXuLFJK5U5xHmea5TcMrvrLEa0pcxLFy6EFDLVostSsw==
X-Received: by 2002:aa7:9309:0:b0:7e8:3fcb:bc41 with SMTP id
 d2e1a72fcca58-7ff547df601mr15079666b3a.22.1766551675325; 
 Tue, 23 Dec 2025 20:47:55 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7dfac28fsm15248263b3a.32.2025.12.23.20.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 20:47:55 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: lukma@denx.de, mkorpershoek@kernel.org, marex@denx.de, trini@konsulko.com, 
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 gchan9527@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot@lists.denx.de
Subject: [PATCH v2] usb: gadget: Kconfig: Correct Qualcomm config name used
Date: Wed, 24 Dec 2025 10:17:47 +0530
Message-Id: <20251224044747.3898137-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDAzNyBTYWx0ZWRfX+Sz+oVez6U79
 jtj6BBta3VJjYt+0Va59kPYcBfqS+/zD3f/YznEr4YswSbF+K6ZIEbV7EwdfmaJjDFHLKGe39a0
 3duwY3790GSNChScJs9hhBn6QeFVJfrKHm13OKDNsprohkYvqKxXsPVJXZKzHVeCVAkDGCjoTs5
 4otGkxUBrRe8AL+i+CJj2nX9p8vWazkftcH+kFlpU3MNsQOAAHsscwaqg2ojtZSp63rqWsPW6zt
 8OqWrDzz/gqk3mXpP84bznPkYN+iZYRA4mPiSdFnF929k7Y3OlegSyG93dYqQR/GXQxYvF5RGPk
 yCNDX1YVJMHn7viI7QLfkSqgib1j7n5TZ50YipE8goeokqW+3UErzDT3HDOSe5vEk20wkw/ddq8
 4FijBvnr3tksFd68+WEAdCi8KDZQVEnn7VVWGo7zTw+UJKnpAG8RduwUrZ1FOJmAfutpJFCTHK1
 Y7UgEFZ4YOvKiw5mrIQ==
X-Proofpoint-ORIG-GUID: BmJ15uW2dMpFcsuh98Yw3avKjCkEMSWi
X-Authority-Analysis: v=2.4 cv=WegBqkhX c=1 sm=1 tr=0 ts=694b707c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ztfn3FVH9eksO_uVlSgA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: BmJ15uW2dMpFcsuh98Yw3avKjCkEMSWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_01,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240037
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

Correct ARCH_QCOM to ARCH_SNAPDRAGON as ARCH_QCOM is outdated/unused
config. Using ARCH_QCOM was causing USB fastboot mode to fail.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v2:
- Corrected ARCH_QCOM to ARCH_SNAPDRAGON
- Link to v1: https://lore.kernel.org/u-boot/20251114063507.3834973-1-balaji.selvanathan@oss.qualcomm.com/
---
 drivers/usb/gadget/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 7e08aeab904..ebb306852a6 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -61,7 +61,7 @@ config USB_GADGET_VENDOR_NUM
 	default 0x0955 if ARCH_TEGRA
 	default 0x1f3a if ARCH_SUNXI
 	default 0x2207 if ARCH_ROCKCHIP
-	default 0x18d1 if ARCH_QCOM
+	default 0x18d1 if ARCH_SNAPDRAGON
 	default 0x0
 	help
 	  Vendor ID of the USB device emulated, reported to the host device.
@@ -89,7 +89,7 @@ config USB_GADGET_PRODUCT_NUM
 	default 0x350b if ROCKCHIP_RK3588
 	default 0x350c if ROCKCHIP_RK3528
 	default 0x350e if ROCKCHIP_RK3576
-	default 0x4ee0 if ARCH_QCOM
+	default 0x4ee0 if ARCH_SNAPDRAGON
 	default 0x0
 	help
 	  Product ID of the USB device emulated, reported to the host device.
-- 
2.34.1

