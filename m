Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9A81073C9E
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8625984118;
	Wed,  8 Apr 2026 14:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvUAVnUf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E+COyjfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB97984150; Wed,  8 Apr 2026 14:20:57 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631A18416F
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6388ERsQ1796841
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 12:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XwN4kGD9ncW
 qWLhKNsNZIHuHZieDe07DwJqxo/7nNIo=; b=XvUAVnUfvLuRt+TXlc/mydCwK6f
 gSFusL+mW8+JhS2SUj06nd4Mfzz4DOb2JKEjAvw7JcyqNRTzsuLW1U1QCCzIRyiW
 CdPpeF5eedF9iWNz9R1CVF3uckt33XnSXeHWZAEj8OBRJdACpuQi/pq0Nb6xtcbs
 zr+jssrDi9Em1IR5Y12oncsbfM0LCQsmMfhO8LCUJPTVoFs1qs7qh6Log3l6Rp3b
 F8QzuafnRxmEuDbcI7ft1sZzHFH57VcIdtAAmCeMvaLQz5ZwYSBcrPLaEZ+T2niA
 I8rtwoTPBGNBbHYwcaXQYNKq2YAWQRj4Lo67Q7A4ye73hyhZZroBkqJicMw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51dc3v8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:20:53 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c7a84a43eso9528204b3a.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775650853; x=1776255653; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XwN4kGD9ncWqWLhKNsNZIHuHZieDe07DwJqxo/7nNIo=;
 b=E+COyjfMO92KhGxaMiX5GN4mFQQ0J41UgXvlrc0B15WaKUNUMOQ/zHG9Kwa+OlfO+F
 nZHqDOs0zuYOHhvANjtPuye6YXqwh48O0C9lIeEwUB9aUfNdSzigTdDb4JOB8/CH+X3J
 BFidqhvaytkQnc5i83gma/wHbz6WPW9/XujkQRwwcZ9ZPMEyR8IkeiiHIIEXZvA87aRE
 rnWa0062Czq0IoLyXSbuX3kCuadYaJU33+TJvCEB15bLrcAZLeA94eRDyn4HBAXl+B6n
 7yY8/BNogcAUpxQPIx/IphqJkb25XtNu8pi/UlKD3lA5HKrTWnMXRZp91majyCIF/cV9
 G3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775650853; x=1776255653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XwN4kGD9ncWqWLhKNsNZIHuHZieDe07DwJqxo/7nNIo=;
 b=KGvJulkPBphhzsFWtHGhXvx/fTxbOIzTv8mrZx/o0DPO+eZIiNgCMA3NMo1Gmy6lrw
 g9SdPmCVuj4EBrIv8yvgIGxJYkKaMk86DjkQYh50A/iWT4he69lNw5LNKUDqRBgs33FA
 e4Vl1Z5dGWB3mWp2xhqDdv7Mll14pVUUET6gPxKXvBv66SX6I2SOXG2j6Ma+On2DmDTZ
 ImxEZmdkq5Q74HWscMRKTOxwq0216eJheXj+slSqMHz3MlDJu4/Ycjs7OToOdgsVijWh
 Rm9HSgysNEhIjqKoB4NhjCL2WdJHHTDW8Vv8kS0E2nQ1KPPEpZ1MWOZ1LF98z8fVNcLo
 QWSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFMS77PpeQk1jdtLD2A0OofiltsWj6jZvHoWJpcJyRo/gNEDq296AaYbGDaeQ0gM88lc+sbIo=@lists.denx.de
X-Gm-Message-State: AOJu0YxuPLO4kgiS6sUaBCfrGzg+0uipkB8qijbFp1/ENE41z8A3Vkgm
 yLXysj84ZN059PQbqRBViscvt2S/nQRplMmCXDtCqRg5R7NsiPTwqN5AcuTZwX0K0ckNC2kepAg
 Mid//8q+fG7WJlsic8ipRKmE49b1emiudzMQb0GjP8V+lVAMFk5VfZnor
X-Gm-Gg: AeBDiesR5fQGcuy6gqxaBavmjtUlMB+gabIBmGb0/E7bDmqkMSqhr9TjrtE0Re/OTD5
 VAClWM6iarX+DmOSUWrWXtgiacla2ZaCZA7TeKqesMegEwgmkLc4ejuxZqLXDcB2NjbmPrnmqOI
 E6R6Ila5pZ1cN6l0pC5CJBpyors1p/vu/Lc7mjiF9LLJu06x2cgwe5LQUSJN5PLHb3SmLeL5k5B
 Ilpiwa76euSby772cnwRlxJjSCarmEWfUquHj+ccYGoqlStBDmv6IdP3w3guCjCwcbXktScncI+
 3ND7FT7bdVg9j/AZz/RmeUGoczEp/T01QCFPhHDRN2tHuN3LA+XHb4ra/GpUBh0sAzBjXAgyQ+n
 76vbZVyox1GU+Tp2SODA3N5CNcNCw1Q5FpZuMv8N32Mk6/QEv3xgjJ4Bj2Uo4UrvdDTooOLp8AF
 2g621mBrG6LzH16VitB3O/mMVkST4LEw2zGw/LiJw3
