Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F54E65D10
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 01:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AA488F0C;
	Fri, 22 Nov 2024 02:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hvpLPACP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D053088F28; Fri, 22 Nov 2024 02:30:47 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F8488D3C
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 02:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b155cca097so140022185a.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 17:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732239044; x=1732843844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FZ/hGKRRksyVpAXtvbB5bTtztxNTUc2xwhDb2yIpHKo=;
 b=hvpLPACPynhABmI6arWISw81yvJWcCv7OEtwEWMEdqJkphb6pdPe4kA0FkWU9u099c
 PZa9JWldOAIDx6swX84xMf5jO0nBYYZKz3sq3b/Q9df2K2afVdZXO8PEA3TF7mmqscbR
 mkV2Rd32dYDkasMdMXqdUFmwrJ/B3T3bAyhdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732239044; x=1732843844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZ/hGKRRksyVpAXtvbB5bTtztxNTUc2xwhDb2yIpHKo=;
 b=uMF8NuVw3lR0VmmC9wb6JI+8z4UgY9X5kKglxnGk/5dBvStaSFOBWFd9liOMGeEqeK
 h4Vb7RQ15Ywa07ZoHhGrXryCIp35Ta3/ptcsaaKWgt9jCd04uP7D4qnDgFsOBrpeXJ0W
 Nfyy3Bx5EcCAHTCagaNli/o7pSSv8IhYg04VnB8hnRbXhPdeoT7RCnzLgqT2GiVz1CQI
 N0VEhd9F7Fkl2jCMKpeuFKDWEZmJEUlMj41LBqeXBjRHosXRIuquplWLg9rimxlqRJV3
 mRGZmbapbE2E1pvqNBdCn3m1au6VoWr0QO/w3N4BNZyLL8JigtzI46id14aBkPdw8e6B
 LuWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgglzIAy6vSn4HxPssegXOnByt0F88xvQAcEKrInCB30BNtrdIuIb/Hz0NJb0rgf6UGbKfvgg=@lists.denx.de
X-Gm-Message-State: AOJu0YzZqbw49d0aK0w/z6gB/ZoAwx2JKKFvGFVuwem5oF6V/tOQSwzl
 oUswF6ShHW3mcpZz9YLkng0RaRWUJgKfcrY0gOkB1+ns/J9s5Bc1mbbr3N0PUnY=
X-Gm-Gg: ASbGncvXwTO6CXw7hpv+CxHoEGCbQprKuA6zDKblHmlmQg2f290olm7CDR08/YtBC+H
 W7VrWtMyEwg0rHKNSx/wcnY7dYi3x8QFjKHz+zzBxUqlzIcI/BFDo9dfM11tE6p/rOf6g0B4iQS
 aVL0f7Oive00qdzfb99Nyj3CZ9a4XCbwIr04mHBYIoBGirVaFhGin/MIuLE6ROmye7bre/UVZnQ
 L0KpezSZEgHG2QroJP3/J4tGNCiCR7YVhppk5pG6iwawi/sdg==
X-Google-Smtp-Source: AGHT+IGVwQmBpv2YlLSebJWkizUyKNohFS+7bjTqjyqLhdF/WaSiki43/FdC0WqHY6ty99hlKxx9vw==
X-Received: by 2002:a05:620a:244a:b0:7ac:e8bf:894a with SMTP id
 af79cd13be357-7b50c1bbe26mr830113685a.20.1732239044395; 
 Thu, 21 Nov 2024 17:30:44 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c3d6ff6sm5499991cf.4.2024.11.21.17.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 17:30:43 -0800 (PST)
Date: Thu, 21 Nov 2024 19:30:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] Fix device removal order for Apple dart iommu
Message-ID: <20241122013038.GJ3600562@bill-the-cat>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241121073926.GA2171629@robin.jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pWCjFzDzmhJ7vQ0z"
Content-Disposition: inline
In-Reply-To: <20241121073926.GA2171629@robin.jannau.net>
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


--pWCjFzDzmhJ7vQ0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 08:39:26AM +0100, Janne Grunau wrote:
> On Thu, Oct 31, 2024 at 11:48:00PM +0100, Janne Grunau wrote:
> > Starting with v2024.10 dev_iommu_dma_unmap calls during device removal
> > trigger a NULL pointer dereference since the the iommu device is removed
> > before its user. The sparsely used DM_FLAG_VITAL flag is intended for
> > this dependency.
> > This series adds it to the Apple dart iommu driver and implements the
> > two phased device removal to the EFI loader.
>=20
> Can we get this two small patches merged? They fix a regression although
> it worked previously just accidentally. The only drivers using
> DM_FLAG_VITAL are clk-rcar-gen3.c, rzg2l-cpg.c and apple_dart.c all used
> on arm SoCs. arch/arm/lib/bootm.c already uses a device_remove call with
> DM_REMOVE_NON_VITAL so adding it to efi_loader looks reasonable as
> regression fix.

Can you please take a look at doing the changes Heinrich suggested I
believe in 2/2 ?

--=20
Tom

--pWCjFzDzmhJ7vQ0z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc/3rsACgkQFHw5/5Y0
tyyn3Av/XyHL3D1DimsOyM1XrxPdDVp6qNkBwet2EFwAclkiPUMk+QqWPAn03Ud9
qT9+EQfD/sTn+7LIds1Yyh9cO1Z9k0OKBHJth9IO3f+20FxDgaRtr6zFF347/s2G
ywWvjHkPlr2wwLZLIiSx1CLyBvIBysQN+P6HakeKYSzO1JkigQ0cZcimZESbGhE2
HqiUdKnnzQtPZii9O2rUa3gG1F55hQmxtBotP8KAo4ugAPKVwfNlZUTo7q7wV/tf
t/JhlwcgmWPaHStfk6S9UnSP7wNiKLe6atyhmzAaDakyekMZ6bRdypr6eavvMOTC
2YFYZEAqT7oE49IcP32b3mDXq2oC1bPEOtZVwUxIyckG1cPC4vBGR6Zm3ZyV30b/
zHo9Ypbcyasst6lqyJ0VLMWxzMeLntkm3HhIcEoUJ8/vt3ooWLVFRsWrPzyi6KVE
qqggRRVERREtsHAxW8LpLxlvTkEDWUL9U2m6fJrd7D1qbCCGSpb6F5M2oUIzHawN
NCbQ2DV9
=tSAy
-----END PGP SIGNATURE-----

--pWCjFzDzmhJ7vQ0z--
