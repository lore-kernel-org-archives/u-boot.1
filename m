Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B817BD12694
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 11:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1085E83F8F;
	Wed,  3 Dec 2025 12:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7vp8SdY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKKbv0du";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C9A83F8E; Wed,  3 Dec 2025 12:08:21 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F364283F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 12:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3B3hdT1536308
 for <u-boot@lists.denx.de>; Wed, 3 Dec 2025 11:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4jcBiydUPDc
 SeXj3bz+MakIV8YELHh6JEZ516Zd0xJk=; b=C7vp8SdYUHbUT6swyyd9A5uY3qi
 A9/oYRfixrJyKOoTEes0DpFvXDsKbsaoSjPGBhmnDolwc3BAk/UhOlhc5jC1mBiH
 XAxDBdxRoNkKmzJo6HLZkWHfN4Ykty1NHksd3v5UrDyWkzYfMEa6phBbzanNiIft
 FSCOn7unbwZwmMbbDfZFqxh5xJ0Plxpyc3z2CtyAsr30iNMDv7zu6q8hdw4Nv6eU
 oRp95D4xyCBnb3P731TchSQAc177T6wuoqKzOUD4171Dqos4xzngHuLsSjCtJJOB
 +mA3fSbskBtwyHe1IexRZcouUcTgvy2fN7DwIwLBgsJmj3KGzM6Z+ywX42w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm0hr0ey-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:08:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-297ddb3c707so51612535ad.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764760096; x=1765364896; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4jcBiydUPDcSeXj3bz+MakIV8YELHh6JEZ516Zd0xJk=;
 b=MKKbv0dui6aeJWcW65SBP+JGE07rqRKAhzIY0KhyPcjotWQI63MyVy/5eddsFo/f+F
 ZqL/z3+9zfAIrewAQwHqe91Uf0JZyN8ZzFpKhX5JzRKRDvGX8TKrhsrjm+YP/RgFFwYq
 QNHS+pjbdWiKMq0l1oCEpVL3XhRJ3YA+NoEC5bk9sIhhcpsAef0gLVwa8GwgHqk2BuSI
 eGMfLvYZd8EDndVOxnAU5dthRk5UYd1uLM6zayy5sKuOCs0Rnlt47zSh68Yw/oSjem48
 drexPjStsrjwbi8sqTUrgCC03ASWGi6cfO9I4qOI2jUeyIY5Fx0kKqQVIYT3kLdpGe7G
 mh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764760096; x=1765364896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4jcBiydUPDcSeXj3bz+MakIV8YELHh6JEZ516Zd0xJk=;
 b=wmTki5qgualftXgMQnXo4kVXXrwyyViA9KpcZkQ0ZzD5I2pHElygc1u5xZFzY+7mWX
 9B2rzLEEj53+S7QqndloIZ0fSYV01h6jSk3KQRi46KkcbEJRHzJycoTNWSo/hk9eCg6N
 sld35fj7A35tWqdtHwbB3/VyYwJR/8+wz0XbUIV4W2z7rQIA5Chhn4QCHMeglrD/8EgD
 f4GV13MUQ7vFp6wRfB3DCzTwTrYSDOXAOJFoSeAIkms4K6Yl3PNYrdUNQnEJS4I7nV/G
 Qraxxie6s5Y/Kvbbnsz+BlgNYsXpzXj2YXElzlxBYS1UWvW/dDfqte0jPpso6uOIZyCO
 sd6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuRT6+wU/fuyDSqMy3sJv/vWQrJTTVJer0uiiPAWOUbArF4sPl/yADRuBdn5KQjyqCSWNLwLo=@lists.denx.de
X-Gm-Message-State: AOJu0YzVRaWMnONGfeTmIPx4bNELgx1I8teIaNMayJWI5zUrG1KA04D2
 HTDa6KDpEmexPKN7LJ+Y1uBY5OLgvoKmdF8RevtVr8026zL9IQiUDXAwXUuhiCfGX0Jaw9yZivZ
 pwwdqLvjowlYrRn1pS5m4bCB0QsfwD4VIRUUucYlVYMrq33wksNSkzbHX
X-Gm-Gg: ASbGncsXHZlx2tFvzq6KwcdZwOIwqzG7Xx7Y79n9Pbql+9kSOEz79QfMRQUev1ixj1P
 zcaq8cKVnKkqLK7PHf27hr9fUJ7mm+mWrOzisDuuK8hevL1mwpLIQsV/PdXeWO25dz22HBOKIAF
 zyD9WJJBjqAikcL7QT874T2dFb3SjlgCLqJu36aKJnV3sS6rvlw8urdEoJ+fFAm1xWl6KTuPkj8
 1gPX8NNVcUVsKyL2QjDgAejXMRNvvdyo0ojFQmcXDlSrO5kK1vO3LOyUWkRFQuofBFSq7cxRqGd
 4C5pfULHsvM74lFO4oWiZTA3N73279oNApof4wXnZnsmDlfKFQaIup70mNGz+wQxrNZLav3HVim
 /5u4b25H78ZCOwKe7bShmaEQUjvoou40qoHHwa6G4V6oyQD3zS5njL+OdLjIdVd6+4MoN56rO29
 DN3hWWgcJpZG3NYVcaLi0xG/ddTwYkiStCHIJMXA==
