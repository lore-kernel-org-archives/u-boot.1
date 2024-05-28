Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D26C27C44
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 21:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5EC883F4;
	Tue, 28 May 2024 23:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YbIY28g8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D240884F1; Tue, 28 May 2024 23:30:35 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E282883A0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 23:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5b96a78639aso753312eaf.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716931832; x=1717536632; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=waJjbDLygqkSEDGg9raxbmIepkQl1GmKTj6JTR89rHg=;
 b=YbIY28g8cVSFsLMV/J+5xmyZZznRjHjOxwrgbbYyewEfQVeGqeSN/hZUc7RQZZK0mA
 mdtxflFLsQz+Bsvv8P8i1+ICeIE9SCKLKhxQYh4wP66jkQ4esQBeIUJOnEJdUWt66dz5
 Dvwug7h1vrbwymUCpYW0zQH8qqN9noJYN7P3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716931832; x=1717536632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=waJjbDLygqkSEDGg9raxbmIepkQl1GmKTj6JTR89rHg=;
 b=LiHjeZEJthGhMIfKvkPudDxvo52gWMNSbc5zwtNcYI8RmXOdvhv4FIC7oF8phyYLfm
 xRg2p6wdZRc+hE/dyXu0f4zZE8mdh32ovrS9jMsnDs5DGkGMet/PK9ZGnRZuhxh7Pq3v
 ZidZEbRCbH8nWbh77wDhMYHVOYiBD0zNW442Ug/tu6NSVukgdKgoEwk0SJxsfftM0Niw
 LZMUwD1tqtRg48Y+uRd11u4omMHd/ALb4HyCXD/dY+Eh3mlgKMPr9TtyriyR+okRfCLN
 IXmQdwQlAwOmIyBg0CB6zE7IxWqIaNyWaw6LoQjT+tV8Is8e8tQ8rzKucBq1+ViLuF9I
 I1Fw==
X-Gm-Message-State: AOJu0Yw7NKNp4UJJxKhBNZja4btHiWdilHEunzc0wQG1q+7Cwb6Doaln
 bWN6vVPOqOJwdoKFuBuhuTBVB0agjd0y1nlrXV1E8eQn7x1JkHM8mGqfyzRAYZw=
X-Google-Smtp-Source: AGHT+IF6X3v/T4VO0YMInpwfSZPICju+xzCxPW8+1Zn/tef4GyqGBuW0poqULDxWpQqzm0C1R+LcAQ==
X-Received: by 2002:a05:6820:551:b0:5b2:3782:7848 with SMTP id
 006d021491bc7-5b961c730e4mr15342984eaf.6.1716931831474; 
 Tue, 28 May 2024 14:30:31 -0700 (PDT)
Received: from oliver.lan ([2806:370:558f:4a42:867a:7a66:2d67:2a53])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b96c461f1dsm2328216eaf.7.2024.05.28.14.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 14:30:30 -0700 (PDT)
Date: Tue, 28 May 2024 15:30:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v5] test/py: net_boot: Add test cases for net boot
Message-ID: <20240528213024.GA546015@oliver.lan>
References: <eedb4599e11ffed72cd0866fa02d4b144e3192ad.1716886448.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1Kk34XnBfh5gcKIx"
Content-Disposition: inline
In-Reply-To: <eedb4599e11ffed72cd0866fa02d4b144e3192ad.1716886448.git.love.kumar@amd.com>
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


--1Kk34XnBfh5gcKIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 02:33:17PM +0530, Love Kumar wrote:

> Add tests for booting image using tftpboot/pxe boot commands, tftpboot
> boot case loads the FIT image into DDR and boots using bootm command
> whereas pxe boot cases downloads the pxe configuration file from the
> TFTP server and interprets it to boot the images mentioned in the pxe
> configurations file.
> This test relies on boardenv_* containing configuration values including
> the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux till the
> boot log pattern value is matched. For example, if the parameter
> 'pattern' is defined as 'login:', it will boot till login prompt.

Good news is that the kernel test is working for me now. Bad news is the
PXE test fails, but good news is I figure out the problem.

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

This works for me, and matches how other tests are written. However:

[snip]
> +def setup_pxe_boot(u_boot_console):
> +    f =3D u_boot_console.config.env.get('env__net_pxe_bootable_file', No=
ne)
> +    if not f:
> +        pytest.skip('No PXE bootable file to read')
> +
> +    test_net.test_net_dhcp(u_boot_console)
> +    test_net.test_net_setup_static(u_boot_console)
> +    return f

This doesn't check for if dhcp worked and skips the test when DHCP works
but there's no static config, which is how my lab is. For v6 we should
have a setup_networking function that both the TFTP and PXE tests call
in to that does what I suggested above. And what I suggested above
would be a good clean-up to the xilinx-specific tests.

That said, with a local fixup so that my network is configured, and
having pxelinux.cfg/01-b8-27-eb-fc-64-a6 (the first file pxe boot looks
for on my test Pi), pxeboot.cfg/default and pxeboot.cfg/default-arm all
configured from the examples given in the test itself, I get:
------------------------------------ Captured stdout call -----------------=
--------------------
U-Boot> setenv autoload no
U-Boot> U-Boot> dhcp
Waiting for Ethernet connection... done.
BOOTP broadcast 1
BOOTP broadcast 2
DHCP client bound to address 192.168.1.100 (255 ms)
U-Boot> U-Boot> pxe get
missing environment variable: pxeuuid
Retrieving file: pxelinux.cfg/01-b8-27-eb-fc-64-a6
Waiting for Ethernet connection... done.
Using smsc95xx_eth device
TFTP from server 192.168.1.10; our IP address is 192.168.1.100
Filename 'pxelinux.cfg/01-b8-27-eb-fc-64-a6'.
Load address: 0x2500000
Loading: ##################################################  64 Bytes
         0 Bytes/s
done
Bytes transferred =3D 64 (40 hex)
Config file '<NULL>' found
U-Boot>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

--=20
Tom

--1Kk34XnBfh5gcKIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZWTO0ACgkQFHw5/5Y0
tywm5wv/RvZh/87ps5hlXPNnxlRXSYWcuZxR5qyRuDNDlWSj3JPZFAWo+p0mtbcJ
X75I8nn9R8tN3Kz74dtmtneMR3SJp6r08r9i2KzSdQqXNbtmcPTSd3U/gwg3Pk37
spxJwXt79bHDfvJsnqqLahytXt4RAKXROkcPSROeSSE3oHlh+2D8cScxoCLDDOeN
Jg2zw8awknw74rQXMNU5C+RdUZ+tCNBEF6cCIYk7YSKO8QfmqGB8OvKUyHxkr093
FcySDFYKWQnHd1P8WuHm4Nde+RdPItc/9tpXF1xEsnlKYIriXomxDjTSIyJd7Ull
mwBw9KkBSgpURN+XskioLn9mRZA8bRHEc7WJdHpZxV9n6OLtHr+T8mEyaLlBOO2J
UdCTCVzB6tPsQtaEfRyaMMqQaTESPbl3z7mKjpBxZiiejfPwB6cYSigoEGlFCAnd
0V6xaa3xIl3baD2qjFgOrQfv+AlvqOpjImXgMod5xBeJywgClgPTOu2HFD/GSvOC
tCOodWXS
=6F34
-----END PGP SIGNATURE-----

--1Kk34XnBfh5gcKIx--
