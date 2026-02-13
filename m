Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB00EDF152
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DAC83CEE;
	Fri, 13 Feb 2026 12:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mc5svzGf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N1RfXbRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B6780B98; Fri, 13 Feb 2026 12:11:00 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8919383CBD
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DACE9U3259044
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OjD/Fe/2CVq
 eA8Oapu8CeKA0Nqj+u+xEL+FYtEClBks=; b=Mc5svzGftHk/Vkn8CXa2Zzg8Vqh
 1Qn+SPgAmhH/yYU7d9rQyGqh09bu3Fa4lhvx0IwMO/DyHxS5RNvVLAVHADwDDLaF
 pWDmVikgUY2irDZA0g0w64TmZGY37GiEcAu88Gq0CaAX+gsFe4uoZOtI8e6gbAAL
 0QMba54ZRdOlrxX4a6WqKJytwCLkWGrywbWt3UY6glfo3ZxC/Qg+nsbv3YaZad+t
 2axyMbFLi3mIhEnjE9PbbTPMXS/vOjunUabIoG2pLYYTAjmMXbhKq7+OTQecf5La
 T2mgeS+X7DaOZ0+ZM3Qfe9ZSbuLOy01BKfIqJxv5TbMLo0Zc8n1bU4Pkt6Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ptv2hhs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:10:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34e5a9f0d6aso1010194a91.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770981055; x=1771585855; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjD/Fe/2CVqeA8Oapu8CeKA0Nqj+u+xEL+FYtEClBks=;
 b=N1RfXbREmxXZ58cfRunGuA/acGoqt3gA3lna1Aj08sW2LWaazP2wELVhDYOidLVqCs
 3xng/VARNKY2WhEwaLeELywPJG9hPBG/uwFEbNeCbUqfXECXHocn0thiGR4lgzj3kUkM
 74djxacgwfip9Ri/BcwsDuoW23wI8Z/EXElrovlT+HnFko46IQ7il2p0QRdojMiOOC41
 TvjJ/9phvDc+cggUTCzExPEa7x/Zz3pQ+vJ9uMh07Ii6DYwBW87SN6lPA39kgtSC9Xmp
 b5ab9zjAYz97czF3uhOqZrm8SfC8R7VdSMXhGpkJNuwEKkHkWeogZP7z4mqnaG8QEfs9
 VXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770981055; x=1771585855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OjD/Fe/2CVqeA8Oapu8CeKA0Nqj+u+xEL+FYtEClBks=;
 b=hbG4rWFTaFTbxIGJwZWMKaAb+VbuSP35wJUfF9GuLfftiyanXvjPuwKbvSmrjospNc
 EoymdS5f4/MyWYKIf1cFVGKF6POZ0r3O3sDhMEeEtQjDGWvEp2O9Y6aoWSI23ghxavAI
 2g5LNFNosmDvkVexPEeWWgv2tcFfd86EfJHQHADz+LIJAKUerE0AzgcrC68Yk2fvfIv7
 6k7tiV/Z+m0e64zCieEdq2+zdS++zt2g7P9ioLIME08uZAlOE+D3qQNDFk0QbrlasWbO
 1/wECGoI2VGUYALwgVuqC1Wcu4d9aSlaHPoEXgPksBrpSdrsoyHcLe3kt02wK6Uibby3
 AVBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3H1xSSxRpXUj/SOTca6cK9wQES2/S3ScgSr32/YKOgWTx/qZRO9h40vzWMxfKTOTdCBF5K/s=@lists.denx.de
X-Gm-Message-State: AOJu0YwIHGPMujq+JdDpw2tnbfg94F9d9cCMcZxQHaECTBuWAw3Dqz16
 OXAYzFtDRmyQXMnxBDoNovR15vMTXPwOCb/7pf68CigV4XW5/ew/e6M/ipYx7ZDhr4dMzORdfyE
 ja6FXTfsxhlDZlY1M5SJfFBFDT7NNvcs3XRevYVIA+PMpLs9fDjq0wfLV
