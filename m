Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A19D18153
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA62388DBF;
	Mon, 14 Oct 2024 23:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OEVJe/Xi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2911F8907F; Mon, 14 Oct 2024 23:27:28 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B1388D1C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7afc591c69cso324873885a.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728941245; x=1729546045; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ILnfAcYt3E6iQxPLd50m0WFcbhW3g1ESyEV1LlJyen4=;
 b=OEVJe/XigohMbfiFGdaBAo+9JGjIXiMFT9ofVC3QJWzdS7JoPZq6QW0fx6IQbhg+O4
 bgQKQvzLk6cgafxLiYKgcfmp/1rScaKKY4p0ylLJz0pma7b+68biypCsZrZWV7cI3Bcx
 jljG0pJCNvYXPDe4pvgch0iP6rCatVRzO0pag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728941245; x=1729546045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILnfAcYt3E6iQxPLd50m0WFcbhW3g1ESyEV1LlJyen4=;
 b=q++J7AL5HuYl+Tdx8IZZ2yX+Xf5j3FJaFYXu5AcV8vtJEIHzTYQ3uVjxKdySMoK+/e
 CWbigS8zVpX7ykovqEsBbXk6g6gq2cMprMm2OFilDTaDzppc1Gc0+93ZmahvTIfPAT4u
 8H21MUDysJhYW5wVQD15ueUvbxx3R6mQSDB/25WBPNAGZtG0P0xfqJMLagSjRPSlNQMs
 GqV+oGLVi0F3JsmgZhL5B3KQDffKV6/1+UIDX1lYPxvqfpcE//b0Z1fDN4EaHYSl/wBV
 ZnH0NSgty56uiC8YbZS2wROPc2kbl60aQwn3S8jXjjj3l4bv/xBFq/jcRIWZzNxTf4c/
 X4lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcMiI9e+v7K3PTP1ZE0B0RolzwgX0/ZCMmorfCE/R4e/nkhztEVqtWsCmve9KJ+jVIU4C1kW8=@lists.denx.de
X-Gm-Message-State: AOJu0YyqfzfFZrCShyoWed/xfSbL7RiSLs3xjiuwGx2moJV6tRyzAAuO
 ah11N+3iuscP9gOx8F0S6yDLpuAG33i6G46EbzlxAFR9nUhTYXfcePuqWYQuzKg=
X-Google-Smtp-Source: AGHT+IHiZdsrJGs8FDcK5kfLLQF5hdU82TJ6hqBon7WIM6h3ZvXnXvMxmIi2cohOvjyq+P18IE+hhQ==
X-Received: by 2002:a05:620a:1aa3:b0:7ab:322d:8796 with SMTP id
 af79cd13be357-7b11a3e594fmr1868169585a.64.1728941244833; 
 Mon, 14 Oct 2024 14:27:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b11497894asm454820585a.104.2024.10.14.14.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:27:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:27:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
Message-ID: <20241014212718.GZ53053@bill-the-cat>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
 <20241014210453.GU53053@bill-the-cat>
 <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1UJjF7t6AwVaEB4w"
Content-Disposition: inline
In-Reply-To: <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
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


--1UJjF7t6AwVaEB4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 03:13:01PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Oct 2024 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > > > > Hi Sughosh,
> > > > >
> > > > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.o=
rg> wrote:
> > > > > >
> > > > > > Use the LMB API's for allocating and freeing up memory. With th=
is, the
> > > > > > LMB module becomes the common backend for managing non U-Boot i=
mage
> > > > > > memory that might be requested by other modules.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since V2:
> > > > > > * Use map_to_sysmem() to get the user-visible address to be sha=
red
> > > > > >   with the lmb API's for sandbox.
> > > > > >
> > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++------------------=
--------
> > > > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > > > >
> > > > > When efi_init_obj() is called, it should be able to add the lmb m=
emory
> > > > > to its own tables. There is no need to worry about lmb after that,

Saying "There is no need to worry about lmb after that" is not true.
Invoking the "env" command for example will have efi_init_obj() be
called, among the others that Heinrich listed. And to possibly refute
a next issue, that is intentional so that efivars, the standard
mechanism used by an OS to talk with the firmware can be available to
U-Boot, if I recall things correctly.

My understanding of your assumption is that you believe that once the
EFI_LOADER subsystem has started work on a payload we're just a few call
chains away from the OS being started and runtime services aside U-Boot
being done.

My understanding of how things are used today is that this is incorrect.

--=20
Tom

--1UJjF7t6AwVaEB4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNjK4ACgkQFHw5/5Y0
tywoyAv/a985DOn4Qcc/l7clIXcP1QSOvgYx7zCva4aeQaMfGO3kTP5lZ4XJ9Aw3
2YEQGh/LjFZfgw/Ibw2G+ChdTHqHaijWDwJsuKpPKFHR2X6Th9mjXor83Rgquzis
qrrlq6TGCPAoj+InINnybaM7e6/IPOhIIAUI3S5nuV0sdQa1NIzoHZhTr5d3lUVo
6Nu09XPmURwY33M4H+QlKNvFFxPlxO/gJ9qxrfVcOW36p3cNU0rb+B0sPFVngZNU
UmbG3zrELYmx5qF9xonJHAf9V4AK3DYZy2rJM+d7gO1pNlzVRVk/Fb9ueEFdThzP
GhmH3YW23wKiNEt3U/FKdIMUt8Gvv+6L49gNzABby5uB7mktrrFerDVmByOvPafu
JM4P0lj/lYbMoDSVVLvzigGMdTToNUrMrYL+o7jh4oYAsuBu71Hpp/VdGYVNF+Db
+6SDnrVxZ5COrluPa7zb/8M3hVo6FJD312uHjBUpK2bPhYX1dOpUTpUYVzOlMnju
6ODgyyDi
=dso8
-----END PGP SIGNATURE-----

--1UJjF7t6AwVaEB4w--
