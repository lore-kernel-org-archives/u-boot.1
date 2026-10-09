Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9CFCA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC19F8129A;
	Fri,  9 Oct 2026 19:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zMlu7sW3t6lu; Fri,  9 Oct 2026 19:33:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0974281158
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791574411;
	b=WNm83jnxFuI+Bcx9bPQVPgjkyn+iMLgxOTzTFLlBKj157+KZZ8F9TXuY7xfZzdGTGWP7
	 fNAMEtC0ECmUAqXBpwsLzUPlFzVpqdCGz+2jlHv2OGIbHZf5q0n6ZpsndTVoOb5C1S7xa
	 SxxIyYhFnp3ddqRhDmY+u3XEnOO3mt5xUa3GsJtg2PMhRFQweM+OaO+ZDWzOsSspSJ2sZ
	 i+sUHS+HaG1N2oxXQx4VnLE6HOYrsE3kn0vp+etqy18PF1PEVELpVQB6U8gW1Gc91sssw
	 OVGTGkcNvkSxbNBpYEmeRGImEWck4beDIFa/7RRSmS+Bvg1p5oVJaMZFUOY19YActXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791574411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VM7P7Dq80VJ+TW7/ntuBrh5EW9Fe37nFWCV76QYDkFU=;
	b=oRewGRFH0KARk2oSHmDaKx4QmF08zL+C0xBUlYahfnD5sX7lAtnIvG1cANR0FLxXCeOw
	 3uWZwtFQtQe8ZGmYrzJroAWFeaEGNdX2cs8b8Jg0MUjtHIpQ0Idr8PEtgBkNjxQWz9PG9
	 jQvewv4sCOtcqoMOrxFhQiMaGIxun2sOxR/Py+lOR5Km6upJoBE4C4gPkMh73oFl0TBje
	 ZbccLvhWWzd3R75XiR7r3ZZJXbazjK2lutcyqeO4zppW7ACENXSYGevoxPaLJlxHvfKt5
	 cdrg7vQkQYzGvYt8hj4BRtWoP8v03biYk2pVhs+NkczczLawP3zd11et9T4l+8Tou9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791574411;
	bh=VM7P7Dq80VJ+TW7/ntuBrh5EW9Fe37nFWCV76QYDkFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BS574ROv9ujh0Dzbiqina4bvLq89vMIRtZZ9h+1IkSeivsABk6Brs6Usqx5Qi3Z9c
	 krEVVepvqMXwVDAqpMq5vZVgcIDGQFqeqMV4XzWV7GPsr7UlOOYch3hTt69IbQdRed
	 OED5YHYlD/XFe/rjicX7UcmLtqnjPipuMQcjaPN3g0/q0rZNX3hj6O/Vt6dHt0x4RI
	 fWBGkVnAK4pyJnCpPZq6+bZWBM/yWBOaB4vQypTv9u0pjPNpGChhuc1Ucz9bvn6JNs
	 D7cwXkHKXAmRYEospn0F6SYkpPigNCnynIqlSYoF8lF4l++hZmn0+TLFJb5ENwnrPS
	 gOXB9eF/gyfGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0974281158;
	Fri,  9 Oct 2026 19:33:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57F4E184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DD4340080
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OuxIEPCc65Rq for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:33:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7F22840053
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574409;
 b=r0W6gWrx6iSbLvq9Xxtm71gCsh8FmGhw7Ds/cl056ulwdOb0OqKOmYMs8jMCr9GCDciu
 c0PGkdpgvQGBCAjPzr2WOW9+igmmfaHoiJMLRnuQkq2Y5VS0rdz4X6xApbVIoF1fHueke
 3xJoQQsaVnI8w7Kc0czGRuv5WPeC23wGge2my0IeoSRhgCN30zxhaECqDxb28JCslEXRw
 5VTUpEZ0MXnCMNY3pKedmAmhSYE0ujfpXRYHQjVE0VfFPaqnT0REvL0DjBgaYwlv2wTfY
 S+yzr5Ov4uHXPIxnzbMGFuKXEH9UEnzKFFerUboln6NBJjwkJRb2ZU8bHMHslonZurg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574409;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=VM7P7Dq80VJ+TW7/ntuBrh5EW9Fe37nFWCV76QYDkFU=;
 b=A53VcUOlmepVRLTmwExN8VT9PFpXzhZ8w+tt5Zo49Qu0kagKDOZN6D9CYPv6vCcf2UMu
 bkUmzYZ79rDIoMDS2Vk55gajh+j296hldmyVIIYN0Qo3JjfmxAwLhdvGif4KLOI5Ejxr9
 sIimyUzYBO1unkHvg29xtMdBYj7/8l+MS6QSeCF8/6ItvaXFEgDwa1vBqBs84rB9Ew7IA
 QQ09MFzoTHtnCWxVw7iijHJ3EgskFPqYPNGyBnsqQgZd7vnho0oq0k+V090+42OI7ZQCw
 Z/zEkB+/G77VCXVKczs3/CP8lnTiNfw381UQDbJfJrHulziPSVmHFEVkkslUazsYIMw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lO66l01e; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lO66l01e
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F22840053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:33:28 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-8266c388b67so148140a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791574408; x=1792179208;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VM7P7Dq80VJ+TW7/ntuBrh5EW9Fe37nFWCV76QYDkFU=;
 b=lO66l01eDW9tYwXK+NdJsLyivXjdwFV8psBhip1aMaMvxQ6AIbgZeSampgYVHIc3Gf
 HOCNTe4rD0qi7oYTCXNblq840OAeQudeFKqmmz4swKsd+jihgNsh/u4o9q/K2DkKvXPZ
 FXQ44jkAi5Og1BKpvm8A86oeAhOAwn3L0QSf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791574408; x=1792179208;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VM7P7Dq80VJ+TW7/ntuBrh5EW9Fe37nFWCV76QYDkFU=;
 b=VecQbuTN8+xUHcUyTt8HWweJS3tudb6X5re/X1TWiD3oQz79alnBCaHld4mq8BK0Ze
 u6HRnIAObRC1Zg/ccHpQVt2/vbBG3yZ6ZH0M1qStLyEXetRb11PXsVu0r/jmeV7IWlB/
 iqOCBi0Mi3msAHO8CtHRhOQew8Hz4a8p9RgZUmj5ZufHVNpoAxLZkOVlUMcgAbr6FfUF
 gFg2x10MOXQrHDccc8x89ZiLnzXpIwn9VrnAHXZWUJGdHJyILxm2yfyqsErIK/18ZEVO
 oLbM/sPCK6yHoTgypBGnkWXJZ9rEWmgVB3kwWmJSiZ8uWEEIUYuRq7sLJ3kBhLo0YIzg
 2aSA==