X-Gm-Gg: AZuq6aIeB9BHUilmdxRMXwM22ARAs79yXKDVI2lo1K+C1uyWS8dvzz+zexkZztObPmh
 qzQiWygZ58mm/2PgEfoobU6IayKmobbh0OwRCvrjqVTCKwn6/1aGmWLzqgmkHDuD8tTSVpovTHN
 j10bWurbj8bCA7pvmYSgG6c04uE5luzsZYygF2e2zenorKruKP9yFZ67JH6JI203bF6BjNcZEJs
 u/CxdOk3G4l/zV5yXopdVCgo43+6JkhJaSVJ49LU9r841Tkeyjm54cTS0iBvn3MO3Od6WRXbxPM
 JWAVo07twLW7KI24L+clwU4jWKxSAdKgxdCCz8Q6bjSravuG0c2OZt8qyaww2uBlZb5ob8UvVqr
 Rv6sqhgIq6QZFK6Gl0ka9gdkJtIYU38vp0Rue6XVfpVoHoz+KOSWjdspOViU4ZAHDyvIWdJ1KJ2
 IxpPXih0+tnPl0/5B8sS7P/fNWtyKz9SrOnBKhYPhG
X-Received: by 2002:a17:90b:54c6:b0:340:29a3:800f with SMTP id
 98e67ed59e1d1-356ab18a7dcmr1208554a91.15.1770981054593; 
 Fri, 13 Feb 2026 03:10:54 -0800 (PST)
X-Received: by 2002:a17:90b:54c6:b0:340:29a3:800f with SMTP id
 98e67ed59e1d1-356ab18a7dcmr1208529a91.15.1770981054039; 
 Fri, 13 Feb 2026 03:10:54 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35662f8cc57sm12364399a91.13.2026.02.13.03.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:10:53 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: trini@konsulko.com, sumit.garg@kernel.org, jh80.chung@samsung.com,
 peng.fan@nxp.com, neil.armstrong@linaro.org, tien.fong.chee@altera.com,
 miquel.raynal@bootlin.com, msp@baylibre.com,
 alif.zakuan.yuslaimi@altera.com, balaji.selvanathan@oss.qualcomm.com,
 w.egorov@phytec.de, varadarajan.narayanan@oss.qualcomm.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org, me@samcday.com,
 marek.vasut+renesas@mailbox.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v8 1/4] power-domain: Add QCOM RPMH Power Domain Driver Support
Date: Fri, 13 Feb 2026 16:40:06 +0530
Message-Id: <20260213111009.1254360-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
References: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ASqM9lUBTn-qLkvCVCYtpN4F-En-ap9x
X-Authority-Analysis: v=2.4 cv=eaowvrEH c=1 sm=1 tr=0 ts=698f06bf cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=mxzJDyrKheeO0MTuWfoA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NiBTYWx0ZWRfX6o2jtV4gVUM/
 jj09dT1T9wybUGjXdqAnMKldbWNFJlSr9iCnRv/FWrNPZavuaeC+cDlyMIABptmUJSfg5+qg4/T
 +cNcNKGE9zwYp2pcL6NOVM64zUw6CFTQEFqKT0fc/vDS2+SBxXk88buRnasEL15NgwV3cGaWp4k
 uckC1Sy/x4uO2IcUHquGjbO2B7Zc7m4jcAigvXS538NekTiXSsxLqAQxeSTx6esn5qnlfWQugWK
 FQg9kI9e/DcXBVAdUJ7fGeJQdZtZyVOx5KzVNUSge16tl1INPms0r47PpCUDf9Ad+wFJUeqrHNF
 ukn0t2Ha/cMMwNwO4iV3NWgb/lTAJqMcMsegTbzNevYtZ7iDhl/MoUblJkQ3xj4gxdMDERQNp+/
 yn2Hp4sOzZlJAnNfEo6YuQHlOmNMfnGZHwYKpYx6reaGvaJxL0w8AMwN1nHUK614D9a8zSaPrMn
 7jkwZpCcCWqP2v45uPw==
X-Proofpoint-ORIG-GUID: ASqM9lUBTn-qLkvCVCYtpN4F-En-ap9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130086
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

From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Added support for Qualcomm RPMH power domain driver, responsible
for managing power domains on Qualcomm SoCs. This is a port of
the Linux RPMHPD driver [1] and sa8775p related changes. The
power domain driver currently has support to power on and off
MMCX power domain of sa8775p; support for other soc entries power
domains are stubbed, in future, the required soc support can be
added.

[1]:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v8:
- Renamed Kconfig option from QCOM_POWER_DOMAIN to QCOM_RPMH_POWER_DOMAIN
  for better specificity as requested in review feedback

v7:
- No changes to this patch in v7

v6:
- Initialized ret with 0 in rpmhpd_probe()

v5:
- Changed the first argument passed to rpmh_write as pd->dev
- Added (ulong) casting in rpmhpd_match_table to address the warning.

v4:
- Added all SoC entries from the Linux driver and stubbed it
- Removed "qcom_rpmhpd" driver
- Removed unused members in struct rpmhpd

v3:
- No changes to this patch in v3

