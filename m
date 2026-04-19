Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90197EA719A
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 17:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D7183E81;
	Sun, 19 Apr 2026 19:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nqw7/hmn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UX3vA+9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE8884181; Sun, 19 Apr 2026 19:38:55 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E7A839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JGCU1n2107176
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 17:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4r5zEIU/dXPfFFQqEgbH8fxAnczLuX4G31A
 z5P/PXuU=; b=nqw7/hmnLp8v7G3SKRuwfIqSKc4qyrZ8lHhYrWYWtcaZ6WYwz9o
 8xE6Y67LinKt7/didIDy0DA0QFkWz6fVm7T9deVUJaEk3kFGeRtoB0hK0BKEJUSH
 0KGsVRJkIMw5xpbToKo2ITskZZlIZRByIc2Ns6qkZbad08uA+hsdRGpEUQL3XMuj
 j+cUQbWXEDmj7NtAuTtzKbk35YYL1Af0Hb8unmtrzFSN22FRrIc8ecTjpZwP2IiT
 UUj0q2gvIr+MiqoHXBUu0FfU7sz85SV2RAm3z5Ei/eJzgWObeBVG1RSuueMsBYve
 e3toQkwLos2ZTuE9i4RVdinqfGDo1bWKFgg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0y632vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 17:38:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f7bec24fdso1390456b3a.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776620330; x=1777225130; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4r5zEIU/dXPfFFQqEgbH8fxAnczLuX4G31Az5P/PXuU=;
 b=UX3vA+9lC2T2TYnpL8fwWNxNYSbYLeDo0qEXGI/r3G4F9sAQ/vhvA5IOX6f/yC+Ym1
 lRRm30kDC1sn7PrJaKcPGOJjY1+KKEu1YZNUFTzRklZPy7GMzVLwMVPliSfio9fPAkAi
 wn+StQKXW6q5NatBKxDKaajuKQ/cP+x6oE3pDsG1RdLiRmtS9QF2o8Tke6zlzj6Y9YXP
 6SKr9//cLchoFtgjLFn+aPpAFRuSeW2cdJoy28IaSkILYtiGQvS82OfBM5Sn7wnAB4KL
 aRYvNejgHQyblx2EtKZjS8NZz+gdskCwwkE0sM1udCP4WQpiY1JZ3CcQtwRLCdjTquXc
 Uwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776620330; x=1777225130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4r5zEIU/dXPfFFQqEgbH8fxAnczLuX4G31Az5P/PXuU=;
 b=ngymTdrL/36i+9EpECf2OLbS8bjGPgfZMr9N2gQ19MNWcRoYatpe1P92jjpvWZJk+B
 ORYWCC56Afga6j9JbeHXd1x9DwflZTrhenjH73X+13xeSw+QB0BRyT6Mch93/EC86UQ3
 2HO58atoEvx3Rr5acKjF9yyDHXyQ5OBMi4mWzcekMAnSZo5bohuQlSxpwiKcTrodJWQm
 WvLylMb4PkK5VBIrkul86Cd4FbhoV2Ns8OWvLGTGHUfroWwjj7rtzVT4MeIjMo0eEWNl
 GaJSvsbwcMwncbRPzjWnpJjLLkbrPI6cJveMCxPUHYqFeNhic+SK3IdUe5Vc0zDFkTHC
 W04Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8V+ZpSl04V++WBqHo7yGJQrlKjHDjm8STjzR08QqlqyH01dbJA8MT84tnOWxisAzljxFzluro=@lists.denx.de
X-Gm-Message-State: AOJu0YxEv9p/R4l8379leAfo6RYPmetyX310pudL8RtbA7nE3Job9HtD
 HEjcyapm6TcelF2daWCstBl4HAvOWUzvzb21oUMSG90cXMokI5vAIgIuuUbRyPl0cLyW2f3YVba
 v8ypogKKtCLARa67SOAA+YxJruWnjPuAY9ol285LjK6O3Jv96x2WI7u9u
