Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C126FC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 22:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D994D87642;
	Tue,  7 Nov 2023 23:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nD8g9ukS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303B887642; Tue,  7 Nov 2023 23:10:31 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BFD87627
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 23:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41e1921da84so39265191cf.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 14:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699395027; x=1699999827; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PaCju1Z7sOOOEZzmHeA+a4OPK5Pgf53st51ABS3kRns=;
 b=nD8g9ukS81IuBYkwXTHKRfdeMI/t9MBPJbS6m6ZMb2Bpt/bNVN9Dw9AIJj1YuAj2Cw
 dtFqRlY3BZRNdN187o45D9/lL/OlCLopAm+6cPgPXLoWmXrt+/stqJNT4xgUH+h23WC8
 LT5lneNn1Bj+dKLOEttDh5FglCbjOFKHnQtVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699395027; x=1699999827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaCju1Z7sOOOEZzmHeA+a4OPK5Pgf53st51ABS3kRns=;
 b=GwOalkA3Rl3Urtygx6JyEnknH8fBVXHv8P5yDci6L0u/Yu/ypEfGk2q+nTIXG9vS4P
 u2m/jqVCrbEJ5mLWVYwV4sVghdKSvHaf5Gakvn/JZG6YoafW5+mXxm4NAI/Xf7YmhbCE
 vbnKKZiw2YgS2L43INTZVI8pud/bstLJIvkPQ3hQGZao1VgOXNeIRrGqnQZjPUIdlnia
 M4Q25OA/+cDUilVGybUa5On4TtMb1P4yGGf5Wfy9LTUNf5UxQ/B5qw5sVs3eaVQx+uP8
 a+vOx+ArdJFJryUe6gJi9iKunHab5tc+HesbjjosLHnmIDGOnrkJazcc0m07xQwHrTVA
 MSaw==
X-Gm-Message-State: AOJu0YyLB7OeZCAVpGSRGutu0gIOb+kGBuNxvmoKXrJ7PdTIcWouIGA0
 xRojDlaDaPyTxstThIt2FlKYFQ==
X-Google-Smtp-Source: AGHT+IEJn4MXj0aysyOQnYOKT5KucDyt5om9kxSLkzs770HBLkmzs85URuRhF9dm+qEH1Sr6UrIWwg==
X-Received: by 2002:a05:622a:3d1:b0:41e:31b3:da8f with SMTP id
 k17-20020a05622a03d100b0041e31b3da8fmr227034qtx.1.1699395027007; 
 Tue, 07 Nov 2023 14:10:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a05622a110c00b0040399fb5ef3sm144518qty.0.2023.11.07.14.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 14:10:25 -0800 (PST)
Date: Tue, 7 Nov 2023 17:10:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Rob Herring <robh@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107221023.GS6601@bill-the-cat>
References: <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ljk+DULStCYXENEm"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
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


--Ljk+DULStCYXENEm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 03:52:36PM -0600, Rob Herring wrote:
> On Tue, Nov 7, 2023 at 1:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Tue, Nov 07, 2023 at 01:10:44AM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 6 Nov 2023 at 13:46, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Nov 06, 2023 at 01:38:39PM -0700, Simon Glass wrote:
> > > > > Hi Andre,
> > > > >
> > > > > On Mon, 6 Nov 2023 at 10:26, Andre Przywara <andre.przywara@arm.c=
om> wrote:
> > > > > >
> > > > > > On Sat, 4 Nov 2023 19:45:06 +0000
> > > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@a=
rm.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > > > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > > Hi Heinrich,
> > > > > > > > >
> > > > > > > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On 11/1/23 19:05, Andre Przywara wrote:
> > > > > > > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > > > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.co=
m> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > >
> > > > > > > > > > >> The Zkr ISA extension (ratified Nov 2021) introduced=
 the seed CSR. It
