Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DDDC52D7F
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 17:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E4A889D3;
	Wed, 14 Aug 2024 19:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ri6lirM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04682889F6; Wed, 14 Aug 2024 19:56:08 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ECDC87873
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 19:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5de0e47b9so106133eaf.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723658164; x=1724262964; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LpWYTtCTaHm1H7KHabBbTS3KkPjSCPGV2L//ipqV9Ek=;
 b=ri6lirM+I/TVArNWu97SMdAVSIPCsQmn9N5A+asXtl1CU+jCYrpQ9QFwaOhJgpUoPK
 mC3oF+IKQhkDSex7gwyhuyZdZ0IhbnLG01PW8lbi5EeIAJVgP/99+D0G9UmTKUw1yVJ7
 48ElK5okDwvwWDz4rl7HWPInNh/A2hsln49NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723658164; x=1724262964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpWYTtCTaHm1H7KHabBbTS3KkPjSCPGV2L//ipqV9Ek=;
 b=ojWpz3PDQuoqdaVm+c4sq97TwihrphrRkvpqfXUJuuFCuBf7ifVkjEuyXg7ulgbCCB
 2ndqpT8GktFBkK07eZVHlCAEVfIqYJocA03LkuiB3R9q3XF7tnmI09zaBaiRw3dnnlpP
 TpcFxD0jrlaSAJsQ7ZyRZxW+SuympATMVQlDc9GxlwkKx5AAHJwUS29sIhlTRvL3HuFg
 I0SRITL2JF8SRJXja6+6niZoXrnT1v3wSFHl+3YnaCATrcSmAIUXiIVYIe59LF/OUWx4
 eK/Nn63JqPXgxsEnZAePCSbKMidjm66lOl71LimYxLrD/KOiK3Ii25qlGANyvZKyx84B
 1Nuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2ZUTNcAOWKeU432+wXwUDOELAVyVfAyE5hiIvHMr3Fj552bPbOZSKPfpogNz68m+VbC6YxGsRbqGcSVYXTrgEBtP1oQ==
X-Gm-Message-State: AOJu0YzMsXUBgHwwQ34bLhs+ugjp8uStrWPEkMPQ2xjK0pOf+2Hd5wkd
 B6eyKyGdVSq7+jOT8uoRLoTTkHUfQPs83oSZNVE3Gj4GxsE8SaiqX4yMoNrRNaA=
X-Google-Smtp-Source: AGHT+IFBiyW2ns3xtzXUGaeU57E7fnzdj0XzfbpiK7Vw5HyNzAv/WCtY7mXKQNRLtLoee835cdrpjQ==
X-Received: by 2002:a05:6820:228c:b0:5d8:f3f:b1f7 with SMTP id
 006d021491bc7-5da7c772d12mr3949192eaf.6.1723658164213; 
 Wed, 14 Aug 2024 10:56:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8877ca90sm83137eaf.6.2024.08.14.10.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 10:56:03 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:56:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 37/39] efi: Avoid using sandbox virtio devices
Message-ID: <20240814175601.GP1626301@bill-the-cat>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-38-sjg@chromium.org>
 <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
 <20240807015613.GD1626301@bill-the-cat>
 <CAFLszThhn0240xt1j6GQB9QTKxiHiAg6J3vMXCnHBE15iYZSkA@mail.gmail.com>
 <20240808200634.GR1626301@bill-the-cat>
 <CAFLszThM=23AXCOfZ_uOyGGDQTRurDpAjR-t8X_NHjz4LgQ9SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GwdERsGmAGP+x9VF"
Content-Disposition: inline
In-Reply-To: <CAFLszThM=23AXCOfZ_uOyGGDQTRurDpAjR-t8X_NHjz4LgQ9SA@mail.gmail.com>
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


--GwdERsGmAGP+x9VF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 08:50:21AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 8 Aug 2024 at 14:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 08, 2024 at 12:44:05PM -0600, Simon Glass wrote:
> > > Hi Heinrick, Tom,
> > >
> > > On Tue, 6 Aug 2024 at 19:56, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Aug 07, 2024 at 03:47:21AM +0200, Heinrich Schuchardt wrote:
> > > > > On 06.08.24 14:58, Simon Glass wrote:
> > > > > > While sandbox supports virtio it cannot support actually using =
the block
> > > > > > devices to read files, since there is nothing on the other end =
of the
> > > > > > 'virtqueue'.
> > > > > >
> > > > > > A recent change makes EFI probe all block devices, whether used=
 or not.
