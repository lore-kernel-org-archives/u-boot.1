Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DC1C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 20:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A798875C;
	Thu,  8 Aug 2024 22:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q4SuFfpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF8D8875C; Thu,  8 Aug 2024 22:06:44 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E15EA88A0E
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 22:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7094641d4e6so641719a34.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723147600; x=1723752400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n9Skzen/UfAR0n/e9UWkiYKRe0miEKLFSO3f6ass5zc=;
 b=Q4SuFfpv4PQ0YnAHmKUDLea01V4TxyLOruvhyY7uaVvba7CZG9X4GimYd3FME6Mylm
 j7FzXHiNtlkndcXGZDpVeptfMWBOkFjUVwtfA86Ubj4I809US2igCAWwXf2QdAU8nfxn
 xxfKK87ewJsftVbcJ4Lj8+mB2IZlntY0mzQdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723147600; x=1723752400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9Skzen/UfAR0n/e9UWkiYKRe0miEKLFSO3f6ass5zc=;
 b=t9zxODfyOudUf29RHBm84QN4SQbeQdpydw2kY7GvhQjsPyY51XAVaVLXs2f/Y74ISx
 ATCWhA8jwODfR6SJgNNsdT6r/jk6rOvU26vovgt86tuhxGGVWXdXlX/9wLRUQskQc9CX
 KGiCmi7wSgxwtQTTE0T97Xuaewee7jmNXbibhzhgHTlX8xr3fRMd8fcK6Qgd+bLt5P4h
 1VrQn1GHtnq9VnBVVMCRh3NKybPrKOKMu09h09jEvsjpSD0RBGLo1+LdqMsJ8e4WEIN1
 7XVEK3y1zio2WsFyaVMhFE8SNli+lR6aU+M0Ln7KqBVBQID3mBTOap6S3Eolt3cRlt4Z
 fHVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNQQ5dp5fHCaHJeMld6vR3+mrV+sCWo69DiEVLdDgvkJ2WZQn3bsNjTbOVaSkI3TpXQYmd37Ez/7b/dqmWuTAFHbq3YQ==
X-Gm-Message-State: AOJu0YwkswfeqJKgVEAo63KVMqCld4trmyhjq/YrqHZ5lHxjm1nquGi3
 U5YpVMMW6+/Ni1lqm7udkaQhdVPoiuxlZlHSmB9ruhJtj2LAdfw321uCA4yZT9KirUMI0hl2cie
 kyPQ=
X-Google-Smtp-Source: AGHT+IEqDTUzUDA7xZ1W5oK1ENzjaSbZx6YEvmNl7IEpA3ZlhiUrks9QH5CsegQghlxsXqW07vsmkA==
X-Received: by 2002:a05:6871:5227:b0:25e:bd9d:b1cb with SMTP id
 586e51a60fabf-2692b7a928fmr3811425fac.40.1723147600414; 
 Thu, 08 Aug 2024 13:06:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31eaeed4sm5726522a34.25.2024.08.08.13.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 13:06:37 -0700 (PDT)
Date: Thu, 8 Aug 2024 14:06:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 37/39] efi: Avoid using sandbox virtio devices
Message-ID: <20240808200634.GR1626301@bill-the-cat>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-38-sjg@chromium.org>
 <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
 <20240807015613.GD1626301@bill-the-cat>
 <CAFLszThhn0240xt1j6GQB9QTKxiHiAg6J3vMXCnHBE15iYZSkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CkjKBbADQd5NYwIq"
Content-Disposition: inline
In-Reply-To: <CAFLszThhn0240xt1j6GQB9QTKxiHiAg6J3vMXCnHBE15iYZSkA@mail.gmail.com>
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