> > > > > > > > > > >> provides an interface to a physical entropy source.
> > > > > > > > > > >>
> > > > > > > > > > >> A RNG driver based on the seed CSR is provided. It d=
epends on
> > > > > > > > > > >> mseccfg.sseed being set in the SBI firmware.
> > > > > > > > > > >
> > > > > > > > > > > As you might have seen, I added a similar driver for =
the respective Arm
> > > > > > > > > > > functionality:
> > > > > > > > > > > https://lore.kernel.org/u-boot/20230830113230.3925868=
-1-andre.przywara@arm.com/
> > > > > > > > > > >
> > > > > > > > > > > And I see that you seem to use the same mechanism to =
probe and init the
> > > > > > > > > > > driver: U_BOOT_DRVINFO and fail in probe() if the fea=
ture is not
> > > > > > > > > > > implemented.
> > > > > > > > > > > One downside of this approach is that the driver is a=
lways loaded (and
> > > > > > > > > > > visible in the DM tree), even with the feature not be=
ing available.
> > > > > > > > > > > That doesn't seem too much of a problem on the first =
glance, but it
> > > > > > > > > > > occupies a device number, and any subsequent other DM=
_RNG devices
> > > > > > > > > > > (like virtio-rng) typically get higher device numbers=
=2E So without
> > > > > > > > > > > the feature, but with virtio-rng, I get:
> > > > > > > > > > > VExpress64# rng 0
> > > > > > > > > > > No RNG device
> > > > > > > > >
> > > > > > > > > Why do we get this? If the device is not there, the bind(=
) function
> > > > > > > > > can return -ENODEV
> > > > > > > > >
> > > > > > > > > I see this in U-Boot:
> > > > > > > > >
> > > > > > > > > U_BOOT_DRVINFO(cpu_arm_rndr) =3D {
> > > > > > > > >
> > > > > > > > > We should not use this.
> > > > > > > >
> > > > > > > > Agreed.
> > > > > > > >
> > > > > > > > > Use the devicetree.
> > > > > > > >
> > > > > > > > No, this is definitely not something for the DT, at least n=
ot on ARM.
> > > > > > > > It's perfectly discoverable via the architected CPU ID regi=
sters.
> > > > > > > > Similar to PCI and USB devices, which we don't probe via th=
e DT as well.
> > > > > > > >
> > > > > > > > It's arguably not proper "driver" material per se, as I've =
argued before, but
> > > > > > > > it's the simplest solution and fits in nicely otherwise.
> > > > > > > >
> > > > > > > > I was wondering if it might be something for UCLASS_CPU, so=
mething like
> > > > > > > > a "CPU feature bus": to let devices register on one on the =
many CPU
> > > > > > > > features (instead of compatible strings), then only bind() =
those
> > > > > > > > drivers it the respective bit is set.
> > > > > > > >
> > > > > > > > Does that make sense? Would that be doable without boiling =
the ocean?
> > > > > > > > As I don't know if we see many users apart from this.
> > > > > > >
> > > > > > > I have seen this so many times, where people want to avoid pu=
tting
> > > > > > > things in the DT and then are surprised that everything is di=
fficult,
> > > > > > > broken and confusing. Why not just follow the rules? It is no=
t just
> > > > > > > about whether we can avoid it, etc. It is about how devices f=
it
> > > > > > > together cohesively in the system, and how U-Boot operates.
> > > > > >
> > > > > > A devicetree is only for peripherals *that cannot be located by=
 probing*.
> > > > >
> > > > > I have to stop you there. It absolutely is not limited to that.
> > > >
> > > > It is limited to that if we're going to keep using the device trees=
 that
> > > > Linux uses. Full stop. There's not really wiggle room there either.
> > >
> > > That is really the problem, I agree.
> >
> > And we need to accept that, and what is/isn't something that we can
> > expect every board developer to have to tweak on top of this.
> >
> > Heck, maybe part of the issue here is that devicetree-the-spec and
> > devicetree-the-linux-kernel-input need a little differentiation and some
> > official statement along the lines of "just because X can be in the
> > device tree does not mean that X will be defined in the device tree, if
> > it can be detected in some other reliable manner" for the latter.
>=20
> I think Andre's statement is just missing 1 word: required
>=20
> A devicetree is only *required* for peripherals *that cannot be
> located by probing*.
>=20
> But really I'd phrase it in terms of what's needed for discoverable devic=
es.
>=20
> I'm somewhat surprised at this point in time we need a statement, but
> happy to add something to the DT spec. DT has been optional for
> PCI/USB since the advent of FDT and only used there when there's extra
> resources which are not discoverable. It only seems to be a question
> when it's a not $sig bus.

I think the need for a statement about this will help with less long
time and/or Linux kernel centric communities. So really do think putting
something in the spec will be helpful, and maybe further clarify or not
the RISC-V ISA thing that's elsewhere in this thread (and part of the
kernel, not a U-Boot thing).

[snip]
> > But I think drivers/timer/ is the better example of
> > needing to just have the source present, with minimal run-time checking
> > (since it's a feature of the CPU).
>=20
> Timers come up frequently (well, less so with Arm arch timer now) with
> various ways to assign timers to Linux clocksource and clockevent. My
> response there is what's the difference in the instances that you care
> about assignment? If they are all the same, then you shouldn't. If
> they aren't the same, describe the difference. Sometimes it's just one
> instance has an interrupt, so it's the clockevent. Or you need the one
> that's always on. The OS/client can figure that out if you describe
> those properties. That's better than creating arbitrary indices.

In details, this is about the U-Boot API for "how long has elapsed in
the system" and not clocks for peripherals, which gets confusing in that
I _think_ in Linux it's all drivers/clocksource/ but in U-Boot we have
drivers/clk for peripherals and too-many-things for "elapsed time" and
so for example the ARMv8 generic timer isn't in the DM framework but nor
do most platforms using it trigger the "no DM migration!" warning
because the "driver" is so simple.

I introduced the "timer" part to the "rng" thread because when I saw
this going on Friday it reminded me that I'd seen another case where
"CPU lets us do X" and "this is not happy in current DM" was true, sorry
for the confusion.

--=20
Tom

--Ljk+DULStCYXENEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKtc8ACgkQFHw5/5Y0
tyxGsQv/TIjSHqQn6mgUcj3ELj49wZSC7e7ry2Qha81YIXQ1dVPfen5H6CRGC68z
7K0867MLpqNHIqrRUq+ydCuO/r324u+MMb8LJ7cYhS30sLN3b7yzRBVtMJ3N0DXy
iWplL7iNo7bUE2E1xcTYtAjwLN2+5U+CSMDK9pZU2G9tB7vEC2/vM7HjUJocxoYI
4F6P0A+xeCV1HpZLYK6lhfWg2JSX/vK1j0pL9p5w60uzGQKG9nXKaMEAM3oQZcVJ
xiodWR72k6BPAAJfRkJRxjwQTabJqqKZJtM1BHY7v6FyJ3j1vjU9xTTRHFgvcPwV
++wS7IDMTnl+93sd8ERMz4lT0gwnkQ8p+jUD5rumr2TVgkMZeMhOvDFsCSOU1u8t
Jtt5bPwrW5m7C4Ni3M/W65fhZa+YBXPgySjGydngYr24jUm1ey+qB9c68qLewrPd
TzDHukjU4VADP53IU2bu7cx6KtCyutwvtvbz9dhYIFzHfly4JCLMd/QYOOuzzvG3
QDkhSYly
=2dbA
-----END PGP SIGNATURE-----

--Ljk+DULStCYXENEm--
