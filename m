Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A36C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 13:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5407480584;
	Wed,  4 Jun 2025 15:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PScOUiqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF6338070C; Wed,  4 Jun 2025 15:56:19 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37C580050
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 15:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-407a6c6a6d4so1233921b6e.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749045376; x=1749650176; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qke/eKawxonuPqjcK9s5tvKNYsyKNURklO8Iv25niCk=;
 b=PScOUiqD0eDF0GcK9SE7AolriwFBFRc7XLIHpfF9OUm8nndkFJq3eSxlIVJfEDSIJ1
 BKIeDFe10fPxAeW5GqaudLL45wqBM+6hzdZwpTr5WWS6t05EvIwenj6a2FPNz/CCMj3d
 mDHyXbbBg4vF5Rbt6Nk/ws0ak/OnmO8cz9y+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749045376; x=1749650176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qke/eKawxonuPqjcK9s5tvKNYsyKNURklO8Iv25niCk=;
 b=E9woICyyxO9+uJirxvKOZUN7nwGTi1sN3+NFT8TOihDS6MiwlxKt/FQ+ms54fkaYHT
 5MP9KvHIugUgoPraQZkLEe+E7jVPrnIqUuw9C/ZihqBcvgvzeIiHcM912RRUg9Tu4vfU
 hPvzl44TYR7Cq1tPTO6ORpJnlhP5IU1sLgIC4dRgBrVbqJKsdJ0KIcttsnFgXnKaC8IL
 KudIDykRmQFRisl4Hfhb9JXee8elVHXNEV+Rs6MMpZ9siPw6+mrpnXIx9lCZX/tGQ/xd
 2grcY+qm5CCO46EPfEVeRzQfsThcnxydxYCyEHo32dsaQcA6UoEaTfRPRW+jLd4KGCui
 BIYw==
X-Gm-Message-State: AOJu0YyngBtQsaA0avL0TBJv7g8yj1J1CKzobOqmEor5Owa/S5SvEZW6
 lhQyZQMve/5RYnhXWw2facIhhzB5uviRGxI0SyTubVzE5y/YKK662nln0K+Ymaji1Gc=
X-Gm-Gg: ASbGncua6zlhBzMqQLR72vvC51MePJCYnCekklRnFdjsFG16zAEIKvbgG7omzO2XEm7
 aEBNr2gZR4plj+PXBrD1OsdZtrAPGaHG4NreTL91ABp7xC72hX5CTdhg2EKpiIcYVKVKCSWvc/W
 D252mF2H54B9fm8yDbXq/eEBXz0ZZU2ChRSoAnHkjAM8WxqtX20QWs98+Q3izuYbHF+EAO3hGrM
 5pX/hhVRgGfmafJcZA78k9O1LtwMlDIX3ORjs5SAQXzt2tBx3g2ZFhYgeRSialXNph7RBUZ+FCY
 L5VVc7GS31pC9I8B9+gYbaXBMSq8kXsx+xh80EaIhb6XxDcvKsjbpEf7fzsWwUgKTc9jzWE1d2q
 ++s5b97hfgmAn
X-Google-Smtp-Source: AGHT+IF2eFR5N0zq3JYw7QkzwGXWYlMsvnViZWEU/EjYlq1qsrxkhZFFs5UJwoHRS5qntOy6kMWGEQ==
X-Received: by 2002:a05:6870:3d85:b0:2d5:ba2d:80da with SMTP id
 586e51a60fabf-2e9bf48b7bcmr1964994fac.36.1749045376340; 
 Wed, 04 Jun 2025 06:56:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e9058cbfebsm2659878fac.0.2025.06.04.06.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:56:15 -0700 (PDT)
Date: Wed, 4 Jun 2025 07:56:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>, Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
Message-ID: <20250604135612.GN1382132@bill-the-cat>
References: <20250603151401.1709532-1-raymond.mao@linaro.org>
 <20250603154748.GG1382132@bill-the-cat>
 <CAEfUkU+7BaEcmQ1NL2TSMLpHYQt1DhPLKZPtkB_Fd6u_Oq4qEA@mail.gmail.com>
 <20250603192345.GL1382132@bill-the-cat>
 <CAEfUkULmB2PckAKf+euT8Mj3ehirw-TjmNT20-+AfVy6SpRB=Q@mail.gmail.com>
 <DADNW2131HYB.V2UGC24FOJJO@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VUY0LixEcEAVzrMa"
