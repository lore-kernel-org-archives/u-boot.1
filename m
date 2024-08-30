Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEB4CA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF5388D50;
	Fri, 30 Aug 2024 03:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X0IUXPKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9664A88D5B; Fri, 30 Aug 2024 03:46:31 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4872C8826E
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a802deea39so90307085a.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724982388; x=1725587188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=376lpd8+/kOic3Dzscx6tOftL0aNE/Z7Upcpq/GcTyc=;
 b=X0IUXPKuVKDfh1M8GkRdd8kk4dcmGvNvMyarXJvsGDCIDWyl730gbSAqBC7XWWsVHD
 oCwFoHOZ34+k2G2ojqURx4N9NEL6mwhSSg3N38JZssry3geXMUx2MnJLzsUIl+1t6L2n
 rzFWgxwYSgclbmnrfREcwiJ3jmRSMxzOsKsEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724982388; x=1725587188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=376lpd8+/kOic3Dzscx6tOftL0aNE/Z7Upcpq/GcTyc=;
 b=qP/e2/71Ec4ZYFfRLF/OtmZFnlHVHqBLgSRf5KMX4oksE5HU+lKdi87iaXwFoQR8nI
 wHN8E+1Shq+QUYEnwMloZaXboATLLQUP05TR3Zkv4oEzaAkHcWY7vjS/rH6wXdCFoQkP
 6RVqwFHsfCyIyWQgM1qzqBP+QkkFj+sWcV7nt2pcbqsyxAMRs6c/jBiqenEOp+nwE36w
 6wgOCH2nlIEqbbQXiYH8dmLu3LrfuLP+JfZHOYM/HpKEMzguZeS3Aq02zpMcM2N+rrTK
 oWlEh6OaMODoFq1tnQw5UIV6Mbc+3d65HUs+LjqAQvcbeNwshOVzEhUhCI+LqzBlVcEU
 wVkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrzAQkselqzacPuMk0zCkdnOwjrkWjD0EGMWMel7LuREfRqlNPRXrgILcBUdHH36CBrR9G39U=@lists.denx.de
X-Gm-Message-State: AOJu0YxUCDmL5wA5apQt9JseuUIkxgHoLkhR1dFYAWyqH+CUu1LGS0wQ
 7KAhS7Zxn3rbSGYiknWHi2EGNTGkxOSX2hJYqmxioEWD3mcY7dO0+IzUwjBJNLI=
X-Google-Smtp-Source: AGHT+IGyKcR286UENuuKKyTV3FvZmcOZZseXEK6x9odumHZacgSnKg3gbLvjHzDEkXtD1tFu4uOrFA==
X-Received: by 2002:a05:620a:254e:b0:795:5995:fc89 with SMTP id
 af79cd13be357-7a8041ad0a1mr506119885a.18.1724982387929; 
 Thu, 29 Aug 2024 18:46:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806d3be38sm102003285a.79.2024.08.29.18.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 18:46:27 -0700 (PDT)
Date: Thu, 29 Aug 2024 19:46:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Roese <sr@denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 huang lin <hl@rock-chips.com>
Subject: Re: [PATCH 00/18] vbe: Series part D
Message-ID: <20240830014622.GQ2479150@bill-the-cat>
References: <20240828014538.3322013-1-sjg@chromium.org>
 <CALeDE9MX6MMECX+vNCjMs8Z2_G3+gSio4BxFHgez-H_a4f2Uyg@mail.gmail.com>
 <CAFLszTgrCGhvhO0GDSLABu1D10H97dBWFSnEf8gSJujq6iUduw@mail.gmail.com>
 <20240830004936.GP2479150@bill-the-cat>
 <CAFLszTjjni839jghOpforB-4+MnqRh7JXw575VtP_UO-SzfnKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QnR0bfpeb3MZ0pX8"
Content-Disposition: inline
In-Reply-To: <CAFLszTjjni839jghOpforB-4+MnqRh7JXw575VtP_UO-SzfnKg@mail.gmail.com>
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


