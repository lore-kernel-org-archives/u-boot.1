Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176FCEF5851
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 19:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D52483AA9;
	Sat, 14 Feb 2026 20:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="bM+fOWv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD12983AB7; Sat, 14 Feb 2026 20:38:34 +0100 (CET)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DE083AA7
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 20:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4fCzqC3zp2zyQn;
 Sat, 14 Feb 2026 21:38:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1771097911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9gDnK4qvieC9W5sABAVAumAzS7g81uwp279uNf48gU=;
 b=bM+fOWv3oDj5sDuycK5FRH4rWHOmwtrlGhRBzY8i2G1iBX12RbAc7FlgROYjJrZVkyN3iY
 USxKXDCfcX6rtGOr4WXHg9xrm9jWubZJeAHYipy4lU9dAi6I/TVi5MzrF5HwN8p++HN3KI
 +LgFa8lvsWHzp8NQK+OhwKiMnwib84M=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1771097911;
 b=C4CG9pPXp9iNI+jhIMfGjMVfW0CbbNfKEhmycR/oyRTasQfzRMI5G3Fdrbv9tVw29LrbVC
 Vf9ZOUrSmxQ21csWFpvnUQ6NkSs7PNYsx+18Wicrml15xoJEhvVh/P93LpmhyWWswGLabO
 CnlOKdrMCe4kdV1HCLJ9Du6Dl5oMh/Q=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1771097911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9gDnK4qvieC9W5sABAVAumAzS7g81uwp279uNf48gU=;
 b=m4xQx0UosE85nD2ILxI0qoZzpo6I8yGeXNhiSXc3Id/OMSK76G7+jOe+zq/w5hevUJI6DO
 KbR9J6kO9yv8YEfWGB+rKFM5emeNWp1tKRETyu9X9sAWy0BUYkqUnEHaNXuZjnoszsxT94
 eX/BYJA/xxBHNwF4nEGVCt3psEWPng8=
Date: Sat, 14 Feb 2026 21:38:30 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: jonny.green@keytechinc.com, raymondmaoca@gmail.com,
	u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
Message-ID: <aZDPNtx6-4YwPhli@kehys.lan>
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
 <aYoFqWew28crCb1i@kehys.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYoFqWew28crCb1i@kehys.lan>
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

Mon, Feb 09, 2026 at 06:04:57PM +0200, Marko Mäkelä wrote:
>For me, mkimage version 2025.01 (as shipped in Debian Sid) would crash 
>if I ask it to write the public key to u-boot.dtb using the parameter 
>"-K u-boot.dtb". The following statement in do_add() would hit SIGSEGV:
>
>        ret = fdt_setprop_string(fdt, key_node, FIT_KEY_REQUIRED,
>                                 info->require_keys);
>
>The function do_add() is invoked by ecdsa_add_verify_data(). For my 
>kernel build, I did not yet try a mkimage that is built from the 
>latest u-boot. Should that make a difference?

Apparently, something has been fixed since the 2025.01 release. The 
following would work for me with a current u-boot build:

echo "/dts-v1/; / { description = \"\"; images {}; };" > public-key.its
mkimage -f public-key.its public-key.dtb
mkimage -f fitImage.its -k . -K public-key.dtb fitImage

With the mkimage 2025.01 that is included in the Debian Sid 
u-boot-tools, I am able to build an unsigned Linux fitImage:
mkimage -f fitImage.its fitImage

Then I can invoke a freshly compiled mkimage to sign it and include the 
corresponding public ECDSA key in an u-boot image:
mkimage -r -k . -K u-boot.dtb -F fitImage
cat u-boot-nodtb.bin u-boot.dtb > u-boot.bin

However, this will not work on the Raspberry Pi 4, which defines 
CONFIG_OF_BOARD. I came up with an idea of creating a device tree 
overlay file instead:

tools/mkimage -r -k . -K pubkey.dtb -F fitImage
cat > signature.dtso << EOF
/dts-v1/;
/plugin/;

/ {
         fragment@0 {
                 target = "/";

                 __overlay__ {
EOF
dtc pubkey.dtb|grep -A12 signature >> signature.dtso
cat >> signature.dtso << EOF
		};
	};
};
EOF
dtc -o signature.dtbo signature.dtso
cat u-boot-nodtb.bin signature.dtbo > kernel8.img

Initially, I tested this with CONFIG_RSA, which I expect to work. The 
bootm command would start up my fitImage, but unfortunately it would do 
so even if I corrupt a bit of the public key. This would lead me to 
believe that the overlay was not loaded and the signature was not 
validated. I only saw messages about hash validation. I'm afraid I need 
a target environment where u-boot is the primary bootloader, or I must 
override the CONFIG_OF_BOARD and see if the u-boot.dtb approach would 
work.

Another point is that my initial CONFIG_ECDSA_SW build was over 4 MiB in 
size, while the sha256,rsa4096 experiment was only half a megabyte. I 
did trim the build options for the CONFIG_ECDSA_SW experiment yet.

	Marko
