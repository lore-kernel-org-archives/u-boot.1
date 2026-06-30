Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F5CC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961F684B49;
	Tue, 30 Jun 2026 14:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GvjLxALE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1lhmAbk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD09849FB; Tue, 30 Jun 2026 10:10:45 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BA984857
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CadD1056728
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RljcQ2DJGs5xE7DPWuQaSkwJCoTVCB1S+Obcets6Qds=; b=GvjLxALE96h1sSiF
 OBI7wGYBpP5jq8CzPd3h4jqheEZ0IlrweO55D81FAqBCKncbFP2xgLF1FOyxr2NO
 7NuNMwEX8+NXy5opjjKX5DVCAhAptz5hXxFunxSfR3RZgcUygBLi9yyVRkBP4mfj
 9CBV0SWhK/TZBehHrcq824gbWKpAV7S4BNMFRSsORCOdAoQkzIAjFU+9Q1K5CEOD
 qIgcEH7jcbBK/u7kfiJ7A7uMXyJpkACH2W9Q9O/AITLo7n1LWeHTRmrEXXlfVXYQ
 b7EqTFdb4IkRlxs20rmVk3dox7rlEynQ8itahl/uucFMuB/LNeYUkmiADAywYMnr
 WypSvg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f46861146-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:10:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4958121eec.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782807041; x=1783411841; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RljcQ2DJGs5xE7DPWuQaSkwJCoTVCB1S+Obcets6Qds=;
 b=j1lhmAbki1k3UfvEVhn90JQVhbkSOdT1Wcr+Wkv3P5o8yP6zDKTB+2BSqMEf5RDBAK
 7RotAGiTiaXyEk/qbQsB20nSos5bDegyOjnMDV5ZqQPBe4SbansaaRKgri4IdqQfXHgP
 3Q8LLHP53I610CjDpiibWu1KLV2f3c1AbPPTQnpSIhtn1TI1YI8FC0BihAQhhlgVVGJ4
 +nbQngcD7lAEeYzETKJHOHwqBgDxBVogdysnocyDrbX/v+kfJEoTd5dQ2DtrONxgIuCp
 v0dAZEV8tzR4BjXIZjl1zmNLge9Qine4U9+2ksSohX7FbNs9Kj7MWeplLoZwh+VvZnYf
 HrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807041; x=1783411841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RljcQ2DJGs5xE7DPWuQaSkwJCoTVCB1S+Obcets6Qds=;
 b=kDAZQa1hQixGgianMA2zEF+7jtEaKxpHvk6TKtAa3NyEjrHz6cm6TtGTbH14nw8En+
 4um8TD8rLOntC4sK5hXgj0kA2Q1bnCAPlVFTw9mPYCs8h69kVAdnh7UrcETNMZRUNbvy
 mlBNO3vUZMMVOcaVfJq8zg3eDo4cQo976f91QT5PO6qRUfEmveHnd6/x9qodWQZxXWo9
 ah2+45gnE+8JU07WKLtznvC68XL4QxKoLNqh+L9aZxWAPXtKw/JRKrbIEdX9FRrt6GDO
 CsO56twjwx74IsS3ZohnGFrhquWAGxpt9CsX18KcnxJKDlhwTt0dtaEArbNwiA3T5X5I
 Vc6g==
X-Gm-Message-State: AOJu0YzpQUtDC72zFJ/cWf81qePtgtieY4cu+PuDfhuCY7k+3nyJe4Pw
 TU+HgffcP5W679ZW71zQdNINVIE2UYGCObnKqkKtwsCVVh9PXTcikhY0xjjF9ADEHL66pKQr0ZF
 yLeYgxrmiYt0rc3KWnbvaTyr5L7/XgurLvvaKp4Q/gZMADaZ++U55EkU5
