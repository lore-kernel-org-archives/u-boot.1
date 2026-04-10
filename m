Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF91F44852
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 12:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C7884220;
	Fri, 10 Apr 2026 14:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FRGfnzlW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y2qNi9Px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A5584106; Fri, 10 Apr 2026 11:13:50 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8E283DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A4NOFW2698253
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Zz1q/alc5mX
 BunuFaXKoF8w6Ij1gWBL0tUoQJrO8t8o=; b=FRGfnzlWlOZfxfQPxxYAoy6A4EV
 r2GT5aR157j/9iCWsZZW78Z+0ujIVGbsa7UdK/TQf2XP1QRzPZi9y2qXPIHAZUTm
 iHjtoThUi5jX923m6rFjyBEOzwM0DFpC+T+CMuceqFAjS7LzC8dHMzI2icA8XGd7
 /HQzsjduAb/3GK6DKJvqDHGWuLUjdmfHVsZB2Gfprf3ww0SDA8Ty/WaAPdfpYbT9
 aeGEiYF4eRuzmCi9ZlfBMG6y/rHGllWjZtNvaZyf3rxe0xMh1+Jh5txtm+2JuuiJ
 Sb/8kIYtzDLMloJe0v8PG6zmhp7vY+yyGahbCAZ2lO1EvrhlyumQXMjr83Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9tg42-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:13:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35da99b90f6so2293732a91.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775812426; x=1776417226; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zz1q/alc5mXBunuFaXKoF8w6Ij1gWBL0tUoQJrO8t8o=;
 b=Y2qNi9Pxh2OzxSCdhmopW+aFEKHBb031iTdhD8gJoitg16ooh3eDAxuEcMBgU2AzUr
 804Fhj/GoAF4HM/UrR81fDmV1k6al9//NHuO7yA4Q4aCkuztZr9ZlTC8epOXWQTJlNXh
 zMXBDdtCGkJE8sxx70BbCrCyDCqxaBm20CNqkHHLmdT5Y+6AwfmZQltU4KwMJO0aMI8l
 Q9wHb6tFuiVaalj6fxbAB1Uzukj7NWeUoTiRCzzvk2DDbm/x8D741CpNcaSZLFqGyhP2
 Dw+bFAjD67bQTkCqT5Y0c32bk3tHyLUiWbfn6Sp/FRlA91HWZ9PRQiwI5rQhKGNVH4yl
 IEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775812426; x=1776417226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zz1q/alc5mXBunuFaXKoF8w6Ij1gWBL0tUoQJrO8t8o=;
 b=DbGF1kf5f36INSj/oLCVWovq3fjoPSUMVwfRQp9XM7Kb4AQG8krIsgoEyLceme6NkM
 9chYzdZHmcMnpDxC6Dgc5woYTt3TF4kwyRsZGxtlmPiyOj5IXt6mP3E5z3iv6Kp1+Rez
 hwjzeVpWq3Pfw23SJTy4Rfqqw6A8e4Cdt9hlNrML2OA+hgzSjAQU4oV2hetM2qcTa/T0
 suZ30rDARoOTZtqRgTNt6XPIES8+9wbF61dW1/FBDs9auctgz1PlyECdzm5paDlTuZdt
 yuHxML1Hc/C6jkqxJCTYubv+UcizDG+Qa6A77N546myLZhJpwFIE3kJKb5h9gXOHmYzM
 QfJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9yMv9+9mtb5uTX1DKhLnJxXNnovcy4sD0cs0lQ8GRYsIqkgkPwIFKE2TFpbg17eJjsERz5ns=@lists.denx.de
X-Gm-Message-State: AOJu0YwdyOVpAWqclSjY4GgyIBudvUx7dElUdJlFqy/5hwEnoJCB2y4Z
 E+pVUPhAaR1aQLiJVwsvI4/ka9LliNUUCwCA06XrWdjjJY4K6eVeSeIt4gtsagp30fzTd1WI72d
 /SF+yONLZnxxdlVS5avv8jUdlWPv2yzhDAZBb+L6tQsp9yNUiSDUYEdQi
X-Gm-Gg: AeBDiet9uo7enAovEwbJIx7TSAOC/h1iO1zIph31pUCL5oVoZQq7OLEjJ57POKaumAf
 n3cSI4OtrQ6uNQEEyD/xVNxM32wYAdCUwL0Pf6v4t6i4Dk/gl5ZTMrBz0ewPxJwQmwFr64h8lnr
 yoDQrtqpA6pnoVQMPkqHdfvJuqRNRyY3O6hi9sSQw8hZmKTLYk1B4VDM2N2nUNMe5jqGYSAJwd/
 ZE6o9sjmRahxCSfxJ34TbURyaOuwMjuBdijzYeWOJYJebS1jNIoQOxaAsKrLnZRqhzk3JdZGMr7
 s2N08YcLzIsDnwga9gR5/bPJ2MBCFRC2MeRiA90fYY/thiTWGbbYuXaZ6RZVMvQUOzGmKaXEZDi
 AScXlUOoc8Y/h/LkytjXxYIV79Sh9lBtCedCmVHzNjQsfi+dPJVoIrZaNpKyhopXUSx93hj1Wd8
 ZN1wHstiGnytOuKZTEvbHawGwBxZ9V6cqdB0+6Hj5d+kajm8KCM2M=
