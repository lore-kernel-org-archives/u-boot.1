Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF97D6B072
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7035183F32;
	Thu, 29 Jan 2026 16:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gdba1FpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5D083FC6; Thu, 29 Jan 2026 16:26:50 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB1B83A64
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-45f126d47b8so740305b6e.2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769700407; x=1770305207; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t2Brmnfgp/bxV9mmsVSbg5j2hzp/+26GRKKTX47CUlg=;
 b=gdba1FpQqQ6crCrzVCaNvyb5xrnyDQcxAh33bCOvxOrMc4SoD8lhIod4rJnprOq6bh
 yqKmR7kLrQBLFTaU3rm/CKPFnhrr6GuoklHbTqfSu1q6ZYrHQf/S/yWNBBxMk13kadL0
 KYlA4abIg3MxwJ0ij67po7O8ZGHd2eA96Rano=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700407; x=1770305207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2Brmnfgp/bxV9mmsVSbg5j2hzp/+26GRKKTX47CUlg=;
 b=eltZdOYcmvNLEJqe7dXO2DT3pRdz6jAfxhpx0m5UOeIcexa7/EVNijjNdS1CS3QK0a
 A27b24/CNfM1jyOD9qtHU/3I8V4UeUbKcxUnqqVeG1F6nFIFIuaSJDSsCjJWMvAH1yTQ
 CDhHnqukAP2BNhmUDSxDHNVQXUM6IZNi9flKHrTIburKcR/zGuQzjV0i1hZ8DnIjM7BU
 y2P9iiW8TjCIVfiHoRdCBxd0WKM6w/fpxM0+OK7T6HNCNheN1ulV2Xx3s2miW3EqqCZz
 yOBcSt9NNivDXPhsRC1+7d6ZMyy01gk1tAcK6TpCxTnCdTVh4FznjBfp5HEqhoSCB72i
 xznA==
X-Gm-Message-State: AOJu0Yz2sj9wTPU5yVVA7vC7Iy5JhcIsiiMC+4ywQFgrOjxpQbhQi3vv
 mHJUs64l5EvAYxwpT92sj7C+Zto0J3E0+kH+ssM76DhclMOqzLUL3lVRYFGYCzrF2pA=
X-Gm-Gg: AZuq6aIup1SerYFeNPRYlTbl8X7QMcHA39fgJI1LuvY/i9MDxDdv00vxS1piV0Uaak+
 miM0zVHJqXeHGYvFOWcxOh42etjXHCL09U22XGYh4rkcbeRlQkwh9LFKjAzUkvldjj5k1GttTE/
 RRFYEq8b+5rNE3DrngD6IQNtve8BYTFw1TtD6uSsAtPX2hIUOKNRAH0C79IpmfhwHP0KjsGqshu
 ERM/YrFcc3ioz8rvxsIiXP6gyVNt5qZXvp+WFSCzT44A9DBL6Udt2pYZEZY0OKTr5s+HQYH8Lnn
 wHn8CJeW1hT0OhnZNo8OJSyS1MVPdd7rVDpMmu5PQUZcFMQGc1giB+Rafw0g+BNF/3R9LxZ3BYp
 9B2/pGBFrA7nPI9nvAS1zo9nw4QmybEgoRpdjXcHjbjjype37y9ZiRzy/mtLilBJ4b2mZIcHD07
 om19gD0pYYlTvUVKse4Mi0mCZH3+q0npmSVysyAKBd59viHU6+3wziw8MBUucx/sp3RuUb9ePF9
 b9EsIYMAvHO1lDK5zG1lUQVshEwpP+pldi7T3w=
X-Received: by 2002:a05:6808:151e:b0:45e:a555:4f1e with SMTP id
 5614622812f47-45efc6a4f40mr5430480b6e.38.1769700406576; 
 Thu, 29 Jan 2026 07:26:46 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-409575b0a89sm3974510fac.20.2026.01.29.07.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 07:26:46 -0800 (PST)
Date: Thu, 29 Jan 2026 09:26:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129152644.GW3416603@bill-the-cat>
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
 <20260128145118.GJ3416603@bill-the-cat>
 <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
 <20260129145416.GR3416603@bill-the-cat>
 <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
 <20260129151919.GU3416603@bill-the-cat>
 <CAN7C2SBMTxqeN45RiAuz4oW9bKVUYDgJzmHH+eM0pNN3X6QpHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="shubU3UvmREKFEDf"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBMTxqeN45RiAuz4oW9bKVUYDgJzmHH+eM0pNN3X6QpHw@mail.gmail.com>
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


--shubU3UvmREKFEDf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrote:
> On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrote:
> > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrote:
> > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrote:
> > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
> > > > > > > All Cyclone V boards are unable to boot, not sure this patch =
is the fix?
> > > > > >
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > > Yes, those commits were unintentional and have been reverted.
> > > > >
> > > > > Had tested the last commit 6a1bdb7e952d5841f42742fefa907cae5dc8d5=
0a
> > > > > Same situation that the boards are unable to enter the SPL phase.
> > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works properl=
y.
> > > > > After that things are broken.
> > > >
> > > > Please give
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20260129035512.639=
362-1-marek.vasut+renesas@mailbox.org/
> > > > a try as I think it might have been working before by alignment luck
> > > > rather than design.
> > >
> > > Hi Tom,
> > >
> > > It is the revert itself that is broken.
> > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > >
> > >
> > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026 - 22:56:17 =
+0800)
> > > Trying to boot from MMC1
> > >
> > > Which revert is correct.
> > >
> > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> > >
> > > Then all these broken I don't understand why even file diff cannot
> > > show any changes.
> > >
> > > Do you mean the revert is broken and fixed by alignment?
> >
> > I mean that arbitrary changes (as part of testing these things, the
> > "-dirty" in the version string would lead to failing trees now passing)
> > can make the difference between pass/fail to boot. Did you try Marek's
> > patch I linked to?
>=20
> Yes, I had tried. Cannot boot same as I had mentioned failing commit #.
> I apply that patch on the latest master commit.

The other, maybe, thing is you need a bigger SPL_SYS_MALLOC_F_LEN ?
Otherwise, you'll need to dig more and see why the device tree isn't
being found where expected on your platform, and possibly where it is
instead.

--=20
Tom

--shubU3UvmREKFEDf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXt8NAAKCRAr4qD1Cr/k
CtwCAP4jg3tqEwgwAhZn1RKoXYYgPCyVHVdIE+2wdTU1MGLyTwD9Gde/NjEgMbrb
OcYfQMOjz+l3Kz34oLn3Oc3mSbBwtwM=
=bqSN
-----END PGP SIGNATURE-----

--shubU3UvmREKFEDf--
