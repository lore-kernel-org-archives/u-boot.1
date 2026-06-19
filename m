Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31898CD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 185C7849BF;
	Fri, 19 Jun 2026 13:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i/JAasbh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ebFkXIJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D2F849C5; Fri, 19 Jun 2026 13:10:49 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B2D847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7Po4b006966
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HvMaNaqcwIttNkU3aDc1WXF1Qz5hxdsi2aImlgX12OE=; b=i/JAasbhKgms9kj9
 7/LzqhoJDCmzweRO48pP6Kgr6UNNr9mx97bXaI0r9H4FdvioXG8GRRdPoLG3WZkS
 rA+7n9Qvwae9n0fAHi1TZptMaqdUurcFMZxlJz+7v2+WseTbQpbYHGrv8SyLcj/V
 6Gr1uBGI6bsLRmc85WnC/OEYQTVzTc48mZsYZ4AcmxDDwNidsH7vt3pHDqLKlIJW
 7faV3uX7ofDwTJ44PTYPOOCeovLATcSHh9o7SU98WS7LvOm4WBlwWdS8w798AI9Y
 L7Ri9VjZgPjcoxRoUNq/d37jAYCJ2LSK7jA0ZkxoplaQlCLHzRlKTbxrHgOrt8gm
 GCzTFg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm20kpcn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:10:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c6a20348ceso25215555ad.1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867445; x=1782472245; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HvMaNaqcwIttNkU3aDc1WXF1Qz5hxdsi2aImlgX12OE=;
 b=ebFkXIJbiKIlP7rmsffrVJtakE8pE3Xww/quduV09Hp9iDM+2RLCllGIyD/DEa81NH
 HUhaMdpMOp0ecztO7fRMaQHFS6vkylN+E5NI5hpkNOVvCkSoOsQD/yoHlO6d2TU2BUnL
 0dylKmTokKIuzi+o1qiFA8PkGy5Ebasr7nXXM28skU4cqYYe+aTJvjYEIFzsrTxWlrsI
 awJSRVjS1p3v6qK3RGBOZb94DtfEiQqWUNN7zVPz+KFTXliF+XUnbVfiNyCsCQmBvidL
 3fDbL303lNO+V4PAtYvOy4oZ841if4zeYpBZMw00VhlQFAUYFB/OPoHfS4zU65o/pTBQ
 Un2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867445; x=1782472245;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HvMaNaqcwIttNkU3aDc1WXF1Qz5hxdsi2aImlgX12OE=;
 b=Uys472ugdvQ3kftLDe8Wsc8eA/E6pPHQIlHzQkOY98Bi+PnHLi/xeK881JhfA1kO9+
 Uft3JxRQzRrrhD2UgCHk0iQ59LI/13QiDHEBAcBxacklsO5cb/5+fa2t53sCcpSUFBvP
 /StXitVolPOo+LB3w8AhFvk0Gy89RIalVz8nz+ztE+Vm9I/9ccBWd45GD+EnRiUF5QT8
 6z9DKUVIqZaM6JsJu3cUJqhZDXEuoXZWvpU3yC44PgdKtO5o3943Ktu2Z97yjcv/XeMI
 ieakBcSB9BHXKLbxJUidVwGUekYwgXTmFZcX3nQKARjCZjHjH+kgCETtMfYLWYokt+qy
 S2rQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tC+XvXocEFqaX+7LmIAcxLZaM29q2cWh9/rzzjgJH1r84g6Hr4vurn9Cotndox9kckvMrnXI=@lists.denx.de
X-Gm-Message-State: AOJu0YxXoX0fER4yLVTDLjfqvH5DABSVjejG0QX9BkotH4uvyh9Y9N5D
 ijIvtRn5+y++9ctVXtvYd+plzRIu6LAI9Lct1nNQfeQVVPJd0XlgQdiyCuaVtsn341C3pq5bV4x
 m23XWVgBI1l6K2nvJfEIr3hnjg6zHsmQcypbf5CcXt7ooQQIOQGGcFVB5
X-Gm-Gg: AfdE7cnKaoNjA72tQLLLwUpigeDUVpFHHy2e8G3EAfk6dFYrLz9F2nv5UjVErPM9vx2
 Z3t2mU7fFX+2JKloKDs6lUIUc/uor8XJBBn3sUUbFtAkvbPlugESky+mmygewZXxRQTFt02hGI6
 f2n6ZI/DOa+9VJ++ek9EQoHlaw7DV9y5iuF9vmftVNHhqY2w0FEBccFTN73A8M5VfM0TKXiqQrZ
 LwPkaozfJFd5u9Hkn0M2sCqWohonCojQ8jFXMuDYjw13fU7DkoS7RCRLLcN27SAkEcoAU7rXDGh
 Thu9hkyeNYeHqNbTc2SM3+rZBsfO99cu8OzbSoIk1XBlXooxZOPdmSMs+0oVBqrW/19i3r1D241
 lDsdXKSEcvD/EAilrmrkgHjK3Si2YGap4wQzvJdE6jMI+Z2fhgIpTOW+B6xygx+pLrfXCKcQi+F
 +Mese+Y6dGLli8joC85GOArBuLmAYCNNPOXc/Q9/Y=
