Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D7BCD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B9BD84A30;
	Wed, 17 Jun 2026 14:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QuBB7nDU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K5gKGsXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED9B841F2; Wed, 17 Jun 2026 12:20:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93420838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UT2d1703416
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xdfSOcIzGPS
 u8j9o5OBt++H6uRJMd5Rz2nlh2od72sA=; b=QuBB7nDUydJHiFaOaV38aXfcyEM
 0m03t43c0NqjpeK2cMSMiOUWkRd5P2Az74rgOptZsuxgX/z4njFROrQoy2s0wNvg
 tBepEB9LG2PRoTS/6o5iz+xoW9hIQfzTV0VV7L8eaXqmTfsJ3Q324ZkgMu6u8aOX
 qfwlvsnAbh5/x1cBaOAyDdicDAp8vv5BCg044aXvvDj8KSKpWVzbUgfuFmRjRhKO
 5Oh7yk4IKINtiqYoQDlpw7qSHLh00Tc7nCjd6JTjLSAHat/Bq2Zo1pkt8jfhe22u
 6VQDBw1bAVHl8ICp8Zzdjkv6wXLFU0bXFKOqhV9Z1ncd33no9J/VhWi9pTQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueet2j5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8428384f31fso4302656b3a.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691635; x=1782296435; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdfSOcIzGPSu8j9o5OBt++H6uRJMd5Rz2nlh2od72sA=;
 b=K5gKGsXuVIX0g1Afs/peVqu2jRs58BNuvHQrBmAecseB2PAv1HXBOIEz/9wv5z4zNm
 A4jLkbObCuwe0ZuK+O0Ka2F4f0iKNUKsgV04XpDR3Te2MhWBzZs0yFkx0DumBgZubqf3
 zM5Q7HXJlBY3gkEmRdN9DykmeLdKqZeHFfelS02QCvcy1ddp+r8N5+sobklFWitmGBCY
 KPk9NKI0arVa8sNGVPpbaBnBNGmvIRYG0yFjxnMKCLJwzxn+QD2UXZF3YvX+TbOgDdt/
 0EKnE3wbHcl8RpMjZl2oc3K/5aCw7uyN5SRp8mPwhBHMlh5he5WiAI3k1hkg4Cd6KKV6
 zhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691635; x=1782296435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xdfSOcIzGPSu8j9o5OBt++H6uRJMd5Rz2nlh2od72sA=;
 b=UtXzCU0SFq+PmtqKPNUNPcqVwD5J8CwQNP1s0q7aoYeWEt0g7NtGP4jZpWsq0P7kg/
 QSTFSt0qbycyviTcF9QGgVAYxH3Qwk2Pz/a1Zac4VzJohfS5qg3Aqe05BHQAi+nChiAW
 PKcSLfXNOCxm6EVuLvcYHvEUWC0ToWa1tFa/aMs29IgSqinJAYKiyncUJ+4YxpLbxZD1
 iyAsEKKk4E4q9gcqttKK0YgKpuehQZuY1fjm8i0VX0wrXLpPuqJl4G3Qro5LOUou4V9l
 2iLb+UqhmhkiWZTgTmeZuQCeeln9sfk8Mw83jDYkj23cqYw8yVqwo2FD0DN7nNIlDTmt
 SG1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pCkqhVYamM2/HFQxnwv0mO3GDNlHJX/Fk91yi/B72tmRPd2XVZ9R5zBsY6M1niG/6rQUTDfk=@lists.denx.de
X-Gm-Message-State: AOJu0YyxHJrVIPS61dvuyZ2BpjT3H/zXyRy1ocizpxzD0wHLwaubdYNO
 ECIzCGKp+oCuFWMR5uXIV40dih3ptIeuN5qBdBBjmMrWmcqq75OczfKqQisCW/q2ClgduDsm3xg
 T4q8EwDYI9VQwX2VoK5On5U9qadr0CG4+dyOfnsMsOZ5r+QwxqHNqRmrv
