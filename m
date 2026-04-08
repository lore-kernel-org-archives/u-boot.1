Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EB21073C9E
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4853783D8A;
	Wed,  8 Apr 2026 14:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Flrb2iX3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dOUXJ1BL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E47083D8A; Wed,  8 Apr 2026 14:20:49 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F26838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638AlpZ83362755
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 12:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3TeUKGv+NT8
 UqBE0FOYvcxyIbb8y/o0TnxIraoTfEuU=; b=Flrb2iX3+cCliGpyNRAyeXfGy7z
 dEI0tYRMYcycss0YwjcgiDjW8RmwZakKJ94B1OwKTrJG8ES0PEfRVYx3Qy+n5w60
 3zw1LDfYPsjCsDwcdp2kBXnYn8HOU4R4FreblG9dYDqgP6+LvCIt+UpGNnzAAeEF
 wjm1i0EdQZ69kTA096L00I9Bf7pt17dWLGdPfpEplt9vIWO4FjE9X2PTOxeint3B
 U6AWyH1b12NvpqgnCUM7vEeOXUSqeK0wnuVf0OSYNa0G1JO9CxL/f9iLIIwNRaGI
 n2hmxB1BIG4sfc2DEST5yFoyHX6XibR9lqGGFF13Nah8Us2Nq5494Md6uwg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7tkkamr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:20:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82cdf02bce5so3765469b3a.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775650844; x=1776255644; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3TeUKGv+NT8UqBE0FOYvcxyIbb8y/o0TnxIraoTfEuU=;
 b=dOUXJ1BLZZ/8Pns/AVqTUZioelrUo56duMIK3q/31Ajbvi8+vQQn7eEqVwtVCaUjG3
 kqYnWpwEndgnM1seiHIVpqbrpLk8e+UgHZXpLDISjHigovYxacbxrkozCC++VkfvqniX
 pGKiux9WTlwTbnHdrC1cVyOKTlS+rCJUPAtYptLqlK7r56D7nL8xalnx4Jawm810sQ7a
 W2ATpXyE1sdoGg24edAdRpfnlgSADC33YHYynqX8WtlceuXwe4x8YbLQr6zQcgTtgx1C
 ujUb/NxIw6AdZ5hmyX1appHoQN7X6JGzzrSWma0xv/Omuii0li987/m5W8Vr8v0cBRRh
 X6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775650844; x=1776255644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3TeUKGv+NT8UqBE0FOYvcxyIbb8y/o0TnxIraoTfEuU=;
 b=BPRp4MuyaswvIPJdk5uSOg+vDqE3+XzEl0pgFsJCB5bZgnMoQerr96dFlWL8bakyAa
 n+OtZx6nEhzUAnWazpsIg33WKVldil6NRkMd8yvVDjHYfHzR9BFDRUoBdaCz1mCjSUWI
 XwjBbcScNxNR45nioZ3mcXZyu8AnwihwapUdpripgCTCEAzlyIXuE3sHuxQ2us4PHpvh
 mHXiLeKq7t64EL30k9iNQ1PyqRfhNg/aq2s5upZp+0iKNOcK2TfdsC04TYw84OTyWHUC
 1XxoMpFTZgPVmSqMOKfqymY9toZyG/9rfmBzUPBEJU5BX7GnHTHL1sweHAoqqoGrOE03
 LckA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVurwA+6u4fIujlps6xWHuWT1nxdhQdFWs9Ahri7YI3pTf+r6CnwRrnZgnxfhn/o9Sut2q2hbc=@lists.denx.de
X-Gm-Message-State: AOJu0YwHJiy+Sx2lYmJMVD7vsCCaUR2OvYXvzqSAXzxKL/EHpJc3vF0/
 /GihE3R9pWbbRydzbotA99gYlcII51B9SU8AT2nv8JOqLgh/8upseUv/Q3CgQCZhgEVjRRqZFmU
 7Sm7ATDKm31lQ9u+j5QaGQUXcf/fPfpxwQQF3YYInI6oj1QOZJR4dCC56
