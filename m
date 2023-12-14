Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3320EC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 12:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E7B87A70;
	Thu, 14 Dec 2023 13:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="jkflWMim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1AF87A68; Thu, 14 Dec 2023 13:11:49 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F84887A70
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702555903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wERgIUvLyXTKOcvM9MGus0RX69APkgydwK8SDkBex3c=;
 b=jkflWMimPexIRUQ6pyxtktzqSkdTCK59kdpfQJ2FTpsGjL5iHHT7skXZeZQKh/j9hH/Yqc
 ncVeT1he9nTRKy3feM8lkM54/GW1uWiS6worEPwNefag3SWypG42bm9HmpiKA4UkT83MDy
 htt8ahi+lGcA2cOMAaQHIKjhvSp2OPq+nvGDWJOO+XPyhblb7YZDlL3bweUHbyv/8d34zH
 rArkTbJd6+hN25OhiKR+eINJfRfDajrW9dQe8VNK+KkScZw4+jcjCngY6dT5tfC4ImqB4R
 6Gk4omj0wzkxxqdwNNqvFSqcB2PXT4CBeTrc0gj+LCV+PY3h1O8BoRZiviVesQ==
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Terry Lv <terry.lv@nxp.com>
Subject: [PATCH v2 1/2] tools: kwbimage: Allow disabling build on non-mvebu
 platforms
Date: Thu, 14 Dec 2023 13:11:35 +0100
Message-Id: <20231214121136.3286703-2-ada@thorsis.com>
In-Reply-To: <20231214121136.3286703-1-ada@thorsis.com>
References: <20231214121136.3286703-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
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

Some users want to build with CONFIG_TOOLS_LIBCRYPTO disabled, which in
general is possible for at least some boards.  32-bit mvebu however
requires kwbimage for building SPL, and kwbimage has a hard dependency
to host OpenSSL.

The new symbol CONFIG_TOOLS_KWBIMAGE allows disabling kwbimage build on
non-mvebu platforms, and thus building without host libcrypto from
OpenSSL.

Based on previous work and discussions, see links below.

Link: https://lore.kernel.org/u-boot/20211021093304.25399-1-pali@kernel.org/
Link: https://lore.kernel.org/u-boot/20220111153120.1276641-1-marex@denx.de/
Link: https://lore.kernel.org/u-boot/20230121154743.667253-2-paulerwan.rio@gmail.com/
Cc: Marek Vasut <marex@denx.de>
Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    This is more or less a mashup of the patches of Pali and Marek, but
    considering the feedback given by Samuel on Pali's patch and considering
    what I thought was the preferred style in other parts of the Makefile.
    
    Link: https://lore.kernel.org/u-boot/f4660467-9d25-dc46-9e60-b2f7f09236c2@sholland.org/

 arch/arm/mach-mvebu/Kconfig | 1 +
 tools/Kconfig               | 5 +++++
 tools/Makefile              | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index c80d8587b14..2058c95ca2d 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -15,6 +15,7 @@ config ARMADA_32BIT
 	select SUPPORT_SPL
 	select SYS_L2_PL310 if !SYS_L2CACHE_OFF
 	select TRANSLATION_OFFSET
+	select TOOLS_KWBIMAGE if SPL
 	select SPL_SYS_NO_VECTOR_TABLE if SPL
 	select ARCH_VERY_EARLY_INIT
 
diff --git a/tools/Kconfig b/tools/Kconfig
index 6e23f44d550..f8632cd59d0 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -25,6 +25,11 @@ config TOOLS_LIBCRYPTO
 	  This selection does not affect target features, such as runtime FIT
 	  signature verification.
 
+config TOOLS_KWBIMAGE
+	bool "Enable kwbimage support in host tools"
+	default y
+	select TOOLS_LIBCRYPTO
+
 config TOOLS_FIT
 	def_bool y
 	help
diff --git a/tools/Makefile b/tools/Makefile
index 1aa1e36137b..fd3b207eb96 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -94,8 +94,11 @@ LIBCRYPTO_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := \
 			generated/lib/fdt-libcrypto.o \
 			sunxi_toc0.o
 
+KWB_IMAGE_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := kwbimage.o
+
 ROCKCHIP_OBS = generated/lib/rc4.o rkcommon.o rkimage.o rksd.o rkspi.o
 
+
 # common objs for dumpimage and mkimage
 dumpimage-mkimage-objs := aisimage.o \
 			atmelimage.o \
@@ -114,7 +117,7 @@ dumpimage-mkimage-objs := aisimage.o \
 			imximage.o \
 			imx8image.o \
 			imx8mimage.o \
-			kwbimage.o \
+			$(KWB_IMAGE_OBJS-y) \
 			generated/lib/md5.o \
 			lpc32xximage.o \
 			mxsimage.o \
-- 
2.39.2

