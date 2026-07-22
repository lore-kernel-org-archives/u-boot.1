Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C56C44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44C6040849;
	Wed, 22 Jul 2026 10:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NvRujSlr5jPH; Wed, 22 Jul 2026 10:47:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BC994087F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717250;
	bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=SUwQ+IB9bSKFDRWHGPw68hpYG+naQ32w0vI4zIUoCbxGYatj4vDeT46YlCIQy68KU
	 Eo8+4lGJAznHncnlPVpQhQBMdQMB2Di5REiOwC36jXatvDHK2MXZHRRZ4a7sqrh8xs
	 4USAAsz3KxWVIq0CaFsOVUWSUgC7VEn2b32iPzaASrUmApkRAZOhGEOECcJBtDrGMc
	 DyCVG2ry+a9HKhRyPV8+Gd2cQib7+7pmb210trXjAb3rDu3NH5SgCg8r5aNpVY8UWl
	 aqMoblhFBt0PyISanachO5b191gO4FP5OqZ238pRMGMzhI0UpMRnHALt/IuYJ5CYAn
	 aq9nKJvuqA2+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BC994087F;
	Wed, 22 Jul 2026 10:47:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 653ED390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 565A280F14
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DD_T26tE5J54 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:47:28 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=badhrinath.s@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BF40080F0F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF40080F0F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF40080F0F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:47:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FC77848BA; Wed, 22 Jul 2026 12:47:26 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA596803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:47:22 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x9p3140659
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:47:21 GMT
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2rg2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:47:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso5702184a91.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 03:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784717240; x=1785322040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
 b=WWnk3tQOe5dvKGXwgA3hm+rQBg1DI0RCK8Y8SrcR36Y4GlY5NTqNOZrjGSYCtCFZcX
 o8QHsKLnzEYqhrBrjaqDJUGuY8R6/FhYBqoudjrP2KCmgMwMjGNxzrTjwDO92DDybvk0
 FPKvY6BNSJfZJulmtUO/oCJzUPNd4LGMJy5nAevm/lVlLzpPwN4zFtGHP2EOrbazFC4v
 XTF7hpcyeWzsL2S+LDk8ZxXc102HAivc95yIAoUXalFOYOPCQMTELQzMif7fjb5LPn3F
 NnUZ2+P5JQrzGR+H42lRgB5q7LYLRnlPHgBRYEaazMPdAe5niEVXgRhXghA1hwmgm4xY
 uJRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RriX3egJPjFdUfSoQH+lKfwzYUkX7EqVXwEZt1wYsA42Bv7/hp8rj/STL1QBG7XScX/mq2AtfY=@lists.denx.de
X-Gm-Message-State: AOJu0YyHc5+nlF1YUJZY2qXzmty1y4hmr8zFuVcy4FDT2WnJnXOf1M+C
 NoJh/Ex7kSWpK09YSoCVooPMXpsjFjSJyTSjB/TajlMxDH0+6jp/mJdcF82VaGABNi9AFP6vEYb
 KEHupUb3N622SrRlvedSjTaVcbNt+xgIg6SaCzlaENEB6T/9SLh34FRGP
X-Gm-Gg: AR+sD12wv6kI0ajxdhygMNgMBZOqHJ8SCTos/HSTFdZOo05Lyb3fNcbO4IDf1ZOLNKT
 /QZ0Fwi4lvpOw029PXljnCNpY5uZoPC5QVegIbVGCeWBasdok2ScTf5FRE1z5CxYHaxDbqnri3+
 mli2munOnDIQah8Th9Ms9LZs0ZO6YVITtgHpsyKiFkosw+opbRt2PrMBupHGB3uj67Sqklj1K+b
 EYr7kdwVpLIBaPIdZMmfYUy5UGikLAKhnKkca8zTRLYT00acJVdQtogMZMrInX2t5+PyCy8D23l
 MsZ1juxQr0Hly+zBCUq6vxr3L6VjDuX3BgVMJy1hwr1rk0knx/sRoa8ORg3UWZ37zp2woFaoPxH
 vIe4YeIfzeMuXdCGnytfDhpUWosCtrKzIOBEh5XVBqiCMYt4Cv0y8uY9Ntb5PVFKOMiR2Z/AENU
 0aGIYqEmlnl7ZrxNL0yoId
X-Received: by 2002:a17:90b:2890:b0:36d:7b62:4767 with SMTP id
 98e67ed59e1d1-38e4b434f04mr23073799a91.5.1784717240185; 
 Wed, 22 Jul 2026 03:47:20 -0700 (PDT)
