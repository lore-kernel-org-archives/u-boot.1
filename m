Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338DAEDF150
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026E783CF2;
	Fri, 13 Feb 2026 12:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HxMeD3F7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KdBotEPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176AF83DE4; Fri, 13 Feb 2026 12:06:12 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02AA83CEE
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DAo6mO2093483
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hImQDvgKu9h
 saN9nt5U2O1xnGRiQmy5K52PekaGjZ4s=; b=HxMeD3F7GExKUOhbWVxJtytHUdM
 6ckt3KVH/NT1Q+8ZfUUjE0X2eyo3IbsgJ64rQ31Cc9O3iTdFuEdDCh5OD7AV8v2P
 zjuJk2Dwc72sM++IewusKJcCt7dU8P3P/oQ6RMoj3DUJz70ar/OTVaFrUXucY7lq
 BlnQ0hjxRyEXnJPyT0goxR5WO8A0yWXBvC0JP+FFHCz9gKwswAeQkajs78b3rBJZ
 9VvEI3moB9YyN+Q2jX9Kk6Ed/soImepGYFaQfkRY2eu4T/ZiXxRTq/JPulnGJRo6
 MlslVEF4Fq07GHRL5rJBsyirM+X9Nj/4pUFPewDbRUMOh5/Ix6HhMs/yOzg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9k6y3c79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:06:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c6136af8e06so654474a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770980760; x=1771585560; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hImQDvgKu9hsaN9nt5U2O1xnGRiQmy5K52PekaGjZ4s=;
 b=KdBotEPV56XpU4TVbbWZerDP7HDIjVuG4FU53mGH5WDniI2PvgDNC8xyQEPF3fOg7f
 91cBvPz9BUY4lfIeQODMRwfND3bs910pScc3Rs63WmhCskeJdsu4NKWHh5IINXDUjVlH
 aHpT2Q7InAjblcp7R7zfP3IJfEetdlszh0XBSQoRrLE2a/IEWnJ+8x/bz49vzMhVElJo
 859SGZyKoSEXGoxIUpA4UsMMBUnD3jII9HCju57sClS+8FGVBU4u9+JN3cYJvoZnMdCj
 Wcnp2M5sn99mNqV/QDmguSXqXRTH40nkyuDImufPqjES4qGK8P3//LAKWFSNEnAnmtpl
 t1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770980760; x=1771585560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hImQDvgKu9hsaN9nt5U2O1xnGRiQmy5K52PekaGjZ4s=;
 b=RbMGaETPLG6QlULOtkZC93oTgFsjjMRKiWAPH2/PvZ0GIixlJWbMMZqJ28DPcHqbwO
 UzUCsmWGNQZS2OHDqKgqoEc+6FcdGNtgtP+//PXFIKl7EgVtPu9HkxQcAQBqoZ7e9jYN
 ccoEvoe4jJaLT1dDJQ0Ew0IhNp2GeYcfhTtp/SvRexi8ba0h2ngw3t8D3Bv9wurNo/g5
 cW5XCkfbdAkxwOJSmdre1oXzHvg/8sTrpnJ2wh+x4XDGq6b286l4r+Sdiyhev4bvl9+b
 Ii/JsUYN9e3zrZQ33RHQhdTnCckMmuBWKxDZtUyuEA38IecTln7EDdujkEjOIxvy10Jg
 +IFA==
X-Gm-Message-State: AOJu0YyNthi6llxgh42bf4PB+AQLzVFyGypCLHV00PdhCr5yq5PVvN2o
 IMnLHukbvRj7t1yPtdQcZgfbmJTA9UWHXmjIGmZxD3lFTRqWEh3OOxzTJw1bVsinqCG9XudJqnn
 2+P8sBsShQ81LYOjRz8DgavEDsoVTSHhsHm6eR/++MPaVQ5Yxo2+Zo1f3RHznhOrB
X-Gm-Gg: AZuq6aJSJfbVvDLLgZOARbEKTpz1H/pELEgNo67XxLK8a4q69G6ntQuBXmgBr3hTPzx
 PuyVMkCcHjNaTgeLN/Y8yYLUptH4MpCzvM4dud8S8OynbC/5MLLVZ9lIg0JWoTfzcmOZMJaXTZa
 sIzqHCHcJq61gFcMH9r0RPH5p843V3N8UksdyRikMiynqcbzB01V5Kx2rdBdtkIZi7eqJdX2l5i
 EY2oYJwa0e/4BoAlMDitA5/1XZp73iNKXzzLAVN4LfjgydN2ggsJZeezAisHxrJ/rqXkDtvbyd+
 aJKpyNiEBQ/W8zVmRSe0ZM4hzAWtJ6Jo2prF5bfNxcCi7d8uQaPjO3bOU0n+xTp21m9lkZI313i
 05a2vQfOpeKSJAuIzRIv+Wz1pCBxRSNSoXft2eT5v/Ohq6g7/t36ygoP+ekDjKBVjCEbH/5zOQu
 vxbgLFcf4NRb338QShK0XL6ZQaVDp9ueer/j6E4r7A
