Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CFAC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 16:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A548759F;
	Mon, 27 Nov 2023 17:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QXuV0snW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6100F8761B; Mon, 27 Nov 2023 17:32:02 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2185B87585
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 17:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5cc55b82ee5so41108197b3.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701102719; x=1701707519; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZVGEhAKntuSLzVHCX4BjfUeJp/mfNMnKRAwlXOfj1w=;
 b=QXuV0snWgcNHil/oVJc3UU2hA0viDoQLHua5CboH9LQkF98pGqtL88oORRevwczsFh
 6t0VyLYt2Pd1DE2xh3wd0SD2f49/hOsmt5BYyop7Reni1BsIY0tVDe5L2ZmbPZlZh02N
 gp1dqLdW7ic0gl7F4SNLPoqZ+76RQxoGaKcgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701102719; x=1701707519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZVGEhAKntuSLzVHCX4BjfUeJp/mfNMnKRAwlXOfj1w=;
 b=hydmebVnW+cVGj0RXB/m600E9NsBByTpPwHmIXonL4Pi6L1t4lVn4RJf5Pzy9xFQHA
 bffcHVYjf+UKSkF5Z2Lf8Cjg32LwMgtT2Lh8Qof9kfG1V7F8z8hZ1q2IsI7rYDyEjnhS
 LnWkC/kR1rya1SJBEcj+VTIqGZUC2Oumi+qNS6qqEPldoqZxKWeArvMiIkN+YseO0w6a
 Z8TdQ4ppTIVhZGsiSGWxr15aRjld3m+XbYJ30P8FZEHNRdFBzPWE3nHtvkzGyIK/zvFR
 ai5DPcYekJNXSZLNpTcEYZykKRMaPWzommn17w01K/TjgQrvB4Cv6tbsmMoYZD/aU3H5
 NCTg==
X-Gm-Message-State: AOJu0YzvI82sZX/mvR+BrIrf93oTs8XqoC+Q21QrEgxINKXq5pt+BYal
 NsDDUK4lPeA+QLUOJ3mGaMxD9w==
X-Google-Smtp-Source: AGHT+IGkQEPbIVS2BpTBLcSnvwx0axa8tHYOsxIet4sLkLfKZ+OALiBye+FOG3yj7460fm8MVkajcg==
X-Received: by 2002:a81:e30a:0:b0:5cf:b796:c40b with SMTP id
 q10-20020a81e30a000000b005cfb796c40bmr4867630ywl.20.1701102718581; 
 Mon, 27 Nov 2023 08:31:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 b123-20020a0dc081000000b005a7bbd713ddsm757871ywd.108.2023.11.27.08.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 08:31:58 -0800 (PST)
Date: Mon, 27 Nov 2023 11:31:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, goldsimon@gmx.de
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
Message-ID: <20231127163156.GJ2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
 <20231127130828.GC2513409@bill-the-cat>
 <CAD8XO3buruEtFvVv32J-LW+Jj=+vFJk2Q+TgBKL130sL2qY0DQ@mail.gmail.com>
 <20231127140813.GF2513409@bill-the-cat>
 <CAD8XO3b-BijLJz0fbsLA-DdAzW_Yj0Z+JOWZtFUFr-3KgKesQA@mail.gmail.com>
 <CALeDE9MMCPNtj9yaXdPwbppOsmUSvmuNWdicNLvqZmY2c=h9dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r+EEGU2mx1h+0ZQD"
Content-Disposition: inline
In-Reply-To: <CALeDE9MMCPNtj9yaXdPwbppOsmUSvmuNWdicNLvqZmY2c=h9dw@mail.gmail.com>
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


