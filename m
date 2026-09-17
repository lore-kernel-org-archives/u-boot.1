Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6F2C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 19:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E611540856;
	Thu, 17 Sep 2026 19:52:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s7HzBNFyOdPk; Thu, 17 Sep 2026 19:52:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 38FFF4082E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789674747;
	b=YNBpT4GiOLE5w/o8ffFkodYStaPBxoFl75HI4yIjWIJJ9FKH6jI1XHiTNd/I6AK4Q3GK
	 ALCKU1Qq5rb7GFNX+Q3tvNGLEVpd1u5wZS0Mw8CjVtWDl3JCobWtHo+B/oaLX9xNEXPwP
	 dFzW0rRjetSrUxpWJ7BAFWXTHrTjQIWZ87V3CGRn5rJ5frI62tDBpA9aLJAqaHiQ5XkIR
	 x/vObStdCxwSdyw7stRi4ui3FVLFvA9QqaPsjdVPRaE3fVUoojhAfEagdJRA/zfbsU0kR
	 v5UwA5j5MA0l3BUL7Ja4yX64MMm05a1f0yTVlEW1w8H7rRhhOOK97ErJk3OH7sqzFGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789674747;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0IawjEcimIm2+geZ5Vu/sIo+RaNK2Zg8rnlaKdpbmd4=;
	b=FIm6GK2EFsOBmW+UI+0zbA/cEGgKtQyEPePQ2ZNVg2Am2GbO6pOrro/wSuGjeW3ZfCV6
	 LlRmyJU42867tGwCbgbT4mLdQw63WiRq7OtQfLnHtw9S8qRDuRfrQBQn9eOjGTgddfcQc
	 X+k2vB7rYwVtTIyPFwRfNAYi98Xbyi0PRzW0JnQYcl7Zg6s0RONEnWx7Mpl2D0GhZWfWr
	 YcDQZxessoZNjsnv6/1sDXXNgI3IEGRUEd7rgqxtGQFfq0oXzopcJgYU64NeR31nfd9gN
	 iNQARFTVqYJMlPm80uCfhNm6tCET/yPPPw8GWrReNB4CBTPKsfWJwzSB5SE2YI9FJ1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789674747;
	bh=0IawjEcimIm2+geZ5Vu/sIo+RaNK2Zg8rnlaKdpbmd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dDXFARJDtjaFQRDR9O27ACtbUqEGPRO/k3kAf1ZuICTcFRaLvhGePQZgK72ez/rDZ
	 ifzRYTBy7y3Pam+slgl2AQHtUtPidPRQ8suA4V4Lf4ey6DmlCPyw9Jh2In8bM/uAQD
	 p5n2LVIF1eb2DndH7D87HpZuA7ZY9mL0vkAecXn1ydqqfpUhPQ/Zca0KVEnrTpqlLi
	 4+CHPiKOe0SpF7XmRVknzcEUG5errcWDe541wQkc957tHoWuxOOzjh6nQiZsNCRInf
	 Y0/Kz6AX33NVY9i7wG4+BxNwJznRhWrhIYLJMyo5Dh+JVDXAOod9NRrBF+QX0c5Jrx
	 SsQeNAlFh4r8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38FFF4082E;
	Thu, 17 Sep 2026 19:52:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC1873AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D206C40460
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJVrH2bpkQ7S for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 19:52:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2210340452
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789674744;
 b=KDxwZSuDMFUZhd9a3X417EWbfCyi0k98OP+VY+8vj3GvBc+d2zMdyT1WwMvO2xGnLbOZ
 olZ3IDRxZ6TMgrWGeib5rPZ/ueOdmM10/PSGyFBmms0+yJa/hHhOwpFlqhe55xrN6W4z8
 DJTi4yJ3/uQzouKaE8oHa0cvRNHudyXaUlZGnaEWM0BGj85AovDdK8rz+FBITqsUUyJ1O
 mCuIyn17R9+0aGFa//MQKpnPKmTA2NIr03Mj67IEXHoel1Bx2zBgh21B9aua6iNLAvBm7
 BDSq3CpIF5HoR5wWW/vB012ib6maIMPUH+8kpfx5+JjjTJssxA1+uwH6zO4wSqijchQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789674744;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=0IawjEcimIm2+geZ5Vu/sIo+RaNK2Zg8rnlaKdpbmd4=;
 b=hv2SvrpBpOSv2/8EsLdZ3z0PG+YCBowe+dFHqLK2WTT/QZo91frU3VZVGQxi+EhlAtlJ
 O4UtCeWhJr9wU61F0IU06ws6JCyEEg/OSHNVbSEgFGMYOWVhbKRy45xptGvyKVc9Irnk9
 a4qUIWgMWmraBpQbzYzUCo8lyIBxi6hGuOtttUzywUJrzV6yGP15x4LAxXSC1oAtNBDEz
 rEUk9Eyk5AePGpcbrMtvADdWUC+f5PatxNcidfy6uKCmPY73I8W017PG+RcB4nXf4Bt75
 80eVhratumz5d2rbvGdcVqjJy+QNWTil9OdqYYy9HDzbFoDR8Bz2/ICcG7hy7vZRRnw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bo0SOFnj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::f;
 helo=mail-oi2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bo0SOFnj
