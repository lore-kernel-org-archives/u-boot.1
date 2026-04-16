Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D7FF8A16F
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA8F841D5;
	Thu, 16 Apr 2026 15:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWMjtYI3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDMRhzkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6C38407E; Thu, 16 Apr 2026 07:41:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9947C83C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FNshGf3733599
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gb2gLo7WyCC
 /6KhZSllF+g+CZk1pGt8ESd32KlyZ5M8=; b=YWMjtYI39rZRBcfcx5Y561cdFCi
 mSziuy7OiCehZSsURDRCF9ACQ9jYi1b7jCB8e9sIeXwe0XQZK1Qwzv3F9akoa6tC
 DFo3edPNReQLJLUv/vOXyZ/gFb/f+The44KIUm3BHZ5eBqiq0YiA6MLxcGmoEYAy
 dmEndkzIgEBFQj4JgSvfNMLJHI3nEQr6IW7EleFRmXiX/jDHuz9pjLZThIx0awtE
 w0r2Dj7MJOVGNPL1uorQ0pCg/wdmjIQkEf/CQZKEhu4yPJBGACI1SKxy7uV7KL9c
 aC554K5rQj+3qAcfKi4Z7Nn0aOL9yoq1R4l1fzhefcUHnEk8oxamhHAlptA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcqwjjhe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:41:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c792e2169adso2353520a12.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776318076; x=1776922876; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gb2gLo7WyCC/6KhZSllF+g+CZk1pGt8ESd32KlyZ5M8=;
 b=dDMRhzkkkY2TP9DBTY9s0u5KnTObz08yXKIF/YIMP6AkNtDALgU8nwiLfZHpZ0qNhE
 SmLYflSAxXg0pWjA9tgmVD6hjN5rJoc3U/Cy8foP4aBu/FSzoX0u7RrIxiyY/XFkvHd7
 IX5vzIgVioDei259oLGx3e8aW5lrfJ+IhLuke2cUbcKAwbkP98XYBLaNHyoDWTKlGswm
 KoN+AGczQE7yodge6Wz2GSSG4N66cLn74uT9H9wpanw8dDcMh0diW5scVPU1vatxfrw4
 GNZec8erKY+mFPSS/8e5R0scOglvZ12T4LL+wyejReiVAgiEj0dx55wojkR677E2RkO8
 SJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318076; x=1776922876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gb2gLo7WyCC/6KhZSllF+g+CZk1pGt8ESd32KlyZ5M8=;
 b=n5RT14NrrFaEuRNOzft8eLHxV5RRf+COTekTwsYCGbu9wl36muzG1kNOXGHJ9X0EBX
 d469irlGdSJUpcoCJbnQt6VGXZliKelKaOpbiHcm1jLF7eOjc9o4r1xtSSsFV22wAKhT
 Z7POLZgPu6xE+AuZ0woq7K46rhCKu/8hIu4o+F7QlTZzFi5nO6dW7aKm8kLFp6Zh+oQY
 JFAu5sRi6oNIf/RCZKM5lWdDiAAhqtr4G7rbHO4RMLuCZLHvdWYv2HB/OQiQSJlsMPEy
 LWlYw+yitOx0dGljZXXa5OIcSSJLQl31kwVvJHG2MB3IwgZFlSNoa6HbLcykdnpPL50e
 cc0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LL2mZiobxGwPRUw1AEa04XHbTSccNz4/0N6m1VgeEspONYpboEPI6gcUHZjJcihltWKHSUpI=@lists.denx.de
X-Gm-Message-State: AOJu0YwBt5wcbAbcoLEa9b6RAElWnka6tOW4LoscmdKbEjYkscvpxmO6
 chx+lYwPaMWRs1Lss831xRm7VH/F/Y3M/bv184pjc7X1lY/Xhbn2QpBQ2j9/7uZt4icZdrkENpA
 W4Cu+/F4oChQga45qgPmK6yYFsmNrGWPphZeotKTCqMPNj0grKMMnJTTb
X-Gm-Gg: AeBDieuIla0B0MI8ZJjsmyOUqv5el2rPKeGJGBZj1OAB1TN1HgHQ8mMWxF2P8bGHA15
 4J6O6+8GeFPcNwwCZxhiKM3equ+utnnZWH/Ubyqs93wOpNRl2RJhPsBU5Hgtq6XPDlv+MubGoAc
 6BevyX2fpdspbIjmL+GMG9ZVSYARKHOKmRB/3rcEeIvPLGV+Cc2fs90jyJ6iRK5DNcpo0C35qGo
 ERKttPQMdX6u4QdMIRJq7bkn8wyl5SXn77uYZTpri6VSlL9A39QltZzK+ClparimHiXRncWSSFa
 4+7VUo8RLU1wtg9aKtyjQ12fEInGWsQrV4I8HaXEEwv1674jmeN24nBLX/DkhPgSQEXM0ni3NPb
 szViFr4UF8D8bu0eUJJiewdF47UGTcd07Q1nP3AEPzQaa2YgElLFFJB8GwuAzcAV23TfPXYYPrE
 bSNaSo1igeIPJg7RRxdaT4FoBi0njMdFiLjgqUvxV7tkZmJq+Nhcw=
