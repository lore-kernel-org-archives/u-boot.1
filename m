Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9B2E63F06
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 18:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 456B580FA1;
	Sun, 15 Feb 2026 19:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="s26D8QUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302E883642; Sun, 15 Feb 2026 19:31:50 +0100 (CET)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7108063E
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 19:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fDZHf5pGCz49PtM;
 Sun, 15 Feb 2026 20:31:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1771180303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7cmrN8b9lbxBnPR5wF9JQwzdpf3sKRZpFzQQMp+iQE=;
 b=s26D8QUBn1P4MfFwmn6jbgI6d8i6IgNlsTngB42Ir1w1QctkWR74JHVz1RIZKQgF9gWe35
 bK1qRzpR5bIVR4O7m/+93ZkQZ8Mgf8aK5LpvQSlbGz04mXwDya5o+9mRMF2tyPcfNdVE6K
 fvFsH6v0kMQEfrPhDYr2MqXvPTXw6SdsLxy0mtTSRVNB9psklU336oruyYb3Y36rdZHxAb
 XcRIU2nvHQVPhhJLagLS3eNroveEex2OrO5vhpb0Tkx/WKKcV6yUZhFeUIHGMk61u4tYi2
 LbnSJ9t6NEeRK9slIoZrZLob6+5zMkqbvSXYb3soI0A4WjTA2+hRe21xMXUetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1771180303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7cmrN8b9lbxBnPR5wF9JQwzdpf3sKRZpFzQQMp+iQE=;
 b=gSLM8bt8G09MRzVx9M3FXL5QQTKmeCMoicOeQ014rMeqaEPazvoOThNYzZO0Du/3/C/Q9T
 0ve99hjAla0Km0MqjkppfUABQi4uCIq5OYIVXKeXx3gGhog9O+CjxcdIDN0EA9tkTTJg4s
 px2YAvbF0X6fjEEXtLotbAohCSi/pO5/lBDJ9heFVvDKSXP/2f02cICUWJc+UKJ+QPQrP/
 4f55/HKTfzNSEV4DxOIEf5yvFWHwBNTRkItkLNcQPZIt/JwsQhfiTD/2nfILo9EOXfqdIx
 utoHKjjudOtThvHum36Gm/ymcpEfEgw2ZMOOooAl7KJ1tILtTKs9gxB2jeScbg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1771180303;
 b=lRmnyhU0HjCNoaxvstgRtzRR8jxvO4qkhdn8zKBuA4gyq7hGvjsF6zc+OYnB0ZWsWYUx3T
 OMBk5lbt6fHUyX6hZwSZKc5waFaj8V7diwHDujGOTkbvb9T0Fc2EtKC2n68fU/TZA2ae6F
 70LPIJweKJHGQBM1KyvImxblc5w0P+GJaXhsE7jrih1k8cBdjNsr6YTGNz/W59cx8xmAcN
 kQM5LJtk+GpoOINyMrdHUZ1MBIQgHbOExh7Xsgh5f06KYNwXDXIYUUsimPB3P8HptyY/xK
 4HFzV5NmlzCYO0TCnvE5bwXidHZrh5pXmnWHs2hUm3LAl0MbKSeXg8VyExELcw==
Date: Sun, 15 Feb 2026 20:31:37 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: jonny.green@keytechinc.com, raymondmaoca@gmail.com,
	u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
Message-ID: <aZIRCc82mcIxeTWu@kehys.lan>
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
 <aYoFqWew28crCb1i@kehys.lan> <aZDPNtx6-4YwPhli@kehys.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZDPNtx6-4YwPhli@kehys.lan>
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

Hi Philippe, hi all,

Tested-by: Marko Mäkelä <marko.makela@iki.fi> # Raspberry Pi 4

I finally got this to work, with one small patch (see below) which I 
hope you will include in some form. First, here is the relevant part of 
the output of a successful run:

U-Boot> load mmc 0:1 $loadaddr fitImage.signed
9748489 bytes read in 437 ms (21.3 MiB/s)
U-Boot> bootm
## Loading kernel (any) from FIT Image at 01000000 ...
    Using 'conf-1' configuration
    Verifying Hash Integrity ... sha256,ecdsa256:dev+ OK
    Trying 'kernel' kernel subimage
    Verifying Hash Integrity ... sha256+ OK
## Loading fdt (any) from FIT Image at 01000000 ...
    Using 'conf-1' configuration
    Verifying Hash Integrity ... sha256,ecdsa256:dev+ OK
    Trying 'fdt' fdt subimage
    Verifying Hash Integrity ... sha256+ OK
    Loading fdt from 0x0193dba0 to 0x05600000
    Booting using the fdt blob at 0x5600000