--r+EEGU2mx1h+0ZQD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 03:52:50PM +0000, Peter Robinson wrote:
> On Mon, Nov 27, 2023 at 3:32=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro=
=2Eorg> wrote:
> >
> >
> >
> > On Mon, 27 Nov 2023 at 20:08, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Mon, Nov 27, 2023 at 08:06:23PM +0600, Maxim Uvarov wrote:
> >> > On Mon, 27 Nov 2023 at 19:08, Tom Rini <trini@konsulko.com> wrote:
> >> >
> >> > > On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:
> >> > >
> >> > > > Increase allowed binary size to fit lwip code.
> >> > > >
> >> > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >> > > > ---
> >> > > >  configs/am335x_evm_defconfig | 1 +
> >> > > >  1 file changed, 1 insertion(+)
> >> > > >
> >> > > > diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_d=
efconfig
> >> > > > index f048e60f7f..9fd608bd76 100644
> >> > > > --- a/configs/am335x_evm_defconfig
> >> > > > +++ b/configs/am335x_evm_defconfig
> >> > > > @@ -124,3 +124,4 @@ CONFIG_WDT=3Dy
> >> > > >  CONFIG_DYNAMIC_CRC_TABLE=3Dy
> >> > > >  CONFIG_RSA=3Dy
> >> > > >  CONFIG_LZO=3Dy
> >> > > > +CONFIG_SPL_MAX_SIZE=3D0x29000
> >> > >
> >> > > As probably a problem for other platforms you made this change on =
too,
> >> > > you can't do this. The link limit is here because that's the limit=
 the
> >> > > hardware (and ROM) imposes.
> >> > >
> >> > > You might need to either:
> >> > > - Figure out how to make lwip even tinier for the SPL case
> >> > > - Limit the old network stack to just for SPL, and a later task is=
 to
> >> > >   reduce what's in the old stack to just what's also needed within=
 SPL.
> >> > >
> >> > >
> >> > Thanks Tom. All these size changes need to be reviewed.  Some of the=
m are
> >> > ok, I think like for x86 or qemu virt, but some of them might not wo=
rk.
> >> >
> >> > Question - Do we need networking inside SPL rather than in the main =
binary?
> >> > Is it a real use case?
> >>
> >> Yes, the device supports loading SPL, and then SPL loading U-Boot both
> >> over USB RNDIS as well as regular physical ethernet.
> >>
> >> --
> >> Tom
> >
> >
> > That looks like not a production use case. USB + NET + drivers + EXT4 +=
 NAND + MTD and everything else and trying to fit into SPL.
> > With enabling LTO I still need 4k (without dropping current code). From=
 one point it's too synthetic use case here and might be a historical
> > limitation which we will not see on future boards. From the other point=
 it will be good to not break it somehow....
>=20
> Does this still include the old network code?
>=20
> Also I wonder if we can have a paired down SPL_LWIP option that
> removes things like PXE and HTTP/wget because none of those would be
> used in the SPL use case as they're all brand new.

To be clear, I am fine with either "old network stack only for SPL" or
"figure out how to pair down lwip to just SPL features". In fact having
said that, the first thing I would suggest is to turn off LTO as it
makes reading the linker map file harder, increase the size limit for
this platform, and take a look at what's being linked in and not
discarded in SPL, for networking, in spl/u-boot-spl.map. Maybe the
answer is that we just need to be more careful about using
IS_ENABLED/CONFIG_IS_ENABLED (and obj-$(CONFIG_$(SPL_)FOO)) in the lwip
series.

--=20
Tom

--r+EEGU2mx1h+0ZQD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVkxHIACgkQFHw5/5Y0
tyxoSgv7Bj1Q9FI6C2/nnSPYrHIfSwXM2SJUJiNgo+flITHBH+pnfEL9rm/N7KsA
iyb/PEC6LBmMVEZok4IGo+u0pLRcAAezW1P+t1O1Q6he+V4vCqkGbY4jos1yYBdS
i8Pnrp8zrEAVeVfIazSWGEGiLrcW32Qisx7q+VyevVLuBBCTfDIILQXAdqGUgaLw
bt/66JaYwz0CaKr0W1dAzKH0u6GEO8nopgaMhgfdrzIKftycIpIoSnfUtvPv8ZPL
l52gBSIcZX97JwUZzhbs/N3loA/Cu2HLa3zGYuUfDVufixrxY1OTkbNUkC6c59hy
Kp9F3UGzXvXl+E3GbthZAU55lP8roPdx+RqO2gFJh+o8mWaDWr6qe5CBC7+d094u
sOT54TyfXDa6xB+mGMAgkHAvNBzGP6xF5BK/zyAm/imM2vpWWXe/gVyXTzGa2TiH
QVEvrg2oRoOte8jcocbWa9RSgG+EqY0KZeOxI8P9BT6Sy6sgqK/irjFivH0Rco+y
SnCkqdEV
=e/3O
-----END PGP SIGNATURE-----

--r+EEGU2mx1h+0ZQD--
