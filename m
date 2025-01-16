Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4587BC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96ED78022B;
	Thu, 16 Jan 2025 15:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ek5PZrn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDF580283; Thu, 16 Jan 2025 15:33:07 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0159D80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dce7263beaso9876356d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737037984; x=1737642784; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aVX316p0wsek//GCijrqQTaWvxsun/T+6LZ9EaPxL4c=;
 b=Ek5PZrn2tssOk8hpDPqW74gDZGz4t0ym9jl1eIi72v1O5+t/e7QH4a8LHgfYZL70H7
 1IQmuJDCh5NvQON11buMsi6qL9EA5Yddxa/EVvOZYLwx+cxyhY+1isCG8DCDkLfN402v
 X0nFWOHcZg71JEZPgTpBDxJGElQaTMUFue65U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737037984; x=1737642784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVX316p0wsek//GCijrqQTaWvxsun/T+6LZ9EaPxL4c=;
 b=LYPUvWNrP30cRk9p/PzjbG/vRRi60qE1c1nLfaltMq3EF1wOaFyoRrYgjwuo9HdVKb
 YOn9qpP/QRyQWNw7c/nyPv2H8fJUb3yOmD8NSNUdNJ5eP8qwPgR6C9yt42JmXuWKMSXc
 p32xq0GdDCmzf4czAMClKXl3vSQe3DP871e3q5/fE4u1pQDXIOTq5KB3JOe47hZa7aIw
 uN14ARI4sLcG8m6sPCXKBYGZOMKOWTDGqkfz1a1TFijaDIzSFTycC16ZJUTcwC1U01Dh
 4/k63/wqVNw3TgxqRrzeqc4wiM87v/SuhcdSKoKtUTWNpbxHRH6/LeyPiGosrdLSOgcM
 iDEw==
X-Gm-Message-State: AOJu0YxqRkhBtzzHcZXL4a0zNlIZu0sXtaFzMVUsg831JFH0CerI4X/3
 eqeB3b+BREUOQou+KHkO8o6s3rnpDCdRDoQXwneCHMPnhopLKJ7UCuf10pFkkAk=
X-Gm-Gg: ASbGncu+zZ9ulGiqzMcxl66E/ozzpgZAs2BUhmzKXRYCZ+otkjy6OoFOp7IY7+Fb6zX
 Woqxcu6v/nZF9Kb1D17NsyJYAQNE/JSNAV7kZhTORoll5WAgIwza298FtTHpTBzkIrty9fxA4Cn
 FzCTAeuJjfQ0VbOmCOKZOVbFoMys/pm/GUyry9/rpcnKzx7Jy0qE0l6/WVP7X1+A3u3/gH6x19C
 CX41KDSZL51NWr0ObE2Lcq4SIiG+pZFHIKDz2n3JYP7SkBCGaMi8A==
X-Google-Smtp-Source: AGHT+IEb7MTl2t1rt07RBgrSbkYDvM62xePVMLH+7QWq0dP+gxMY3AnD1k9/6ToeuoQ2dE2FZNHMFQ==
X-Received: by 2002:a05:6214:3212:b0:6d8:7db7:1f2e with SMTP id
 6a1803df08f44-6df9b1db07amr571684046d6.14.1737037983841; 
 Thu, 16 Jan 2025 06:33:03 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc21ce5sm476466d6.52.2025.01.16.06.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 06:33:03 -0800 (PST)
Date: Thu, 16 Jan 2025 08:33:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] block: Remove "select BLK" from non-block drivers
Message-ID: <20250116143300.GG3476@bill-the-cat>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-7-trini@konsulko.com>
 <2b3e1050-7cbe-4dde-a298-5efb63cb4ebd@cherry.de>
 <20250114165914.GN3476@bill-the-cat>
 <4cb564bb-8c0d-43bf-bd91-04668a1deab2@cherry.de>
 <20250115202029.GC3476@bill-the-cat>
 <240a9f89-2374-46eb-b780-a628c08e2a3e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cwrZf967ml7CDN72"
Content-Disposition: inline
In-Reply-To: <240a9f89-2374-46eb-b780-a628c08e2a3e@cherry.de>
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