v2:
- Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN Kconfig
- In qcom-rpmhpd driver, the un-supported power domains are handled with warning
  in rpmhpd_power_on() & rpmhpd_power_off()
---
 drivers/power/domain/Kconfig       |   8 +
 drivers/power/domain/Makefile      |   1 +
 drivers/power/domain/qcom-rpmhpd.c | 278 +++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 935f282d6c5..9fc2f5f020d 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -90,6 +90,14 @@ config MESON_SECURE_POWER_DOMAIN
 	  Enable support for manipulating Amlogic Meson Secure power domains.
 	  Support for Amlogic A1 series.
 
+config QCOM_RPMH_POWER_DOMAIN
+	bool "Enable the QCOM RPMH Power domain driver"
+	depends on POWER_DOMAIN && ARCH_SNAPDRAGON
+	help
+	  Generic RPMH power domain implementation for QCOM devices.
+	  The RPMH power domain driver is responsible for managing power
+	  domains on Qualcomm SoCs.
+
 config SANDBOX_POWER_DOMAIN
 	bool "Enable the sandbox power domain test driver"
 	depends on POWER_DOMAIN && SANDBOX
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index b2c0bd8a61a..f373fc01395 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
 obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
 obj-$(CONFIG_TI_OMAP_PRM_POWER_DOMAIN) += ti-omap-prm.o
 obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
+obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qcom-rpmhpd.c
new file mode 100644
index 00000000000..f51bc9a4bbb
--- /dev/null
+++ b/drivers/power/domain/qcom-rpmhpd.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+// Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+
+#include <dm.h>
+#include <dm/lists.h>
+#include <power-domain.h>
+#include <asm/io.h>
+#include <linux/errno.h>
+
+#include <power-domain-uclass.h>
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/rpmh.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dm/device_compat.h>
+
+#define RPMH_ARC_MAX_LEVELS	16
+
+/**
+ * struct rpmhpd - top level RPMh power domain resource data structure
+ * @dev:                rpmh power domain controller device
+ * @pd:                 generic_pm_domain corresponding to the power domain
+ * @parent:             generic_pm_domain corresponding to the parent's power domain
+ * @enable_corner:      lowest non-zero corner
+ * @level:              An array of level (vlvl) to corner (hlvl) mappings
+ *                      derived from cmd-db
+ * @level_count:        Number of levels supported by the power domain. max
+ *                      being 16 (0 - 15)
+ * @enabled:            true if the power domain is enabled
+ * @res_name:           Resource name used for cmd-db lookup
+ * @addr:               Resource address as looped up using resource name from
+ * @skip_retention_level: Indicate that retention level should not be used for the power domain
+ */
+struct rpmhpd {
+	struct udevice	*dev;
+	struct power_domain pd;
+	struct power_domain *parent;
+	unsigned int	enable_corner;
+	u32		level[RPMH_ARC_MAX_LEVELS];
+	size_t		level_count;
+	bool		enabled;
+	const char	*res_name;
+	u32		addr;
+	bool		skip_retention_level;
+};
+
+struct rpmhpd_desc {
+	struct rpmhpd **rpmhpds;
+	size_t num_pds;
+};
+
+/* RPMH powerdomains */
+static struct rpmhpd mmcx_ao;
+static struct rpmhpd mmcx = {
+	.res_name = "mmcx.lvl",
+};
+
+static struct rpmhpd mmcx_ao = {
+	.res_name = "mmcx.lvl",
+};
+
+/* SA8775P RPMH power domains */
+static struct rpmhpd *sa8775p_rpmhpds[] = {
+	[SA8775P_MMCX] = &mmcx,
+	[SA8775P_MMCX_AO] = &mmcx_ao,
+};
+
+static const struct rpmhpd_desc sa8775p_desc = {
+	.rpmhpds = sa8775p_rpmhpds,
+	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
+};
+
+/* stub RPMH power domains mapped for unsupported platforms */
+static struct rpmhpd *stub_rpmhpds[] = {};
+
+static const struct rpmhpd_desc stub_desc = {
+	.rpmhpds = stub_rpmhpds,
+	.num_pds = ARRAY_SIZE(stub_rpmhpds),
+};
+
+static const struct udevice_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,sa8775p-rpmhpd", .data = (ulong)&sa8775p_desc },
+	{ .compatible = "qcom,qcs615-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,qcs8300-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,qdu1000-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sa8155p-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sa8540p-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sar2130p-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sc7180-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sc7280-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sc8180x-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sdm670-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sdm845-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sdx55-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sdx65-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sdx75-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sm4450-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sm6350-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm7150-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8150-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8250-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8350-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8450-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8550-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8650-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8750-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,x1e80100-rpmhpd", .data = (ulong)&stub_desc },
+	{ }
+};
+
+static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
+			      unsigned int corner, bool sync)
+{
+	struct tcs_cmd cmd = {
+		.addr = pd->addr,
+		.data = corner,
+	};
+
+	return rpmh_write(pd->dev, state, &cmd, 1);
+}
+
+static int rpmhpd_power_on(struct power_domain *pd)
+{
+	int ret;
+	unsigned int corner;
+	struct rpmhpd **rpmhpds;
+	const struct rpmhpd_desc *desc;
+	struct rpmhpd *curr_rpmhpd;
+
+	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmhpds = desc->rpmhpds;
+	curr_rpmhpd = rpmhpds[pd->id];
+
+	/* Do nothing for undefined power domains */
+	if (!curr_rpmhpd) {
+		log_warning("Power domain id (%ld) not supported\n",
+			    pd->id);
+		return 0;
+	}
+
+	corner = curr_rpmhpd->enable_corner;
+
+	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
+				 false);
+	if (!ret)
+		curr_rpmhpd->enabled = true;
+
+	return ret;
+}
+
+static int rpmhpd_power_off(struct power_domain *pd)
+{
+	int ret;
+	unsigned int corner;
+	struct rpmhpd **rpmhpds;
+	const struct rpmhpd_desc *desc;
+	struct rpmhpd *curr_rpmhpd;
+
+	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmhpds = desc->rpmhpds;
+	curr_rpmhpd = rpmhpds[pd->id];
+
+	/* Do nothing for undefined power domains */
+	if (!curr_rpmhpd) {
+		log_warning("Power domain id (%ld) not supported\n",
+			    pd->id);
+		return 0;
+	}
+
+	corner = 0;
+
+	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
+				 false);
+	if (!ret)
+		curr_rpmhpd->enabled = false;
+
+	return ret;
+}
+
+static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
+{
+	int i;
+	const u16 *buf;
+
+	buf = cmd_db_read_aux_data(rpmhpd->res_name, &rpmhpd->level_count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	/* 2 bytes used for each command DB aux data entry */
+	rpmhpd->level_count >>= 1;
+
+	if (rpmhpd->level_count > RPMH_ARC_MAX_LEVELS)
+		return -EINVAL;
+
+	for (i = 0; i < rpmhpd->level_count; i++) {
+		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
+			continue;
+
+		rpmhpd->level[i] = buf[i];
+
+		/* Remember the first corner with non-zero level */
+		if (!rpmhpd->level[rpmhpd->enable_corner] && rpmhpd->level[i])
+			rpmhpd->enable_corner = i;
+
+		/*
+		 * The AUX data may be zero padded. These 0 valued entries at
+		 * the end of the map must be ignored.
+		 */
+		if (i > 0 && rpmhpd->level[i] == 0) {
+			rpmhpd->level_count = i;
+			break;
+		}
+		debug("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
+		      rpmhpd->level[i]);
+	}
+
+	return 0;
+}
+
+static int rpmhpd_probe(struct udevice *dev)
+{
+	int i, ret = 0;
+	struct rpmhpd **rpmhpds;
+	struct rpmhpd *priv;
+	const struct rpmhpd_desc *desc;
+
+	desc = (const struct rpmhpd_desc *)dev_get_driver_data(dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmhpds = desc->rpmhpds;
+
+	for (i = 0; i < desc->num_pds; i++) {
+		if (!rpmhpds[i])
+			continue;
+
+		priv = rpmhpds[i];
+		priv->dev = dev;
+		priv->addr = cmd_db_read_addr(priv->res_name);
+		if (!priv->addr) {
+			dev_err(dev, "Could not find RPMh address for resource %s\n",
+				priv->res_name);
+			return -ENODEV;
+		}
+
+		ret = cmd_db_read_slave_id(priv->res_name);
+		if (ret != CMD_DB_HW_ARC) {
+			dev_err(dev, "RPMh slave ID mismatch\n");
+			return -EINVAL;
+		}
+
+		ret = rpmhpd_update_level_mapping(priv);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static const struct power_domain_ops qcom_rpmhpd_power_ops = {
+	.on = rpmhpd_power_on,
+	.off = rpmhpd_power_off,
+};
+
+U_BOOT_DRIVER(qcom_rpmhpd_drv) = {
+	.name = "qcom_rpmhpd_drv",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = rpmhpd_match_table,
+	.probe = rpmhpd_probe,
+	.ops = &qcom_rpmhpd_power_ops,
+};
-- 
2.34.1

