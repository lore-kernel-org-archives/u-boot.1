Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC97C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC2B807B1;
	Mon, 10 Feb 2025 15:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pZ5VtOiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E6580821; Mon, 10 Feb 2025 15:35:11 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB52806ED
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f77b9e0a34so32301997b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739198108; x=1739802908; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i9l2f81LtYIHwg8hLQ1gA2aHqQTGIQIAygClho6yYY0=;
 b=pZ5VtOiJqPArsL1cefTl/hl+f8tKS2r75Xe4btaYH4JOIwbwJbDp5mzLD4p0C7i0GR
 Q5TzqSPBlst3f2IMZUQyRyX8drfm6sX4CivWZhc1TiIvKMYnWUzd5N7bF6NAgYYsX+Ka
 +NsTAe/tuWkUVLZ+Eebxtg9l6cTCxBahUcfoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739198108; x=1739802908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9l2f81LtYIHwg8hLQ1gA2aHqQTGIQIAygClho6yYY0=;
 b=UeDG8cw/oekujwmPfDk1sp+xS/701M53fWYOv1vm2L9t4r7oR9DzQzw9IsjLFwLWf/
 KrRGO7II9jsDH/zKDiuTcoddfCO6ysHB0DfJiKHpBlS1u5aVsuryqe/5AbRVXahdXe5E
 32H9X73pRAlP8kwCk41oKc8zKVLH9kmHHByOLC1Jjpv03cIP4dCyEL63rKjxI/nncL9N
 StodXCKrwRpwAKgih/nLCCXjvsvzaa9udGKpgeWwYf3ZxxFNLqgl3uk9dKpXlJ1nTDeH
 tDx/m8I0eLi+KgO5Zz6nf4KcdRCYA/zeXk1IRg9CN7RNftc5e4BL+/yO+7eIql8Ahu7c
 qNpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6nlSEZTZvW5Juqu+i56KomEC5GO7k+gO2XL+KymYFDuOA/Rmxhm4aEJPANL21+OTKq7ggLy8=@lists.denx.de
X-Gm-Message-State: AOJu0YwsZGmYXJueiW3MvWq4VUDC74+tb0phqQ9hco6jtjsSzRRknBXe
 /rFOb97GcnE52+UA8EdiLhXwgQ6ujLEbjDLXUmRc7FNDvHuLnT1485Tzu1q6QTQ=
X-Gm-Gg: ASbGnctkTiT0uQKBgEEoyidOzzsM2muyiZPi1n1yN5vAgCsp2xGMlfDNcOR/0Ozvw5Q
 OJMvAjBxNoEIbcH8RmPdThkw4rd8Oj/ozRG40S0fNDd0AZ1Ux4ZtJ9EB81gVu689lJIqwLXdGky
 e3O/2cNX6jSaCKWG9cwaPyOUrsSeroG7Jv1OJJTDR5iI2ale8VfHJn2qzPcbuXkY1fgS0uQsaO2
 466fjYWOqE97BfO41j47kxEA74o13v4ZGSEflJrW47aBIMKl9w8a/eNACPb1eptphFTQQpCxt9j
 0Y7+fmFsFhKuhV4=
X-Google-Smtp-Source: AGHT+IEEO05q1Tp2aicksrtbWcmg1fanhCImr/Cvf2UqcdetIDqFKVq2tJjuXtT7CuAThCHcTsRe5w==
X-Received: by 2002:a05:690c:4c10:b0:6f7:55a2:4cf5 with SMTP id
 00721157ae682-6f9b2844626mr115175337b3.2.1739198107651; 
 Mon, 10 Feb 2025 06:35:07 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a856sm16689607b3.92.2025.02.10.06.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:35:07 -0800 (PST)
Date: Mon, 10 Feb 2025 08:35:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
Message-ID: <20250210143504.GC1233568@bill-the-cat>
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
 <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
 <c3cd2190-096b-4f5d-a5cc-481cc44fa11c@kwiboo.se>
 <CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com>
 <20250209164945.GN1233568@bill-the-cat>
 <CAFLszTjFDzM18Nzacj+z7E+PaGwmF5+PcP=T2vFA=Eg1+AdpsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kU+XyL0EyVUs/28x"
Content-Disposition: inline
In-Reply-To: <CAFLszTjFDzM18Nzacj+z7E+PaGwmF5+PcP=T2vFA=Eg1+AdpsA@mail.gmail.com>
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


