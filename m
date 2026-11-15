Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620D606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ekY8Rm5i
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AE776074D;
	Sun, 15 Nov 2026 16:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id saG8t3J0TiVp; Sun, 15 Nov 2026 16:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3F34607B9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794758574;
	b=QRO9HuqJtxX3cZfhLpNnBZLJQMPEXosMHkiTYSRzlb7l6G/z4SXaH9+Zh2jDGEuQMtPY
	 HgAHNUOU7gpCxFYMunTjsBO85cvAUfIsb+McpUcGM/4x1N60LWntziWghagsxnljp9F0c
	 Zg2Y/fWsa49FRHIaxRQ/DIgDp/tZS33jOmFeUFM5ZN4ZKiLkP1ytJkSHPI9Nqu8F+Svrt
	 T7/wgarVOdxkuCqAfzDM6Yp9QaOOwbqZccpcICEubed52nUpU+KN/3PFw7ApTaHUCSsbI
	 ITmpkHCT7tnkI7nTgP+GId8TAUdgQhOkSauu/MAKj2Zx4ZWHsyq7HHA3TkZc5JcX3oA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794758574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-QQ-mid:
	 X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PSTSdzhz455UCgbC82z2rOQGLGOoFUFJT0SL0NFeZE4=;
	b=npYJDLbxPI8p05s/azdDsq6oP8eQhKUoxB+5/AHz8Df7FAkAwy1nWG5UWAIr+SknuLIp
	 ZMs/G6yfGuo7f0Kgd13hDkN+aEjn6rPPTbxY1KpSuvi17TBICYXPVMcxeLYShwGKPfbsq
	 vfSjj8FzBMzRj0vmcotvVlLcjW/fUvh/buFOqi3PYPvde1buuietANpfhW814uzyMip7m
	 0NAYXM2ua30mnOSvXLPn3/dgLic7x2rbtT1p2yFe7VPMR4ZnT9+6KDmnut6CiEi8qN578
	 jmy7vX+Fa7+e4R2PMWxUVkU72b5STj56WmX5Qa2ewVVlK99U0Jmd16ZHeBLV04ghmlw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794758574;
	bh=PSTSdzhz455UCgbC82z2rOQGLGOoFUFJT0SL0NFeZE4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ekY8Rm5iOZx6uxd/G/ne536vy0gFZ8kn4eIkUn9bj1rc7IfCZy6u0ZLfrTJiu5xq1
	 F95pZ/+by+VmcOIvOcxxrtfFPy8e9zquErVxpEdjOm2StAKnlCboSM93RNEwuFufC3
	 PfXlcZXuU0z8+2xU2BKXOO2zxjXTE01o6hmQ4ITlgwE5SS7mVP7UNsjiRZ1+xlkGwD
	 8tdYeojyMBk+C4gc1aM/y6QeE0IYSTMcNTy/tNwi1OEYwapu+zAPg7rSXptIEfELNv
	 ARZG5COb9ctNzgyAPe6GvGZaIqYGLPmsDWAUg6BfntmXrxqBOy/CBLxYjJw45LJs5H
	 A/0FXeUHMeiJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3F34607B9;
	Sun, 15 Nov 2026 16:02:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AFF8D109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A114440061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A76TKjfCxCd2 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 14:38:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D2C6840050
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=43.155.80.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2C6840050
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:38:23 +0000 (UTC)
X-QQ-mid: esmtpsz17t1794753452ta64c3fff
X-QQ-Originating-IP: 2rTJreHFztvYXvZW5aRjX2Pva+/Fz8Kca2VNQ8q5muQ=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 15 Nov 2026 22:37:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2331869085628336787
From: Zhouqi Jiang <luojia@rustsbi.com>
To: u-boot@lists.u-boot-project.org
Cc: tim609@andestech.com, leo.liang@sifive.com, me@ziyao.cc, sjg@chromium.org,
 alpernebiyasak@gmail.com, trini@konsulko.com
