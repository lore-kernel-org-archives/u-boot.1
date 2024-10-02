Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F20CF6D3C
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 15:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5124E892A5;
	Wed,  2 Oct 2024 17:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o8dzx3DO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C0D892BA; Wed,  2 Oct 2024 17:54:45 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEBAF89122
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 17:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a9ac2d50ffso109585a.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727884481; x=1728489281; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ub+PVmW5aKVLlpwmXC8Uo/qnHFoIoSL/8L8pApMZCvY=;
 b=o8dzx3DO9LTqAlkQ4LsRF8U5nAKbNfgJAU7t1hgP1Z1ZZUiyrT7aUX5JWlLBiZZbnl
 Lstc/1SYjSm0WzESW7iODhqsgqh4jWY9SWN4CjXSceZxYT15+aARC1WZfpp23fEuYmx5
 qupQTy9hMAaf8/Wph1maNPe4mIr9funBf3cgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727884481; x=1728489281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub+PVmW5aKVLlpwmXC8Uo/qnHFoIoSL/8L8pApMZCvY=;
 b=JGBJTKwNpLk+uYxLRBMkfD4IR8n+FNLh50jb+rt2CixHkij/9RVhA2QGo5YuMXuboH
 iKx4wqnqR+ZcjvpfDFtEkmbz0AoURFhMnsWZ5sEKnytYyuaug8ueb+iO/w7ggyUQ03RG
 MAUzj+CdigZ3H68rjI0aH/22ljiXx1d5PkH2G/ctF0dsRdVJK2NXvb9mGIw2jmscnOUc
 G3ExzsoOCaaBZr4S1+Y7rkP8pmdYFBqy3brlxrullBztRG243vdp5YkOnu1hu+YUHohX
 y+sX8vMFZAmf/GPU78U9EK1xPmT/VkrMoUyx4g3kvEt14Y6+GnBigEhaJH4wIOaaY1QQ
 5qQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW06uWL7i7CiIarvEGXXovSgb4Uzgr0M5sWc87ngQ44icS2g+V/FuWwyhnFwjGL59gaKReoWz8=@lists.denx.de
X-Gm-Message-State: AOJu0YwO/GNB6BI3fCgKJDQNYyHvgEJloD634PdD6N5DCXFosRkMyCfv
 MpDGNqspAameA/+NnX9r8ddAUOmsGE3G6KkT0AonwP2W0uyg6ok1RWqSyg+WCyA=
X-Google-Smtp-Source: AGHT+IHX+Ndeec5waD+WT4uO//BAKlRZBOhzFKWLyaIz4K0K0KbX4nNMU/kvvZU3UZhd1g8tVZ2IzA==
X-Received: by 2002:a05:620a:46a8:b0:7a9:b56a:3e09 with SMTP id
 af79cd13be357-7ae67e59f5amr16864885a.24.1727884481464; 
 Wed, 02 Oct 2024 08:54:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377ebd9fsm620649185a.56.2024.10.02.08.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 08:54:40 -0700 (PDT)
Date: Wed, 2 Oct 2024 09:54:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Alexander Dahl <ada@thorsis.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dario Binacchi <dariobin@libero.it>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 3/4] dm: core: migrate debug() messages to use dm_warn
Message-ID: <20241002155437.GP4737@bill-the-cat>
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
 <20241002-caption-saline-d00d342af087@thorsis.com>
 <cd12220e-a111-4576-87d1-e838f1c5998e@cherry.de>
 <b574fe29-3e3b-df51-6b09-af06303e11ac@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jA92Lynv49+3SW5r"
Content-Disposition: inline
In-Reply-To: <b574fe29-3e3b-df51-6b09-af06303e11ac@gmail.com>
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