Working FDT set to 5600000
    Uncompressing Kernel Image to 2000000
    Loading Device Tree to 000000001ffef000, end 000000001ffffbb8 ... OK
Working FDT set to 1ffef000

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 6.12.68-v8 (root@bob-the-builder.example.org) (aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT @1770573000

After I flipped 1 bit of "ecdsa,y-point", the boot failed:

U-Boot> bootm
## Loading kernel (any) from FIT Image at 01000000 ...
    Using 'conf-1' configuration
    Verifying Hash Integrity ... sha256,ecdsa256:devsw_ecdsa_verify: public key is invalid (err = -19584)
-  error!
Verification failed for '<NULL>' hash node in 'conf-1' config node
Failed to verify required signature 'dev'
Bad Data Hash
ERROR -2: can't get kernel image!

Sat, Feb 14, 2026 at 09:38:30PM +0200, Marko Mäkelä wrote:
>However, this will not work on the Raspberry Pi 4, which defines 
>CONFIG_OF_BOARD. I came up with an idea of creating a device tree 
>overlay file instead:

I found a promising setting CONFIG_OF_OVERLAY_LIST, but apparently it 
has no effect on the u-boot.bin when CONFIG_OF_BOARD is enabled.

>Initially, I tested this with CONFIG_RSA, which I expect to work. The 
>bootm command would start up my fitImage, but unfortunately it would do 
>so even if I corrupt a bit of the public key.

After I added #define DEBUG to boot/image-fit-sig.c and 
lib/rsa/rsa-verify.c it became clear that the CONFIG_FIT_SIGNATURE 
becomes a no-op if no "signature" node can be found by u-boot.

The trick was to add the public key to the device tree that U-boot will 
be starting with, that is, the file bcm2711-rpi-4-b.dtb that will be 
preloaded by the VideoCore GPU.

Sure, this is an obviously insecure (trivial to circumvent by reverting 
to the stock *.dtb files), but I think it is good enough for using this 
piece of existing commodity hardware for development and test purposes.

>Another point is that my initial CONFIG_ECDSA_SW build was over 4 MiB 
>in size, while the sha256,rsa4096 experiment was only half a megabyte.  
>I did trim the build options for the CONFIG_ECDSA_SW experiment yet.

I managed to shrink the u-boot.bin to 645296 bytes, or 56320 bytes more 
than the CONFIG_RSA variant. However, I had to adjust some dependencies:

diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index a5331313a60..14f4d295d2a 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -57,6 +57,8 @@ mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
  	$(MBEDTLS_LIB_DIR)/rsa.o \
  	$(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
  mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/bignum.o \
+	$(MBEDTLS_LIB_DIR)/bignum_core.o \
  	$(MBEDTLS_LIB_DIR)/pk.o \
  	$(MBEDTLS_LIB_DIR)/pk_wrap.o \
  	$(MBEDTLS_LIB_DIR)/pkparse.o

This may need some fixup, so that the bignum*.o will not be added twice 
if also CONFIG_RSA_PUBLIC_KEY_PARSER_MBEDTLS is enabled.

Below is my build script, with 4 lines FIT related overrides because it 
is normally disabled on this target:

make rpi_4_defconfig
scripts/config -d BOOTSTD \
-e FIT -e FIT_SIGNATURE -d FIT_CIPHER -d FIT_VERBOSE -d FIT_BEST_MATCH \
-d FIT_PRINT -d UPDATE_TFTP -d UPDATE_FIT -d EFI_LOADER \
--set-val FIT_EXTERNAL_OFFSET 0x0 \
--set-val FIT_SIGNATURE_MAX_SIZE 0x10000000 \
-e ASYMMETRIC_KEY_TYPE -e ASYMMETRIC_PUBLIC_KEY_SUBTYPE \
-d LEGACY_HASHING_AND_CRYPTO -e MBEDTLS_LIB -e MBEDTLS_LIB_CRYPTO \
-d X509_CERTIFICATE_PARSER -d X509_CERTIFICATE_PARSER_LEGACY \
-e ECDSA -e ECDSA_SW -e ECDSA_VERIFY \
-d MD5_MBEDTLS -d HKDF_MBEDTLS -e SHA256_SMALLER \
-d RSA_PUBLIC_KEY_PARSER -d RSA_PUBLIC_KEY_PARSER_MBEDTLS \
-d X509_CERTIFICATE_PARSER_MBEDTLS -e MSCODE_PARSER
make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-

In my CONFIG_RSA test build, the 4 lines starting with -e ECDSA were 
replaced by the following:

-e RSA -e RSA_VERIFY_WITH_PKEY -d RSASSA_PSS -d MSCODE_PARSER

With best regards,

	Marko
