Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0021073CAE
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CAE0841FA;
	Wed,  8 Apr 2026 14:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NDDZs88W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vada1nGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E168838BB; Wed,  8 Apr 2026 11:13:23 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D148A80433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6387tiRv1259648
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 09:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XRn1dVngd6k
 nsCq3eqtR6vmOojnq1Q17wFnlvQgKTh8=; b=NDDZs88W/u/dbc5e/i1EOkrHnbQ
 wnkp795BtFZ60V5bkqdgaERo+GqtXRxOsrGZAYsjZAcET75QWZdK6UIhv4vhE0iT
 xLvJOjn0YSs8TtF6weG1Vm3JAT9ZcTLqn8Ulus4leHl4rIJWEI3BX8epPf9URghW
 ByKvUahXpcYA/D3ohrfSCI/WhCJQWjM1aMdcEeLsOcN1FwvfTnTRSP/bWQA3F09j
 8aLe+w43X/lSr07IkmMSg03sRyJ5CbpnhPfuDiVkxU+xBEsklnrILUZV+dUMNuOf
 ZJD17nlVCoLVCyYvYF2atEW6DN/Ftdq2LMJXMiNdBvQWwmWjP9Zfcswk3Hw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddbttst4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:13:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b242cbb97aso48403435ad.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775639598; x=1776244398; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRn1dVngd6knsCq3eqtR6vmOojnq1Q17wFnlvQgKTh8=;
 b=Vada1nGdBoG9QPxs5AjH4PsukKB2RkXgzCMnmnR8151MV6ZdTKHBSBieyytK48tMBM
 Xda53Q3ZK/E4FcQyRPWXdAIxCMQLZHGOFOJUEHdOOLMQVlu+tuzFz5B+rwcssn/KfQj1
 f5Z6V+fv+Q4oxdEed7BVA2Dt+ZYkshhNS61Lqbv4iCOAPCMy4DwUzgUnHVCo001hshpL
 r8FxDz5RM5l+2j1WRfEypUZVC41zoye77Aa2T7ciV4rA4TQgqB0O0JllvrudZA4h0YDQ
 LFV8JoWIFJdQKCicgizUvcVNnEGbAnTdsCNsX7lUrD64+bIDBzVdb98aFIkyz/JuZA1O
 uZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639598; x=1776244398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XRn1dVngd6knsCq3eqtR6vmOojnq1Q17wFnlvQgKTh8=;
 b=c0jOzDBq1kshHuvbSKdq2wphOhCltzU0dw2xJMSK6H1tdJuj/BY8qjZqA2WAmR2eg6
 UE0Ddvq1dWfd4GawEfhM7/is8BeN32V73SuexRPz1kZE+0FM7hI4lwa4BEGATXb4WBJ1
 Gf6DaG6/IsGqRJZB+37EscGyvgmV8t+ectyPkUs8rkdAdQqdZXTiCgsQm6EZHGxF312b
 Ts7HkH+c2jqJBCuIzfIP/PEv8dyPBs97uOxn+SdP3FAOTXa5T5sjvrAVIneeQbCJWlDS
 hgP0xH+UO/qJF2IqRjcn+1pJ1XfRG2l8BMDygtuJvf+9ZSVdxBB/ZpNK2bxb2M2NukjT
 Jv2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVzfnSHWTdMhpkyx9NDRhNsekF0U3ym82q7jUa1H6q4Wmv+i1B2dEFCHZ9KnLZkrtNMqS1SHo=@lists.denx.de
X-Gm-Message-State: AOJu0YymsNCmYNugEbF8XLaqwduXKPQqpPk+zufBL5bZYpnQyQgyVPa6
 LVYUj0kwWREvZgIVYKljhQoM474Ms1dt0ZMz2o3zc3bxLkL1eqwvEHfq4r9PfTbgZ6bh0qqeAg0
 rpfkIQQyMq7atVQ43Ldf/K7YiiZnd96NVjdqE71JAP4qlarZlo6eQAWnL
