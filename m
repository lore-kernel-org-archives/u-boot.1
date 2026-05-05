Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A3BCD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05803848FC;
	Tue,  5 May 2026 16:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pXh2mRDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7DDA84956; Tue,  5 May 2026 16:29:22 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00EB0848CE
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso5398992a34.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777991359; x=1778596159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ousVYVXbP6DMBQ5Dh4OA3ZSIMld/5zioM2NxeIGE+gY=;
 b=pXh2mRDdJl6H8ILCyNpQylfBmk/9ResxoVfuZjAMmQi/4Isz7gLQOGDW2nrF15tlEc
 meCFQ2FzWQwDFm8Sq7Las7YAhC1xkPFFkPHQrCiagTXjNaQTKYMv3EAH7W6xReHTVCKR
 AaIzjjQ2KvFaTuRZm6LMhJybv98IJVdn/DQ8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777991359; x=1778596159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ousVYVXbP6DMBQ5Dh4OA3ZSIMld/5zioM2NxeIGE+gY=;
 b=aczWCmA6md+F31INt7/DolUcQRKfLmwnSLWObe4dk/4m/E6nAU5dNV2+5vtXgpQ7cO
 tAaqYRVFOXOBzKK4CjZPCaLJrIau7VwU/HpB6dzwkfkgd744eMZSu9b6IQObmh6uZ92H
 0ZIFZgeFhwbUwwHjMcGrXxwfmYJRNXjRD6Ebf0A3Rr6dNdsU0YYgMEV4vNd9xhEZvaAM
 IIysK7VdlEkRbdN1nZn/7DITGtTRC3jK8Pzkv9GpxoSaVekWEx90J6KePulfL/RujeYk
 qLdXEiMXXibH8xYTxMiy06daT0MZR0nC7HowlZiGKFqwYZgUjbpv3mM7JW7TMdu7+08i
 wOEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iy4L7RfgBjJiuvO9OfjKzrS84FqB8ZXx7h0IZyXG4O+X2jtbkZse3Uy0Piu0dk+ONypckBVA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxmz01n2sXpm9HAkCIQNNLzhZWXwzZuOMUtL6HrM1HoD60v9elp
 1Q3sLXvaTyWNaAgNnMczwLuUxl1zypPMRj4FHVLJ2kDUvAEFrDpCLF+hu4deuJUwrNM=
X-Gm-Gg: AeBDiesTnSqGfBMzaiO17c0eWqF+aQRhIkapaMYfSs8n+40JjYl87PvLwlilWVH/LLo
 MfaY3GoGLIVzdNWYGmGGfANzGVPD1QH2bSviDclqzT5fQe970TdRxzRo+wYP1Tb+jsjp4glDK+U
 hcuFA2A2Cki9fIwYWuyeO3UPynb9z4cdnrn1a1U//x9U7dQEvmBdEgwWjC6EPGf4wxzt5XYv/ON
 qXVcPcV0OUww5kZMAxpxUhJxlGvJ50tH8I7Ci1URwnWnfVmMcOORma/JIQj0cax1EGaubt8whwO
 hYVdg/qMgY1E1d37dgPHqr+DRiVF9HcN1RUikBwhKLOMLnU8iA4B1BIjEGZ4hCSbMNmP0VXUVwY
 Whf+uyYEmxhiv0JvkcsIFKZ+TTkivO0y7Vxc1ZivjE5TKeDNIGy6tmoV5TYJ7emY2aho1Tckkq+
 TXokuvpE5eq3gkz+YyBn6IZ6b5nNv8Pxz1V2ktK6i572LszwRT6dc2xU8Q+6TrYeSOsbIoBDosF
 /gOQTLKN7T2e52UmRS4veGBbcCZAugFW742++q+86FC0WYPRemvR+PQ5Pyeeg==
X-Received: by 2002:a05:6830:461f:b0:7d9:ade1:e19b with SMTP id
 46e09a7af769-7e0bfd17557mr1396090a34.14.1777991358500; 
 Tue, 05 May 2026 07:29:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac8ef53sm10373057a34.21.2026.05.05.07.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:29:17 -0700 (PDT)
Date: Tue, 5 May 2026 08:29:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, foss+uboot@0leil.net,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH RFC next 08/18] scripts/Makefile.extrawarn: sync with 6.1
Message-ID: <20260505142915.GP1614990@bill-the-cat>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-8-b19301d1948a@cherry.de>
 <CAFLszTjS4guQy-sW4SL3fzpbcNNqJKxMYn1qDDjpUhdP05YwVw@mail.gmail.com>
 <48121be4-3675-453d-b2a8-839c46756fb6@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S+RTEw4Fvqbc25gx"
