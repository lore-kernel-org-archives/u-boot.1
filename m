Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFD9CDE014
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 06:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A04E783FF4;
	Fri, 14 Nov 2025 07:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OIAU3VjI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ja/OgGqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C780E839B7; Fri, 14 Nov 2025 07:40:52 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACAC882A9E
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AE41H392263210
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wKFciuafTEbrwV4XccjTDtl77QerWWgMotb
 WY4HtSjQ=; b=OIAU3VjIw6sBj8QJqGfYT9sOGVi2FoupaKwuffSmCTkoAA/Xh92
 j4WfsNnyzV93tvOpaCb7xZfIfIbtoWxfCSA86ohlGr1PFRUHMvk0vkmoZRQIDNyM
 zbTMuVb0KJOcixTl0Q+BRsInKLIUy8SKwux5T3iDTOrTJ+tLT7hPq6XuKyD8TNIV
 otyn9gHKSAU82zqGf853fCpJ76Gx8y3OMRnKXe0N+67FkLOEMxnzD2okBV+Yiyh4
 D6yUfEORvaeeWVL8CVg4xsEebMK7FH5qCBpp3Jw8VmoUuYyOqFAh33McB6kNKVFO
 Q9FU5pgDSGQGtWpWVJc8XpgjTnZ6Qy6GIhQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adw1j0bxc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:40:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-295952a4dd6so34166075ad.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763102448; x=1763707248; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wKFciuafTEbrwV4XccjTDtl77QerWWgMotbWY4HtSjQ=;
 b=Ja/OgGqRgcn13iqugSI96PwyPWmp6qZyE7uv8nVUitkml2GLSRk+r67vGyB3Kk2Q36
 PJWVjkZZnyfQ7rKsjVuOq1wD9C+dRbGxZbPv5ggvPO4LPh3KUwBgTS0FTiFVIhMucwaj
 SvMAA8DBZud0i7Blcdpxv9zA1Wq5aw7HVdTbbapV64wnOnE1lrMrBquTirEaSE9AU4wu
 LwS43NBglcSde9ZCwL8wW7q8D3Zaw+3ZPAs2ZktJWUt/MTBF1ec4nRpeyh3sTGl5oojR
 g1bLXcQndGL7m4JK25NaffHZsC2atq13MjqKqUlJhN+B0xGZSI3+synioFsY2libkpo8
 qzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763102448; x=1763707248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wKFciuafTEbrwV4XccjTDtl77QerWWgMotbWY4HtSjQ=;
 b=OXdulnwYFx/b/4qlUawKRXpktuJtBY9V/8gb43dOdbYrroFRiQJ8cVwMmUV51xpnS1
 Wv12lfr85gtenVHEgVt0Y26YaBM7yN2l/csK8p9hqgAkpteICf00yclYUyNljICZHszK
 sFJoscFrtV3llpA+lN+oOuG4OFRAxLXFOHe32xYXXzmLXRHb2rusWYkP2IBqIhDMNWEu
 hDlqsxJrqNWr2PP19maMRioBh/avAK1rXx2OXom1/JEqvZIn082kBspHo3MFuP6n+o2I
 S6oK9vgTormVW5Pp08WyAfnVa5rvsX5nIFkHTbGNwDNXydlG6xnXJzdrNBktlb/RIbld
 YL2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrb4He51PVjklxAvSK4LfjmhCHx6hsx3f0IA7jps0O2z0nDUssxs8gPMvzWKF8qYUl9Rrzr4U=@lists.denx.de
X-Gm-Message-State: AOJu0YxoouZhnUuzeSb3yuCvGk3/aDV8o+PeYYwQgTSSDD31OwNUf7nH
 IXrNk5ZyTHTbJzUMWYQZrKyjKs4DZSoCIs3Xd+EKdTZ8P/FFMLE2kxue7uL7xoaD2m1rSK43H6I
 vHu7FcIrO8wWmSIympFpIei2KFhryQwhMZPeUDjNNyEi0ykBrTm2wHTWx