X-Gm-Gg: Acq92OFQqiU21kyEeM36xMSt3M5JQQDc8Unohb/eHvHFTE76FIb7seNGH6J3bQxOJC6
 w4PxlvAnAflZ580jMhDxSWxFolUVZ7Rj/pUAsYtONqiE2lZzyZAs5eEKwMucj6lryIJBoridJ6M
 72Brr5DelLr1+/FG3LslkQ/M/RpO5va97OrN1sVXgiD0HYCU1Xr3qk4C/tgZI709rvVtxgNHkzL
 k0SIA4ynF9XfG/kFIE5DPpbQmqWsINOaHJsMz99Bq8co5Jm/483z6gqvLsg1E8jnlUo66f75BFe
 q5pStTu4F8W5m2ZgjfbGClWLfgU9IW70UwQV6qEWet1DaaNiilecCcvaPfPCOXgfujE3FmW9wsp
 fG9K/3BZgG8yU8HrkTqqqWyeRBJqRXuoWr9NllWgkbmEk63yQFlWjUy6psH1+aWY8FZWlhm8Hqp
 8Txo+Upe0SVmtcKXYlqW+7uyNACh7kFIrc/mK9PhO6
X-Received: by 2002:a05:6a00:10d2:b0:842:7e6f:f487 with SMTP id
 d2e1a72fcca58-8452445b595mr3175243b3a.15.1781691635036; 
 Wed, 17 Jun 2026 03:20:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:10d2:b0:842:7e6f:f487 with SMTP id
 d2e1a72fcca58-8452445b595mr3175188b3a.15.1781691634566; 
 Wed, 17 Jun 2026 03:20:34 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:20:34 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 11/13] mach-snapdragon: Add commands to create wrapper ELF
Date: Wed, 17 Jun 2026 15:48:10 +0530
Message-Id: <20260617101812.299586-12-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kd9pSCyEaKZ-JRv7--kac2g3L7Fv5u9Y
X-Authority-Analysis: v=2.4 cv=JufBas4C c=1 sm=1 tr=0 ts=6a3274f3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=PX2gLaQeLxl2-ScWg4cA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: kd9pSCyEaKZ-JRv7--kac2g3L7Fv5u9Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX8axWrD4TYdtH
 WDM7dOF4uqNDGjvCYibbJcQJ0juL4R0SomDKZE8hx0HW3eLOIgn/nEafJF0PwWOpjR7Zd4B2N8D
 mCwqfxa4vjjkvPXNVs2cdoXIlbEHDNXFukuSWKveBadD5OKmU4UYE+ROJm69sOFAtAarKbFIfUz
 eCbcDBOQApTuDKRP8/hEDEmGQ/5F/vkxlzrGsWJzIT2la/vcEkyjFFMRKnI1vyXx5Ym2emm9bPw
 u5Wckq6M+G3sEzCdHqu0XSAi0qGGT650QkLBFUV9ggtZAiGtiAhK06rvC6Ow+eDik++LSvAio3P
 OHv9ULlhms4JiOZslsTE4QHirWvkP0xjiKncP2bLDZiEaDJsljT8YKIGY3bk6/iMhJQhNjlTv+e
 n1BtKAQDjfVNH6KgcX1SgDWn8Imc8d8/MfYZjgaFkIeAnJYZ6uUoFxDL+04w3jPzUqVyi1P9hkz
 49pKhzdKLT5wXIJoylw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX+PqTkh1Cmy7o
 TYW5mxtizJHtH0Xq/RP+5+7+H9SJqm+5V13xGg2/+V+xh1HlJ421Q2JB65bo/g8bixJxh+EIJGx
 w1zq351r4WfBn3Ye7Vioty8fHkS9k3g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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
v4: Use $(obj) for u-boot-spl.wrap-elf

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
index a3fd3e1375f..6e9f24b748a 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -256,6 +256,26 @@ MKIMAGEFLAGS_boot.bin = -T zynqmpimage -R $(srctree)/$(CONFIG_BOOT_INIT_FILE) \
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
 	@dd if=$< of=$@ conv=sync bs=4 2>/dev/null;
 
@@ -302,6 +322,10 @@ INPUTS-$(CONFIG_ARCH_ZYNQMP)	+= $(obj)/boot.bin
 
 INPUTS-$(CONFIG_ARCH_MEDIATEK)	+= $(obj)/u-boot-spl-mtk.bin
 
+ifeq ($(CONFIG_ARCH_SNAPDRAGON),y)
+INPUTS-$(CONFIG_SPL_WRAPPER_ELF) += $(obj)/u-boot-spl.wrap-elf
+endif
+
 all:	$(INPUTS-y)
 
 quiet_cmd_cat = CAT     $@
-- 
2.34.1