X-Gm-Gg: AeBDieviRXQ0QwhrQtNCmNmDZ9WPKEMrL5LVUDqOFf5Mele8TPfYwQbOoNR8jany5tP
 8Uz94/jGB5dgV/WpU+VT4SfLga8fi6e3ogC/3gelQgQ5jak/HXqtiTP3BGK9myGaGHeoG7C6J8a
 tmI1Zif+uGIEhoZrlurv9CXVdVsIC9eIJ2VNQ64fxb7g8LJuUyXC5bM43xVbIXd4Yz9KgvC4uKg
 CJ6jQrRhHg8Slbmy1r2whErMeDYsDxAUbIYQ8kjk5qSp8BDqiYazG5KwdfpmyiexSlOLroeIwrt
 9ej7diJnQVBBZ84KhAMakoK/nImef4I5z+dio7IYhyaqwLkhtLaLfdlGbLfvgmbjOsrH8WXDQ7y
 s1Jm99YIzIkap8rx4TKwP6/2g6xKNPAvO44K7WX/J4CrvgLa+EPbDbcLyI9zEIMszV0jPKP9DvO
 e4P7r37B4/4SSYILsW+pqtaZTz+4Huz1tW6ajXLrlkLpByaWNAFtk=
X-Received: by 2002:a17:903:4b2d:b0:2b2:4e5c:69a9 with SMTP id
 d9443c01a7336-2b281715f1amr216336255ad.5.1775639598215; 
 Wed, 08 Apr 2026 02:13:18 -0700 (PDT)
X-Received: by 2002:a17:903:4b2d:b0:2b2:4e5c:69a9 with SMTP id
 d9443c01a7336-2b281715f1amr216335765ad.5.1775639597717; 
 Wed, 08 Apr 2026 02:13:17 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm260020325ad.28.2026.04.08.02.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 02:13:17 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, anshuld@ti.com, tingting.meng@altera.com,
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, afd@ti.com, andre.przywara@arm.com,
 h-salunke@ti.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 dinesh.maniyam@altera.com, danila@jiaxyga.com, adrian@mainlining.org,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, miquel.raynal@bootlin.com,
 malysagreg@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: snlakshm@qti.qualcomm.com, gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 8/9] mach-snapdragon: Add commands to create wrapper ELF
Date: Wed,  8 Apr 2026 14:41:35 +0530
Message-Id: <20260408091136.2794546-9-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DQi8v_prpeyma3tnIbEEvEvx8tfPs_tS
X-Proofpoint-GUID: DQi8v_prpeyma3tnIbEEvEvx8tfPs_tS
X-Authority-Analysis: v=2.4 cv=TOt1jVla c=1 sm=1 tr=0 ts=69d61c2f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=2sQAHRQp2-iZZ35JgqsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MiBTYWx0ZWRfX6uq/72KhAHRg
 U72b8d3iDn8ce9pLbClafckXkdmF07Z8H0Bvqut4Yo7BrNMgrMtbzOFTy6OjQ7lTaepahIL/gpY
 88ew1EWlx55hymv5CmFJfcocFlxdmZ9UJXvgzyqIz6dSdZH53A2ztW+VG07g6UMgfP0pjksRLUu
 PmqO1SzKYjrNk/aRR1u9Ru1rmCZmOR0eT1+yAAD7d3zJEm7MVUkuUNoFyMxchxFhNAxguli88Da
 NBFFOu/DC/J5ZnsJnZx055/L23g4t3jHPh7IST6rRMSCj3Eq6K9mi0CPJqt5RjbHii6ubU1T7X+
 FJwQd8ZfO87rFUxLUdUhQqxh4BP4YRpqle367AMw6TNjZtQ8a4TxkCNWMMprYnkyghLtoBOsYB0
 VRUuGCnlAhv+NLqjqtMFEgtj+QsS1Es1OcK5IqGnu88n/du6N2l1jAWUqlsPVEd13c0ICySgXI8
 3eXDEoLnw80s8x5IhJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080082
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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
index 976c0e35fce..80efe20c370 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -45,4 +45,10 @@ config SYS_CONFIG_NAME
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
index 55aeac1038e..37e2b79299a 100644
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

