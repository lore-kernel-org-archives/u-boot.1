Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CFDC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 22:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33BAE88B14;
	Fri, 16 Aug 2024 00:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bWjTrZq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8897588B5D; Fri, 16 Aug 2024 00:56:40 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2744588AF8
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 00:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-27010ae9815so573531fac.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 15:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723762590; x=1724367390; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LnO/Qab/Kgb2ZzyXABHVh1XGgZSEXYQAtTFgI606G/8=;
 b=bWjTrZq9Pm2iTVeO7IHLwJ7RrhtbKw6FRMy1CrlWSLWCsaJQ6/ghAKg/O0gsWpnCsJ
 iGLt6rawQv98b6qMi57iERQW21ceUff3ZaPwI+GmNK3VX3pnWVpxHbwh6dXlno98dyJO
 qtGmCx9hhHkEtnIE3tZfmJAz1b+zZa1QZlLrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723762590; x=1724367390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnO/Qab/Kgb2ZzyXABHVh1XGgZSEXYQAtTFgI606G/8=;
 b=jTYdx3ZIUcagLOU8DXt6DyVgvAKzpM7GZ0s1VcEFheiZ3IG9EW5MiEkYIQOHnzunJA
 T2qyXhBsMlvmIZvi9JlizAxRdCgMES4D5dyxgPwgxUz322xFTOnc5yVZx37QjzN59/94
 W1t35/DbfP78ZB5mlGkTfQBXPoRNdk/QSo0tGkDII1yvQZsmelqLIOnpslayOkBfIiSw
 bGX6PzrXiwlFTiIXTuPUAl3w1srVkpzt5iNVvGJ918w8iiJOmX0XXHWD0XzK9sDWTmOF
 Ak4WIuKuWc+lT+IWZ87fKsjgR/wCfRLpRNePp83mmnOeuAv7HaNKejrvmZA/QAT3KTfm
 Wi9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjxE+smfXXXooDq0uT5iQso64FSe7uuLlLLdtzxvJmJ8Nub2ych3N/+19UXjC05saNH58OXUCLuo6lpsQuFFho95ONAg==
X-Gm-Message-State: AOJu0YyewzZ0lCvEY3DyxhxkJaGJ/GD6jenwO2bla80GoNluOGW4kmZc
 1P+9L8K+44w9+voQwjWadeIal8AZLyPOnvKQJAx36RzfHfgAPNBXNYBf/g6Hfmg=
X-Google-Smtp-Source: AGHT+IEiWt8FZAhjG323sG9WaUBq/AsSwmI5ZFnA7p1iM1dQy9nWNZ2yqEYwl0qhOndV6xTdnATZWw==
X-Received: by 2002:a05:6870:1698:b0:261:6bc:9b8e with SMTP id
 586e51a60fabf-2701c3f7b59mr1272052fac.26.1723762589648; 
 Thu, 15 Aug 2024 15:56:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270049f7e96sm594201fac.51.2024.08.15.15.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 15:56:28 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:56:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 37/39] efi: Avoid using sandbox virtio devices
Message-ID: <20240815225626.GW1626301@bill-the-cat>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-38-sjg@chromium.org>
 <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
 <20240807015613.GD1626301@bill-the-cat>
 <CAFLszThhn0240xt1j6GQB9QTKxiHiAg6J3vMXCnHBE15iYZSkA@mail.gmail.com>
 <20240808200634.GR1626301@bill-the-cat>
 <CAFLszThM=23AXCOfZ_uOyGGDQTRurDpAjR-t8X_NHjz4LgQ9SA@mail.gmail.com>
 <20240814175601.GP1626301@bill-the-cat>
 <CAFLszThU+vLUm_fveWUgV3Qt3J+F3=Sr1aBgbc4T5z8zJJz5sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sDSmB0NrX436emLx"
Content-Disposition: inline
In-Reply-To: <CAFLszThU+vLUm_fveWUgV3Qt3J+F3=Sr1aBgbc4T5z8zJJz5sw@mail.gmail.com>
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