--QnR0bfpeb3MZ0pX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 07:06:32PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 29 Aug 2024 at 18:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 28, 2024 at 04:16:55PM -0600, Simon Glass wrote:
> > > Hi Peter,
> > >
> > > On Wed, 28 Aug 2024 at 03:59, Peter Robinson <pbrobinson@gmail.com> w=
rote:
> > > >
> > > > Hi Simon,
> > > >
> > > > > This includes various patches towards implementing the VBE abrec
> > > >
> > > > What is abrec?
> > >
> > > It's a VBE method which supports A, B and recovery images and permits
> > > updating from SPL onwards. The idea is that you can safely update
> > > without bricking a device.
> > >
> > > >
> > > > > bootmeth in U-Boot.
> > > > >
> > > > >
> > > > > Simon Glass (18):
> > > > >   sandbox: Add missing header file
> > > > >   bootstd: Add stub for bootdev_setup_for_sibling_blk()
> > > > >   gzip: Correct function comment for gunzip()
> > > >
> > > > Is this from upstream gzip code somewher?
> > >
> > > I'm not sure, actually.
> > >
> > > >
> > > > >   fdtdec: Support separate BSS for all XPL builds
> > >
> > > Needed so that VPL can use DDT
> > >
> > > > >   tiny-printf: Correct return values
> > >
> > > I can't remember, sorry.
> > >
> > > > >   tpl: Support numbered aliases in device tree
> > >
> > > The MMC needs to be accessed using its sequence number
> > >
> > > > >   ram: Support driver model in TPL
> > >
> > > That should say VPL...but again I'm not quite sure
> > >
> > > > >   serial: Support debug UART in TPL
> > >
> > > This allows debugging of the jump from TPL to VPL
> > >
> > > > >   armv8: Support not having separate BSS
> > >
> > > VPL doesn't want a separate BSS since SDRAM isn't available that early
> > >
> > > > >   arm: cache: Drop a stale comment
> > >
> > > Just something I noticed
> > >
> > > > >   arm: Fix up a stale comment in sections.c
> > >
> > > Another thing I noticed
> > >
> > > > >   mmc: Support driver model in TPL
> > >
> > > TPL needs to read VPL from MMC
> > >
> > > > >   mmc: Add more debugging for SPL
> > > > >   mmc: Log the error when init fails
> > > > >   mmc: rockchip: Log some error returns
> > > > >   mmc: rockchip: Allow clocks to be missing
> > >
> > > These all help with debugging reading of VPL from the correct MMC dev=
ice
> > >
> > > > >   rockchip: mmc: Fix a missing colon
> > >
> > > Just something I noticed
> > >
> > > > >   rockchip: Provided SPL control over efuse presence
> > >
> > > We don't want this driver in TPL or VPL
> > >
> > > >
> > > > I'm not sure what most of these patches have to do with VBE?
> > >
> > > Basically there are a lot of little tweaks needed.
> >
> > Well, I think this gets back to some common feedback. You have a lot of
> > little bugfixes, which is good, but they get sprinkled in to the next
> > big series you post, which is bad and hard to review. And that leads to
> > fixes not getting merged / reviewed timely because nominally simple fix
> > A is in part 3 of a series to introduce something larger and to which
> > there is feedback to work through.
>=20
> I actually thought I was splitting them up quite nicely. What do you sugg=
est?

I would refer back to your own comments about what some of the patches
do and say that "Just something I noticed" should be a one off, and
little fixes for this-and-that should be a 1-2 part series and so on.

--=20
Tom

--QnR0bfpeb3MZ0pX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbRJGsACgkQFHw5/5Y0
tyzK2Av/YEuPc8gvF+74/pzhrmJnxKcf8A5romGqeqjTV1TlVRo6z83isiPjji8t
XalJMDom2lx/DjZkPMqQgoPkH113lk8z++I1vt2Gb2CJZ5mzWXHwwcNkGLHHYhaL
GVMuSnetrMjMINqn+b/D4ZSL94h4ECp/JERHQKAqr2DzfCr7dwZNg+2KhOcldktS
AU/hOKohn7HHFGjq0GUQxwGCfWzXi1hA9BvZrAQlLskvPw2Tn3/WYAEjLP/FEGcK
uzhPF6wDiGOZyIap/ufK4+aN2rgAlwiqau6E9icr9qXkb5YR/lhcRN+kC2kaEe7e
oXJ6FV2eNv2wwwY+YJmJIPYoM/tGBMufsGvksAb++OlABv2RRp85AQbfwB0nqYbj
QfPECWhbgCHEvSBXszJ9jL2jJWXu2tl46DOMzSJc0/fAc82eEm1fh00x91ZVof4c
PAKdHiN1yL3V11hG+uTWKLh5MYd7OG4fYqnHix3LLWvKtu5qJ+tuknAGcSdrbv3b
mF3ghrbD
=Dv9L
-----END PGP SIGNATURE-----

--QnR0bfpeb3MZ0pX8--
