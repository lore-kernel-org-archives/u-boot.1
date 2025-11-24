Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E796CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD8383E7F;
	Mon, 24 Nov 2025 16:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g1xMTf6Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hpAdblLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68BC83E5D; Mon, 24 Nov 2025 16:55:46 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB0F83E76
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AOB2rR53884507
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o4PjT6TMBU4
 NgC8rqaAXil68QyQEASaI09nf4f7df18=; b=g1xMTf6YZhQgdj0p0GTnhW2fp4X
 oz8CxR5gkAs/sUvQRzb0EVaIzE2YYcFwdY5ZxYEf40nf8kcsZwM6Zot2g0M2umZ1
 qABQHKg9mugQWjUyFplNWvCibb4jmqH6LpQ7BV5dK7APWTDH+2+j2ronYnqdVRVp
 NLLxHb9KMdLDbdfb8F5W9Rl9QgS8Q76UlwhQCasl7lJHZR+AiLnF7lMPS1phWm9I
 J5ADXwuZdZqt+ScopWbE3+O8VWPgi1c7CpRhZwyWyKCuznlejFlTNimbfowyxCKZ
 ZV1oi1jkDPjl0OY8MDE9DFgoJtX41KAYZR5jIJTmLKrnfwqQGO6BJkksEEQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amp568skp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7b8ed43cd00so4521401b3a.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763999742; x=1764604542; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o4PjT6TMBU4NgC8rqaAXil68QyQEASaI09nf4f7df18=;
 b=hpAdblLQ1Asdhmb+Izq/sceoSViivGgjNp8591emg+fPPsjmM/w5UyR4aSPt0+o5U6
 ZBgYtMslzat+c9MDFqV9mI/Equb7V/iryrYtSDfLKyWu0NTOYQCi41Pp2lSgIiLuJ2Ny
 F4LhdyjEdKPfvEg4xOKS4EvHoieWcXx6LPYqjymonlk+aPpuZx9x2gyz/L71MIKYy23O
 rdBNOaZMuD5NtwDZjTDftSJCSGRqFm4WAy+hk4ZqT5hRLBXj5bq0N7QQC4sw+viwLrrj
 qoolZllGIcVYuy+tU0ziEFRFn5SZ5tonxxq8/pAYr7ixQ7cBOVkb+8ocp/SXQZfPxyLA
 7m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999742; x=1764604542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o4PjT6TMBU4NgC8rqaAXil68QyQEASaI09nf4f7df18=;
 b=TVrnf+6d6Dbwj/iyK8l7fj8FuuG7qq/2mdBhp+sgoknhd055g478Vz6qBCmpo4J01L
 hl90BfF8c/R0BmD8Pe5GVmQ5fvLqCaI27+Y6eFjRLOly7N879ntXd7AXkQFgq+8SkSHq
 ciOjo9QRYzDUgVXT+UO9aKGQuF62TzCxW20K+zhEPo1ovy9lwu7tXbw3mqCwfSYqw+s8
 hBDtsO1a/MoYfPhzROH+CwjquCV926lPMbexdr9mNC3ljiIwkQKIRz6sdCi3BS9f/hys
 LQ2ffVaauo3AWD680tVO0d51ZedLsjL1EtvhrkfVgoOQ2KGDv4mVPqQi4HZ6FgCnOSOL
 QwPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa/aiDVWnuERU9bCxFTcS499J1RPS8uELezesxcknasziBJ5jNGh1JzJm/4fCE7cO7c8uAYSQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxocVxeJ4YYMauRQcz5UaMFpQcuEIERoohZ3s426YpIL9hE2EHX
 k7gde3Iz39wEtKp8mbrO4FOa28TGQ4jFieBZyfSIC1Rc/4IiYLni/C/otKQB7d88V9zkcaA4IqX
 iHakktIJmC2MnTvtVxQPbNEZ7f4ezl5TivCiiOWoSKP4Rc4VLq1p6afqj
X-Gm-Gg: ASbGncuTDtS3KNeuDdirwcdWPy0nr4PxFOt7oFSgPKeYrU7z/buYcPviXYPH8gz+S1q
 a1GPhzaJQaF185w663wpMD/09effABGJ1vWBRbFVqbddl3/4+nV7iitexTIoz7yz1yFRaFgzxfI
 4pZmq+327klf2ezcbllc/ScWmhTjTcUJfKLdMwWeqbQZTaunxuyR/0up5B7sJY2w6nqEY+VYoEz
 lfq5shcvafwu3tXHPbXJGF5KH3PiOCYXlLKSt7Myo6xuCxoQjLtxquQ/Ydm/IQ85SrwMZ+jVtKd
 s1hf6EnKmSU2pfa8ZCqPP+NGB9RuGMAAMf1tUaxUVLni/lEZhrxMn/a0huIKn8MffIrzw2kBXdj
 Ea1Tf4WF0f47ewp2U1Uj3P3iJiOqsSZmQk24UzVd6TBgu2A+jrhjJCgluOCgSS7nZ2DnwWdSoce
 uyl/PX9d5COpCfUpSn5vWsgEkwWOgg0GKa5lVAxQ==
