Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1336FC78858
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 14:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E77888AFF;
	Fri, 20 Sep 2024 16:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WaREdJQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA89788B0A; Fri, 20 Sep 2024 16:59:41 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DEDE88AA7
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 16:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-502c0ffd07cso570998e0c.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726844378; x=1727449178; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=alY3XSskB//LISmMqEm12jhnI0SDbdDGq+3T8jjtooE=;
 b=WaREdJQO8/2qBk0cxBP1LJpVtIgxnwByLHYtzeTigliWYg4/Fk0avTPjygcBMBqAWc
 HRHF5L+v4t7ZfcXN3wqRGmEXFH89QMsvSbBEbjmp+bYHtd7uyzKLdCvjLtrD3MzkKoK/
 J6v0jBTq+XpM+cB4YqJJvE/scNd/b817wSJR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726844378; x=1727449178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alY3XSskB//LISmMqEm12jhnI0SDbdDGq+3T8jjtooE=;
 b=CV9QQQPyDA91A//5Uw1lHFTIepas+I/VuSngV2XXcOtHJOR+W8XKtECJZ7bTRrb2cG
 cqV8rDMoIMaIFQVvJ1Rzpcyz4VTtlZAtFZivbSbBS7ddOr2Z7wj4cK/5m/g2n/M63Cxs
 AXV/T29sLahBnaw5rBnFos8ascGE3pNIJpTcPM82Jmap2DZfK8Xo0LEp9kag9NUoArfy
 63H+AuDAgy6rnSGPK89qDmLlpDUpdkZxRV+kByjNNc7SJD3SMbZqHe1hpBlLeeIGtjqm
 UUAIpchLzA3zcBhoqFOkHQtDrdWIzbwx6FHCmW4/FWVR/MeSEC7kv4ot5KLMEQUmRvt/
 G3Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdlOZssude7+zDnn6fP9X1DzwVw0E0Ip4X55usPm9TCZ4HAdS6MvTlHpVhaH0nuaFCD9YNkXc=@lists.denx.de
X-Gm-Message-State: AOJu0YzDzguSLKQG9YtoNckJjNMl4HGPdVbm5TMJ4N631ZpfJB6RpV6a
 fXWYNjBOxTvRcyridyUaK2GXO5poVFCMV/M+WFyQNCrfhOUAP0yakQhx3ILWAIk=
X-Google-Smtp-Source: AGHT+IHvk7iOxCT/OwuF+5WHaagdCBamNCgZSoh1BKL7O36BDqyghITvkPx2/NHotYOM325DJeMCsQ==
X-Received: by 2002:a05:6122:468a:b0:501:be30:2abf with SMTP id
 71dfb90a1353d-503e03d3d5cmr2434212e0c.1.1726844377961; 
 Fri, 20 Sep 2024 07:59:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb08d9471sm186126585a.106.2024.09.20.07.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 07:59:37 -0700 (PDT)
Date: Fri, 20 Sep 2024 08:59:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 12/14] efi_loader: Avoid using sandbox virtio devices
Message-ID: <20240920145933.GB4252@bill-the-cat>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-13-sjg@chromium.org>
 <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
 <CAFLszTj47fa7m2Xa4yi5NkcWNUGr4kiM1z4sAnrbd5rFUKq1Zw@mail.gmail.com>
 <20240917170346.GN4252@bill-the-cat>
 <CAFLszThMhNzvW=OTgsAA0Hikv+uxLaVn7bwTGM0=htf=BbzmcA@mail.gmail.com>
 <20240919174554.GT4252@bill-the-cat>
 <CAFLszThvd4HSz6n+3OPVcQ4sv-pKD5rPfvJ_2gy_aLnPMG40hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FW+lnRyIGGhQerUY"
Content-Disposition: inline
In-Reply-To: <CAFLszThvd4HSz6n+3OPVcQ4sv-pKD5rPfvJ_2gy_aLnPMG40hQ@mail.gmail.com>
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