X-Received: by 2002:a17:902:e790:b0:295:3e80:9aa4 with SMTP id
 d9443c01a7336-29d68317c87mr22769115ad.22.1764760096330; 
 Wed, 03 Dec 2025 03:08:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVQPav2u5clfUIvGbqyYAKp04A1k/tAhAq+YfLydpNwSvF7+hymC21lEc2GmQ6O0svu/dNQA==
X-Received: by 2002:a17:902:e790:b0:295:3e80:9aa4 with SMTP id
 d9443c01a7336-29d68317c87mr22768665ad.22.1764760095848; 
 Wed, 03 Dec 2025 03:08:15 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29d7b6ba774sm10132925ad.83.2025.12.03.03.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 03:08:15 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 4/6] arch: arm: mach-snapdragon: Auto-detect USB SSPHY
 driver support
Date: Wed,  3 Dec 2025 16:37:33 +0530
Message-Id: <20251203110735.1959862-5-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: w7wRkmyspNGKnKZvv6siZM31mxPLPECT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA4NyBTYWx0ZWRfX8C3haW3Znk+u
 dK4mfdfqgE+LwpNrtZK6SnZfVXPvk0y8x2hN+5ja6OR45Ioau4WyPDzBYY6b9BlcUu1mf+o15Wd
 KPQBO0EcNM4fSUqhh5p6MMPvbNhBXhRT1o/cbuHkpAPYV/w0KdRmful60vE1xBwf7JuUE0Hng7a
 jCMJOxMNMlh40UH5Sd6yx1EVHxh9+9voX9bcGXwNSXJsgHcRbJmEca4xcTqc6ah6em14foISOfu
 TLoT6+zOCuGK6kfr/xkk9kpUUNWDwZ3aXDNsmeqo14SNT7AJSVXWrtLyw+xcAFxKzbd8QvHOEQ9
 Cu5h7i5WnDmlZGlnQU4tItZ9gPC20rKeEomjuYFXveaUchQbF60i5+tIs4oZ41KJMsXtaH5bqtY
 cf0gbVgAe98A/EBR9SgZ3Rc9rvm0Bg==
X-Proofpoint-GUID: w7wRkmyspNGKnKZvv6siZM31mxPLPECT
X-Authority-Analysis: v=2.4 cv=V5lwEOni c=1 sm=1 tr=0 ts=69301a21 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=nUkZtOdlekVutkRFgWsA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030087
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

Automatically detect super-speed USB PHY driver availability and
skip the USB speed fixup if driver is available, eliminating the need
for manual configuration.

Previously, U-Boot unconditionally limited USB to high-speed mode
on all Qualcomm platforms because most lacked super-speed PHY
drivers.

This change implements runtime detection that checks if a PHY
driver exists for the super-speed PHY node referenced by the DWC3
controller. The fixup is automatically skipped when a compatible
driver is found, allowing the hardware to operate at full
capability. Platforms without super-speed PHY drivers continue to
receive the fixup automatically.
---
v3:
- Removed support to manually disable the fixup via Kconfig.
- Instead added code to automatically detect if
  SSPHY driver is available.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/of_fixup.c | 130 ++++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index eec2c0c757e..85dc1c4573d 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -4,7 +4,7 @@
  *
  * This file implements runtime fixups for Qualcomm DT to improve
  * compatibility with U-Boot. This includes adjusting the USB nodes
- * to only use USB high-speed.
+ * to only use USB high-speed if SSPHY driver is not available.
  *
  * We use OF_LIVE for this rather than early FDT fixup for a couple
  * of reasons: it has a much nicer API, is most likely more efficient,
@@ -21,32 +21,108 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dm/of_access.h>
 #include <dm/of.h>
+#include <dm/device.h>
+#include <dm/lists.h>
 #include <event.h>
 #include <fdt_support.h>
 #include <linux/errno.h>
+#include <linker_lists.h>
 #include <stdlib.h>
 #include <time.h>
 
