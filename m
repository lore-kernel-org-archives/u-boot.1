Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD23C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 13:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC598772A;
	Wed, 20 Dec 2023 14:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EqB1NFLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F3087786; Wed, 20 Dec 2023 14:20:54 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B63876C1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 14:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-db3a09e96daso3942597276.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703078451; x=1703683251; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lcg4bIb1+w/l3J1kHwklsxzpPW+73YG9q4iqwGHMg3U=;
 b=EqB1NFLsfysOaglj+LH3z9mxU687weexRg66ZB3t/kwixYtAJjSK/rW0aINq9V/f84
 kp1Z/B1RDjec5PTbqXtixl8QrHWs+rY5Pifes3nd3K332ASjZvGtDf+bcLcIYtBP4yoT
 2Uk2PrixjK9DqnXl21DpAA715q0nu3J1TR1tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703078451; x=1703683251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcg4bIb1+w/l3J1kHwklsxzpPW+73YG9q4iqwGHMg3U=;
 b=HZeGQuUWY83cTDWjBhRfijZF8ZeanSfk0DZ2nRrNTG4ty/kOJ+WGWAe5f3R8umu8gl
 I5+BNBO+dlkd6KX8RQIpTtwwvkQGuV+B2TwhYw5IhSnRbqviNweHO+1yHcmIEvPaGbBa
 6WPCF03ykB6xuj28UM/282LoIBTqTGndL4HDVAvmFDz5al8rRyj7kPblEYvXFPN0gEp0
 ImSWdxI4KjwG6IECN6lE81Ne8pJrftNBLi9BB33eD1c8CDuNb0HS4LxCImz9OvzdOvD4
 s0OZUAI6zlV0J42rnoXnqF74ZH39UFLnAHBtQ1X2za7tr93kz3SFY9Qv1J3ivab83rGd
 Xqag==
X-Gm-Message-State: AOJu0YwkFkACjno8c7EFl0JqoOtnYK6HhLlfA1ZTxiGH2IRlVNop7shU
 Ptua18RULmA8putexXLAsN7qxQ==
X-Google-Smtp-Source: AGHT+IG4vzjjPrvnTnLuTg+hTurZkviubeZ4t+Uw99e/ojlORvuLoKk3LzhAlw7LODkTxquJM16llA==
X-Received: by 2002:a25:8890:0:b0:dbd:564a:5ffb with SMTP id
 d16-20020a258890000000b00dbd564a5ffbmr1572293ybl.87.1703078449523; 
 Wed, 20 Dec 2023 05:20:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 t127-20020a254685000000b00db39d501e8esm5102735yba.61.2023.12.20.05.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 05:20:49 -0800 (PST)
Date: Wed, 20 Dec 2023 08:20:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: neil.armstrong@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 sean.anderson@seco.com, heinrich.schuchardt@canonical.com,
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Message-ID: <20231220132047.GJ2513409@bill-the-cat>
References: <20231213230545.GM2513409@bill-the-cat>
 <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
 <20231214131139.GY2513409@bill-the-cat>
 <CAPnjgZ17b7sZX-dey5mdXJJ17g5ho_U2UZkawyFYU19R-gidhQ@mail.gmail.com>
 <20231217184100.GC2513409@bill-the-cat>
 <06036b6f-70b8-4b80-823d-d9716cbbf160@linaro.org>
 <CAPnjgZ2wcmGOjbVdNCyzSWNGzBPjPqcjdVcbPu8J2wadnxFRrQ@mail.gmail.com>
 <0b7d6cd7-4248-47d7-81c8-7466177d5172@linaro.org>
 <CAPnjgZ1XP4+0sefoXNfvgSmMef2zsRsNPN-hzxAUFhb7dDX6Hg@mail.gmail.com>
 <CAPnjgZ0hfGARdygcO0wV1R2_XNZ5mUvHfRxsKv2f1AKXiHghFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8BnO2A5boviMuoTN"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0hfGARdygcO0wV1R2_XNZ5mUvHfRxsKv2f1AKXiHghFw@mail.gmail.com>
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