--FW+lnRyIGGhQerUY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 09:25:29AM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 19 Sept 2024 at 19:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Sep 19, 2024 at 04:10:12PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 17 Sept 2024 at 19:03, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Sep 16, 2024 at 05:42:31PM +0200, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >
> > > > > On Thu, 12 Sept 2024 at 09:12, Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
> > > > > >
> > > > > > On 02.09.24 03:18, Simon Glass wrote:
> > > > > > > While sandbox supports virtio it cannot support actually usin=
g the block
> > > > > > > devices to read files, since there is nothing on the other en=
d of the
> > > > > > > 'virtqueue'.
> > > > > > >
> > > > > > > A recent change makes EFI probe all block devices, whether us=
ed or not.
> > > > > > > This is apparently required by EFI, although it violates U-Bo=
ot's
> > > > > > > lazy-init principle.
> > > > > >
> > > > > > We always did this.
> > > > >
> > > > > Commit d5391bf02b9 dates from 2022, so I don't think that is corr=
ect.
> > > >
> > > > Yes, but I also could have sworn that was fixing the behavior having
> > > > been changed again previous to that.
> > >
> > > I don't see any evidence of that, though.
> >
> > Yes, it's just my recollection of the time and I could be misremembering
> > it as one of the other times we've had this discussion.
> >
> > > > > > What problem do you want to fix? I have not seen any issues in =
our CI.
> > > > >
> > > > > The EFI test in this series hangs trying to probe a virtio block
> > > > > device. If you drop this patch and try the rest of the series in =
CI,
> > > > > you will see the failure. Or you could just accept that I investi=
gated
> > > > > this, root-caused it and produced a suitable fix. This is a v5 pa=
tch
> > > > > which has had quite a bit of discussion.
> > > >
> > > > And as I noted an iteration or two back, it's entirely unclear if t=
he
> > > > problem is "sandbox virtio is broken" or "this code is wrong here".
> > > > Which in fact gets us back to ...
> > >
> > > sandbox virtio does not support a functioning block device
> > >
> > > >
> > > > > > > We cannot just drop the virtio devices as they are used in sa=
ndbox tests.
> > > > > > >
> > > > > > > So for now just add a special case to work around this.
> > > > > > >
> > > > > > > The eventual fix is likely adding an implementation of
> > > > > > > virtio_sandbox_notify() to actually do the block read. That i=
s tracked
> > > > > > > in [1].
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are=
 probed")
> > > > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > > [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v3)
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Add a Fixes tag
> > > > > > > - Mention the issue created for this problem
> > > > > > >
> > > > > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_d=
isk.c
> > > > > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > > > > --- a/lib/efi_loader/efi_disk.c
> > > > > > > +++ b/lib/efi_loader/efi_disk.c
> > > > > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(co=
nst efi_handle_t handle, char *buf, int
> > > > > > >   efi_status_t efi_disks_register(void)
> > > > > > >   {
> > > > > > >       struct udevice *dev;
> > > > > > > +     struct uclass *uc;
> > > > > > >
> > > > > > > -     uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > > > > +     uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > > > > +             /*
> > > > > > > +              * The virtio block-device hangs on sandbox whe=
n accessed since
> > > > > > > +              * there is nothing listening to the mailbox
> > > > > > > +              */
> > > > > > > +             if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > > > +                     struct blk_desc *desc =3D dev_get_uclas=
s_plat(dev);
> > > > > > > +
> > > > > > > +                     if (desc->uclass_id =3D=3D UCLASS_VIRTI=
O)
> > > > > > > +                             continue;
> > > > > > > +             }
> > > > > > > +             device_probe(dev);
> > > > > > >       }
> > > > > > >
> > > > > > >       return EFI_SUCCESS;
> > > > > >
> > > > > > Please, do not spray sandbox tweaks all over the place.
> > > > > >
> > > > > > Can't you just return an error from the sandbox-virtio driver w=
hen an
> > > > > > attempt to read a queue is made?
> > > > > >
> > > > > > We are using virtio on QEMU. Why do we need sandbox virtio devi=
ces? Just
> > > > > > run the relevant tests on the real thing.
> > > > >
> > > > > Please go ahead with whatever approach to testing you wish. But
> > > > > sandbox testing is an important component of U-Boot.
> > > >
> > > > Yes, but is sandbox implementing the "just be a state machine" part=
 here