--sDSmB0NrX436emLx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 09:33:18PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 14 Aug 2024 at 11:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Aug 11, 2024 at 08:50:21AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 8 Aug 2024 at 14:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Aug 08, 2024 at 12:44:05PM -0600, Simon Glass wrote:
> > > > > Hi Heinrick, Tom,
> > > > >
> > > > > On Tue, 6 Aug 2024 at 19:56, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Aug 07, 2024 at 03:47:21AM +0200, Heinrich Schuchardt w=
rote:
> > > > > > > On 06.08.24 14:58, Simon Glass wrote:
> > > > > > > > While sandbox supports virtio it cannot support actually us=
ing the block
> > > > > > > > devices to read files, since there is nothing on the other =
end of the
> > > > > > > > 'virtqueue'.
> > > > > > > >
> > > > > > > > A recent change makes EFI probe all block devices, whether =
used or not.
> > > > > > > > This is apparently required by EFI, although it violates U-=
Boot's
> > > > > > > > lazy-init principle.
> > > > > > > >
> > > > > > > > We cannot just drop the virtio devices as they are used in =
sandbox tests.
> > > > > > > >
> > > > > > > > So for now just add a special case to work around this.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > > > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi=
_disk.c
> > > > > > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > > > > > --- a/lib/efi_loader/efi_disk.c
> > > > > > > > +++ b/lib/efi_loader/efi_disk.c
> > > > > > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(=
const efi_handle_t handle, char *buf, int
> > > > > > > >   efi_status_t efi_disks_register(void)
> > > > > > > >   {
> > > > > > > >     struct udevice *dev;
> > > > > > > > +   struct uclass *uc;
> > > > > > > >
> > > > > > > > -   uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > > > > > +   uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > > > > > +           /*
> > > > > > > > +            * The virtio block-device hangs on sandbox whe=
n accessed since
> > > > > > > > +            * there is nothing listening to the mailbox
> > > > > > > > +            */
> > > > > > > > +           if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > > > > +                   struct blk_desc *desc =3D dev_get_uclas=
s_plat(dev);
> > > > > > > > +
> > > > > > > > +                   if (desc->uclass_id =3D=3D UCLASS_VIRTI=
O)
> > > > > > > > +                           continue;
> > > > > > >
> > > > > > > We should avoid depending on the sandbox everywhere.
> > > > > > >
> > > > > > > Please, fix the problem in the sandbox driver.
> > > > > > >
> > > > > > > If you cannot fix it, run the tests involving virtio on QEMU =
instead of
> > > > > > > the sandbox.
> > > > >
> > > > > Which test? All of the EFI tests fail due to this problem. The te=
st
> > > > > actually has nothing to do with virtio, it is just that EFI goes =
and
> > > > > probes every single block device, since [1].
> > > >
> > > > Aren't we running "the tests" on other platforms such as QEMU today?
> > > >
> > > > > > This is an area we go back-and-forth on but, yes, IMHO, if we c=
an't
> > > > > > easily provide a virtio device for sandbox, QEMU is right there=
 and what
> > > > > > this is for, so I see sandbox as more useful as build rather th=
an
> > > > > > runtime checking in this case.
> > > > >
> > > > > The best solution would be to implement a simple emulator, like w=
e do
> > > > > in other places for sandbox. At present virtio_sandbox_notify() is
> > > > > empty.
> > > > >
> > > > > I don't mind working on that, but would like to get a temporary
> > > > > solution here so this test can land.
> > > > >
> > > > > Talking about virtio for QEMU is missing the point of this test, =
which
> > > > > is after all a test of booting an EFI app. I do wish more people =
would
> > > > > see the value in these unit tests. There is a talk at [2] which s=
hows
> > > > > how emulators are used in Zephyr.
> > > >
> > > > So that talk is interesting, yes. So, yes, implement the bus driver=
 for
> > > > sandbox for virtio, and until then we shouldn't have the tests runn=
ing
> > > > on sandbox? Or am I still missing something?
> > >
> > > Sure, but perhaps there is a way to get this test landed without doing
> > > that work right away?
> >
> > Maybe? I guess I'm missing how the problem isn't a problem with the
> > sandbox emulation of it.
>=20
> Basically the virtio block device is probed by EFI (for no useful
> purpose), but doesn't actually work.
>=20
> >
> > > I'm not sure if we actually need d5391bf02b9 ("efi_loader: ensure all
> > > block devices are probed"). It seems to fix a real problem, though.
> >
> > That commit seems fairly intentional and I kinda recall that being one
> > of those challenge points, conceptually. In order for the EFI_LOADER to
> > do what it needs to do correctly, it needs to know what all exists. This
> > is contrary to the usual U-Boot practice of not probing something until
> > it's specifically needed.
>=20
> Indeed, but we have to live with it.

Which gets back to the question I was asking, is the sandbox virtio
driver deficient here? It sounds like that doesn't work, and that's the
problem.

> > > > But I also still say that given that we as a project are more resou=
rce
> > > > constrained than Zephyr, for things that are QEMU-centric, there's
> > > > already a wealth of information on debugging QEMU since it too is
> > > > software. There's only so many hours in the day after all.
> > >
> > > One of Zephyr's challenges is that it relied on QEMU for almost all
> > > testing for a long time. As a result it takes a huge amount of CPU
> > > power to run tests - last I checked it was something like an hour on a
> > > 64-core machine. U-Boot's unit tests ('ut all') run in about 12
> > > seconds on my machine. I could go on for hours about the different
> > > types of tests and the benefits of one versus the other, but the
> > > cheapest answer is not necessarily just to do a 'happy path' test and
> > > call it good.
> >
> > Everything has it's place, yes. For us, sandbox tests take 15-20 minutes
> > per run in CI and most QEMU platforms finish up in about a minute. And
> > of course, it would be real nice if we could easily build those
> > platforms in CI with CONFIG_UNIT_TEST enabled, but I don't think that
> > would cause the run time to balloon up (nor are they the cause of the
> > overall time on sandbox, that would be filesystem tests).
>=20
> Right, I normally use 'make qcheck' which skips the FS test and some
> other slow ones
>=20
> Some notes from a little bit of digging: There are almost 1000 sandbox
> tests (17-20mins), but qemu_arm only runs 62 (2mins). With 'make
> qcheck' it runs about 2500 tests in about 4 minutes. I just got 'make
> pcheck' going again and that is a little faster (2.5 mins). Binman
> tests run in parallel if you use 'pip install concurrencytest'

Yes, I find it frustrating that I only tend to run ~50 tests on real
hardware each iteration and skip ~400. Of course, 250 of them are skips
because they only support sandbox. I guess I need to find time to dig in
to UNIT_TEST compiling on more platforms again.

--=20
Tom

--sDSmB0NrX436emLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma+h5cACgkQFHw5/5Y0
tyzx8Av/RESX5gK7EgagSmp1/oIj8L9m1zz+DfGe+GQpscLHmh8Fb42W9IsoaxhB
2d/f0P1//hMQAEvGvVPhJwpNV/yUqalrdUbjepRL7X/ZOc0VxVjjFMqiLnrMOS6t
wBPCxIZIjsGODvQySiXNqu4V+9vGCe1snoFbyKGKIXw+z9OjMpHWnk9wCET7suhu
qtM0PFrEjgr+2vjf0Ps3x+MEA/WBzBfEDXCISGI/rPvotbseB+fxa9PBAeXjgldk
KrSfnW5CaGfnIxjYJ67T1gdrZr4m8lycCA5ACoAa+A9EP4nLuM6EHuDJ4Ygs9Zs/
DE+eY1miNq9SaHuwFkMhVv6021Sh21DUgdkMI8NgC9S78HL4OJWX7++vYojTcBXj
V/tlVoarogGowB8IO+CIBgJZkN5o5ykj0WTMt1oCV2d/SWB6pFIQtZbWGLCCsXQQ
uBSOAjgStzK1/wRZAcBiKq/ldi6gzyYKJw/W7QoFJQUWc2uGwsLcA7ub9znfFhUO
93URsNGj
=/Xx0
-----END PGP SIGNATURE-----

--sDSmB0NrX436emLx--
