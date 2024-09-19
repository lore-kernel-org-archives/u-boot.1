Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8F5CF3963
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 17:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1B5892C8;
	Thu, 19 Sep 2024 19:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JhwhjP5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48280892B3; Thu, 19 Sep 2024 19:46:03 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3830889242
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 19:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5e1b55346c0so521122eaf.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726767959; x=1727372759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bv+VEzgkz7Hz2wD2ZFjB3qyNBgtNL4+7KGPhLPLz/7U=;
 b=JhwhjP5ZiIcUnIbuCiqLbAQweNjMiweuyn5qCeeiCAff19fs4aXBdZTdeezMZE3lCT
 zztJ71usE1/T4Cq/zDy+ZY8Wo1TTYCAMjYSL16TS7TsPK4PP6/jB/WWZo/R5yTQyQHQd
 nlkKgZXtw72rTHgktyjc1LVogy19kPVICpkzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726767959; x=1727372759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bv+VEzgkz7Hz2wD2ZFjB3qyNBgtNL4+7KGPhLPLz/7U=;
 b=LjYZmFvn5E+oqPkEAeWsxR9xBh/eeikZVa4rCsLkKdVJBzkxHuuXoY2eSsL1Rbt75v
 IdiQb6eplDtdM9gu/KG/CB30IsDBrDEQNL0i4cd67RW6EyNOn1M8LJWQzN8/HucmLeWl
 ZCImtLmRLBhOgkf8fRY8sViLDDpXZpXBXWoFIV91iaPrq7PsV1Q/3YB+t3CKJyNhdxPs
 HcvhPK8Rqk4caMIvhabYhGHwdNkjgUZ+8aDJDkO3l9ntSTIGS6erRrb8dWymxII7PPa+
 aJqEJMq8oGqVFuOVrETBZ/Zr3kvv8VyadGavfhzoxmLbE6SFtp+KQTUZGRUiYFZ7mtFR
 7KXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKlcx57mNJzq0/5VQpxmBdKAKv67FbNC1piyUN8JRsK0mqE9KUlt5YPvq701A+rKYqTWL6g/A=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2SOlmrAVFvx3irdY0XaLHB3NRENPZoKQMWvlnFZ97r3DxlyoE
 nzX5Uok03mzaMVGEZShQLf0MieaMwoqBuHgnxJGXRt/tUGuOKnk9jabLGxrHH28=
X-Google-Smtp-Source: AGHT+IERkhMau9kx/FUooIebWngwkHPlhHwSSZJnmLALeJimjL2JXnl6rUdvhS8BOZik4gJAkOSc0g==
X-Received: by 2002:a05:6358:27a8:b0:1bc:2cff:7209 with SMTP id
 e5c5f4694b2df-1bc975e8240mr52240555d.5.1726767958743; 
 Thu, 19 Sep 2024 10:45:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e576f65sm9447996d6.104.2024.09.19.10.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:45:58 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:45:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 12/14] efi_loader: Avoid using sandbox virtio devices
Message-ID: <20240919174554.GT4252@bill-the-cat>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-13-sjg@chromium.org>
 <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
 <CAFLszTj47fa7m2Xa4yi5NkcWNUGr4kiM1z4sAnrbd5rFUKq1Zw@mail.gmail.com>
 <20240917170346.GN4252@bill-the-cat>
 <CAFLszThMhNzvW=OTgsAA0Hikv+uxLaVn7bwTGM0=htf=BbzmcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UcgNy/bGwRKmphHX"
Content-Disposition: inline
In-Reply-To: <CAFLszThMhNzvW=OTgsAA0Hikv+uxLaVn7bwTGM0=htf=BbzmcA@mail.gmail.com>
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


--UcgNy/bGwRKmphHX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 04:10:12PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Sept 2024 at 19:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Sep 16, 2024 at 05:42:31PM +0200, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Thu, 12 Sept 2024 at 09:12, Heinrich Schuchardt <xypron.glpk@gmx.d=
e> wrote:
> > > >
> > > > On 02.09.24 03:18, Simon Glass wrote:
> > > > > While sandbox supports virtio it cannot support actually using th=
e block
> > > > > devices to read files, since there is nothing on the other end of=
 the
> > > > > 'virtqueue'.
> > > > >
> > > > > A recent change makes EFI probe all block devices, whether used o=
r not.
> > > > > This is apparently required by EFI, although it violates U-Boot's
> > > > > lazy-init principle.
> > > >
> > > > We always did this.
> > >
> > > Commit d5391bf02b9 dates from 2022, so I don't think that is correct.
> >
> > Yes, but I also could have sworn that was fixing the behavior having
> > been changed again previous to that.
>=20
> I don't see any evidence of that, though.

Yes, it's just my recollection of the time and I could be misremembering
it as one of the other times we've had this discussion.