X-Received: by 2002:a05:6a21:7009:b0:366:1880:c8f7 with SMTP id
 adf61e73a8af0-3946c56e491mr1351094637.0.1770980759687; 
 Fri, 13 Feb 2026 03:05:59 -0800 (PST)
X-Received: by 2002:a05:6a21:7009:b0:366:1880:c8f7 with SMTP id
 adf61e73a8af0-3946c56e491mr1351053637.0.1770980758888; 
 Fri, 13 Feb 2026 03:05:58 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e196a3663sm7943908a12.9.2026.02.13.03.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:05:58 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, michal.simek@amd.com, gabriel.dalimonte@gmail.com,
 jan.kiszka@siemens.com, paul.liu@linaro.org, j-humphreys@ti.com,
 neil.armstrong@linaro.org, me@samcday.com, marek.vasut+renesas@mailbox.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v3 1/2] firmware: psci: Refactor EFI runtime PSCI reset
 handling
Date: Fri, 13 Feb 2026 16:35:26 +0530
Message-Id: <20260213110527.1254098-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
References: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NsTcssdJ c=1 sm=1 tr=0 ts=698f0599 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=CLkPrrlkzVyQE86M9QYA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NSBTYWx0ZWRfX+N/BlPNHE8do
 JcpwqSxoWNSaTOtiX5OkCPskD2JFxHboHuqQTvFpvC7kBkJZU8YEBL/F8SEtOhI4nf0LifHHVp4
 crEZck21NWPj0jevhicX9s12QQc+qrKpOEUxQ6Re3DwsH+UFR2ouI34SSq1jqdsRzWyBkgJK/bI
 8RUeFm4jEwlsiRHZRZg89ydnFy9Nx824x1uEcUmCwXop1WgqOTAmLc4DMetUTwB2So5OCGPM2F3
 eJFDgTp5stijIY+YVG3qw6y2orynNxqxSklyaVRrt+6ApsrlHmzK8gMwXgRfIEcmOnHcdUCa0Cn
 RW+8UXY6elYqzdK3sBQ8WmtqmebJjvM5OJ0A+LrjkxunOrmOcfYh94jEcaBxXEG8MHa8/EodPbG
 HHSY87eVJgPFujebNDkqs2nnBSLLT1Z6FdGt6z6eP+hKs/ATMxiiOWV1upv0QqfXosDHuz0ZYEn
 KBJMIiENkLWkkO66pXg==
X-Proofpoint-GUID: mU7FVJEK4WNtk-asuPP6UjupHdx3FuV1
X-Proofpoint-ORIG-GUID: mU7FVJEK4WNtk-asuPP6UjupHdx3FuV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130085
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

The current PSCI-based EFI runtime reset implementation is always enabled
when CONFIG_PSCI_RESET is set, but it does not support the extra arguments
required for specialized reset modes. As a result, reboot requests such as
bootloader mode or EDL mode are ignored and fall back to a normal reboot.

Add CONFIG_EFI_PSCI_RESET_RUNTIME to give platforms explicit control over
the PSCI-specific EFI runtime reset path. This allows a platform to disable
U-Boot's PSCI reset handler when needed so that the kernel can perform the
reset with the correct arguments for special reboot modes.

The option defaults to enabled to maintain backward compatibility with the
existing behavior.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v3:
- Commit message has been updated, no change in code

Changes in v2:
- As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
---
 drivers/firmware/psci.c | 4 ++--
 lib/efi_loader/Kconfig  | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 2e3223e1c32..009c6153d0c 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -244,7 +244,7 @@ static void __maybe_unused do_psci_probe(void)
 	uclass_get_device_by_name(UCLASS_FIRMWARE, DRIVER_NAME, &dev);
 }
 
-#if IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET)
+#if IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME)
 efi_status_t efi_reset_system_init(void)
 {
 	do_psci_probe();
@@ -266,7 +266,7 @@ void __efi_runtime EFIAPI efi_reset_system(enum efi_reset_type reset_type,
 	while (1)
 		;
 }
-#endif /* IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET) */
+#endif /* IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME) */
 
 #ifdef CONFIG_PSCI_RESET
 void reset_misc(void)
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13e44be1d06..3882de273bb 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -106,6 +106,14 @@ config EFI_HAVE_RUNTIME_RESET
 	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
 		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
 
+config EFI_PSCI_RESET_RUNTIME
+	bool "EFI Runtime PSCI Reset Support"
+	default y if EFI_LOADER && PSCI_RESET
+	depends on ARM_PSCI_FW
+	help
+	  Enable PSCI-based reset implementation for EFI runtime services.
+	  This allows the OS to reset the system through EFI runtime calls.
+
 endmenu
 
 menu "UEFI Variables"
-- 
2.34.1

