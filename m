Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58EFC5AD7B
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:19:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 773BF80F65;
	Tue, 11 Aug 2026 05:19:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kVS_KbGnMXsi; Tue, 11 Aug 2026 05:19:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CF0E80F05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425581;
	bh=/OrrAwdS86AmknI4lX0kHSGZGUQDeakEcUiF9jKBvm4=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=s+cV4W99a3T95GOm51rpP88NHEEz6evFyS9euLV+qs7I6KSKuhxtMdrCS0pV6vaf6
	 ZIW6tFK7pDZ3xYKZCmmtD0sZeFQpVO9e+O4Y6IWQ66+GO/Kvb/f4wuOXS4wEr9KfZf
	 w23ueFRJCpSZnGBvqZb4gEKjXeK6IjimyEmv8RJ2wBDXHSEFt8Uumhoi76n/cTspq4
	 8O2ybZolMlZvRvfKJ9fgwVxd+7p1dHCsEzreRL+6UM+/n8u2NuPs0+e4GoraSP5drn
	 6bKXAYa92mFAea1MTuRyl0Dv3H1ik2jtV4pU8XkWjVNoxJjT/1uiT4helOSEsXs77j
	 L92ZveY6j2qNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CF0E80F05;
	Tue, 11 Aug 2026 05:19:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BEFC259
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E20560634
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c2tuH6IDxDTv for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:19:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6DD4C60629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DD4C60629
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DD4C60629
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:39 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpvOq3553006
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:38 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyqmk13rj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so4230385a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425578; x=1787030378;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/OrrAwdS86AmknI4lX0kHSGZGUQDeakEcUiF9jKBvm4=;
 b=mf+068jPKBRKe1iAdA6+/wNYoIXtB5UHIFqA7u/ApXmOH0PrOeQG5gf2kmOwFklQx2
 +RaYVXv4BGfjbOTEu7DG69UoqJvMHePIVeZ6gfIU3JCV2MPyrpy967IcV0KnB3Ic+d82
 QM+BJi4fiyCKOu80FVkH5jpMvZGsxzsROthKs4QBJwZDpQX6/dQo/VNVuzsupTqs2Z94
 ZrMt3t1WEkC61hX3gLGsBUJNFG+KducWKbTROtFtC+dh2BumBN0F6XIXxeTsbkJzc5wt
 NlcJQWWm7msb8ZI6dY2Dhm+dxgb+VhQA0qCGWgSo4fa8Hd8Swa1TCg6Cqq3VJqm/GRU+
 Qmzw==
X-Gm-Message-State: AOJu0YxSrUMJ0oIqKodTHhZkSYHTmPcwzTdtRYTj9qFuwjYhkUuhVUQy
 uR/VT9S5zNlzfZX33Z1UriPX0gOja5BQ9DeXoz5ta5LEIUR5QVwPwm3lQ/SNhE466uvyOTNIUBa
 D8fxnAs1LrYAc7fXHC5Z/n4f/XVJAx6x/SkLPiQkpWhHX29/eh4O9isiiAFPloa5syJM5i3s=
X-Gm-Gg: AR+sD13B+qazXJEETKgkvEoOW7PqW1WvvMrUXyA8FlhhZjFRfyUmMAyhy1oUARFGClX
 qyxhYqE23sgOS2HxfMxUzlUzXsh7TQ/sfsY0nDFAQsbSGH50e0QmsyqKGJ24izScA27Q+5D12tm
 barCZNulCOysZYUZZXVZlGuRcmsPLRPsRFnFzx18klx/zqPZwyNICbtIsxOj91Yu8hT6btvblOK
 jI/60n3cp/Bi7wTHlrNlHvc0unsrVZ2MbMs0sot63bxKIG8hAR7GpHRfOsxQHeQ9Jw2pf3n36YG
 eq4zvQqFUoSZN1x3ehOO9Z7Utna4prieNKv0jEbONy+WurIoMdsyiGTABuW2qxtYYW5U0xBSzqm
 HVAR4GZk6H/2VQkWn1vtVjyG3oSqo5UXCF98DcVmlyCnjqhGXaLF+kTUT3O72Tf4NxVHGr/2IJ6
 BDf/p83x39ie8pZhJE/gDnzpCYkusX
X-Received: by 2002:a05:6a20:b787:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3cc2b87cfcamr1323829637.13.1786425577911; 
 Mon, 10 Aug 2026 22:19:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:b787:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3cc2b87cfcamr1323780637.13.1786425577456; 
 Mon, 10 Aug 2026 22:19:37 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31c619d01f8sm1353804eec.2.2026.08.10.22.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:19:37 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:48:40 +0530
