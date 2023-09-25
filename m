Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54826CE79A1
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 20:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B795686D41;
	Mon, 25 Sep 2023 22:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bIODUXN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7256486D46; Mon, 25 Sep 2023 22:36:13 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D41986D2D
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 22:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a1d0fee86aso17508537b3.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695674170; x=1696278970; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3UjlgJGr+1HQliPcQzTEVjRKl0o/1zkn5yGO7UURx/0=;
 b=bIODUXN/OMrhbqTyWfH37ArozDyJlSSa0xIp880O3OlXROF47PvCE1zlw5nqdTBRAb
 /IHbDAR4Ib/KojfmN3RsZXepzK1xmoC15YGtCejUxDRffYd9uw/yDRBEvUw10Pt6axcW
 0YW6M194A4yQOCnTF0PukhOPNS1Bo2PX2luqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695674170; x=1696278970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UjlgJGr+1HQliPcQzTEVjRKl0o/1zkn5yGO7UURx/0=;
 b=k1nHcVnnm/qPiuh1mGRN+m5StfIH0ZcXQTtQbMHDLrxWdA86TlqgpFHtYWP776Cn7f
 ktHkzE+vTGWhms9aXGJcgw9sW/YrJ2Tl8X4uyybo8HgYWRe1QP6F7eMY59t4mwSvi/LW
 dxAHVcTQmGYu/7ogot4OVzIiG3Swqf2lwGdrQHIw+M1uklCPHO30O9wPWU3zTvPlD2JM
 3bikKtr9vJdwS56icRSdEROjGCX1W8agqdpwVTPGEfOBb58JuEaldpVnZqKs4kbtQVu6
 kqZftlR4h2MhXMPgGLYwOQ5npTbV3miTS7xniShTK4351pu5hSB2mdEpWfXl1+JbbY5z
 Stiw==
X-Gm-Message-State: AOJu0YzFPZgZROw+WhmKkEO5dLnZ7kIXquCx/Dd8a7muDHhzclsftgp+
 c1saFkpYYJiiN/ny+t0mVH1y0A==
X-Google-Smtp-Source: AGHT+IG74VXge1noYQGLDTd2kcEnIn6AKC9u/lhHaHLGLEA0po9MqxnIaeUFS/ZncmqzixEVEV09fA==
X-Received: by 2002:a81:6fc3:0:b0:586:a689:d28a with SMTP id
 k186-20020a816fc3000000b00586a689d28amr7934686ywc.34.1695674169920; 
 Mon, 25 Sep 2023 13:36:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a080-e51b-f064-cf67.res6.spectrum.com.
 [2603:6081:7b00:6400:a080:e51b:f064:cf67])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a81bb47000000b0057a44e20fb8sm2561528ywl.73.2023.09.25.13.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 13:36:09 -0700 (PDT)
Date: Mon, 25 Sep 2023 16:36:07 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 00/38] spl: Preparation for Universal Payload
Message-ID: <20230925203607.GQ305624@bill-the-cat>
References: <20230924192536.1812799-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WzNnRCDHc+QWh0BO"
Content-Disposition: inline
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
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


--WzNnRCDHc+QWh0BO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 01:24:45PM -0600, Simon Glass wrote:

