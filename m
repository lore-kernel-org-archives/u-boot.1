Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095EEC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 12:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36E6487509;
	Wed, 13 Dec 2023 13:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qEUGBMc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B480687698; Wed, 13 Dec 2023 13:43:07 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C27D8747A
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 13:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dbccbdacb9eso783612276.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702471384; x=1703076184; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fVmjKV0XAiDfX9/lPGjEZr6wEDYsNeTd1tVjkyzlEx4=;
 b=qEUGBMc058345gho3ttvhtIQPj6Bor/4ThnCTx5UotcdrHPlEagYk2+PZjjABDa8Oq
 Bmcz8CkChNgMecdtYcMo088mWWHoS5y1i1odQChJch2SWrNZnC8hEEcC27pNaUOVQ2nW
 xo5fSw1vZ9iEi/vIAV0R1PlZ2SKB4J4Co6/iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702471384; x=1703076184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVmjKV0XAiDfX9/lPGjEZr6wEDYsNeTd1tVjkyzlEx4=;
 b=MuytPhN08OD2T97/2YP7/IF3DBA1ZmjxPHrQZe/TBp7a++CWbmCTqpSM+pzo+hchri
 AQh/a3Vu10Nb+FicOtNOQzvAYZe/nt7Pcuu0ZeFA5JuuI2Gs02T7kKWRQEJOnlcrcHKn
 y28OpE/k0esG4cjbqbl6h4JpUMdJXwhiaeQbrzKdKaB3tRTvj7IIq0a6D15e0NfpdBoG
 RNy8oKkjVem2zJ0DZtqlj58HWDUkj7fW+1XIAbkT9yj/9MQq4pWo0eZZuDhKfVtVE/7I
 9mKKMyL/mhtmah78UMG+o+sTY1aCQ//icfS35OOxaBdhcmJ0irWVjOCuUIUILo5hkavl
 LkSQ==
X-Gm-Message-State: AOJu0Yy8020n/pmk4t7wTaCmZRdtKej6pMujrG/QLVIhDz5cX80jmF+R
 iS1bgu3O3KWggcF85rXQg3ohEQ==
X-Google-Smtp-Source: AGHT+IGliZc7hUvi5/xa+rZRv8HlrY+L7r723n2K1DBBdGc3xXi1WllC6S2c3mm7X+NfeX74NoQZHQ==
X-Received: by 2002:a05:6902:cca:b0:db7:dacf:2f07 with SMTP id
 cq10-20020a0569020cca00b00db7dacf2f07mr6340759ybb.78.1702471384051; 
 Wed, 13 Dec 2023 04:43:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 5-20020a251605000000b00d7497467d36sm3987139ybw.45.2023.12.13.04.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 04:43:03 -0800 (PST)
Date: Wed, 13 Dec 2023 07:43:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
Message-ID: <20231213124301.GE2513409@bill-the-cat>
References: <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
 <20231106210407.GK496310@bill-the-cat>
 <ZVTo7BKHmwzns_G-@orome.fritz.box>
 <20231115191149.GI6601@bill-the-cat>
 <C9328ED4-05E7-4060-BF5A-9CB1BCEE5B00@gmail.com>
 <ZXmZIjNKVzukVGVO@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RRfgU8XmX5D018NT"
Content-Disposition: inline
In-Reply-To: <ZXmZIjNKVzukVGVO@orome.fritz.box>
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


--RRfgU8XmX5D018NT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:44:34PM +0100, Thierry Reding wrote:
> On Wed, Dec 13, 2023 at 11:42:45AM +0200, Svyatoslav Ryhel wrote:
> >=20
> >=20
> > 15 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80. =
21:11:49 GMT+02:00, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> > >On Wed, Nov 15, 2023 at 04:51:08PM +0100, Thierry Reding wrote:
> > >> On Mon, Nov 06, 2023 at 04:04:07PM -0500, Tom Rini wrote:
> > >> > On Mon, Nov 06, 2023 at 02:11:16PM +0000, Peter Robinson wrote:
> > >> > > On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM Svyatoslav Ryhel <clamor9=
5@gmail.com> wrote:
> > >> > > >
> > >> > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80.=
 =D0=BE 15:13 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > >> > > > >
> > >> > > > > On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <cl=
amor95@gmail.com> wrote:
> > >> > > > > >
> > >> > > > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=
=80. =D0=BE 13:46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > >> > > > > > >
> > >> > > > > > > Hi Svyatoslav,
> > >> > > > > > >
> > >> > > > > > > > Since the proposed PMIC patches have been accepted, I =
see the need
> > >> > > > > > > > to convert boards which I maintain to use DM drivers i=
nstead of board hacks.
> > >> > > > > > > >
> > >> > > > > > > > Svyatoslav Ryhel (5):
> > >> > > > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM=
 PMIC
> > >> > > > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > >> > > > > > >
> > >> > > > > > > Is there a reason why the two above devices don't appear=
 to have their
> > >> > > > > > > .dts files in the upstream kernel?
> > >> > > > > > >
> > >> > > > > >
> > >> > > > > > Yes, there is a reason. Linux maintainers treat submitters=
 as