-/* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
- * USB controllers. Rather than requiring source level DT changes, we fix up
- * DT here. This improves compatibility with upstream DT and simplifies the
- * porting process for new devices.
+/**
+ * find_ssphy_node() - Find the super-speed PHY node referenced by DWC3
+ * @dwc3: DWC3 device node
+ *
+ * Returns: Pointer to SS-PHY node if found, NULL otherwise
+ */
+static struct device_node *find_ssphy_node(struct device_node *dwc3)
+{
+	const __be32 *phandles;
+	const char *phy_name;
+	int len, i, ret;
+
+	phandles = of_get_property(dwc3, "phys", &len);
+	if (!phandles)
+		return NULL;
+
+	len /= sizeof(*phandles);
+
+	/* Iterate through PHY phandles to find the SS-PHY */
+	for (i = 0; i < len; i++) {
+		ret = of_property_read_string_index(dwc3, "phy-names", i, &phy_name);
+		if (ret)
+			continue;
+
+		/* Check if this is the super-speed PHY */
+		if (!strncmp("usb3-phy", phy_name, strlen("usb3-phy")) ||
+		    !strncmp("usb3_phy", phy_name, strlen("usb3_phy"))) {
+			return of_find_node_by_phandle(NULL, be32_to_cpu(phandles[i]));
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * has_driver_for_node() - Check if any PHY driver can bind to this node
+ * @np: Device node to check
+ *
+ * Returns: true if a PHY driver with matching compatible string exists, false otherwise
  */
+static bool has_driver_for_node(struct device_node *np)
+{
+	struct driver *driver = ll_entry_start(struct driver, driver);
+	const int n_ents = ll_entry_count(struct driver, driver);
+	const char *compat_list, *compat;
+	int compat_length, i;
+	struct driver *entry;
+
+	if (!np)
+		return false;
+
+	/* Get compatible strings from the node */
+	compat_list = of_get_property(np, "compatible", &compat_length);
+	if (!compat_list)
+		return false;
+
+	/* Check each compatible string against PHY drivers only */
+	for (i = 0; i < compat_length; i += strlen(compat) + 1) {
+		compat = compat_list + i;
+
+		/* Iterate through all registered drivers */
+		for (entry = driver; entry != driver + n_ents; entry++) {
+			const struct udevice_id *of_match = entry->of_match;
+
+			/* Skip non-PHY drivers to improve performance */
+			if (entry->id != UCLASS_PHY)
+				continue;
+
+			if (!of_match)
+				continue;
+
+			while (of_match->compatible) {
+				if (!strcmp(of_match->compatible, compat)) {
+					debug("Found PHY driver '%s' for SS-PHY compatible '%s'\n",
+					      entry->name, compat);
+					return true;
+				}
+				of_match++;
+			}
+		}
+	}
+
+	return false;
+}
+
 static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np)
 {
-	struct device_node *dwc3;
+	struct device_node *dwc3, *ssphy_np;
 	int ret, len, hsphy_idx = 1;
 	const __be32 *phandles;
 	const char *second_phy_name;
 
-	debug("Fixing up %s\n", glue_np->name);
-
-	/* Tell the glue driver to configure the wrapper for high-speed only operation */
-	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
-	if (ret) {
-		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
-		return ret;
-	}
+	debug("Checking USB configuration for %s\n", glue_np->name);
 
 	/* Find the DWC3 node itself */
 	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
@@ -58,20 +134,38 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
 	phandles = of_get_property(dwc3, "phys", &len);
 	len /= sizeof(*phandles);
 	if (len == 1) {
-		log_debug("Only one phy, not a superspeed controller\n");
+		debug("Only one phy, not a superspeed controller\n");
 		return 0;
 	}
 
-	/* Figure out if the superspeed phy is present and if so then which phy is it? */
+	/* Figure out if the superspeed phy is present */
 	ret = of_property_read_string_index(dwc3, "phy-names", 1, &second_phy_name);
 	if (ret == -ENODATA) {
-		log_debug("Only one phy, not a super-speed controller\n");
+		debug("Only one phy, not a super-speed controller\n");
 		return 0;
 	} else if (ret) {
 		log_err("Failed to read second phy name: %d\n", ret);
 		return ret;
 	}
 
+	/* Find the super-speed PHY node and check if a driver is available */
+	ssphy_np = find_ssphy_node(dwc3);
+	if (ssphy_np && has_driver_for_node(ssphy_np)) {
+		debug("Skipping USB fixup for %s (SS-PHY driver available)\n",
+		      glue_np->name);
+		return 0;
+	}
+
+	/* No driver available - apply the fixup */
+	debug("Applying USB high-speed fixup to %s\n", glue_np->name);
+
+	/* Tell the glue driver to configure the wrapper for high-speed only operation */
+	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
+	if (ret) {
+		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
+		return ret;
+	}
+
 	/*
 	 * Determine which phy is the superspeed phy by checking the name of the second phy
 	 * since it is typically the superspeed one.
@@ -150,7 +244,7 @@ static void fixup_power_domains(struct device_node *root)
 	do { \
 		u64 start = timer_get_us(); \
 		func(__VA_ARGS__); \
-		debug(#func " took %lluus\n", timer_get_us() - start); \
+		printf(#func " took %lluus\n", timer_get_us() - start); \
 	} while (0)
 
 static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
-- 
2.34.1

