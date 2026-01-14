Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3C2D29FEE
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 11:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4261883015;
	Wed, 14 Jan 2026 12:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKt5VHAj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K11He4Wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF9A830A0; Wed, 14 Jan 2026 12:16:54 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4F882C7F
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 12:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60E9jpOr3296288
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 11:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +aUTEsFiYQGEHxmSf70wLmTxpp1++ct64acYdqH/uyk=; b=AKt5VHAjd0rYr1KZ
 SeGWuOcl9FmF000+KIyiy2VEkHibVb8ioiNHZYVHIvvnr8KDXq2StSPiVwq+72VN
 4Nl3EPV8D0pEMVjdEX7u3mI880V9TjAVpkUs3gdgBxR3J4OexNIyPhc5bLhkWazs
 dN7umsYTskuBc9rCmblm45LtsTZ/R1hhn79IHVUirUsIc+uUTJziLJbdl1wEvLcA
 DjLKR0IMAC/zdYVvbZyRDu+AnmMOiRlzrJdlJ+4njduO32EsRhujIUCPYee4O1zc
 lRnsjcQK3vBdEo61q8GGW9fNYNhoO6tpFM3k68gU7I2hKMB+0LBix3lXAGWEYe2m
 7djJzA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp8t2rbmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 11:16:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a08cbeb87eso97689105ad.3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 03:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768389410; x=1768994210; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+aUTEsFiYQGEHxmSf70wLmTxpp1++ct64acYdqH/uyk=;
 b=K11He4WtPprtTfkoqFrmMZpca+4n0v/0o9LS9WNakY+wlcKwaSoSV8PfC+RtH8XroH
 Mtn4KvQ77Hq10c7Pzsvth+eFZUDcU6kIUE7uIIm+Cbn7Stan3jBVZaTgwRbLhmloUyPH
 S7D8IYRw0jUr4bkNyUm5qwlRk8B+hSUyvDagoA+d6giiR70J8Q5tdG6LCzcHkZzEL18J
 KesqLuQi6zrUGpHawQ1Rkyf0dhKU68SQA16G/wVCUr/RvAGdQL2SL1UQYpr5EMNB8tTy
 oYIKjkQu6eYZ21NgPxDzGPFOTNdZIJhuETc+amzU0j3oF7ABxLV3lZuDHMsv1EF7ckki
 fxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768389410; x=1768994210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+aUTEsFiYQGEHxmSf70wLmTxpp1++ct64acYdqH/uyk=;
 b=iXJBoKayu9cHNJojXiNzNjiZdcZ+r+ErbJqToZHpwoCGd1x6EyoDBxC3MZ0SjUQ8dJ
 IXDembcjftTzbyS4o4VRxwG3KQoyZ6iPPdqiVcIKmfNDDr5wrNu8mi2YwZ2KIcj6C7XD
 Wlphbg8goIW3a2eGq3lorcVGQ81a2Kf+MQh6gzrn0UG91cfhtLXCL6a+IDeaty7Jv4ig
 Xdt0PzoPkoMPeWh/XqWT95nE3JtUBi/cpyf5ET4RX+0wmFrqD9j6XNLV7fRHbEzSvzwt
 +zz0OZ987mHM9rTMNDb9EiqYny0d7HP2vOjaF/bEERteNHfxkeAIp1hMgJ/7VaOuZ5sp
 zbKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5oZPlLGBQurG6QMgSuWMCw1kTPqJcsuKjgDnJjQBqx/HOsNdAIwY117kTHU/nLV31OFavSxU=@lists.denx.de
X-Gm-Message-State: AOJu0YzgrbCp0pRt+4LsJWl0H2zQ3XSv9/AVqKtHRshG03DsOjkpAE7x
 Q86BYeJMnCBCFfL9FxkpYiCb0hY4rQ40YLnibJ74rT3o11vRYDgeSUfaBZYiNynD3Ih0xdiWD0e
 Ov7yZivc4m33LmQ3HjSW5vgRwlIsoaLhv2fb5TNLwbAecpLBFbCcFMpUm