Content-Disposition: inline
In-Reply-To: <DADNW2131HYB.V2UGC24FOJJO@ti.com>
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


--VUY0LixEcEAVzrMa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:33:31PM +0530, Anshul Dalal wrote:
> Hi Raymond,
>=20
> On Wed Jun 4, 2025 at 2:30 AM IST, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Tue, 3 Jun 2025 at 15:23, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Tue, Jun 03, 2025 at 02:00:23PM -0400, Raymond Mao wrote:
> >> > Hi Tom,
> >> >
> >> > On Tue, 3 Jun 2025 at 11:47, Tom Rini <trini@konsulko.com> wrote:
> >> > >
> >> > > On Tue, Jun 03, 2025 at 08:13:58AM -0700, Raymond Mao wrote:
> >> > >
> >> > > > This patch is to solve the sandbox building error:
> >> > > > $ make O=3Dbuild-sandbox -s sandbox_defconfig
> >> > > > $ make O=3Dbuild-sandbox -s -j2
> >> > > > /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined ref=
erence to symbol 'pthread_kill@@GLIBC_2.2.5'
> >> > > > /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding=
 symbols: DSO missing from command line
> >> > > > collect2: error: ld returned 1 exit status
> >> > > > [...]
> >> > > >
> >> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > > > ---
> >> > > >  arch/sandbox/config.mk | 2 +-
> >> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > >
> >> > > OK, but how do you get this failure to start with? What host?
> >> > It failed when I started any sandbox unit test like:
> >> > ./test/py/test.py --bd sandbox --build -k <any_test>
> >> > My local host: Ubuntu v20.04, x86_64
> >>
> >> We don't see that normally, is there something odd about your compiler=
s?
> >> This is the kind of thing which should be failing everywhere, but isn'=
t.
> >> Thanks.
> >>
> > This failure occured in my host since v2025.07-rc1, but with the same
> > host, same setup and same instructions it worked fine in v2025.04-rc5.
> > Seems that some impacts were introduced during v2025.04-rc5 ~
> > v2025.07-rc1, which might be worth investigating.
> >
>=20
> I am unable to reproduce the issue on gcc 15.1.1 and glibc 2.41. I think
> the issue is likely on your host end.  What compiler and libc are you
> using for the build?

This feels like if it's generic, CI should be blowing up too, even if
it's Ubuntu 22.04 not 20.04 these days. Please bisect down to the
failure, since you have known good/bad commits and 'git bisect run' can
use the test case you have.

--=20
Tom

--VUY0LixEcEAVzrMa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAUHgACgkQFHw5/5Y0
tyx6twv+NGPl6HpaNMPgLgVmiEwUlqAZy/9S3CI3K9LBU/iK0DF0w8vVK3R26qL3
Ts0gQ6rrMyU5Q6iPJSGUctH5i+NFO5DbQcClRDKy3IabHxe8icgnr9N7zDmFh0gD
1+NBV1IbgEducNgXf/2RYQPD0b/uhi1oAE2XvlkFV02bkvkuRsbQsxqFD5Z6vAaI
68pQL7jdDmvctyzar3dlMHpoIhW4JpxLS/RagAJXgQ0xJCbfCKAPu/wvz42hFQ0H
59Bga70Q5oVDLNHvjQHENnL3sCF2oBwU1L32Wrso6fo0iMJpeT3kz0/ktpUrxJhG
SH8QxHd18ZXz1o//BhcPF/jxz+kySPQHbButYzf3XCglmZ9wFj4Vxuu2mZQxg9Cj
0nGkqu/B5ndlIOxvLsADG2DJGficzj3U/DaSR+hDfQDWiZSscoejDr57o1ptf5wx
IIY53OndujVkSPK8IYk66v9pvabHUtHHXiuzNlc/yFVb3NkyeSceUcaYjwdUEM1R
btcHJ4vA
=On0q
-----END PGP SIGNATURE-----

--VUY0LixEcEAVzrMa--