X-Gm-Gg: AeBDieuXgG1luC0huaQHIUnw0GRptOLs2zSW+AilHIvR1h86+7TPym9TEsRbshyLztt
 rwJIH9eVT4xRYe73U6bpQOQ3mKpvB7osPpkbHLS4n10x4ECcHphVSUgly9HjxZd8P4shIRN5vLU
 5oAUnESpK5HuYPv/pS+8XLRDJGuSTSUOqMyYf3tOZEI+0vBMLhCDwnRT7gu0cGr4BTLP5V5LgeG
 +XE0VLD3Upvfoxuk8QrKJ/C7xLXUlPrWDMIMHmbYYb6l13FVmLwQEA/mo910trX5BnCjd/swYnz
 DiFrpQ/vzw/s7Yc/X87rBztVTwZroJqQ01a09KNZiAxBATPwSQ+e4oet4Y5eHEnhjoa0sX/2xrz
 vQmuNbTEoPFJzd6NApjd8iqkvcRowwT8YtOWEhjlLCTVH502hwAlSbD9iRrJaygBXg2DnR1HZ93
 QF226h7T9g4EZ8NvXKwE8IPOrzik6X8C06U0svvTWJ8qBHFZTU3mo=
X-Received: by 2002:a05:6a00:4214:b0:81f:3fbd:ccf with SMTP id
 d2e1a72fcca58-82f8c8bcc27mr9943627b3a.23.1776620329829; 
 Sun, 19 Apr 2026 10:38:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:4214:b0:81f:3fbd:ccf with SMTP id
 d2e1a72fcca58-82f8c8bcc27mr9943610b3a.23.1776620329320; 
 Sun, 19 Apr 2026 10:38:49 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f97eb5ce8sm6020070b3a.61.2026.04.19.10.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 10:38:48 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v1] mach-snapdragon: Add KVM hypervisor support
Date: Sun, 19 Apr 2026 23:08:29 +0530
Message-Id: <20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AtxXdBqCXyXLy9p0SutJyOmb8votIZt4
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69e5132a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=v8_0fD8sVwdknlzlMUYA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: AtxXdBqCXyXLy9p0SutJyOmb8votIZt4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE4OCBTYWx0ZWRfXzSYoMWxffcpN
 SYffe2VhJHgzImDCno6S5ual6LW+uV/UbuihllLZnOOc2saRXWc4qWE2ZOmS1D+6vDHuVS3se1f
 3UmnQFnvDxac3GvPnYtQliHdUW2a+z5Fg8y1ciOUwktIgiMwcrmTN2GKEHzzlzFPhxBkAPMOj3u
 srXTqxpKZmhi3yEVd8fCYhu8q1E5JIu5Wz9Ix6Osd17g0Nap5VdLvknhUDeaU2tR3vS+P0Q1YS4
 l3H4Am1pD5YNR33JwAnEmMK+G4f+JiUG0N9n8RdHPtKdqAPp/qc/eZXoWBQWAhPBmMym7so5h+F
 UqaJ7yic6+wqjk7nDzh1ukgGy23bCq4fdZQOMnemvMnp3ypj1bVcqN9le3h2dCUUCzkSwKwaReI
 RDJbSpYY0vo8bzSTkdcfWYFQmnW8zk4weGTCTgScvARkKgwHe6LyG2SaqFfYCHDDxCi4YPjQxEy
 mUQkRJhN+KeSji2Fxng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190188
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

Enable Linux KVM virtualization on Snapdragon SoCs.

Introduce CONFIG_QCOM_KVM_SUPPORT to select KVM or Gunyah
hypervisor modes at build time.

qcom-priv.h:
 - Add TrustZone SMC interface definitions and parameter IDs
 - Define hypervisor boot types (GUNYAH=0, KVM=1)
 - Add TCR_EL2 bit field definitions for memory config

board.c:
 - Add qcom_configure_kvm_hypervisor() with EL-aware logic
 - EL2: Perform direct SMC call for hypervisor setup
 - EL1: Save context, disable caches, run SMC, restore state,
   reconfigure TCR_EL2, re-enable caches
 - Add qcom_configure_gunyah_hypervisor() for standard flow
 - Add SCM service availability checks

Default mode remains Gunyah. Enable CONFIG_QCOM_KVM_SUPPORT to
select KVM for Linux.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig     |   7 ++
 arch/arm/mach-snapdragon/board.c     | 154 +++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |  31 ++++++
 3 files changed, 192 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index d3de8693b5a..2e5676945ca 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -42,4 +42,11 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config QCOM_KVM_SUPPORT