Subject: [PATCH] riscv: Add RustSBI firmware support
Date: Sun, 15 Nov 2026 22:38:08 +0800
Message-ID: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NHQD8NIzEAhRbAeDgyHW6hsVfVPHmvThVKgr6ghP6Dm1j0lGTbY4pAW3
 so05rH8tN1LwSS/TpUqq/kznN/0zZcnXZ5jYbDiP5JO1f3AMvsuDDMayNB/MOHyu4tJRmL3
 bRv4x0188wKO9joMx4+q7z0nIcJ67sgbcnrFVI1xHQGxEAMa7pLy9AXYshb4tEh5EEWSL7D
 rKMCmzkUl/PLZ05CNqkHR5SLAGtQP3KI3N2dNXqp30LsToYP4+zE9CfqNhLlAchpRYXNUQb
 i8RGdsNpC4rzUM2SpgUS4wPAs1v0T+reFfiQvK/SwzZUwnRNZCjlokfH0Upnrj6N1pT8P/w
 dLLstHw+97UEDOa6d8L5x4idAZYxBwM5/t1P2EThyd4WQe3siq7ltVoMEEJt5fD9gFKh51V
 Eg70a1UrITPH40JEaz3og9SbZEEhc+V8jx6eYSCRb15Npovm46qj+tVpvxnsdfKCEu+Y9yD
 cHDz5ggTZdqZJlG4hXOcoGq76R1r8mkIkP9HK/GydyqS2guYU0GfNSrrzzuNMq35i42zXG7
 sjbfQXdO4FKQM6NJPNcuZKBtq4kO8RLt0LyoNeraJn+8EchH/+ZNwxsdVt35OkXc8oRt1Iw
 RuAEJL/zZgZ/PwxfmuM1cK/Cpn0BGoAxMDcSq7JcIcAsYyOgezEr3Ix+ZJmjBr77ylyvbaj
 1gwdLxudARGZQIcVyi4Lgl4lXCtt7lyJBpmd1y9QNC4SyMkhWj03fpwbXMqBMyKPopc8d6z
 TbWZnZ8EEUiMG+uViSdWMNRjyWnJ0WYR/BzDlJJ5AXL9RucGqfNAxoAuFnHzFrAJHjVI7T6
 m91Iz58b6+PjBPFnGkCzPuFhokUIlhWGUIJdnRlaQlXeW5J6btc5yZ42JtKyBVEG5OPgmfX
 frtMtaWfnHy3mUZEtI22IFQ3Fv5EZ7vszK/NYv6KCeUZJZad/jKNajKRWUi1MNApnWnOG31
 1t9pYRaRzXXJhHLKJBwN3XOjhhTLulqYoBvpV+bBW64FFFBVMB4ucH6NqLwgjS6LboD6bWe
 NXfWlE0jEsNw02lBNO1ZNYVTtUPbfe6llmogleGVQfz9sieSEG
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Sun, 15 Nov 2026 16:02:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RustSBI is a security-focused, open-source RISC-V SBI implementation
written in Rust. It is listed in the SBI specification with
implementation ID 4.

Add RustSBI support to U-Boot:
- Add SPL firmware selection and dynamic handoff.
- Add the RustSBI FIT image type and RUSTSBI binman input.
- Update RISC-V FIT templates, documentation and tests.

Ref: https://docs.riscv.org/reference/sbi/_attachments/riscv-sbi.pdf
Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
---
 MAINTAINERS                             |  1 +
 Makefile                                |  1 +
 arch/riscv/Kconfig                      | 10 +++----
 arch/riscv/dts/binman.dtsi              | 23 ++++++++++++++-
 arch/riscv/dts/thead-th1520-binman.dtsi | 24 ++++++++++++++++
 boot/image.c                            |  1 +
 common/spl/Kconfig                      | 37 +++++++++++++++++++------
 common/spl/Makefile                     |  1 +
 common/spl/spl.c                        |  3 ++
 common/spl/spl_fit.c                    |  3 +-
 common/spl/spl_rustsbi.c                | 13 +++++++++
 doc/board/emulation/qemu-riscv.rst      |  9 ++++++
 include/image.h                         |  1 +
 include/spl.h                           |  5 ++++
 tools/binman/etype/rustsbi.py           | 18 ++++++++++++
 tools/binman/ftest.py                   | 16 +++++++++++
 tools/binman/missing-blob-help          |  4 +++
 tools/binman/test/fip/rustsbi.dts       | 11 ++++++++
 18 files changed, 165 insertions(+), 16 deletions(-)
 create mode 100644 common/spl/spl_rustsbi.c
 create mode 100644 tools/binman/etype/rustsbi.py
 create mode 100644 tools/binman/test/fip/rustsbi.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b38ffee288..35980cf8459 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1519,6 +1519,7 @@ M:	Leo Liang <leo.liang@sifive.com>
 R:	Yao Zi <me@ziyao.cc>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git
