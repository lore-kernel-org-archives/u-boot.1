Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A62DD12663
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 18:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DC6983EF9;
	Tue,  2 Dec 2025 19:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HcrmF7oS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B050E83F14; Tue,  2 Dec 2025 19:52:28 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 553BE83EF2
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 19:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3e3dac349easo4340457fac.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 10:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764701545; x=1765306345; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uht2hJxCKdbL85ewiVBwCLSD9DbblhydcBTJIyks+LY=;
 b=HcrmF7oSXFaJUMNq5QJvP48Gs9gFoMRF9oTvTdLVn9KMH6yUTMCwD63ZIHi5bgGT03
 SNiSAdaltzBgEfbZQXa+qwouAW1+RgwTVDO8PKFf+pGSG/qAA+FepWlZ035UEpgEBUJa
 J5Xz8MkJ79iRar3uaLJzb7dpvPShEP92Zg80s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764701545; x=1765306345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uht2hJxCKdbL85ewiVBwCLSD9DbblhydcBTJIyks+LY=;
 b=XBiqQmHlt4rGVgYhZfQdpIoI3t2hboFMUrGPuZ2xOgaYsbiMHKnhrL3/8y8ts5RtNa
 VnMSPh33aVpmTnTt+Sp6zzYLXKxr38a/wkPK6h3zvjayPp/4NLdB0AqziFINQpvcyH8x
 BAPu0WMT/6Qtvde8fQquu+nQmvhBHgQubvzBaQ0PEY9hL1nEA4XgopEX+aqLVlp6HB7X
 qENwzmQ9pl06N8Be1DxhEROAIv4JnNuszhIVI19k4TXGnmriS1dpzqMMBwizndlXSWWq
 9Ra19dc5sASrWZE60wzxtJZXUSXnRHGHi/TTitM15eg3eLmUgsW2UWufaG7MhSO8J+xG
 L5Mw==
X-Gm-Message-State: AOJu0YwucxJ+IuWURdqS3EzedbpMR4v+C8Xq/nLm8OiEaqXwdFZ78F2Z
 Ut+C44Ijn042WODeDTM5dRcCfp6ppOCfF39MDcdHaiwt3PDfRTrenDmADJT6dGz6WJQ=
X-Gm-Gg: ASbGncvCT+tn036Eq7L/C35/dug3OdQGWmwfIam7sL0MJXtLk1YGX6bIfe5xDWrj/pw
 YOWqWMGsvD4V9fLG3i7TT62lPRz9Qc6Dq5uZyXHdFUvX/G3oF8PPkHi3IcIcSmSrNcb3DJ6/AEW
 3sM7sAK1KhX/hSMpB17Dt5oF195daL9G3xSJyXcrMK+PcrMxZ+Z6VOvWDY0C7duXQNwv+6mWDTi
 mnsqu550EoQlQDfn1ab7jWGCgqhW1K18/gnYvgYwQ1JMgmZRo1b7DIGFrUWkg62t+gfQoZ0sqlR
 f0pP8qJDbJQLFU+GZwqlzvwIJBfvzW2hFWdmKDApRz5wU7BphufeZ7Ghikg5gJLLMIdS3z8j+wS
 n3ANreQNMQXhkVKu3m7ShILkZXAwHEBRYMki6XGOQocPh4d6pbTl2PqqYu0DhsdJUZ+4vbPMCNY
 EIe0kEX+nqXhc4P94Kt7jRT9nEQxTbk5nYX861BY0B15uOPh1TOg==
X-Google-Smtp-Source: AGHT+IGSbyNEuCWtGqMrayNDdlqeCpcW6rVLUaFhM+eRpJ02l5di2FCVsdF+lmFcAs/UPjdmoRiigw==
X-Received: by 2002:a05:6808:30a5:b0:450:adcf:9b3e with SMTP id
 5614622812f47-4536a299dc8mr326525b6e.50.1764701544882; 
 Tue, 02 Dec 2025 10:52:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453169f9f54sm6005064b6e.7.2025.12.02.10.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 10:52:24 -0800 (PST)
Date: Tue, 2 Dec 2025 12:52:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
Message-ID: <20251202185222.GG303283@bill-the-cat>
References: <20251202182403.GF303283@bill-the-cat>
 <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qCVCsOpzlRxhgpG4"
Content-Disposition: inline
In-Reply-To: <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
X-Clacks-Overhead: GNU Terry Pratchett
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


--qCVCsOpzlRxhgpG4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 07:49:07PM +0100, Mark Kettenis wrote:
> > Date: Tue, 2 Dec 2025 12:24:03 -0600
> > From: Tom Rini <trini@konsulko.com>
>=20
> Hi Tom,
>=20
> > Hey all,
> >=20
> > I am wondering if at this point in time, anyone still builds our host
> > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> > Windows, natively.
> >=20
> > I ask for two reasons. The first of which is that a reason we still have
> > to support Azure (despite its slowness) for CI is it's where we have
> > macOS and Windows hosts. But at this point in time there's so many ways
> > to have Linux userspace running on Windows or macOS that I don't know
> > that there's any value to these builds.
> >=20
> > The second reason is more macOS specific and is that with:
> >=20
> > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> > Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Date:   Thu Nov 13 12:54:51 2025 +0100
> >=20
> >     boot: Assure FDT is always at 8-byte aligned address
> >    =20
> >     The fitImage may contain FDT at 4-byte aligned address, because ali=
gnment
> >     of DT tags is 4 bytes. However, libfdt and also Linux expects DT to=
 be at
> >     8-byte aligned address. Make sure that the DTs embedded in fitImage=
s are
> >     always used from 8-byte aligned addresses. In case the DT is decomp=
ressed,
> >     make sure the target buffer is 8-byte aligned. In case the DT is on=
ly
> >     loaded, make sure the target buffer is 8-byte aligned too.
> >    =20
> >     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >=20
> > Which does things we must do, we now don't build on macOS. Why? As best
> > I can tell (and for a general purpose OS, is a good call), memalign(..)
> > doesn't exist and you need to use posix_memalign, a not drop-in
> > replacement. We could spend some time reworking the code here for that,
> > but for now I've instead gone with this workaround so that CI can
> > continue:
> > https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsulko.=
com/
>=20
> Are you sure about this?
>=20
> The code in boot/image-fdt.c is part of U-Boot itself, not the host
> tools.  As such it should be irrelevant whether the host OS provides
> memalign() or not; U-Boot provides its own implementation.

We use parts of this code as-is (and some other less obvious files) when
building host tools.

> OpenBSD doesn't have memalign() either.  But I can still build the
> targets I care about on OpenBSD.
>=20
> Or is this about sandbox?  Did sandbox ever work on macOS?

It's about "tools-only" build target, but also I suspect that if you try
the next branch right now it'll also fail and we'll need to figure
something out.

--=20
Tom

--qCVCsOpzlRxhgpG4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS81YgAKCRAr4qD1Cr/k
CoPEAP4hYEaUBbShH0zd0PSge9kb4Eoq42hK+h4kGw9CBSwyBQEAskwwV3rxaUMn
DIjp6J/vb/4kkFLko/5C04bj3m/tMw8=
=mMqN
-----END PGP SIGNATURE-----

--qCVCsOpzlRxhgpG4--
