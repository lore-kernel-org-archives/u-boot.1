Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999F7CD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 05:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0BE48465A;
	Tue, 19 May 2026 07:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qk9fciso";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FjhKMTDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47DA8467A; Tue, 19 May 2026 07:17:35 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CBE184659
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 07:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IM7IZY2892690
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 05:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=z6sutvbct73SJi06CzSq97
 6mWGCzsRfYP+esPpGLXgg=; b=Qk9fcisoEpkwyEwF6YmxXdVmJ7QzWyOXa63F5U
 9ImMfA3Y+4bFNZYbvid12kXw74DcleByx8oh24PnEnPVQ+4Q3byRqkbxWBra/87A
 F9y6yNHB1+8c6k7Ck/qyt/woX/kCnIi/442NXHi6a2XAVNOe9Znw174KQYJ8UsjD
 QkK4ed+x2zJXsFoIbHZqEfUV6e+5oJgjr1gF7Yol4gcD1TC/Hry1HR6QRtWWUNAw
 MEYm7vKg6O7ibDtrQWEFPB8y0dGwbQZ7T7D5u88Me7FAz9ciky48mHpWt8Jdhmkq
 g/6rStbWBbxT0cttfWiwT0CNzR409JExGNGsvUeuFmWMGUVg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk1cgn2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 05:17:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-368b01f8adeso4437686a91.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 22:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779167850; x=1779772650; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z6sutvbct73SJi06CzSq976mWGCzsRfYP+esPpGLXgg=;
 b=FjhKMTDPr3noE0qzoDfoAnqkLCrfrFhO0TK/hEogZLakzLcAbWQSzyOjgp/Q2mbklI
 JuSYcFd7HaD9hLX24exOYz9s1zJA+Sf/QHGwyT+ycgtK5O7wv3zciwY0SDIvLWnpHPCd
 Ku3Exr+fXpb5hOFIiH3Xj3wDxm0qRKxNi5phc6jLk863ktcERfAjB7ONgqfjcaOO5tk6
 3yQqq8LEOPEXAEomi4n4+d4TA6gt3UovPp8q1YExsD48f3QZiAcFONd8asb5ZoqmIhCP
 HWUlNn6zYooZT1YDP/hUeOvnTTGzJCLmaMuiXAYlcHzm6l1o/TcTDx/OejQbDDyLPAMj
 sSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779167850; x=1779772650;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6sutvbct73SJi06CzSq976mWGCzsRfYP+esPpGLXgg=;
 b=CO+Wj8TkL4XehrqxLA8Sh5+2HgOt7NpEJ3TMCFx3ivdvndaOySBNenC4lTO0IArY6B
 bQc2WXgSh985T89o2dy1ilpacsfH6zaN+fu5toH3jQ4eURJEfQTn1WGf947+Xib8WzOM
 2lsx+pG4xOW3TUdcJ/IVgXPJHrvHBm+sIJKwhBH2DA2TzUhBsNRGDH7jtt115wG9UNkv
 Q+OEUcHzOPM09ospUror38dXE7jwuZInb4pjTIHyXJYWfxupMNrACUqKzcm5I74dltpW
 3r9heQSY1fThXRAC3PtV4pXoS7uaQ0NgGgHH7GKxcXxA33Nxo3SR8uM/YiHKT+xTAzSk
 yCSg==
X-Gm-Message-State: AOJu0YysHVX6s2NNmnjxV29mih7yFa2o3FQ0rLDG/yf6iO0zcOVlCCtW
 OGHGHZrKQ+BXkLsB0+WprqeonlhSA7DB7xNTqzI7T7yzQhDtRkePFErE8uP41jyxawu7MkM4FWm
 YOvOvyaua9mJ2S8Fy4+EELBWaMHjoMI6uKl9jN200qzQ4UBHcxGb2tlQ7
X-Gm-Gg: Acq92OHXmRKF9e9x9AV2HW1txuoLfdr9dO/dhg1mm4GgRHOR0q6UkSvfb+o8q0bQH/A
 kKoD+XxY0H8jFaN7wY5NlxsvD9dMTY1jaUU44t9OPWbjmj0u4fLF7iihiqbITWyllcAwW6Bq2LO
 EunzVrJlhIl8Zb1OkzPvXGhptFO3U+ukLBYfsgAg1270cKZC8x969em5MpEvYdAMjBUaNbx6sYv
 dd29UebtlL2kfX8eQzdrv2YVNzT1ohWec7xxfF+zfn+RL62CG1n9eUXDCmQcqEskBxcMyVLEg3D
 5Df7eeVy9Goe8cx8Xk3/0VnKp+1GYaACBqMjkXwTFkM9C5uQPKelGycBAShntSSzxOGOWyL/gZJ
 5iYGwcCnAFpIUnEazXnJsm6XSG1mgSQwqwdeY9r3qH+peLQC8ZKl9Qmy12xfDGITH23EU0JPptv
 TYRxB5k+Z8BsTP3WE7qEZ17s3rXZjfH/hFELjX8eNIkugt1CpYlw==