X-Gm-Gg: AeBDievknsPzSIciUaquBJPwGNFgRYotLLYPKJ91AvtDNDb0xypOQLeRXdSKJ2BNTFw
 zIEsHfHRhzWDZQNOzyFbvZsUHPoQHH30Ybh5n1NdhLt9xS4hNoEodrIivG83a7XjuyFWo6mq0t/
 muH7pAl6OD2fYlpikId5AMIRO8wf7cFSZXNAW8UIr9aVdfGR0lYP5T78cXgKrftdbEFD2tYXfdr
 bb88cw4ASJ6DX1yuozVX34xOLCWxw3SxC8z0gPoNfhNY7sYnOlA7V/ya0SiChreqtWPxyZsvKm0
 3u6R8iQA0CKqO4eRwmLvI5Smg+6+Q3hpSLw2vmQVhv7XAylbu7uch3cN3QDpAodBSRp/ibODPDf
 POV3hnrGZj+bMuuhFVsbpjw+iRqP39475VtVQG9zuJxBH1MG/8dM0xB9IeGar/wtjemqwc2CRyN
 MdLdVkuqZYHalBQGXvS+vclPvrk6j6aMt2doxHEMdz
X-Received: by 2002:a05:6a00:2d10:b0:82c:66f2:1226 with SMTP id
 d2e1a72fcca58-82d0db84a62mr20247382b3a.38.1775650844109; 
 Wed, 08 Apr 2026 05:20:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d10:b0:82c:66f2:1226 with SMTP id
 d2e1a72fcca58-82d0db84a62mr20247328b3a.38.1775650843474; 
 Wed, 08 Apr 2026 05:20:43 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9a24039sm20512602b3a.0.2026.04.08.05.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:20:43 -0700 (PDT)
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
Subject: [PATCH v4 3/7] mach-snapdragon: Integrate reboot-mode handling
Date: Wed,  8 Apr 2026 17:48:37 +0530
Message-Id: <20260408121841.186410-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
References: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=drPrzVg4 c=1 sm=1 tr=0 ts=69d6481c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=HTivtqB3egNFbubTlooA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: Kddf7IFH4cLmztl6QDOVXjRyCPDQ3AYi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExMiBTYWx0ZWRfX7ejhIAJhFPkV
 zkiwXHqPpuglNBl4YJBqcd0KybPiB0SvuV5YbUfZ1xyt+B4rx8sHiREZ+5Y/HB9NFnVYLWhy6Lm
 C2fuaCW0AOafMPOSLQKCEXo9kpRJPecWUhqVho06NVcC9AOcm7DgwecnSQsNVHvd3vzAUKXvgDn
 12ZEjD4EyOribB0e8Ou95bM3+cAaZ9JSXj2JbI36WOsxOYNyquZRT1zNBmdUPjB/1ODmavxsib6
 TbrcjNN3U2N31wNiBwt1QoOu8vBdwscZD0TsccC96t/pOsNwht0wbOTwpidATf0remyBZTWr5Pr
 hrXAuPL8GSzRCE+MbuCf9UgGDF6scJksAgIyxvpKjTKsEJV4+H6Yne8nMhm9V/GoSb1KwEnHSwB
 T8hS9YDgCfsXmsYaOT1Phj0HiYdUxGkG4keZv+tYePLwmNeLFdCDAYVNQmMGXVi57LH6EySiMYT
 wOczjYuqLrQvmNPr4pg==
X-Proofpoint-GUID: Kddf7IFH4cLmztl6QDOVXjRyCPDQ3AYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
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

Add reboot-mode detection and automatic fastboot entry to Qualcomm board
initialization. This enables 'reboot bootloader' functionality on
platforms with reboot-mode device tree configuration.

Changes:
- Add qcom_handle_reboot_mode() call in board_late_init()
- Conditionally compile with CONFIG_DM_REBOOT_MODE
- Reorganize header includes

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v4:
1. Added early return `if (!IS_ENABLED(CONFIG_DM_REBOOT_MODE))`
   inside `qcom_handle_reboot_mode()`
2. Removed `#ifdef` wrapper around function call
3. Function now defined unconditionally with runtime check
4. Provides user feedback when fastboot command fails

Changes in v3:
1. No change in v3
---
 arch/arm/mach-snapdragon/board.c | 59 ++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..c3e97cdbfdf 100644
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
 
@@ -506,6 +507,38 @@ void qcom_show_boot_source(void)
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
+	if (!IS_ENABLED(CONFIG_DM_REBOOT_MODE))
+		return;
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
+		log_info("Entering fastboot mode due to reboot reason...\n");
+		ret = run_command("run fastboot", 0);
+		if (ret)
+			log_warning("Failed to enter fastboot mode: %d\n", ret);
+	}
+}
+
 void __weak qcom_late_init(void)
 {
 }
@@ -570,6 +603,10 @@ int board_late_init(void)
 	qcom_late_init();
 
 	qcom_show_boot_source();
+
+	/* Handle reboot-mode detection and fastboot entry */
+	qcom_handle_reboot_mode();
+
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
-- 
2.34.1