+F:	common/spl/spl_rustsbi.c
 F:	drivers/sysreset/sysreset_sbi.c
 F:	drivers/timer/andes_plmt_timer.c
 N:	riscv
diff --git a/Makefile b/Makefile
index 519866b82ea..cf58788a007 100644
--- a/Makefile
+++ b/Makefile
@@ -1695,6 +1695,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a tee-os-path=${TEE} \
 		-a ti-dm-path=${TI_DM} \
 		-a opensbi-path=${OPENSBI} \
+		-a rustsbi-path=${RUSTSBI} \
 		-a default-dt=$(default_dt) \
 		-a scp-path=$(SCP) \
 		-a rockchip-tpl-path=$(ROCKCHIP_TPL) \
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a..4bd562437cb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -476,8 +476,7 @@ config SBI_V02
 	  single hart needs to boot and enter the operating system. The booting
 	  hart can bring up secondary harts one by one afterwards.
 
-	  Choose this option if OpenSBI release v0.7 or above is used together
-	  with U-Boot.
+	  Choose this option if the SBI firmware implements SBI v0.2 or later.
 
 endchoice
 
@@ -625,12 +624,11 @@ config TPL_USE_ARCH_MEMSET
 endmenu
 
 config SPL_LOAD_FIT_OPENSBI_OS_BOOT
-	bool "Enable SPL (OpenSBI OS boot mode) applying linux from FIT"
+	bool "Boot Linux from a FIT through SBI firmware"
 	depends on SPL_LOAD_FIT
 	help
-	  Use fw_dynamic from the FIT image, and u-boot SPL will invoke it directly.
-	  This is a shortcut boot flow, from u-boot SPL -> OpenSBI -> u-boot proper
-	  -> linux to u-boot SPL -> OpenSBI -> linux.
+	  Load SBI firmware and Linux from the FIT image. SPL starts the SBI
+	  firmware, which starts Linux directly instead of U-Boot proper.
 
 config SPL_OPTEE_LOAD_ADDR
 	hex "OP-TEE Trusted OS image load address"
diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 84c261c6849..12be2e73f04 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -21,7 +21,7 @@
 #endif
 
 		fit {
-			description = "Configuration to load OpenSBI before U-Boot";
+			description = "Configuration to load SBI firmware before U-Boot";
 			#address-cells = <2>;
 			fit,fdt-list = "of-list";
 
@@ -66,6 +66,7 @@
 				};
 #endif
 
+#ifdef CONFIG_SPL_OPENSBI
 				opensbi {
 					description = "OpenSBI fw_dynamic Firmware";
 					type = "firmware";
@@ -80,6 +81,22 @@
 						missing-msg = "opensbi";
 					};
 				};
