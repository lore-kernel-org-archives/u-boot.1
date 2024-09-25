Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB0BCCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0231188CA0;
	Wed, 25 Sep 2024 19:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GkQOKCZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C75288C05; Wed, 25 Sep 2024 19:26:23 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 281F888CB8
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 19:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-457cfc2106aso165361cf.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727285177; x=1727889977; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tfzAD9xyfcmbY0xTjkPlBEQA8Y3fPDag9C/n9zqjhsw=;
 b=GkQOKCZHGuOBH/dT1sRVrSDAUrPijXjsQKnc7iTLL94Vi03e4He0JTQe1nLXPu53bU
 fyubh+vs157Vd5OJxipmk/N/yOJA/crrpuyCU6ivXqfc2e1O9tr58CDroh+ZIaBg2/EQ
 j1o5+G6OJdrIdwKgM9WaJP2uOY7GvQkELPhNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285177; x=1727889977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfzAD9xyfcmbY0xTjkPlBEQA8Y3fPDag9C/n9zqjhsw=;
 b=GeSlQyyHeC2/AsL82G17Zt10I1xoWlPWgkrQD6YovmCwZCwP2I7dPwCHLAYayWZ1HT
 vJWT5DtCepm8MG9GohUOKhjv2fXtWN9L6RcZRrvMpF7DrS0V+NvEiu3a4xjcqInupPRO
 tnjirHA0HF8ALR4rpqg4mkFAkVBPLLxajdwuM1KvaH2WYzKDkP2DqRmdrUHLIKlunY6n
 nAjrTZRfD0u5cacYjTFyNN0EGp5HkEc4kYW2Ltz7G38/J8gVeLOR2LJ2zePC22Pj3Wpw
 yvtfUrNZXdHHirgNWAGjdVV8RxOj5U4N+qtr59O6ThLBrJDO4/TV5x4nt6Xh78Cia7Go
 j/ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW203SBZ1DV7UOJ2eXxOUqlKL/Xrt+qfqbtGy4fv004AHzX09sVmJZjeQD9uyCvKFFed9jrqFY=@lists.denx.de
X-Gm-Message-State: AOJu0YzrU79BW/jXBuD1lkmgYhrC2XzIKtKJ98lCuVGb8tZPdxAhbR9K
 WO+g1j8iQluG/SGdWg0GmJkj1iYVhY/cuqwwCZXUI4CGRd/KQsGEgj7p7EMmXv3e6NAK4rj0AyN
 7nqU=
X-Google-Smtp-Source: AGHT+IF+rlZmzwBJPp6M56RcNohp8ltzI9DitSh3Md4rlXSjaA7VNYo7YIdsmCcAYI6esndp8/RqoA==
X-Received: by 2002:a05:622a:250:b0:458:34df:1e5c with SMTP id
 d75a77b69052e-45b5dec7808mr57399081cf.12.1727285176849; 
 Wed, 25 Sep 2024 10:26:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b5264b660sm17870851cf.59.2024.09.25.10.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:26:15 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:26:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 12/14] efi_loader: Avoid using sandbox virtio devices
Message-ID: <20240925172613.GC4252@bill-the-cat>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-13-sjg@chromium.org>
 <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
 <CAFLszTj47fa7m2Xa4yi5NkcWNUGr4kiM1z4sAnrbd5rFUKq1Zw@mail.gmail.com>
 <20240917170346.GN4252@bill-the-cat>
 <CAFLszThMhNzvW=OTgsAA0Hikv+uxLaVn7bwTGM0=htf=BbzmcA@mail.gmail.com>
 <20240919174554.GT4252@bill-the-cat>
 <CAFLszThvd4HSz6n+3OPVcQ4sv-pKD5rPfvJ_2gy_aLnPMG40hQ@mail.gmail.com>
 <20240920145933.GB4252@bill-the-cat>
 <CAFLszTi=Kquk3AfQJYpYdvmZn=EKNZTzjOL-ukLJCtP15KfigQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A5iScEtzW/2CwZ5/"
Content-Disposition: inline
In-Reply-To: <CAFLszTi=Kquk3AfQJYpYdvmZn=EKNZTzjOL-ukLJCtP15KfigQ@mail.gmail.com>
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