--cwrZf967ml7CDN72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 10:21:36AM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/15/25 9:20 PM, Tom Rini wrote:
> > On Wed, Jan 15, 2025 at 06:49:45PM +0100, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 1/14/25 5:59 PM, Tom Rini wrote:
> > > > On Tue, Jan 14, 2025 at 02:53:48PM +0100, Quentin Schulz wrote:
> > > > > Hi Tom,
> > > > >=20
> > > > > On 12/20/24 11:22 PM, Tom Rini wrote:
> > > > > > Now that block drivers are all selecting the BLK symbol, there'=
s no need
> > > > > > for other options to be select'ing BLK so that other required
> > > > > > functionality can be enabled. Remove these places.
> > > > > >=20
> > > > >=20
> > > > > We have multiple commands depending on the BLK symbol.
> > > >=20
> > > > Yes.
> > > >=20
> > > > > BOOTSTD also depends on it, but I assume we should be able to net=
work boot
> > > > > without HW block drivers?
> > > >=20
> > > > Correct. That's part of the motivation for this series (which I was=
n't
> > > > clear enough about on its own). Without something like this series =
if we
> > > > remove the BLK dependency from BOOTSTD then some other platforms fa=
il to
> > > > build or grow a bunch in size (as BOOTSTD is default y and now it's
> > > > enabled on those platforms).
> > > >=20
> > > > > CMD_UFETCH wouldn't be usable without those drivers as well.
> > > > >=20
> > > > > Should we do something about that by making them not depend on BL=
K e.g. use
> > > > > CONFIG_IS_ENABLED in the right places? Not sure if all devicess b=
ased on
> > > > > those archs have at least one HW block driver enabled. I guess ch=
ecking if
> > > > > all .config before and after that change are identical would help=
 us figure
> > > > > out if this could introduce a regression?
> > > >=20
> > > > There's a few options, depending on what the command is. For CMD_UF=
ETCH
> > > > it's likely that a small restructure would be needed to not try and
> > >=20
> > > My point is that I believe this patch is too hastily removing the sel=
ect BLK
> > > because some symbols have "depends on BLK" and by removing the select=
, we
> > > make those symbols unselectable. This can cascade if other symbols de=
pend on
> > > those now unselectable symbols.
> > >=20
> > > Also, removing the select BLK from architecture/target symbols can in=
troduce
> > > regressions if BLK really is required?
> > >=20
> > > I think a reasonable (albeit cumbersome) solution is to migrate all t=
hose
> > > selects to the impacted defconfigs so that effectively no change is m=
ade for
> > > existing devices. If maintainers want to remove BLK, they could then =
do it
> > > later.
> > >=20
> > > This also makes sure that BOOTSTD and CMD_UFETCH (and others) are sti=
ll
> > > enabled, since BLK would still be enabled, just from a different loca=
tion.
> > > Then another patch series could remove BOOTSTD dependency on BLK by a=
dapting
> > > the code, same for CMD_UFETCH (and others).
> > >=20
> > > Does this make sense? Am I missing something?
> >=20
> > What you're missing, I believe, is that this patch exists because prior
> > to the first patch in the series and also going back to when BLK was
> > optional, if something higher level like ARCH_ROCKCHIP didn't select BLK
> > then it wouldn't be able to prompt about its MMC driver. This is similar
> > to all of the high level places that "select DM" as that used to be
> > meaningful but now it's not. As part of testing the series I did my
> > world build before/after and the only change is that as noted in the
> > cover letter, espresso7420 now has MMC again. Does this help? Thanks.
> >=20
>=20
> Please add this to the patch commit log as well. The cover letter content
> doesn't make it to the git history :)
>=20
> But with the world build you've done, I'm now confident what I was worried
> about will not happen, therefore:
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks, I'll reword this slightly to include the above when applying.

--=20
Tom

--cwrZf967ml7CDN72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeJGJgACgkQFHw5/5Y0
tyygwQwAtlRXEaPa5LiaYQEWczPyba+4bYzrATi4EZiS7WhmPUA/EUK/q4l4rEAH
KZ/CZprhXoQU5QpqOWD5TFnwVTeN3PV/RCrzB/5dR0lADtvL9SXna6dgcE8ltzIV
ENMI+mFWtmJTxBR/ml/jAEXVwf7UB+Ml8dlfR24OJBl+mlT56gD/ncP5pdS+SMv2
cF0cF4QXJp5x5GAUotbFVwAFEKYyUEzQblpzm4J8XfCFKpqzT8VZZbq0aAgZOT9P
Y/IakkrhD4b2lRw79AjiKCVLO5XB20zm4Vn8ZafFLiZl8KI/Gu6oR9P3sE/JPsnx
XwQe5KTfRYN/J5v5DX9xw766792ByPOTPbcGUkpQQ8b5Q3xIvkKY8XM+O4lafC6q
rADC4AH4zCvtlK3FXhhJEGPRJcrEmiv8yUt+WeYRdfDf1KzxxY+VsAjS8m2jvt9u
rmtMJMreiLR1x9bsRab0bBes5AjyMuEqc/g3D4GxG14EihON8pwQTDGIiEWJijUw
5CGRco4c
=67gc
-----END PGP SIGNATURE-----

--cwrZf967ml7CDN72--
