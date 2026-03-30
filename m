Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742191061B17
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9703B84020;
	Mon, 30 Mar 2026 19:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQwNvYTa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FULmdP6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF6E84020; Mon, 30 Mar 2026 19:15:10 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2711F83E7A
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UG48AG3668463
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6JNEPFQimK2
 O52Lsilc33mZzYpt3iDDdyNIZ6dq4XTc=; b=hQwNvYTayCJIli0W5s07LjGvMmc
 M0WA8vplIBgEmassGPy9X7hiIZg3eVpqe+c4eVF9hfs7uLp8rzUxkLrqHFz6lI0F
 6HWhINNKLX6kn3p8vGB8iFtXzBzyN9AbHXoOXdSyAsYvokI00ncsbMymb4EkHMUQ
 2br05sqlYRP83jv5sBWSY/w40/6qkj2r6IEqqFK0XJZNf6Y/Ko0IZLBTUMXztEMe
 1iWklmjLSlaWegZ+IvGxrWdPurrUdJYSnh16gwvBMC+Ao6obNhah9+tg/PUWFkWP
 fwKtymAnLWDZV2GT3tq1I6OTd1ddrBrvIrDYQKv4BmdK1MSgA/Rrj2xsPRg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7vcc09pv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35da99b90f6so1762646a91.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774890905; x=1775495705; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6JNEPFQimK2O52Lsilc33mZzYpt3iDDdyNIZ6dq4XTc=;
 b=FULmdP6LTBN7VmeNHqldrIOlQsM7qmuNz2sHBhkQDuxEP2PYNsyHnYeaDK0eACsBMr
 Lf/dSHo0LpJQfk0mnqsRotf4WWL84/CcLeZIPmIDUlt+Kpis7W80oi5AsAX9uPrup+Nu
 nYoueOQOSXqCh/7usElWJezPR4gidl2T9ArokLV9S+WlsoHEeyyUO6eRcUbcC/4b7ya7
 uJYk515hBylI49zi6dBfynsU5Xd/zVidfIWKD8eLwbVXX131C13tRYQ2/Eg1FAbuBskg
 kqSS+GwL0kATPp65Juw+XL/tZhws/0VcuzXEV14ZlVyEkns5xiID4rmD7QsCynY3RbVC
 1dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890905; x=1775495705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6JNEPFQimK2O52Lsilc33mZzYpt3iDDdyNIZ6dq4XTc=;
 b=FQCe8zJwrrovmgKG7p6ER6/+s6RpgWsp1t4pcQ8F44EaKnzvv1chTD0Nq0uQ9mrYsw
 FuAWwaOXHJ1JCs40d+FfnBji5RXnNnn0r+qQUe7um4JZlHHfuznjnoWscX28sm9/pWIq
 uf7fXQ6DS4iFnZn6Of90zvOhkxfrjCGJ8Dv03H/eHI9WhGxNHvfsPZ6HsOhSX7Nu8HEi
 ODPkolhI8L67WyMGHY7df+2xNHcnQyz5sfhtQv8MHakE9RxeR/JTVOKqA37/D0/jo1HF
 /CXgS+1rNdqr3GYD7nk6l/Wk2xluHfzSVBBtn7Cs/ay7ak8MqMbW6NaJHo12AFKy1MYA
 JFzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNmxxrjTgPzJ4oLs4Pzelwbwxu1d9UhthZfJqNyOqLXtIJz7sa5Ro3Xw7WotXPGZus0OlsH60=@lists.denx.de
X-Gm-Message-State: AOJu0YwhcWpNuJA9PYDbnWpYg3OpZfcfSbM+inW+N9G/di9PbGIAud3d
 lkykKbhFcXkECT1IbrE9pEc2hU3CFRj99Ni5j+2p90c9hN1X34oE3Tug/CkyS0BAglwQYl937Bh
 KT6YpwV84g23HbmZnTqo5sUBTPD9VoSDqDrDTEpeoRb+2notkrSaDDDwA
X-Gm-Gg: ATEYQzw4u09APQB+NHCAiQ2yB6NSlsIJ/WKgDclmProBpioVOtlT37WFmy9eN75hyfd
 Pfz0stUAm8zt5+tKeNrNu3N9DSAQuKt4dJfVDrJuZUK4v0ODEd3+7s/y+yT6V5KO5SnjRGu+2dZ
 yav+Cg98m9N3ZvKVcmlovLvuN42CSJWlYIwO1fJyWhHQGuNnEe5xeUa0Fjbs1yMk9tjIbu7UfqT
 bPXpOm2s4rKG1VhYz3Nx+SpRJNfLP4gD+hN+f4gMin5H4gmXgPK8pQJU/33go4k+HChO0Kb6ltz
 DN8tWRteBnEx8UtdKgivSqrobAWHc1N5TxHxY2H8l2tHJaENigahpIHH9IwStWtNNN4rmOXCZQL
 OAazyY1iWTW39oZ1FbIA2anIGaQnHi1n8FYacvoCBjE2+KufSW8yJuBULpxvIsYp26HfVONV3Mt
 5E5LShWvlKRU998XTy+t5unmAV5rcXl6J701NtWxSD
X-Received: by 2002:a05:6300:218c:b0:398:79a1:cb1 with SMTP id
 adf61e73a8af0-39c87c61d6cmr14083234637.64.1774890905115; 
 Mon, 30 Mar 2026 10:15:05 -0700 (PDT)
X-Received: by 2002:a05:6300:218c:b0:398:79a1:cb1 with SMTP id
 adf61e73a8af0-39c87c61d6cmr14083186637.64.1774890904517; 
 Mon, 30 Mar 2026 10:15:04 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8626518sm7349777b3a.52.2026.03.30.10.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:15:04 -0700 (PDT)
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
Subject: [PATCH v3 3/7] mach-snapdragon: Integrate reboot-mode handling
Date: Mon, 30 Mar 2026 22:44:15 +0530
Message-Id: <20260330171419.1117817-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iWxCHupHK7_-__G2fY1MGCDRqLYODdI6
X-Authority-Analysis: v=2.4 cv=GbMaXAXL c=1 sm=1 tr=0 ts=69caaf9a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=zRlt6gtmhGCAqZgH310A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: iWxCHupHK7_-__G2fY1MGCDRqLYODdI6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MCBTYWx0ZWRfX/NSq0aatIwMS
 EX5xj3ZeV9N5DU5QHDOxzxtpYxnjPXupgu+ZK24QG7iiyRNSmBfdzP6yFDV3+QmE7iwa+nGUnOH
 GzOj7YAHD4+RDFYvgkYOeR2bUQ/0z9zdmaFFxNar9xMxv7TRBW/5b+mt/VVpEfUv/oCw/7ZsgqK
 WN+XrLUh5NRH+APFhIft2id/G2W0Mww4icoRsRVbFVx1z0kn8gieI+nRzrOumlfEDlAAvGB4Pdj
 9R40ZmMQdkkAkK5u98zLCzEMlGhewbfRvVodUYgq+xUjGXWwDxUfKbsAvXfnI1kbmqLFj0Sa4ut
 ssDIiAaqm7ehrBmlOtQyCZ+24KK7OuerhOKbW8lPz7Pm3q0mXkvKR8Q2R8UjFb2iwy9Ctf6bLPX
 vcBQEzTq6cFT1mWZ4O7ZZ5AJ0Q8uLtTif2AVTxVBYqNCzoJupVXJH1ih+/76nhISjHjlHsnjY8k
 9spVNoXplNdW2loAffg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300140
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
Changes in v3:
1. No change in v3
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

