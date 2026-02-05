Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0B9ECD992
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 18:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7A283BC4;
	Thu,  5 Feb 2026 19:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="vZ0O1DHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E1C483B95; Thu,  5 Feb 2026 19:16:50 +0100 (CET)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E40C383BC4
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 19:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4f6QQy3zWZz49PxR;
 Thu, 05 Feb 2026 20:16:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1770315402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ThVLjx9osoD3Jt+PMfET4Uz+qbi97wLDNFePRX6IZNQ=;
 b=vZ0O1DHtc5ECUWsal0xkJ9ySBXDiu+3CX5UVMMxCJEVla5nrxnQ4F9WlRc9q02rfkQ6J5+
 XAVr49dMTtG3w2W0Jt7HCu3h9DEula1A1W2VS6+hJU6/FZL/QqA9Opua6gTSZxJln7w592
 jRJKZWrUAKVQXiLnhrzjrcDe905UXXIcams2gMVMmgGb43utfKlHC53Ol38uWcssCiTakQ
 y86pIMZ3kvLXi8K5KzwN6rMMbN4OTRNPA40RGTAC8Bb+5U1t1nTjOUpyJzSzvpZC6TSi1Q
 3DgOjC+zHZ9XgNAR7a1ASpVEoJBLWvMr90fRzc6OB8AKa4B5vo+mNs/iqkaLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1770315402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ThVLjx9osoD3Jt+PMfET4Uz+qbi97wLDNFePRX6IZNQ=;
 b=Gm8jf/FMIqFyZAVTntysDmTzgobmIieYEiVzmSV4GraXNqe/joLzR6WiGKiMwtxB6iF+yQ
 Or9F2xZir0DWsojmCM6korBohPsdZW5OYeEYMWGXK9cnK04Um3IE2H66xxpJtjLqr6KO4Q
 hRC/b/HzvZI2zC2NR+zYdWTKwfMtcyVXlLHm/cmo4Qeltp/7ZSUT5O96lruUvNJA63N0YJ
 e6UuXZDpoZWCdLeQKlSdip8ZpqnUVRweDr5haiig3aWodO9R4GNjrc0QzkYeztEXSC5zVW
 cVoeXM1Z5GKhE78k8VFJM2mOJMwWBU1NR67nXwrVB2lTsl6IzlZFCOx0uQAllg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1770315402;
 b=PkVyCXbXC+RdeXtxrVmm0TwE719JEVZK6192RT6VEdmJYSqi+meWxzYiUBYz8wLQyfKClH
 SKgR+vn/LxX+kYCFn9wCWTeb2FrZ1vctOBtXgbknsdJq4fr49t8KgvwT/T3UnXnzo/Rjj9
 tA1z0jjIjBslmLcLMRx5kJlDlq3pt5Gkv/S0bsBtkSmNowXkYHdfwg0BEpecU1z7dKmLts
 ai1W7xWYRnKk7IMXE3hRACr55JlKsRaniS0WtwxZQYTHtTVzTQ26sOpV/xN/b0hyk46CT+
 jEh57B3aVU21iulRcA7mc5nhiqC27AWpnrYZ7Kkz/855lgon970B1skkEy2s1A==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
Date: Thu, 5 Feb 2026 20:16:37 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 jonny.green@keytechinc.com, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
Message-ID: <aYTehXWL9mAJoMeh@kehys.lan>
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
 <aYOXxN-DBm_6LrSE@kehys.lan>
 <CAMDkj5y-GgnwgnuQKnDY5AJAL8XWmCXWsFdKtj93VjEyR=b0oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMDkj5y-GgnwgnuQKnDY5AJAL8XWmCXWsFdKtj93VjEyR=b0oA@mail.gmail.com>
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

Hi Raymond,

Wed, Feb 04, 2026 at 02:28:53PM -0500, Raymond Mao wrote:
>Hi Marko,
[snip]
>When EFI_SECURE_BOOT is enabled, all these dependent Kconfigs will be
>selected automatically.

Thank you for your help. I can confirm that the following will build the 
ECDSA_SW implementation:

make sandbox_defconfig
scripts/config -e ECDSA_SW
make syncconfig && grep ASN1 .config
make -j$(nproc)

The redundant "grep" step above would output the following:
CONFIG_ASN1_DECODER_MBEDTLS=y
CONFIG_ASN1_COMPILER=y
CONFIG_ASN1_DECODER=y

I still can't enable those in any rpi_4_defconfig based build attempt, 
such as this one:

cat > configs/rpi_4a_defconfig << EOF
#include <configs/rpi_4_defconfig>
CONFIG_EFI_SECURE_BOOT=y
CONFIG_MBEDTLS_LIB=y
CONFIG_ECDSA_SW=y
CONFIG_ECDSA_MBEDTLS=y
CONFIG_ECDSA=y
CONFIG_ECDSA_VERIFY=y
EOF
make rpi_4a_defconfig
make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-

This build fails in the same way as yesterday because none of the ASN1 
options will be present in the .config file. Neither will 
CONFIG_EFI_SECURE_BOOT. Many EFI options were enabled, but not that one.

On a positive note, CONFIG_LEGACY_HASHING_AND_CRYPTO was disabled 
automatically by the above, and MBEDTLS was enabled, unlike in my 
earlier attempt about a month ago, using an different u-boot revision.

I also tried to enable several options that CONFIG_EFI_SECURE_BOOT would 
select in lib/efi_loader/Kconfig, but with no success.

Is there a way to get some diagnostics that explains why Kconfig refuses 
to enable a particular option?

With best regards,

	Marko