Received: from mail-oi2-x0f.google.com (mail-oi2-x0f.google.com
 [IPv6:2607:f8b0:4864:32::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2210340452
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:22 +0000 (UTC)
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d298ccso535095a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789674742; x=1790279542;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0IawjEcimIm2+geZ5Vu/sIo+RaNK2Zg8rnlaKdpbmd4=;
 b=bo0SOFnjhvAnAfZWY79236z1KDIIJ8GYaTQBE20CSZbu8kgjygffrC6YgsIZj9J+iS
 Z4n46MypNsYJiZ3E+VdC4FToLyr7hp5u6kjZyrP2ndf1j7Y4TClpeRw758di9hOYUb5i
 34uX8uaaU6Pdm5cx3w5QH6gv7HHCyYWo13RI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789674742; x=1790279542;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0IawjEcimIm2+geZ5Vu/sIo+RaNK2Zg8rnlaKdpbmd4=;
 b=0/erei7b5m5/EE8+eJTNT2HeF8YLRTea8QKAe8CN/hNUnnAs6RF2jhtnj4E1GTKE4r
 on8BTjqkg9/czSKq3RaeuzEkWqwij1ffDkkMaSaWozYk4hUCKTHSvz5TC1wXCSwd2+Cu
 sqCwP9PskUBUcVbjdiLOQaqSB3UcDA3Nr5Wk28ep+NCxJimTQgXAl6plpHkgeOAEMIZr
 +b23joNuQqNQomjRe6YEewBna+fSjYxpQPOAujaTinmwdGmgNVk+m3G+tWoSPy1JQoU4
 vufD2zfkTARBFm0EE5FQi0SS9IB6Z++jxN+VGPIe2rwSqBBWk0X4bCpF0Ra3ml6XwOF2
 4hwQ==
X-Gm-Message-State: AFuF++l9tZI8OBbGf/NwrFsbsYCrils7w+Ceu6BKZATcM67cQURCvYlm
 9MFj2ddjExaVHVBuwML3/gegc7pVOgrF/6Fr0SnK32ZNh5Fm4YODgZ5uWiKqZWLLCas=
X-Gm-Gg: AYBFou0d3qxYvIaz5Mgm3/3UrcSzAmPmye1r4Ix+46jMbbO3/4Zgd9uYl+eOtG0LBFz
 EzXZGBDNK/DZK8tlXaqNqH7XyW7sfwl4cU0h318pBuK8ZpzKq+y2uMxkm9xcv7DyoBYG80Av12J
 dGJ5LwcovoqnALwArWcKTjGZfSoUE/1TQ+HEbo6pd79wCZNsXnMAQR3Z828b07yc31vifnLnfyE
 w+8SgTSMlg4liZVreixgMC0tRiizO2AkhZVtq4FdaD3V+9Cr+K2P4tBEfB9FVG4xzVZhPERS7c/
 6Khko6dtVb0dF3+7c0FNaorDewyy6R7FBA6gwcG2vg9Gjm3IGZyGphoOjJp8mq3X7wrBFVnKmNT
 fRHqRSa1vnC+cKS32IjpfHX0UoWJfacHzQIHb/1T12WpEAfVxLDcthBLcamRFyWp+rVAo+cWDpq
 QUrjycXiodqbvxOj6dT45mWffFlKPWMjeON1qV0d8susunM3J9hirJWI3BOZb/YfLIAuWKx0CM7
 THtGuh/il7DwwqSIcafOhWGnMWs9QazzHDXE1p1+QN7gMIElUp9AqqNrqUoWj5pyIleq1DKW4wS
 Yct7D41Zi2b5x0cJtcA0WHWnYxrfs6w=
X-Received: by 2002:a05:6830:83ab:b0:7e9:eb13:d042 with SMTP id
 46e09a7af769-80de04566d6mr239824a34.8.1789674741829; 
 Thu, 17 Sep 2026 12:52:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80d8039bd6dsm1149300a34.6.2026.09.17.12.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:52:21 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:52:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 01/11] boot: image: Keep the image-type table out of xPL
Message-ID: <20260917195218.GJ858934@bill-the-cat>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
 <20260917-spl-fit-compression-v1-1-7985ac56ee9e@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="njzezS11QxLDPUNh"
Content-Disposition: inline
In-Reply-To: <20260917-spl-fit-compression-v1-1-7985ac56ee9e@flipper.net>
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


--njzezS11QxLDPUNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 06:02:22PM +0400, Alexey Charkov wrote:

> print_decomp_msg() names the image it is about to unpack, which drags
> uimage_type[] and its strings into any phase that links image_decomp().
> That is about 2.5KB, measured on a Rockchip RK3576 SPL, spent on one line
> of progress output in a phase built for size.
>=20
> Name it "image" there instead. U-Boot proper is unchanged.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--njzezS11QxLDPUNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqxE7gAKCRAr4qD1Cr/k
Cj2sAQD/1mDpZukSaI72FnT4WLXoFDmRDd7uAZkgZjqF1LQ7FwD4gH3Jhq5qy3fc
szOyPkQBKsFWQgiTxMSVkaZJ1D2uBQ==
=8br3
-----END PGP SIGNATURE-----

--njzezS11QxLDPUNh--
