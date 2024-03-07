Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B21C54E4A
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 20:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D97987DA0;
	Thu,  7 Mar 2024 21:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RdtNMuOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC79A87D91; Thu,  7 Mar 2024 21:26:41 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9901B87D14
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 21:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6e4f7975121so80948a34.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709843196; x=1710447996; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fz7bxi84O2a9/C8DJHPLIVhfnlMyQBhHuzw2Qr8xCg0=;
 b=RdtNMuOQMc3SIdmi8FNNFPUhZBCqAaSTw+SYkFmwuKLBJBdukSRzCwIDTqC1XClgdy
 mW8vHGCYEkJhY3Be9Jadxc6mxtgFOtAWqL4e+eZ2Kbjlr6OvDHWd5eEgoGjt7pbc0TCl
 VQHDEoWKN6CNXHAZ3/xB7nNcT8y4rLSQ++eG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709843196; x=1710447996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fz7bxi84O2a9/C8DJHPLIVhfnlMyQBhHuzw2Qr8xCg0=;
 b=R/vRG20VVffk4PcYtWq17gIuumDOA7qQUzOnZYZNzsOXhMB3uDQDmV4KAzOp6M5VDU
 B6qksUyCXhQWlwtA2PgA3b5H6qCeAD76dae6nwWvIuGj0gJBLW+Sq8cjjsdnqyFD/ekn
 VsBH6yfmluULYri+tWUOwKRbgrQ/oz5i1UW0qcgKAewZFIaAn4zoyQH5QJvdopvvJkPj
 8wD5ffDP6MEjQMNP/JXHXZHnzFCCwP1bQc/01spyDoaM5k68xu7hNl5vkLxHD7KIiGZG
 P6ASeVig3DInxn/vjxvdDkMx0FpU4MXE9uuVIMAgq3w1cETHbNVxCJBfw86911mON6lQ
 aYzg==
X-Gm-Message-State: AOJu0YwqL6CXwMgMhkhyvvMX42fgPCPn/sVRqXxU1vxkO3SNVkWRmq4g
 nPMMnpyLsGYwoxqi5yuVefAkOaZht/HQmidegulnbVrWjyHCJvOCxeeNzcRXaWk=
X-Google-Smtp-Source: AGHT+IGdhELg30RUaHmbyLIny6x7YHTzkB9ROdxcIcShjl2/xwT63Z5iuvl4fWhaQVHXYSK+RTzCbw==
X-Received: by 2002:a05:6870:9712:b0:21f:e244:e356 with SMTP id
 n18-20020a056870971200b0021fe244e356mr1079871oaq.2.1709843196155; 
 Thu, 07 Mar 2024 12:26:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 pi36-20020a05620a37a400b00787c0e4ac78sm8053725qkn.106.2024.03.07.12.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 12:26:35 -0800 (PST)
Date: Thu, 7 Mar 2024 15:26:32 -0500
From: Tom Rini <trini@konsulko.com>
To: "Maxim M. Moskalets" <maximmosk4@gmail.com>
Cc: u-boot@lists.denx.de, Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH v4] cmd: add FDT setup for bootelf by flag
Message-ID: <20240307202632.GQ1523872@bill-the-cat>
References: <20240226183553.11615-1-Maxim.Moskalets@kaspersky.com>
 <20240307124126.GA4077069@bill-the-cat>
 <1fbcf398-ee89-49b3-b514-1c36b6ee04ec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9viE2avevv35tpzF"
Content-Disposition: inline
In-Reply-To: <1fbcf398-ee89-49b3-b514-1c36b6ee04ec@gmail.com>
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


--9viE2avevv35tpzF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 10:35:35PM +0300, Maxim M. Moskalets wrote:
> On 07.03.2024 15:41, Tom Rini wrote:
> > On Mon, Feb 26, 2024 at 09:35:53PM +0300, Maxim Moskalets wrote:
> >=20
> > > From: Maxim Moskalets <maximmosk4@gmail.com>
> > >=20
> > > Added the ability to use FDT for ELF applications, required to run so=
me
> > > OS. To make FDT setup, you need to set the -d fdt_addr_r cmd option f=
or
> > > bootelf command.
> > >=20
> > > Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
> > >=20
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > >   cmd/elf.c | 27 ++++++++++++++++++++++++---
> > >   1 file changed, 24 insertions(+), 3 deletions(-)
> > This breaks building on a number of platforms such as
> > xilinx_zynqmp_mini_nand_single.
> >=20
> There's an unresolved reference to LMB functions. This code compiles
> without a patch (i.e. it is not disabled by the preprocessor or externall=
y),
> but when linking, since this function is not called, it is discarded
> (you can check on a clean build with the command
> aarch64-linux-gnu-objdump -d u-boot | grep image_setup_libfdt).
> I think it's worth fixing this bug too.

Yes, you need to re-structure this patch so the existing configurations
still build.  You might need to guard some areas with
CONFIG_IS_ENABLED(...some existing symbol) before you call
image_setup_libfdt.

--=20
Tom

--9viE2avevv35tpzF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXqIvIACgkQFHw5/5Y0
tyy7fAv/Rwu+Tw3Tn36lwhFiM6Ro703oSrM9BAomAf6amNcrluAUh454MSsGGZ2V
PhRfjZiKQe2QJq34DOG34VgtbPp+lwei73czwfh73dAa+LwMUcRZuTGWdNUxQUwR
lS6UmZOm/BmEThgN3FsYP1dsG71ZMRXspxAVL4hM14LLvExAblBrTyXkyUJn/rCY
Y2orPYdc4hId+1Z5V6elDVgpPYPFpGyMDlwL0JRK6ekopoy45pO9UlltFN8+tCuD
ERu1zmPeZ3FTKmg4QEqxUdpKk5xUqeXwdOl+V64eOjdw4ySktt0eZjgl6h/2NfxI
gQcRlFd10VQPWBKQFyNGzN80L1BRfN0BhPtnx7V6a5EVZcaX9Ed8uHSzhD8HaA/G
2wHBOop2mjey+qPT9YvojnClLv4N42yNNWGSjmw7jFJ01HvMaQYHVrbJH4046n66
b6j/yYzfLXzImqLgZ+fZa8pCHwssv97NyWc/TBnmCzK08xQMNcuxmLGG05HaHI/z
YrAaF0CF
=o0l6
-----END PGP SIGNATURE-----

--9viE2avevv35tpzF--