Content-Disposition: inline
In-Reply-To: <48121be4-3675-453d-b2a8-839c46756fb6@cherry.de>
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


--S+RTEw4Fvqbc25gx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026 at 12:46:16PM +0200, Quentin Schulz wrote:
> Hi Simon,
>=20
> On 5/4/26 10:34 PM, Simon Glass wrote:
> > Hi Quentin,
> >=20
> > On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> > > scripts/Makefile.extrawarn: sync with 6.1
> > >=20
> > > Sync scripts/Makefile.extrawarn with Linux kernel 6.1's.
> > >=20
> > > Since it adds a new option for KBUILD_EXTRA_WARN with e, document it =
as
> > > done in kernel commit c77d06e70d59 ("kbuild: support W=3De to make bu=
ild
> > > abort in case of warning").
> > >=20
> > > s/gcc/build/ in Makefile as done in kernel commit e27128db6283 ("kbui=
ld:
> > > rename KBUILD_ENABLE_EXTRA_GCC_CHECKS to KBUILD_EXTRA_WARN"), part of
> > > v5.4. The rest of this commit was backported with commit bd3f9ee679b4
> > > ("kbuild: Bump the build system to 6.1").
> > >=20
> > > Our scripts/Makefile.extrawarn before this commit is Linux kernel's f=
rom
> > > v5.1 with the following diff:
> > >=20
> > >   # diff --git a/proc/self/fd/11 b/proc/self/fd/13
> > >   # --- a/proc/self/fd/11
> > >   # +++ b/proc/self/fd/13
> > >   # @@ -13,17 +13,8 @@
> > > [...]
> > >=20
> > > Makefile                   |   3 +-
> > >   scripts/Makefile.extrawarn | 154 +++++++++++++++++++++++++++-------=
-----------
> > >   2 files changed, 95 insertions(+), 62 deletions(-)
> >=20
> > > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > > @@ -22,64 +17,101 @@ endif
> > >   ifdef CONFIG_CC_IS_CLANG
> > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, initializer-overrides)
> > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-value)
> > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, format)
> > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, sign-compare)
> > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-zero-length)
> > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, uninitialized)
> > > +KBUILD_CFLAGS +=3D -Wno-initializer-overrides
> > > +# Clang before clang-16 would warn on default argument promotions.
> > > +ifneq ($(call clang-min-version, 160000),y)
> >=20
> > clang-min-version() is not defined anywhere that I can find. So I
> > believe $(call clang-min-version, 160000) always expands to empty, the
> > ifneq is always true and the inner ifeq always false.
> >=20
>=20
> Thanks for catching this. It seems scripts/Makefile.compiler is also not
> sync'ed with 6.1. We're missing kernel commit 88b61e3bff93
> ("Makefile.compiler: replace cc-ifversion with compiler-specific macros").
> I'll add that to the v2.
>=20
> > > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > > @@ -22,64 +17,101 @@ endif
> > > -warning :=3D $(warning-$(findstring 1, $(KBUILD_ENABLE_EXTRA_GCC_CHE=
CKS)))
> > > -warning +=3D $(warning-$(findstring 2, $(KBUILD_ENABLE_EXTRA_GCC_CHE=
CKS)))
> > > -warning +=3D $(warning-$(findstring 3, $(KBUILD_ENABLE_EXTRA_GCC_CHE=
CKS)))
> > > -
> > > -ifeq ("$(strip $(warning))","")
> > > -        $(error W=3D$(KBUILD_ENABLE_EXTRA_GCC_CHECKS) is unknown)
> > > -endif
> >=20
> > Dropping this silently accepts make W=3Dq as a no-op. That matches v6.1
> > so I'm fine with it, but please note the behaviour change in the
> > commit message so anyone bisecting a "my W=3Dfoo did nothing" report
> > finds it.
> >=20
>=20
> ACK. This was told in kernel commit 64a91907c896 ("kbuild: refactor
> scripts/Makefile.extrawarn"):
>=20
>     This commit slightly changes the behavior, I think all of which are O=
K.
>=20
>     [1] Currently, cc-option calls are needlessly evaluated. For example,
>           warning-3 +=3D $(call cc-option, -Wpacked-bitfield-compat)
>         needs evaluating only when W=3D3, but it is actually evaluated for
>         W=3D1, W=3D2 as well. With this commit, only relevant cc-option c=
alls
>         will be evaluated. This is a slight optimization.
>=20
>     [2] Currently, unsupported level like W=3D4 is checked by:
>           $(error W=3D$(KBUILD_ENABLE_EXTRA_GCC_CHECKS) is unknown)
>         This will no longer be checked, but I do not think it is a big
>         deal.
>=20
>     [3] Currently, 4 Clang warnings (Winitializer-overrides, Wformat,
>         Wsign-compare, Wformat-zero-length) are shown by any of W=3D1, W=
=3D2,
>         and W=3D3. With this commit, they will be warned only by W=3D1. I
>         think this is a more correct behavior since each warning belongs
>         to only one group.
>=20
> > > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > > @@ -22,64 +17,101 @@ endif
> > > -warning-1 +=3D $(call cc-disable-warning, missing-field-initializers)
> > > -warning-1 +=3D $(call cc-disable-warning, sign-compare)
> > > +KBUILD_CFLAGS +=3D -Wmissing-prototypes
> > > +KBUILD_CFLAGS +=3D -Wold-style-definition
> > > +KBUILD_CFLAGS +=3D -Wmissing-include-dirs
> >=20
> > ...
> > > +KBUILD_CFLAGS +=3D -Wno-missing-field-initializers
> > > +KBUILD_CFLAGS +=3D -Wno-sign-compare
> > > +KBUILD_CFLAGS +=3D -Wno-type-limits
> > > +KBUILD_CFLAGS +=3D -Wno-shift-negative-value
> >=20
> > Several flags previously wrapped in cc-option / cc-disable-warning are
> > now passed unconditionally (-Wmissing-prototypes,
> > -Wold-style-definition, -Wmissing-include-dirs, -Wno-type-limits,
> > -Wno-shift-negative-value). That's the v6.1 behaviour, fair enough.
> > What's the oldest gcc we support?
> >=20
>=20
> Pfew... That I don't know. We have an explicit check for GCC10 on ARM sin=
ce
> commit bb1c2b463265 ("update GCC version check after Kbuild bump"). We ha=
ve
> GCC4 min for PPC in arch/powerpc/config.mk with checkgcc4 target.
>=20
> mbedtls specifies they test against GCC 5.4, c.f.
> https://github.com/Mbed-TLS/mbedtls#tool-versions. Some parts in
> lib/mbedtls/external/mbedtls/library/aesce.c and
> lib/mbedtls/external/mbedtls/library/sha256.c require GCC6.
> lib/mbedtls/external/mbedtls/library/sha512.c requires GCC8.
>=20
> lwip's CI tests on ubuntu-latest GitHub runner, c.f. https://github.com/l=
wip-tcpip/lwip/blob/master/.github/workflows/ci-linux.yml#L9-L17.
> I don't know which version we've been using but it was merged for 2025.01
> and at that time ubuntu-latest GitHub worker was Ubuntu 22.04. I believe
> GCC10 was the version by default, though 9 to 12 are available in the
> Universe package feed.
>=20
> microMIPS requires GCC>=3D4.9, c.f. check in arch/mips/include/asm/compil=
er.h.
>=20
> include/linux/compiler-gcc.h requires GCC>=3D4.6.
>=20
> For the rest, I don't know. Maybe Tom does?

Absolute minimums are driven by other failures (for example, the bug we
hit that pushed arm to gcc 10). GCC 10 is over 5 years old, so saying
that's a global minimum is fine with me. And I've said before I'd be
open to a global check.

> The Linux kernel states in Documentation/process/changes.rst that the
> minimum GCC is 5.1 though "The gcc version requirements may vary depending
> on the type of CPU in your computer." (and I'm assuming "in your computer"
> applies to the target device, not the host machine).

I do wonder, idly, what platforms in the current kernel can build a
functional kernel with 5.1 :)

--=20
Tom

--S+RTEw4Fvqbc25gx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafn+ugAKCRAr4qD1Cr/k
CgW5AP9x7NQmkIYPvHD0d6n1EhIxMrOmRFFXYiaENseiMQxikAD9ENzZobBqB/mB
BpXwg4p7dKVElNS8YPW514kCFlis9AI=
=awmY
-----END PGP SIGNATURE-----

--S+RTEw4Fvqbc25gx--