Subject: [PATCH 5/8] arm64: dts: qcom: add psci reboot-mode edl node for
 lemans/qcs6490-rb3gen2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-reset-edl-rebootmode-v1-5-2e15adc156a3@oss.qualcomm.com>
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425541; l=1590;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=/TxXU5WB//NDk+txt8cbltkQQ3ANuoLfvpn+ewHNKFM=;
 b=RThshUUgWPQm1WL5Zrhmfvc/41CmdKGL2/s37GUxUe2z7PuGrSS6zfe9+z28/AhXhpN6WSV0g
 /QZ9L3wU46aANRaALt2s9XRyu78xlZRfYbGEhL6lAdflmIRPYYuAYFg
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX/MNvpQETZ6Pn
 keydW1Z2uqwc8+FlZAfiANtvOBH7LEiZtPR8kVtt1GBdHWkG0A41fTaRi0rjhhkeMgY0ZMMFLyT
 0lHdRiELdAFX9paX3exI3RTWOUuGat3ezpFtVaDUFaf1ToN7NIWOKoUx7NyNzXUOfEqf1FanYUh
 wbYGxV5RBTsqTxeOD5ECShSlSd8HlXzBfPBkY3LcRrJmUnrq6EsW/xyYU02T4R/GzAMRfDRsV2E
 8j99ePvkqLxWYJtQ/WUtZF+E+QGzrpjaNo9qTkpvtXYXmZHHVbxr1x2N5ca2Ci/DYIZoYPdM1Ii
 9apiiSWB5f1nLaaaubO6ETkyyi8gIPlZWZsS0HGhZXgNy2EZ0QInoERgDmGIBmUmgod5ZS6Gw8U
 svYkU7r4FyQqW26xNBuy+pYiKFONFVz4tXtPFb0WkMlkDRsLkX8rw6FuMHdkaNMP97FfLB1Tx2G
 8sFfeMfgDd8Pv1F67FQ==
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a7ab0ea cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=qXATn2-v6byCqi7T3AYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX/6DCz6Y2prwV
 s+PPU0dpS1UsU0aqFu2iPaqjQyCyfnQ2N4DRgZIiKC7xpA/wrqaOQqDGCCCttolwjuc6aifvZKs
 9M2w37yglYntTlB6w/ewJOn5HIzGkOw=
X-Proofpoint-GUID: ukGOpvcRGXVsAGMoHQ8pSFTDqiXbpCbP
X-Proofpoint-ORIG-GUID: ukGOpvcRGXVsAGMoHQ8pSFTDqiXbpCbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110042
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /OrrAwdS86AmknI4lX0kHSGZGUQDeakEcUiF9jKBvm4=; b=gBBgjQeooQg3GaH/
 0iEtzfFIH4VbzzmAGre81jTuKf2zWWUjs82h7P3xmjkOBiKrOk+3xMzG1i05SM3z
 z0X57SmfYu+q0XbVzcZyXMLuVBQyl+nFMp2xVbrznJrVwPsT7fCL/6qLyQEgSERO
 VLKj1XthN65xi6LkzUrEfCLhBv5E/olfVpoqnXnroMKnKp1q0zH9f6T77zebBaDi
 SONMwPYceK4rcCTjHgk3H0P390vos8O7z1gRJz9zzPHr/C1uaJWJMxc1GcVdP8M5
 mgB+PDFQW7BcQaoibIe+NlvYAvU8A/ROpBFCmjF37sBK7SBHVkseNyzTmB4U5WED
 zVIg7Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786425578; x=1787030378;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/OrrAwdS86AmknI4lX0kHSGZGUQDeakEcUiF9jKBvm4=;
 b=Ar6iPKq/I9U+51dpBrnzk+iiKhWxhG3eTW9onLyDOMuSqjPemrh1Sx4iBS4evCv5UJ
 2ndg5Qt+Htl4C2nwf+/gfWU8qqLAyp41TBxixcM2sgrpY9OPge1J4+KqW5rK/P3AoV0o
 8tn29KlYh0gND0tVwV8IVIPx6HoOMK7x2nUCdgmzPy+abNoAVbvt8nVoudGsapEwHiBE
 xtR7QQi1IHYvBBovUJHrBBGrasRxyfydKlLp6Ij/46u3PrvgY8y5js5FmubTy3BRCrvi
 +1pX0TfoFGr+3qgudwZhMBKi1emCZYWNrLL9Y0BrV5aCCXPXXaZBGW7i+qgL2iiSMxj0
 PKdQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=gBBgjQeo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ar6iPKq/
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a "reboot-mode" subnode under the psci node in the lemans-evk and
qcs6490-rb3gen2 U-Boot device tree overlays, declaring "mode-edl" so that
"reset -edl" enters Qualcomm EDL/download mode via a PSCI SYSTEM_RESET2
vendor reset. The magic value <0x80000000 0x00000001> is reset_type =
0x80000000 (vendor bit set) with a cookie of 1.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/lemans-evk-u-boot.dtsi      | 7 +++++++
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
index cdd3d32f61a..e6ff510caa1 100644
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -17,3 +17,10 @@
 		      <0x0 0xd3500000 0x0 0x2cb00000>;
 	};
 };
+
+/* Enter Qualcomm EDL/download mode via "reset -edl". */
+&{/psci} {
+	reboot-mode {
+		mode-edl = <0x80000000 0x00000001>;
+	};
+};
diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index c3ec4a317f7..e0e6d32c937 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -17,6 +17,13 @@
 	};
 };
 
+/* Enter Qualcomm EDL/download mode via "reset -edl". */
+&{/psci} {
+	reboot-mode {
+		mode-edl = <0x80000000 0x00000001>;
+	};
+};
+
 // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
 // RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
 // RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000

-- 
2.34.1

