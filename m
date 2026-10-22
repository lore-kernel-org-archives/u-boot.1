Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B26606A31F
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dQoHlPn4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=KLWkb56h
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60E4B811E5;
	Thu, 22 Oct 2026 18:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqOhxDVlp4kS; Thu, 22 Oct 2026 18:29:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 974EF80D0B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792693767;
	b=JdUOEGgRf2tSKrxvNasrb9R/Ujm9cfXG9/b+RM2ikTX9Sz8XNSx17LUhyNLGKvSbrCpc
	 jZ53G4aN+H9qv4yxmhEopxvMJQTmf4qhuFYbMakD2rfGfeQLwlOjq/oPEgXFjfsmXUiKE
	 D61dDl2NrVCDF8/OBh11GSBY+KYshax/vIUfjFfFmLumxoZ/pk8+ItrepcupynIk7hO/C
	 fxKhApM0NCjQAZIzWTDGXE4PabUBU/mazdHRL4XgZ1d1RLwmJ6D8dRsKYFGOoLvhSD3Ot
	 F3ZoTVgn3jhnU8RFV+tQlkAIZIIul340UGZdqKNQNno3huZm9TlT1pcHshyIwdXiMcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792693767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=A4G5DPcE1jkZ+hrCQkaGhWKYszrV2YTZPNnU7QMrJb0=;
	b=Lb6a8WWLidUgQsd2I7tUGLiOsfqUyv1ZbDA7fj1Kl44Ayh5I1MVDDenxfX3as0V+G/PG
	 2D3+r7XawbQjQ85excbFnSALo5EbkM4MeQgZZmDB57t+tMYhF2fj8X70UUb2FQBkgirJb
	 zKTiSuFSzUmpE+8I9tNfzMtM4BloZIHzIXxcjlTQ6Vv8DJadW2ITYp7xNfTaiScrtwfSd
	 ccWYrI3ky1cdkCFL04+Sif6n2IN57EY7fyXqZ0OTTTQX2RRoAtoi48b+K+HcK5nu1FOwQ
	 1vYrbLL9Hym6lUUBdI9b/0oOarGx7+etzdDASRVmxAHvoWk+np3sKmm8BKU6W0HK1+Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=KLWkb56h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792693767;
	bh=A4G5DPcE1jkZ+hrCQkaGhWKYszrV2YTZPNnU7QMrJb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQoHlPn4U8F8OfKSiu22mJ1EjeoN5MwoVil/C2AXyB+XThS1A93JOLdi+r+I0PAsY
	 aNowUCYgfLFL9QRNjUV6BDlampe2Z25ZWWEbak2Y40Pb1KUj8qvGFfSpA5ajWjXgiV
	 s/WYP1PC422tfiZGeBwxaVRRYQoSzQY0uqOqBtmQGH/+aLFP7B2GmYm8jK5atr/Wcf
	 8z5b4/d4vOIOultXqiuRC8AofIV9Ze4oTz36OBNBOfPN1YQ9Z79M2ls1OMGor394Nv
	 42LJX1DOGGOwyj6NgmW99s/mvSBtuIGOqtFiyfQS4y4bfCVm0hjXN2jHeamAgxSXKP
	 d6rsqANKyakBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 974EF80D0B;
	Thu, 22 Oct 2026 18:29:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D01DA499
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C163880D0B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:29:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwXSgGx0CWXv for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 18:29:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F2A1480D09
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792693765;
 b=kQFkYmfWg8ZsauZATQ5kxUSP8YVN9gS8pZ88vqPMe+UwgMtt20QZKRF41i2K30y7u7G0
 4/HOBEu7QxviG/bOZux3Bvkh8CQz0p1Az8T2oxGr6rmM4cItrVKFdIyx5gkDmcO7ZkZL/
 2IhYreXGa2aHTI4voI3ViZ9kzjSCLXlQFPgl078kRwM+mp30H1eCX/3BupmA1bogR79JV
 I0iCDnYha+Ds9VDjGrk9jreloms0E/WwTuyBy+yqxxdmAkVZU4KE/57m1DNsq5fpsM1oX
 awnClZR1+0aHXHspUR2N/rXERRPJiYyYzoSkMS9mC9TlWShkzW1clB1hU6b7FQYNS1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792693765;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=A4G5DPcE1jkZ+hrCQkaGhWKYszrV2YTZPNnU7QMrJb0=;
 b=V6MPcPXJGTgbD+Tw77m8KFjnkmFQoN6s4jyjGWgrcFMZSr9TUKYNXvtcVYIqMLYAQNXm
 VtQo+zFeT6yUWRn49IOuM47yaltI670iULMs7GdmxctnDKDaQ6UqE2mhgPfKFKTtwSzC6
 dtQCh9nTuU0EPgWep7lE4TVsCqHslphCIg96Q3iAci4hbdApdpp50i5Ov3jsiaUMLu26W
 lLvwjrH6DYNK/YbdkpY/whdaRUa8Bmjcf5/ACKz9JMtH/eenigkWs7NvqBW+FV6gmCxYw
 TvZuVLfl1oAe92aeu/qXMlT3oCwx29/ndpO6oQySx+tSnorqfiBvj3tX91RSeF1MLhA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KLWkb56h; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KLWkb56h
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2A1480D09
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:29:24 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-81ba09a5d23so45646a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792693764; x=1793298564;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A4G5DPcE1jkZ+hrCQkaGhWKYszrV2YTZPNnU7QMrJb0=;
 b=KLWkb56hdxLt0VGJHS3m7jJ1x1DmLIq/5K50FiGUchAFPRBzCjZ91ecm4pLikFlVo3
 RcXFCIkSMcAGe6zf+VMSOOJPLLypN6f4mpYivGsysdcP+b67IqwRcRRTX62sXuiWTWBl
 M1kKs6bEuDNA7tjEhmEkC+CKWCkRJrHvO3lkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792693764; x=1793298564;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A4G5DPcE1jkZ+hrCQkaGhWKYszrV2YTZPNnU7QMrJb0=;
 b=nBOKN8z3zJesbM5Zsb21buGCbe2XPeC7gB+/n2mnpt6lSkissPeQTv5a9O39nps96g
 8kjkYXlIW3egjaGLTBFpF66146fBhJPXBYtbLcnPO5MsHYYyH3mLUfsqsXqqBxnhJez3
 NkeVAfrSWGhkOQbXRgTUu40seL+0LXYGLIlGGSwv4+ndr+r4bS399Qr1tAO1i0sxYb9n
 2AInuGE3XsHcgm75GHW1u0ZwkLqOwZQc86J8zSzRRWLCDJjRMR38+CZ7nHvqAnIlaDud
 cipLtKkcZiZvjNPkvom+HKCkos/xFLAR/vUgZP7Utwj4Zw03MRTP+GtQ9fi1V6salVFl
 JqUg==