X-Received: by 2002:a05:6a00:4f0e:b0:82f:7c7e:b465 with SMTP id
 d2e1a72fcca58-82f7c7ebb5emr878127b3a.24.1776318075924; 
 Wed, 15 Apr 2026 22:41:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f0e:b0:82f:7c7e:b465 with SMTP id
 d2e1a72fcca58-82f7c7ebb5emr878076b3a.24.1776318075394; 
 Wed, 15 Apr 2026 22:41:15 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e3824sm3994496b3a.34.2026.04.15.22.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:41:15 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 08/10] mach-snapdragon: Add commands to create wrapper ELF
Date: Thu, 16 Apr 2026 11:09:26 +0530
Message-Id: <20260416053928.2834699-9-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3abDmOVSN635UtvRaL0LUlzQHOCdjeKf
X-Proofpoint-GUID: 3abDmOVSN635UtvRaL0LUlzQHOCdjeKf
X-Authority-Analysis: v=2.4 cv=XOIAjwhE c=1 sm=1 tr=0 ts=69e0767c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=PX2gLaQeLxl2-ScWg4cA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfX4FnnJZgltHjy
 Tcllb+D+l+2XvmYRyyx4vqGfsg3O6FuIv6fzdzpw72SPrMPtnEx58bSBgqV7zvtMzmxJoKVaZnk
 fQOWkUmuBQyGKZXFXJSA9NOuLZQWIUe8CDxRGrp0msUKnexS3G05TrQtTWyNNMwD7+G3GHy6Cpt
 AdVkyUlJhOzSCDn9RP2KRx+JcbPRugX3VyjPlgWKgnxlla6pPAqBsX2T5pQAxojHK1NNZH2gnxM
 Y2YtfODnkgAPNwZ9TLEJhx/m+US73k28KJPv5vmPkEsLnL8+3oEz0ckkx0YDfwcQ/zzS7gDWik8
 7senj2OMw8vQ9nHchchjdo2JGmv33E32sRFuVYNhWAxhgkbd7EbkFTqa21URoBht6OPKD27wR2y
 oyW/zZsF6PYIM3MIHEMrXKPrXtww/ekM8pMzZmHA35TtDv3rgil3t28mfJ9LIo3Dx8tt+Gs8BG6
 8WC6R1GrB2MDx1K1t0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160051
X-Mailman-Approved-At: Thu, 16 Apr 2026 15:16:28 +0200
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
v3: s/a image/an image/
    Add SPDX header to linker script
    Pre-process linker script to use IMAGE_TEXT_BASE instead of hard coding it
---
 arch/arm/mach-snapdragon/Kconfig              |  7 ++++++
 .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  | 18 ++++++++++++++
 scripts/Makefile.xpl                          | 24 +++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index d3de8693b5a..d94cb6206e8 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -42,4 +42,11 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config SPL_WRAPPER_ELF
+	bool "Create wrapper ELF for applicable platforms"
+	depends on SPL
+	help
+	  Some platforms embed the U-Boot SPL binary within an ELF as a segment.
+	  Additional tools are used to convert this ELF into an image that is
+	  usable for the boot ROM.
 endif
diff --git a/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
new file mode 100644
index 00000000000..5a582e65ca0
--- /dev/null
+++ b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = IMAGE_TEXT_BASE;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index c5ddf64c73f..930ca2c0e91 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -255,6 +255,26 @@ MKIMAGEFLAGS_boot.bin = -T zynqmpimage -R $(srctree)/$(CONFIG_BOOT_INIT_FILE) \
 	-n "$(shell cd $(srctree); readlink -f $(CONFIG_PMUFW_INIT_FILE))"
 endif
 
+ifeq ($(CONFIG_SPL_WRAPPER_ELF),y)
+# Convert ELF to object file
+OBJCOPYFLAGS_$(SPL_BIN).bin.o = -I binary -O elf64-littleaarch64
+
+# Wrap the object file inside a ELF
+QCOM_SPL_SOC = $(shell echo $(notdir "$(CONFIG_DEFAULT_DEVICE_TREE)") | cut -f1 -d-)
+QCOM_SPL_WRAP_LDS = $(srctree)/arch/arm/mach-snapdragon/$(QCOM_SPL_SOC)-spl-wrap-elf.lds
+LDFLAGS_$(SPL_BIN).wrap-elf = -T $(obj)/$(SPL_BIN).wrap-elf.lds
+
+$(obj)/$(SPL_BIN).wrap-elf.lds: $(QCOM_SPL_WRAP_LDS) FORCE
+	$(call if_changed_dep,cpp_lds)
+
+$(obj)/$(SPL_BIN).bin.o: $(obj)/$(SPL_BIN).bin $(obj)/$(SPL_BIN).wrap-elf.lds FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/$(SPL_BIN).wrap-elf: $(obj)/$(SPL_BIN).bin.o FORCE
+	$(call if_changed,ld)
+
+endif
+
 $(obj)/$(SPL_BIN)-align.bin: $(obj)/$(SPL_BIN).bin
 	@dd if=$< of=$@ conv=block,sync bs=4 2>/dev/null;
 
@@ -301,6 +321,10 @@ INPUTS-$(CONFIG_ARCH_ZYNQMP)	+= $(obj)/boot.bin
 
 INPUTS-$(CONFIG_ARCH_MEDIATEK)	+= $(obj)/u-boot-spl-mtk.bin
 
+ifeq ($(CONFIG_ARCH_SNAPDRAGON),y)
+INPUTS-$(CONFIG_SPL_WRAPPER_ELF) += spl/u-boot-spl.wrap-elf
+endif
+
 all:	$(INPUTS-y)
 
 quiet_cmd_cat = CAT     $@
-- 
2.34.1

