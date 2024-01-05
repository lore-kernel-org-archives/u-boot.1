Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3043BC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 14:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D709879AF;
	Fri,  5 Jan 2024 15:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uJdsel80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35ADC87282; Fri,  5 Jan 2024 15:48:03 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54654879AF
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 15:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7815aad83acso46887585a.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 06:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704466078; x=1705070878; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NMRKqQiy49znztIHQSeIDTlLDPw4c5oHm+JkYY3oLUQ=;
 b=uJdsel80ZcHlBA4HolalaU319F9NGOWkGC9l4mjEe6WhJ2qoUMd9dRxK62+fgbBile
 vYRbrP4uZGUXyetZXtphDhv4tKck15z58t9CvwN64Whai7+fXRl2uBcM15GUNU3hxU6i
 nrgx6UOzrX+Ca97XJmMvLVPfm7mJAEBSJ412k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704466078; x=1705070878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMRKqQiy49znztIHQSeIDTlLDPw4c5oHm+JkYY3oLUQ=;
 b=artbFNqiZrN7xxo25NjAwqa8w4BTCLOwQDmIcANpcjT2+BXxFXj35tHZ3QK208tr28
 Li0f+jdwhDYAm2GLutsf+7nXfdOV/vs8wtBJ2WS3eaVQmAdvui/p1Qv4n3SQCKnxW2T4
 s6VO1tSzy84i7L4RSbpUPxHsJw3AUGNGex6MIUYyciu7BtelnPtJX5vKThPcsOTvAgfP
 d//rOYwFX35AgLdwrJT6e9smmBjz7GhVreKogL/31x6y24/T+GF5TSOH8CXPSXdF1KFO
 w8CjSTJIDKKR3+mCNnEgWeRjgbRITbviQlbif3LoFkTY6r0qdFfwJSFRgiz7MLalyOJo
 9FGQ==
X-Gm-Message-State: AOJu0YyiPIxs3YUNgFAHCHidyf4BSTdPC3jK3OeG8A5WvD0XgmTBV07L
 cfdugQ/QefhI9wgyaTN/H1HWau/YZwPywQ==
X-Google-Smtp-Source: AGHT+IE9voez2h67JFlHPinAhCpVFikSl9DMGGcLKhYVKBp2JiTV8f5iSDF76K3syCtr9j5L6ddUeQ==
X-Received: by 2002:a05:620a:851:b0:781:2184:d9f5 with SMTP id
 u17-20020a05620a085100b007812184d9f5mr3015570qku.54.1704466078059; 
 Fri, 05 Jan 2024 06:47:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 v9-20020ae9e309000000b00781bd7542ebsm628368qkf.79.2024.01.05.06.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 06:47:57 -0800 (PST)
Date: Fri, 5 Jan 2024 09:47:54 -0500
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
Message-ID: <20240105144754.GV1610741@bill-the-cat>
References: <20231208083726.26906-1-wan.yee.lau@intel.com>
 <DM8PR11MB5592CA687BF05641806BA22BD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
 <edccf82f-2c65-4f09-bd9d-f94765ae015d@denx.de>
 <MW3PR11MB4553AD65903767C338B8E43AB696A@MW3PR11MB4553.namprd11.prod.outlook.com>
 <c85be092-64de-4bac-842a-b7d1d4587d84@denx.de>
 <MN2PR11MB45528C0C90F9EFCF41312795B695A@MN2PR11MB4552.namprd11.prod.outlook.com>
 <20231221142629.GG2513409@bill-the-cat>
 <MW3PR11MB45535668EDBDDD0F191D471CB6662@MW3PR11MB4553.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4bxRZj++wwYWLRi9"
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45535668EDBDDD0F191D471CB6662@MW3PR11MB4553.namprd11.prod.outlook.com>
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


--4bxRZj++wwYWLRi9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 01:54:34AM +0000, Lau, Wan Yee wrote:
>=20
>=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Thursday, December 21, 2023 10:26 PM
> > To: Lau, Wan Yee <wan.yee.lau@intel.com>
> > Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> > <tien.fong.chee@intel.com>; u-boot@lists.denx.de; Hea, Kok Kiang
> > <kok.kiang.hea@intel.com>; Maniyam, Dinesh <dinesh.maniyam@intel.com>;
> > Ng, Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> > <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> > <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> > Subject: Re: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for=
 Intel
