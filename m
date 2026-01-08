Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8B1D185C9
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 10:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80B4B83B8A;
	Thu,  8 Jan 2026 11:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eFg32/wU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G0BpMfcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F77F84113; Thu,  8 Jan 2026 11:52:06 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48FDF83B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 11:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6085DIcv3890526
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 10:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=E3AWy6avvb0gCg3VQv1lG9
 trDRbn4odqmH6mcho0/Ow=; b=eFg32/wUFfagJHH3h0jRfaYeaaKgBc1OXioqZa
 N59zJ80tZBSZGeLjwc9v/NZLLoF7eCB0ynH8+tpeVv00IkzdhO63OxDinu+I6et7
 A30x82lIV8pqlDc9qoipiReHpUVDePYeeF8ZSgRSZznPgadsgZot6UpneBCNa7Oz
 rZVt28Ffy1SuiNoJiC5hMz7ktzEmIsTxv6iz3NhQj8TcTQwJ7LYVIK7x5vGIPeo2
 3PG+VbR+nXaN42C+lfL7hhtU2DDHWwG4cUrDwd196iTa9o0KxKwVT+etSiPuJWnR
 YmuzcNdW/a356ofhIZw0VlqBz6/akr7TeReX4OKOX6sZSxNA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhuy72sr8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:52:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a377e15716so67105795ad.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767869521; x=1768474321; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=E3AWy6avvb0gCg3VQv1lG9trDRbn4odqmH6mcho0/Ow=;
 b=G0BpMfcbvo7iFpK3r+uuWme3T2I/Y3tbHs7Qi0koKZbdIR3mNt2liCf5FGoc1Zjcg0
 yN9LAaz5m09sMQ4O7ZBnMM+mRtrABZL8JElhuSsCGlkNjcMaDE30gOBCmJb9GCqf57Ix
 ePghuQN3YRdO9yNXrhZhe33cFIBlabdi9nhOXAN2IWBs8C58p18pkOxtXWnc3U4cXSom
 8BQjO0TiDxDYz6wMjwrzB/KNOxYZNqfu2kVZvSw1aTq3urUnqR8B+cZRmJgOkxt63Wwl
 j+IYFmeyGgb+eomAwOQrFvWYnzGXfntG6mlfaR3PmpuTKdygnh8VzxNcbyu30GVhW7u4
 hEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869521; x=1768474321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E3AWy6avvb0gCg3VQv1lG9trDRbn4odqmH6mcho0/Ow=;
 b=CXaKIoQqtYG9tBTKZ9iwFiQj9Jekg0zxdW9vxWKpODJbHscok0FNHGOToG6eHB7hDi
 d8H2Ah8HmtfreKNTJm95m/Al1iKxa2wGgzHO+gOVGhoKvbK4ZqPG6xD9sOQvalXJFbrh
 GcUnXFOYyQOjlUCyPvGtmsvWTQLF4ju1Ar6kaMO5MSi+0ijO1Wv3JBErqWAn4XITwQZp
 XOMj/ItHNftJeOAzfDB6Wf0svtiUd5Bbb5rA70gBIik6VGEzhxzaLJ7ZYb373npR3Nxo
 lA5vdRnrZFf/SN/ykkIsAoJfjr4dlOF/nb48tFpassQC1G7d4HdySV12GPM2heUl3KjP
 WuSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkA3+leAx7KiYyN5dPCWOLB2kx+YK3OzboxXkRZlFwW34cMjhVlexkC0Hc8EHMhil4AJthKHE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4IEK5LzgwjtWJEW7HkFwVW1NhNR9tHHXsJPTkkm3BFTml8fGb
 ELyqPYQapS6f/aZKV3PnlYP16ubVnu79WROvwj+z+wuzGtLnHKdDDfy43uY/r/W4rTiLZeDQm0M
 lYSWCMorw80q/O4zvmaEyvzsQ+OUCpWxAN7ZF4HzRSLtDWaxkMXsfvZs0L3d77qWY
X-Gm-Gg: AY/fxX40m3pbObg8Ck2HIQIIPKCgWc3bE9ak4lxF7uENP084mii/I4ZebvWH8xPRBjb
 Wg2kniomUjendLeHtZlOj2YVzH+XtOWZlhUd9dC3RqfCOcOlH6jPlkvMmrQCOUIlngSPZQ2oJus
 jmmS/0A6Q45mTRO2rRpRoLZgx+4yBrec0pomM56qb1UYJzTD1veeDwvagb74496ytQQT7t3thgP
 YDQHzzKilV3oCtGlEVuBXOkYO7syXHXO3HKWJu6MpWY+FuZIUoa82lOxSD/M/fB985KpG27RpH5
 LS6msJsh2mHk0cFLUo7FPk21olS2s1TmL3O77ZWV8V6xuuLtzyEutFzEhAWHbmxILC2ayF7EkkM
 ZAixiruGt5zDAYP+q/+Q7jKbOW5lsawlnOuJhvxGauvBhDOb+T4iG9aBcjn0eiS0nHJJwpi69SZ
 9CzZj8dhxgRFoFmLjDShv4t7LwQlq2
