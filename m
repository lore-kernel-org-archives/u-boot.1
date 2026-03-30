Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A91B1061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E137D84011;
	Mon, 30 Mar 2026 19:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qq9Uj/ut";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XV/aaISN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB1FF83E7A; Mon, 30 Mar 2026 19:15:17 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F27C84011
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UH2OZO4013626
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pbBu7bw1B84
 jNKy/jnQuW2CKf2iRazPLn5S4sYEmd/Y=; b=Qq9Uj/utqYxVjObhR1VbiX9MDO0
 ZlcD1uDyx91O43uCea2GBooksJMEnjWsdWw3x9TXKMUgAOsDQtGE/Bx7cpct6ljj
 baO7kZfxoVqg/oAu/W9VTLwAJSKHc+E/O4LF4MHlWJWTZ0PpSlPUtdA6Gdgw8Ubj
 j9dI9zFwOB+qViCrFcbeBs3/ci/5mvIC0p/Q23Eo3eBX/MhIKE6w7I9lIjN3O6KY
 cxHwkp2NRGiEg7l8kCKXBZqobwg0LfgvZQkSHuMG1fmqJTWtHoB+REha6zasDIH+
 +mdiiI+wAw2HdZvhKqtf7SZeHuNUKxzEq7XzCm60N9jatPbqVf8uDVumilQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7regsd9q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c4664f75fso3906238b3a.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774890913; x=1775495713; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pbBu7bw1B84jNKy/jnQuW2CKf2iRazPLn5S4sYEmd/Y=;
 b=XV/aaISN/LOgyuVizq8YOwTvBmns8EQa1SofD6wJ6qhh5/Qdo68ij/Rsf00XvY82Bw
 5ux9t+MMHrOqpt2xGZMRKWzXNLT3T6cq9fyZySGY1lV03FRvT32cqA1R9kioUTbX9I79
 wMj0Bu1VD2B70DUZpAtYGul2uEKwghvuwGiDx1vf3EGQVuGpRA6tylhPIwMbCdwrnvqK
 9XhDrjYE/cwzh9KE2gKrUueaF46s/va02jb+f11MEfYba5DrzlRxKbSMJFp214SV5Gs7
 p9QGACZgvKWdAzHKlo/aEXP8sNNmNbuc8i5xD5X3o6wRm1CJ2U+uQfpZrfrTZ36k9Rm1
 uxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890913; x=1775495713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pbBu7bw1B84jNKy/jnQuW2CKf2iRazPLn5S4sYEmd/Y=;
 b=PQDGLtJNV8FysCFq/9eWy/kBEoMAv5HnIuo26nxYlreAFV6sUklu+SkxGUf/8ogGx2
 w5SSTG7MDA0dmLuiMOrVCE6j0IecQUe2Z9J82DXH50320TfoO9O/gUPQb7tsd3ZH2WqC
 vG0AH6c8Ej8i+sggD6GoE7pg152dIrsW50+wMPdTpYvWVnsPLCfr8IpgNqs5gGGFGS8P
 rquC1RCpJPB3Q9R8N/PlvHW70I65yy/fPs5H2/U+S3Z/qoxNyBqo3MRx/lvqdy2ZLnIN
 7QR+7LMSziyxs/z5D6lYpxgfNbeygnpVjBpI0rjspT5Xx5YTlJe/QhSL5hN6VjXS2004
 d/xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHlXCWMArFEZZTiaMXQ8C790MsPTkuxUCcXFYtfBjBoyua0vi/DnOEoV6/VZUezcAVw3BhzvA=@lists.denx.de
X-Gm-Message-State: AOJu0YzmmgO/EJ91+LHSQo3YLMPNSiyB5bwJsCZ4TPfn9F+ZRJNFpf1P
 ri2sZygEtm2KEEoIWBMjW3zZrR6nQvBVsWxlzfiI72nJto2ZFlzBCvtymLKKzi6xrtoHi/8GqEf
 6wt5Rz/vpLVEnlfC7iEDAtDow2g8fc9kEt0LaO9WI8/6Vag7SPzS/oEza