> > SoCFPGA
> >=20
> > On Thu, Dec 21, 2023 at 01:59:02AM +0000, Lau, Wan Yee wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Marek Vasut <marex@denx.de>
> > > > Sent: Thursday, December 21, 2023 12:11 AM
> > > > To: Lau, Wan Yee <wan.yee.lau@intel.com>; Chee, Tien Fong
> > > > <tien.fong.chee@intel.com>; u-boot@lists.denx.de
> > > > Cc: Simon Glass <sjg@chromium.org>; Kever Yang
> > > > <kever.yang@rock-chips.com>; Bin Meng <bmeng.cn@gmail.com>; Jonas
> > > > Karlman <jonas@kwiboo.se>; Jean- Marie Lemetayer
> > > > <j.lemetayer@kerlink.fr>; Peng Fan <peng.fan@nxp.com>; Vladimir
> > > > Zapolskiy <vladimir.zapolskiy@linaro.org>; Konrad Dybcio
> > > > <konrad.dybcio@linaro.org>; Simon Goldschmidt
> > > > <simon.k.r.goldschmidt@gmail.com>; Hea, Kok Kiang
> > > > <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> > > > <dinesh.maniyam@intel.com>; Ng, Boon Khai <boon.khai.ng@intel.com>;
> > > > Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Chong, Teik
> > > > Heng <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> > > > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > > > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>;
> > > > Tom Rini <trini@konsulko.com>
> > > > Subject: Re: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver
> > > > for Intel SoCFPGA
> > > >
> > > > On 12/20/23 04:09, Lau, Wan Yee wrote:
> > > >
> > > > Hi,
> > > >
> > > > can you trim the CC list to relevant people ?
> > > >
> > > > [...]
> > > >
> > > > >>>> +++ b/drivers/misc/socfpga_dtreg.c
> > > > >>>> @@ -0,0 +1,117 @@
> > > > >>>> +// SPDX-License-Identifier: GPL-2.0
> > > > >>>> +/*
> > > > >>>> + * Copyright (C) 2023 Intel Corporation <www.intel.com>  */
> > > > >>>> +
> > > > >>>> +#include <asm/io.h>
> > > > >>>> +#include <common.h>
> > > > >>>> +#include <dm.h>
> > > > >>>> +#include <errno.h>
> > > > >>>
> > > > >>> Please move <asm/io.h> above to here
> > > > >>>
> > > > >>>> +#include <linux/sizes.h>
> > > > >>
> > > > >> A good starting point would be to have socfpga 64bit maintainer ,
> > > > >> without that , these patches are only being archived .
> > > > >
> > > > > Hi,
> > > > >
> > > > > Is only one socfpga 64bit maintainer needed or the whole socfpga
> > > > > 64bit
> > > > maintainer need to be included for this driver?
> > > >
> > > > U-Boot currently does not have any SoCFPGA 64bit maintainer, that
> > > > needs to be fixed .
> > >
> > > Can you share the steps on how to get this fixed? Is there a guide on
> > > how to add/process new maintainers?
> >=20
> > Well, the first step is to identify someone with familiarity with SoCFP=
GA and U-
> > Boot and time to spend in the community.
> >=20
> > --
> > Tom
>=20
> Thanks. What is the next step after identifying the person that fits the =
requirement?
> How do I proceed with adding the new maintainers.

Having them talk with me, off list.

--=20
Tom

--4bxRZj++wwYWLRi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWYFpcACgkQFHw5/5Y0
tyyO3Qv8CtOBeigaChvBHHdi79NC6bu2zKOgIx/MDlrPFt/w0retCYszUdNsKu5S
2+EAoHp6hm4NpPBTJ4cXjl1WF4la0tMn7VZzzOdr3MKY6kdfS1jUtHr1VjJRJMGg
cJ6FB02juf8L7fotC8pzKSZl/cuqBDLHr3rU9yjXl+8/MMyWqRamoWusUeJPsXlC
ezrZbZIE3cN4pgUFyk7wAc3h/3+HhICPr8SrcxEtfeqwpYdhaNe3pEUldD1xDCmX
OR9Vv6DzeREvnFH/9K9PRC3vhBXnvU0hRMIdCTb5coiXKRGyEGqCCxU9M8Yh34Tk
jAJVGfWfYmlmXTVkYlX+7z135Hk/xYZeuVPb/KNGRnK/5Gt72t143x7BD+iYLj89
iLku75Xxrsuz/BTKY5luDluMq6n7hkFl/9ikSEwEq8YlUQxVITWBs1M7WZeFaMhV
wKejH9GY0HzkWgCUUA4P5zpZ4tcJY3Lfd7eAtHmW9hGJ8/pFnfGD8YFXgyZl33bL
/vdd9pV6
=ynud
-----END PGP SIGNATURE-----

--4bxRZj++wwYWLRi9--