> > > > > > This is apparently required by EFI, although it violates U-Boot=
's
> > > > > > lazy-init principle.
> > > > > >
> > > > > > We cannot just drop the virtio devices as they are used in sand=
box tests.
> > > > > >
> > > > > > So for now just add a special case to work around this.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_dis=
k.c
> > > > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > > > --- a/lib/efi_loader/efi_disk.c
> > > > > > +++ b/lib/efi_loader/efi_disk.c
> > > > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(cons=
t efi_handle_t handle, char *buf, int
> > > > > >   efi_status_t efi_disks_register(void)
> > > > > >   {
> > > > > >     struct udevice *dev;
> > > > > > +   struct uclass *uc;
> > > > > >
> > > > > > -   uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > > > +   uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > > > +           /*
> > > > > > +            * The virtio block-device hangs on sandbox when ac=
cessed since
> > > > > > +            * there is nothing listening to the mailbox
> > > > > > +            */
> > > > > > +           if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > > +                   struct blk_desc *desc =3D dev_get_uclass_pl=
at(dev);
> > > > > > +
> > > > > > +                   if (desc->uclass_id =3D=3D UCLASS_VIRTIO)
> > > > > > +                           continue;
> > > > >
> > > > > We should avoid depending on the sandbox everywhere.
> > > > >
> > > > > Please, fix the problem in the sandbox driver.
> > > > >
> > > > > If you cannot fix it, run the tests involving virtio on QEMU inst=
ead of
> > > > > the sandbox.
> > >
> > > Which test? All of the EFI tests fail due to this problem. The test
> > > actually has nothing to do with virtio, it is just that EFI goes and
> > > probes every single block device, since [1].
> >
> > Aren't we running "the tests" on other platforms such as QEMU today?
> >
> > > > This is an area we go back-and-forth on but, yes, IMHO, if we can't
> > > > easily provide a virtio device for sandbox, QEMU is right there and=
 what
> > > > this is for, so I see sandbox as more useful as build rather than
> > > > runtime checking in this case.
> > >
> > > The best solution would be to implement a simple emulator, like we do
> > > in other places for sandbox. At present virtio_sandbox_notify() is
> > > empty.
> > >
> > > I don't mind working on that, but would like to get a temporary
> > > solution here so this test can land.
> > >
> > > Talking about virtio for QEMU is missing the point of this test, which
> > > is after all a test of booting an EFI app. I do wish more people would
> > > see the value in these unit tests. There is a talk at [2] which shows
> > > how emulators are used in Zephyr.
> >
> > So that talk is interesting, yes. So, yes, implement the bus driver for
> > sandbox for virtio, and until then we shouldn't have the tests running
> > on sandbox? Or am I still missing something?
>=20
> Sure, but perhaps there is a way to get this test landed without doing
> that work right away?

Maybe? I guess I'm missing how the problem isn't a problem with the
sandbox emulation of it.

> I'm not sure if we actually need d5391bf02b9 ("efi_loader: ensure all
> block devices are probed"). It seems to fix a real problem, though.

That commit seems fairly intentional and I kinda recall that being one
of those challenge points, conceptually. In order for the EFI_LOADER to
do what it needs to do correctly, it needs to know what all exists. This
is contrary to the usual U-Boot practice of not probing something until
it's specifically needed.

> > But I also still say that given that we as a project are more resource
> > constrained than Zephyr, for things that are QEMU-centric, there's
> > already a wealth of information on debugging QEMU since it too is
> > software. There's only so many hours in the day after all.
>=20
> One of Zephyr's challenges is that it relied on QEMU for almost all
> testing for a long time. As a result it takes a huge amount of CPU
> power to run tests - last I checked it was something like an hour on a
> 64-core machine. U-Boot's unit tests ('ut all') run in about 12
> seconds on my machine. I could go on for hours about the different
> types of tests and the benefits of one versus the other, but the
> cheapest answer is not necessarily just to do a 'happy path' test and
> call it good.

Everything has it's place, yes. For us, sandbox tests take 15-20 minutes
per run in CI and most QEMU platforms finish up in about a minute. And
of course, it would be real nice if we could easily build those
platforms in CI with CONFIG_UNIT_TEST enabled, but I don't think that
would cause the run time to balloon up (nor are they the cause of the
overall time on sandbox, that would be filesystem tests).

> For this particular test, I do want to have tests for each bootmeth,
> to the point of running the target, so far as possible. It turns out
> that we can launch an EFI app on sandbox, so connecting it up to
> bootstd seems valuable to me.
>=20
> I've filed an issue for the virtio improvements.

OK, thanks.

--=20
Tom

--GwdERsGmAGP+x9VF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma876oACgkQFHw5/5Y0
tywYrgwAjKNbXZldc1pDPM0yXPGTGzOquVjWY7gyE10hgSGZtcHr6tg2FX5JQG8A
a0vh4sJu6jZ27BcAT0tsWJ8UJFd+W5UZ9mpDJozyfdwmGoUV+xCm+DXx9LT+Oj1v
kEADOBnqOdSRQyAuW0UIgjpPOIoIwtZT2Iyn5OJhWLEuLPiVi8JYDYMKwyVdBMFq
Up+00Cyk0SK+KOFDTJ8wl4F2C2PxkU6n4NqX8FeXT/H4g3ThtRq2+T06nN+5qr26
4E66U80vslqFJfpWepcZiUCfBWCSV4aW9bdtNClH0gw8u3MSAIOLP5H1Afy3f/CE
T1NKanVkcZvfXzt8GjuoGSptvXWVJlG7uSJ4RTJBHuYd4qepiFW9017gVywMFFut
uFWXPBqE/5D2gIjjZsrMFdg3Di+basKnLDgexBMb0FX/ACpw7yOnykS6N9b31B+L
DDMRVDLySp/G3KipYVwAHbBgpXiijE3hvyh3DAVsrVskaHRzSxZCgb9zgEgh6XHZ
n5dUYgfb
=TjKR
-----END PGP SIGNATURE-----

--GwdERsGmAGP+x9VF--
