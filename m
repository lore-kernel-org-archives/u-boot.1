Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B69C27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 20:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5CF8895E;
	Thu, 13 Jun 2024 22:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W9HziMDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0FC888001; Thu, 13 Jun 2024 22:28:23 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BF7888C0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 22:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DKS7YJ068220;
 Thu, 13 Jun 2024 15:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718310487;
 bh=5riuLkK4x/GTLYYNvx1JWMXVfj1t2YCRF/E3jME1fxY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=W9HziMDA8OalJKfqvB70BNr7mq2xTUpsJHH1UQXClbWu46lY3TYwAREbvhK/JeqqD
 L42cKL+rgb4Roq7JGRHUj1sjrw7ysb2vMhyEIB1dBvtMj+D6n4w/AOPxLucNEXfkrU
 Mmyi7VrSHNV5Wa+IEMHCj30cYiJJNk1vmimKgWpA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DKS7Gw099549
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Jun 2024 15:28:07 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 15:28:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 15:28:07 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DKS7OB090014;
 Thu, 13 Jun 2024 15:28:07 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Sumit Garg <sumit.garg@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Joshua Watt <jpewhacker@gmail.com>, Caleb
 Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>, Simon Glass
 <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 2/2] scripts/Makefile.lib: EFI: Use capsule CRT instead of
 ESL file
Date: Thu, 13 Jun 2024 15:27:53 -0500
Message-ID: <20240613202753.2528889-3-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613202753.2528889-1-j-humphreys@ti.com>
References: <20240613202753.2528889-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The EFI Capsule ESL file (EFI Signature List File) used for authentication
is a binary generated from the EFI Capsule public key certificate. Instead
of including it in the source repo, automatically generate it from the
certificate file during the build process.

Currently, sandbox is the only device using this, so removed its ESL file
and set the (new) CONFIG_EFI_CAPSULE_CRT_FILE config to point to its public
key certificate.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 board/sandbox/capsule_pub_esl_good.esl | Bin 831 -> 0 bytes
 configs/sandbox_defconfig              |   2 +-
 configs/sandbox_flattree_defconfig     |   2 +-
 doc/develop/uefi/uefi.rst              |   8 ++++----
 lib/efi_loader/Kconfig                 |  12 +++++++-----
 scripts/Makefile.lib                   |  22 ++++++++++++++--------
 6 files changed, 27 insertions(+), 19 deletions(-)
 delete mode 100644 board/sandbox/capsule_pub_esl_good.esl

