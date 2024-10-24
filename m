Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A20CE8E8B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80F788F48;
	Thu, 24 Oct 2024 17:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cG6fRaFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A318E88DFE; Thu, 24 Oct 2024 17:20:44 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76B588F33
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cc250bbc9eso6514436d6.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729783232; x=1730388032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/dws4XKnxjN+dSaCGx41zWSGaRkF3/vg7UhB6DSTa9k=;
 b=cG6fRaFWW3EkRD6ok5WBoBsBXZdot3FhvrGRAOiuh6hUlG+vyvs80njqnY+Ht68JRs
 YEnp/tvO0QHXIAsMDQyTJNiCknE29/IlfqNSDjOtZoacK7STWmHsAaawKKcK6ODtG3vn
 YVRI+Q6GD4hG8ckO9F1e/qMnrDyvhP1OZScGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729783232; x=1730388032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dws4XKnxjN+dSaCGx41zWSGaRkF3/vg7UhB6DSTa9k=;
 b=WKiVKN8qRNBbZrlkC/3s7PNIn7F4HXWXze/V1xNM0JV522w4Xq5VL+IqExerutJH99
 HTzKhhpS+dTvbCXyb8XE6fZZSllsH+wXUuq34oiIAfUOrj9KW5ECm6okFiX98djMIrKx
 h7eYKR89HmQmhTRUvKyMt3KL6Xe00OZ+a4/MaMac2BZG0rl1aNbXg6Hryxyatfes0vTF
 vcMtkvIvgwplZLwI/WRda8NLI2CiCQGJSDyqtOl2rAJeosZiVaBihTQLG9AKeyEv7HV4
 7FSc0Vdre8lknM3BwFl2SM6bJd/TDzBSizs7zswfCLGsWuLIykOjD9k9UKxkKQjSMHXc
 MnKg==
X-Gm-Message-State: AOJu0YwYvBXmtFaZiO7nGZJEJo4wVF8JnILdWd5/nXLslX5q5ZMSRFKo
 dj04WNTa8z2TOj6NaMQu+RIhikFofLKCpPy5jAUNAMz+a9Fv4GtgpeZk/zo2bcM=
X-Google-Smtp-Source: AGHT+IEj449uYXyU7i4yEUsXQVQtgXUerBvMd5hVXJSC69N00XCeuVT3Iz8B9NYivFQkMqH0WX+zvg==
X-Received: by 2002:a05:6214:5f09:b0:6cb:2565:3f5f with SMTP id
 6a1803df08f44-6ce342caa46mr5004976d6.51.1729783232435; 
 Thu, 24 Oct 2024 08:20:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009ffeebsm51040796d6.138.2024.10.24.08.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 08:20:31 -0700 (PDT)
Date: Thu, 24 Oct 2024 09:20:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, iwamatsu@nigauri.org,
 marek.vasut+renesas@mailbox.org,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 0/8] SMBIOS improvements
Message-ID: <20241024152027.GT4959@bill-the-cat>
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241024002255.GP4959@bill-the-cat>
 <CAEfUkUJYcBSET22QJAKzCd+q4GYXe6H9Xshpm_RiET57uzsE3Q@mail.gmail.com>
 <20241024141010.GQ4959@bill-the-cat>
 <CAEfUkU+2yxeH2+27We-_qEb1jY5_59oPsK-6tCcyqMwQV+1-UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+3kzfSBd8/hcCOrB"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+2yxeH2+27We-_qEb1jY5_59oPsK-6tCcyqMwQV+1-UQ@mail.gmail.com>
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


