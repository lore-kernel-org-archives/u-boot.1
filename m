Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655EFE77160
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 00:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B69A28966B;
	Wed,  4 Dec 2024 01:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ihFBlR9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E918966C; Wed,  4 Dec 2024 01:12:43 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B9C894FB
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 01:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-466879f84ccso43512411cf.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 16:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733271160; x=1733875960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXlpizFu0xLiL8SMknMwoEk47IVT5Ihs/L2QSiaBx+4=;
 b=ihFBlR9V9eFhC0GcDUC56MkSJIzZ4a+m/HAOglQJXJlBvNJFVzq8Wxvn+Jw/8/VFjN
 YRTjKWQV7u6sA9AjBsSDy6kgIC6BALvVxMAjpZFVWDz73BZNqFDk4362GT00ObIPkzmI
 Jdjm83N9s6uelb9IgWWm+iVlJQ8EjIX15AOhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733271160; x=1733875960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXlpizFu0xLiL8SMknMwoEk47IVT5Ihs/L2QSiaBx+4=;
 b=SK/57U7NUL0NvPB7CUerVBa7zMBbPfzDkFxCA+yE9nLf5OjhiQoDUsYwekxhu6/Ofn
 lbeYjBWHYG3TFy9qM3jHbFMOPPixjqZbdouSFIMQDVxM2jOW4m5TCY39x3OxwL57tlQ/
 EbvGc+B0mVJx8pev3jRXAtOPi/vfVx+6bmS72A0rge2Vzh1gt9Ygt+VdqnhhUcEPTVGr
 H5TSVd2Kfv8CcN5rTDJWUlkfYxIMo+PFd5pryBhvXs9Wf/Fz4upom8hfCDr9qhU25Yg1
 ZM8PQvv2rAraJtY+j4XWb89qaW7j/usBBHDZJD/XcnF6RFfoD7lauXqlo/AiESp3wNaO
 vv8A==
X-Gm-Message-State: AOJu0Yy5dP7u7xl0ZS/FJnbTiLQHIUk3S0476Gr5EQUl4i6sjQ/jtsEL
 d+ao9rxG+tpMRkcQFeZzPzEGYNUxyiTVWdkUrW9vqRTPggiGV8JWmt16OiyiI5A=
X-Gm-Gg: ASbGncs5DSWzvReW9//3yqmpB/HCTEGwZObmzqV8n90A8mAvswEogu5Ijwx2NG1isqH
 n+O5jH8YtU7X3it7YB6XtrwG1VwUwnzCTTkleSVr+r/JRZzVK5HP98VqXav4IKdeYBLB2lcWKIN
 dqD+pEDlQM35dc4ORR37rJLS02wXYs4beRYzP1IPQsY16IJ85t+0H7htdgvMJAXBskGsevEapGj
 vjE9EW/+Q5rTkotueYJDeCklCqL8DY2Y5opZ+p7459kKXBxOQ==
X-Google-Smtp-Source: AGHT+IEBsoBNC7rYvNAMNt2idaBiwpiwvml9nBg8HV7TjrPjcQRysAQJ9lfBTb0RdxN8Oj3Q9IThBQ==
X-Received: by 2002:a05:6214:f0a:b0:6d1:87f7:2924 with SMTP id
 6a1803df08f44-6d8b7431214mr76303606d6.47.1733271159590; 
 Tue, 03 Dec 2024 16:12:39 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d891919b43sm46876496d6.113.2024.12.03.16.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:12:38 -0800 (PST)
Date: Tue, 3 Dec 2024 18:12:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v2 00/41] pxe: Support read_all() for extlinux and PXE
Message-ID: <20241204001234.GC2457179@bill-the-cat>
References: <20241203234559.2938192-1-sjg@chromium.org>
 <CAFLszThuRngaW_kOTnEakDr6GSRc5TWpy7WT9yvQJmuMP2eUVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tfJh8EosjMNBhcRP"
Content-Disposition: inline
In-Reply-To: <CAFLszThuRngaW_kOTnEakDr6GSRc5TWpy7WT9yvQJmuMP2eUVw@mail.gmail.com>
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


