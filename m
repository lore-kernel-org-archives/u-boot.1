Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F6BE78D74
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 16:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FC580325;
	Mon,  9 Feb 2026 17:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="Y4HAoSU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D30D802C1; Mon,  9 Feb 2026 17:05:04 +0100 (CET)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3CA80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 17:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4f8qK71zb8z49PvN;
 Mon, 09 Feb 2026 18:04:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1770653099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwrtX9Jwn0k+Deh3xSvv1z5U2dFzYGBJijGpTwY97xs=;
 b=Y4HAoSU4N/582glclrs9e91rDqs+2UNwgnB679fTu95NPs+uOfFL+nUHPfM3TrTzRFHJTU
 fCPx9vaox5MmyK89XwQeYdvZm2U+m1F+m2gWwzQJuezXn5EXpUFVMheSH+Pdpe185Gvyri
 +PJ+6o5xDD5jBZbrt2GcpCoiFtzjShbZDqGzIszUKOn4iNPu0/YNY0s6Wm65XmOw9rKG2W
 q+VZ8PQcUWlAUVOAd4GDXdhQbrwBTlwAFU4SU04e+3ssMZnm+2qdrFT/F448lUK4OdXO6z
 HpSWKR61uLIfwhTMrWbxrpNp37jVoRIuhcPZI8MrFKmEqKawd4+X5GObyXzQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1770653099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwrtX9Jwn0k+Deh3xSvv1z5U2dFzYGBJijGpTwY97xs=;
 b=LMEZipaQqsJNCUzmbJA9OtZwdvNnG7JK7nXHC/tzZIHxQQwHifcxF78JhPKb6Qd9IG4ueX
 nCWozSTdmwnuNEtXGGRYRzpOe9SRcbneW0hVevNMqTsdx8zHBwIyvIEZQpfSzN/YHRBqx+
 SwNgKhhwiDFm5dmw/4HJ1jNRxZfyFoG3vr12sdXc71ZKO+jzvH/Oy1CXeBGZEvSxBFXsPt
 WhrfKW8MKazFclaS3BgPNGRHCtMi7xR+bp+6tld4ZSA1EeYrOWF6520Zs+ldZrEieZ4xWB
 wONBeIEIM6nVYtKq7KTt0Nn/kSxgvyHmCg5uez8OGg7cFFw4SJo0Utfya8pAsg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1770653099;
 b=U84czn7V/jG/oVbtUqwHkm9twPYkIRtkSqdsVmMpTBvCyAiQ6Sr1MhcLApW1al9007eSUW
 2Sj9R0WBP0qPZxzyzyE1YrmLhV6gMxGvxTa9SFHYiJ4Vok66pE/LlaqNjyx7PY7FbNXF1R
 AaI3qXZvuFbSf9khx/y3Lh9mxvu+3nhgjyA255QWTiwOgYHCM/5B8QlsGFJ0GzYp3aYB48
 IXaeHV7ray+S4odfSQdDOuBSeJ2eYhEBegNnG8KmDX9VyKXP5siaJsvrtfg9plKt0zKdzW
 wi/3093jmqY/v5knG+4rEnyYJbdvqj8GRSVvHA+Kn7lkI0L7AbEOYJE29HUrrQ==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
Date: Mon, 9 Feb 2026 18:04:57 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: jonny.green@keytechinc.com, raymondmaoca@gmail.com,
	u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
Message-ID: <aYoFqWew28crCb1i@kehys.lan>
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
>I have tested this code with sandbox, and I have
>followed those steps:
>
>0) build u-boot using sandbox_defconfig and adding those options:
>CONFIG_ECDSA_SW=y
>CONFIG_ECDSA_MBEDTLS=y
>CONFIG_ECDSA=y
>CONFIG_ECDSA_VERIFY=y

I believe that I was able to build an ECDSA signed fitImage of a Linux 
kernel. At least "dtc" shows that a signature is present, just like with 
my earlier attempt with RSA.

>1) add a signature node to an its file
>	signature-256 {
>		algo = "sha256,ecdsa256";
>		key-name-hint = "private-key-256";
>	};
>
>2) generate an ecdsa key
>openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem
>
>3) create the itb file
>./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>

Step 1) is part of <file.its>, which specifies how a signed payload, 
such as a Linux kernel, is built in <file.itb>, right?

I assume that arch/sandbox/dts/test.dts is the source code for 
arch/sandbox/dts/test.dtb. Would this file correspond to the file 
u-boot.dtb in a non-sandbox environment (in my case, based on 
rpi_4_defconfig)?

For me, mkimage version 2025.01 (as shipped in Debian Sid) would crash 
if I ask it to write the public key to u-boot.dtb using the parameter 
"-K u-boot.dtb". The following statement in do_add() would hit SIGSEGV:

         ret = fdt_setprop_string(fdt, key_node, FIT_KEY_REQUIRED,
                                  info->require_keys);

The function do_add() is invoked by ecdsa_add_verify_data(). For my 
kernel build, I did not yet try a mkimage that is built from the latest 
u-boot. Should that make a difference?

For an earlier experiment with an RSA signed fitImage, I was able to do 
the following:

make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu- all u-boot.dtb

cp u-boot.dtb u-boot-pubkey.dtb
ALGO=$(scripts/dtc/dtc -I dtb /target/fitImage |grep -A10 signature|
sed -ne "s/\s*algo = \"\(.*\)\";/\1/p")
tools/fdt_add_pubkey -a "$ALGO" -n dev -k . -r conf u-boot-pubkey.dtb
tools/fit_check_sign -f /target/fitImage -k u-boot-pubkey.dtb

make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu- \
EXT_DTB=u-boot-pubkey.dtb

cp -L u-boot.img /target/

With CONFIG_ECDSA, fdt_add_pubkey would SIGSEGV (unrelated to these 
changes) and fit_check_sign does not appear to be built.

I would appreciate some help in embedding the ECDSA public key to the 
u-boot image, so that I can test this.

Best regards,

	Marko