--+3kzfSBd8/hcCOrB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 10:19:41AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, 24 Oct 2024 at 10:10, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, Oct 24, 2024 at 09:35:36AM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Wed, 23 Oct 2024 at 20:23, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Tue, Oct 22, 2024 at 01:05:21PM -0700, Raymond Mao wrote:
> > > >
> > > > > Motivations for changes:
> > > > > Current SMBIOS library and command-line tool is not fully matching
> > with
> > > > > the requirements:
> > > > > 1. Missing support for other mandatory types (#7, #9, #16, #17, #=
19).
> > > > > 2. Only a few platforms support SMBIOS node from the device tree.
> > > > > 3. Values of some fields are hardcoded in the library other than
> > fetching
> > > > >    from the device hardware.
> > > > > 4. Embedded data with dynamic length is not supported (E.g. Conta=
ined
> > > > >    Object Handles in Type #2 and Contained Elements in Type #3)
> > > > >
> > > > > Changes:
> > > > > 1. Refactor the SMBIOS library and command-line tool to better al=
ign
> > with
> > > > >    the SMBIOS spec.
> > > > > 2. Create an arch-specific driver for all aarch64-based platforms=
 to
> > > > fetch
> > > > >    SMBIOS private data from the device hardware (processor and
> > cache).
> > > > > 3. Create a sysinfo driver to poppulate platform SMBIOS private d=
ata.
> > > > > 4. Add generic SMBIOS DTS file for arm64 platforms for those comm=
on
> > > > strings
> > > > >    and values which cannot be retrieved from the system registers.
> > > > >    Vendors can create their own SMBIOS node using this as an exam=
ple.
> > > > >    For those boards without SMBIOS nodes, this DTS file can be
> > included
> > > > to
> > > > >    have a generic SMBIOS information of the system.
> > > > > 5. Add support for Type #7 (Cache Information) and link its handl=
es
> > to
> > > > >    Type #4.
> > > > >
> > > > > Once this patch is acceptted, subsequent patch sets will add other
> > > > missing
> > > > > types (#9, #16, #17, #19).
> > > > >
> > > > > Tests:
> > > > > To test this with QEMU arm64, please follow the guide on dt_qemu.=
rst
> > to
> > > > > get a merged DT to run with.
> > > > > ```
> > > > > qemu-system-arm -machine virt -machine dumpdtb=3Dqemu.dtb
> > > > > cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v
> > > > /dts-v1/) \
> > > > >   | dtc - -o merged.dtb
> > > > > qemu-system-arm -machine virt -nographic -bios u-boot.bin -dtb
> > merged.dtb
> > > > > ```
> > > > >
> > > > > Known issues:
> > > > > It hits the image size limitation on R-CAR board(rcar3_salvator-x=
).
> > > > > ```
> > > > > u-boot.img exceeds file size limit:
> > > > >   limit:  0x100000 bytes
> > > > >   actual: 0x10049d bytes
> > > > >   excess: 0x49d bytes
> > > > > ```
> > > > > This board needs a clean-up to reserve spaces for the changes as
> > SMBIOS
> > > > > is a fundamental feature.
> > > > >
> > > > > Below is the breakdown of the size-growth of the related function=
s:
> > > > >   function                                   old     new   delta
> > > > >     static.smbios_write_type4                  252    1052    +800
> > > > >     static.smbios_write_type7                    -     764    +764
> > > > >     static.smbios_write_type3                  188     488    +300
> > > > >     smbios_get_val_si                            -     128    +128
> > > > >     static.smbios_write_type2                  316     376     +60
> > > > >     sysinfo_get_data                             -      56     +56
> > > > >     static.smbios_write_type1                  380     396     +16
> > > > >     smbios_write_funcs                         112     128     +16
> > > > >     ofnode_read_u32                              -      12     +12
> > > > >     sysinfo_rcar_ops                            40      48      +8
> > > > >     install_smbios_table                       468     472      +4
> > > >
> > > > Right, so here's the problem I see right now. About 70% of all U-Bo=
ot
> > > > platforms enable GENERATE_SMBIOS_TABLE and so "smbios: Refactor smb=
ios
> > > > library" causes a growth of around 1.5 kilobytes. That's a problem.
> > > > There is a place where we're going to generate as full and complete=
 a
> > > > table as we can, and a place where we just want maybe the basics. We
> > > > need to re-factor things first so that the platforms which aren't d=
oing
> > > > detailed tables do not grow and perhaps even shrink because we can =
pull
> > > > existing code out.
> > > >
> > > Do you have a list of those platforms which don't need detailed table=
s?
> > > I can add a new kconfig for this in the next version.
> >
> > No, you need to determine this, but it should be something that can be
> > determined by existing data. The platforms which grow by only 1.5KiB
> > don't. The ones that grow by ~4KiB, maybe? You need to see what they're
> > actually doing today to determine that. Growing by ~8KiB? Yes.
> >
> > You can see my log at:
> > https://gist.github.com/trini/8d3d4ab5b53402059a9d178786033c18
> >
> > And all of that is aside from my original worry about including a large
> > number of static strings. I did not look in to if v2 deals with that.
> >
> Yes, v2 has moved all the common strings and values to a generic dtsi
> so that it can be included if any platforms are interested other than
> qemu_arm64.
> I will look into the log you provided.

Well, that's better, but not great if it's still including all of the
strings. But we can circle back to that because this other issue is more
important to figure out first, thanks.

--=20
Tom

--+3kzfSBd8/hcCOrB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcaZbsACgkQFHw5/5Y0
tyyCGgwArtnjnxaNffIekn3jq8SeFfX8y8ySiYJc4dR1hRJktb8xJZfjMwtG3M6/
Lw2wZm7IEWaTQNVD6t/DCcfU2aKgouvIKJqt5EgSyTP8ehe8O4k8TmWPaL8T7d6Z
W60pLhAZnRjuXiNQpXaWaAuIFlfTkQeOLAw0Yxc3+o5uvZyv947pih1uvwq4dH6E
iJ6OXHeZMPopv+7Y7SCt+S+wDxS/n/lpBBWLJBEyf63bv1YMqI6a03XO6vzPnnc8
5Hsy8NUtkfSMafTcIQQRMBk+aUri57nCrWPgvqTmCSEMCBRs8CHuPFbufE93O2Mu
A1r9QnetvqXGTKi3GEDzPA6Qf6MazFqt2Q18zVPxIAZsjFP7jJQauP0TY1+41lyb
3CQSFPJb9nIA9/cGBKGasBgoYdAEINb7pf+CUsuJXjivUDkLEEmRKm4jPmZT7/4l
xoOi7VqstUaCJVSL9fAeGjnXyApzIeXWNKl+n2hxg/6ycD8llbkavH0nB9XZN+9r
hLKp0Q5O
=R8sP
-----END PGP SIGNATURE-----

--+3kzfSBd8/hcCOrB--