> > > > What problem do you want to fix? I have not seen any issues in our =
CI.
> > >
> > > The EFI test in this series hangs trying to probe a virtio block
> > > device. If you drop this patch and try the rest of the series in CI,
> > > you will see the failure. Or you could just accept that I investigated
> > > this, root-caused it and produced a suitable fix. This is a v5 patch
> > > which has had quite a bit of discussion.
> >
> > And as I noted an iteration or two back, it's entirely unclear if the
> > problem is "sandbox virtio is broken" or "this code is wrong here".
> > Which in fact gets us back to ...
>=20
> sandbox virtio does not support a functioning block device
>=20
> >
> > > > > We cannot just drop the virtio devices as they are used in sandbo=
x tests.
> > > > >
> > > > > So for now just add a special case to work around this.
> > > > >
> > > > > The eventual fix is likely adding an implementation of
> > > > > virtio_sandbox_notify() to actually do the block read. That is tr=
acked
> > > > > in [1].
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are pro=
bed")
> > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> > > > > ---
> > > > >
> > > > > (no changes since v3)
> > > > >
> > > > > Changes in v3:
> > > > > - Add a Fixes tag
> > > > > - Mention the issue created for this problem
> > > > >
> > > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > > --- a/lib/efi_loader/efi_disk.c
> > > > > +++ b/lib/efi_loader/efi_disk.c
> > > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const =
efi_handle_t handle, char *buf, int
> > > > >   efi_status_t efi_disks_register(void)
> > > > >   {
> > > > >       struct udevice *dev;
> > > > > +     struct uclass *uc;
> > > > >
> > > > > -     uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > > +     uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > > +             /*
> > > > > +              * The virtio block-device hangs on sandbox when ac=
cessed since
> > > > > +              * there is nothing listening to the mailbox
> > > > > +              */
> > > > > +             if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > +                     struct blk_desc *desc =3D dev_get_uclass_pl=
at(dev);
> > > > > +
> > > > > +                     if (desc->uclass_id =3D=3D UCLASS_VIRTIO)
> > > > > +                             continue;
> > > > > +             }
> > > > > +             device_probe(dev);
> > > > >       }
> > > > >
> > > > >       return EFI_SUCCESS;
> > > >
> > > > Please, do not spray sandbox tweaks all over the place.
> > > >
> > > > Can't you just return an error from the sandbox-virtio driver when =
an
> > > > attempt to read a queue is made?
> > > >
> > > > We are using virtio on QEMU. Why do we need sandbox virtio devices?=
 Just
> > > > run the relevant tests on the real thing.
> > >
> > > Please go ahead with whatever approach to testing you wish. But
> > > sandbox testing is an important component of U-Boot.
> >
> > Yes, but is sandbox implementing the "just be a state machine" part here
> > correctly, or not? It keeps feeling like "not" and that the reasonable
> > course of action would be to stop testing this on sandbox until that is
> > fixed especially since we can test this reliably on qemu.

OK, but I can't tell if your answer to my point here is:
- Yes, sandbox virtio is broken / incomplete
- No, sandbox virtio is fine, there's some other mismatch between how
  it's used for sandbox and how it's used for QEMU. This will get
  resolved later.

> We have to move things forward a piece at a time. Not having a proper
> test for the EFI bootmeth is a significant gap and is what I am trying
> to fix with this series. It isn't perfect, but it is a step forward
> and will prevent regressions. It can also be built on later.
>=20
> Happy-path testing with QEMU is all very well, but it only goes so far.

I frankly get really puzzled about why testing all of this, in QEMU,
where we could actually design the test to see if the OS has booted (and
if we leave things configurable well enough, do this on real hardware)
is wrong but sandbox, where we can't boot the OS, is good. Especially
for the device that's only present in an emulator. We're emulating an
emulator and not getting matching behavior in our emulator.

--=20
Tom

--UcgNy/bGwRKmphHX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbsY0wACgkQFHw5/5Y0
tyzD9gwAh2Q+us9nsPjGJsKbFdKyfEkEIagQXBgZU/remoEQqTAO2x4s0LdgBNHV
l/jUQDdxmTd1zyLaSUeLNYsYbYlyrBN2XldQQ1WZ1+RWxSS5aPawKvSNXbNhXg9W
swNJEvGS/syxEEwtnx139gCFqjEEE3yKRsEMIcRSgmEaFNPPWAoJwx+B8kBl2KWk
egWHxb8+FqI0bfeJsikORsh0CwM1CJPol5Ir/Hb6XLUMw3Lv19kZDUb59roCkcQu
aS6i48YtinlGgwk0TSPMO1Kt7/moObd9ob4nBQZJDhM+2l0dQM1E12BLXO5DzVdJ
JhrdkQO0jjVPAMw+JH6AHDm7qP6DyCWh5Xa1oCQB7Oa22cJ70e6N7PiXmLXaPx2x
T32bbOjj/TctRdTjRGMj/5Yj7N8e9SoFrH8ohOWANPPbbPiGCOPnzzF9iz1JAhky
L1i9YYljDwpUmDPZuF8z9DivlgNgwF51HGJB8J7mdXysBXLU0/RmIZQDoK8sfBd8
HtrkyOt6
=5ES4
-----END PGP SIGNATURE-----

--UcgNy/bGwRKmphHX--
