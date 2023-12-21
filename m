Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7A8C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DBE8775F;
	Thu, 21 Dec 2023 15:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nm7+XgKn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E57BA876C6; Thu, 21 Dec 2023 15:26:35 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A058775F
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67f147c04b7so4437216d6.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703168792; x=1703773592; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ht5cwf9xY/QpP1635ByK81l1p+okByAcje4aTgH+Fzc=;
 b=nm7+XgKn2xRcfzymHspxavmXjwOkzsG/qV2deRi5+jsf3ngKVGbgUgti7Peyp/1xhG
 2fbLXU0OMCPt1rWMksd4a1O+Hb+TIOv3x4E+94zzhlqDNZpPZYS/blGHcLOuq0Vza9un
 6lh8CzOqSzBhpxQpClsCZsT8tD/GYMi7fXf2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703168792; x=1703773592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ht5cwf9xY/QpP1635ByK81l1p+okByAcje4aTgH+Fzc=;
 b=qIqoVhBYJ59lAL4w7XqqTtquBlXuru4II22ba5WcnqQ45HDVt/J94Ul2W/qCe0S3Mp
 5y3+aggnUPONqKZ70zNk4m0jHlzPvco3/hI2dP4XKBQqSC2C9xhPxl7sZwJapHB39iLs
 N47+/lVuWm/GgZGbR68JAu3SkoR9jMnymxby0rNEeZu5IwCQ9L6tab9Bj0Qn+84riIhk
 ClJapYuvRgxCGptTbrgd+iup0X00ytfp1KK3ScNd3zMpHb/06RCesWCe6J0omaDFQ+Ws
 8yiiE1fOCJmg1ppO7Tz92bcHWObLFUnsrQwyGlVDpLRhf+ZGarWI00VTQa6Npc2qsShB
 isnA==
X-Gm-Message-State: AOJu0YwifXDuZyMAH6PAh2RYAd7YeFghgIsr89pyluisQ0UU+ASu26dO
 k1pVBj3lekvLJtEIVxM2onffuQ==
X-Google-Smtp-Source: AGHT+IF/Ps6lxn0rFc0C2RZFhyW1910yI1j7WudTGNulkWUsRqlEoPaCKxrxpH7i+w4QTnEXqIReUw==
X-Received: by 2002:a05:6214:114a:b0:67a:a721:b1c3 with SMTP id
 b10-20020a056214114a00b0067aa721b1c3mr20727554qvt.126.1703168791932; 
 Thu, 21 Dec 2023 06:26:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a056214029300b0067f82489c98sm441365qvv.123.2023.12.21.06.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 06:26:31 -0800 (PST)
Date: Thu, 21 Dec 2023 09:26:29 -0500
From: Tom Rini <trini@konsulko.com>
To: "Lau, Wan Yee" <wan.yee.lau@intel.com>
Cc: Marek Vasut <marex@denx.de>, "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>,
 "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Chong, Teik Heng" <teik.heng.chong@intel.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>,
 "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: Re: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Message-ID: <20231221142629.GG2513409@bill-the-cat>
References: <20231208083726.26906-1-wan.yee.lau@intel.com>
 <DM8PR11MB5592CA687BF05641806BA22BD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
 <edccf82f-2c65-4f09-bd9d-f94765ae015d@denx.de>
 <MW3PR11MB4553AD65903767C338B8E43AB696A@MW3PR11MB4553.namprd11.prod.outlook.com>
 <c85be092-64de-4bac-842a-b7d1d4587d84@denx.de>
 <MN2PR11MB45528C0C90F9EFCF41312795B695A@MN2PR11MB4552.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2XbK1fwueMR/SOrl"
Content-Disposition: inline
In-Reply-To: <MN2PR11MB45528C0C90F9EFCF41312795B695A@MN2PR11MB4552.namprd11.prod.outlook.com>
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


