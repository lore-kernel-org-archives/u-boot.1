Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64F5C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 22:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC7088CE8;
	Tue, 20 Aug 2024 00:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c5XNSlLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4761A88D39; Tue, 20 Aug 2024 00:19:36 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A34FE88CE8
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 00:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3db23a6085aso2416062b6e.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 15:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724105972; x=1724710772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ioFzBbIrCFtaZxtxUnnl0ibfi+1/KtN3TY57d0XiRmo=;
 b=c5XNSlLhNPmJ4CWgCbtS7bKZOj55fPUTEViQkcGSwV6Fis/Gfj3vST0nLKR4zjzDSV
 bzewfR5Kr+N8wmhGV7bDC+il7zFmjjk/72QdyXdDaxkHDmhE9jNzSt6eVH6e8XjaikKm
 unWNgk+9BDCjAkX5ft/1R/UZUMPNrE9zw/e1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724105972; x=1724710772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioFzBbIrCFtaZxtxUnnl0ibfi+1/KtN3TY57d0XiRmo=;
 b=JK74yXObu2GUox09GdlEPxcTmYNR1T3RXcLNCThvhDw1j66jwsCI1AWa49iRRYuy9f
 j4wCbt7FMUYjeK+SDJCo2EmnA0FdMlH3M0oM40SqZvEhHlFpth1/X8k9ZAjXuHRaxhtM
 S1gTapkVLf42i4ddOdkK2A0yAID5V/DR57R3TaSpwLS56ra9x6bRFepiGJ/d+xoCl8fJ
 KwhM26dFzCNP755YGJ7bLq3MYf66gp91t4zfs5NUL2D1i3tEtQ4pnUG697KlZmiIeUFZ
 ghom6LMWiUT2vLzQZ896h1gGGfG6+5RwFC6FlWe//4ZYaXndukdr/NcffqTKeYHHIvCb
 4/Mw==
X-Gm-Message-State: AOJu0Yy/+116P7tMogGEQ8m//a23zHGB8Zc8FCAZx3P4paRo8xWDQSYV
 tZl/Uv3ZEQc3EyQRu6V/5JFEBLrYgA/2JZbe2sFeKq6xhKnX3av55Z9Seb9LRtU=
X-Google-Smtp-Source: AGHT+IEigzB2sxjByp4zh9Nh2t35KtGwmvJT1MTivbj6L0AfYky1jmldGercTcGTmIqkwcg6f6/yhg==
X-Received: by 2002:a05:6808:3386:b0:3d9:3427:56b9 with SMTP id
 5614622812f47-3ddb4d0bb95mr480598b6e.4.1724105972321; 
 Mon, 19 Aug 2024 15:19:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3de10258d42sm72309b6e.30.2024.08.19.15.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 15:19:31 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:19:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Stefan Roese <sr@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 10/10] tests: update smbios pytest
Message-ID: <20240819221928.GJ1626301@bill-the-cat>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-11-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zbdrgCIF5y+Urw2a"
Content-Disposition: inline
In-Reply-To: <20240816154658.1866186-11-raymond.mao@linaro.org>
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


--zbdrgCIF5y+Urw2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 08:46:53AM -0700, Raymond Mao wrote:
> Update the expected test result to align with the smbios library changes.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  test/py/tests/test_smbios.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
> index 82b0b689830..ffa4ea795ec 100644
> --- a/test/py/tests/test_smbios.py
> +++ b/test/py/tests/test_smbios.py
> @@ -32,7 +32,7 @@ def test_cmd_smbios_sandbox(u_boot_console):
>      """Run the smbios command on the sandbox"""
>      output =3D u_boot_console.run_command('smbios')
>      assert 'DMI type 0,' in output
> -    assert 'String 1: U-Boot' in output
> +    assert 'Vendor: U-Boot' in output
>      assert 'DMI type 1,' in output
>      assert 'Manufacturer: sandbox' in output
>      assert 'DMI type 2,' in output

This needs to be done with the change, not by itself.

--=20
Tom

--zbdrgCIF5y+Urw2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbDxOgACgkQFHw5/5Y0
tyy+vAwAn3wstFBwxaLzPKxElA85bN4XhoCmxtuPbklP6LJ92FOB08wRpQMe14dx
kN7ZqnlYF+4T9SSz8md0JwyIU/zNzcULyI+IrpTIyxORsPDCe3qCpjcpkJZDAaAY
T/w1YJzhdzdFds2jqqSO9RKPkJ+UGCFCEduFwno17lz1Orwd4PCoHYKnIFHMDlE6
dY/egHVwEd40lc8o+coeD/EC1rPpEafodqKtLG+Njgygxo+zn7N7BDAU0bw/BoY5
z3K2ehnhuGOEJJtteSawqgx5dCK/+giwJBOEwMaSqn5gzH47+BiX9YWxpLqAuE4p
GWSLRJPb/OYyDQIsO/3jbLSSIzx2g/A5M71MEECk7EvNiyps4VP8cHZJPYhNCdEG
Kog4iepWe5bePz3Jr/6d6hLLGeG8iF1jJDT3ppooYKPEeXwUxUrJ+iir0oF5smmk
/+ILT4U803p05sjyvT+N4o5cs4U5QRH/mwFMCjkfVV+AXhUpTKrVCdOnWToEcGIm
bTgqmoZa
=GqQv
-----END PGP SIGNATURE-----

--zbdrgCIF5y+Urw2a--
