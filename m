Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C740AC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 19:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34779875E1;
	Tue,  7 Nov 2023 20:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="puwY5FZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC4D875E4; Tue,  7 Nov 2023 20:30:32 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1868A875DF
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 20:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7b9bd9f8bfaso2146730241.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 11:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699385428; x=1699990228; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+YOm1B2BKq2mTXUAWh3vOfkyePou+X9zAWsXjtClPo8=;
 b=puwY5FZ09h3YPdRfa+Fkvb444ziFuKmqGAlNIAEAxShXBzoev46+O2LWYHx9EuTHae
 IoajKs6GNTVMKua/+o+KCWHmJbJ4JgUgs5i24aODGzP4xJV+VLU6EQxR+7q8Z6n/mhMK
 DwMQGJyFgiZa0nOWaHuqh+FsSTvRk61/9LPhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699385428; x=1699990228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+YOm1B2BKq2mTXUAWh3vOfkyePou+X9zAWsXjtClPo8=;
 b=PflhrnTUYluW4LxdWh1J1cQNhAR1BgVPvH3HfD6836pBChy+jzMM5BGTQtfoL5t2h/
 SeZ4nHC4UBcJmztMr2fhBj/9HJhWNKcu1DKPnEYouZJcLleqXdZ+BpSt/pngXsF4Dd7k
 UGOIap3f/fcDR5s/tMQPHk0lHCFzDQv9e0WE70R6QsNDKUB3eEECkkex4rN0sj/u3nIc
 TG0TBBoB7RXJHdLlb5WJjFS713O5nJWV9cUIbxOvnCPqbJpW8IZx/8S+oPigGaA39kT9
 88bVjzbw6n2qaQrR/V5NAVzEYmQX2n6t+r6iss2JyImgzkOJdav01PIIUWOy1oM3LN5Y
 N/JA==
X-Gm-Message-State: AOJu0Yzt0zhChvirW4/Bz7wyxvf7c/ynY/JfoDoLcE2fDysUFH6S1rM0
 hFi7/c1+SwPVmMTWOKYJC2nV7w==
X-Google-Smtp-Source: AGHT+IGeqnzaYHuXmkJU2I4rmkatyhQo4JnT94OHY/EC+zMKSIlYzZ10MnZ1H/1aypyt55/bNJN3Yg==
X-Received: by 2002:a67:c09d:0:b0:457:670f:e2eb with SMTP id
 x29-20020a67c09d000000b00457670fe2ebmr32900656vsi.20.1699385428309; 
 Tue, 07 Nov 2023 11:30:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 dd17-20020ad45811000000b0064906cfe430sm199254qvb.135.2023.11.07.11.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:30:27 -0800 (PST)
Date: Tue, 7 Nov 2023 14:30:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107193025.GN6601@bill-the-cat>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pJRe20hGYvpaA7QW"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
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


--pJRe20hGYvpaA7QW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 01:10:44AM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 6 Nov 2023 at 13:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Nov 06, 2023 at 01:38:39PM -0700, Simon Glass wrote:
> > > Hi Andre,
> > >
> > > On Mon, 6 Nov 2023 at 10:26, Andre Przywara <andre.przywara@arm.com> =
wrote:
> > > >
> > > > On Sat, 4 Nov 2023 19:45:06 +0000
> > > > Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@arm.c=
om> wrote:
> > > > > >
> > > > > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > >
> > > > > > > > On 11/1/23 19:05, Andre Przywara wrote:
> > > > > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> w=
rote:
> > > > > > > > >
> > > > > > > > > Hi Heinrich,
> > > > > > > > >
> > > > > > > > >> The Zkr ISA extension (ratified Nov 2021) introduced the=
 seed CSR. It
> > > > > > > > >> provides an interface to a physical entropy source.
> > > > > > > > >>
> > > > > > > > >> A RNG driver based on the seed CSR is provided. It depen=
ds on
> > > > > > > > >> mseccfg.sseed being set in the SBI firmware.
> > > > > > > > >
> > > > > > > > > As you might have seen, I added a similar driver for the =
respective Arm
> > > > > > > > > functionality:
> > > > > > > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-a=
ndre.przywara@arm.com/
> > > > > > > > >
> > > > > > > > > And I see that you seem to use the same mechanism to prob=
e and init the
> > > > > > > > > driver: U_BOOT_DRVINFO and fail in probe() if the feature=
 is not
> > > > > > > > > implemented.
> > > > > > > > > One downside of this approach is that the driver is alway=
s loaded (and
> > > > > > > > > visible in the DM tree), even with the feature not being =
available.
> > > > > > > > > That doesn't seem too much of a problem on the first glan=
ce, but it
> > > > > > > > > occupies a device number, and any subsequent other DM_RNG=
 devices
> > > > > > > > > (like virtio-rng) typically get higher device numbers. So=
 without
