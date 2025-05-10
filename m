Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A10C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 15:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1DC082952;
	Sat, 10 May 2025 17:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eXHWtn+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4DFD8295C; Sat, 10 May 2025 17:11:58 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C939F82935
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 17:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so859313a34.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746889915; x=1747494715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hvAyK/18AVEXrqXCMj3WY5yt6BhmoFLpss9WKdqDZU0=;
 b=eXHWtn+ooe0ZayExBDMPqzqoXcM4aeSPBqgZH2weMmNjcE+vPluXhdcn0w5FE7avfr
 XqWNk7EN97OJXuX91iM3Vb0pdzVgnkPsYAcJxmWhPeS+/3Wl6kWcN+DXOCbpzvvPPw9j
 rvQ5Bbr6fabEb0SSojUjnZN8PEGUDfm4oGtaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746889915; x=1747494715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvAyK/18AVEXrqXCMj3WY5yt6BhmoFLpss9WKdqDZU0=;
 b=pVuMw4Qc3oehOsVf1qHJ1KV3YCT1UK21bi191VFmvmcI6FCUUa/DyZL5V8RlxjzgAO
 pnLDAgVSrQSOOjmXv4F//sWIdWbWx/SCjvVnvoomD4DMY4LkpIA5XH+SFtf7PvbBBU9Y
 6LQgArLE9hNdjSxXMIs5Sv/232+CbRCakCSMGgMHIac8Txo5I+ICJYJZYpphd/SVhhVO
 wWuvbflMyWS3kUl1bDTDfO6mt30xDIXmD0J8cm47K17TNERhybr/0GnhTeJpBvv4eyAa
 vdLl19w7u0iotid4KpmsfKrJZh9fhQwY5rqFbwZ79qvqmVToCp/ZR9snGe6UHiQWP4uq
 vevg==
X-Gm-Message-State: AOJu0YwBN0JkI7O5Hf/K/YHP8VZrRZl9mQpOmA65PY6sC+k4Z/nndT+X
 +qW8H2AvklGEvHvU1L5HJ+DGUcqcZ32o+UB7TfSREtzJ9UJJ6XRz77ShvjOMCUk=
X-Gm-Gg: ASbGnct2OwPErLi7sPfWhCrYv1AKioyjyA6Db7nD726wmqiUn0u8YXLc08FFTZ3UJYe
 aoc5Espmx3GuFZQfu+lZVrJjMQ2rXf95LWGxXoFr6ki6Xji2L6zZe+8pQ9LqfVHvwZ6qmTeWB5h
 m03TMKf8Grbf4xiW+KijNVuZGyAGnygP2iv8+T2iJDzGUDcWOVofsoBIQezR+V+FEhZPhMC6WIh
 8O4vj7LOBpviO3kcfLDOi3w3s+YGdaDqCI9ZCBikQIQrUQ4t+KF/t1beD37zjmzoFs0JT4uhhrG
 w+8CX7jXidx+MN5oitt20OxdvIve0wS63oaFNyhErvbbI31L6uWxFJnypIsFDONRkx+Ppqhfbgi
 7QDMqOU/DDkbK
X-Google-Smtp-Source: AGHT+IGLpa4zRVXlYVirV2Xike7TB86GFem5De+d0pcxCsOt1DYitIWzJnIy4UEwd+NHHIzgupK6/Q==
X-Received: by 2002:a05:6830:648b:b0:72b:9b1f:2e1d with SMTP id
 46e09a7af769-732269c8ce0mr5405273a34.2.1746889915514; 
 Sat, 10 May 2025 08:11:55 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264b0036sm945007a34.15.2025.05.10.08.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 08:11:54 -0700 (PDT)
Date: Sat, 10 May 2025 09:11:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 3/4] doc: pytest: Document the test_net_boot test
Message-ID: <20250510151152.GM603748@bill-the-cat>
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
 <20250507221112.518041-4-trini@konsulko.com>
 <CAFLszTh+5AT2pmKwY38+16+Ujdooa9e+1BB=oH3P9z-1PN7hAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mw7ktvtCk+IvqiNK"
Content-Disposition: inline
In-Reply-To: <CAFLszTh+5AT2pmKwY38+16+Ujdooa9e+1BB=oH3P9z-1PN7hAg@mail.gmail.com>
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


--mw7ktvtCk+IvqiNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 01:25:27PM +0200, Simon Glass wrote:
> On Thu, 8 May 2025 at 00:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > Add the test_net_boot.py test to the generated documentation. While most
> > of this was already commented correctly for inclusion the biggest
> > problem was examples of code without a code-block notation. This in turn
> > broke parsing. Add the missing notations. We also must have the comment
> > prior to any import lines or it will not be seen as a comment on the
> > overall file and thus not included.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >  doc/develop/pytest/index.rst         |   1 +
> >  doc/develop/pytest/test_net_boot.rst |   8 ++
> >  test/py/tests/test_net_boot.py       | 163 +++++++++++++++------------
> >  3 files changed, 98 insertions(+), 74 deletions(-)
> >  create mode 100644 doc/develop/pytest/test_net_boot.rst
> >
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> Can we add some default binaries to the tree, or somewhere else?

No, I don't think that's a good idea. It needs to be something that will
actually boot on the hardware in question.

--=20
Tom

--mw7ktvtCk+IvqiNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgfbLgACgkQFHw5/5Y0
tyyapwv/dTamjtIWSxtgnV0fNqgdZRgVxj3+7lc4JiS8VDgIgClAAE+ExN/3NaEv
irLW4C+AbWDxmhbnvx/gZpPrT/+tvVFNsdCQ7VrxifOPfGaf+q0PsUMrj7ieuGn3
xKxIZKRJu9z+A1yHnQZ9eQX96NP99OwuC6UgF13G2OSOcNe0fP0d3CAaxOgzJChZ
3aOK1riJq+8ILKR/g3iTKaE0XGVkxe7ksjQHzZxYbUMthp29x2BJw8vsFZ+f+sQb
gyV7L2MirVXhwuQoQRg0qcdnsT/ZEg8xoMEgeWFS6z3mBvBm+1OnXGBp3QvLkBN/
yf07cye9pSVgjmI5Mh0i521+kh+qMxSMckxCtc042Gb+7k18l1MlJtD+sqU22T5D
kU+eIjq8O5PHuLS0VAKJIhh4bsztmBJ31KTN8Y/V9OdmQaM4moUgE8PPM4e7OmfS
d12m1BEtnnCa54WJS7Ls7OJJjw/doAOWjHp00KQZiBJEr5gz01k0dqV4lwRHjQWi
XPkOfLCZ
=Clf+
-----END PGP SIGNATURE-----

--mw7ktvtCk+IvqiNK--