X-Gm-Gg: AfdE7cm9OF6BDxCr3+2KS4n5JnBzAoOKjK+x5KBMtW+i6yYDO+wNVaVaIhGLpdhiPE8
 4d+Dfy7jbO7BlJoUZDgASgmL+eNV41ve09KFmb2hXtO7X0y/jxjmBJjBmXGMbRe0h+YD0RjsKpa
 ad+knRoZCFXLxfjQmLpPsD4eanbEhonZW4BHiat/tYxSfhnNVvFYhetrtC6HrW/rHpsmq1jxtIy
 hwwJo5bYa5siS+ioeZBaUNpKnJzroD9/5+fC93SGkIlnGaZCIINFuoJMlVXqNRcT5wExACFDiIx
 SrNVD74/JGGcNYKpZ6++s0UI/P66S5yjJAU6LL0xoUSDODOC3b+ZQranj0T/kqe+gRUKcBtzw4G
 IIhmLyxfISddBPwYa71pCJXvQJ1jsLI6skfqUPyJqrzP6lHKbkMzwu6fWwsYOejOHL5gt9hNAKB
 1VwQFo/j1ktjnm9+P4IbWNpCEB0rQ8BCGvp5YU+dTf
X-Received: by 2002:a05:7300:6405:b0:30e:cef2:c3a5 with SMTP id
 5a478bee46e88-30ee11ad7dfmr1941685eec.2.1782807040501; 
 Tue, 30 Jun 2026 01:10:40 -0700 (PDT)
X-Received: by 2002:a05:7300:6405:b0:30e:cef2:c3a5 with SMTP id
 5a478bee46e88-30ee11ad7dfmr1941641eec.2.1782807040010; 
 Tue, 30 Jun 2026 01:10:40 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3264f52sm5415816eec.28.2026.06.30.01.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:10:39 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:38:31 +0530
Subject: [PATCH v7 09/11] mach-snapdragon: Add commands to create wrapper ELF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-edl-v7-9-1dcb0d2a347c@oss.qualcomm.com>
References: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
In-Reply-To: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: VObNL_QDmIOMIJNRUYod9-te-SnqNgpi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX5cTvEYdljxoK
 HQ+/bITG3z2LbDMTOHt6PMFRGgZ8Drw8nk1v+yzAB5pwyGY5C3ioijK7o0S2J7GFZTAcE86y7dx
 ZsPUmYvsz9SnRMbINsROhHcK7MjFpxxxWuwfvTRrAK+AMw2RL/7EvtWyAkoXUL0dSNaJrPcRlhe
 sEG4K4fDWNAr4jbq7WsbHaHR86WOC4u8l3Cwe2GmiMUUk6OV+3jMLJt4AN9ttxBlZCe5bJy0fVG
 CYf44xsLCACxcZP/SD6F2K2M3g4QjxhzwWsP1duhZgJMbpg3u5+ygB5XLpStAosL586DOOYkPDZ
 2nRNG5mfxNaCKh0Qgkg1SGMs9HMmkmDl4Q9fbUehAvZJ9hGJcVwA6a6KOKi62DhRhXBNSzINmuS
 z4BxXJRlgv8gChWwGLiviqO+5i4moWYNGYv0FqifumdCJfSzVHBxYXFGkjXp52FfqUVjf3oQLQm
 qNn0H5MJa+8LZM/e0fg==
X-Proofpoint-GUID: VObNL_QDmIOMIJNRUYod9-te-SnqNgpi
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a437a01 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=PX2gLaQeLxl2-ScWg4cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfXx2dJCQZu0xrs
 m71C4D0oFqtAa+ooP67Fx4kaY+Ai6tZcQCWYABoTRdc2R2wUDp8UZ+k2WTmdPzcrjwNz79tXDMh
 YspaVaqhezT9qka4yX9GYcWH0by+vqo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig                  |  7 +++++++
 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds | 18 +++++++++++++++++
 scripts/Makefile.xpl                              | 24 +++++++++++++++++++++++
 3 files changed, 49 insertions(+)

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