X-Received: by 2002:a17:90b:2890:b0:36d:7b62:4767 with SMTP id
 98e67ed59e1d1-38e4b434f04mr23073764a91.5.1784717239755; 
 Wed, 22 Jul 2026 03:47:19 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1300401fsm7581425c88.3.2026.07.22.03.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:47:19 -0700 (PDT)
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, badhrinath.s@oss.qualcomm.com, michal.simek@amd.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com, adrian@mainlining.org,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 3/4] arm: dts: ipq9650: Add override dtsi
Date: Wed, 22 Jul 2026 16:16:23 +0530
Message-Id: <20260722104624.3842833-4-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
References: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfXyVIQk599xFbd
 k9Psoipkod8d2qS31DxcP6s1bLnK1q5new/0SdR2nAdRsdu7U0awekOMPKRmRMYOp4hKrAKufrM
 ZoEfT5W7V8bMwl4tjCrVFzKcEPCvDtSaao3mzE2Cf4uhuGV+4ybtfSHk3G7F+5FbnHJi2cMfwxt
 wjbowrTTwXTkU8xiBLm3on+lEvSTg0LsanEMztcGdLpgJcSZIyeCuoptWSC6V+MfNnwoLGZshKl
 170XOI0uzzFSzMAp0q3eTEf6fIMMviHGIAVCGXPpOX34AGFr+1n4mUCXnL1kXt2eHEBs7EdCJPP
 gLpgyGwvQ4E4PlEvajGbL7Buf45SBpGw9w4hoBD029xq2fy3gTMSAjBLG9XCO0RDq1vdcUXHvfb
 XAYWHDLXciPmLCGIWL+aEFpRyOvSVqeZL/lIxMPugRaO1zKBUjturFNrPiiQor/Y4fU/l5yVcwE
 9gw0183gUyqr0BwLf2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfX6jyR52y9aP4a
 FDVdBLWJuIJ5O6RDAdbSlIS5r4a/rEHQPOhtYJCgLsKNfxMMwuUP8oQcpetHHTHlxQdBx43ryd9
 TAwLei2bWdoujSKAigf6K5gt+LPAf/A=
X-Proofpoint-GUID: es-7IJ7SPA--5rsMRKgKeeknIcHxAcqq
X-Proofpoint-ORIG-GUID: es-7IJ7SPA--5rsMRKgKeeknIcHxAcqq
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a609fb9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=kOoMYcB8HEV07GVGuZsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220104
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AjwHog1Hk6Q
 +omLu7CS+KlWnZQoigsQi+ByJXC3MivY=; b=W4pJH7jBMlYBRnm30Z5Pak2wQZB
 7E5Ksa9VuuXluqukY36LPjAvStsPchr0vPiaVQ8UWMtPymAXeOfaGHIX82Bu9WnK
 uimlpN9W/HLejPBy+/zywfh+P01tORRvNE4hjnDXjForHJST7h1AefDU1egryL8y
 maS+GZcLXqIEMOvfs49NNHm4j1Y+QAYCME4YKbGpLu8snPsTVihB4meVlKVMkrnB
 95gsDsztT1TBzNo3O1zlISWKs2qCotr4+hLOF3eh15Niaz4D4bWgQGnpiwdgWiWk
 bNUip2wlKvCTkutVUFT60+MZEo6OmHjjf64z+bSRZIoBDzx7xVBbbK0rQ8A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784717240; x=1785322040; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
 b=AvFpx7HBY+odd+KOhdoiOaS4eFhkNQvWS87tbkmwCC5reef68ldHlXe2gYQ+X6cor3
 7VBMWTXW7X/KnPtXdAL0a6AtSTuzdQFKPmHJJJPqagTUJlu3cUkQuJANuZQCNVhLUUxB
 mZZO6B4l2EALLAwWyKpJVdnTYLDmBVbPGw478R4fxX+SJTATQgMx8SYMOIGbaIEngfUQ
 52BIswwuklKXyIw6S50AVpsqh8nUAFvJD1DA3uAZYZEEzccnKwxPVveASjFn8PhPEZUV
 CnsUVHrvip3kxv6YQ8/thA4Ddm4LgvHDX/NfW+aHLLeHMpdAkDph5frgPzROqOlSlN4d
 mFJw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=W4pJH7jB; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AvFpx7HB
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W4pJH7jB";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="AvFpx7HB"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Badhrinath S via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
This includes memory configuration and SDHCI reset configuration.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi

diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
new file mode 100644
index 000000000000..dd03de98b921
--- /dev/null
+++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IPQ9650 RDP488 board device tree source
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
+};
-- 
2.34.1