--8BnO2A5boviMuoTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 09:46:22PM -0700, Simon Glass wrote:
> Hi again,
>=20
> On Mon, 18 Dec 2023 at 14:07, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Neil,
> >
> > On Mon, 18 Dec 2023 at 08:37, <neil.armstrong@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > On 18/12/2023 16:01, Simon Glass wrote:
> > > > Hi Neil,
> > > >
> > > > On Mon, 18 Dec 2023 at 02:54, <neil.armstrong@linaro.org> wrote:
> > > >>
> > > >> On 17/12/2023 19:41, Tom Rini wrote:
> > > >>> On Sat, Dec 16, 2023 at 11:46:18AM -0700, Simon Glass wrote:
> > > >>>> Hi Tom,
> > > >>>>
> > > >>>> On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrot=
e:
> > > >>>>>
> > > > [..]
> > > >
> > > >>> And my point with the above is that other SoC maintainers (Neil, =
for
> > > >>> amlogic) have said (paraphrasing) he does not want to do N smbios=
 node
> > > >>> patches. Which is why Ilias' patch is if not 1000% correct, it's =
Good
> > > >>> Enough and will, if it's really a problem to have all lower case
> > > >>> information displayed, spur people to see providing that informat=
ion as
> > > >>> a real problem that needs to be solved. Or it will be seen as good
> > > >>> enough.
> > > >>>
> > > >>
> > > >> If some platforms requires a more "correct" smbios dataset, then t=
hey're
> > > >> welcome adding the required smbios node, and it's perfectly unders=
tandable,
> > > >> but for the other community-maintained platforms we need some vali=
d fallback
> > > >> data otherwise they'll be de facto excluded from some tools for no=
 valid reasons.
> > > >
> > > > Do you know which tools require SMBIOS tables? I found sos and anot=
her
> > > > Redhat one.
> > >
> > > SMBIOS data is translated into dmi informations in Linux, and a little
> > > lookup in GitHub gives 6.4K files using something from /sys/devices/v=
irtual/dmi/id/,
> > > and by very commonly used tools like lshw and probably fwupd.
> >
> > lshw also uses devicetree, so should not also need SMBIOS.
> >
> > fwupd uses UUIDs to indicate the device. So far as I know (and I wrote
> > a plugin for it, so at least know something), it does not rely on
> > SMBIOS tables.
> >
> > Here is my main question: is SMBIOS:
> >
> > 1) just informational, not affecting the operation of the device
> > 2) important and needed for the device to function
> >
> > If it is (1), then I don't mind what is in the tables - we could
> > perhaps add a '?' at the start of each string to indicate it is
> > provisional?
> > If it is (2), then I want to avoid adding information that might be
> > wrong / might change over the life of the device
> >
> > In either case, putting these workarounds behind a Kconfig seems
> > reasonable to me. What do you think?
>=20
> Hmmm and I forgot the other problem, which is that there is no way to
> pass an SMBIOS table to Linux without booting via EFI. But I don't
> follow it closely, so perhaps that has been resolved?

This issue here is firmly NOT a U-Boot problem. It's a problem for
whomever wants to, I assume, design and upstream a DT binding to
describe how to find a populated SMBIOS table? There is IIRC some
MIPS-specific Linux Kernel option, but I imagine it wouldn't be allowed
to be added to other architectures as I assume it's magic location based
like non-EFI x86 ones?

--=20
Tom

--8BnO2A5boviMuoTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWC6i8ACgkQFHw5/5Y0
tyx1sAwAjLEfW/5TZTejj4LMMsli6LI27rdUj/20yMrjPpdaHVyXolrEPJDzepb9
1KuSawrdlYTwqiJkmRRYc0PYsQrVKFwvykpG+OKb2sUBa+9vYZm5QrKqjV2iraLT
IY80yxNK0AMeihEVb8CT90r6I/Fk2inc7ygGULJqNbAwGNFRoJJZYC6t2ocwrlCT
Arx95xsG6xEB5/IZ+WYsrt1GIHmgjkHsEMWovmUPx+Qav8l+sMeuQXl6h5xhRvxC
wKkboGW0ZqvYuI989ib1xoSqUh//akupDn1maqbJ+ObQiQK7B8Czusix9lU2ItUU
UVfLUdKHL1/AocKR6nx1sfjydAY4ErlMlZ/AsqkKEM2N+zQPxPDgDne/0DzhP2Zu
1AUz3NcmhMuePgOI/VcuL8pcAcKmNpRaJJcqpSvNTY7RlMGfGKIy4aOK1tyw7tb/
O3mwNajMZqbEEz/LHjuuN7PJHBw9wHG0i1CZcrG/clEyUmo2op5I73N8tULZPspH
cZfXr7Po
=PgNI
-----END PGP SIGNATURE-----

--8BnO2A5boviMuoTN--
