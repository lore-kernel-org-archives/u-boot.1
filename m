Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E91C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 10:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D48286FE5;
	Mon,  6 Nov 2023 11:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="cqH9sxj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA4CA86C33; Mon,  6 Nov 2023 11:42:30 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6E586D7E
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 11:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so7173369a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 02:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1699267342; x=1699872142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=thMslcgBqaUAT1bAZ9aqrb+AnShN38KGLArHdPBpeXU=;
 b=cqH9sxj9cxjLjnT7CFIcm2TEb0dUrdqQS9c4TpaTjGyHlDdWp1wEn4UD+rFWbamjV/
 nhiuPc98tfOfqavYxknbcz7FXqE2r+Nh+hPo6kMyY9MrZyhNYWgBYvrlyML6adNjmFNq
 kuWNTzYQRHD6Q7MR9FJ/LABXoP8GCiCiydvWD6uYvuIFWMsvfuaFs2Ey5R8ClLmcgw2n
 K5aHIU0wntKtHcb2IIKuO6uF87Aap10PW88tGBY7FipW7QsJ8adVAmzjX1chqNMh8yuE
 vpJEoqCCcBp57uY3mYqxBJewOgwks3b9sdhYPNdJIXhL9qT+38IdnYRciDXYww7MUQ8m
 oIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267342; x=1699872142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thMslcgBqaUAT1bAZ9aqrb+AnShN38KGLArHdPBpeXU=;
 b=M6U89M1Bi1UTNRqDM4VW4sAKtQklVlugRA9omj2sZHF3lhQCo+QDqDrH/ujxcOq2c8
 uI9pZOPZ0fYyyJH3XoS3fHERnAsdPUnK93d/9ETPNJWfA3hHrKdmkK8G3plOnPK8R/X/
 BlVS8OpFT/3SqTv2tpXH2h9z7MCeHMoXUuzPJTxvZFafXMR/JUtkwn5hw1llXfyB8wwC
 oIKyc366kLhNJaJzAjPlzbQ5Hprl9b1mOXkte5mWfeF449oZ2GPziDu0SvT8o+sCzT9A
 NDCKHei0UqfxgIl979TYdiYG66e7jbaN6zJsUIBOvtXyDbcln+1uMfnAzC0VAC2hv6hy
 XMRQ==
X-Gm-Message-State: AOJu0YyiA3YPVaw9lprjx/S5v+K9tKs40/S6f/6GUTv1jC7wkIe+z0Te
 QljIMCTQRX4OeU7x24mI8xUgsZ0wFkJ5EARNVdpNSWgU
X-Google-Smtp-Source: AGHT+IHhrDa3IrfZxFrd2TjhcCKtPyum48rZp9aWtFQ64mCZ43TACBGg6dTABHXFyfdB5s1vOe5z6Q==
X-Received: by 2002:a17:907:7208:b0:9e1:21d:fdaa with SMTP id
 dr8-20020a170907720800b009e1021dfdaamr733875ejc.57.1699267341781; 
 Mon, 06 Nov 2023 02:42:21 -0800 (PST)
Received: from igor-thinkpad.local ([109.108.76.111])
 by smtp.gmail.com with ESMTPSA id
 qw23-20020a1709066a1700b009dd949b75c7sm3304181ejc.151.2023.11.06.02.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 02:42:20 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de,
	uboot-stm32@st-md-mailman.stormreply.com
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, Marek Vasut <marex@denx.de>
Subject: [PATCH v1] stm32mp1: read auth stats and boot_partition from tamp
Date: Mon,  6 Nov 2023 11:41:52 +0100
Message-Id: <20231106104152.140495-1-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Obtain from TAMP backup register information about image authorization
status and partition id used for booting. Store this info in
environmental variables ("boot_auth" and "boot_part" correspondingly).

Image authorization supported values:
0x0 - No authentication done
0x1 - Authentication done and failed
0x2 - Authentication done and succeeded

These values are stored to TAMP backup register by Trusted Firmware-A [1].

Testing:
STM32MP> print boot_part
boot_part=1
STM32MP> print boot_auth
boot_auth=2

[1] https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?h=refs/heads/integration&id=ab2b325c1ab895e626d4e11a9f26b9e7c968f8d8

Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Co-developed-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>

---

 arch/arm/mach-stm32mp/cpu.c                   | 23 +++++++++++++++++++
 arch/arm/mach-stm32mp/include/mach/stm32.h    |  4 ++++
 .../arm/mach-stm32mp/include/mach/sys_proto.h |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-stm32mp/cpu.c b/arch/arm/mach-stm32mp/cpu.c
index e07abbe21c1..ba5942848bd 100644
--- a/arch/arm/mach-stm32mp/cpu.c
+++ b/arch/arm/mach-stm32mp/cpu.c
@@ -40,6 +40,13 @@ u32 get_bootmode(void)
 		    TAMP_BOOT_MODE_SHIFT;
 }
 
+u32 get_bootauth(void)
+{
+	/* read boot auth status and partition from TAMP backup register */
+	return (readl(TAMP_BOOT_CONTEXT) & TAMP_BOOT_AUTH_MASK) >>
+		    TAMP_BOOT_AUTH_SHIFT;
+}
+
 /*
  * weak function overidde: set the DDR/SYSRAM executable before to enable the
  * MMU and configure DACR, for early early_enable_caches (SPL or pre-reloc)
@@ -371,8 +378,24 @@ __weak void stm32mp_misc_init(void)
 {
 }
 
+static int setup_boot_auth_info(void)
+{
+	char buf[10];
+	u32 bootauth = get_bootauth();
+
+	snprintf(buf, sizeof(buf), "%d", bootauth >> 4);
+	env_set("boot_auth", buf);
+
+	snprintf(buf, sizeof(buf), "%d", bootauth &
+		 (u32)TAMP_BOOT_PARTITION_MASK);
+	env_set("boot_part", buf);
+
+	return 0;
+}
+
 int arch_misc_init(void)
 {
+	setup_boot_auth_info();
 	setup_boot_mode();
 	setup_mac_address();
 	setup_serial_number();
diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 1cdc5e3b186..ac0deced67e 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -139,8 +139,12 @@ enum boot_device {
 
 #define TAMP_BOOT_MODE_MASK		GENMASK(15, 8)
 #define TAMP_BOOT_MODE_SHIFT		8
+#define TAMP_BOOT_AUTH_MASK		GENMASK(23, 16)
+#define TAMP_BOOT_AUTH_SHIFT		16
 #define TAMP_BOOT_DEVICE_MASK		GENMASK(7, 4)
 #define TAMP_BOOT_INSTANCE_MASK		GENMASK(3, 0)
+#define TAMP_BOOT_AUTH_ST_MASK		GENMASK(7, 4)
+#define TAMP_BOOT_PARTITION_MASK	GENMASK(3, 0)
 #define TAMP_BOOT_FORCED_MASK		GENMASK(7, 0)
 
 enum forced_boot_mode {
diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
index 83fb32a45fc..52aca1e23e1 100644
--- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
+++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
@@ -66,6 +66,9 @@ void get_soc_name(char name[SOC_NAME_SIZE]);
 /* return boot mode */
 u32 get_bootmode(void);
 
+/* return auth status and partition */
+u32 get_bootauth(void);
+
 int get_eth_nb(void);
 int setup_mac_address(void);
 
-- 
2.34.1