--tfJh8EosjMNBhcRP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 05:03:26PM -0700, Simon Glass wrote:
> Hi,
>=20
> On Tue, 3 Dec 2024 at 16:46, Simon Glass <sjg@chromium.org> wrote:
> >
> > This series implements read_all() so that it is possible to read all the
> > files relating to a bootflow, make adjustments and then boot.
> >
> > Unfortunately quite a few things stand in the way, so this series
> > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > required support in pxe_utils and the differing code in the extlinux and
> > PXE bootmeths. There is very little new code, but quite a lot of
> > refactoring.
> >
> > The bootm, booti and bootz commands have all been refactored previously,
> > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > At the, time, zboot was left alone, since it is x86-specific and a bit
> > more trouble.
> >
> > This series adds a programatic API for zboot and uses the forthcoming
> > bootstd 'image list' to collect information from an extlinux file. It is
> > therefore possible to parse the file, load the resulting images and then
> > examine/adjust the resulting bootflow, before booting.
> >
> > The addition of options to extlinux resulted in the PXE and extlinux
> > bootmeth having slightly different features. This is tidied up in this
> > series, with common functions for both. This allows the same features
> > (loading images as a separate step) to be provided for PXE.
> >
> > Changes in v2:
> > - Split out strlcpy() change into new patch
> > - Move strlcpy() change into an earlier patch
> > - Fix 'initaddr' typo'
> > - Rebase on earlier change
> > - Add new patch to simplify the code reading fdtcontroladdr and fdt_addr
> >
> > Simon Glass (41):
> >   x86: Make do_zboot_states() static
> >   x86: Rename zboot_run() to zboot_run_args()
> >   x86: Drop duplicate definition of zimage_dump()
> >   x86: Move x86 zboot state into struct bootm_info
> >   x86: Rename state to bmi
> >   x86: Move the bootm state for zimage into cmd/
> >   bootstd: Correct display of kernel version
> >   x86: Drop the unnecessary base_ptr argument to zboot_dump()
> >   boot: Use strlcpy() in label_boot()
> >   boot: Split pxe label_boot() into two parts
> >   boot: Split pxe label_run_boot() into two parts
> >   boot: Pass just the FDT argument to label_process_fdt()
> >   bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
> >   boot: pxe: Use bootm_...() functions where possible
> >   pxe_utils: Simplify default fdt in label_run_boot()
> >   boot: pxe: Refactor label_run_boot() to avoid cmdline
> >   net: Keep the bootstage functions together
> >   net: Tidy up the comments to parse_args()
> >   net: Simplify parse_args()
> >   net: Return the load address from parse_args()
> >   net: Return the address and size from parse_addr_size()
> >   net: Return the size from parse_args()
> >   net: Refactor part of netboot_common() into a function
> >   net: Drop #ifdef in parse_args()
> >   net: Provide a function to run network operations
> >   boot: Avoid using the cmdline in bootmeth_pxe and pxe cmd
> >   pxe: Drop the cmdline parameter
> >   pxe: Record the bootflow in the PXE context
> >   pxe: Allow skipping the boot
> >   test: Update bootm test to restore silent_console
> >   bootmeth_extlinux: Move extlinux_info into plat
> >   bootmeth_extlinux: Move pxe_context into plat
> >   bootmeth: Refactor to put options in a common file
> >   bootmeth_pxe: Implement the fallback option
> >   bootmeth_pxe: Drop the driver-private data
> >   bootmeth_extlinux: Move boot code into common file
> >   bootstd: Update extlinux and pxe to allow boot interruption
> >   pxe: Collect the FDT in the bootflow
> >   pxe: Deal with a missing FDT in the bootflow
> >   pxe_utils: Refactor to separate reading from booting
> >   bootmeth_extlinux: Refactor extlinux to split boot
> >
> >  arch/x86/include/asm/zimage.h |  57 +---
> >  arch/x86/lib/zimage.c         | 102 ++++---
> >  boot/Makefile                 |   6 +-
> >  boot/bootm.c                  |   8 +-
> >  boot/bootmeth_cros.c          |   6 +-
> >  boot/bootmeth_extlinux.c      |  97 +------
> >  boot/bootmeth_pxe.c           |  48 ++--
> >  boot/ext_pxe_common.c         | 134 +++++++++
> >  boot/pxe_utils.c              | 507 +++++++++++++++++++++-------------
> >  cmd/bootflow.c                |   8 +-
> >  cmd/net.c                     |  92 +++---
> >  cmd/pxe.c                     |  30 +-
> >  cmd/sysboot.c                 |   4 +-
> >  cmd/x86/zboot.c               |  33 ++-
> >  include/bootm.h               |  63 ++++-
> >  include/bootmeth.h            |   8 +-
> >  include/extlinux.h            |  52 +++-
> >  include/net-common.h          |  30 ++
> >  include/pxe_utils.h           |  56 +++-
> >  net/net.c                     |  44 +++
> >  test/boot/bootflow.c          |  71 +++++
> >  test/boot/bootm.c             |   7 +
> >  22 files changed, 957 insertions(+), 506 deletions(-)
> >  create mode 100644 boot/ext_pxe_common.c
> >
> > --
> > 2.34.1
> >
>=20
> Unfortunately it seems there is a bug in here somewhere, in that it
> prepends the extlinux file's path to any files which are read, at
> least with pxe. So I am going to need to take another look...
>=20
> We don't have sandbox tests for this case, unfortunately. At some
> point we should try to add some.

Does the pxelinux test not catch the problem? If not, that would be
where to start expanding perhaps.

--=20
Tom

--tfJh8EosjMNBhcRP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPnm4ACgkQFHw5/5Y0
tyyWMgv8DJ/R3AQKahgHHO1hU4FAOhAOL7cDFCPV6cWB9p6sR5EzukDc6dGJyhj9
IGzM3bxzHjgz1eu5nxytrR8tzOyeHqh18p0oae/cBk+P32k403PjdJlO6eWgGd8F
bkLGDqFoWZPVo2tpGMdo9bGGAh0VHFYHD3EMvFYe9afCQb0ZqbWj7YF/mNs36UME
m4vMwsYSW2q9N358znmqRvxFxzTy0zbFaC5+1dbjTyQZ5tInCtQvk8tMY0HsAuIU
IZI4UnlXIh0yZK3YV38L0h9K5Vwu6tLUF29AjWINhg3Ojjo/yggesCF3C5ze4U3L
kiz2Gd49wfHghUuOE4R2+MedHeFbs/Q463ZjL1OAYdHnrDTrK2jXwYo7TP6uo7oA
deXIgDUXFSAZqYS9KuSIiQ0G8eJRUepHXxj+z7ZdsnlEgO6yGHKevsIVBkyXEhBY
pj2nLJuz27VDTFGwxRL5YSjm8PyLkJ7hWFgv3SfLdttGuIJvA9n78qSAM85EnLRm
VLDMVk0l
=k9h3
-----END PGP SIGNATURE-----

--tfJh8EosjMNBhcRP--