X-Received: by 2002:a17:90a:d610:b0:35a:24f3:2c8e with SMTP id
 98e67ed59e1d1-35e4276eb1cmr2468912a91.9.1775812425914; 
 Fri, 10 Apr 2026 02:13:45 -0700 (PDT)
X-Received: by 2002:a17:90a:d610:b0:35a:24f3:2c8e with SMTP id
 98e67ed59e1d1-35e4276eb1cmr2468890a91.9.1775812425385; 
 Fri, 10 Apr 2026 02:13:45 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm2564871a91.8.2026.04.10.02.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:13:45 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, h-salunke@ti.com,
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 8/9] mach-snapdragon: Add commands to create wrapper ELF
Date: Fri, 10 Apr 2026 14:41:53 +0530
Message-Id: <20260410091154.1001021-9-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfX9EKHk/Zs6Kxv
 Xq5f5Nycd3hZROVk50mpoN7T6XKhobgeTVm/aIGaocjcaKX5cipuzwNkRyHXu/D/3gg8p95DS1b
 lZIxaWU5oW/tmEZYNhWEqvmcTk4EyPBToGVDmB6xRSbGvD9PN7xiVY7LF2dXkZR+CYrhuh4s/6S
 r9CP8Xlsn5rQJF4aD0g2Z68IejUL2PViCkxQFUTihTn5QzNG80FBg/4ft5Zhl4C1BMbTKB1CgGH
 JszHFCox9QSBbejgx9so7+G/Axn3tp6zgf3D6lILBOx9SeBXvxQtLvIGjPZbO63tirMkha6C4Cm
 b/RJAS3T4wcRIzk7hHafxK9zXjsLAm90x3fN63+uCg5vnAQ2px+ds0hpd4LNNjMwhg8x9UhM5iM
 v9ngjI4cKOPPsV7OaSXumSGydywXytk6cuIQZ1rp2PrB5BP7SBAetWFF2Uc3+HX7NeA4hjC+cFs
 MV8PhXWmxp1guu2nxvQ==
X-Proofpoint-ORIG-GUID: GiLSny773Hj2BJH-UM26fO9wetqn1Qhp
X-Proofpoint-GUID: GiLSny773Hj2BJH-UM26fO9wetqn1Qhp
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d8bf4b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=2sQAHRQp2-iZZ35JgqsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100081
X-Mailman-Approved-At: Fri, 10 Apr 2026 14:54:22 +0200
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

The IPQ5210 boot ROM expects the SPL binary image to be embedded within
an ELF along with additional binaries. Hence add the relevant commands
and linker script needed to convert u-boot-spl.bin to the expected
format.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              |  6 ++++++
 .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  | 14 +++++++++++++
 scripts/Makefile.xpl                          | 21 +++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index d3de8693b5a..378f891a6ac 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -42,4 +42,10 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config SPL_WRAPPER_ELF
+	bool "Create wrapper ELF for applicable platforms"
+	help
+	  Some platforms embed the U-Boot SPL binary within an ELF as a
+	  segment. Additional tools are used to convert this ELF into a
+	  image that is usable for the boot ROM.
 endif
diff --git a/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
new file mode 100644
index 00000000000..d13a7e41c29
--- /dev/null
+++ b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
@@ -0,0 +1,14 @@
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = 0x8c24000;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index c5ddf64c73f..15dee45053e 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -255,6 +255,23 @@ MKIMAGEFLAGS_boot.bin = -T zynqmpimage -R $(srctree)/$(CONFIG_BOOT_INIT_FILE) \
 	-n "$(shell cd $(srctree); readlink -f $(CONFIG_PMUFW_INIT_FILE))"
 endif
 
+ifeq ($(CONFIG_SPL_WRAPPER_ELF),y)
+# Convert ELF to object file
+OBJCOPYFLAGS_$(SPL_BIN).bin.o = -I binary -O elf64-littleaarch64
+
+$(obj)/$(SPL_BIN).bin.o: $(obj)/$(SPL_BIN).bin FORCE
+	$(call if_changed,objcopy)
+
+# Wrap the object file inside a ELF
+QCOM_SPL_SOC = $(shell echo $(notdir "$(CONFIG_DEFAULT_DEVICE_TREE)") | cut -f1 -d-)
+QCOM_SPL_WRAP_LDS = $(srctree)/arch/arm/mach-snapdragon/$(QCOM_SPL_SOC)-spl-wrap-elf.lds
+LDFLAGS_$(SPL_BIN).wrap-elf = -T $(QCOM_SPL_WRAP_LDS)
+
+$(obj)/$(SPL_BIN).wrap-elf: $(obj)/$(SPL_BIN).bin.o FORCE
+	$(call if_changed,ld)
+
+endif
+
 $(obj)/$(SPL_BIN)-align.bin: $(obj)/$(SPL_BIN).bin
 	@dd if=$< of=$@ conv=block,sync bs=4 2>/dev/null;
 
@@ -301,6 +318,10 @@ INPUTS-$(CONFIG_ARCH_ZYNQMP)	+= $(obj)/boot.bin
 
 INPUTS-$(CONFIG_ARCH_MEDIATEK)	+= $(obj)/u-boot-spl-mtk.bin
 
+ifeq ($(CONFIG_ARCH_SNAPDRAGON),y)
+INPUTS-$(CONFIG_SPL_WRAPPER_ELF) += spl/u-boot-spl.wrap-elf
+endif
+
 all:	$(INPUTS-y)
 
 quiet_cmd_cat = CAT     $@
-- 
2.34.1