+#elif defined(CONFIG_SPL_RUSTSBI)
+				rustsbi {
+					description = "RustSBI dynamic Firmware";
+					type = "firmware";
+					os = "rustsbi";
+					arch = "riscv";
+					compression = "none";
+					load = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+					entry = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+
+					rustsbi_blob: rustsbi {
+						filename = "rustsbi-prototyper-dynamic.bin";
+						missing-msg = "rustsbi";
+					};
+				};
+#endif
 
 #if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
 				@fdt-SEQ {
@@ -101,7 +118,11 @@
 				conf-1 {
 #endif
 					description = "NAME";
+#ifdef CONFIG_SPL_OPENSBI
 					firmware = "opensbi";
+#elif defined(CONFIG_SPL_RUSTSBI)
+					firmware = "rustsbi";
+#endif
 #ifdef CONFIG_OPTEE
 #ifdef CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT
 					loadables = "linux", "tee";
diff --git a/arch/riscv/dts/thead-th1520-binman.dtsi b/arch/riscv/dts/thead-th1520-binman.dtsi
index 7b535e8402c..ee9716d157e 100644
--- a/arch/riscv/dts/thead-th1520-binman.dtsi
+++ b/arch/riscv/dts/thead-th1520-binman.dtsi
@@ -30,6 +30,7 @@
 		fit,fdt-list = "of-list";
 
 		images {
+#ifdef CONFIG_SPL_OPENSBI
 			opensbi {
 				description = "OpenSBI fw_dynamic Firmware";
 				type = "firmware";
@@ -43,11 +44,30 @@
 					missing-msg = "opensbi";
 				};
 			};
+#elif defined(CONFIG_SPL_RUSTSBI)
+			rustsbi {
+				description = "RustSBI dynamic Firmware";
+				type = "firmware";
+				os = "rustsbi";
+				arch = "riscv";
+				load = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+				entry = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+
+				rustsbi_blob: rustsbi {
+					filename = "rustsbi-prototyper-dynamic.bin";
+					missing-msg = "rustsbi";
+				};
+			};
+#endif
 
 			uboot {
 				description = "U-Boot";
 				type = "standalone";
+#ifdef CONFIG_SPL_OPENSBI
 				firmware = "opensbi";
+#elif defined(CONFIG_SPL_RUSTSBI)
+				firmware = "rustsbi";
+#endif
 				os = "U-boot";
 				arch = "riscv";
 				compression = "none";
@@ -71,7 +91,11 @@
 			@conf-SEQ {
 				description = "NAME";
 				fdt = "fdt-SEQ";
+#ifdef CONFIG_SPL_OPENSBI
 				firmware = "opensbi";
+#elif defined(CONFIG_SPL_RUSTSBI)
+				firmware = "rustsbi";
+#endif
 				loadables = "uboot";
 			};
 		};
diff --git a/boot/image.c b/boot/image.c
index 289e80f23a7..5a9d11f4015 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -123,6 +123,7 @@ static const table_entry_t uimage_os[] = {
 	{	IH_OS_OPENRTOS,	"openrtos",	"OpenRTOS",		},
 #endif
 	{	IH_OS_OPENSBI,	"opensbi",	"RISC-V OpenSBI",	},
+	{	IH_OS_RUSTSBI,	"rustsbi",	"RISC-V RustSBI",	},
 	{	IH_OS_EFI,	"efi",		"EFI Firmware"		},
 #ifdef CONFIG_BOOTM_ELF
 	{	IH_OS_ELF,	"elf",		"ELF Image"		},
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4930ecb0861..abb6964794c 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1735,10 +1735,17 @@ config SPL_OPTEE_IMAGE
 	  OP-TEE is an open source Trusted OS which is loaded by SPL.
 	  More detail at: https://github.com/OP-TEE/optee_os
 
-config SPL_OPENSBI
-	bool "Support RISC-V OpenSBI"
+choice
+	prompt "RISC-V SBI firmware"
 	depends on RISCV && SPL_RISCV_MMODE && RISCV_SMODE
 	depends on SPL_LOAD_FIT && !SPL_FIT_IMAGE_TINY
+	default SPL_OPENSBI
+	help
+	  Select the SBI firmware that U-Boot SPL will load and start.
+	  OpenSBI is selected by default.
+
+config SPL_OPENSBI
+	bool "Support RISC-V OpenSBI firmware"
 	help
 	  OpenSBI is an open-source implementation of the RISC-V Supervisor Binary
 	  Interface (SBI) specification. U-Boot supports the OpenSBI FW_DYNAMIC
@@ -1747,16 +1754,30 @@ config SPL_OPENSBI
 	  More details are available at https://github.com/riscv/opensbi and
 	  https://github.com/riscv/riscv-sbi-doc
 
+config SPL_RUSTSBI
+	bool "Support RISC-V RustSBI firmware"
+	help
+	  RustSBI is a security-focused RISC-V Supervisor Binary Interface (SBI)
+	  implementation written in Rust. U-Boot supports RustSBI Prototyper
+	  dynamic firmware, which is loaded and started by U-Boot SPL.
+
+	  More details are available at https://github.com/rustsbi/rustsbi and
+	  https://github.com/riscv/riscv-sbi-doc
+
+endchoice
+
 config SPL_OPENSBI_LOAD_ADDR
-	hex "OpenSBI load address"
-	depends on SPL_OPENSBI
+	hex "SBI firmware load address"
+	depends on SPL_OPENSBI || SPL_RUSTSBI
 	help
-	  Load address of the OpenSBI binary.
+	  Load address of the SBI firmware binary.
 
 config SPL_OPENSBI_SCRATCH_OPTIONS
-	hex "Scratch options passed to OpenSBI"
-	default 0x1
-	depends on SPL_OPENSBI
+	hex "Scratch options passed to OpenSBI" if SPL_OPENSBI
+	default 0x1 if SPL_OPENSBI
+	# RustSBI shares the dynamic handoff but does not use OpenSBI options.
+	default 0x0 if SPL_RUSTSBI
+	depends on SPL_OPENSBI || SPL_RUSTSBI
 	help
 	  This bitmap of options is passed from U-Boot SPL to OpenSBI.
 	  As of OpenSBI 1.3 the following bits are defined:
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 9c94e8f143e..2b03b7e8282 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_$(PHASE_)MMC) += spl_mmc.o
 obj-$(CONFIG_$(PHASE_)ATF) += spl_atf.o
 obj-$(CONFIG_$(PHASE_)OPTEE_IMAGE) += spl_optee.o
 obj-$(CONFIG_$(PHASE_)OPENSBI) += spl_opensbi.o
+obj-$(CONFIG_$(PHASE_)RUSTSBI) += spl_rustsbi.o spl_opensbi.o
 obj-$(CONFIG_$(PHASE_)USB_STORAGE) += spl_usb.o
 obj-$(CONFIG_$(PHASE_)FS_FAT) += spl_fat.o
 obj-$(CONFIG_$(PHASE_)FS_EXT4) += spl_ext.o
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6c9a1a1cbcc..6214074c824 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -791,6 +791,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	} else if (CONFIG_IS_ENABLED(OPENSBI) && os == IH_OS_OPENSBI) {
 		debug("Jumping to U-Boot via RISC-V OpenSBI\n");
 		jumper = &spl_invoke_opensbi;
+	} else if (CONFIG_IS_ENABLED(RUSTSBI) && os == IH_OS_RUSTSBI) {
+		debug("Jumping to U-Boot via RISC-V RustSBI\n");
+		jumper = &spl_invoke_rustsbi;
 	} else if (CONFIG_IS_ENABLED(OS_BOOT) && os == IH_OS_LINUX) {
 		debug("Jumping to Linux\n");
 		if (CONFIG_IS_ENABLED(OS_BOOT_ARGS))
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 64e5f95546f..dabf60b28ad 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -466,7 +466,8 @@ static bool os_takes_devicetree(uint8_t os)
 		return true;
 	case IH_OS_LINUX:
 		return IS_ENABLED(CONFIG_SPL_OS_BOOT) ||
-		       IS_ENABLED(CONFIG_SPL_OPENSBI);
+		       IS_ENABLED(CONFIG_SPL_OPENSBI) ||
+		       IS_ENABLED(CONFIG_SPL_RUSTSBI);
 	default:
 		return false;
 	}
diff --git a/common/spl/spl_rustsbi.c b/common/spl/spl_rustsbi.c
new file mode 100644
index 00000000000..60d85993bcd
--- /dev/null
+++ b/common/spl/spl_rustsbi.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Institute of Software Chinese Academy of Sciences,
+ * Zhouqi Jiang <jiangzhouqi2025@iscas.ac.cn>
+ */
+
+#include <spl.h>
+
+void __noreturn spl_invoke_rustsbi(struct spl_image_info *spl_image)
+{
+	/* RustSBI and OpenSBI use the same dynamic handoff protocol. */
+	spl_invoke_opensbi(spl_image);
+}
diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index a76a1a8bf75..1be2f53f54e 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -124,6 +124,15 @@ with the following commands.
     make qemu-riscv64_spl_defconfig
     make
 
+To use RustSBI firmware, build RustSBI Prototyper in dynamic mode for the
+target with the SPL firmware load address. See https://github.com/rustsbi/rustsbi
+for details. Set RUSTSBI to the firmware binary and build U-Boot::
+
+    make qemu-riscv32_spl_defconfig  # Or qemu-riscv64_spl_defconfig
+    scripts/config --disable SPL_OPENSBI --enable SPL_RUSTSBI
+    make olddefconfig
+    make RUSTSBI=/path/to/rustsbi-prototyper-dynamic.bin
+
 The minimal QEMU commands to run U-Boot SPL in both 32-bit and 64-bit
 configurations are:
 
diff --git a/include/image.h b/include/image.h
index a424206bedf..c9b129589d5 100644
--- a/include/image.h
+++ b/include/image.h
@@ -100,6 +100,7 @@ enum {
 	IH_OS_OPENSBI,			/* RISC-V OpenSBI */
 	IH_OS_EFI,			/* EFI Firmware (e.g. GRUB2) */
 	IH_OS_ELF,			/* ELF Image (e.g. seL4) */
+	IH_OS_RUSTSBI,			/* RISC-V RustSBI */
 
 	IH_OS_COUNT,
 };
diff --git a/include/spl.h b/include/spl.h
index 390d18fd9d5..5d0a329ce60 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1144,6 +1144,11 @@ void __noreturn spl_optee_entry(void *arg0, void *arg1, void *arg2, void *arg3);
  */
 void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image);
 
