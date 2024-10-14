Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B7FD1627F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A03788B6D;
	Mon, 14 Oct 2024 17:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oBNPPQs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC02A88E42; Mon, 14 Oct 2024 17:02:24 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926A888A3C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4603ce01023so37068491cf.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728918141; x=1729522941; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vvKBrSD15lb36KHneO1tiXO/uNuSqhSWUP0/dP2Fb5Y=;
 b=oBNPPQs7alM4IJzxVCjtr46Y8bwigqrhZQ0ZsXCf+UDVYosPS9cI0GJvxolcPWjZtf
 BKem3+LzAjFr/cUGJFIQWDJ9bBh5Y6w82aXBLw/PyqNhbkSKXalR1vLDyC4Tpvmv32IV
 0g/9u/OY/ThGuolXANGbQZZNbP87WUu9yf0Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728918141; x=1729522941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvKBrSD15lb36KHneO1tiXO/uNuSqhSWUP0/dP2Fb5Y=;
 b=nJU62KSBznA6Mzp0+TfviZxYvo/E6DhQBMPl+eSaf+PQfZx/bYKOYmXuq2BsjOxg4n
 moi4N9vFkP/RB/yXENhvBuNDxmryECn0V2aSl/J8bprCzxo97AQUYfdHg6WQTjGYL65h
 6g0sdx+7uQV0tJdERIpRq6D1pzC/XmVNyPpc6zSZWOKw+BKhAqwuVxDEP+VWcenqQOyN
 RkXDvoBXh/zi2UBY5qsEHjwxDGzw36Dfh+ERsDlqqEFLlAFo67EnWiuhJ/9VF9PX6SMr
 jgpkpTLJOFFRR3mC0xGcrKoWGqGAFUTErgrNsBbJBVJOC3+puKYMZPrX/ySO+BXLhH59
 yPZg==
X-Gm-Message-State: AOJu0YwqaRlJRAN4Ug9JofmwaqyRkZRmJ50LYT5xFyFhqIg4dMXDGUbj
 RKRAm/tXxFdXrYLUFcs5yu7pxj0dmq+ZgbpLM7l2BQpeC4SaleaXb4t/fRVvPy8=
X-Google-Smtp-Source: AGHT+IE4wYHIcjGMJnHLcXA3jrFk/bgY6vAjfIi/lkv8ppquvYEUQxf0hDUeMJmbaxGlGoyY4KAl5g==
X-Received: by 2002:a05:622a:5e8b:b0:460:5294:66ce with SMTP id
 d75a77b69052e-46052946c1dmr141941211cf.42.1728918141105; 
 Mon, 14 Oct 2024 08:02:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460427db7d6sm46201491cf.33.2024.10.14.08.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:02:20 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:02:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 02/15] lmb: add a flag to allow suppressing memory map
 change notification
Message-ID: <20241014150217.GL53053@bill-the-cat>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-3-sughosh.ganu@linaro.org>
 <20241013175146.GN14210@bill-the-cat>
 <CADg8p97a5jVR=_YRpbzBDEFLzPea-UtBFHc+X679vyPhGfC2Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="egx+Ur9ZhZr80BKk"
Content-Disposition: inline
In-Reply-To: <CADg8p97a5jVR=_YRpbzBDEFLzPea-UtBFHc+X679vyPhGfC2Xw@mail.gmail.com>
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


--egx+Ur9ZhZr80BKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 12:26:02PM +0530, Sughosh Ganu wrote:
> On Sun, 13 Oct 2024 at 23:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Oct 13, 2024 at 04:25:09PM +0530, Sughosh Ganu wrote:
> >
> > > Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> > > reserving memory. This will then result in no notification being sent
> > > from the LMB module for the changes to the LMB's memory map.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >
> > Can you please elaborate on what we need this flag for, for example what
> > the valid situation for it is? We should be updating (or adding comments
> > such that updates are automatic..) to doc/api/lmb.rst as well. Thanks.
>=20
> The flag is used to prevent notifying the EFI code about the change in
> the LMB memory map when the alloc/free request originates in the EFI
> memory module.

Simon, this is the loop you referred to on IRC the other day, and
instead you solve this with the flag about a point of cooperation?

> The EFI memory module adds the memory region to its
> memory map as part of the alloc/free operation. The idea is that the
> LMB module should notify EFI about changes to its memory map when
> these changes are initiated from non-EFI consumers of memory.

OK, so the first change is that since doc/api/lmb.rst is just a
kerneldoc of include/lmb.h we need to add the flag here, and we need to
first document LMB_NOOVERWRITE which is already undocumented. The next
change is that at the end of the series, update the rst with some
paragraphs about what and why, for clarity, after auditing include/lmb.h
for other items that are missing kerneldoc comments. I am willing to
make that second change a follow-up series, however.

--=20
Tom

--egx+Ur9ZhZr80BKk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNMnEACgkQFHw5/5Y0
tyw1zQv/WxAwJFvxamP3R6Uz23A6QxqYdKBS+O2YXYdciZ0J5DM/kujU4Pv3/Fm8
x8x77ZBo3rysIo02Acpgn2RLWi8kY4tRwnkxcqO9deT+FgUHZt5rF9ObdFK02fK6
jAaSChoM4YUPr3AFTzL84VeEfY8k1rVsaRj4PIuvxyp88iQPcBXqs4nHgSr1QTCP
Ejv55BQSR+N9Yvx0gBAWu69RIne+E98PWTc6ik0rfQemf/SvBAw6BOUtr0vYlLRa
7ZSjX64QcTh0Wm+dKWg1Hp34eyjzK3yPD5aoc0vbr3/R6119nWMniPJ0ixv9nB1m
oN44aftjvrKEajUANYtBOiNjAnrGZf0Vhgbcr0Xuk+oezhfIENceuKpQuOfX1+Bd
76Vovl1be4YfRYKzjjPOYcuMKGeoRX0A6x35sFy9oS6SZ586DwzNHERqtN6s8LOr
s5rPc4AJ9900KYmXqnBG84jnZEvys1zQBEu1J3SdczqfPOsPtMXWmaL+4FUK3FXa
9bpnKrL4
=Ql5o
-----END PGP SIGNATURE-----

--egx+Ur9ZhZr80BKk--