X-Received: by 2002:a17:902:f650:b0:2c2:245a:3364 with SMTP id
 d9443c01a7336-2c718fbc332mr38289605ad.32.1781867444755; 
 Fri, 19 Jun 2026 04:10:44 -0700 (PDT)
X-Received: by 2002:a17:902:f650:b0:2c2:245a:3364 with SMTP id
 d9443c01a7336-2c718fbc332mr38289095ad.32.1781867444303; 
 Fri, 19 Jun 2026 04:10:44 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089a6b2sm22619585ad.2.2026.06.19.04.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:10:43 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:40:24 +0530
Subject: [PATCH v4 1/8] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-snagboot-v4-1-385497442db2@oss.qualcomm.com>
References: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
In-Reply-To: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781867429; l=2313;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=pIIHhn8rFQFxcnUMhcjr/yX2yRlCHFlj/5wTUBBJ9rQ=;
 b=W32Obe/gooP3hz0l9dEP/ag28xC2R2vvcxj5fx/GeeXO/eSk0rjKG6KZgZysOPFC1/7sYAl9A
 GZBKEI4VUPGB3BAZt8kYKkPWlmJKf4/YzufAuR9CCXtuow62fJpnbwH
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfXz5uuq6NVXj9B
 TR+ArSUkzRPyHnz7OTcRcc9BbMQl8O9wb0hCfd2qeRe+jomGcC5jqdRqQPexNDV+2cesCFZ3Bcw
 cNcgHXDAL67ITqutWf2qPLpTmrp2IZw3UtHShw3VWxrM6ZHXUP++zSRQN6mvlNtZdVYBktQq5BA
 BB5kIEeRlJDiFFVR/pkXj1HRlFH83xleP4RHyXrXhf66o3Liwp81yWuxAtP8eLzO78iSEgqNAEH
 SyXQNerDz61fWcIzq5jRdBHWL9Kaqm7btLA5Ej+oERlStN8GudVhPufmdEgsgGmo4qDlWEDwBXK
 n3HrD2yC1uF8/4zMqOK/Z3oloRMZ4vF/qziKbeUMh9m1XOFRsKcI2dUSqbcJiO/PS6jEZ9XcN3C
 X1OTDd9iM2RYdwm9uhIYLKuIfY0TRfjsytxboX8ccvg7q6FO5uA0dtql5M+ZyYHqtdL4aAGJioQ
 M4KYVokFueQJpz4OScw==
X-Authority-Analysis: v=2.4 cv=GKw41ONK c=1 sm=1 tr=0 ts=6a3523b5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=kIbHLVDOQXlpZWfP0G8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfXxQVEqGPuoCQS
 kXGP92gzSd6ORvHfPhWPpOCXda6VspY6o3bu8mSif70tdk4B0To1aADfCFySP5DhzBMLKQ6mDIN
 NHFPVxu5OGlz+ELBHdKStFYWKaNkG0s=
X-Proofpoint-GUID: GQG6Z5dAzR4DJzGNkDZ2L5zNcDQo0Ug3
X-Proofpoint-ORIG-GUID: GQG6Z5dAzR4DJzGNkDZ2L5zNcDQo0Ug3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190104
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

Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
platforms. This config automatically selects the required dependencies.

Add QCOM_BOOT0_SNAGBOOT_MODE as boot0.h config for automatic selection
by QCOM_SNAGBOOT_MODE. Document the platform-specific requirements and
configs that must be disabled in snagboot mode.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
  QCOM_SNAGBOOT_MODE
- Document the platform-specific requirements and configs that must be
  disabled in snagboot mode.

Changes in v3:
- Newly introduced in v3
---
 arch/arm/mach-snapdragon/Kconfig | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 931d25c1023..5c7dbe0dcc4 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -65,4 +65,32 @@ config QCOM_EL2_GUNYAH_EXIT_SUPPORT
 	  run properly at EL2.
 endchoice
 
+config QCOM_BOOT0_SNAGBOOT_MODE
+	bool "boot0.h initialization for Snagboot mode"
+	help
+	  Enable boot0.h early initialization required when U-Boot
+	  is loaded in Snagboot mode by XBL.
+
+config QCOM_SNAGBOOT_MODE
+	bool "Build U-Boot for Snagboot mode loading"
+	select QCOM_BOOT0_SNAGBOOT_MODE
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select SKIP_RELOCATE
+	help
+	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
+	  for device/factory provisioning using fastboot.
+
+	  Snagboot mode requires disabling several configs in your defconfig:
+	  - PSCI_RESET: Not available in Snagboot mode
+	  - IOMMU: Not initialized by XBL in Snagboot mode
+	  - SAVE_PREV_BL_INITRAMFS_START_ADDR: Previous bootloader context
+	    is not preserved in snagboot mode
+	  - REBOOT_MODE_ENV_UPDATE: Not applicable in device/factory provisioning mode
+
+	  Additionally, use CONFIG_ENV_IS_NOWHERE to ensure recovery works
+	  even with corrupted environment storage.
+
+	  Platform-specific requirements:
+	  - Set CONFIG_COUNTER_FREQUENCY to match your platform's timer
+	  - Configure CONFIG_TEXT_BASE for U-Boot load address
 endif

-- 
2.34.1