X-Received: by 2002:a05:6a20:4325:b0:35d:dd84:148c with SMTP id
 adf61e73a8af0-36150ef91cfmr13919526637.28.1763999741948; 
 Mon, 24 Nov 2025 07:55:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBimzIJKECQETmoiFSX8Hds/xtSvW7hRmZN88aM4hBg2TrKSEGvKp6/vgYTNJ1kybGOXiuIA==
X-Received: by 2002:a05:6a20:4325:b0:35d:dd84:148c with SMTP id
 adf61e73a8af0-36150ef91cfmr13919474637.28.1763999741396; 
 Mon, 24 Nov 2025 07:55:41 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023fd82sm15254884b3a.42.2025.11.24.07.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:55:41 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 4/7] arch: arm: mach-snapdragon: Make USB speed fixup
 configurable
Date: Mon, 24 Nov 2025 21:25:00 +0530
Message-Id: <20251124155503.2839766-5-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uIndJ_IBQ8q8IPIPtqZqrYcb7ogw6aYF
X-Proofpoint-ORIG-GUID: uIndJ_IBQ8q8IPIPtqZqrYcb7ogw6aYF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzOSBTYWx0ZWRfX9RP/cuzMNIuo
 a69kmPcAUhdrBSZqaKC7CWkROD9JaFSHdYJthX1W0xH7U4OPG2grjF8ri8UHt/7CFARNXM1t8op
 oFDWmuGA8qvSNc3s8iMHyT5RndGkBDEccDeD5bLRUpxspZTg609flZXqqJi1HiASZtkqL2KbaUY
 Y4thNYK+ajCVnyNzmq9qsqQbNu+wR1JFYCusUcv6+DB6WTMN5g+LuMs9WlocWsihyuR00l/v84B
 Zrj/+2ZeoTCpqDF0Q1B91AyRxaxFHnnUUshd2KKdP/ncyqAQb3BRpLJd2g3LTywEcuZ91UMnvCZ
 IE+E8RoDOIdeWvC6woT7eXTjOPpRgG/w64bhIK6bZwO39zSzVsJ5XR2UgPduopC6jmgjazS9zSV
 j35fAeL0l078TjKUfwa2+xCsRLJe3g==
X-Authority-Analysis: v=2.4 cv=dPWrWeZb c=1 sm=1 tr=0 ts=69247ffe cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AhJC8zaAl2eY2UkKhXUA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240139
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

Add CONFIG_QCOM_USB_FIXUP option to allow platforms to disable
the USB speed limitation fixup when they have proper super-speed
USB support in U-Boot.

Currently, U-Boot limits USB to high-speed mode on all Qualcomm
platforms by fixing up the device tree at runtime. This was
necessary because most platforms lacked super-speed PHY drivers.

However, newer platforms now have proper QMP PHY drivers that support
super-speed USB. For these platforms, the fixup is counterproductive
as it prevents the hardware from operating at its full capability.

This change:
- Adds CONFIG_QCOM_USB_FIXUP (default y) to maintain backward
  compatibility with existing platforms
- Wraps the fixup code with #ifdef to allow selective disabling
- Allows platforms with super-speed support to disable the fixup
  via their defconfig

Platforms without super-speed PHY drivers will continue to work
as before with the fixup enabled by default.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig    | 10 ++++++++++
 arch/arm/mach-snapdragon/of_fixup.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fce..6c53aeef597 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -29,6 +29,16 @@ config SYS_MALLOC_LEN
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
 
+config QCOM_USB_FIXUP
+	bool "Enable USB speed fixup for Qualcomm platforms"
+	default y
+	help
+	  Enable runtime fixup of USB device tree nodes to limit USB to
+	  high-speed mode. This is needed on some Qualcomm platforms where
+	  U-Boot doesn't support super-speed USB.
+	  Disable this for platforms that have proper super-speed USB support
+	  in U-Boot.
+
 config SYS_BOARD
 	string "Snapdragon SoCs based board"
 	help
diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index eec2c0c757e..6a64168f67e 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -27,6 +27,7 @@
 #include <stdlib.h>
 #include <time.h>
 
+#ifdef CONFIG_QCOM_USB_FIXUP
 /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
  * USB controllers. Rather than requiring source level DT changes, we fix up
  * DT here. This improves compatibility with upstream DT and simplifies the
@@ -115,6 +116,7 @@ static void fixup_usb_nodes(struct device_node *root)
 			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
 	}
 }
+#endif
 
 /* Remove all references to the rpmhpd device */
 static void fixup_power_domains(struct device_node *root)
@@ -157,7 +159,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 {
 	struct device_node *root = event->data.of_live_built.root;
 
+#ifdef CONFIG_QCOM_USB_FIXUP
 	time_call(fixup_usb_nodes, root);
+#endif
 	time_call(fixup_power_domains, root);
 
 	return 0;
-- 
2.34.1

