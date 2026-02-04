Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200DEEA7942
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 19:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9F883015;
	Wed,  4 Feb 2026 20:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="yhfxU44Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C35F838FA; Wed,  4 Feb 2026 20:02:34 +0100 (CET)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F458063E
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 20:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4f5qVG2lgpzyS8;
 Wed, 04 Feb 2026 21:02:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1770231750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SIcoaVqCfROVDQ+2qWhyLARzBQb15EqPVj4fqWgKEk=;
 b=yhfxU44YjxeyITeJ9F1mX9iICrTtUKwij74gS7OMBoeWWjW3YWAJ7qiC/zdMycjvHxjd49
 ahc71xOA0Pqw2MUgO/Amg6ALBoiyXtxUHFQ5/ofZMlzLtKhglW56hrzDvHydBacQjZJDfQ
 bFMa6+dVzEH16whaPyHeDWbPaRHsleg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1770231750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SIcoaVqCfROVDQ+2qWhyLARzBQb15EqPVj4fqWgKEk=;
 b=qg2GcqXGc9sU/Y63RLDn+D5BFqsA2wRh2tpFnIW+ivT3jG8/Ea7LwoJIVXRU0kRsOd3eHJ
 H1UsXRslFwpK8k4BC564nxkQFj2Mjs20K6XL40dJ8S3BluR99BHaSVOTMkd94+D/2GiOot
 dgzVC60uU6JuVkMXlbyIEFK1aRfcKyY=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1770231750;
 b=l5A846OdTYEWNirRERWhLiSnxQxVewrNXAUTl5ZxMNK9FoeM0iI0wWNUcqduQsVwK8Znet
 SIuT0zrr00fudSjS3CD/GyUWGY3ryDqUHYGag6KPSFsRB0Ou7pyEt/1b7x9XO8dlmfoQ6q
 2xid7bfXKQKruaKld9dH1zOFDwNRMcE=
Date: Wed, 4 Feb 2026 21:02:28 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: jonny.green@keytechinc.com, raymondmaoca@gmail.com,
	u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
Message-ID: <aYOXxN-DBm_6LrSE@kehys.lan>
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260202170307.217200-1-philippe.reynes@softathome.com>
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

Mon, Feb 02, 2026 at 06:03:03PM +0100, Philippe Reynes wrote:
>This serie adds the support of ecdsa with software
>using mbedtls. So boards without ecdsa hardware may
>also use signature with ecdsa.
>
>To add the support of ecdsa with mbedtls, I have:
>- enabled ecdsa in mbedtls
>- add a function sw_ecdsa_verify that uses mbedtls
>- add a driver sw_ecdsa that call sw_ecdsa_verify
>
>I have tested this code with sandbox, and I have
>followed those steps:
>
>0) build u-boot using sandbox_defconfig and adding those options:
>CONFIG_ECDSA_SW=y
>CONFIG_ECDSA_MBEDTLS=y
>CONFIG_ECDSA=y
>CONFIG_ECDSA_VERIFY=y

I did "git am" on top of the master branch as of the current 
eb1562cc3e4c5130c76db1c1ea57156322362a7c and tried to build it as 
follows:

make rpi_4_defconfig
scripts/config -e FIT_SIGNATURE -e ECDSA -e SHA256 -e ECDSA_VERIFY \
-d BOOTSTD \
-e MBEDTLS_LIB -e MBEDTLS_LIB_CRYPTO -e ECDSA_MBEDTLS -e ECDSA_SW \
-e SHA256_MBEDTLS -e SHA256_SMALLER -e MBEDTLS_LIB_X509 -d HKDF_MBEDTLS \
-e ASN1_DECODER -e ASN1_DECODER_MBEDTLS \
-d LEGACY_HASHING_AND_CRYPTO &&
make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-

No matter which variations of this I try (starting with -e 
HDKF_MBEDTLS), the build would fail with an #error in
lib/mbedtls/external/mbedtls/include/mbedtls/check_config.h because 
MBEDTLS_ECDSA_C is defined but neither MBEDTLS_ASN1_PARSE_C nor 
MBEDTLS_ASN1_WRITE_C are defined.

By disabling that check I found out that the functions 
ecdsa_signature_to_asn1() and mbedtls_ecdsa_read_signature_restartable() 
really depend on these.

I diagnosed this by executing
make V=1 CROSS_COMPILE=aarch64-linux-gnu-

Then, I edited the compiler command line by replacing "-o *.o -c" with 
"-E -dD", and redirected the standard output into a file. In that file I 
found that lib/mbedtls/mbedtls_def_config.h is defining MBEDTLS_ECDSA_C 
and would also define the ASN1 symbols if CONFIG_ASN1_DECODER were 
enabled:

#if CONFIG_IS_ENABLED(ASN1_DECODER)
#define MBEDTLS_OID_C
#define MBEDTLS_ASN1_PARSE_C
#define MBEDTLS_ASN1_WRITE_C
#endif

Something is wiping that out from my .config, also when I execute "make 
syncconfig" after the scripts/config. When I search for ASN1_DECODER in 
"make menuconfig", it mentions a large number of other configuration 
options.

Can someone help me to enable CONFIG_ASN1_DECODER in this configuration?

With best regards,

	Marko