> > > > correctly, or not? It keeps feeling like "not" and that the reasona=
ble
> > > > course of action would be to stop testing this on sandbox until tha=
t is
> > > > fixed especially since we can test this reliably on qemu.
> >
> > OK, but I can't tell if your answer to my point here is:
> > - Yes, sandbox virtio is broken / incomplete
> > - No, sandbox virtio is fine, there's some other mismatch between how
> >   it's used for sandbox and how it's used for QEMU. This will get
> >   resolved later.
>=20
> It is incomplete, in that the block device is not fully implemented.

Then please disable it until you can complete it.

> No other test enables it, but EFI does, since it blinding tries to
> access all block devices without any control.
>=20
> >
> > > We have to move things forward a piece at a time. Not having a proper
> > > test for the EFI bootmeth is a significant gap and is what I am trying
> > > to fix with this series. It isn't perfect, but it is a step forward
> > > and will prevent regressions. It can also be built on later.
> > >
> > > Happy-path testing with QEMU is all very well, but it only goes so fa=
r.
> >
> > I frankly get really puzzled about why testing all of this, in QEMU,
> > where we could actually design the test to see if the OS has booted (and
> > if we leave things configurable well enough, do this on real hardware)
> > is wrong but sandbox, where we can't boot the OS, is good. Especially
> > for the device that's only present in an emulator. We're emulating an
> > emulator and not getting matching behavior in our emulator.
>=20
> There are many reasons:

To be clear, I'm not saying sandbox tests have no value, or are
unimportant. I apologize for imply as much.

> - with sandbox we can test the operation of the bootmeth, including
> under failure conditions

Yes, state machine tests are useful. But we can test for xFAIL on other
platforms, yes?

> - we can test what happens within U-Boot itself when
> exit-boot-services is called, which is the bug that provoked me to
> write the test

I honestly don't recall the state of the discussion around that patch,
positive/negative/neutral.

> - we can build on this test to cover other bootmeths without needing
> to install a full OS just to run a test

Counter point, we can't test that an OS actually boots. One of the most
valuable personally tests we've added recently is=20
test/py/tests/test_net_boot.py which makes the network load and boot an
OS image, and test for (some) failure modes.

--=20
Tom

--FW+lnRyIGGhQerUY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbtjdIACgkQFHw5/5Y0
tyx4SAwAi+KRDHNRvmiau4Mr/+7BkoFW/p3SiXx5WgF+ws9fgGqDkhGaOtfN1L2k
NBzctnoGZKyYTj3jI6urBlDOUbAKbtTry8vQQxyxBs7m373dn5DVq2ua3PojFvR8
01/vlmQy7rVsARKl3xHxlJ5Kpq4yYC447WK04VuEPWDM1Te+Xq/f3CQQUKkiU6Xk
qSrr3Zc8cz0JvPBRySsbkMi/8M8huoyDax0CeY1Lxt45PHBTHh+J7D9WsOxPg/8A
iMdlYR5DXNuj4fW0pus6RwodSoCRrHvcAHYiocFE019qH/BUp0tt9sQ6r000NihE
0VLQC2UXDjAnoIFIZFe7OsEW1ECwk5HFh6aUSGfwdq8Y8X7alwaJFgcNqE5anhXn
Je69jFp4KfWBRRofNtSKlQgi5FMmWgXDlRW21gCJps3VNVYOzPXJwBXBjsvMAj31
tjlF66J4KdjLShPwRCS1B47EDH4UAvQy3IMH5l5uDWIxeEHv1Uzr4tbLJeCSsFyw
sYRESEX/
=5rsx
-----END PGP SIGNATURE-----

--FW+lnRyIGGhQerUY--
