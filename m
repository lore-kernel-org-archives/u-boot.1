Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6413FEDF154
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02BB083C4B;
	Fri, 13 Feb 2026 12:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EsH/vRwB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OXf4pC1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CDDF80FA1; Fri, 13 Feb 2026 12:28:06 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5A483DE4
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D3vpcn1756703
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=s7MN/AyttXj
 s36dKL7ONF/wi5A8+5O+HHmAQirWhqCU=; b=EsH/vRwBYUQ6Y/7BhS9Bzm8o/t+
 0ciJeAqWm/9QVi9KTbIu3D7nrIsdYz2ZhBujKVowTXqogar+bQoKABMKJPADz21K
 xGqxDRb+UBzivr21dn+8rZrIFEQgJ5HAQQTgTMa2ZMKAS/Qwcfk3atG7r2LrASV2
 vrJ0WYGy6cfSgtAruxxkXjCK7gqRjzc2/jQJofFi2BeZ0TvXn0t5n3yngp07jIcN
 gESRrN521DzlOAaPQu6Xpih0wDdQz+833QS30YsIr4luxmbdU7xP1532N+OcPtXx
 95fcecharhcYv+q+aYK8p5A9XbYkA+6T7d7yKYGnT/XLbGiqBFJs/4HHH2w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9mb1375c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:28:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35464d7c539so846904a91.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770982080; x=1771586880; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7MN/AyttXjs36dKL7ONF/wi5A8+5O+HHmAQirWhqCU=;
 b=OXf4pC1i2y0xwOgZ0s2ZqLp0dpetcaJK21hnD3G+nHbpmomy1Mo99JUGcZqRy81OQ/
 ka6qJLS2nFjQ99HUb4YTNPyTCHnzayGrH7JE1+wBCZbeETQkzoG/KJC1lgLRHS/TsePV
 /O+qVhv+VQCEs3wnnboC0vKNsSaAblkYt9e6JBNU+6PkfGiVzCaPtBEZ1bfFon6cW7i6
 crWApN60x0k2ZUqg5jxpX8TRMACRtNCoNrfMn0aK8NIRWN3h0yq8mhooLE/sTkiYphuN
 +IuwBJZWDD/8Kt9mCQDrH4UQUw4+dMK07gksWjhZMS8PNeOibm+F1yK55MY4Qe1xws6W
 cXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770982080; x=1771586880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s7MN/AyttXjs36dKL7ONF/wi5A8+5O+HHmAQirWhqCU=;
 b=c4PSMM7WFFkIuzizFmc6mlfH59whHMuHAcbwE6UpKNbQHFr3FV6LA3T+VbLpu4F7tb
 9pztAG2a1Mf1GED+KytD0c3M+Cl1O+FvVVJYiDO+GYyUoraEXSSen7yirZW4BThN6yFs
 m2Hc+SawRzM7tr5Vxo5nMuZglutIPBg8QXvPfbyVMaOuVChbOQdeTJfgAWEBBYnrXSGZ
 WNiI7hM3yGQbo8d0U6qS8w9mdzR4sXJabusImAAUsa9cQH+PlMqb4SLe6mWF42Ga+ibU
 1/O3n7md9GrUbqVvmi/BjdwuxpxE0wjFGd/Umfee/P6uWLyFUwgHPvLA6qM49GBJeyfv
 kAlQ==
X-Gm-Message-State: AOJu0YyxjdvYjtRcHUmFfom1g5XZY3YrbPwJSifXy7n0Y1I/Dn5/S7dg
 Dw6JYzA9+hCUNVWG3z4nc1+cuHU95B0k655KDPAP6PWVW3gC46wEy2iT+B0y/gWb2oCNcGeIuCR
 trWEnJwUVrH9rxngyCK1Rbz4wX+ETdqnqc7B1iuRkPDN/0qezDR5KSSS68GEqtVpV
X-Gm-Gg: AZuq6aKRBsu6e4GqFsQorq/YNYCIQg4sZoBALF3vc+Q3GSYyBB8i4V0xQtiPlV9iwIt
 4TeRXqgG20hFIeISW2YxGaxmJp8fhy3tiecZUEbMu1i1nfxylSEMeo7tHBJ/bf8jn8CF1Knne98
 jZHJjyZNQrg7TYMaMV7MOf/JVBAN/46rh3/ywGzw4ddk/8sLA4D4uG7vk/ChZjIYRo7/PMVrZlZ
 sokoDFfX24gkMI/r6xIcquFjZh3DKYU2wBz+mRQ5+v5itiGfvYlokqpn9WPY2N0mIuKjk78y2Nd
 dPUrrhsTRfIjYhDdF/6z55rduCB0wquog6UFyU2QwYT1dP0HVBlJiDjxqs5N659gqe4pTzjGxeM
 t653k2DDvVKZZPDPOMf9PLua7S83dC7ehdWiVLQvOLIeoBBWnzrVWVmOXlBYzD9/RFUgaI0loJ7
 DSIdMFVwfV8JMP9NNoB55jqNqOgwxMCuYyex2NTnah