> > > > > > > > > the feature, but with virtio-rng, I get:
> > > > > > > > > VExpress64# rng 0
> > > > > > > > > No RNG device
> > > > > > >
> > > > > > > Why do we get this? If the device is not there, the bind() fu=
nction
> > > > > > > can return -ENODEV
> > > > > > >
> > > > > > > I see this in U-Boot:
> > > > > > >
> > > > > > > U_BOOT_DRVINFO(cpu_arm_rndr) =3D {
> > > > > > >
> > > > > > > We should not use this.
> > > > > >
> > > > > > Agreed.
> > > > > >
> > > > > > > Use the devicetree.
> > > > > >
> > > > > > No, this is definitely not something for the DT, at least not o=
n ARM.
> > > > > > It's perfectly discoverable via the architected CPU ID register=
s.
> > > > > > Similar to PCI and USB devices, which we don't probe via the DT=
 as well.
> > > > > >
> > > > > > It's arguably not proper "driver" material per se, as I've argu=
ed before, but
> > > > > > it's the simplest solution and fits in nicely otherwise.
> > > > > >
> > > > > > I was wondering if it might be something for UCLASS_CPU, someth=
ing like
> > > > > > a "CPU feature bus": to let devices register on one on the many=
 CPU
> > > > > > features (instead of compatible strings), then only bind() those
> > > > > > drivers it the respective bit is set.
> > > > > >
> > > > > > Does that make sense? Would that be doable without boiling the =
ocean?
> > > > > > As I don't know if we see many users apart from this.
> > > > >
> > > > > I have seen this so many times, where people want to avoid putting
> > > > > things in the DT and then are surprised that everything is diffic=
ult,
> > > > > broken and confusing. Why not just follow the rules? It is not ju=
st
> > > > > about whether we can avoid it, etc. It is about how devices fit
> > > > > together cohesively in the system, and how U-Boot operates.
> > > >
> > > > A devicetree is only for peripherals *that cannot be located by pro=
bing*.
> > >
> > > I have to stop you there. It absolutely is not limited to that.
> >
> > It is limited to that if we're going to keep using the device trees that
> > Linux uses. Full stop. There's not really wiggle room there either.
>=20
> That is really the problem, I agree.

And we need to accept that, and what is/isn't something that we can
expect every board developer to have to tweak on top of this.

Heck, maybe part of the issue here is that devicetree-the-spec and
devicetree-the-linux-kernel-input need a little differentiation and some
official statement along the lines of "just because X can be in the
device tree does not mean that X will be defined in the device tree, if
it can be detected in some other reliable manner" for the latter.

> But I would be happy with a u-boot.dtsi file to resolve this, while we
> wait. I believe a binding makes sense in this case.

We don't need a binding, we can easily check at run-time. We only barely
have to worry about run-time failing (yes, QEMU could be fired up with a
model that lacks it, or some future change, and it's cheap to check). I
would say we could use the cpu compatible as a binding, but I don't want
to then have to add a bootph property to that. And the RISC-V example
makes it even clearer that this is not a binding thing.

I do not want a binding here that we just don't upstream because it will
make life harder for everyone else that's adding new platforms to get
the feature to work. Or people won't get it to work and instead add new
code that they most likely didn't need to, per drivers/timer/ today.

I'll let security people argue on what level of RNG (and so perhaps RNG
choice on systems that have more than one source available) devices need
to be present. But I think drivers/timer/ is the better example of
needing to just have the source present, with minimal run-time checking
(since it's a feature of the CPU).

--=20
Tom

--pJRe20hGYvpaA7QW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKkE0ACgkQFHw5/5Y0
tyxLGgv6Antlfk+TN67UmfmkVLUWqOASVzpfgnT2ybHxTZZ5CgLL4+x+xkL8b66q
zf01Te1SSTMUJV99vuzC45aArO2yCj7mKwvzAO5lU6CWe9YyQfeVmC6Opcl53ffY
JRKZUWd3swWImqsDycaABI0lNpioFHpRIg7uYReI3w2/auuH3bpF9Kcn0ZLaa4Gh
ASn71tPXAGEsWcapjci7fNBxjycf7Xf4v1Mw9Mo0LwuN+6SAvZJPIki4rTPyJ+St
Caz5PHadRRFL9UBAnw1XC7xy7hOhvyt8rbd4u2UY3xGwGEGPKXVr4QUKeutubJsM
PdSmYkCRAh5gmsUieZhxbaoYA/D58zWXp8KG2ufxm9Jq931Jfk7l/0WvlpSYlcu0
LlKJNJahxWqgVhB2ZDgIdwznkpfe9TWnFfXhR33rz1iAKtIu766doUZc9IPGdwF3
kyjSLRs2jf1UsI59rGeNNSLxAHweYYSdWhlHt/1TPyYmkjb4XU9DE2Mx2SRwUGaA
cI+skoQH
=s5Mp
-----END PGP SIGNATURE-----

--pJRe20hGYvpaA7QW--
