Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E85CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D824B84928;
	Thu,  4 Jun 2026 14:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A/CRyvFZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XiToPNiM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 829F28486D; Thu,  4 Jun 2026 11:33:59 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF9184868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6546L2Bi3242345
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xdfSOcIzGPS
 u8j9o5OBt++H6uRJMd5Rz2nlh2od72sA=; b=A/CRyvFZ+3qNmnVFj8YxdLaKi+I
 hy3RjmV119JadYZ1DXVnHR9JKYr+zsrodaySkGGt/892CS1UTSWVtZLK1871BYUA
 o2l4cZEit0QwUZ9G7HDh1P6LPdkSd+w2aljwsCB8jHjXqo/zSdA2GBiL1TM8AfLa
 rI71+qu98AZID2RoOUPYfEakukceKMevalQpH306ncsmI0Lvb0c1hHCdXN1U3U9i
 V3jSHK8PcnkkrFzA1qsq52/qPyDJUQNnW/CaCy6ElqHBRhDepOCH3euCD7eKa5Mr
 47wtlJ2NSmOj5r9lfZDiMkj89Gcgur5lo4wWv2/iPSqjBWFx+iidoMfR9gw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejvd0a7b1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:33:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c857ebbb0easo1023809a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565635; x=1781170435; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdfSOcIzGPSu8j9o5OBt++H6uRJMd5Rz2nlh2od72sA=;
 b=XiToPNiM8WjawH2AUnZGc07LHbkBmZTUsLs6jiHH7NXOWOas8AhruNL6kAa8fH0cv6
 3Af4Ro8dDv0tf+w7cPKcZOViAzZNfcVOUGMj9PcKeIsmzWRBqsranlozEx5kqB0iY4ou
 xRcybrQiF1WFUawjf0fyTbKuaqUDGW74H+uhqah/CaOizn6kV3GAIo5ed8V5qkosQkE7
 2DfpMeujOYClrNUGVztsENo3MQ3Xx+kVgO+11s0b49dVVJh2aErunJRLZ2GWG6iwcXzE
 q4K++FdJ5noVfgIMVR1mFCo4HeGWk28UhrlFcbn/kPJREP9g8Dd3Gdpj53G2cWUjp7H1
 8B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565635; x=1781170435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xdfSOcIzGPSu8j9o5OBt++H6uRJMd5Rz2nlh2od72sA=;
 b=pbMNAC+uVU/ZbARWcZISmv8MMptjJYxVge7cu118LW05MwZOHCt/SCVQNdvZVEB1Ul
 hxcKxBRTK7jasCzqTsQUceOLpADKlnyIcFrewi53QdUC71GecstfDC8Fjtgeb+Ws9c4L
 HnAQGnuct0wKegQuvv8ZupXjUXR8efV37baf106fIkQRVyIVW/6gR2ZKOOhb+PBlx5eM
 xVPvpC5mlZ3ZSvtnISzK1WB1ReHjOvGiTozXrx7FSml7rNYYVaYy1lSu+iRvosuODyil
 7ttXC57rCkKQYx1TL4igbSmsPu5yorAGHm92UuGiZPH72QjJfkxzVGzrMHlLhy2zlSmU
 0OXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bnqzdKOGCQLR9h70DC+bxNYdK+JXiRn9Ck18pF83qZ+YJzTqSNveHls+v1S69XsETGhJiv2E=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1D221A4jrD4ZR1V+jwGLR9WmcMz39YnUnO/V7EHPG2t3D56Kd
 9hBAXjnlh7WQPe65S/GT/58PNOHY1a3QoNFqTLBmoRN65H5TG7XakOtF0c7opLA45Wr3yMOdxu8
 xN0wg9d2PKEq9WbFEo8Le3zJvy+xeNhWOBuZaPsGgyBnaLusXJWYSzz7s
X-Gm-Gg: Acq92OHye6TPDHdkGfyTfbADYeDfLb9Nu0vh7mxJGZ/dew9eOJO18wWCNU0C56osUbH
 1PvYtNZQLGJMtCFlkjhrG9RcTwpHJVE/R+QuCt6PDP1EZVzJst5/xYNqZ7OyFxfo4MIfjiLfsc6
 rrouEuA6k3SE8469dZUds1KzVDwkSM7du1ixDsWZ9L0hRFib8X6DPBfxNNPLVz9YxVxkBwTSlh4
 lzeclScMOZ+SVaD2WOVMldUbzS9ngh0wWc0bcDp7QgwsKYUAn/PgS/OyoP2LONTGSRikO5iy33w
 +0Nt0dACRjqU/rRqyJ19Y7aMLODgWn77lxDH1sI2p+1LVfzEkwoRv6cJEa9o0ud1pvnjq1vqaHk
 idXtGxtqvG4fzF9GmwF6qkk4GaysGwisdkMv+jmvALlAPDfrbTNkKTj1r3jw7S7aiNgqvohulPY
 NPkA9GguiAl6ITeMyWoHcTJCGfmv0GWMsO5z5OPb021/rBzi+c2dP3sAUcGw8/Ow==
X-Received: by 2002:a05:6a21:7e02:b0:3b3:e4d:5071 with SMTP id
 adf61e73a8af0-3b4b1a1e330mr2164839637.0.1780565634854; 
 Thu, 04 Jun 2026 02:33:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:7e02:b0:3b3:e4d:5071 with SMTP id
 adf61e73a8af0-3b4b1a1e330mr2164727637.0.1780565631606; 
 Thu, 04 Jun 2026 02:33:51 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:33:51 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 11/13] mach-snapdragon: Add commands to create wrapper ELF
Date: Thu,  4 Jun 2026 15:01:30 +0530
Message-Id: <20260604093132.757583-12-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hqNLgp576t0QBqbZYOx_tXf6iTLwJY7k
X-Authority-Analysis: v=2.4 cv=M8h97Sws c=1 sm=1 tr=0 ts=6a214683 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=PX2gLaQeLxl2-ScWg4cA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: hqNLgp576t0QBqbZYOx_tXf6iTLwJY7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX5GAgTOC7KZB2
 FB1O3Anq7cJrczAo+WkD9bo8StFK8uhAhD+tCkyu+niR6gdaKt8GjASjbMtYGEG9Cy4vdeSCMNV
 t4qgVadlRnzWAgzpy/8T4egH1Wm1E5oCbOcdmaP2/5autP8Zog0BYB3oBM4QWKfj7yfZTvAGPCo
 KmIAXRCy4zZYMUZqeMmj/8606oyAN93gBerHTpjz2xafBnGK3vq2I6AAEWCEBCHZbT4owmsdB8G
 AV0VchQgU14n+gFv4vT7Lq7VvSTHji8UDD5eLfWOSZecWonorBvCygfNgq9KqnvJOFf2BtxgXu4
 X/2QGZCdPevsQKt8rCWiS/rleSjOUbpWg4da2Cl6AvtovSL1lMvo1HfdwKGD33mpx3zSOh7byy5
 JRotWZBwp2uK5JwdbGkepDkgcZpGkB+wo/Ge8mnFVjgmctn4NoZhm9sZgJ0kVTO3BnY6wXGajTi
 eyVOqeO5OB+QD090a0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