X-Received: by 2002:a17:90b:3c4c:b0:341:8491:472a with SMTP id
 98e67ed59e1d1-356aab9a316mr1530040a91.4.1770982080384; 
 Fri, 13 Feb 2026 03:28:00 -0800 (PST)
X-Received: by 2002:a17:90b:3c4c:b0:341:8491:472a with SMTP id
 98e67ed59e1d1-356aab9a316mr1530012a91.4.1770982079881; 
 Fri, 13 Feb 2026 03:27:59 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1969f314sm7996939a12.8.2026.02.13.03.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:27:59 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: seanga2@gmail.com, trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v2 4/6] mach-snapdragon: Integrate reboot-mode handling
Date: Fri, 13 Feb 2026 16:57:15 +0530
Message-Id: <20260213112717.1256823-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NyBTYWx0ZWRfX2NYOnZ5kV5rm
 5Uqx12X5gBqeXwodvRXGpzzeSXRvXlycdFzwsmzjpsrLXUU3u7JMIQtTe6rV3UsC6f5D0HPjPLz
 O2LuC+O2PbNgavzpLhFWhjnd70wt4yJl7I2Sz1WvETrzfdgxs/PW8NhqAC8WkWJY+U9x3PaR8/m
 K2GsFkaw0n2+7HWKfLX0E9DZLNs16IKnbxdXJofZBLAae2YBl76qOZk+q3lwYgQoDLgIdDKeDCk
 yPtpCPz1SLbwH6Ny4KPd+N0p+U01k+7QmG6gHAHXgXtLFxYg2N7QtImGnwGgDGDzA+SBVWoEMqf
 qdEoy5eFvS4ytHlV9FVDAnbYTXM3K73D1q/QvCzNbFIlXmP2WtH8CX28ysoRka/SzXQHRospUO+
 bjfUUEC4kM2jkye1Ydupm6ovJ/frwWq7IOuk6PJUgHN1Zq83AKWmcxaXfwK4YRoy7uM/mnM3aQF
 wiWK+MH5Op7J0pD1eXw==
X-Proofpoint-ORIG-GUID: cGZmGCmc2CJxVVWI7z_GAJOPqSJnY26x
X-Authority-Analysis: v=2.4 cv=asC/yCZV c=1 sm=1 tr=0 ts=698f0ac1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=zRlt6gtmhGCAqZgH310A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: cGZmGCmc2CJxVVWI7z_GAJOPqSJnY26x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_02,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130087
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

Add reboot-mode detection and automatic fastboot entry to Qualcomm board
initialization. This enables 'reboot bootloader' functionality on
platforms with reboot-mode device tree configuration.

Changes:
- Add qcom_handle_reboot_mode() call in board_late_init()
- Conditionally compile with CONFIG_DM_REBOOT_MODE
- Reorganize header includes

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 56 +++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..a596d052711 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -9,6 +9,15 @@
 #define LOG_CATEGORY LOGC_BOARD
 #define pr_fmt(fmt) "QCOM: " fmt
 
+#include <command.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <init.h>
+#include <lmb.h>
+#include <malloc.h>
+#include <sort.h>
+#include <time.h>
+#include <usb.h>
 #include <asm/armv8/mmu.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
@@ -16,22 +25,14 @@
 #include <asm/system.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
-#include <dm/uclass-internal.h>
 #include <dm/read.h>
-#include <power/regulator.h>
-#include <env.h>
-#include <fdt_support.h>
-#include <init.h>
+#include <dm/uclass-internal.h>
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
-#include <lmb.h>
-#include <malloc.h>
-#include <fdt_support.h>
-#include <usb.h>
-#include <sort.h>
-#include <time.h>
+#include <power/regulator.h>
+#include <reboot-mode/reboot-mode.h>
 
 #include "qcom-priv.h"
 
@@ -506,6 +507,33 @@ void qcom_show_boot_source(void)
 	env_set("boot_source", name);
 }
 
+/**
+ * qcom_handle_reboot_mode() - Process reboot-mode detection and handle fastboot entry
+ *
+ * This function detects the reboot reason from PMIC registers and automatically
+ * enters fastboot mode if the reboot reason was "bootloader".
+ */
+static void qcom_handle_reboot_mode(void)
+{
+	struct udevice *reboot_dev;
+	const char *reboot_mode;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_REBOOT_MODE, &reboot_dev);
+	if (ret)
+		return;
+
+	ret = dm_reboot_mode_update(reboot_dev);
+	if (ret)
+		return;
+
+	reboot_mode = env_get("reboot-mode");
+	if (reboot_mode && !strcmp(reboot_mode, "bootloader")) {
+		printf("Entering fastboot mode due to reboot reason...\n");
+		run_command("run fastboot", 0);
+	}
+}
+
 void __weak qcom_late_init(void)
 {
 }
@@ -570,6 +598,12 @@ int board_late_init(void)
 	qcom_late_init();
 
 	qcom_show_boot_source();
+
+	/* Handle reboot-mode detection and fastboot entry */
+#if IS_ENABLED(CONFIG_DM_REBOOT_MODE)
+	qcom_handle_reboot_mode();
+#endif
+
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
-- 
2.34.1