X-Gm-Message-State: AFuF++kR3q9b6v/NCPEnl4UxyNTUbjhUlTWeICokt7x5szJXU+MPZDa9
 2Okb1/CWzchkZRdq4QW4CxdGiXIiYghBfp0QvfF71QKb7aKIkTB/5Xplktb7DqTyVGU=
X-Gm-Gg: AYBFou0y8WrYvkeAtQyxN35urGb+IwDcxtrBmymFCd8JdghztEmk20rDScCHBQrDX3v
 VBOK23HxRV4ET/8lXr2pj8WrReYe6kbafb/KYBOTU+vNBYCK8Mmdk9Fiikm6oMlLBWmVM4Wgylx
 PyRctFsUP9DaUPeNtO45xJeVVjzxR4PyyEXkCz/9iToNnkMXDre+8rEhPEqSmGWnBlFmvznTNew
 Y1SImK8Nb89t2/rcnMbXNtn41+6ocBzOnA3d55wRPBooMcBVwvSw+1ZVCDMNXS1gzKGp+ZUrK0c
 +yL3A4ybRdL6VKjD73FTmhdvThALWOEfZtv4dEhdJlgRsk4Bk4U2ANKzMUuEPTiTPD319YOb3B5
 5ep5iA7po61ZwjbpgQdre01cbOUPG4ERK2eyXyi0tNOXC2awJk+i/5Uri/HBiIhjNIjNG6zVWHV
 W3xKoonN05PIFsuvcwanQ92kp3R942A/XP3TT042RSgPSqRSvL+t2qAcq7hzTW5JKJ4CdeY0EQE
 d18B5EgvFp6SRGDx9c5bR6x+Zp4XNkdwlzLSbASKQ6ZLAnnfxEyCyHFpGZOUG12VHj3EISM2VSk
 8IOjg5Ify4sPm2fCHKRfA1Yz/n46tQ==