diff --git a/board/sandbox/capsule_pub_esl_good.esl b/board/sandbox/capsule_pub_esl_good.esl
deleted file mode 100644
index f8cc272309b2f80113c29e22bc9fdd5c767b4667..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 831
zcmZ1&d0^?2Da*aux2_hA(f&|m&&&V@%1|1@gOCPI%=`vTjNcb9GchtTi3D3+YdNud
z!N;6d=3f<&F-6ONS4$i4vT<s)d9;1!Wn|=LWiSvk6fqEDV-96u=HU);4GxJ9_H_4i
z4Kh#==QT1murM$&v@kF?F^ZDlH#RUZHZ(9Wg9_l(*~F-XYzZSP19KB2KLgNRTue=j
zj0_uCzfHaHH`(1}*Y#3U|97H!k3}~NhPN}GOrG;oTyFi(qmA`NTh~3>_x7NA^t?#f
z>a)U0PLquF6_u8?^dHul+F@6qxB0YdssF`W?=n<3b^P4dmiKI#^@p}E)#B;%RW0;Z
z-#n?@Et9eDfUQTgV&QR*{b|~VRC6NVv@WS%&0hbnAnbMH)s>m<ruWw!o9KU&t7IaN
z^ws?)fy!Y!PA6wHM9oeqJuYyoIO0;duj#}3>jlOWk4kw?f2&||$2#il@?9KqESXN5
zbz2wTe>RVi?d~3_cT1K9oDaUDRd@aM1GkLbi{)<QcW%>Ma(#i_ui5G`j(PuTIhpoN
z73DslYiZhJ`RkA&6Eh<N<Kke0Km%D|xXbdfh_Q&secT;;BI`VRLX*$F#X3)yTwnIl
z%Rn9^t;`}}Al86g0Y6BAFeBrC7FGjhAcY+4z_<klJ0n9-ZF-^Byx1)aGPkZ;M8@iK
z@4h6QYApWke51U4vh|)B+RHfwcQh8f`Fd8-Ad#bU?mv#SCl^~!ojUbKMpn)-Kd>zH
z-bULy5-~dZsg>zZPS-w(zNM;c<#N4ar|5@t2FY2AoF7{4IWYI(=HR-Vl;VtSQGM$z
zG&LhNEwesN5|ez&@#Le<mt%k4Ngp{`oU3!I!!G(r+O78=mGAf;yBNLt_LaVmLHB2w
zF3Vp(*($;GmPMkjzjWQf=x-~Qozl?NwEilS|Lo7%xGP$f^Riek&1Q@!w>qJ9NJDsL
xX})Fc$L0Fj-&QP|CD!3Bu=aCF<a-t|<@nrhQ$HQy*tL7JV9T^r#)tp!0|2#rO&9<G

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 93b52f2de5c..d6c7d7a4ad3 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -352,7 +352,7 @@ CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
-CONFIG_EFI_CAPSULE_ESL_FILE="board/sandbox/capsule_pub_esl_good.esl"
+CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
 CONFIG_UNIT_TEST=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 6bf8874e722..049a606613e 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -227,7 +227,7 @@ CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
-CONFIG_EFI_CAPSULE_ESL_FILE="board/sandbox/capsule_pub_esl_good.esl"
+CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 36ac75278fa..985956ab85c 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -580,10 +580,10 @@ and used by the steps highlighted below.
     }
 
 You can perform step-4 through the Kconfig symbol
-CONFIG_EFI_CAPSULE_ESL_FILE. This symbol points to the esl file
-generated in step-2. Once the symbol has been populated with the path
-to the esl file, it will automatically get embedded into the
-platform's dtb as part of U-Boot build.
+CONFIG_EFI_CAPSULE_CRT_FILE. This symbol points to the signing key
+generated in step-2. As part of U-Boot build, the ESL certificate file will
+be generated from the signing key and automatically get embedded into the
+platform's dtb.
 
 Anti-rollback Protection
 ************************
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 430bb7f0f7d..23079a5709d 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -298,13 +298,15 @@ config EFI_CAPSULE_MAX
 	  Select the max capsule index value used for capsule report
 	  variables. This value is used to create CapsuleMax variable.
 
-config EFI_CAPSULE_ESL_FILE
-	string "Path to the EFI Signature List File"
+config EFI_CAPSULE_CRT_FILE
+	string "Path to the EFI capsule public key certificate"
 	depends on EFI_CAPSULE_AUTHENTICATE
 	help
-	  Provides the path to the EFI Signature List file which will
-	  be embedded in the platform's device tree and used for
-	  capsule authentication at the time of capsule update.
+	  Provides the path to the EFI capsule public key certificate that
+	  corresponds to the capsule signing key. This certificate will be used
+	  to generate the EFI capsule ESL (signature list file) that gets
+	  embedded in the platform's device tree and used for capsule
+	  authentication at the time of capsule update.
 
 config EFI_DEVICE_PATH_TO_TEXT
 	bool "Device path to text protocol"
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index af97fcfe4bb..0faa849a345 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -342,21 +342,27 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 		; \
 	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
+capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
+capsule_crt_file=$(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))
+capsule_esl_dtsi=.capsule_esl.dtsi
+
 quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
-cmd_capsule_esl_gen = \
-	$(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_input_file) > $@)
+cmd_capsule_esl_gen = cert-to-efi-sig-list $< $@
 
-$(obj)/.capsule_esl.dtsi: FORCE
-ifeq ($(CONFIG_EFI_CAPSULE_ESL_FILE),"")
-	$(error "CONFIG_EFI_CAPSULE_ESL_FILE is empty, EFI capsule authentication \
+$(obj)/capsule_esl_file: $(capsule_crt_file) FORCE
+ifeq ($(CONFIG_EFI_CAPSULE_CRT_FILE),"")
+	$(error "CONFIG_EFI_CAPSULE_CRT_FILE is empty, EFI capsule authentication \
 	public key must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled")
 else
 	$(call cmd,capsule_esl_gen)
 endif
 
-capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
-capsule_esl_dtsi = .capsule_esl.dtsi
-capsule_esl_path=$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_ESL_FILE)))
+quiet_cmd_capsule_dtsi_gen = CAPSULE_DTSI_GEN $@
+cmd_capsule_dtsi_gen = \
+	$(shell sed "s:ESL_BIN_FILE:$(abspath $<):" $(capsule_esl_input_file) > $@)
+
+$(obj)/$(capsule_esl_dtsi): $(obj)/capsule_esl_file FORCE
+	$(call cmd,capsule_dtsi_gen)
 
 dtsi_include_list_deps := $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
 
-- 
2.34.1