> > >> > > > > > existential enemies or as dirt at least. I was trying to w=
ork with
> > >> > > > > > linux but I have no desire to spend any time to upstream e=
ndeavoru or
> > >> > > > > > lg_x3.
> > >> > > > >
> > >> > > > > The usual policy for acceptance into U-Boot is to have upstr=
eam review
> > >> > > > > in the kernel first.
> > >> > > > >
> > >> > > >
> > >> > > > May you point to a policy which clearly and explicitly states =
this as
> > >> > > > a mandatory condition?
> > >> > >=20
> > >> > > There have been a number of devices rejected in the past until t=
heir
> > >> > > DT are upstream but I'll leave Tom, who I've explicitly added on=
 cc:,
> > >> > > to clarify the exact policy.
> > >> >=20
> > >> > Well, here is where it's tricky. I brought this up for one of the
> > >> > Broadcom MIPS platforms a week or two back, and Linus Walleij's po=
int
> > >> > (and I'm paraphrasing) is there's not really an upstream for it to=
 go.
> > >> >=20
> > >> > What we cannot have is device tree bindings[1] that aren't upstrea=
m or
> > >> > worse yet conflict with the official bindings.
> > >> >=20
> > >> > So the general way to resolve that is have device tree file be dro=
p-in
> > >> > from the linux kernel, and what additions we must have be done via
> > >> > -u-boot.dtsi files. And in turn, some SoCs are better about keepin=
g in
> > >> > sync with the kernel than other SoCs are.
> > >> >=20
> > >> > Now, upstream being actively hostile to dts files, especially for =
older
> > >> > platforms? That's unfortunate. So long as we aren't violating the =
rules
> > >> > about bindings, the intention is that we don't have device trees t=
hat
> > >> > are either (a) massively out of sync with the kernel[2] or (b) kept
> > >> > intentionally mismatched from the kernel.
> > >> >=20
> > >> > --=20
> > >> > Tom
> > >> >=20
> > >> > [1]: There are both examples like binman that Simon is working on =
at
> > >> > least but this is more exception than intentional rule.
> > >> > [2]: Per our other conversions, I know the tegra ones are in this
> > >> > unfortunate state in general
> > >>=20
> > >> On the Tegra side we've been fairly lax about the device trees in
> > >> U-Boot, I suppose. The assumption had always been that U-Boot would =
load
> > >> an external DTB and pass it to the kernel on boot, so keeping them b=
oth
> > >> in sync was never a high priority.
> > >>=20
> > >> U-Boot does only a very tiny amount of what Linux does, so dropping =
in
> > >> the kernel DTB always seemed a bit overkill.
> > >>=20
> > >> In either case, if this is problematic, it's something that I could =
take
> > >> a look at. Again, it's expected that the device trees are different,=
 for
> > >> historical reasons, but I'd be surprised if they actually conflict w=
ith
> > >> one another. U-Boot's DTB was always supposed to be a subset of the
> > >> Linux DTB.
> > >
> > >So, the issue with U-Boot and kernel device trees being out of sync is
> > >that we then can't support the model of "just pass the current DT to t=
he
> > >OS". This in general is good to support because it means that even if a
> > >given platform isn't formally SystemReady IR certified it's still like=
ly
> > >to be functional.
> > >
> > >The most strict rule is that you can't have bindings in U-Boot that
> > >conflict with the kernel, or should be in the kernel but aren't, and so
> > >on.
> > >
> >=20
> > So you say that U-Boot should support only components which have linux
> > driver? May you clarify?
>=20
> I think Tom is referring specifically to the bindings only. While it's
> certainly preferable to have drivers in Linux for all bindings, that's
> never been a strict requirement.

All bindings must be upstreamed and we've been working with Rob (and
he's been receptive) on this point. There's U-Boot specific bindings,
even, now and those in turn pass validation in the kernel and can be
synced in here. Can you give an example of what you're concerned about
Svyatoslav?

--=20
Tom

--RRfgU8XmX5D018NT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV5ptIACgkQFHw5/5Y0
tyyJKwv/Sl9OWhnhpcRDfEhn8W0QdIYA1FgFfADW3EKLXVG+aDNkZLWAze8LmUeu
gufKoDfry3vvRFMbV6xSFthD/NAA9gtMWuIB3b4MNWrO0wdCn2Ch9fYeWPhIvg3Q
aJ0gVisncb7OwB+Ml6oMOmfWPtMO4NMtRmAjAWFiD3y3H7DwP3tkEaH04ysg5Q9p
vRvO367OOVgxA+fjqW/ZHhHuXcXElHoYNrAoj14mtoVxtVEP/BYSDnxJ93ukTduI
o6VkfnS8GOVax8SZI68ZYsQ80ojFP1ZVUWORuZnvYOSPfTTgSKDNlt3flQ1F4zix
+ykH78jC7LqnWy30enUsXjFOoNeWxsKLTirm+USJfW4SnnUY7WDJVDnG51/RYjUc
AoQLNLHer3wPHcS99Qh7xATi3EbxYC0F4KoqU1w+ScicCvXMEzEA6zCt5OH38uk4
HqDZ02OdERNOgUZ5W3Rkvr3Y90C+xcw47TD3cAdEhHxbbhDxgPA61eiVjCoxAG5W
DYKRtSqg
=yE62
-----END PGP SIGNATURE-----

--RRfgU8XmX5D018NT--