X-Received: by 2002:a05:6808:2222:b0:4be:d8dc:be57 with SMTP id
 5614622812f47-50c4084ede0mr2940050b6e.4.1791574407997; 
 Fri, 09 Oct 2026 12:33:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1c1246cbsm2871881b6e.18.2026.10.09.12.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:33:27 -0700 (PDT)
Date: Fri, 9 Oct 2026 13:33:25 -0600
From: Tom Rini <trini@konsulko.com>
To: wadowski.arkadiusz@gmail.com
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH] board: qemu-arm: Add SPL support
Message-ID: <20261009193325.GF769217@bill-the-cat>
References: <20261009-spl-for-quemu-arm-v1-1-8ea39068f888@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1TdSqvGn845OKyhf"
Content-Disposition: inline
In-Reply-To: <20261009-spl-for-quemu-arm-v1-1-8ea39068f888@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--1TdSqvGn845OKyhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 06:18:34PM +0200, Arkadiusz Wadowski via B4 Relay w=
rote:

> From: Arkadiusz Wadowski <wadowski.arkadiusz@gmail.com>
>=20
> Add an optional SPL boot path for the QEMU ARM64 virt machine,
> allowing the SPL-to-U-Boot boot flow to be explored without
> physical hardware.
>=20
> Use the existing NOR loader to load u-boot.img from flash into
> RAM at 0x41000000. Generate u-boot-with-spl.bin with the payload
> placed after SPL padding.
>=20
> Signed-off-by: Arkadiusz Wadowski <wadowski.arkadiusz@gmail.com>
> ---
> This patch adds an optional SPL boot path for the QEMU ARM64 virt
> machine. It provides an emulated environment for exploring the
> SPL-to-U-Boot boot flow without physical hardware.
>=20
> SPL starts at flash address zero and uses the existing NOR loader
> to load U-Boot proper into RAM at 0x41000000. The combined
> u-boot-with-spl.bin image places u-boot.img at flash offset 0x100000.
>=20
> QEMU provides initialized RAM at reset, so this boot path does
> not require a DRAM initialization sequence.
[snip]
> diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/=
Kconfig
> index 447061b25cd..c6bfb82e7f3 100644
> --- a/board/emulation/qemu-arm/Kconfig
> +++ b/board/emulation/qemu-arm/Kconfig
> @@ -1,3 +1,7 @@
> +if TARGET_QEMU_ARM_64BIT && SPL
> +source "board/emulation/qemu-arm/Kconfig.spl"
> +endif

This guard should be in the new file.

> +
>  if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT
> =20
>  config TEXT_BASE
> diff --git a/board/emulation/qemu-arm/Kconfig.spl b/board/emulation/qemu-=
arm/Kconfig.spl
> new file mode 100644
> index 00000000000..38002a87b70
> --- /dev/null
> +++ b/board/emulation/qemu-arm/Kconfig.spl
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +config TEXT_BASE
> +	range 0x41000000 0xffffffff
> +	default 0x41000000
> +
> +config OF_OMIT_DTB
> +	default n
> +
> +config DEFAULT_DEVICE_TREE
> +	default "qemu-arm64"
> +
> +config QEMU_ARM64_SPL
> +	def_bool y
> +	select SPL_LIBCOMMON_SUPPORT
> +	select SPL_LIBGENERIC_SUPPORT
> +	select SPL_HAS_BSS_LINKER_SECTION
> +	select SPL_SEPARATE_BSS
> +	select SPL_NOR_SUPPORT
> +	select PANIC_HANG
> +	select SPL_LEGACY_IMAGE_FORMAT
> +	select SPL_DM
> +	select SPL_OF_CONTROL
> +	select SPL_SERIAL
> +	select SPL_DM_SERIAL
> +
> +config SPL_PAYLOAD
> +	default "u-boot.img"
> +
> +config SPL_TARGET
> +	default "u-boot-with-spl.bin"
> +
> +config SPL_BLOBLIST
> +	default n

We should be able to omit the dtb, and then pass along the dtb we've
been given via QEMU from one stage to the next, like some real hardware
platforms do.

--=20
Tom

--1TdSqvGn845OKyhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaslBfQAKCRAr4qD1Cr/k
CrFJAQC4tRBUSWx75vIdePxI8OLjUs97ff7Wc9Bwm5Y6yNYn0QD+NGOGISbOFvik
fVOM2VvpWQr2oBfiRU+D2E6hzSLlEg0=
=43Sa
-----END PGP SIGNATURE-----

--1TdSqvGn845OKyhf--