X-Received: by 2002:a17:903:b48:b0:2a0:98a2:3ccf with SMTP id
 d9443c01a7336-2a3ee4b237cmr61251285ad.40.1767869521043; 
 Thu, 08 Jan 2026 02:52:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjcO3vp/lDdjXRJWpCtTMa/cxNBNFdAW93blEy77VWQKKCaw1r/LqNqUSgZ+Gp/lDF+cEFmw==
X-Received: by 2002:a17:903:b48:b0:2a0:98a2:3ccf with SMTP id
 d9443c01a7336-2a3ee4b237cmr61250985ad.40.1767869520532; 
 Thu, 08 Jan 2026 02:52:00 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc7856sm77032085ad.68.2026.01.08.02.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 02:52:00 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org, michal.simek@amd.com,
 j-humphreys@ti.com, raymondmaoca@gmail.com, paul.liu@linaro.org,
 u-boot@lists.denx.de
Subject: [PATCH v1] firmware: psci: Refactor EFI runtime PSCI reset handling
Date: Thu,  8 Jan 2026 16:21:46 +0530
Message-Id: <20260108105146.1285450-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xCHhRFsoQ3aUS5ZE_IS9KjDxLXetvVM2
X-Proofpoint-GUID: xCHhRFsoQ3aUS5ZE_IS9KjDxLXetvVM2
X-Authority-Analysis: v=2.4 cv=DZEaa/tW c=1 sm=1 tr=0 ts=695f8c52 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ICsd6TV6tRGNqm-va00A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA3MyBTYWx0ZWRfX+PSqTP+jzvaY
 EE3OEV2nB4I1jcIZZAlq4fdbEUrUTruYoJKHS2SbHc/pZ68fVP/DeCXFf9eaY1n4qmvgunkanM3
 Vj6PsClyWdo2P61pX7lN+CYFfLyz1cIudUWnTaBX4u/gVhcesIwh5a47ddf+1sGaXLtwlcf4cYK
 cjG1MwnVPL4UTj5cagitcxjQkIP7JUbamosNUjtAjiGPvH8FZrD2bSEJ1kGZOxyGhWlZkyJkg8U
 juIHma4aVxrGVL6Oy+WJhJBFFmUicmRP5kXS5oyrOnbif9IaXsvXzcgd07R8W/TXeHfIeiVe4mk
 fBHKhPvvt6k/GK/+gvUeSn2aVkiqarR3EX7TF+QzhIXT2G56dW0gbUg7t/3RfGYxq23T+zZH09c
 CAEAFyicQhuGMYxQLmFlPDJdNQn+kK0kTI9Lpx8dNj3+ESCCfaTXI7E9T8TSidN92oDmj7OVHDn
 PoY66wT3DS1YV5joJTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080073
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

Previously, U-Boot’s PSCI-based implementation of `efi_reset_system()`
was always enabled when `CONFIG_PSCI_RESET` was set, but it did not
handle additional arguments required for specialized reset modes. This
caused issues where special reboot requests (e.g., bootloader, EDL)
were ignored, resulting in a normal reboot.

This change introduces a new configuration option,
`CONFIG_EFI_PSCI_RESET_RUNTIME`, to explicitly control whether the
runtime PSCI-specific EFI reset implementation is enabled. By default,
the PSCI EFI reset is disabled unless this config is selected, allowing
the kernel to handle the reset logic and pass the necessary arguments
for the intended reset mode correctly.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/firmware/psci.c |  4 ++--
 lib/efi_loader/Kconfig  | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

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
index 13e44be1d06..23c9e5cd1ea 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -106,6 +106,16 @@ config EFI_HAVE_RUNTIME_RESET
 	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
 		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
 
+config EFI_PSCI_RESET_RUNTIME
+	bool "EFI Runtime PSCI Reset Support"
+	depends on ARM_PSCI_FW
+	help
+	  Enable PSCI-based reset implementation for EFI runtime services.
+	  This allows the EFI runtime to perform system resets and power-off
+	  operations using the ARM Power State Coordination Interface (PSCI)
+	  firmware interface, providing a standardized method for system
+	  power management across different ARM platforms.
+
 endmenu
 
 menu "UEFI Variables"
-- 
2.34.1