X-Gm-Gg: ASbGnctdno8+HUQXo2wTl0WsOaWg8UM+UwgC7yoGFTy+EBPxPPryNG9XvemFoqC8s38
 qyCWBovj6TmAG8+M8QT1MrBAVf4GPKt01TqGM8zq4CAfJBAlKyJqo7LfGAxXKsR2+Ri1oZw4CSI
 80W3p5KHVy42w0WryLxQI2BXixjPRrYIUKTC4PsKuZjQfL8koOQ/27u6KPXqLlSfQ6qa2MLNsjz
 I1Jk9p12yKJaNDUlrtVad8bV8Y0lqrsgqUsnWipNhudiukhQ4C62BW61RTmCKgXZyTu7UF3pzQH
 XmaiiorEjXSs4fqi+0DWa3ruBMBA4jxREv1JSME7Fq3X+mpKIfgme6GtXT2CtBagU7+EpwreffS
 IZnIppURKgDjRmcuPM+VqTHUZC0MAvwk8U1gZawePKNdLnRLyAXKIqkQt9nsmgaK8CbYH4UutBU
 jXuqEgcxj8NmyQxTp4GgLu724l6flH82uHXseG2w==
X-Received: by 2002:a17:902:e80a:b0:266:57f7:25f5 with SMTP id
 d9443c01a7336-2985a4ccc61mr76652615ad.7.1763102448231; 
 Thu, 13 Nov 2025 22:40:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdtx9UHQTWh56BPxvRUDb9rZ00uMbk7WOjnK8/EG7PnGBgeVv8LWxz3kvymBKJoITSkTe+Ew==
X-Received: by 2002:a17:902:e80a:b0:266:57f7:25f5 with SMTP id
 d9443c01a7336-2985a4ccc61mr76652525ad.7.1763102447711; 
 Thu, 13 Nov 2025 22:40:47 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2ccbb7sm44104315ad.107.2025.11.13.22.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 22:40:47 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, u-boot@lists.denx.de
Subject: [PATCH v1] dts: qcs6490-rb3gen2: Switch USB controller to peripheral
 mode
Date: Fri, 14 Nov 2025 12:10:42 +0530
Message-Id: <20251114064042.3835312-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jv38bc4C c=1 sm=1 tr=0 ts=6916cef0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=dDU778MKnIizena4DrUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA1MCBTYWx0ZWRfXxtxg7vm60g2N
 9AZDhh7ANzaOXOQ7M01FsqQyU0ptHzEIAiUOZgT5CluQyrwbXAE+nKKSCF5/gGTTrl9KxK7ySgq
 SksOGhDFHZmx3VJvXbEUO0J1kfd9CDrSCNizO1VRisLCB8JvioWC3CEk3EB+ZhHQX9m5geU0WaN
 O3QDhf6Hy6ktRbdK/ioh0/rq6oGuILSVn73hIc53uDQwtp3rZTZ1b7/AlK9D7zQwaig3BNKao7J
 abA/7maJPKA/8d3QqvBv3+EVToyeuSrDdg4XtB52YvWSSd95bUyVVhLli6lu3isin4kyhPKDy/w
 oGEw7P/jCgob6FR5j0yKx6y/i6RtK3DtYwlE9MJwZA9IrIq1/tPgOVOQ1ReH6cZBfNa8Qwunhs1
 PNg+aERcMfBkSJ0JKuIq8pnp+gFdlQ==
X-Proofpoint-ORIG-GUID: DlF-dHQ_GHdVMh8Wo-0yetgIVCIdCXVW
X-Proofpoint-GUID: DlF-dHQ_GHdVMh8Wo-0yetgIVCIdCXVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140050
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

Change USB controller dr_mode from "host" to "peripheral" to enable
fastboot support on the QCS6490 RB3Gen2 board.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index fbe72595f5a..50674b692ed 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -18,7 +18,7 @@
 };
 
 &usb_1_dwc3 {
-	dr_mode = "host";
+	dr_mode = "peripheral";
 	/delete-property/ usb-role-switch;
 };
 
-- 
2.34.1