> This series tidies up SPL a little and adds some core ofnode functions
> needed to support Universal Payload. It also includes a few minor fix-ups
> for sandbox.
>=20
> For SPL the changes include CONFIG naming, removing various #ifdefs and
> tidying up the FIT code.
>=20
> One notable piece of the ofnode improvements is support for flattening
> a livetree. This should be useful in future as we move FDT fixups to use
> the ofnode API.
>=20
> Changes in v3:
> - Mention testing on qemu-ppce500
> - Add new patch to create a proper symbol for enabling the malloc() pool
> - Add new patch to enable CONFIG_SPL_SYS_MALLOC_F where needed
> - Add new patch to nable CONFIG_TPL_SYS_MALLOC_F where needed
> - Add new patch to use SYS_MALLOC_F instead of SYS_MALLOC_F_LEN
> - Add new patch to tidy up uses of CONFIG_SYS_MALLOC_F_LEN
> - Add new patch to clean up SYS_MALLOC_SIMPLE documentation
> - Add new patch to correct help in TPL_DM and VPL_DM
> - Rebase on the new patch
>=20
> Changes in v2:
> - Rename based on Tom's feedback
> - Improve readability by moving the size part to the header file
> - Explicitly copy two maintainers as it seems only Mario was auto-cc'd
> - Change the approach to use the header file
> - Use the same condition for both pieces to avoid possible problems
> - No changes as it still seems unclear what should be done
>=20
> Simon Glass (38):
>   spl: Use CONFIG_SPL... instead of CONFIG_..._SPL_...
>   spl: Rename SYS_SPL_ARGS_ADDR to SPL_PAYLOAD_ARGS_ADDR
>   spl: Avoid #ifdef with CONFIG_SPL_SYS_MALLOC
>   spl: mx6: powerpc: Drop the condition on timer_init()
>   spl: Drop #ifdefs for BOARD_INIT and watchdog
>   spl: Avoid #ifdef with CONFIG_SPL_PAYLOAD_ARGS_ADDR
>   spl: Drop the switch() statement for OS selection
>   spl: Create proper symbols for enabling the malloc() pool
>   spl: Enable CONFIG_SPL_SYS_MALLOC_F where needed
>   tpl: Enable CONFIG_TPL_SYS_MALLOC_F where needed
>   spl: Use SYS_MALLOC_F instead of SYS_MALLOC_F_LEN
>   Tidy up uses of CONFIG_SYS_MALLOC_F_LEN
>   doc: Clean up SYS_MALLOC_SIMPLE
>   dm: core: Correct help in TPL_DM and VPL_DM
>   spl: Avoid an #ifdef when printing gd->malloc_ptr
>   spl: Remove #ifdefs with BOOTSTAGE
>   spl: Rename spl_load_fit_image() to load_simple_fit()
>   spl: Move the full FIT code to spl_fit.c
>   spl: Use the correct FIT_..._PROP constants
>   spl: Move bloblist writing until the image is known
>   dm: core: Reverse the argument order in ofnode_copy_props()
>   dm: core: Ensure we run flattree tests on ofnode
>   dm: core: Tidy up comments in the ofnode tests
>   dm: core: Add a function to create an empty tree
>   dm: core: Add a way to copy a node
>   dm: core: Add a way to delete a node
>   dm: core: Add a way to convert a devicetree to a dtb
>   dm: core: Support writing a boolean
>   dm: core: Support writing a 64-bit value
>   dm: core: Add tests for oftree_path()
>   sandbox: Move reading the RAM buffer into a better place
>   sandbox: Init the EC properly even if no state file is available
>   sandbox: Only read the state if we have a state file
>   sandbox: Move the bloblist down a little in memory
>   bloblist: Support initing from multiple places
>   fdt: Allow the devicetree to come from a bloblist
>   command: Include a required header in command.h
>   pci: serial: Support reading PCI-register size with base

Specific feedback aside, generally this seems fine.

--=20
Tom

--WzNnRCDHc+QWh0BO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUR7zAACgkQFHw5/5Y0
tyzMOAv/emPAuAUkX50v7NKVpMmOZiPum4YNqYa3B5PDsjre/C1vP/3/PD72QgwS
Lpfe8tl887kjv45YZm6J/8W5TaxW0Wj2bd8xFu7RueVZ+ez80qtdAv4L9zbrTgOP
nnUMR3pKIraOvsgeX3nV1OzdGwIqOQvHAJduvecJLpmrKAAIuQnc9aBDML1FH+2n
w3Fin7EtmjLbVZR0KwnVsuk2WuB4sGWV6Ltl9HrqC0UhWo9rNIqOspHAfrR6wAgw
vUVqYge/aMyXXwZo6z/dglb3OdTsLn2/y/z9GytWPp2qJzC42OeCg6UK8o+cMPhM
aKKL6288yJd7dvD4D+tL29yw24T5rBL1ru714SGglMYhlHMn6QRUeokuLhJp+roh
kdd2BNu/iWE43EalrPYBdnFCKvzrmxK7iVo3RDG6XsxG+bED2E+XarDn8iDXlOuN
T1lFj9yg+EZOb4riX6S6RKnnQZ+3xaLbGlyMfJiXEGGVhhGSOtSJOpCThjjlQtAy
Uk7G2rjz
=w2R6
-----END PGP SIGNATURE-----

--WzNnRCDHc+QWh0BO--