X-Gm-Message-State: AFq9FYIRCGOdEb7Du0okHKDaiplTuzVBw7nTlyCC+IyvwRoN9ksfCVNT
 QTI/9wriVdGpjWIwM0jegMShG9U9B9akAo3goZDo9ZVdwOL4Xs+FTkOwWsJmj1uJw14=
X-Gm-Gg: AYBFou2CF518aAqOVcaLnC9HtgMMkyOpb5SxC/jZ2dVJiSY0g3z7RPTM6MYKcYnurFv
 Hchawla4Z37Et7sD+MR7zHn0VksSiFiddQRqWLiChVeBfWfPb/RprWn7RVIYuExTDf5KT5uGQS6
 xov+cT7JsmGh0pE70zDIkwy+jS13Yhb0tvzeQRCF6wgAUdNe0ZETMiRxK/XdxYCui2FYnhFbaMH
 /52UBp09z5fV5knYUOA6wVd4Zj3/V97AXoSNEBskmMn46RbjXMx77bpIlP2yqspR1r2oEJy4uOT
 pxY6qDFrndc+ik0iI9o5O0N1hnMHQBi1UObc2Vx3KOoi+Tqv/zavFJ89cCLZSTVIx2YXKciApXz
 z5+A0yI80UuYXFuR1eJrm0dE47AuQqQc8RsyR8or1VE5psgOF4ny4lrv6THHqNPS0Yk5JyGhvCd
 coNmszIZs9EO5o4wxIw4WYPnt8vpcLSphjiKKk9PWtKa3njBsIQdQgpa04pdmwbgWe5UA711meP
 OJ6gm4z05KlOtO5XxRHOnI/u1qlKTIEA32teRtW/ybJcBvL4D3aMo+S7JLYGIvYS813DeU6YTcG
 Fvn/se9pf9VpghzF4dKwKVontWn5AlnbRalrym1VDXsJk4fOV0xvld8dVG1Mfmf3yEAH+ldgOU9
 U