+	bool "Enable KVM support for Qualcomm platforms"
+	depends on ARM64
+	help
+	  This configures the hypervisor interface during boot to support
+	  KVM virtualization instead of the default Gunyah hypervisor.
+
 endif
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..2926dd8ccc0 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -510,6 +510,154 @@ void __weak qcom_late_init(void)
 {
 }
 
+/**
+ * qcom_configure_kvm_hypervisor() - Configure hypervisor for KVM guest mode
+ *
+ * Configures the hypervisor for KVM operation:
+ * - EL2 path: Direct SMC call
+ * - EL1 path: Save context, disable caches, SMC call, restore context
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_configure_kvm_hypervisor(void)
+{
+	struct arm_smccc_res res;
+	u64 current_el;
+
+	asm volatile("mrs %0, CurrentEL" : "=r" (current_el));
+	current_el = (current_el >> 2) & 0x3;
+
+	log_info("Configuring hypervisor for KVM (EL%llu)\n", current_el);
+
+	arm_smccc_smc(TZ_INFO_IS_SVC_AVAILABLE_ID,
+		      TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID,
+		      TZ_CONFIGURE_MILESTONE_SERVICE_ID,
+		      0, 0, 0, 0, 0, &res);
+
+	if (res.a0 != 0)
+		log_debug("KVM milestone service not available (0x%lx)\n", res.a0);
+
+	if (current_el == 2) {
+		log_debug("At EL2\n");
+
+		arm_smccc_smc(TZ_CONFIGURE_MILESTONE_SERVICE_ID,
+			      TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID,
+			      0, 0, QCOM_HYP_BOOT_TYPE_KVM,
+			      0, 0, 0, &res);
+
+		if (res.a0 != 0) {
+			log_err("Hypervisor configuration failed: 0x%lx\n", res.a0);
+			return -EIO;
+		}
+
+		log_info("KVM hypervisor configured\n");
+		return 0;
+	}
+
+	log_debug("At EL1, saving register context\n");
+
+	u64 ttbr0_el1, tcr_el1, tcr_el2, mair_el1;
+	u64 t0sz, phys_addr_size;
+
+	/* Save EL1 system register context */
+	asm volatile("mrs %0, ttbr0_el1" : "=r" (ttbr0_el1));
+	asm volatile("mrs %0, tcr_el1" : "=r" (tcr_el1));
+	asm volatile("mrs %0, mair_el1" : "=r" (mair_el1));
+
+	t0sz = tcr_el1 & TCR_T0SZ_MASK;
+	phys_addr_size = tcr_el1 & TCR_PS_MASK;
+
+	log_debug("Saved context: TTBR0=0x%llx TCR=0x%llx MAIR=0x%llx\n",
+		  ttbr0_el1, tcr_el1, mair_el1);
+
+	icache_disable();
+	dcache_disable();
+
+	arm_smccc_smc(TZ_CONFIGURE_MILESTONE_SERVICE_ID,
+		      TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID,
+		      0, 0, QCOM_HYP_BOOT_TYPE_KVM,
+		      0, 0, 0, &res);
+
+	if (res.a0 != 0) {
+		log_err("Hypervisor configuration failed: 0x%lx\n", res.a0);
+		icache_enable();
+		dcache_enable();
+		return -EIO;
+	}
+
+	asm volatile("mrs %0, CurrentEL" : "=r" (current_el));
+	current_el = (current_el >> 2) & 0x3;
+
+	asm volatile("msr ttbr0_el1, %0" : : "r" (ttbr0_el1));
+	asm volatile("isb");
+
+	if (current_el != 2) {
+		log_debug("No EL2 transition, skipping TCR_EL2 config\n");
+		icache_enable();
+		dcache_enable();
+		log_warning("KVM hypervisor configuration failed\n");
+		return 0;
+	}
+
+	/* Read current TCR_EL2 and reconfigure it */
+	asm volatile("mrs %0, tcr_el2" : "=r" (tcr_el2));
+
+	tcr_el2 &= ~(TCR_T0SZ_MASK | (0x7UL << 16));
+	tcr_el2 |= t0sz | (phys_addr_size >> TCR_PS_SHIFT);
+
+	tcr_el2 &= ~TCR_SH_ORGN_IRGN_MASK;
+	tcr_el2 |= TCR_SH_INNER_SHAREABLE |
+		   TCR_ORGN_WRITE_BACK_ALLOC |
+		   TCR_IRGN_WRITE_BACK_ALLOC;
+
+	asm volatile("msr tcr_el2, %0" : : "r" (tcr_el2));
+	asm volatile("msr mair_el1, %0" : : "r" (mair_el1));
+	asm volatile("isb");
+
+	icache_enable();
+	dcache_enable();
+
+	log_info("KVM hypervisor configured\n");
+	return 0;
+}
+
+/**
+ * qcom_configure_gunyah_hypervisor() - Configure hypervisor for Gunyah mode
+ *
+ * Configures the hypervisor for standard Gunyah operation.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_configure_gunyah_hypervisor(void)
+{
+	struct arm_smccc_res res;
+
+	log_info("Configuring hypervisor for Gunyah mode\n");
+
+	arm_smccc_smc(TZ_INFO_IS_SVC_AVAILABLE_ID,
+		      TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID,
+		      TZ_CONFIGURE_MILESTONE_SERVICE_ID,
+		      0, 0, 0, 0, 0, &res);
+
+	if (res.a0 != 0) {
+		log_debug("Hypervisor milestone service not available (0x%lx)\n", res.a0);
+		return 0;
+	}
+
+	arm_smccc_smc(TZ_CONFIGURE_MILESTONE_SERVICE_ID,
+		      TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID,
+		      0, 0, QCOM_HYP_BOOT_TYPE_GUNYAH,
+		      0, 0, 0, &res);
+
+	if (res.a0 != 0) {
+		log_err("Hypervisor configuration failed: 0x%lx\n", res.a0);
+		return -EIO;
+	}
+
+	log_info("Gunyah hypervisor configured\n");
+	return 0;
+}
+
 #define KERNEL_COMP_SIZE	SZ_64M
arch/arm/mach-snapdragon/Kconfig #ifdef CONFIG_FASTBOOT_BUF_SIZE
 #define FASTBOOT_BUF_SIZE CONFIG_FASTBOOT_BUF_SIZE
@@ -570,6 +718,12 @@ int board_late_init(void)
 	qcom_late_init();
 
 	qcom_show_boot_source();
+
+	if (IS_ENABLED(CONFIG_QCOM_KVM_SUPPORT))
+		qcom_configure_kvm_hypervisor();
+	else
+		qcom_configure_gunyah_hypervisor();
+
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index b8bf574e8bb..a5d9dec6aa7 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -17,6 +17,37 @@ enum qcom_boot_source {
 
 extern enum qcom_boot_source qcom_boot_source;
 
+/* TrustZone SMC definitions */
+#define TZ_SYSCALL_CREATE_SMC_ID(o, s, f) \
+	((u32)((((o) & 0x3f) << 24) | (((s) & 0xff) << 8) | ((f) & 0xff)))
+
+#define TZ_OWNER_SIP				2
+#define TZ_SVC_BOOT				1
+#define TZ_SVC_INFO				6
+#define TZ_BOOT_CMD_KVM_MILESTONE		0x21
+#define TZ_INFO_IS_SVC_AVAILABLE_CMD		0x01
+
+#define TZ_CONFIGURE_MILESTONE_SERVICE_ID \
+	TZ_SYSCALL_CREATE_SMC_ID(TZ_OWNER_SIP, TZ_SVC_BOOT, TZ_BOOT_CMD_KVM_MILESTONE)
+#define TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID		0x23
+
+#define TZ_INFO_IS_SVC_AVAILABLE_ID \
+	TZ_SYSCALL_CREATE_SMC_ID(TZ_OWNER_SIP, TZ_SVC_INFO, TZ_INFO_IS_SVC_AVAILABLE_CMD)
+#define TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID		0x1
+
+/* Hypervisor boot types */
+#define QCOM_HYP_BOOT_TYPE_GUNYAH		0
+#define QCOM_HYP_BOOT_TYPE_KVM			1
+
+/* TCR_EL2 bit field definitions */
+#define TCR_T0SZ_MASK				0x1FUL
+#define TCR_PS_MASK				(0x7UL << 32)
+#define TCR_PS_SHIFT				16
+#define TCR_SH_ORGN_IRGN_MASK			0x3F00UL
+#define TCR_SH_INNER_SHAREABLE			(3UL << 12)
+#define TCR_ORGN_WRITE_BACK_ALLOC		BIT(10)
+#define TCR_IRGN_WRITE_BACK_ALLOC		BIT(8)
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
-- 
2.34.1