+/**
+ * spl_invoke_rustsbi - boot using a RISC-V RustSBI image
+ */
+void __noreturn spl_invoke_rustsbi(struct spl_image_info *spl_image);
+
 /**
  * board_return_to_bootrom - allow for boards to continue with the boot ROM
  *
diff --git a/tools/binman/etype/rustsbi.py b/tools/binman/etype/rustsbi.py
new file mode 100644
index 00000000000..2fe2b6ac559
--- /dev/null
+++ b/tools/binman/etype/rustsbi.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0+
+"""Binman entry for a RustSBI dynamic firmware binary."""
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+
+class Entry_rustsbi(Entry_blob_named_by_arg):
+    """RISC-V RustSBI dynamic firmware blob
+
+    Properties / Entry arguments:
+        - rustsbi-path: Filename of the RustSBI firmware binary
+
+    This entry holds the M-mode firmware started by U-Boot SPL.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'rustsbi')
+        self.external = True
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 567ffa96b2b..30528974e0f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -97,6 +97,7 @@ TEE_OS_DATA           = b'this is some tee OS data'
 TI_DM_DATA            = b'tidmtidm'
 ATF_BL2U_DATA         = b'bl2u'
 OPENSBI_DATA          = b'opensbi'
+RUSTSBI_DATA          = b'rustsbi'
 SCP_DATA              = b'scp'
 ROCKCHIP_TPL_DATA     = b'rockchip-tpl'
 TEST_FDT1_DATA        = b'fdt1'
@@ -236,6 +237,7 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('dm.bin', TI_DM_DATA)
         TestFunctional._MakeInputFile('bl2u.bin', ATF_BL2U_DATA)
         TestFunctional._MakeInputFile('fw_dynamic.bin', OPENSBI_DATA)
+        TestFunctional._MakeInputFile('rustsbi-test.bin', RUSTSBI_DATA)
         TestFunctional._MakeInputFile('scp.bin', SCP_DATA)
         TestFunctional._MakeInputFile('rockchip-tpl.bin', ROCKCHIP_TPL_DATA)
         TestFunctional._MakeInputFile('ti_unsecure.bin', TI_UNSECURE_DATA)
@@ -5059,6 +5061,20 @@ class TestFunctional(unittest.TestCase):
         data = self._DoReadFile('fip/opensbi.dts')
         self.assertEqual(OPENSBI_DATA, data[:len(OPENSBI_DATA)])
 
+    def testPackRustSBI(self):
+        """Test that rustsbi-path selects the supplied firmware binary"""
+        data, _, _, _ = self._DoReadFileDtb(
+            'fip/rustsbi.dts', entry_args={'rustsbi-path': 'rustsbi-test.bin'})
+        self.assertEqual(RUSTSBI_DATA, data)
+
+    def testPackRustSBIMissing(self):
+        """Test that a missing RustSBI binary is reported"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb(
+                'fip/rustsbi.dts', entry_args={'rustsbi-path': 'missing-rustsbi.bin'})
+        self.assertIn("Filename 'missing-rustsbi.bin' not found in input path",
+                      str(exc.exception))
+
     def testSectionsSingleThread(self):
         """Test sections without multithreading"""
         data = self._DoReadFileDtb('entry/sections.dts', threads=0)[0]
diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index 27dc620bd35..5c1bb1e7482 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -38,6 +38,10 @@ https://github.com/riscv/opensbi.git
 You may need to build fw_dynamic.bin first and re-build u-boot with
 OPENSBI=/path/to/fw_dynamic.bin
 
+rustsbi:
+Build RustSBI Prototyper in dynamic mode for the configured SPL SBI load
+address, then re-build U-Boot with RUSTSBI=/path/to/firmware.bin.
+
 rockchip-tpl:
 An external TPL is required to initialize DRAM. Get the external TPL
 binary and build with ROCKCHIP_TPL=/path/to/ddr.bin. One possible source
diff --git a/tools/binman/test/fip/rustsbi.dts b/tools/binman/test/fip/rustsbi.dts
new file mode 100644
index 00000000000..2275cca5414
--- /dev/null
+++ b/tools/binman/test/fip/rustsbi.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		rustsbi {
+			filename = "rustsbi-prototyper-dynamic.bin";
+		};
+	};
+};
-- 
2.53.0.windows.2