--jA92Lynv49+3SW5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 11:13:14AM -0400, Sean Anderson wrote:
> On 10/2/24 05:25, Quentin Schulz wrote:
> > Hi Alexander,
> >=20
> > On 10/2/24 10:37 AM, Alexander Dahl wrote:
> > > Hello Quentin,
> > >=20
> > > sorry for being late to the party, but I just tested v2024.10-rc6 and
> > > my console output looks like this now:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-all: true
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_u32_array: ranges: ofnode_read_b=
ool: bootph-all: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-some-ram: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-pre-ram: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-pre-sram: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-pre-reloc: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-pre-proper: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-spl: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-tpl: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-vpl: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-all: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-some-ram: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-pre-ram: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-pre-sram: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-pre-reloc: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-pre-proper: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-spl: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-tpl: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: u-boot,dm-vpl: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-all: true
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_u32_array: ranges: ofnode_read_b=
ool: bootph-all: true
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_u32_array: ranges: ofnode_read_b=
ool: bootph-all: true
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-all: true
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ofnode_read_bool: bootph-all: false
> > > =C2=A0=C2=A0=C2=A0=C2=A0 =E2=80=A6
> > >=20
> > > This goes on for several screen pages, and clutters the usual output.
> > > I first thought I messed up CONFIG_LOGLEVEL or CONFIG_LOG, but no.
> > > All I had done was setting CONFIG_DM_WARN =E2=80=A6
> > >=20
> > > Am Tue, Jun 11, 2024 at 03:04:26PM +0200 schrieb Quentin Schulz:
> > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > >=20
> > > > Prior to that, seeing the debug() messages required to enable DM_DE=
BUG
> > > > which defines DEBUG (and then _DEBUG) which in turn makes failing
> > > > assert() calls reset U-Boot which isn't necessarily what is desired.
> > > >=20
> > > > Instead, let's migrate to dm_warn which is using log_debug when uns=
et or
> > > > log_warn when set.
> > > >=20
> > > > While at it, reword the DM_DEBUG symbol in Kconfig to explain what =
it
> > > > now actually does.
> > >=20
> > > CONFIG_DM_WARN currently reads like this:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 Enable this to see warnings related to drive=
r model.
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 Warnings may help with debugging, such as wh=
en expected devices do
> > > =C2=A0=C2=A0=C2=A0=C2=A0 not bind correctly. If the option is disable=
d, dm_warn() is compiled
> > > =C2=A0=C2=A0=C2=A0=C2=A0 out - it will do nothing when called.
> > >=20
> > > Instead of just useful warnings, users get debug messages all over the
> > > place now.=C2=A0 Is this actually intended behaviour?=C2=A0 Can this =
be fixed
> > > before v2024.10 release please?
> > >=20
> >=20
> > There are basically less than 3 working days left before v2024.10 is re=
leased and I'm inclined to say this is annoying rather than a bug, so I am =
not entirely sure this will 1) make it in time if we agree on a fix (needs =
to include review process in those 3 working days) 2) be acceptable for a l=
ate addition in the release cycle. Let's try though, maybe we can figure so=
mething out.
>=20
> This is a bug. Printing this many messages will have a major impact on bo=
ot times.
>=20
> A config going from "may print out a few more lines of extra info" to "fi=
rehose"
> is very surprising to users (as evidenced by Alexander's email).
>=20
> If you can't figure out which lines to disable, I recommend simply revert=
ing the
> patch.

Checking this myself too, no platforms enable this by default. So I
believe we do need to improve the situation here, but I don't think we
need to revert this for release.

--=20
Tom

--jA92Lynv49+3SW5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb9bLoACgkQFHw5/5Y0
tyz6vQv9GpW+N0sDn9VOMbN+Crf5BKrJDAOFEKD1sAmuc+W681JAfZVy4FFsP/6v
Pp1auX5sNsfazKzEpuw385mX24tUpJJBpxYDkX+Nv9OGRC2yKlEq0DBvtTk01ELn
9FqZC+SBXqKZRxnU5D/XZ4HDhveuJX5RO2tGtpMV7W6qovMIDI+unkwSD9cVjVWC
C9gSidIdEOEgdmMfjzoqj+//93d4/qgsCfDI/fNS6O0suygSrXeMwrq2oIblpbcg
WecuQQUyXYvqJhWW/libLqCP8EhytFeeYMwn4fOHlVR7Vw96QDDyRwxXJiEdZBUU
bfgqcpVr04L4c9rDgSEyiWpiCdFJbs7Mi2grvRs6vfTOxZPBBFSdcmbwv0TSU7iD
YBZWGfm5UL8lo70NmPCgmComrtVSVyjj1K0MCVkZaNR7k0ZxqJ41GQOBxUFbRIks
X0E4bjjeOHuhprMRV0WU755mEbP4vpYymUmOe+eax3HzLnFX6PF9oUv9rQON3S4o
NyRe07VK
=qZXh
-----END PGP SIGNATURE-----

--jA92Lynv49+3SW5r--