X-Gm-Gg: ATEYQzyFYumJ5M7/VopU/fAt+WH7z0D6uEX4XFN7GMR8eP5fJr1beU4dJzqkfMFCcSF
 CA+mNvnIeoMxyvGimXwX5xrWqL918/7NX2cChSuNNtfIL0cmscsGZhocSlgpLJ0GaH899rmVCZr
 lM7ya5VVLH+GUjASs2Zn2WPSKe1lnnZCTXDRSTJZ9mVvtgosIC2lJocQmzwXG/wmVyMd8Sixqs/
 cJXohUWeQfqkEFpGQViJQMKJ8r4aqFbpj9/CFUkmcLO/X60ay7oac8YLF87HflhoHVLAQ9RqIxe
 +BDIUria2jmPaehfvzSaSQBohZRB88a+dwpFq+VpPZfDmQAvP/EFF46EO9RQsB8MIe1XAu3yTlj
 C6j/eo7XdsLN9wThmbYrGXvS+SnEXtZIqWXcLn58brjy4Lp40OIg+YHvJ01LWTVPTUaN1ETT21m
 EEaBSKcpn7jaqeP0LqpOQWoZaD8UBvyV0LP+4QDXVZ
X-Received: by 2002:a05:6a00:338c:b0:827:489d:76d0 with SMTP id
 d2e1a72fcca58-82c95e6ee8dmr12012298b3a.14.1774890912753; 
 Mon, 30 Mar 2026 10:15:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:338c:b0:827:489d:76d0 with SMTP id
 d2e1a72fcca58-82c95e6ee8dmr12012252b3a.14.1774890912194; 
 Mon, 30 Mar 2026 10:15:12 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8626518sm7349777b3a.52.2026.03.30.10.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:15:11 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mkorpershoek@kernel.org, hs@nabladev.com,
 marek.vasut+renesas@mailbox.org, msp@baylibre.com,
 dinesh.maniyam@altera.com, peng.fan@nxp.com, quentin.schulz@cherry.de,
 kever.yang@rock-chips.com, jamie.gibbons@microchip.com,
 justin@tidylabs.net, xypron.glpk@gmx.de, n-francis@ti.com, h-vm@ti.com,
 ycliang@andestech.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 4/7] dts: qcs615-ride-u-boot.dtsi: Add reboot-mode support
Date: Mon, 30 Mar 2026 22:44:16 +0530
Message-Id: <20260330171419.1117817-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G6wR0tk5 c=1 sm=1 tr=0 ts=69caafa1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=yUmxN5dSmvX78ioYZS4A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX5V7DsJKSFoai
 2PO8X5to8P8N7SLZfXUxHwozYrlAN4GPIC4OGXqY6Qvz2nSU34wq1s7oL2k+y7GeYsgiv+cySdZ
 hcf8kicdLsgkunnSILqUymtcvgBU+ol3CCq/ohHCSaU7G7reClMd1ehKv3rSpCsPzG29hFGAYR+
 0aZUD+fmKdTyrNIogCZRiungxjkTuA1Ibi6W0VRqZPz7e/Z9aEwzCBiVrQh115qyJryvpGgalK3
 tyK7DYaB/qRqGXdE1u8V+rz+FUnuNWzBfhCl/er9hBQ6vkq8Ruu0w6EzGDJjKkj8MH5zogAZAn/
 ZjgR7lXzVp2MdiHO+5tJ3oyr8VMMoaw3hNpTCzxlhmm/rfuhGtQ5nhV0MNNJlnEvtRNAoebMCeR
 YhdnP/mIplEmTals8DTwRBayAHGtdrEVD2NhoC25v5WVzyC1aCegFrUqBvl18EbZl8EcPSy5qAF
 YLPUszrwAjbjcSPCNFw==
X-Proofpoint-ORIG-GUID: ECj_GV6R7RXm2fVgoELtnAzKgHuGt-Bj
X-Proofpoint-GUID: ECj_GV6R7RXm2fVgoELtnAzKgHuGt-Bj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300141
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
Changes in v3:
1. No change in v3
---
 arch/arm/dts/qcs615-ride-u-boot.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
index 68fffc70fcb..50784807cf4 100644
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
+			bits = <0x01 0x07>;
+		};
+	};
 };
-- 
2.34.1

