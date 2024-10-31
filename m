Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780DDD767E5
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 16:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D9588F1B;
	Thu, 31 Oct 2024 17:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QH0mBgsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E39CA89177; Thu, 31 Oct 2024 17:54:01 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BAB888E5C
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 17:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b1505ef7e3so76248285a.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730393638; x=1730998438; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uuMFLayBMoIpZDEOcK0Ouoi/rqdMY4cTLJ2KNWxzs8A=;
 b=QH0mBgsOr+Y15tlXeOFovJJsmmtQpXiKS4Ae78FJMDO9+T/D9fAOZsInAuR6FgBAC9
 Kpu2uNVZxV47EGijnZv1vF5t7yXdaFq1quhmA/edcgsuELUP3XaOO1IwaG3UeLXkhbSj
 GTXfPKC13l2+sgglJkWUWgXyE07/bJi5WcyA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730393638; x=1730998438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuMFLayBMoIpZDEOcK0Ouoi/rqdMY4cTLJ2KNWxzs8A=;
 b=OTO8gQ5i4qCUHDpK6u/6MN6buQJQ0ttWAAytccklGVpge4EaYqt3S8KmCnzsafgyJS
 hfzWHFh/d8w0wDkzcrCg7kSsjddGTSlcn03m1cZUKIrilQ092S7AnojMwh0LQsp3VyD1
 6SjmEvfTsu1FrB38lUiMBBw/CWadptPJPNC+/Lenf+Momb5adf4vjqZGQ0z2eOQueAf+
 VEFpPHLJDHyNzu0oznhjbtgyIpAz87+azmLpmUiHG5H5sbU2vIZ6jXiirDUNkzS2C946
 0jRACekl8kOd7sA0cgDb7rPyMjHW2UOfq6ETU82AUd/P9Wws+fiVUeYkYSpAzyWIY796
 h0IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVenHXE7ZbuieetEfJYsD91qD7jJlYLu2kDIhbqgIl/ipYQ3xQF4j98ihnxOLaZbyWDRd9979M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1YhhT+TgCh9yvOnWIoV1Ot8N2Ka8g4XLwzmE+xYIYlMkAl4Cv
 YNaGBC/KKsncyj7EdDPrKtvfAlHAbtKPMToIumo4ZgFgnQwNbVpTQPm6HFQ0uYw=
X-Google-Smtp-Source: AGHT+IHL1nkBq6X7Z4hOlzfomBOpmtfLZeqL8BNxx/lFisZojBus/CoAqCNxVaD2Og8ok4MOg3f3Kw==
X-Received: by 2002:a05:620a:4613:b0:7b1:1cc2:8238 with SMTP id
 af79cd13be357-7b193f045admr3203486585a.39.1730393637979; 
 Thu, 31 Oct 2024 09:53:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39fb99csm85658485a.36.2024.10.31.09.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 09:53:57 -0700 (PDT)
Date: Thu, 31 Oct 2024 10:53:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
Message-ID: <20241031165353.GS2558755@bill-the-cat>
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
 <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
 <19fc4486-f8fe-4286-8941-76ff2a81b7d9@linaro.org>
 <CAMty3ZAJrKvUAxWg9CfKtyrjw+WnHOgwkfAJb+N-7d3NyXUrxA@mail.gmail.com>
 <f797cb27-84ca-41c3-83a5-b9044f2d5e5c@linaro.org>
 <3835b139-ae37-423e-8a24-a958ece69c0d@amd.com>
 <20241030165618.GP2558755@bill-the-cat>
 <37c64d4a-1d5b-4f5e-bf2d-6e2a8b6b7669@linaro.org>
 <997b584a-8065-48dd-9bbf-d56dbcb18626@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jteHIgrYFMJyfPQ1"
Content-Disposition: inline
In-Reply-To: <997b584a-8065-48dd-9bbf-d56dbcb18626@mailbox.org>
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


