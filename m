Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5400C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 17:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42AA588842;
	Mon, 29 Jul 2024 19:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FrShPqXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A804388835; Mon, 29 Jul 2024 19:47:01 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424D588791
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 19:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7092ea69218so2088904a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722275218; x=1722880018; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3D4vuLMoGga1nRZ9ZRWo7GCq0zNQLIMMrHVj3HXbtug=;
 b=FrShPqXI7r9NQoIbQ7QE5CsW5v92E0GMOmmsXF3sR/ytWVFxmepxpWZyC1fjKM3o7E
 xSZsB5JLqZH1iIjvBayz2fzrFEfW0THu0eToP0RACTL8SQzklvupnW7q77pcYKgTqjVU
 Mj4lfmKQ/KtlmGSBQJ6kWUFAGD6LndxnIRYXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275218; x=1722880018;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3D4vuLMoGga1nRZ9ZRWo7GCq0zNQLIMMrHVj3HXbtug=;
 b=hv7mmD5d9Q7elhngTwBTc++b9OVENQ5ZF5K0fl4rA5RtUSNEzXLouue0EJhXtFF2Ja
 P330A35P1mYfSUncULLRWlnhpTCHefdLHr/ARVgg/pHUlFCq520urHqyY4YfApC1V6jn
 qAgqOx5Q56WV9Mhsm9iYzXrIpJFogwiTm56tY/IJeRgfpVzL+2z/hjd/6ieBs/2p2YUQ
 eEVYoB9bsUPCJ8jvhRNREhteIZ8K4m21rBxe++qHw74pdMemaD0w10gjhTCSow+w+FjI
 xy4CX/cZZRaPBuvcNhYGsa/etaMP+kEL2rZQd70zPQ1WRcOtn7roCF9gyjnzSJMxl+X6
 TbUg==
X-Gm-Message-State: AOJu0Yx9ddGaQLCLumZu2auf45FVo10qbRdlDIp0KB/cSubRedB8OQsn
 umr1Nsp+TpL1G0hYHvY+GIxfFn3uznuZx+FFEFDUyHpWjE5lCzG1p7jPqnZILbk=
X-Google-Smtp-Source: AGHT+IGiOf8bMfialf2IPFTpfzgVKQ9icxLySsvSG+dxqaIGqbROsYjOOPXEnJzewC0qyNHmFxYCkg==
X-Received: by 2002:a05:6830:6e0f:b0:703:68d0:a266 with SMTP id
 46e09a7af769-70940c10294mr4514776a34.4.1722275217896; 
 Mon, 29 Jul 2024 10:46:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-709499c80aasm834041a34.35.2024.07.29.10.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:46:57 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:46:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Anand Moon <linux.amoon@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v4 3/4] alist: Add support for an allocated pointer list
Message-ID: <20240729174654.GM989285@bill-the-cat>
References: <20240726140038.194946-1-sjg@chromium.org>
 <20240726140038.194946-4-sjg@chromium.org>
 <20240726143320.GJ989285@bill-the-cat>
 <CAFLszTiwRFb+8tGE1w+Qi6fia_qaKm-Xs6OGALBCU-EzTBPMNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D0LUnEYUYiAaD5ss"
Content-Disposition: inline
In-Reply-To: <CAFLszTiwRFb+8tGE1w+Qi6fia_qaKm-Xs6OGALBCU-EzTBPMNQ@mail.gmail.com>
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


--D0LUnEYUYiAaD5ss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 08:54:52AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 26 Jul 2024 at 08:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jul 26, 2024 at 08:00:37AM -0600, Simon Glass wrote:
> > > In various places it is useful to have an array of structures, but al=
low
> > > it to grow. In some cases we work around it by setting maximum number=
 of
> > > entries, using a Kconfig option. In other places we use a linked list,
> > > which does not provide for random access and can complicate the code.
> > >
> > > Introduce a new data structure, which is a variable-sized list of str=
ucts
> > > each of the same, pre-set size. It provides O(1) access and is reason=
ably
> > > efficient at expanding linearly, since it doubles in size when it run=
s out
> > > of space.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v4:
> > > - Avoid using realloc() unless specifically enabled by Kconfig
> >
> > Is this really so performance critical that we can't always just use
> > malloc/free here?
>=20
> I would have to write some sort of test suite to get a better feel for
> that. The realloc() can be instant if there is space above the current
> item, whereas the malloc() approach always does a copy.
>=20
> It is certainly odd to use malloc()/free() when realloc() is there, so
> I think it makes sense to provide the option.

Well, we have realloc but generally don't use it. After a quick grep I'm
inclined to suggest we just go without it.

--=20
Tom

--D0LUnEYUYiAaD5ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAman1YcACgkQFHw5/5Y0
tyyuUQv+Ity9Hy2yb6rtMTDuLpzM3pVC0pNix/yAlLelQiur6IpN6tcCIKncZhkF
grv3v3FJLuKMCghmbRmyrmX3o3Pj5mEs2XGpOX6ptHY3trffXXXGYnYxhLw/z26x
eX3+1zP5ZKZ6Bv6edphR8fu+JlFe/GGpA8FKP/v1EmmgyZEqEr27d/okpuDP4OQk
psbfeeVs/fG8mJvv/Jb94DKiHMC0INrfiS/6IOSEe+XZBrggu8XFNpdhQ/JXxvwF
QleMV6QqMsjeZ8aOQCTBKBOUjylwDGRvohgTYvYwkAxeWChJVFC4RyiKGPEcsoOX
/4s9BMAcl86weKBDy5fPm5sGc6COqQQLJ9HkVhoTQ06EoujhX+0ThfRSe25i8XYI
C05x+WgZZWdGzG9FijsUvsd1XJmvchYXm4foN0LfEt7TnM6vP2CveYNXiDDNjJrS
GUH+Y4EMdl7uWhhM78PCISVsufdYcVLpr3HlFGoZj1zFA0yxf9FAS0wovKiGOlhJ
WDS788BQ
=gZKA
-----END PGP SIGNATURE-----

--D0LUnEYUYiAaD5ss--