X-Received: by 2002:a17:90b:3b4d:b0:35f:ba8e:150d with SMTP id
 98e67ed59e1d1-36951b75db7mr17144414a91.14.1779167850398; 
 Mon, 18 May 2026 22:17:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4d:b0:35f:ba8e:150d with SMTP id
 98e67ed59e1d1-36951b75db7mr17144392a91.14.1779167849884; 
 Mon, 18 May 2026 22:17:29 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d23a41fsm169761105ad.83.2026.05.18.22.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 22:17:29 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 19 May 2026 10:47:26 +0530
Subject: [PATCH] arm: dts: talos-evk: Set USB controllers to peripheral
 mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-talos_fastboot-v1-1-6908b79ffccc@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGbyC2oC/x3MQQqAIBBA0avErBPSMLCrRITVWAOh4UgE4t2Tl
 m/xfwbGSMgwNhkiPsQUfIVsG9hO6w8UtFeD6tTQaWlEslfgxVlOawhJ7Mah6bUcjLJQozuio/c
 fTnMpHxCljpBgAAAA
X-Change-ID: 20260519-talos_fastboot-d9fe9351692a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779167848; l=1066;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=mikUSSagoqpjZG+y3+MX0F1I9d0AXaT2hRTrvxy6EbM=;
 b=eHncS4u68YZM5jf1ygKUGORd7RWx//+AR90ssaCd0/t2dxi1yHydzw1uPhAbA4/B8y9VZz5Vb
 idTDWynZkOaCKhSiN0m97CgdT5nd3WxHTwpsdbSBHAU17hHOcyxtP2m
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: WRk37MKO9qVeIg5DRBNP0EeaAe52VM2w
X-Proofpoint-ORIG-GUID: WRk37MKO9qVeIg5DRBNP0EeaAe52VM2w
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0bf26b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=u5OGKguPy5VyIZgQgecA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA0NyBTYWx0ZWRfXx++/a3AYUCS/
 8SZ68StSBOWqNfYU43zEYtEhG7fo26Fc7JhQGlINq475g8qWn/roIGjGKfRQT74AZstD4GWkaII
 ClB2beo2VHmf7XFWJarBcfOyDfmlltGPoXTqFKDKuGkiNYidPPU8TAQ4YWj7qM4ySFa0qfAfDxr
 bFluqEFWtzLxyW0yRRCK0kNPai2nJ21l9hFyP9yxsZjIO7D27klEcO/l0EG9X1Lzp+eoV4PoHPo
 UrfYLVioWjzr8y04Ws1Vzl5e0BJdHBAcrSV8eOogLAVrOKnQ8GJ3TNT+46AxceqfjoJK6Rk0YN3
 ack8rzEpNAQNQ1U9TH16TS5z/x1qYC5E4s/Og7+UhwbpdbfOmYEf+KXNT6Y0Es/ZizXN4lZfjIh
 Eot3shy1CbhUnqODvik9FLuPRJ2ujrgevHMrPN2w/ifEDp+jYEWw94c7muNqVdoo/NeSaSX+c4L
 jUfRtYUT0ly6AzT4aoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190047
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

Override USB dr_mode to "peripheral" for both usb_1 and usb_2 nodes
to enable fastboot and USB download functionality in U-Boot. The
upstream device tree configures these as "host" mode for Linux
runtime, but U-Boot requires peripheral mode for flashing operations.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/talos-evk-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/talos-evk-u-boot.dtsi b/arch/arm/dts/talos-evk-u-boot.dtsi
new file mode 100644
index 00000000000..74c3d37e2d9
--- /dev/null
+++ b/arch/arm/dts/talos-evk-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+&usb_1 {
+	dr_mode = "peripheral";
+};
+
+&usb_2 {
+	dr_mode = "peripheral";
+};

---
base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
change-id: 20260519-talos_fastboot-d9fe9351692a

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

