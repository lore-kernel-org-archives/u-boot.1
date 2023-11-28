Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC196C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 15:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5348754C;
	Tue, 28 Nov 2023 16:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ORwwUkoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30ECB86F02; Tue, 28 Nov 2023 16:08:04 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE5787253
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 16:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5c8c8f731aaso57024627b3.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 07:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701184078; x=1701788878; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UgBf72RsLa3w1Cxe7Tt5EWM6/TOwfgm0/mCICZaUgQQ=;
 b=ORwwUkoUsd3p+l0eB6c/xMnNcxX4QUB6+60yoJQZLj/yeLbG7THod9dC+6ChmPE/6S
 9PxCuI2BMJv6aak+J+1VtdCuc8bRrV841kVDoR/IBmnrb3NO6GQyAofZy4Hq08bIPXNd
 0CDUNfhbiShx9dvpPtLxPTScKAmQkmgL5G0uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701184078; x=1701788878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgBf72RsLa3w1Cxe7Tt5EWM6/TOwfgm0/mCICZaUgQQ=;
 b=qRNdpAWOUjzoStnbncXc8senBVwNjYCBt0YsiyVMyiYY/nrhhUpUCWthqemsMvGxmv
 nVuEkp9miMPHrsK42HZ4Ao1Pq6OQ2OOUBwx67qttIOB+CECK3Q6SQzk0rdXzv0QAtC8E
 blVYJrm1rypgwoBZwatG2+QiTFQEQ5w3+A0Tf9lTuc3fUHw0Q88GJ/yROfoTVcZp1U0P
 jf2jy5OO+u8IinMPtovoFty+CVIfbLSaConqhv53sFwNNRLgiQl/VSQaSbzTcxHc61Li
 VZ7pIBGZQEh89t6j1tGKfqX4LYYDHC3G/bc77CgBC6bZRPQ70e8Bz2I/PeYPJFg/qZhy
 GX+w==
X-Gm-Message-State: AOJu0YxsCYQmxoKyesiG98nuEGArp0IH4Oz40x7zHEJAMA1XiVhN/iyg
 7V641dQz/GooMrXfycmaFui/vw==