X-Received: by 2002:a05:6820:4612:b0:706:4a84:20d5 with SMTP id
 006d021491bc7-70b88a7a73amr164260eaf.56.1792693763768; 
 Thu, 22 Oct 2026 11:29:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d61ce790sm5085986fac.11.2026.10.22.11.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:29:23 -0700 (PDT)
Date: Thu, 22 Oct 2026 12:29:20 -0600
From: Tom Rini <trini@konsulko.com>
To: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Cc: u-boot@lists.u-boot-project.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>, Marek Vasut <marex@nabladev.com>,
 Siu Ming Tong <smtong@axiado.com>, Johan Jonker <jbx6244@gmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Adam Ford <aford173@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] arm: synaptics: add SL2619 SoC and RDK board support
Message-ID: <20261022182920.GB3596691@bill-the-cat>
References: <20261022-sl2619_base-v1-0-ef20cc43d78b@bootlin.com>
 <20261022-sl2619_base-v1-1-ef20cc43d78b@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oTBCvOTUqVVZjLiV"
Content-Disposition: inline
In-Reply-To: <20261022-sl2619_base-v1-1-ef20cc43d78b@bootlin.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--oTBCvOTUqVVZjLiV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 10:08:23AM +0200, Richard Genoud (Synaptics) wrote:

> Introduce mach-synaptics to support SL2619 SoC-based boards. This adds
> the platform Kconfig and build infrastructure, along with initial
> SL2619 RDK board support and defconfig
>=20
> Introduce SYNAPTICS_SL2619, which selects ARM64, along with ARCH_SYNAPTICS
> which selects driver model, SYS_NS16550 and GIC-v2.
>=20
> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
[snip]
> +ARM SYNAPTICS
> +M:	Richard Genoud <richard.genoud@bootlin.com>
> +M:	Terry Zhou <terryzhou05@gmail.com>
> +S:	Maintained
> +F:	arch/arm/dts/sl2619-rdk-u-boot.dtsi
> +F:	arch/arm/mach-synaptics/
> +F:	board/synaptics/
> +F:	configs/synaptics_*
> +F:	doc/board/synaptics/
> +F:	include/configs/synaptics_*.h

Use "N: synaptics" instead to cover most of these.

> +
>  ARM TEGRA
>  M:	Thierry Reding <treding@nvidia.com>
>  M:	Svyatoslav Ryhel <clamor95@gmail.com>
[snip]
> diff --git a/arch/arm/dts/sl2619-rdk-u-boot.dtsi b/arch/arm/dts/sl2619-rd=
k-u-boot.dtsi
> new file mode 100644
> index 000000000000..a886ed7355ff
> --- /dev/null
> +++ b/arch/arm/dts/sl2619-rdk-u-boot.dtsi
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +&sm_uart0 {
> +	clock-frequency =3D <25000000>;
> +};

Isn't this allowed upstream?

> diff --git a/arch/arm/mach-synaptics/Kconfig b/arch/arm/mach-synaptics/Kc=
onfig
> new file mode 100644
> index 000000000000..33282060a8e0
> --- /dev/null
> +++ b/arch/arm/mach-synaptics/Kconfig
> @@ -0,0 +1,36 @@
> +if ARCH_SYNAPTICS
> +
> +config SYS_SOC
> +	default "synaptics"
> +
> +config SYS_VENDOR
> +	default "synaptics"
> +
> +config SYNAPTICS_SL2619
> +	bool "Synaptics SL2619 SoC"
> +	select ARM64

Shouldn't this be with the ARCH symbol? Or are there 32bit cores you'll
be supporting later?

Otherwise seems quite reasonable and I'm glad to see this posted,
thanks!

--=20
Tom

--oTBCvOTUqVVZjLiV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatpV/AAKCRAr4qD1Cr/k
ChbJAP4pQkNHmmOJ4/EruZFeBeW00+vZElXzvH0Me4RNFhmf/gD+MH830DeYiS+I
9RlqrXJfMTgMFBHFcw7+MkyPvTRSqwU=
=hCsL
-----END PGP SIGNATURE-----

--oTBCvOTUqVVZjLiV--
