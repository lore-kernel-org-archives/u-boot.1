Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D833DC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 855C8884B2;
	Fri, 17 May 2024 18:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="qQFlEOfo";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="JiS+6Uq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973F4884A6; Fri, 17 May 2024 18:33:05 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864348823C
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id A28EC1381524;
 Fri, 17 May 2024 12:33:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 17 May 2024 12:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715963582;
 x=1716049982; bh=JhT8Q3D6n7rg1lgYpwlcal58gTgLZ7v3osl1v4z0Dok=; b=
 qQFlEOfojAQD4gym1FWvzmZYO7tdcfuM0voUyHOxKrEMKaaA69X80xV8f2nOtCvC
 Rs9Pp3sXzriMcKJ/C89/dERDvK89q2pQLgXZ/FsPgo5lnPiwIFupfLsf28whjn6M
 Tv7y2zK0r00xnvS2WJkTY/SzCj3ZJkm/Bj+Fl6tL/mOZiV1moc3gASNRAEMndXS0
 HgMEO3WvOfODyazq0Nw0eUTvAwyGTySG0YUQnaLL6LIKhqaDM/SQUbLbm1lvRol8
 qQ4Y9bIvNXo8FFI0sVhehQu3mZQi2GB8oRZkVa4k+KOZ5iN2BqwdVyT0qXBMc6u7
 yP6KdGT0UzyzVE3HfRw7Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715963582; x=
 1716049982; bh=JhT8Q3D6n7rg1lgYpwlcal58gTgLZ7v3osl1v4z0Dok=; b=J
 iS+6Uq3dPfmI9+ypzk5YfO4p/ZgFNDIIsuQHnZmARqH8aQRJknXi3MmnDeXwW4G2
 w3YxYK4qenbs/oaPUQ+qC/nvLFUrbJ1i2VCwzJJTVKcoTjX/8lep2TplC1/WhF6n
 jXrqbugfREcXQOVaetHSBvnyBewBNTDXJNHlwtvQjTMCatJneNfQrqXS2FF3J8L+
 JNROHVc0ySIBp1DU8qexfFjFvbheUvrlm6s69l4Iiy9+oVwhcRWXfqvfo4xburwv
 WR6+0Q4dRZBFGgh1bmVvjKkHU57oJiAD1gnk+Imbmv0d0NnmIrAHtbzyo1zPM7ho
 8fvJ6NEEfnlvF7ZGEWBlw==
X-ME-Sender: <xms:voZHZoM9Xlp5t_z59DPLCOXCF3UEEOKMfW83TKVBGs9F_xl5v762WA>
 <xme:voZHZu_-Hbwz1pt6IeTbmHhAetEVYkiixEmgIozY_BdsNeFRmiwqskoZU_XAoyUP6
 2kA6Pbzohw-_3Wwodg>
X-ME-Received: <xmr:voZHZvSdhEn4YA61nDjQRV1l1PyCQgrUcX4zdAtJ9DP22bDhCpU0VZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:voZHZgvlM-1YIUfP79xsw_yEkXS_lRlU9Jg9qKEbJAqZ9C9prTQaMw>
 <xmx:voZHZgcsSIuPbbgND4k1YOK1xkaxhQedVxY76ZyNEGV0g4oJMQ7zbA>
 <xmx:voZHZk2lo05cUSCINZivz04jeHIZXI31XzDLRqaz_vXfcsTjPAM2kg>
 <xmx:voZHZk8hyh0TrBNPpxxO7_njDMobPX8lYJLNm0Fn7p8MQocvST21kQ>
 <xmx:voZHZoQJMlmdfH0GIC9DqQbSf-o2_8rkTrBG2VxYaHf9Ov77RlqfbIMn>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 12:33:01 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 17:32:55 +0100
Subject: [PATCH 4/7] Makefile.lib: Enforce EFI CFLAGS/AFLAGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mips-efi-v1-4-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2096;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CSJtpFj5b7zu420sJwH/Z3EfZu/4s5WymivI4RlsgWA=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3th1yP2SvP/DhNhS3Ud9j8V20Yv15C36L2tO7jpoFG
 8ia3l7RUcrCIMbBICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABOx7mb4w8G5Myb0216+2RWz
 RW9sX7yYl8vbeQf3t9BMqUixnXbmVxgZlvMWPnR0Cuv7dNV9UgbTMh/11SH8jz893PCAP67H5Cc
 zCwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

EFI AFLAGS/CFLAGS should be enforced for those runtime
supporting files as well, otherwise EFI applications
will fail to compile on MIPS.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 Makefile             | 3 +++
 scripts/Makefile.lib | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 44deb339af19..6c9098f5823f 100644
--- a/Makefile
+++ b/Makefile
@@ -652,6 +652,8 @@ export EFI_CRT0		# Filename of EFI CRT0 in arch/$(ARCH)/lib
 export EFI_RELOC	# Filename of EFU relocation code in arch/$(ARCH)/lib
 export CFLAGS_EFI	# Compiler flags to add when building EFI app
 export CFLAGS_NON_EFI	# Compiler flags to remove when building EFI app
+export AFLAGS_EFI	# Assembler flags to add when building EFI app
+export AFLAGS_NON_EFI	# Assembler flags to remove when building EFI app
 export EFI_TARGET	# binutils target if EFI is natively supported
 
 export LTO_ENABLE
@@ -926,6 +928,7 @@ export PLATFORM_LIBGCC
 LDPPFLAGS += \
 	-include $(srctree)/include/u-boot/u-boot.lds.h \
 	-DCPUDIR=$(CPUDIR) \
+	-DARCHDIR=arch/$(ARCH) \
 	$(shell $(LD) --version | \
 	  sed -ne 's/GNU ld version \([0-9][0-9]*\)\.\([0-9][0-9]*\).*/-DLD_MAJOR=\1 -DLD_MINOR=\2/p')
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 52aed7a65d47..5aacab32cb38 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -495,8 +495,12 @@ $(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_free
 
 targets += $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
 
-CFLAGS_REMOVE_efi_reloc.o := $(LTO_CFLAGS)
-CFLAGS_REMOVE_efi_freestanding.o := $(LTO_CFLAGS)
+AFLAGS_efi_crt0.o := $(AFLAGS_EFI)
+CFLAGS_efi_reloc.o := $(CFLAGS_EFI)
+CFLAGS_efi_freestanding.o := $(CFLAGS_EFI)
+AFLAGS_REMOVE_efi_crt0.o := $(AFLAGS_NON_EFI)
+CFLAGS_REMOVE_efi_reloc.o := $(CFLAGS_NON_EFI) $(LTO_CFLAGS)
+CFLAGS_REMOVE_efi_freestanding.o := $(CFLAGS_NON_EFI) $(LTO_CFLAGS)
 
 # ACPI
 # ---------------------------------------------------------------------------

-- 
2.34.1