--2XbK1fwueMR/SOrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 01:59:02AM +0000, Lau, Wan Yee wrote:
>=20
>=20
> > -----Original Message-----
> > From: Marek Vasut <marex@denx.de>
> > Sent: Thursday, December 21, 2023 12:11 AM
> > To: Lau, Wan Yee <wan.yee.lau@intel.com>; Chee, Tien Fong
> > <tien.fong.chee@intel.com>; u-boot@lists.denx.de
> > Cc: Simon Glass <sjg@chromium.org>; Kever Yang <kever.yang@rock-chips.c=
om>;
> > Bin Meng <bmeng.cn@gmail.com>; Jonas Karlman <jonas@kwiboo.se>; Jean-
> > Marie Lemetayer <j.lemetayer@kerlink.fr>; Peng Fan <peng.fan@nxp.com>;
> > Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>; Konrad Dybcio
> > <konrad.dybcio@linaro.org>; Simon Goldschmidt
> > <simon.k.r.goldschmidt@gmail.com>; Hea, Kok Kiang
> > <kok.kiang.hea@intel.com>; Maniyam, Dinesh <dinesh.maniyam@intel.com>;
> > Ng, Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> > <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> > <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>; Tom=
 Rini
> > <trini@konsulko.com>
> > Subject: Re: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for=
 Intel
> > SoCFPGA
> >=20
> > On 12/20/23 04:09, Lau, Wan Yee wrote:
> >=20
> > Hi,
> >=20
> > can you trim the CC list to relevant people ?
> >=20
> > [...]
> >=20
> > >>>> +++ b/drivers/misc/socfpga_dtreg.c
> > >>>> @@ -0,0 +1,117 @@
> > >>>> +// SPDX-License-Identifier: GPL-2.0
> > >>>> +/*
> > >>>> + * Copyright (C) 2023 Intel Corporation <www.intel.com>  */
> > >>>> +
> > >>>> +#include <asm/io.h>
> > >>>> +#include <common.h>
> > >>>> +#include <dm.h>
> > >>>> +#include <errno.h>
> > >>>
> > >>> Please move <asm/io.h> above to here
> > >>>
> > >>>> +#include <linux/sizes.h>
> > >>
> > >> A good starting point would be to have socfpga 64bit maintainer ,
> > >> without that , these patches are only being archived .
> > >
> > > Hi,
> > >
> > > Is only one socfpga 64bit maintainer needed or the whole socfpga 64bit
> > maintainer need to be included for this driver?
> >=20
> > U-Boot currently does not have any SoCFPGA 64bit maintainer, that needs=
 to be
> > fixed .
>=20
> Can you share the steps on how to get this fixed? Is there a guide on how=
 to=20
> add/process new maintainers?

Well, the first step is to identify someone with familiarity with
SoCFPGA and U-Boot and time to spend in the community.

--=20
Tom

--2XbK1fwueMR/SOrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWESxIACgkQFHw5/5Y0
tyz7Xgv+M6UO/lGF4OsX/aqJuliSX73VM6F731tNYaFlBZayIDdxt2KJz9hEmmDp
CYHsmcoicRtbokUfmpHrEEswW0OK440ab6AlGkaDft7/ZpC3HQfem2MSsmlrngCX
hXHqPltBbwu5oImeiOGyZH4vFRTKCyiriKHa++u93Y6jcwRRMl3nOy/lfp3xV3he
K2r9+BXuOcK9Np08RXFQcjYwZXN/1o6fb4uAwgrRzq7dWlfIsV9fslAP/a0ejZ76
yWR9eJYFYxZ3vvp5zn/8KObW4g4cqcwqimesBnDle7L6CcO3akmlvd0k5Rors7D3
PsvPm2pb8FEpMVCEWT9spxI94zLkPRWAfKgf7CiTK0LOVectApN/1uRS3E/H6JSJ
lSaficGKm76HdxGNPUiEPTWJUL8PgqISwsgxic7bwVmvfsC26JMvi4TEiSqgybh2
L/WajEAlvqEeXIYwY2rXHcQn4k7Ern8P7AatqNwyv4iKuUQ4Gkjv4RFFQMzlyExa
3ceVFhS8
=jwRl
-----END PGP SIGNATURE-----

--2XbK1fwueMR/SOrl--