--A5iScEtzW/2CwZ5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 02:52:04PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 20 Sept 2024 at 16:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 20, 2024 at 09:25:29AM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 19 Sept 2024 at 19:45, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Sep 19, 2024 at 04:10:12PM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 17 Sept 2024 at 19:03, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > >
> > > > > > On Mon, Sep 16, 2024 at 05:42:31PM +0200, Simon Glass wrote:
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Thu, 12 Sept 2024 at 09:12, Heinrich Schuchardt <xypron.gl=
pk@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 02.09.24 03:18, Simon Glass wrote:
> > > > > > > > > While sandbox supports virtio it cannot support actually =
using the block
> > > > > > > > > devices to read files, since there is nothing on the othe=
r end of the
> > > > > > > > > 'virtqueue'.
> > > > > > > > >
> > > > > > > > > A recent change makes EFI probe all block devices, whethe=
r used or not.
> > > > > > > > > This is apparently required by EFI, although it violates =
U-Boot's
> > > > > > > > > lazy-init principle.
> > > > > > > >
> > > > > > > > We always did this.
> > > > > > >
> > > > > > > Commit d5391bf02b9 dates from 2022, so I don't think that is =
correct.
> > > > > >
> > > > > > Yes, but I also could have sworn that was fixing the behavior h=
aving
> > > > > > been changed again previous to that.
> > > > >
> > > > > I don't see any evidence of that, though.
> > > >
> > > > Yes, it's just my recollection of the time and I could be misrememb=
ering
> > > > it as one of the other times we've had this discussion.
> > > >
> > > > > > > > What problem do you want to fix? I have not seen any issues=
 in our CI.
> > > > > > >
> > > > > > > The EFI test in this series hangs trying to probe a virtio bl=
ock
> > > > > > > device. If you drop this patch and try the rest of the series=
 in CI,