--kU+XyL0EyVUs/28x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 01:14:29PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 9 Feb 2025 at 09:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 09, 2025 at 07:27:37AM -0700, Simon Glass wrote:
> > > Hi Jonas,
> > >
> > > On Fri, 20 Dec 2024 at 09:50, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > >
> > > > Hi Quentin and Simon,
> > > >
> > > > On 2024-12-13 15:30, Quentin Schulz wrote:
> > > > > Hi Jonas,
> > > > >
> > > > > On 12/13/24 12:57 AM, Jonas Karlman wrote:
> > > > >> The u-boot.rom image contain u-boot.img FIT instead of the FIT g=
enerated
> > > > >> by binman for the u-boot-rockchip.bin image.
> > > > >>
> > > > >> Change to include the binman generated FIT for the u-boot.rom im=
age.
> > > > >>
> > > > >> This change result in TF-A being included and the use sha256 ins=
tead of
> > > > >> crc32 checksum in the u-boot.rom FIT.
> > > > >>
> > > > >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > > >
> > > > > IIRC Simon was fine with removing u-boot.rom support for RK3399 w=
hen I
> > > > > asked months (probably years?) ago, if that hasn't changed, maybe=
 we
> > > > > should now.
> > > >
> > > > Good to know and fully agree, we should try to remove it now.
> > > >
> > > > I did a compare between u-boot-rockchip-spi.bin and u-boot.rom and =
after
> > > > this series they are now identical for the full size of
> > > > u-boot-rockchip-spi.bin.
> > > >
> > > > However, the u-boot.rom also has a copy of ~u-boot.bin and a fdtmap
> > > > starting at 0x300000. I have no idea if they are used for anything,
> > > > if they are it is probably not for bare metal booting (TPL+SPL).
> > >
> > > I'm not sure about the extra u-boot.bin, but the fdtmap is so that
> > > 'binman ls -i xxx' works.
> > >
> > > >
> > > > Regards,
> > > > Jonas
> > > >
> > > > >
> > > > > Especially since the only RK3399 with CONGIG_HAS_ROM set are Bob =
and Kevin.
> > > > >
> > > > > @Simon, you said you tested the patch series on them, with which =
image
> > > > > did you do that? Are you still fine with removing the u-boot.rom =
for RK3399?
> > >
> > > Yes that's fine.
> > >
> > > Basically all my testing is in my lab now, which you should be able to
> > > use with gitlab.
> >
> > I really wish you would use the community gitlab instance and not
> > encourage people to use your personal instance instead.
>=20
> I wish I didn't need one and anyway, that wasn't what I said. Jonas
> has u-boot-rockchip, I believe, so should be able to push things and
> run on my lab.

I don't know why you think you need your own gitlab instance, no one
else does.

> Perhaps the problem is that it's too complicated? If you could find a
> way to allow this change in, people could just click the button and
> may be more likely to use it?
>=20
> .lab_template: &lab_dfn
>   stage: sjg-lab
>   rules:
>     - if: $SJG_LAB =3D=3D "1"
>       when: always
>     - if: $SJG_LAB !=3D "1"
>       when: manual
>       allow_failure: true
>   tags: [ 'lab' ]

And I don't know what that's for. You can already click a button and run
a pipeline that includes your lab.

--=20
Tom

--kU+XyL0EyVUs/28x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqDpgACgkQFHw5/5Y0
tyzMtAv/bID4nB081x/2ne5Tj2TMkpBITewAWVonMVujsBO/2GKYrEi19kSN2jgs
/chV1r4oJpNYEpZjiXySLh/Xsml82o5TW1Ad3EIGxLrBHYn2m83WYWq8Z2RK/ivE
F0S1Pg6Vw4G42K9MWe9mMHwrp0JQ2bmRuVGVzpflPQX6fhaORrGO/EMxgRDQKmyi
QFVQV9L29PQdpxs5cC9UMY0bHjsEXQdBy5slw+DEjQGLd/ZU0SQodxiSm/sWFg2L
yw3RWSv0L1IKaCEzmilxP6Qr9JeL0JbpO3Q54uLaUNd5fy9eu5oZbYnGWldMjgC3
i6QzO91Rn2jp/FdGUBA1zvlNCzyEkpQ8k/nhUWhqDqUviAqus/uQkxPSocl1iWLy
lfCDA+Km5Wu0Yj9b9fANLxp1j/0RSUseuDgJFI/mcmPoS3xihdKmYPCEQgbixxdG
oQ8YOk0+VtKKHtAnGoYqZH0j/OPEOciZcd2Mft6pMhe6dhiZLohCi3RY7YozPYDs
zIh+gmh5
=+CkG
-----END PGP SIGNATURE-----

--kU+XyL0EyVUs/28x--
