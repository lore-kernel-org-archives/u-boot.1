Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046A5C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 19:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 272FE8872A;
	Tue, 30 Apr 2024 21:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A33ZJA7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F48488735; Tue, 30 Apr 2024 21:28:46 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5986D882D9
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 21:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-43ae2a44963so9737811cf.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714505323; x=1715110123; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yaOguqohdJXXmEajnuzf0y/SMc3CLcFwSBNmJs+vdN0=;
 b=A33ZJA7PqeI+C/CWft22xibso5VW9DnRdkpF2PDa7cMxFXiq484STHTdlUWWQtIdl9
 RhvVQwqbpUap1jRemUJP1n5dGNtoyGKQGxdAXutrUtvoBcpbC29UzC8dw6gCLLex+Wzr
 NegQD00zV6CwshmaeBRxeEB1jYQ3SjN6RKqjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714505323; x=1715110123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaOguqohdJXXmEajnuzf0y/SMc3CLcFwSBNmJs+vdN0=;
 b=feV0YERCNo/br217Bjs29FqD5OVTjfSdlnqW9f7k/5ZTaNT+ChRp7VvbPD4FeUbYyL
 1DqN3P/P9sMnvF6MJtvzP/qaqldVHiDK1RwFSKOhWyWFAQmn38S6zBOgLADjpRdgv3Yn
 8jQtuxSIp8y+aCNnULrbop+kLJBW8qQ0lvx1Wjy1D0AV7NF+CxHfvgmJyg52NAE15kZ1
 1jhB2/kRcdo3MNSTItdj0k4+b+XJVBVuBP0q1wAuiAsYdrFm29JNLuhMP0+KMih1aZCM
 dFm/LFahu6AbTD24y92pZDJItBqFrY0FmYWKb4eRUygUIO2qdI+YnUpVusUTwC4np3Ad
 nXqQ==
X-Gm-Message-State: AOJu0YwGCFtCEM2gLRqySSo2SH2rw4e3O/e0DJyeamRs4wAx/37Ki4z/
 Y7yMzmu3ErwVvoslOm/Drnyi8b9AqPCRue7eo7DCnr4XyRKSgKAVFPod+9i9a5o=
X-Google-Smtp-Source: AGHT+IFM/lfz1KyM/xCxIyxdb5rbZPo+B+rAnuNqBVsSUqKjiGC+gX5RtV+9ZycO8RZo0bpWI8+fHQ==
X-Received: by 2002:a05:622a:4b05:b0:43a:f64e:a71f with SMTP id
 et5-20020a05622a4b0500b0043af64ea71fmr300485qtb.24.1714505322865; 
 Tue, 30 Apr 2024 12:28:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 fu48-20020a05622a5db000b0043781985244sm11662459qtb.59.2024.04.30.12.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 12:28:42 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:28:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v3] test/py: net_boot: Add test cases for net boot
Message-ID: <20240430192839.GQ1054907@bill-the-cat>
References: <1e297cfe3063e6ac6103e0b15fbc61442fc4dea8.1714467244.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="94fJWvpdzNRAYWV/"
Content-Disposition: inline
In-Reply-To: <1e297cfe3063e6ac6103e0b15fbc61442fc4dea8.1714467244.git.love.kumar@amd.com>
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


--94fJWvpdzNRAYWV/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 02:24:55PM +0530, Love Kumar wrote:

> Add tests for booting image using tftpboot/pxe boot commands, tftpboot
> boot case loads the FIT image into DDR and boots using bootm command
> whereas pxe boot cases downloads the pxe configuration file from the
> TFTP server and interprets it to boot the images mentioned in the pxe
> configurations file.
> This test relies on boardenv_* containing configuration values including
> the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux till the
> boot log pattern value is matched. For example, if the parameter
> 'pattern' is defined as 'login:', it will boot till login prompt.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
[snip]
> +def setup_tftpboot_boot(u_boot_console):
> +    f =3D u_boot_console.config.env.get('env__net_tftp_bootable_file', N=
one)
> +    if not f:
> +        pytest.skip('No TFTP bootable file to read')
> +
> +    test_net.test_net_dhcp(u_boot_console)
> +    if not test_net.net_set_up:
> +        test_net.test_net_setup_static(u_boot_console)
> +
> +    addr =3D f.get('addr', None)
> +    if not addr:
> +        addr =3D u_boot_utils.find_ram_base(u_boot_console)
> +
> +    fn =3D f['fn']
> +    output =3D u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
> +    expected_text =3D 'Bytes transferred =3D '
> +    sz =3D f.get('size', None)
> +    if sz:
> +        expected_text +=3D '%d' % sz
> +    assert expected_text in output
> +
> +    expected_crc =3D f.get('crc32', None)
> +    output =3D u_boot_console.run_command('crc32 %x $filesize' % addr)
> +    if expected_crc:
> +        assert expected_crc in output
> +
> +    pattern =3D f.get('pattern')
> +    config =3D f.get('config', None)
> +    timeout =3D f.get('timeout', 50000)
> +
> +    return addr, pattern, timeout, config

The problem here is that we don't get the configured timeout and then
use it while running "tftpboot" nor "crc32". For me this leads to
failure on hardware as I'm tossing it a 83MiB FIT image and it just
doesn't load in the default timeout period.

--=20
Tom

--94fJWvpdzNRAYWV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYxRmAACgkQFHw5/5Y0
tywTxQwAj3mSNyZGVo5Cajr+mpB+CIpxOlh0BzqtJB6ULJ+Mzpff8fUGGjbnf7Lg
Rcc6m/YUCPSVgb/ASH0Lcd9L6p0vPab/mX4l3x3wDltRaqv7L4wRm5NUKhBoscte
UvuvqADZk+8qCW8L3cZC32XS3QvjAE2nl78Rq5ZMw5DRkrxiz1bSpnAzl51uLev3
u5Wy+/M2VaB6vZZIYVZ1UVoE5Y9+nDS2SUU0NbP40M+WdFWKgvF8aTdA1RBJ8wsr
IDS+bfEoShk2ndaww+HD82LdanKULfoRq23F6LTSY3LbajbaO2PXJX+PnnRsZgrc
+xAOUO0pRXxIXrjYIk0F8Mabh6N36m6pkGA5qrl2dHBLCw9tKfLlXsZye9GiZmDP
bDGtBjmtDR08T1uPz7g9UXfDd/IE4Z1AlxbxBaGeliwDPIGh1IEoT01E+NRKPOAm
B/oBrBc1JPwxM/6D/XcyiDf4wfc/blzym5BKKgeIG98l5NvKtZ2Xyx2FEpkyHjfp
t08aQsG0
=1IrP
-----END PGP SIGNATURE-----

--94fJWvpdzNRAYWV/--
