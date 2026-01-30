Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28446D49C7C
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 08:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763288426E;
	Fri, 30 Jan 2026 09:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="M3xIgATo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DAE6842CD; Fri, 30 Jan 2026 09:58:15 +0100 (CET)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8691A84131
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 09:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4f2VKH2ln7zyQK;
 Fri, 30 Jan 2026 10:58:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1769763491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AI6uIvgzImyPiX3ioK1k/POU2OcSBYi4LwOe/wdu4dw=;
 b=M3xIgAToHoTOtUKNLze8RFVWsodfMyuiJ6IsCRlFY1VgEWpaNexP+8ODhKrNZPcjeKBB6g
 dDrPF5AJoXMriJhltcm3GVDCXkeFt+RrUk9lbth4fnK4k4CRrbjwS2oy+I54VKqqjJETS3
 /2n/6mLAyldDouDnGxjX7E21Gbgs4wc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1769763491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AI6uIvgzImyPiX3ioK1k/POU2OcSBYi4LwOe/wdu4dw=;
 b=Jk7a1wVK7LIbbKS0j8YdWfQB9Wz/PaAQF1BpyWq7BxgZz3acyqEB4FukcFdFZgmunwGc7E
 OtS9S6pTfJYAhv3Hg7wBg6LvQc4HDdnzyVVJr/LK3SrvlxTrkS+fc6w7DG7mWYizTzhSy8
 ju2sYxVgwGQ2JA36vJdXJ8q/HKv7ob8=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1769763491;
 b=nh2vwPacBEyzKK9jsmgwiQyOlAufCAR45APZdHZaoSnmNTer+Gtf2NO0rmkGVRb/qLW54r
 WvEmPjL5w++CYzVS2uH0MVUizIkMGnKeTpgL6akmXEQonpCI0UuSDTiAYDBVaiDKutC2L8
 qV0Zp4A8LuSf83Eai8AlOw0f9Qi+OYE=
Date: Fri, 30 Jan 2026 10:58:10 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Jonny Green <jonny.green@keytechinc.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>
Subject: Re: lib: ecdsa: Verifying signature on target
Message-ID: <aXxyovMIrH15aVnP@kehys.lan>
References: <IA0PR17MB66130E9A26543D795DB5C98C959EA@IA0PR17MB6613.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wBT3nhzOcyT5zyO4"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA0PR17MB66130E9A26543D795DB5C98C959EA@IA0PR17MB6613.namprd17.prod.outlook.com>
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


--wBT3nhzOcyT5zyO4
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Thu, Jan 29, 2026 at 10:18:03PM +0000, Jonny Green wrote:
>Hello,
>
>I am implementing FIT booting with an ECDSA signature. I am building 
>from a TI fork of U-Boot that is based off of v2025.01 from the 
>mainline repo.

Nice. I have been meaning to do the same;
https://lists.denx.de/pipermail/u-boot/2025-November/602918.html 
contains some notes.

>However, attempts to boot on the target with the signed u-boot.img and 
>generated .itb are failing. Debug printouts show that the call to 
>ecdsa_verify in ecdsa-verify.c is failing after calling 
>uclass_first_device_err: "ECDSA: Could not find ECDSA implementation: 
>-19".

I only found some implementations for some specific firmware or 
hardware. In mbedtls there is an implementation, which I have been 
intending to write an interface for. A first challenge was to actually 
include the mbedtls in the build. The attached patch would introduce 
CONFIG_ECDSA_MBEDTLS.

A challenge with the Kconfig system is that you can create an "overlay" 
of a default configuration that adds things, but you cannot remove 
things that are part of the default configuration. Here's an example of 
adding things (without modifying any existing files in u-boot):

cat > configs/a53_defconfig << "EOF"
#include <configs/phycore_am62x_a53_defconfig>
CONFIG_FIT_SIGNATURE=y
CONFIG_ECDSA=y
CONFIG_ECDSA_VERIFY=y
EOF

The above actually is how I was originally experimenting with ECDSA.  
Currently, I am using a Raspberry Pi 4. I figured out that there is a 
lower-level configuration interface:

make rpi_4_defconfig &&
scripts/config -e FIT_SIGNATURE -e ECDSA -e SHA256 -e ECDSA_VERIFY \
-d BOOTSTD \
-e MBEDTLS_LIB -e MBEDTLS_LIB_CRYPTO -e ECDSA_MBEDTLS \
-e SHA256_MBEDTLS -e SHA256_SMALLER -e MBEDTLS_LIB_X509 -d HKDF_MBEDTLS \
-d LEGACY_HASHING_AND_CRYPTO &&
make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-

If the LEGACY_HASHING_AND_CRYPTO were not disabled, it would override 
any MBEDTLS parameters.

>Other debugging steps I've taken:
>* Ensured public key is present in the booted image via inspection with fdt
>* Ensured relevant config values are set: ECDSA, ECDSA_VERIFY, FIT_SIGNATURE
>* Attempted to get trace information from the boot attempt, but it 
>appears my board does not support the required clock

One problem that I noticed is that the ECDSA signature verification in 
fit_check_sign needs access to the private key. Were you able to fix it 
so that only a public key is needed, like it is the case with the RSA 
signature verification?

Also, I understood that u-boot prefers to store a parsed RSA or ECDSA 
key in the FIT in its own pre-parsed way, while the MBEDTLS library 
would apparently input the raw key. This problem would have to be solved 
in some way. Maybe, by just embedding the key in binary form in a FDT 
node and letting MBEDTLS parse it? This would of course require some 
changes to fit_check_sign and other tools as well.

Storing the key in the canonical format would seem to make it easier to 
add further algorithms. I'm actually not that interested in ECDSA; my 
ultimate goal would be to integrate an algorithm that is expected to be 
safe against attacks based on quantum computers.

With best regards,

	Marko Mäkelä

--wBT3nhzOcyT5zyO4
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="config_ECDSA_MBEDTLS.patch"

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 789721ee6cd..12f6bd3f063 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -231,6 +231,13 @@ config HKDF_MBEDTLS
 	  This option enables support of key derivation using HKDF algorithm
 	  with MbedTLS crypto library.
 
+config ECDSA_MBEDTLS
+	bool "Enable ECDSA support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && ECDSA
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with MbedTLS crypto library.
+
 endif # MBEDTLS_LIB_CRYPTO
 
 config MBEDTLS_LIB_X509
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..fdea27d9901 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_$(PHASE_)MD5_MBEDTLS) += md5.o
 obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += sha1.o
 obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += sha512.o
+obj-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += ecdsa.o
 
 # xdiff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 789721ee6cd..12f6bd3f063 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -231,6 +231,13 @@ config HKDF_MBEDTLS
 	  This option enables support of key derivation using HKDF algorithm
 	  with MbedTLS crypto library.
 
+config ECDSA_MBEDTLS
+	bool "Enable ECDSA support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && ECDSA
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with MbedTLS crypto library.
+
 endif # MBEDTLS_LIB_CRYPTO
 
 config MBEDTLS_LIB_X509
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..fdea27d9901 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_$(PHASE_)MD5_MBEDTLS) += md5.o
 obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += sha1.o
 obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += sha512.o
+obj-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += ecdsa.o
 
 # x509 libraries
 obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \509 libraries
 obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \

--wBT3nhzOcyT5zyO4--
