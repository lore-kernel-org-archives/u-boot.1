Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF3F8FA8F
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B18839D5;
	Tue, 21 Apr 2026 17:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="axlj6Tns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7253983BC4; Tue, 21 Apr 2026 17:03:22 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B23280433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so880808a34.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776783798; x=1777388598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s7cAZVp0zYH1CzZxn1MBzMxz+gnJcGt0wniSjWvRMLQ=;
 b=axlj6Tnsy+GZYfGQNxypYp4e2N/GZQdvf873WnG+awteGYWIA6ym6i/IwtrxykKY0F
 kmOmN60v9S9aMUlvbsLDiDqU6IqOem3pAzsYWpERvC4LUeKqXxGO6gOTJ0DFWTxrdCoO
 w1EhV0gKxKhq1O28jBi9IFfT4OSdeDdDA5PJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776783798; x=1777388598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7cAZVp0zYH1CzZxn1MBzMxz+gnJcGt0wniSjWvRMLQ=;
 b=kCunXjn+owtJfX9SyAqb4Ey3BDcB4iS9hlZ0wvCQIkcVcEnQFf+b+4U3dwCqdBKQki
 R3n/dcV0LA7sYwuqY3jLmLJx5TOQkZEve/RbSk8Wp2XEp56aESymwumsIYvYDTC3ol3B
 OBj2b/Do8gfp4mQDWfbvrsNaiQ+gf5Vkz3+O3B1AUaIrUbL2ckkhIH7fjDWv31SwKtZH
 SPurZviRT6XEebPRQZDjxcuOQqUyTrQKlw36w8BLgnGkrtLtPv39XkITQGObdyqZmHJl
 GkUoXbKCLTBQtnvvoYvpE6Ab7CskBylOC7EzTQlkxnzPQA5sTmlQHaKDvsVHAA1PjesO
 Tzdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MS5uOjtVd4yPxnqUGnFbZs/nl3Pde+8hRjXOIvOykgj0yrfz4y0Uajldchhg4Cv5qOHF9ULQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyY6GytFdrpi1JKihX7O1sRfttybv/O2RWW09YdNNcZRqPvUVDp
 WBOp14WdSEjyPBUSz9iVCn8Hx/jFcG/Q17agDWt38h18PnOFM4juKNUKO40orU5KQec=
X-Gm-Gg: AeBDieuzWU6gw4xVAfVziwrRmlaSYS6zDTDiX+5rgVU6fvw1KY+YgN3vVWj2fy3ePyv
 6jRbdKLkUjAUxSl9NsCEpGocwvUsIKPwYmOGeQUwSswqeBeYluh4s2mmV7Ph6T7eGFQW9AH14qU
 Ra5k0IgZ8ISu3rI57caoX356jjqnhxbuwZJrSQWKJRcCZo6XdDR1/F6Lt37oeGEwvaECzW1DFbd
 ObVJxFmndAFXUFQ0wQgVZuXrmaq5epF/8suA2OmHkucUHRhRJ/r4PhdPoxLGbPJTbh7HMnam3a2
 6YEte3RmMDKE4353FeKnMWnc7JVQINIe0/QnYv3lKOBrWn94mOpI8Ujf2VKw00xfG1NF8YSMalf
 49B9GWujG9LZfZyJwT4KGlJY87HnN86W1+1a6vaNiNwvSu/jNHYx3ha0aoT1uvG2ozchlF4BRvP
 z+Im/X+G1VDSVg3yQbu3srqfuzXa72fmOQZI196Csnb8V/ONlJcVZl+LZavC2ObLo5LAM/IWLpN
 fBl2x8XzBYTiYjwhVGImBs9n1Ww0HwS2n1UnwjGl0JCvGnPRJgjiAQrK4ZroA==
X-Received: by 2002:a05:6830:2815:b0:7d7:419a:7ac8 with SMTP id
 46e09a7af769-7dc951c74cdmr12518807a34.15.1776783797627; 
 Tue, 21 Apr 2026 08:03:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcc892c515sm4495514a34.21.2026.04.21.08.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:03:16 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:03:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 venkatesh.abbarapu@amd.com, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/6] Add support for DT overlays handoff
Message-ID: <20260421150313.GA3036003@bill-the-cat>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <696b7f4d-e192-44e4-8652-e8db7f980507@gmail.com>
 <1a1f881c-bd6d-4677-af87-1c73bcac3dca@amd.com>
 <CAMDkj5z7xKkuSpnn45Uvcb0j68wqXt92eQu4FPCC2FARcQu4pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TlnXHEe/L+jl2gWt"
Content-Disposition: inline
In-Reply-To: <CAMDkj5z7xKkuSpnn45Uvcb0j68wqXt92eQu4FPCC2FARcQu4pw@mail.gmail.com>
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


--TlnXHEe/L+jl2gWt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 09:40:10AM -0400, Raymond Mao wrote:
> Hi Michal,
>=20
> On Mon, Apr 20, 2026 at 3:06=E2=80=AFAM Michal Simek <michal.simek@amd.co=
m> wrote:
> >
> > Hi,
> >
> > On 4/17/26 22:39, Raymond Mao wrote:
> > > Hi,
> > >
> > > The Firmware Handoff spec changes required for this series is already=
 accepted
> > > and merged at [1].
> > >
> > > Please review and merge this series.
> > >
> > > [1] Add Transfer Entry for Devicetree Overlay
> > > https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> > >
> >
> > Yes. We are using this series. Once retested we will provide our tags.
> >
> > Raymond: If there is a need for any change are you going to send another
> > version? Just asking to double check it.
> >
>=20
> No plan for another version unless I get more comments. I have rebased
> and tested this on upstream/next and looks all good.

Looks fine to me, I'll wait for some tested-by tags to show up before
applying.

--=20
Tom

--TlnXHEe/L+jl2gWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeeRrgAKCRAr4qD1Cr/k
CvguAP4o77RivMVQVJR2q0jbczqM7vZAj53b55ZIBudc4XLa8QEAuF5fcButINQK
Pl2WK+uXtC8KZXJf+FKTk3iJE55qvQU=
=0whs
-----END PGP SIGNATURE-----

--TlnXHEe/L+jl2gWt--