--jteHIgrYFMJyfPQ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 02:39:14PM +0100, Marek Vasut wrote:
> On 10/31/24 8:10 AM, Tudor Ambarus wrote:
> >=20
> >=20
> > On 10/30/24 4:56 PM, Tom Rini wrote:
> > > On Wed, Oct 30, 2024 at 04:20:32PM +0100, Michal Simek wrote:
> > > >=20
> > > >=20
> > > > On 10/30/24 15:49, Tudor Ambarus wrote:
> > > > >=20
> > > > >=20
> > > > > On 10/30/24 2:17 PM, Jagan Teki wrote:
> > > > > > On Wed, Oct 30, 2024 at 4:15=E2=80=AFPM Tudor Ambarus <tudor.am=
barus@linaro.org> wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 10/30/24 10:33 AM, Jagan Teki wrote:
> > > > > > > > Hi Marek,
> > > > > > > >=20
> > > > > > > > On Sun, Oct 27, 2024 at 1:48=E2=80=AFAM Marek Vasut
> > > > > > > > <marek.vasut+renesas@mailbox.org> wrote:
> > > > > > > > >=20
> > > > > > > > > Remove undocumented nor->addr_width =3D=3D 3 test. This w=
as added in commit
> > > > > > > > > 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked mem=
ories support")
> > > > > > > > > without any explanation in the commit message. Remove it.
> > > > > > > > >=20
> > > > > > > > > This also has a bad side-effect which breaks READ operati=
on of every SPI NOR
> > > > > > > > > which does not use addr_width =3D=3D 3, e.g. s25fs512s do=
es not work at all. This
> > > > > > > > > is because if addr_width !=3D 3, rem_bank_len is always 0=
, and if rem_bank_len
> > > > > > > > > is 0, then read_len is 0 and if read_len is 0, then the s=
pi_nor_read() returns
> > > > > > > > > -EIO.
> > > > > > > > >=20
> > > > > > > > > Basic reproducer is as follows:
> > > > > > > > > "
> > > > > > > > > =3D> sf probe ; sf read 0x50000000 0 0x10000
> > > > > > > > > SF: Detected s25fs512s with page size 256 Bytes, erase si=
ze 256 KiB, total 64 MiB
> > > > > > > > > device 0 offset 0x0, size 0x10000
> > > > > > > > > SF: 65536 bytes @ 0x0 Read: ERROR -5
> > > > > > > > > "
> > > > > > > > >=20
> > > > > > > > > Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stac=
ked memories support")
> > > > > > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.o=
rg>
> > > > > > > > > ---
> > > > > > > > > Cc: Andre Przywara <andre.przywara@arm.com>
> > > > > > > > > Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > > > > > > > > Cc: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > > > Cc: Michael Walle <mwalle@kernel.org>
> > > > > > > > > Cc: Michal Simek <michal.simek@amd.com>
> > > > > > > > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > > > > > > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > > > > > > > Cc: Pratyush Yadav <p.yadav@ti.com>
> > > > > > > > > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > > > > > Cc: Sean Anderson <seanga2@gmail.com>
> > > > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > > > Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> > > > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > > > Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> > > > > > > > > Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > > > > > > > > Cc: u-boot@lists.denx.de
> > > > > > > > > Cc: uboot-stm32@st-md-mailman.stormreply.com
> > > > > > > > > ---
> > > > > > > >=20
> > > > > > > > Is this patch-set next version for 'previous' reverted seri=
es?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > my 2c: I think I lean towards reverting the stacked/parallel =
support.
> > > > > > > The only one that benefits of is AMD, while affecting the cor=
e code
> > > > > > > quality. It also slows down further contributions and I assum=
e it
> > > > > > > hardens maintainer's job.
> > > > > >=20
> > > > > > I did try this before and it is hard to separate from the core.=
 and at
> > > > > > the same time it is hard to maintain the core too.
> > > > > >=20
> > > > > > >=20
> > > > > > > Even if I (we?) haven't made my mind on how to best implement=
 this, it's