X-Received: by 2002:a05:6a00:10c7:b0:82c:eafa:8863 with SMTP id
 d2e1a72fcca58-82d0dbbcc99mr21566117b3a.49.1775650852668; 
 Wed, 08 Apr 2026 05:20:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c7:b0:82c:eafa:8863 with SMTP id
 d2e1a72fcca58-82d0dbbcc99mr21566054b3a.49.1775650852026; 
 Wed, 08 Apr 2026 05:20:52 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9a24039sm20512602b3a.0.2026.04.08.05.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:20:51 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, msp@baylibre.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, sajattack@postmarketos.org,
 peng.fan@nxp.com, quentin.schulz@cherry.de,
 jamie.gibbons@microchip.com, mateuslima.ti@gmail.com,
 justin@tidylabs.net, wens@kernel.org, n-francis@ti.com,
 ycliang@andestech.com, jerome.forissier@arm.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 4/7] dts: qcs615-ride-u-boot.dtsi: Add reboot-mode support
Date: Wed,  8 Apr 2026 17:48:38 +0530
Message-Id: <20260408121841.186410-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
References: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kRKj5O0pWNyzj34FCtYtyUuexZnSdc9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExMiBTYWx0ZWRfXzukG49Qa9N2v
 rg92K7XqFuxbMo12d7HePDybE/jNBenTSS+41gBH8tImn5CPSVDraO4C1k8ahincGbRKmqBkx63
 n/J3oqPKwmDD+41Q6TFVPzHV2YhmvzQN7tfF2o/Vuo3id0F52b33toofBMM9vJ3V2/3oLwlst0B
 t4C50RELrrJYYVtGMEk5IkvejLf/OJqKbZv633nAyjPMikxpSefN/MOtcGRyrDQF8/C1X/s/+JL
 OdWtOPHuD34ZFywx9aWyf78cJYErc8bc5yNGY0ej/nZfOWS+ZLNGGHoGyMtU1Dar2sMXuxPYCxh
 e6sbTklka40MSf7maDzrBBORhrn+b9tFphAtOAW6ey3B3jHU1PAmbSqPhsgBnQ/xI1JXfx+Tldd
 I8vYEnQ0vJ4Npzs9MNFd9bMydqYTJPreSCXLQpmsRBohbaG+aGepOVRhRk4PdPF3j67lK9DXriT
 n8fQRGY275v0bfDUWmw==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d64825 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=yUmxN5dSmvX78ioYZS4A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: kRKj5O0pWNyzj34FCtYtyUuexZnSdc9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080112
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

The PM8150 PMIC on this platform uses the older PON (Power On) register
architecture rather than dedicated SDAM regions found in newer PMIC
generations. To enable reboot-mode functionality with the unified
NVMEM-based approach, add a compatibility wrapper that exposes PON
registers through the SDAM NVMEM interface.

Add device tree configuration:
- NVMEM node with compatible "qcom,spmi-sdam" wrapping PON registers
- Uses 'ranges' property to map the PON register block at offset 0x800
- NVMEM cell at offset 0x8F (PON_SOFT_RB_SPARE register)
- 7-bit field (bits [7:1]) for reboot reason, preserving bit 0
- Mode mappings: bootloader=0x02, recovery=0x01

This wrapper allows the SDAM NVMEM driver to access PON registers
transparently, providing a unified interface for both PON-based (older)
and SDAM-based (newer) PMIC generations.

The PON_SOFT_RB_SPARE register persists across warm resets and is
automatically cleared on power cycle.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v4:
1. Changed bits property as 'bits = <1 7>'

Changes in v3:
1. No change in v3
---
 arch/arm/dts/qcs615-ride-u-boot.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
index 68fffc70fcb..687e9a67a9f 100644
--- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
+++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
@@ -11,4 +11,30 @@
 		      <0x0 0xc0000000 0x0 0xc0000000>,
 		      <0x1 0x80000000 0x1 0x00000000>;
 	};
+
+	reboot-mode {
+		compatible = "nvmem-reboot-mode";
+		nvmem-cells = <&reboot_reason>;
+		nvmem-cell-names = "reboot-mode";
+
+		mode-bootloader = <0x02>;
+		mode-recovery   = <0x01>;
+	};
+};
+
+&pm8150_0 {
+	/* Virtual NVMEM node for PON-based reboot reason storage */
+	nvram@800 {
+		compatible = "qcom,spmi-sdam";
+		reg = <0x800>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x800 0x100>;
+
+		/* Reboot reason cell at PON_SOFT_RB_SPARE (0x88F) */
+		reboot_reason: reboot-reason@8f {
+			reg = <0x8f 0x1>;
+			bits = <1 7>;
+		};
+	};
 };
-- 
2.34.1

