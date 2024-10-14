Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4415D18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388EC89201;
	Mon, 14 Oct 2024 23:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YY3rblFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C088289202; Mon, 14 Oct 2024 23:49:56 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6914187DC7
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4604111f629so45732451cf.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728942593; x=1729547393; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kfdQ69nrrK8BDZslsudDJB77bvShmVSBdZHVjVKdbVM=;
 b=YY3rblFyQAVrUEgBygnoBrscvtlb2lSL0nk2U0XKT8oXHO/WofWQYjDONHAvyUMlN5
 Weu9e3KQr8wdce5klrg2QQjpD6LwsRq68Kt4SC5zyglpOzBTfRgxBciRLdZ9Oq8MtUhE
 SM4AgyA/zxxq9Ce27e3GFqUdCnCQQcJWUwDxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728942593; x=1729547393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfdQ69nrrK8BDZslsudDJB77bvShmVSBdZHVjVKdbVM=;
 b=PoEsXjsy8sEjfZsyLOuVgFCCeI3GzesJq+SIhqugI+SX+xzzPqPNxqfTdN9/znPugw
 PAjGuyXFzMrLUz+yH0OwqYYI/eZXiNe82Dg1Jn+dm/mP3tzvNgNDFevi+xbH9zzsBxs2
 gn32de5OkqbbCWsUJ8S9fRqs/Xl78EpGfMZUndDX4ANoqsdp79JdIOPpMOvnujAuYKy5
 eV3DkAAhJa7lA9XOcJ4yV1FyduHx6M0mQ7Q/NyxjuzNmA0p6xKwvMeppKPhuwT6ZHb2P
 7RE6++EARFDxMvnd9e7KzWs9eNrFDK1aE7thAkGYzGIAnjGKnJIMr0IZ3yvI+NqytCda
 Zyeg==
X-Gm-Message-State: AOJu0YxrrJlB67Wnf1Ki12MUjPxDq2EbUMd4TFyAJb00VcPeF6XIvoD5
 mcyvKLXrJuUCeK59YDkNiweUbdj6cC5iQXsFfzO/s2w7UmoBhSFCyANX9RULlnM=
X-Google-Smtp-Source: AGHT+IFtmewBrtg5VPS1U5BXfv+AO2Hnzve2QZPVHqhi9do0PUAPDX7x4+M+SW/BTuanGnKdQfrFTg==
X-Received: by 2002:ac8:7f93:0:b0:458:4d0a:608 with SMTP id
 d75a77b69052e-4604bc8298emr212254261cf.51.1728942593214; 
 Mon, 14 Oct 2024 14:49:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4604c9e3918sm40618871cf.55.2024.10.14.14.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:49:52 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:49:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] qconfig: Ignore defconfigs containing #include
Message-ID: <20241014214948.GE53053@bill-the-cat>
References: <20241012232231.5638-1-sjg@chromium.org>
 <20241012232231.5638-2-sjg@chromium.org>
 <20241013161520.GM14210@bill-the-cat>
 <CAFLszTjijFBZar31k1QaLUKcFQyD+CGqyo5wH=7agFF1gr-CLQ@mail.gmail.com>
 <20241014211248.GY53053@bill-the-cat>
 <CAFLszTg6fVsasb8=CJLqFm-T9Vys9_hJDeKfAfTmvfWXNcPZZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IfFQlawaMyZqB1mF"
Content-Disposition: inline
In-Reply-To: <CAFLszTg6fVsasb8=CJLqFm-T9Vys9_hJDeKfAfTmvfWXNcPZZA@mail.gmail.com>
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


--IfFQlawaMyZqB1mF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 03:35:23PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Oct 2024 at 15:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 02:20:00PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 13 Oct 2024 at 10:15, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Oct 12, 2024 at 05:22:30PM -0600, Simon Glass wrote:
> > > >
> > > > > Running "tools/qconfig.py -s" will re-sync files with #include in=
 them
> > > > > and so un-#include them.
> > > > >
> > > > > Ignore these and mark them as failures.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issue=
s/28
> > > >
> > > > How about marking them as warnings? It may be good to re-sync
> > > > configs/am62px_evm_a53_defconfig for example and then re-add the
> > > > #include line, but configs/am62x_evm_a53_ethboot_defconfig on the o=
ther
> > > > hand very much should not be resynced. Thanks for getting on this i=
ssue
> > > > so quickly.
> > >
> > > Do you mean still do the resync, but show a warning? It does
> > > obliterate the old defconfig, but I suppose people can just not commit
> > > the changes. Is that what you are thinking?
> >
> > No, sorry for being unclear. I was thinking it should NOT be resynced
> > but counted as a warning not a failure.
>=20
> Well qconfig doesn't have the concept of a warning, or at least not in
> the title. How important is this?

I assumed it was using the same status counter bar that buildman uses.
If you can't easily do warning not error, OK.

--=20
Tom

--IfFQlawaMyZqB1mF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNkfwACgkQFHw5/5Y0
tywomwv/cvynWxmRVfjtqwqYO4gTQu6Qc2lqlb+WYQXc7pmoQLvVBWikdoJp4eR+
+rUm3A0tFtGk3KHqAxh/rf/k9jJnPFgocFPQhHuugbRB2Co7NA82l46yuSu7vrhX
ZLD1UjAL0+nP/T7cOUHNOXuph+q41ZTfNRtrSgz/d9RLwn6sY/LL8l0zaOrBWape
ADUrUNC+qOMeuiIK7dnG90XnERZo33RmlnXD7rVWvzta2oUfTbyEKDm9WRG7qRJB
ip3ThtJdmrO4X1KUtBz5N3Zx4eTLESN4gbLhUf9H0nQ9V9FkooXRTzNtvRZtIQAm
Y5asf34zZrcJLmZWlnCJePwaOw5KTrSdTUZqvVsMoqk1izcMopQ1FsK/Xkjxy/bN
bNZOJ5L7t724frdlrhL7t68O5pVGwEhtKVgUZ6RTlKfTstCH0f100EKLV9mOYrNp
gMnuX7b8pIxa4/4lmn+1vgVzCejrNGmfUDbl0gxVbSWg0KguiR1OAldBPRMtofsM
jbCoGF7s
=33/5
-----END PGP SIGNATURE-----

--IfFQlawaMyZqB1mF--