X-Gm-Gg: AY/fxX6eh1YyY8b6j6Nxs7wpwc76ALxgBZq085no5Ud9HX0HGsmMPXaidOsCleQxfVv
 WUfsAwZBSCdxSkVEQSSxeRXco356vCkSzeXtIOiwJogkhoTFUAQSIBQUg77bno5WgPxoobciqok
 nK+nKCCIOau5PjgMstWpZQ72OH28oCSKKPIBZUe3J/Mw/Z827U0uYgs+fb7dQvrTNdXMiGIo+G1
 J0BCfBmNjnWEfFIlDUmpwgtswjmuYsFiaEJ8QZJ3EdHtGpHITNK/A/+OhgJik1p4gh2tWMJopm6
 kLDEl8MK0g5PnZnTgsbeSmBX9ubwknndO4yenAOCuGZPsfyxMP14veS5+BPXjHw04n7Ez9HRPNo
 LTDjMi0Ezn6nAIkpoP/Iz1QfZZJ0FJ5RhHBTIZ1AD5ccMxNr36ND4MN7hTWs3jMaqLhd91RaOL0
 Rrfa8ThLXgPLU4bxKJSGkYGFC8Hopf
X-Received: by 2002:a17:903:19e7:b0:29e:1415:df95 with SMTP id
 d9443c01a7336-2a599e5c08cmr20525485ad.51.1768389409932; 
 Wed, 14 Jan 2026 03:16:49 -0800 (PST)
X-Received: by 2002:a17:903:19e7:b0:29e:1415:df95 with SMTP id
 d9443c01a7336-2a599e5c08cmr20525245ad.51.1768389409448; 
 Wed, 14 Jan 2026 03:16:49 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd4654sm227758225ad.97.2026.01.14.03.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 03:16:49 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 quic_varada@quicinc.com, me@samcday.com, michal.simek@amd.com,
 sjg@chromium.org, j-humphreys@ti.com, paul.liu@linaro.org,
 raymondmaoca@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 1/2] firmware: psci: Refactor EFI runtime PSCI reset
 handling
Date: Wed, 14 Jan 2026 16:46:23 +0530
Message-Id: <20260114111624.2321852-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com>
References: <20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=69677b22 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ICsd6TV6tRGNqm-va00A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfXw59it7HleX4s
 ZpFChqDtApOL+c6yDubFQHO6a18WGAR7P4Z5gH85L4YFJmm85PflUtpDlNf6pVIXSDlyO5+vD3N
 9B072HX1addWqjv+09DGzAasyuewipOVfLGCZPEHNWwjXe0aDlE/tKrTAp8zRV8K0Mq2BplfgrP
 wkg0cMS7C/zeCdutHlZop/NGqpy4Dx8H5XmCACecr/oYeK3Mbj1JpuxCRyZayEqxeT/epGRmMOn
 0q4MWfs0j64ZfjFziFcQZ/+mEYvJ9NDDHcLwXJJgFyiXyfYqCvZzfzn59TW4rrsDWxLWEQrWdOk
 Z6uYRA2hr1AOYW+kxqdTtkxLxiYfOrKCw5jc+yn1dJ9cm7nv+8gKI7HNoatMJzTye/NFq+9fEBm
 z9y4iQ4HpUM3vU6I9o38fGJMK1Uu5Fq7om3Zu4saXuxjCH7VtYroAmCVNzWprY2SBMnmJCHLoft
 4r3kFTc3MakGYFVw8qA==
X-Proofpoint-GUID: v-wC4gPFKH8S8N-O3ukT2XscaRG6g22o
X-Proofpoint-ORIG-GUID: v-wC4gPFKH8S8N-O3ukT2XscaRG6g22o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140093
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
the PSCI EFI reset is enabled, it can be disabled at platform defconfig
allowing the kernel to handle the reset logic and pass the necessary
arguments for the intended reset mode correctly.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
---
 drivers/firmware/psci.c |  4 ++--
 lib/efi_loader/Kconfig  | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index 13e44be1d06..712905a56eb 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -106,6 +106,17 @@ config EFI_HAVE_RUNTIME_RESET
 	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
 		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
 
+config EFI_PSCI_RESET_RUNTIME
+	bool "EFI Runtime PSCI Reset Support"
+	default y if EFI_LOADER && PSCI_RESET
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