--CkjKBbADQd5NYwIq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 12:44:05PM -0600, Simon Glass wrote:
> Hi Heinrick, Tom,
>=20
> On Tue, 6 Aug 2024 at 19:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 07, 2024 at 03:47:21AM +0200, Heinrich Schuchardt wrote:
> > > On 06.08.24 14:58, Simon Glass wrote:
> > > > While sandbox supports virtio it cannot support actually using the =
block
> > > > devices to read files, since there is nothing on the other end of t=
he
> > > > 'virtqueue'.
> > > >
> > > > A recent change makes EFI probe all block devices, whether used or =
not.
> > > > This is apparently required by EFI, although it violates U-Boot's
> > > > lazy-init principle.
> > > >
> > > > We cannot just drop the virtio devices as they are used in sandbox =
tests.
> > > >
> > > > So for now just add a special case to work around this.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > --- a/lib/efi_loader/efi_disk.c
> > > > +++ b/lib/efi_loader/efi_disk.c
> > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const ef=
i_handle_t handle, char *buf, int
> > > >   efi_status_t efi_disks_register(void)
> > > >   {
> > > >     struct udevice *dev;
> > > > +   struct uclass *uc;
> > > >
> > > > -   uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > +   uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > +           /*
> > > > +            * The virtio block-device hangs on sandbox when access=
ed since
> > > > +            * there is nothing listening to the mailbox
> > > > +            */
> > > > +           if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > +                   struct blk_desc *desc =3D dev_get_uclass_plat(d=
ev);
> > > > +
> > > > +                   if (desc->uclass_id =3D=3D UCLASS_VIRTIO)
> > > > +                           continue;
> > >
> > > We should avoid depending on the sandbox everywhere.
> > >
> > > Please, fix the problem in the sandbox driver.
> > >
> > > If you cannot fix it, run the tests involving virtio on QEMU instead =
of
> > > the sandbox.
>=20
> Which test? All of the EFI tests fail due to this problem. The test
> actually has nothing to do with virtio, it is just that EFI goes and
> probes every single block device, since [1].

Aren't we running "the tests" on other platforms such as QEMU today?

> > This is an area we go back-and-forth on but, yes, IMHO, if we can't
> > easily provide a virtio device for sandbox, QEMU is right there and what
> > this is for, so I see sandbox as more useful as build rather than
> > runtime checking in this case.
>=20
> The best solution would be to implement a simple emulator, like we do
> in other places for sandbox. At present virtio_sandbox_notify() is
> empty.
>=20
> I don't mind working on that, but would like to get a temporary
> solution here so this test can land.
>=20
> Talking about virtio for QEMU is missing the point of this test, which
> is after all a test of booting an EFI app. I do wish more people would
> see the value in these unit tests. There is a talk at [2] which shows
> how emulators are used in Zephyr.

So that talk is interesting, yes. So, yes, implement the bus driver for
sandbox for virtio, and until then we shouldn't have the tests running
on sandbox? Or am I still missing something?

But I also still say that given that we as a project are more resource
constrained than Zephyr, for things that are QEMU-centric, there's
already a wealth of information on debugging QEMU since it too is
software. There's only so many hours in the day after all.

--=20
Tom

--CkjKBbADQd5NYwIq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma1JUcACgkQFHw5/5Y0
tyx7iQv8DHNUwEdw7MSQ8hCbSVtQhlGSS8Av4dnkACz5SuHpdLX56Dt4sXaOnp1a
cI6NRPFK8P5WQuezy6kVYJ83hItUWLMyNGcqFq5dcdkeggH36vjf3/foCrDVSnDp
9xv6bYXE0c1SoTVRc6zq0rGvdISOphlmpT4ZEgwlRx2YklAaRNRA29sQIZXlC3uQ
nt4Ch6FEjpLGcoU0lJq0IMTZZeALEL9HFmRpmNGwfhg4W02zjsZrNbqzErS5E5dM
C4uY98axFyKNA6gqb/cW+o5szm9VJwOczsevhXhoopjYwMQStYa4XVKSpF9GtmUW
D5Dgjpolgx59Jv9BisMJfMHqzz7yl1ROvvZrS1yuVnIGvFPrpntMHM4weJla20K+
Z12JFLd76iTrKEKZF+JNq8Po4bl0Y60i2G2Orak9TAbtFYGcN5w+K1wxvf0gcSMf
OFh022mlmAD5XmxkNmMjrpjxz03/rW7JkLUlDDNOSNe8+5Xm+jyQClOchP/1XixL
EMlRKk4S
=49zu
-----END PGP SIGNATURE-----

--CkjKBbADQd5NYwIq--
