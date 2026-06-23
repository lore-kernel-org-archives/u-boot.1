Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F81DCDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0391884A48;
	Tue, 23 Jun 2026 08:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFRAm6r6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZWUKY+OX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 582CD849BD; Tue, 23 Jun 2026 08:50:13 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A25800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6cV9Q3338247
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xdfSOcIzGPS
 u8j9o5OBt++H6uRJMd5Rz2nlh2od72sA=; b=dFRAm6r6x8nOzymp7s1Emv6i4+6
 s6qSL0lhqZJsHxo69k6HKoIr1Z0HReNbBHOeHjugcWz4oSy8d6feko0WHzJhZw6d
 BKwOkxjQIeiNOlsNF80m+zM0uCSs2EFN/wQ3ii3dGAkPhRMzbKeszjMTPhIHhZPb
 NCRGcfr5mZMm/VX7fZLR3YWr2BLywezgquQgTWf+2vrlerdH7nD6YMBq9pqFcWB1
 rdaapPqY9zEXbsu5hGTPMygJO25n5V1htEYjynhmZau1lcYm1hErivRZUjq39wU/
 JkevusFOlwSCtieTGUe8tb3QmPsoG9NbF2M5samhVAxCgUXH2EmFFJ5zcVQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjgy0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:50:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c892143db7fso3550978a12.1
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782197408; x=1782802208; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdfSOcIzGPSu8j9o5OBt++H6uRJMd5Rz2nlh2od72sA=;
 b=ZWUKY+OXuOM3txFcE1T2DBcoSUJZLE3GfrrebVntzBBe8OFAAdekwJFq+fLZxLmFWH
 WmZuTpQr33NpJOnK4aW/ONmZdexWtjZdeM7nY18lyvuviPVMJ3kZwk/UyhxsTv5vIY1T
 OUGM5q8qFn0RuNq0dih1F8PezSwpy2hslV53/YTom7qae7NGnjt0n4n0K3KAmAyvMjxg
 KOx8ox2LXYhy2apF3VsICIs8AdmzXM/UI5x6BvyBLM9g9z3hDOIVMV7Y5rb1vsSFLPaG
 NwxJJ8gwH2dW1SfinT4L/4APoeyszoWPvatPKnnJz5bvr5e/m3Y7shXKE5gLcXp31lPg
 WKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197408; x=1782802208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xdfSOcIzGPSu8j9o5OBt++H6uRJMd5Rz2nlh2od72sA=;
 b=sf5Zlp4WSh4Ljc6shbUf/pxoVLwviiPgLhO1FQQUDkWERmxjCor9dhsZGQMYUR++JE
 8rOMAn/HjK2hKlueYyfD1Wki5kdAr79zwcPOxOiShaOR7VJWIqXHUVcsLwyzTYlvTu1s
 /tju1L+zse2kpQ0uivv+5DZnDDryQ0544FKDPdZVTzlF4B8SvNbGM57YsZTePTEOYuOo
 YEmjVYE9tc4TcABDOdi2MHz+UCA7FqaBSEIJ1Mw83Zn4QS3EHtmJdGjNxtWijlPgiyQp
 z/uGNiYQF9JGnWj5sTrtIdrw8v/DuiVJRNI0N40r+vPNxXsF2twHnTNfP6Il24Y9dx6T
 4Kiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLhtkHaTZ30lto2LdsqA5Guv2oo0nYQ7gzeiEfwfy2XN0N9b+/yP0fTROVgxiz6pmxu0MgA5Q=@lists.denx.de
X-Gm-Message-State: AOJu0Ywqs4YoxaJN7HrOuNXzKFpfI9s8SNA6pC6xP1Gz5/h7Rp66W733
 AfsyLMvB0syr+I4Q45lrroQwbCU8JPpYPmFkiQhH4JhHZRTVgf7L+z3pNMoGxFKwBbB2tLfNeFd
 RDbAl78b1YllUMkGgGpkrrAqUFkaAe0raH+BgITVnNFXmmnXbFNJabvxN
X-Gm-Gg: AfdE7cnX7hTI/Tndq1JhUJNu8OG+rokFs1XOhrzHcR52+itR05EqnKtw2VxFaEJL0AY
 mcvo2QfrZivjPOEWpenyUFooLwHcKR/moioywyl/xXCLXKUqpUFltnd6jnHB6IVoRy9S8y9/10A
 gsl8N8GrHOaRs1nMk2LkfKv9B7ODsmdNbpfeef9g+8oxAUX1cEEYXurSdic/elAhoip9KsDLvas
 XbfRM5bE3tEh5PNyB47mTe2pKozOIoG6K4TA3uw6o8q1l327+93Nb7Tk/Eab58fVQwFVbGBsLiA
 Fy40pyhMhMPWNllyUKHQr3V/CkWk9PcpZ+Bsmc5PAduACQzi5u47DhVVcd+SmID/saWpwjuSGJQ
 GBqwSjwtkNOOQ1ZZL3bJh4FqSqt2wNmXHfZ/ACTyTh3xuunh4gzp2pKXCOfbAKPZdb3xGtf5Tzu
 54huCFRRYW5DzgCUGyR3PgiidzGzyxThifCgZVCLXb
X-Received: by 2002:a17:90b:33c8:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-37d15fb0ae4mr17770024a91.0.1782197407602; 
 Mon, 22 Jun 2026 23:50:07 -0700 (PDT)
X-Received: by 2002:a17:90b:33c8:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-37d15fb0ae4mr17769969a91.0.1782197407107; 
 Mon, 22 Jun 2026 23:50:07 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eede23esm8951704a91.2.2026.06.22.23.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 23:50:06 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v6 09/11] mach-snapdragon: Add commands to create wrapper ELF
Date: Tue, 23 Jun 2026 12:18:02 +0530
Message-Id: <20260623064804.3988799-10-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX/biPtIY5UQO7
 M7oa+76BdbzkDvqlhGlUE8R2s3jb9NPMxZ/Bvqfo6gIfRijTaMqr+nzI8D8z+LPBPLVK5gMxoEb
 Hz4tcsScAi3QXEJsZTfC1Kg60NoXK4YLnek6JtkPQCzphuL91sHKAD16jrtzANWFsGH8stzfKG0
 1WBXpm8wVCB5DDfhbEk+zD6m+3OPt0OEg4GTuKCSJHT41/P0bvq0m4jQ7HrIQaADxVisgGsduLs
 twUgyeF9fN8DkKIR3aJYf3KmyhS4DGS1ASdPaFdbwN1UpqH2MSNbKglhP1awGzBPO0/x7+8apUO
 tiCaVTYo3Nwcbdmoq1laao4Ll06fBn42maIZiYnIvH1nFjvS5wdbTOYWGpHvLv3qzJS+DZpQ7kb
 YTfNb4effibD+eDwImi4MSr1oyRKdHdmkGlUYYKlS/H7Two4XZ2fuSd3tijA+Mqtj8b7Rlh5Lti
 M8zhDYhyvxPWJpHuPpA==
X-Proofpoint-GUID: K9fHsq9fJtoyiDPJHahOC40LfYzaiigA
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a2ca0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=PX2gLaQeLxl2-ScWg4cA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX6ol1Q+9nlQ1u
 bHfRh5Pm+VvHB4UNo9tLuG7CfQU2B8gIuZQVGX/7VQ93qp+hZbF9LNBq+VcQz9jXkQbjSUaju2V
 tVyOGdESQ9134jONySoOJCrL56c4Q/U=
X-Proofpoint-ORIG-GUID: K9fHsq9fJtoyiDPJHahOC40LfYzaiigA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230053
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

