Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CC5C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 15:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55C08798F;
	Fri, 12 Jan 2024 16:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mHUfVdkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F83887980; Fri, 12 Jan 2024 16:46:12 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76E4287980
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 16:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5fa4b03f3f5so37095847b3.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705074368; x=1705679168; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HENH9bZd9NdWqoZtLWQCEAgX7hOMWDKfPBjqRwUe79U=;
 b=mHUfVdkMoPcFcBRa5V3WVwvPsGe4o+0QXyH6xS0Y8t+hKPDWCmZDSOZ67xkCeW280d
 6TUM/NiZiH7wkiOQUp+Ef8zjwdQJS3tb6BmVFLNMzrTgqBNF/7o4hCdhmEwXwFurplvI
 T/4+NUSJdSmi9WVuaHgef/MAP/bKANN26vQfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705074368; x=1705679168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HENH9bZd9NdWqoZtLWQCEAgX7hOMWDKfPBjqRwUe79U=;
 b=l9HVt9skBvJNHJQTTLHWkT6M8ngubNY8PA8jfmLxRvfheqIq1mIDmeMXM83itNLcur
 BvMoantaw81IgJHUgbiC9KQvLieIoVDkTneQ1wHuXmgZrGEPafzKNLh71UhxZtPj1ZhQ
 Zmk8ruGf2nD+e19nSebrZJ3938v1APs/RLRxPJeQG0lziAOTeNvM5jUlS0LYAoUtLcq1
 gfT87xCGdKiOAmyhzN1PIv+uVTt1vhk1dHln6HVuX3f5tD3MEEsfBZ0tgj2uHrxEdRDH
 lBt+FnQGhpb5IJqchpAAuq3K5PA4oQ9Fd8iHC3AYGNERFy7I0vcfPwP72+d+ZqEznuNJ
 +cHQ==
X-Gm-Message-State: AOJu0YxvNEsnieCsvqXg0pQWAg9u8O74NLPAtJMipU1JMQBRISaZoC8C
 YvWMDyWN1n3GiuPXgMgTel2MatesZ6mEh6tnNY/O2nAasEQ=
X-Google-Smtp-Source: AGHT+IF7ECPwFgysQ7wVINCwEyaMd/dy0tVglszRpvMNS4wJVzUAcpk/bf3gD/xKjns1DP/sJh2e0g==
X-Received: by 2002:a81:ae48:0:b0:5f7:fb4:bfa9 with SMTP id
 g8-20020a81ae48000000b005f70fb4bfa9mr1608238ywk.33.1705074368166; 
 Fri, 12 Jan 2024 07:46:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 g139-20020a0ddd91000000b005d6f34893dfsm1422143ywe.135.2024.01.12.07.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 07:46:07 -0800 (PST)
Date: Fri, 12 Jan 2024 10:46:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v2] test/py: net_boot: Add test cases for net boot
Message-ID: <20240112154605.GB1610741@bill-the-cat>
References: <a09405bbd1f2ffecdcbc3f485bb115272bb27265.1705053623.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JOXUe6kdAQFLB1KR"
Content-Disposition: inline
In-Reply-To: <a09405bbd1f2ffecdcbc3f485bb115272bb27265.1705053623.git.love.kumar@amd.com>
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


--JOXUe6kdAQFLB1KR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 03:31:25PM +0530, Love Kumar wrote:

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
> +    test_net.test_net_setup_static(u_boot_console)

This means we skip the tests unless both DHCP and static networking are
configured and it's valid to only configure DHCP (or static), so I would
suggest re-running static only if dhcp fails.

[snip]
> +@pytest.mark.buildconfigspec('cmd_net')
> +def test_net_tftpboot_boot(u_boot_console):
> +    """Boot the loaded image
> +
> +    A boot file (fit image) is downloaded from the TFTP server and boote=
d using
> +    bootm command with the default fit configuration, its boot log patte=
rn are
> +    validated.
> +
> +    The details of the file to download are provided by the boardenv_* f=
ile;
> +    see the comment at the beginning of this file.
> +    """

I guess we need a way to skip just this test? My valid FIT image doesn't
have a default config.

[snip]
> +    addr, pattern, timeout, imcfg =3D setup_tftpboot_boot(u_boot_console)
> +    response =3D u_boot_console.run_command('imi %x' % addr)
> +    if not imcfg or not imcfg in response:
> +        pytest.skip('The custom configuration not found')
> +
> +    with u_boot_console.temporary_timeout(timeout):
> +        try:
> +            u_boot_console.run_command(
> +                'bootm %x#%s' % (addr, imcfg), wait_for_prompt=3DFalse
> +            )
> +            u_boot_console.wait_for(pattern)
> +        finally:
> +            u_boot_console.drain_console()
> +            u_boot_console.cleanup_spawn()

Lets skip running imi to confirm the FIT image has the config, bootm
addr#invalid-config will fail itself (and my test FIT is so big we
timeout).

But I am happy the direction this is going in, with some local hacks for
the above I was able to do the tftpboot + bootm test on hardware. I'll
follow
https://wiki.debian.org/PXEBootInstall#Provide_the_boot_image to get a
PXE setup as well for next time.

--=20
Tom

--JOXUe6kdAQFLB1KR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhXroACgkQFHw5/5Y0
tyxF9wwAtmwhhBAdBaBKe2ZN2S6haCu2GFZcHtYw5JE1lM/mpyjTnfjQg/s5D9o1
wfEXkj6F5AFnKM1v7ykjLN8QHuHnHvH4R0E9y/YZg9JxGIHhp3XV5J3QEk23Ikvn
qHnscEcI1I8JI8xqh8krhFzucVY07WruH4riBVI4b7ImtJwxdEgoqpgP6KyorYsg
5GFNUE9sZXOfmZgANdfePNcXqMuGupchPtpMBUS401ZAUA9/q/LM5jOEDAlBp+rc
Aug0vErCzQuibnqEE7c/KtfdqPvNjtbXdKWQKvWRh0wuCYw7sZyEHERy8kLQkWuI
ltaFym5YU8x0REFP0r6yS0BpMF7XOinfo96uI6GT4MRfPAAtytzR47zRuUAequeY
j/4m/eVy3Bx5RJZJznEafvNOJPUpgpF0fWwxhXfalxdwLFhXsNygtqlRBSRI7nWb
DhdN+GNodSw1aarGIAeOAoTW8rhn439HAn9HQypcGNRspucV5eu/CrgPmNSH4ltC
3oiBexbU
=/NGz
-----END PGP SIGNATURE-----

--JOXUe6kdAQFLB1KR--
