Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5A0CE8E7A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF95C88F33;
	Thu, 24 Oct 2024 16:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LsVAcOcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01ABC88DFE; Thu, 24 Oct 2024 16:10:21 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C9C88E77
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b158542592so61374885a.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729779016; x=1730383816; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z+RHkPMjIWL9G+cO+eshkGNbTX4jSgtjVe3Sm+MtUF0=;
 b=LsVAcOcGWmFvyaICIx8of/9kU38zvIXDhIs4xkUuxvJYbFpz/qCeXT6nkKlT+azem9
 kWXjvNL2dL+9UFQMyJqLOU6bdaZpvEUq8K10aoQ3/KEIny09G/L7dD2/AWMH816K8anH
 cmCIDpHt2pVge5St/Pauun/K8Az+tqR5LZwEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729779016; x=1730383816;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+RHkPMjIWL9G+cO+eshkGNbTX4jSgtjVe3Sm+MtUF0=;
 b=XQwgP+U6ZMdXgVt1/ZfmRpi480rr96dNetlFQODsw555WJepRt0YrjVLmyi+frYOmS
 z6wQCbt1ZpUStz9R9YHSvcdh5s1ohpFxv7Z8+KexBa4kN6Yf3ruyv8sI0JmeDb4I1X+U
 1dCbf2htuEw90TMRc/kRm2j8iqYmaMN2GT5z5BTsmLhbPEllTFtGRU51PW5BmP5OVdJk
 mHwr8UAt2oAi3I4XzajAuenLjCLcoG0edqpnVGYtXUDc74USsu9oT28oJaXyYT0EZp3Y
 ycMW7ArKBxLn0/Ffd7/8gDFqg+HWOCZjFnudiiwDtB3Axdx5IqWYP4C4RQQa+oxLnmMK
 nZVw==
X-Gm-Message-State: AOJu0YyF4LASkewZeJfFXI+PFQUTfq5IwFvDYdJ5efhraZREzCGuMSgK
 T5keQ5VfeD3TuvdP+9XmOLWnFuJSTdmq1SDqNhqvzQB79FMhjUjzixS5uPGSmow=
X-Google-Smtp-Source: AGHT+IGLxjfszDeFDrFZkqwrCkNxW9DRvd+lBRVXcFT7dHp1j+K4HGSmeJHt6H35H5tZ9wwXV7anww==
X-Received: by 2002:a05:620a:1996:b0:7a9:c129:5da7 with SMTP id
 af79cd13be357-7b17e57a26amr754520685a.29.1729779015510; 
 Thu, 24 Oct 2024 07:10:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165903a99sm492181685a.0.2024.10.24.07.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:10:14 -0700 (PDT)
Date: Thu, 24 Oct 2024 08:10:10 -0600
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
Message-ID: <20241024141010.GQ4959@bill-the-cat>
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241024002255.GP4959@bill-the-cat>
 <CAEfUkUJYcBSET22QJAKzCd+q4GYXe6H9Xshpm_RiET57uzsE3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JpuhjuCHwNaGUhfb"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJYcBSET22QJAKzCd+q4GYXe6H9Xshpm_RiET57uzsE3Q@mail.gmail.com>
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


--JpuhjuCHwNaGUhfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 09:35:36AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 23 Oct 2024 at 20:23, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Oct 22, 2024 at 01:05:21PM -0700, Raymond Mao wrote:
> >
> > > Motivations for changes:
> > > Current SMBIOS library and command-line tool is not fully matching wi=
th
> > > the requirements:
> > > 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> > > 2. Only a few platforms support SMBIOS node from the device tree.
> > > 3. Values of some fields are hardcoded in the library other than fetc=
hing
> > >    from the device hardware.
> > > 4. Embedded data with dynamic length is not supported (E.g. Contained
> > >    Object Handles in Type #2 and Contained Elements in Type #3)
> > >
> > > Changes:
> > > 1. Refactor the SMBIOS library and command-line tool to better align =
with
> > >    the SMBIOS spec.
> > > 2. Create an arch-specific driver for all aarch64-based platforms to
> > fetch
> > >    SMBIOS private data from the device hardware (processor and cache).
> > > 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> > > 4. Add generic SMBIOS DTS file for arm64 platforms for those common
> > strings
> > >    and values which cannot be retrieved from the system registers.
> > >    Vendors can create their own SMBIOS node using this as an example.
> > >    For those boards without SMBIOS nodes, this DTS file can be includ=
ed
> > to
> > >    have a generic SMBIOS information of the system.
> > > 5. Add support for Type #7 (Cache Information) and link its handles to
> > >    Type #4.
> > >
> > > Once this patch is acceptted, subsequent patch sets will add other
> > missing
> > > types (#9, #16, #17, #19).
> > >
> > > Tests:
> > > To test this with QEMU arm64, please follow the guide on dt_qemu.rst =
to
> > > get a merged DT to run with.
> > > ```
> > > qemu-system-arm -machine virt -machine dumpdtb=3Dqemu.dtb
> > > cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v
> > /dts-v1/) \
> > >   | dtc - -o merged.dtb
> > > qemu-system-arm -machine virt -nographic -bios u-boot.bin -dtb merged=
=2Edtb
> > > ```
> > >
> > > Known issues:
> > > It hits the image size limitation on R-CAR board(rcar3_salvator-x).
> > > ```
> > > u-boot.img exceeds file size limit:
> > >   limit:  0x100000 bytes
> > >   actual: 0x10049d bytes
> > >   excess: 0x49d bytes
> > > ```
> > > This board needs a clean-up to reserve spaces for the changes as SMBI=
OS
> > > is a fundamental feature.
> > >
> > > Below is the breakdown of the size-growth of the related functions:
> > >   function                                   old     new   delta
> > >     static.smbios_write_type4                  252    1052    +800
> > >     static.smbios_write_type7                    -     764    +764
> > >     static.smbios_write_type3                  188     488    +300
> > >     smbios_get_val_si                            -     128    +128
> > >     static.smbios_write_type2                  316     376     +60
> > >     sysinfo_get_data                             -      56     +56
> > >     static.smbios_write_type1                  380     396     +16
> > >     smbios_write_funcs                         112     128     +16
> > >     ofnode_read_u32                              -      12     +12
> > >     sysinfo_rcar_ops                            40      48      +8
> > >     install_smbios_table                       468     472      +4
> >
> > Right, so here's the problem I see right now. About 70% of all U-Boot
> > platforms enable GENERATE_SMBIOS_TABLE and so "smbios: Refactor smbios
> > library" causes a growth of around 1.5 kilobytes. That's a problem.
> > There is a place where we're going to generate as full and complete a
> > table as we can, and a place where we just want maybe the basics. We
> > need to re-factor things first so that the platforms which aren't doing
> > detailed tables do not grow and perhaps even shrink because we can pull
> > existing code out.
> >
> Do you have a list of those platforms which don't need detailed tables?
> I can add a new kconfig for this in the next version.

No, you need to determine this, but it should be something that can be
determined by existing data. The platforms which grow by only 1.5KiB
don't. The ones that grow by ~4KiB, maybe? You need to see what they're
actually doing today to determine that. Growing by ~8KiB? Yes.

You can see my log at:
https://gist.github.com/trini/8d3d4ab5b53402059a9d178786033c18

And all of that is aside from my original worry about including a large
number of static strings. I did not look in to if v2 deals with that.

--=20
Tom

--JpuhjuCHwNaGUhfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcaVT4ACgkQFHw5/5Y0
tyxKswv9HV5Qkm3NNJ3oasEKeeQ142zRiivSvL80Wps3lfRJcvN2dCzhnfPfRf2X
MeybjuJkQ5Devd6pogAhyqNF0TCrDbaRMT/akVpJ/VoYrzC/uI4k4IDYdFVinX0w
lj3xCShlIudiX42vr7TaiWBYaox2JjuX2DXpL836YNd3y8k1IszJ3D2wtDhz/lTd
khA1IKHHwMOlfmwOrN//jrzhznAfl/oclY5ccGhRKLJshYsMwFMQTHqGWjKoMdIr
MMXd5uwhVjiW9jW40Idytph8g5+BWcVLJ7uPMkl3ZL/Gkj59oyXeL8Dgex2Z6RNK
Q/tBhxuolTql3NAjoESyRpJfflKC1uVTSdI98kR+6vb0183DU7emcU99zpGhRg8X
X8gMtzVrQUZo24uw9z0t49XcOr0Q0OTiNcC/jzQv+Pm07vEUF3XQwoR48Fa6XVTz
8WAr3Of+Sfky8NeYTDg1OutNzyXq7PXmSFcc1icylMgC/uZpJDQNDmmyDyICkHis
K7TFvPAn
=Pf0d
-----END PGP SIGNATURE-----

--JpuhjuCHwNaGUhfb--
