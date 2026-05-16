Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B170CD4F25
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 17:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9053E84676;
	Sat, 16 May 2026 19:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="u5v+BtGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B672E84686; Sat, 16 May 2026 19:23:04 +0200 (CEST)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688528465A
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 19:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gHrVn1cRxz49PtL;
 Sat, 16 May 2026 20:22:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1778952177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ny7O9TRmu4iBH6tGVPfHng3UT+7xkp/fPdwL16jBJHU=;
 b=u5v+BtGBxVSTFTMwLivkluCD/NTEIqJjOv+Ve7Q9O/d9fkyIqBfS3cgSPXtWnaY7nOx2sT
 zZ1v1SKhFvcVGDcSoMCqV2wDAT9/tb9mZ+Xn5yFuhjw/1XXNxuuDLaPyLs+d7J+CKrS59r
 TRN+Jqti89KSKfpnmamNolPdTMgUQr9QNkffb22NTiPKVnRbaPFu76cYUhqZr1wZrwGyUp
 0jrHNnhkaoaA0O56hl9JOuftdifKMS6mpJzTwX9UFxZsXf+hCJ+EIJnUGcZi+0yfDH07sI
 4B/dE2gf5Arl0mNhXfR3JeGUPbt11RPV+nH9HA8ItQBF6m4SenvQUFH+gKAayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1778952177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ny7O9TRmu4iBH6tGVPfHng3UT+7xkp/fPdwL16jBJHU=;
 b=IcO2n1gEEkDzXhB3NLLhZmJvYE1stogTwUskHz4mZhTYFI9ED53+AyqA9e5jIN6jrvaI+y
 Y4tkJhUqqtjvZFnYssNWWGOnLrSFoI6+9rwSlqOpD6FbWn5gMOOlrESUvReUuDhzP9zoJ9
 f6azz/iq0r6p7WGjf/YNZQU456GFhmrEND+q9wr5Ode+y3fv74wVUg848vGyVqKFAi13Yf
 uNz+Zdzmh+rs+nimIPZO3fsni7uF7sIM4yjwFTGi71WhNj6tfdl+f7RuTc1w5V6uyOo5A9
 OKIn/+o79URY1WiBuj4R3WabmuF2HBmmGFnCL0xpnXMhy8p0XB5dJQpDZuzxDg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1778952177;
 b=rYvuDYHLqpljzkmf8lWrhQHicF/GlJ7UmMJ6SHyUmxc5k+B9Zi/jBZsaD0N9WAzbiCF/ju
 69cb2lD+8QNWOT3kDvSdLAnoLfwO/4SEqTH/xaJecQd4sTOqATfjOaG0yeeqT2sXUC2cXh
 lpiu6za036aI8J3iY1rKK+HVJ6qpQypTnn3c7Ujx4pDOSUB1CrdSssNpu6Kr6SVqbG1Vcv
 fKEE4B6EIUiYEZV8gwz608CC3azqpjMKu4uZTX0VD3QcJjzrdvHocLnW/6MjmBYDKWE/YQ
 1XD6NGR18o8QPp1u90zrj7gxqbboNHeFvD4/7d3HzpP0Nd3hONxKr9X8Hg1bSQ==
Date: Sat, 16 May 2026 20:22:55 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: jonny.green@keytechinc.com, raymondmaoca@gmail.com, trini@konsulko.com,
 simon.glass@canonical.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 00/15] add software ecdsa support
Message-ID: <agin72spk-usvOVz@kehys.lan>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
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

Hi Philippe, all,

Tue, Apr 21, 2026 at 11:09:39PM +0200, Philippe Reynes wrote:
>This series adds the support of ecdsa with software
>using mbedtls. So boards without ecdsa hardware may
>also use signature with ecdsa.

Today, I finally tested this patch series on top of Robert Nelson's 
u-boot v2026.01 based fork for BeagleBoard PocketBeagle 2:
https://github.com/beagleboard/u-boot/commit/ef03e35488377a32cdd4f76d1a03ef7f60c798ef

The only conflicts were for copyright comments in some files.

I used the following configuration; this platform enables CONFIG_FIT and 
CONFIG_FIT_VERIFY by default:

make am62_pocketbeagle2_a53_defconfig
scripts/config -e ASYMMETRIC_KEY_TYPE -e ASYMMETRIC_PUBLIC_KEY_SUBTYPE \
-d LEGACY_HASHING_AND_CRYPTO -e MBEDTLS_LIB -e MBEDTLS_LIB_CRYPTO \
-e ECDSA -e ECDSA_MBEDTLS -e ECDSA_VERIFY \
-d MD5_MBEDTLS -d HKDF_MBEDTLS -e SHA256_SMALLER -e SHA512_SMALLER \
-d RSA_PUBLIC_KEY_PARSER -d RSA_PUBLIC_KEY_PARSER_MBEDTLS \
-d SPL_ECDSA_VERIFY \
-d SPL_ASYMMETRIC_KEY_TYPE -d SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE \
-d SPL_RSA_PUBLIC_KEY_PARSER \
-d PKCS7_MESSAGE_PARSER -d PKCS7_MESSAGE_PARSER_MBEDTLS \
-e X509_CERTIFICATE_PARSER -d MSCODE_PARSER

I used these settings also for the 32-bit 
am62_pocketbeagle2_r5_defconfig which loads the 64-bit u-boot.img.

I tested this build with an ARMv8 "defconfig" of 
https://github.com/torvalds/linux tag v7.0. An image that was signed 
with a different private key was rejected:

=> load mmc 1 $loadaddr fitImage
15013689 bytes read in 180 ms (79.5 MiB/s)
=> source
## Executing script at 82000000
sha256,ecdsa256:dev-  error!
Verification failed for '<NULL>' hash node in 'conf-1' config node
Failed to verify required signature 'dev'
=> bootm
## Loading kernel (any) from FIT Image at 82000000 ...
    Using 'conf-1' configuration
    Verifying Hash Integrity ... sha256,ecdsa256:dev-  error!
Verification failed for '<NULL>' hash node in 'conf-1' config node
Failed to verify required signature 'dev'
Bad Data Hash
ERROR -2: can't get kernel image!

A correctly signed image passed the verification:

=> load mmc 1 $loadaddr fitImage
15013689 bytes read in 179 ms (80 MiB/s)
=> bootm
## Loading kernel (any) from FIT Image at 82000000 ...
[snip]
    Loading fdt from 0x82e430d4 to 0x88000000
    Booting using the fdt blob at 0x88000000
Working FDT set to 88000000
    Uncompressing Kernel Image to 82000000
Error: inflate() returned -3
gzip compressed: uncompress error -3
Must RESET board to recover
Resetting the board...
U-Boot SPL 2026.01 (May 16 2026 - 16:42:03 +0000)

I think that this can be declared as a success for this patch series, 
even though my kernel load address is causing trouble.

With best regards,

	Marko