X-Google-Smtp-Source: AGHT+IHrLs090+9amutqH+ZSAkrIJZKNeqOf71gnlFZj0P/pfkAYFcmjxIabk8swtNu/Na9QsHN4qQ==
X-Received: by 2002:a05:690c:2505:b0:5ce:e0a8:ed6f with SMTP id
 dt5-20020a05690c250500b005cee0a8ed6fmr13900259ywb.22.1701184078322; 
 Tue, 28 Nov 2023 07:07:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com.
 [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
 by smtp.gmail.com with ESMTPSA id
 i186-20020a0dc6c3000000b0057a8de72338sm3921188ywd.68.2023.11.28.07.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 07:07:57 -0800 (PST)
Date: Tue, 28 Nov 2023 10:07:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, goldsimon@gmx.de
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
Message-ID: <20231128150755.GY2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
 <20231127130828.GC2513409@bill-the-cat>
 <CAD8XO3buruEtFvVv32J-LW+Jj=+vFJk2Q+TgBKL130sL2qY0DQ@mail.gmail.com>
 <20231127140813.GF2513409@bill-the-cat>
 <CAD8XO3b-BijLJz0fbsLA-DdAzW_Yj0Z+JOWZtFUFr-3KgKesQA@mail.gmail.com>
 <CALeDE9MMCPNtj9yaXdPwbppOsmUSvmuNWdicNLvqZmY2c=h9dw@mail.gmail.com>
 <20231127163156.GJ2513409@bill-the-cat>
 <CAD8XO3YyzGz3MFPoBu1SZyC1rA7u2y_vB8Y9XCry5bTvwdjoiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tpaWeO+CfpisoyGq"
Content-Disposition: inline
In-Reply-To: <CAD8XO3YyzGz3MFPoBu1SZyC1rA7u2y_vB8Y9XCry5bTvwdjoiw@mail.gmail.com>
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


--tpaWeO+CfpisoyGq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 03:35:00PM +0600, Maxim Uvarov wrote:
> On Mon, 27 Nov 2023 at 22:31, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Nov 27, 2023 at 03:52:50PM +0000, Peter Robinson wrote:
> > > On Mon, Nov 27, 2023 at 3:32=E2=80=AFPM Maxim Uvarov <maxim.uvarov@li=
naro.org>
> > wrote:
> > > >
> > > >
> > > >
> > > > On Mon, 27 Nov 2023 at 20:08, Tom Rini <trini@konsulko.com> wrote:
> > > >>
> > > >> On Mon, Nov 27, 2023 at 08:06:23PM +0600, Maxim Uvarov wrote:
> > > >> > On Mon, 27 Nov 2023 at 19:08, Tom Rini <trini@konsulko.com> wrot=
e:
> > > >> >
> > > >> > > On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:
> > > >> > >
> > > >> > > > Increase allowed binary size to fit lwip code.
> > > >> > > >
> > > >> > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > >> > > > ---
> > > >> > > >  configs/am335x_evm_defconfig | 1 +
> > > >> > > >  1 file changed, 1 insertion(+)
> > > >> > > >
> > > >> > > > diff --git a/configs/am335x_evm_defconfig
> > b/configs/am335x_evm_defconfig
> > > >> > > > index f048e60f7f..9fd608bd76 100644
> > > >> > > > --- a/configs/am335x_evm_defconfig
> > > >> > > > +++ b/configs/am335x_evm_defconfig
> > > >> > > > @@ -124,3 +124,4 @@ CONFIG_WDT=3Dy
> > > >> > > >  CONFIG_DYNAMIC_CRC_TABLE=3Dy
> > > >> > > >  CONFIG_RSA=3Dy
> > > >> > > >  CONFIG_LZO=3Dy
> > > >> > > > +CONFIG_SPL_MAX_SIZE=3D0x29000
> > > >> > >
> > > >> > > As probably a problem for other platforms you made this change=
 on
> > too,
> > > >> > > you can't do this. The link limit is here because that's the
> > limit the
> > > >> > > hardware (and ROM) imposes.
> > > >> > >
> > > >> > > You might need to either:
> > > >> > > - Figure out how to make lwip even tinier for the SPL case
> > > >> > > - Limit the old network stack to just for SPL, and a later task
> > is to
> > > >> > >   reduce what's in the old stack to just what's also needed
> > within SPL.
> > > >> > >
> > > >> > >
> > > >> > Thanks Tom. All these size changes need to be reviewed.  Some of
> > them are
> > > >> > ok, I think like for x86 or qemu virt, but some of them might not
> > work.
> > > >> >
> > > >> > Question - Do we need networking inside SPL rather than in the m=
ain
> > binary?
> > > >> > Is it a real use case?
> > > >>
> > > >> Yes, the device supports loading SPL, and then SPL loading U-Boot =
both
> > > >> over USB RNDIS as well as regular physical ethernet.
> > > >>
> > > >> --
> > > >> Tom
> > > >
> > > >
> > > > That looks like not a production use case. USB + NET + drivers + EX=
T4
> > + NAND + MTD and everything else and trying to fit into SPL.
> > > > With enabling LTO I still need 4k (without dropping current code).
> > From one point it's too synthetic use case here and might be a historic=
al
> > > > limitation which we will not see on future boards. From the other
> > point it will be good to not break it somehow....
> > >
> > > Does this still include the old network code?
> > >
> > > Also I wonder if we can have a paired down SPL_LWIP option that
> > > removes things like PXE and HTTP/wget because none of those would be
> > > used in the SPL use case as they're all brand new.
> >
> > To be clear, I am fine with either "old network stack only for SPL" or
> > "figure out how to pair down lwip to just SPL features". In fact having
> > said that, the first thing I would suggest is to turn off LTO as it
> > makes reading the linker map file harder, increase the size limit for
> > this platform, and take a look at what's being linked in and not
> > discarded in SPL, for networking, in spl/u-boot-spl.map. Maybe the
> > answer is that we just need to be more careful about using
> > IS_ENABLED/CONFIG_IS_ENABLED (and obj-$(CONFIG_$(SPL_)FOO)) in the lwip
> > series.
> >
> > --
> > Tom
> >
>=20
> Yea. If I disable TCP then we get the right size for this board. So for S=
PL
> I think to build without TCP so that ping, dhcp and tftp will still work.
> For normal binary TCP will be enabled. For other boards with limits I thi=
nk
> also to disable TCP for now.

Yes, that sounds right and also like you need to integrate lwIP more
with our Kconfig symbols, PROT_TCP is already there and needs to be
obeyed.

--=20
Tom

--tpaWeO+CfpisoyGq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVmAkgACgkQFHw5/5Y0
tywPCgv/TaF6wt0KJjA8vS99L24DyHoG3/FeFUHIs5njhyeojiLeCd7oCCqvg8l8
uSFqBqT7Iy6khMyiiZmxrE3KC6kihix1QNL4hSgUA/1G1KHOEJoKPs9clmATp8A/
9Ptl0HpLJ2qCTrlLkesDRbx/ri01Th53yfaJQN2Xy+Bm3XjopXFtayf34GvXzRdV
E+bBWP/K9JpJJhNggJPwW0O4zRcxc8/jZeArU3vXR7/wVKzJfNTTMH9pVNLdnDrm
K1d0YsQjbvyyXGpcgRBmcf7LqzqLuOFU2HZp/jcGz5tJichEZptPJF5lrJZKuuuK
WOIS5Uwo87oy/EL4kg1BC+J3rwSGqSpkefFBCb2meTR6aImVQ6vMTwzKGocLz+4p
mco7ZyAE1eaV3Y5BxhL3yb8WD3CP7mpV6NlIe/ukwrzwDAokP4mldmPHrEZRsTbf
YaM5tCL4haLncy7qSDhUIc6SlfprAAA2iJs69B1iKG9YD83hpWSsjxJI4xcIDDcG
LICQSLXb
=3sE8
-----END PGP SIGNATURE-----

--tpaWeO+CfpisoyGq--