> > > > > > > clear that it shall be above SPI NOR without affecting curren=
t devices.
> > > > > > >=20
> > > > > > > Not sure if it's fine to revert everything, haven't followed =
u-boot
> > > > > > > lately, your choice to make.
> > > > > >=20
> > > > > > If we find a way (not sure if it's possible) separate like a wr=
apper
> > > > > > or fix the things without revert - these are two points I can s=
ee as
> > > > > > of now.
> > > > > >=20
> > > > >=20
> > > > > Then this set shall help move in this direction. Some involvement=
 from
> > > > > the stacked/parallel authors would be nice here, and some commitm=
ent
> > > > > that the current status in just a temporary situation.
> > > >=20
> > > > I hope that by authors you mean SW owners not really HW authors of =
this wiring.
> > > > Jagan is aware that we are using this configuration for quite a lon=
g time
> > > > and we are still here and not leaving.
> > > > As you know Amit is trying to find a solution in Linux but nothing =
has been
> > > > agreed yet. If there is agreement to separate it to own driver or s=
o we will
> > > > be definitely working with u-boot to get it to the same state.
> > > >=20
> > > > This patchset is using the latest approved DT binding created by Mi=
quel and
> > > > if new binding is accepted we will be working to align to it.
> > > > Also intention is to bring this functionality to customers and not =
break
> > > > others. That's why these patches are pulled into rc1 to get better =
test
> > > > coverage.
> > > >=20
> > > > And to be fair to say version which has been merged was v14 and any=
body
> > > > could comment it before and we are definitely here to help to resol=
ve issues
> > > > on other boards caused by this patchset. But we need to have help f=
rom
> > > > others because obviously we don't have other boards and they are li=
kely also
> > > > not wired in CI.
> > >=20
> > > To be clear, we need to resolve the problems that have shown up now on
> > > all of the hardware that was working in v2024.10. My current inclinat=
ion
> > > is to merge
> > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D429932&stat=
e=3D*
> > > (aka this series in question) ASAP.
> > >=20
> >=20
> > We can surely live with this temporary situation. Now that we're assured
> > to have AMD's help in moving forward, it feels less like a transfer of
> > responsibility on the poorly designed stacked/parallel software support.
> > Fine by me to choose the smaller fixes/improvements over the full rever=
t.
> Considering how many unexplained subtle broken changes even the first com=
mit
> of the stacked/parallel series included, I would be banking toward a full
> revert. The hints on which changes were unexplained are in this series.

I'm going to start with this series. If there's still unaddressable
problems, now that we have more eyes on everything, it's not overly hard
to revert this series merge and then the initial series merge.

--=20
Tom

--jteHIgrYFMJyfPQ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjthYACgkQFHw5/5Y0
tyzwGwv8Ca5lYFGGkeMHjZGCH3wAGUwDM2rEaJy/EaJd8OjswvtgJO9iCzCLslN+
MCXqeEoyQBtut3uXdaWqLs6dQGlp9Vrn/jrCeVYpBjo2DvQym7EK1HbPiFkCB21E
fre/Kok1q2rbggRtysgrqIfly1TDjpgAMOS17WxC+yiQurjP6pb3sAgDay1g4epZ
iC/WY0myO4CrEVVk+uqz64Orwbow1+POozz6gkRmjXU1QHEVicQ3d8WUY4sABXJZ
4Pc9CasmP64fWMRpsbUMyQBPF2+wUZOEHCb1+/4Q/FoiaFHuWFpQ8gUfx8F+NENh
bZCCPtH18an/XCYWNKjgosbRWk9B+LLeLZliRcU1CuOC2DMhQFwGG4s2T9QE5yXO
G7uiBRjr+UAn8QFthVv/Ub8Dir9v4yjm22tCEdIhEjdamKDx7SU//Xqa15tnVas4
wKiAiFXArk3PCpG5Qk/FPPhZiQ7ZObXCx0YX8PpQTaKvQC51QJEBlFM6w6Sc3rbZ
0J/JdkjN
=MHCh
-----END PGP SIGNATURE-----

--jteHIgrYFMJyfPQ1--