> > > > > > > you will see the failure. Or you could just accept that I inv=
estigated
> > > > > > > this, root-caused it and produced a suitable fix. This is a v=
5 patch
> > > > > > > which has had quite a bit of discussion.
> > > > > >
> > > > > > And as I noted an iteration or two back, it's entirely unclear =
if the
> > > > > > problem is "sandbox virtio is broken" or "this code is wrong he=
re".
> > > > > > Which in fact gets us back to ...
> > > > >
> > > > > sandbox virtio does not support a functioning block device
> > > > >
> > > > > >
> > > > > > > > > We cannot just drop the virtio devices as they are used i=
n sandbox tests.
> > > > > > > > >
> > > > > > > > > So for now just add a special case to work around this.
> > > > > > > > >
> > > > > > > > > The eventual fix is likely adding an implementation of
> > > > > > > > > virtio_sandbox_notify() to actually do the block read. Th=
at is tracked
> > > > > > > > > in [1].
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > Fixes: d5391bf02b9 ("efi_loader: ensure all block devices=
 are probed")
> > > > > > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.or=
g>
> > > > > > > > > [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > (no changes since v3)
> > > > > > > > >
> > > > > > > > > Changes in v3:
> > > > > > > > > - Add a Fixes tag
> > > > > > > > > - Mention the issue created for this problem
> > > > > > > > >
> > > > > > > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > > > > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/e=
fi_disk.c
> > > > > > > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > > > > > > --- a/lib/efi_loader/efi_disk.c
> > > > > > > > > +++ b/lib/efi_loader/efi_disk.c
> > > > > > > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_nam=
e(const efi_handle_t handle, char *buf, int
> > > > > > > > >   efi_status_t efi_disks_register(void)
> > > > > > > > >   {
> > > > > > > > >       struct udevice *dev;
> > > > > > > > > +     struct uclass *uc;
> > > > > > > > >
> > > > > > > > > -     uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > > > > > > +     uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > > > > > > +             /*
> > > > > > > > > +              * The virtio block-device hangs on sandbox=
 when accessed since
> > > > > > > > > +              * there is nothing listening to the mailbox
> > > > > > > > > +              */
> > > > > > > > > +             if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > > > > > +                     struct blk_desc *desc =3D dev_get_u=
class_plat(dev);
> > > > > > > > > +
> > > > > > > > > +                     if (desc->uclass_id =3D=3D UCLASS_V=
IRTIO)
> > > > > > > > > +                             continue;
> > > > > > > > > +             }
> > > > > > > > > +             device_probe(dev);
> > > > > > > > >       }
> > > > > > > > >
> > > > > > > > >       return EFI_SUCCESS;
> > > > > > > >
> > > > > > > > Please, do not spray sandbox tweaks all over the place.
> > > > > > > >
> > > > > > > > Can't you just return an error from the sandbox-virtio driv=
er when an
> > > > > > > > attempt to read a queue is made?
> > > > > > > >
> > > > > > > > We are using virtio on QEMU. Why do we need sandbox virtio =
devices? Just
> > > > > > > > run the relevant tests on the real thing.
> > > > > > >
> > > > > > > Please go ahead with whatever approach to testing you wish. B=
ut
> > > > > > > sandbox testing is an important component of U-Boot.
> > > > > >
> > > > > > Yes, but is sandbox implementing the "just be a state machine" =
part here
> > > > > > correctly, or not? It keeps feeling like "not" and that the rea=
sonable
> > > > > > course of action would be to stop testing this on sandbox until=
 that is
> > > > > > fixed especially since we can test this reliably on qemu.
> > > >
> > > > OK, but I can't tell if your answer to my point here is:
> > > > - Yes, sandbox virtio is broken / incomplete
> > > > - No, sandbox virtio is fine, there's some other mismatch between h=
ow
> > > >   it's used for sandbox and how it's used for QEMU. This will get
> > > >   resolved later.
> > >
> > > It is incomplete, in that the block device is not fully implemented.
> >
> > Then please disable it until you can complete it.
> >
> > > No other test enables it, but EFI does, since it blinding tries to
> > > access all block devices without any control.
> > >
> > > >
> > > > > We have to move things forward a piece at a time. Not having a pr=
oper
> > > > > test for the EFI bootmeth is a significant gap and is what I am t=
rying
> > > > > to fix with this series. It isn't perfect, but it is a step forwa=
rd
> > > > > and will prevent regressions. It can also be built on later.
> > > > >
> > > > > Happy-path testing with QEMU is all very well, but it only goes s=
o far.
> > > >
> > > > I frankly get really puzzled about why testing all of this, in QEMU,
> > > > where we could actually design the test to see if the OS has booted=
 (and
> > > > if we leave things configurable well enough, do this on real hardwa=
re)
> > > > is wrong but sandbox, where we can't boot the OS, is good. Especial=
ly
> > > > for the device that's only present in an emulator. We're emulating =
an
> > > > emulator and not getting matching behavior in our emulator.
> > >
> > > There are many reasons:
> >
> > To be clear, I'm not saying sandbox tests have no value, or are
> > unimportant. I apologize for imply as much.
> >
> > > - with sandbox we can test the operation of the bootmeth, including
> > > under failure conditions
> >
> > Yes, state machine tests are useful. But we can test for xFAIL on other
> > platforms, yes?
> >
> > > - we can test what happens within U-Boot itself when
> > > exit-boot-services is called, which is the bug that provoked me to
> > > write the test
> >
> > I honestly don't recall the state of the discussion around that patch,
> > positive/negative/neutral.
> >
> > > - we can build on this test to cover other bootmeths without needing
> > > to install a full OS just to run a test
> >
> > Counter point, we can't test that an OS actually boots. One of the most
> > valuable personally tests we've added recently is
> > test/py/tests/test_net_boot.py which makes the network load and boot an
> > OS image, and test for (some) failure modes.
>=20
> What do you want me to do with this patch?
>=20
> Without it, the test cannot pass. Are you suggesting that we apply the
> patches, but don't enable the test until it can be made to work,
> without this patch? Are you suggesting that I implement block devices
> for virtio in sandbox?
>=20
> I see great value in this test. It covers a case which we don't
> currently have in CI.
>=20
> Please can you just take this patch so we can move forward?? I'm happy
> to add the virtio support later.

I'm suggesting, again, that you need to disable the sandbox virtio
driver until you can come and complete it.

--=20
Tom

--A5iScEtzW/2CwZ5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb0R7UACgkQFHw5/5Y0
tyyb2wv/T69R6diwQ4ZJ07fL3fHQepSKVrO2JhNNcP4YLC3UVRdoLid7ZhoqzlJB
KOGIlXiKu5UF37k7vPFG73yKFwvMUyRHjQrtQAIKcDBmIzzYj/GXYGP0InGvU/n9
l3FE2qDpKejI5FH9wFtyagfD+IowfjGhDFXH+B2p7F3W4zyn0dzodJ2Jbul/hthV
X5x5kosIxE++LmJRHGcpYdvA+cl5NNpV0mzyoNTGkIx1wKRA9NBzHgLttDUnIK2G
nKX2lGCxPcPIZng2CzD679c2zqMhKweHrIrvrZ73KvhmyrhvQXOY8bvOnbFaTyv+
cghyfXEHd6FUpAWnpdlYShmv1H2xX3p6x/Gaa8GOb8AoTkFk2KRSl8VuQtRFPQNc
R1wGsVtZAGVOd51QrlPBXfUgRR50VVq/+EZFZvhklFaAWp89SiKIlk0WCC6Jk8W1
rzx/BysRbC4ckjgV8LX+/WWkRS0ED/45XcUtUjvb0Y+V4Ho2abyRTP05fQGoF6KV
ko7ZNNRU
=inGI
-----END PGP SIGNATURE-----

--A5iScEtzW/2CwZ5/--
