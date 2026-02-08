Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE13EF06E1
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 18:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B3E8341A;
	Sun,  8 Feb 2026 19:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="jbXfCflx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE2683BC9; Sun,  8 Feb 2026 19:38:04 +0100 (CET)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CB3805D7
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 19:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4f8Gm35PxHz49PvR;
 Sun, 08 Feb 2026 20:37:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1770575875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4lYUqVedaVu+kTdrZfFnNzjL9ZNjgweHBgK4KHWDxw=;
 b=jbXfCflxkj0SSh4NYSgB84PnMRm87PZXys2NFzwDgCWHVZohUDi16v1FxOrrw4dn7qPWkb
 /CKY2en0LM/hHrmeQrFsDXuP+woKK8+fOgjHUjsc+5y0DgAKJZMiCb/uPAErummuYc+udp
 Tk5Ji83FOn7cSX6PlJ+oVHWxaioiImn2yZChmCqLXsaJLadaOZ1U8/H8T2szpfToHzVoM5
 bjvTWeyQA39sWIz9BP8/cA9v8It/ubdXJKlllDFqZvxlWia5Aa9mTUBJGLgBQh8G/YhWuK
 Y2PqcCq5flbDXVkA33RC63+ItZ8bUhGyP/4ppOGU+s91WkeZseRsHwFb6Z1SMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1770575875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4lYUqVedaVu+kTdrZfFnNzjL9ZNjgweHBgK4KHWDxw=;
 b=QOIfXy1OgKpNL2PjtZTL0wiwenxHhKK/COVsXXybvirPNJTcG20ltLMArZxaYVVA9MdAZI
 X3888b0t3BRacMaH/GnvDwB7Bv/WQV6N4Ih+jbAhoOx6CgRV3vfIc/5/+bq27jRNCgPO9T
 q+KKRSnmLkk6BW7FVPTfQqb8f9NEb1MTG/XtKsqZRxcAC9KuuVt/1X8eiFVWPcFBjBuxcy
 KoeWDKqTj5uGkMPrZfFQz1iyW0misjKawRw6HFTa+m6RhVLDFgrZdJURio0vHKDid5DH8Z
 bYDIbe6mqbavL8yi4ARDS2o9+d+semDYVuRjuk+H7XPzM7enqyeIelMi7lbntw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1770575875;
 b=Cbf2wgUZ5chPT5otpUkL0eJlKjo9Xt3aeRsi/ERVPbBiiHp4a7y40lRDObSAkGwPamHxcT
 WinD8aItaoRvpaG0ME9OuqZ4F4X8BGatgqgMRFcf9dCkM8F1P9XdYEWLJYAz01tI1dEVOF
 l2OOHne+m+FLKehLhljaDbDoJCwMHBLSRafPQtDGsUKtRfwJrJWNuBEUjne673L1Mzdn8a
 IlWSdlrTaDEzcmUGnRRd1Jb9FC3bgVtBe1nJblwyK3fnKIzoenu/0Gi5pjWI40jY4Rwra9
 Nrlg/JlVcFqJVp7mHaA/ImX+58UrYR0WSB+GzfGdhyOnCfAqiW+uJIM5uo23kw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
Date: Sun, 8 Feb 2026 20:37:53 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 jonny.green@keytechinc.com, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
Message-ID: <aYjYAY-num_VZowK@kehys.lan>
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

Wed, Feb 04, 2026 at 02:28:53PM -0500, Raymond Mao wrote:
[snip]
>When EFI_SECURE_BOOT is enabled, all these dependent Kconfigs will be 
>selected automatically.

I finally solved my problem by using "make menuconfig".

It turns out that CONFIG_FIT is not defined in rpi_4_defconfig. That is 
why some requested configuration was being disregarded. The build 
succeeds with the following:

cat > boot/rpi_4_ecdsa_defconfig << "EOF"
#include <configs/rpi_4_defconfig>
CONFIG_FIT=y
CONFIG_FIT_SIGNATURE=y
CONFIG_MBEDTLS_LIB=y
CONFIG_ECDSA=y
CONFIG_ECDSA_SW=y
CONFIG_ECDSA_VERIFY=y
CONFIG_EFI_SECURE_BOOT=y
CONFIG_EFI_LOADER=y
EOF
make rpi_4_ecdsa_defconfig
make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-

I am yet to build an ECDSA signed fitImage of Linux and the device tree, 
so I did not actually test this implementation yet.

With best regards,

	Marko
